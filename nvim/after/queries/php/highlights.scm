; extends

(php_tag) @tag
"?>" @tag

((variable_name) @variable.builtin
 (#eq? @variable.builtin "this"))

[
 "$"
] @keyword
