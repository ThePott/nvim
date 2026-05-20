((call_expression
  function: (field_expression
    object: (identifier) @db_obj
    member: (identifier) @method)
  arguments: (arguments
    (string
      (string_content) @injection.content)))
 (#match? @method "^(execute)$")
 (#set! injection.language "sql"))
