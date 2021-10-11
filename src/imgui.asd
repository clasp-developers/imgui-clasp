(in-package :asdf-user)

(defsystem "imgui"
  :description "Expose ImGui framework to clasp"
  :version "0.0.1"
  :author "Christian Schafmeister <chris.schaf@verizon.net>"
  :licence "LGPL-3.0"
  :depends-on ( :cffi )
  :serial t
  :components
  ((:file "packages")
   (:file "imgui")
   ))
