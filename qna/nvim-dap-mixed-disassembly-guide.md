# Mixed-Mode Disassembly for nvim-dap (VS Code style)

## Problem

Current disassembly view shows raw assembly dump without source context. You want VS-style mixed mode where source lines
are interleaved with their corresponding assembly instructions.

## Files Involved

| File                                                                        | Purpose                         |
| --------------------------------------------------------------------------- | ------------------------------- |
| `~/.local/share/nvim/site/pack/core/opt/nvim-dap-disasm/lua/dap-disasm.lua` | Plugin that renders disassembly |
| `~/.config/nvim/lua/almond/plugins/test/nvim-dap.lua`                       | Your DAP config                 |

---

## 1. What Current Code Does

### `dap-disasm.lua` — `write_buf` function (lines ~136-168)

This is the renderer. It builds a flat list of text lines from the DAP `disassemble` response and writes them to the
buffer.

```lua
write_buf = function(pc)
  if not instructions or #instructions == 0 then return end

  local pc_line = nil

  -- Calculate format widths for each column
  local fmts = {}
  for _,c in ipairs(M.config.columns) do
    fmts[c] = string.format("%%-%ds", vim.fn.reduce(instructions,
      function(w, ins) return math.max(w, #(ins[c] or "")) end, 0))
  end

  local lines = {}
  for i,ins in ipairs(instructions) do
    if ins.address == pc then pc_line = i end

    local line = " "
    if fmts.address then
      line = line .. string.format(fmts.address .. ":\t", ins.address)
    end
    if fmts.instructionBytes then
      line = line .. string.format(fmts.instructionBytes .. "\t", ins.instructionBytes or "??")
    end
    if fmts.instruction then
      line = line .. (ins.instruction or "??")
    end
    line = line:gsub("%s+$", "")
    table.insert(lines, line)
  end

  -- Write lines to buffer
  local buf = disasm_buf.bufnr()
  local ma_old = vim.bo[buf].modifiable
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = ma_old
  -- ... sign placement, cursor ...
end
```

**Key observations:**

- Columns are configured in `M.config.columns` (default: `{"address", "instructionBytes", "instruction"}`)
- Each instruction from DAP produces exactly **one** line in the buffer
- The code only reads `ins.address`, `ins.instructionBytes`, `ins.instruction`
- **The DAP `disassemble` response also includes `ins.location`** (with `path`, `line`, `endLine`, `column`,
  `endColumn`) — this is **completely ignored** by the current code.

### DAP Protocol — Instruction object structure

From the DAP spec, each instruction in the `disassemble` response has:

| Field              | Type           | Description                                           |
| ------------------ | -------------- | ----------------------------------------------------- |
| `address`          | string         | Memory address (required)                             |
| `instruction`      | string         | Assembly text (required)                              |
| `instructionBytes` | string         | Raw hex bytes (optional)                              |
| `location`         | SourceLocation | `{path, line, endLine, column, endColumn}` (optional) |
| `symbol`           | string         | Symbol name (optional)                                |

LLDB/codelldb **does** populate `location` when source info is available.

### `nvim-dap.lua` — config

```lua
require("dap-disasm").setup({})  -- line 51: no options set
```

No `columns` or `mixed` option is configured, so defaults apply (flat assembly only).

---

## 2. Fix: Add Mixed Mode to `dap-disasm.lua`

### 2a. Add `mixed` config option (in `M.config` table, ~line 293)

```diff
  M.config = {
    dapui_register = true,
    dapview_register = true,
+   mixed = false,                     -- new option: toggle mixed mode
    winbar = { ... },
    sign = "DapStopped",
    ins_before_memref = nil,
    ins_after_memref = nil,
    columns = {
      "address",
      "instructionBytes",
      "instruction",
    },
    dapview = { ... },
  }
```

### 2b. Modify `write_buf` for mixed interleaving

Replace the loop in `write_buf` (~lines 148-167) with:

```lua
  local lines = {}
  local prev_source = nil
  local prev_path = nil

  for i,ins in ipairs(instructions) do
    if ins.address == pc then pc_line = #lines + 1 end

    -- Mixed mode: insert source header when source line changes
    if M.config.mixed and ins.location then
      local src_path = ins.location.path or prev_path
      local src_line = ins.location.line
      if src_line ~= prev_source or src_path ~= prev_path then
        -- Read source line from file
        local source_text = ""
        if src_path and src_line then
          local ok, lines_from_file = pcall(vim.fn.readfile, src_path)
          if ok and lines_from_file and lines_from_file[src_line] then
            source_text = lines_from_file[src_line]:gsub("^%s+", "")
          end
        end
        -- Insert header: "-- path:line    source_code"
        local display_path = src_path and vim.fn.fnamemodify(src_path, ":t") or "??"
        local header = "-- " .. (display_path or "??") .. ":" .. (src_line or "??")
        if source_text ~= "" then
          header = header .. "    " .. source_text
        end
        table.insert(lines, header)
        if ins.address == pc then pc_line = #lines end
        prev_source = src_line
        prev_path = src_path
      end
    end

    -- Build instruction line (same as before)
    local line = " "
    if fmts.address then
      line = line .. string.format(fmts.address .. ":\t", ins.address)
    end
    if fmts.instructionBytes then
      line = line .. string.format(fmts.instructionBytes .. "\t", ins.instructionBytes or "??")
    end
    if fmts.instruction then
      line = line .. (ins.instruction or "??")
    end
    line = line:gsub("%s+$", "")
    table.insert(lines, line)
  end
```

### 2c. Enable mixed mode in your config

In `lua/almond/plugins/test/nvim-dap.lua`, line 51:

```diff
  require("dap-disasm").setup({})
```

→

```lua
  require("dap-disasm").setup({
    mixed = true,
  })
```

---

## 3. What the Fix Does

### Before (flat disassembly)

```
0x1000:  89 e5        mov ebp, esp
0x1002:  83 e4 f0     and esp, -16
0x1005:  e8 0a 00    call __main
0x1008:  c7 04 24    mov dword ptr [esp], 5
0x100f:  e8 00 00    call func
0x1014:  89 c3        mov ebx, eax
0x1016:  b8 00 00    mov eax, 0
0x101b:  5b           pop ebx
0x101c:  c9           leave
0x101d:  c3           ret
```

### After (mixed: source + assembly)

```
-- main.c:8    int main() {
0x1000:  89 e5        mov ebp, esp
0x1002:  83 e4 f0     and esp, -16
0x1005:  e8 0a 00    call __main
-- main.c:9    int x = 5;
0x1008:  c7 04 24    mov dword ptr [esp], 5
0x100f:  e8 00 00    call func
-- main.c:10   return x;
0x1014:  89 c3        mov ebx, eax
-- main.c:11   }
0x1016:  b8 00 00    mov eax, 0
0x101b:  5b           pop ebx
0x101c:  c9           leave
0x101d:  c3           ret
```

### How it works step by step

1. DAP `disassemble` request returns `instructions[]`, each with `address`, `instruction`, `instructionBytes`, and
   `location` (from LLDB/codelldb).
2. `write_buf` iterates over instructions. When `mixed = true`, it checks `ins.location.line` against the previous
   instruction's line.
3. When the source line changes, it reads the source file at `ins.location.path` and extracts the line at
   `ins.location.line`.
4. It inserts a header line: `-- filename:line    source_code`.
5. Grouped instructions under the same source header appear together.

### What LLDB/codelldb provides

LLDB's DAP implementation sends `location` per instruction with source mapping. The `resolveSymbols` parameter in the
`disassemble` request is also available for better symbol resolution (already partially supported in the code via
`use_dap_request`).

---

## 4. Limitations & Edge Cases

| Issue                 | Notes                                                                    |
| --------------------- | ------------------------------------------------------------------------ |
| Source file not found | `pcall(vim.fn.readfile)` gracefully fails, header shows line number only |
| No `location` field   | Falls back to flat disassembly for those instructions                    |
| Large disassembly     | `readfile` called per unique source line; could cache in production      |
| File path resolution  | Uses `location.path` as-is from DAP; may need path adjustment            |
| Winbar line tracking  | `pc_line` offset changes because headers shift line numbers              |

---

## 5. Alternative Approaches

| Approach                                      | Pro                                       | Con                              |
| --------------------------------------------- | ----------------------------------------- | -------------------------------- |
| Fork + patch dap-disasm (this guide)          | ~30 lines, preserves dap-view integration | Plugin updates overwrite changes |
| Write standalone nvim-dap-view custom section | No fork needed                            | More work, duplicate logic       |
| Use Vimspector                                | Built-in mixed disassembly                | Different ecosystem, no nvim-dap |
