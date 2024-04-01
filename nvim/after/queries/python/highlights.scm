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
