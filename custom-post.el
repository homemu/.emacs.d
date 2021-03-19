;;---better default---

;; stop the backup files (end with ~)
(setq make-backup-files nil)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;; rime config---
(require 'rime)
(setq default-input-method "rime"
      rime-show-candidate 'posframe)

;;; Code:
(setq rime-user-data-dir "~/.local/share/fcitx5/rime")

;;(setq rime-posframe-properties
;;      (list :background-color "#333333"
;;            :foreground-color "#dcdccc"
;;            :font "WenQuanYi Micro Hei Mono-14"
;;            :internal-border-width 10))

(setq rime-disable-predicates
      '(rime-predicate-evil-mode-p
        rime-predicate-after-ascii-char-p
        rime-predicate-after-alphabet-char-p
        rime-predicate-prog-in-code-p))

;;---evil config ---


;; use evil everywhere
(evil-mode 1)
(setq evil-emacs-state-modes nil)
;;(evil-select-search-module 'evil-search-module 'evil-search)
;;(setq evil-insert-state-modes nil)
;;(setq evil-motion-state-modes nil)


;;(setcdr evil-insert-state-map nil)

;;(define-key evil-insert-state-map (kbd <escape>) 'evil-normal-state)

;;--general key define---
(require 'general)
(general-define-key
 :states 'motion
 ";" 'evil-ex
 ":" 'evil-repeat-find-char)
;;(general-define-key
;; :states 'insert
;; "M-." 'pyim-punctuation-translate)
;;(evilem-default-keybindings "SPC")
;; global define key map
(general-define-key "M-m" 'toggle-input-method)

;; my leader-key
(general-create-definer hm-leader-def
  :states '(normal insert visual emacs)
  :prefix ","
  :keymaps 'override
  :non-normal-prefix "M-," )
(hm-leader-def "/" 'swiper)
(hm-leader-def "i" 'rg-project)
(hm-leader-def "r" 'counsel-recentf)
(hm-leader-def "l" 'dired-jump)
(hm-leader-def "," 'save-buffer)
;;(hm-leader-def "m," 'evil-window-prev)
(hm-leader-def "." 'evil-window-map)
(hm-leader-def "n" 'ivy-switch-buffer)
(hm-leader-def "f" 'counsel-projectile-find-file)
(hm-leader-def "b" 'evil-switch-to-windows-last-buffer)
(hm-leader-def "F" 'evilem-motion-backward-word-begin)
(hm-leader-def "j" 'evilem-motion-find-char)
(hm-leader-def "k" 'evilem-motion-find-char-backward)
(hm-leader-def "y" 'youdao-dictionary-search-at-point)

;;---tab ---
(hm-leader-def ".n" 'tab-new)
(hm-leader-def ".," 'tab-previous)
(hm-leader-def ".." 'tab-next)
(hm-leader-def ".c" 'tab-close)


;; ---pyim settings---
;; 需要解决counsel-ag 下的快捷键冲突问题。
;;(setq default-input-method "pyim")
;;(setq pyim-default-scheme 'microsoft-shuangpin)
;;(setq-default pyim-english-input-switch-functions
;;              '(
;;                pyim-probe-dynamic-english
;;                pyim-probe-isearch-mode
;;                pyim-probe-program-mode
;;                pyim-probe-org-structure-template
;;                ))
;;(setq-default pyim-punctuation-half-width-functions
;;              '(pyim-probe-punctuation-line-beginning
;;                pyim-probe-punctuation-after-punctuation))
;;
;;;;  选择弹出框选项
;;(setq pyim-page-tooltip 'posframe)
;;(pyim-isearch-mode 1)
;;(setq pyim-page-length 5)
;;
;;(define-key pyim-mode-map "." 'pyim-page-next-page)
;;(define-key pyim-mode-map "," 'pyim-page-previous-page)
;;
;;;; 添加中文分词功能
;;(global-set-key (kbd "M-f") 'pyim-forward-word)
;;(global-set-key (kbd "M-b") 'pyim-backward-word)
;;
;;
;;;; 在输入不了中文时，按的快捷键，原本是M-j, 但在org-mode 和 markdown 下与其快捷键冲突。
;;(global-set-key (kbd "M-i") 'pyim-convert-string-at-point)
;;;;(global-set-key (kbd "M-j") 'pyim-convert-string-at-point)
;;;;(define-key minibuffer-local-map (kbd "C-<return>") 'pyim-convert-cregexp-at-point)
;;
;;(defun eh-ivy-cregexp (str)
;;  (let ((x (ivy--regex-plus str))
;;        (case-fold-search nil))
;;    (if (listp x)
;;        (mapcar (lambda (y)
;;                  (if (cdr y)
;;                      y
;;                    (list (pyim-cregexp-build (car y))))
;;                  x))
;;      (pyim-cregexp-build x))))
;;
;;(setq ivy-re-builders-alist
;;      '((t . eh-ivy-cregexp)))
;;
;;;; 启动emacs 时加载词库
;;(add-hook 'emacs-startup-hook
;;          #'(lambda () (pyim-restart-1 t)))

;; ---pyim done---

;;(defun xah-html-open-in-brave ()
;;  "Open the current file or `dired' marked files in Brave browser.
;;If the file is not saved, save it first.
;;Version 2019-11-10"
;;  (interactive)
;;  (let* (
;;         ($file-list
;;          (if (string-equal major-mode "dired-mode")
;;              (dired-get-marked-files)
;;            (list (buffer-file-name))))
;;         ($do-it-p (if (<= (length $file-list) 5)
;;                       t
;;                     (y-or-n-p "Open more than 5 files? "))))
;;    (when $do-it-p
;;      (cond
;;       ((string-equal system-type "darwin")
;;        (mapc
;;         (lambda ($fpath)
;;           (shell-command (format "open -a 'Brave Browser.app' \"%s\"" $fpath)))
;;         $file-list))
;;       ((string-equal system-type "windows-nt")
;;        ;; "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" 2019-11-09
;;        (let ((process-connection-type nil))
;;          (mapc
;;           (lambda ($fpath)
;;             (start-process "" nil "powershell" "start-process" "brave" $fpath ))
;;           $file-list)))
;;       ((string-equal system-type "gnu/linux")
;;        (mapc
;;         (lambda ($fpath)
;;           (shell-command (format "brave \"%s\"" $fpath)))
;;         $file-list))))))
;;
;;(defun xah-open-in-vscode ()
;;  "Open current file or dir in vscode.
;;
;;URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
;;Version 2020-02-13"
;;  (interactive)
;;  (let (($path (if (buffer-file-name) (buffer-file-name) (expand-file-name default-directory ) )))
;;    (message "path is %s" $path)
;;    (cond
;;     ((string-equal system-type "darwin")
;;      (shell-command (format "open -a Visual\\ Studio\\ Code.app \"%s\"" $path)))
;;     ((string-equal system-type "windows-nt")
;;      (shell-command (format "Code \"%s\"" $path)))
;;     ((string-equal system-type "gnu/linux")
;;      (shell-command (format "brave \"%s\"" $path))))))
