

(defpackage :imgui
  (:nicknames :ig)
  (:shadow )
  (:use :common-lisp :imgui%)
  (:export
   #:create-context
   #:get-io
   #:get-tex-data-as-rgba32
   #:fonts
   #:delta-time
   #:display-size
   #:im-vec2
   #:new-frame
   #:text
   #:render
   ))
