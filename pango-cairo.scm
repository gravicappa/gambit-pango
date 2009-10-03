(namespace ("pango-cairo#"))
(##include "~~/lib/gambit#.scm")

(declare
  (standard-bindings)
  (extended-bindings)
  (not safe))

(c-declare #<<end-of-c

#include <pango/pangocairo.h>

end-of-c
)

(include "ffi.scm")
(%extern-object-releaser-set! "g_object_unref" "g_object_unref(p);\n")
(%extern-object-releaser-set! "pango_font_description_free"
                              "pango_font_description_free(p);\n")

(%define/extern-object "PangoLayout" "g_object_unref")
(c-define-type cairo-t* (pointer "cairo_t"))

(define create-layout
  (c-lambda (cairo-t*)
            PangoLayout*/g_object_unref
            "pango_cairo_create_layout"))

(define show-layout!
  (c-lambda (cairo-t* PangoLayout*)
            void
            "pango_cairo_show_layout"))
