(in-package :imgui)


(defun create-context (&optional im-font-atlas)
  (imgui%:|CreateContext(ImFontAtlas*)| im-font-atlas))

(defun get-io ()
  (imgui%:|GetIO()|))

(defmacro set-fdefinition (new-name old-name)
  `(setf (fdefinition ',new-name) #',old-name))

(set-fdefinition get-tex-data-as-rgba32 imgui%:|GetTexDataAsRGBA32(ImFontAtlas&,UnsignedCharStar&,int&,int&,int&)|)

(set-fdefinition fonts imgui%:|Fonts|)

(set-fdefinition delta-time imgui%:|DeltaTime|)
(set-fdefinition (setf delta-time) (setf imgui%:|DeltaTime|))

(setf (fdefinition 'display-size) #'imgui%:|DisplaySize|)
(setf (fdefinition '(setf display-size))  #'(setf imgui%:|DisplaySize|))

(setf (fdefinition 'im-vec2) #'imgui%:|ImVec2|)

(setf (fdefinition 'new-frame)  #'imgui%:|NewFrame()|)
(setf (fdefinition 'render)  #'imgui%:|Render()|)

(defmacro text (fmt &rest args)
  `(cffi:foreign-funcall
    "imguiPERCENT__Text"
    :string (format nil ,fmt)
    ,@args
    :void))
