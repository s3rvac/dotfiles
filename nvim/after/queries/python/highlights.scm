; extends

; Recognize class names in definitions as type definitions.
(class_definition name: (identifier) @type.definition)

; Recognize decorators of the form `@object.attribute` (e.g.
; `@dataclass.dataclass`). Without this, `object` is not highlighted.
(decorator
  (attribute
    object: (identifier) @attribute))

; Recognize decorators of the form `@object.attribute()` (e.g.
; `@dataclass.dataclass(frozen=True)`). Without this, `object` is not
; highlighted.
(decorator
  (call
    (attribute
      object: (identifier) @attribute)))

; Recognize __init__/__new__ as methods. Without this, they are recognized as
; @constructor (similarly to class instantiations), which makes them
; non-nighlighted in my theme.
(function_definition name: (identifier) @function.method (#eq? @function.method "__init__"))
(function_definition name: (identifier) @function.method (#eq? @function.method "__new__"))
