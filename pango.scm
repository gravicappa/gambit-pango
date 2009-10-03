(namespace ("pango#"))
(##include "~~/lib/gambit#.scm")

(declare
  (standard-bindings)
  (extended-bindings)
  (not safe))

(c-declare #<<end-of-c

#include <pango/pango.h>

end-of-c
)

(include "ffi.scm")
(%extern-object-releaser-set! "g_object_unref" "g_object_unref(p);\n")
(%extern-object-releaser-set! "pango_font_description_free"
                              "pango_font_description_free(p);\n")

(%define/extern-object "PangoFontDescription" "pango_font_description_free")
(%define/extern-object "PangoLayout" "g_object_unref")
(c-define-type PangoWeight unsigned-int32)

(define font-description-new
  (c-lambda ()
            PangoFontDescription*/pango_font_description_free
            "pango_font_description_new"))

(define font-description-from-string
  (c-lambda (char-string)
            PangoFontDescription*/pango_font_description_free
            "pango_font_description_from_string"))

(define set-font-description-family!
  (c-lambda (PangoFontDescription* char-string)
            void
            "pango_font_description_set_family"))

;; old pango in debian does not have all those constants defined

(define +pango-weight-thin+ 100)
;(define +pango-weight-thin+
;  ((c-lambda () PangoWeight "___result = PANGO_WEIGHT_THIN;")))

;(define +pango-weight-ultralight+ 200)
(define +pango-weight-ultralight+
  ((c-lambda () PangoWeight "___result = PANGO_WEIGHT_ULTRALIGHT;")))

;(define +pango-weight-light+ 300)
(define +pango-weight-light+
  ((c-lambda () PangoWeight "___result = PANGO_WEIGHT_LIGHT;")))

(define +pango-weight-book+ 380)
;(define +pango-weight-book+
;  ((c-lambda () PangoWeight "___result = PANGO_WEIGHT_BOOK;")))

(define +pango-weight-normal+ 400)
;(define +pango-weight-normal+
;  ((c-lambda () PangoWeight "___result = PANGO_WEIGHT_NORMAL;")))

(define +pango-weight-medium+ 500)
;(define +pango-weight-medium+
;  ((c-lambda () PangoWeight "___result = PANGO_WEIGHT_MEDIUM;")))

;(define +pango-weight-semibold+ 600)
(define +pango-weight-semibold+
  ((c-lambda () PangoWeight "___result = PANGO_WEIGHT_SEMIBOLD;")))

;(define +pango-weight-bold+ 700)
(define +pango-weight-bold+
  ((c-lambda () PangoWeight "___result = PANGO_WEIGHT_BOLD;")))

;(define +pango-weight-ultrabold+ 800)
(define +pango-weight-ultrabold+
  ((c-lambda () PangoWeight "___result = PANGO_WEIGHT_ULTRABOLD;")))

;(define +pango-weight-heavy+ 900)
(define +pango-weight-heavy+
  ((c-lambda () PangoWeight "___result = PANGO_WEIGHT_HEAVY;")))

(define +pango-weight-ultraheavy+ 1000)
;(define +pango-weight-ultraheavy+
;  ((c-lambda () PangoWeight "___result = PANGO_WEIGHT_ULTRAHEAVY;")))

(define set-font-description-weight!
  (c-lambda (PangoFontDescription* PangoWeight)
            void
            "pango_font_description_set_weight"))

(define set-font-description-absolute-size!
  (c-lambda (PangoFontDescription* double)
            void
            "pango_font_description_set_absolute_size
              (___arg1, PANGO_SCALE * ___arg2);"))

(define set-font-description-size!
  (c-lambda (PangoFontDescription* double)
            void
            "pango_font_description_set_size
              (___arg1, (int) (PANGO_SCALE * ___arg2));"))

(define set-layout-font-description!
  (c-lambda (PangoLayout* PangoFontDescription*)
            void
            "pango_layout_set_font_description"))

(define set-layout-text!
  (c-lambda (PangoLayout* UTF-8-string)
            void
            "pango_layout_set_text(___arg1, ___arg2, -1);"))

(define set-layout-markup!
  (c-lambda (PangoLayout* UTF-8-string)
            void
            "pango_layout_set_markup(___arg1, ___arg2, -1);"))

(define set-layout-width!
  (c-lambda (PangoLayout* int)
            void
            "pango_layout_set_width(___arg1, PANGO_SCALE * ___arg2);"))

(define set-layout-height!
  (c-lambda (PangoLayout* int)
            void
            "pango_layout_set_height(___arg1, PANGO_SCALE * ___arg2);"))

(define layout-pixel-width
  (c-lambda (PangoLayout*)
            int
            "
             int v = 0;
             pango_layout_get_pixel_size(___arg1, &v, 0);
             ___result = v;
            "))

(define layout-pixel-height
  (c-lambda (PangoLayout*)
            int
            "
             int v = 0;
             pango_layout_get_pixel_size(___arg1, 0, &v);
             ___result = v;
            "))

(define layout-indent
  (c-lambda (PangoLayout*)
            int
            "pango_layout_get_indent"))

(define set-layout-indent!
  (c-lambda (PangoLayout* int)
            void
            "pango_layout_set_indent(___arg1, PANGO_SCALE * ___arg2);"))
