(format t "About to load imgui-clasp asd file~%")
(require :asdf)
(let ((asd-file (probe-file "source-dir:extensions;imgui-clasp;src;imgui.asd")))
  (if asd-file
      (asdf:load-asd asd-file)
      (error "Could not find source-dir:extensions;imgui-clasp;src;imgui.asd")))
;;; 
(push (lambda ()
        (asdf:load-system :imgui)
        (format t "Done eval imgui-clasp startup~%"))
      core:*extension-startup-evals*)
