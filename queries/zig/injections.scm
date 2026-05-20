;; Single-line strings
;;//;; extends
((call_expression
  function: (field_expression
    object: (identifier) @db_obj
    member: (identifier) @method)
  arguments: (arguments
    (string
      (string_content) @injection.content)))
 (#match? @method "^(execute|query|prepare)$")
 (#set! injection.language "sql")
 )

;; extends
((call_expression
  function: (field_expression
    object: (identifier) @db_obj
    member: (identifier) @method)
  arguments: (arguments
    (multiline_string) @injection.content))
 (#match? @method "^(execute|query|prepare)$")
 (#set! injection.language "sql")
 (#offset! @injection.content 0 2 0 0)
)
