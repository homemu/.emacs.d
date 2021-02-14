;;; bmx-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "bmx-mode" "bmx-mode.el" (0 0 0 0))
;;; Generated autoloads from bmx-mode.el

(autoload 'bmx-mode-setup-defaults "bmx-mode" "\
Configure default-settings for `bmx-mode'." nil nil)

(autoload 'bmx-mode "bmx-mode" "\
Small enhancements for editing batch-files.

If called interactively, enable Bmx mode if ARG is positive, and
disable it if ARG is zero or negative.  If called from Lisp, also
enable the mode if ARG is omitted or nil, and toggle it if ARG is
`toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "bmx-mode" '("bmx-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; bmx-mode-autoloads.el ends here
