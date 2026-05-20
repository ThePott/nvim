;; Single-line strings
; ((call_expression
;   function: (field_expression
;     object: (identifier) @db_obj
;     member: (identifier) @method)
;   arguments: (arguments
;     (string
;       (string_content) @injection.content)))
;  (#match? @method "^(execute|query|prepare)$")
;  (#set! injection.language "sql"))

;; Multiline strings (the common case for SQL)
; ((call_expression
;   function: (field_expression
;     object: (identifier) @db_obj
;     member: (identifier) @method)
;   arguments: (arguments
;     (multiline_string_literal) @injection.content))
;  (#match? @method "^(execute|query|prepare)$")
;  (#set! injection.language "sql"))
