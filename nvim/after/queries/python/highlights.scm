; extends

; Recognize class names in definitions as type definitions.
(class_definition name: (identifier) @type.definition)

; Recognize decorators of the form `@x.z.y` (e.g. `@dataclass.dataclass`) and
; make them highlighted
(decorator
  (attribute
    object: (identifier) @attribute))
(decorator
  (attribute
   object: (attribute
     object: (identifier) @attribute
     attribute: (identifier) @attribute)
   attribute: (identifier)))
(decorator
  (attribute
   object: (attribute
     object: (identifier) @attribute
     attribute: (identifier) @attribute)
   attribute: (identifier)))
(decorator
  (attribute
    object: (attribute
      object: (attribute
        object: (identifier) @attribute
        attribute: (identifier) @attribute)
      attribute: (identifier) @attribute)
    attribute: (identifier)))

; Recognize decorators of the form `@x.z.y()` (e.g.
; `@dataclass.dataclass(frozen=True)`) and make them highlighted
(decorator
  (call
    (attribute
      object: (identifier) @attribute)))
(decorator
  (call
    (attribute
     object: (attribute
       object: (identifier) @attribute
       attribute: (identifier) @attribute)
     attribute: (identifier))))
(decorator
  (call
    (attribute
     object: (attribute
       object: (identifier) @attribute
       attribute: (identifier) @attribute)
     attribute: (identifier))))
(decorator
  (call
    (attribute
      object: (attribute
        object: (attribute
          object: (identifier) @attribute
          attribute: (identifier) @attribute)
        attribute: (identifier) @attribute)
      attribute: (identifier))))

; Recognize __init__/__new__ as methods. Without this, they are recognized as
; @constructor (similarly to class instantiations), which makes them
; non-nighlighted in my theme.
(function_definition name: (identifier) @function.method (#eq? @function.method "__init__"))
(function_definition name: (identifier) @function.method (#eq? @function.method "__new__"))
