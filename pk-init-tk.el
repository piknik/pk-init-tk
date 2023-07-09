;;; pk-init-tk.el --- Init variables -*- lexical-binding: t; -*-
;;; Commentary:
;; 
;;; Code:
(defmacro pk-init-tk--set-custom (&rest defs)
  "Generate `with-eval-after-load' blocks for custom variables.

DEFS is a list containing the form (FILE . SETS)

FILE is the name of a loadable library file used in
`eval-after-load'. SETS will be loaded according to the behavior
of `eval-after-load'

SETS is a list containing elements (NAME VALUE NAME VALUE ...)

SETS is intended to have the same definition structure as `setf'
or `setq'. NAME should be a symbol defined by `defcustom' in the
FILE library. VALUE is the value to set to NAME when FILE is
loaded. SETS may contain any number of NAME and VALUE pairs."
  (declare (indent 0))
  `(progn
     ,@(mapcar (pcase-lambda (`(,file . ,setf-defs)) ""
		 `(progn
		    (with-eval-after-load ',file
		      ,@(mapcar (pcase-lambda (`(,name ,value)) ""
				  `(customize-set-variable ',name ,value))
				(seq-partition setf-defs 2)))))
	       defs)))

(defalias 'set-custom #'pk-init-tk--set-custom)

(provide 'pk-init-tk)
;;; pk-init-tk.el ends here
