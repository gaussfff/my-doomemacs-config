;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; general info
(setq user-full-name "Bohdan Sokolovskyi"
      user-mail-address "gauss.falcon@gmail.com")

;; font
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 14))

;; enable paredit
(use-package! paredit
              :hook ((emacs-lisp-mode lisp-mode lisp-interaction-mode clojure-mode) . enable-paredit-mode))

;; set dir for org files
(setq org-directory "~/org/")

;; set line numbers in files
(setq display-line-numbers-type t)

;; set theme for emacs
(setq doom-theme 'vscode-dark-plus)

;; dosen't ask when quiting from emacs
(setq confirm-kill-emacs nil)
(setq confirm-kill-processes nil)

;; fullscreen on startup
(add-to-list 'window-setup-hook #'toggle-frame-maximized)

;; colorful mode
(global-colorful-mode 1)

;; color vars
(global-color-identifiers-mode 1)

;; disable sound
(setq ring-bell-function 'ignore)

;; display time
(display-time-mode 1)

;; autosave
(setq auto-save-default t
      make-backup-files t)

;; icon modes
(setq mode-icons-desaturate-active t)

;; visual replace
(visual-replace-global-mode 1)

;; keyborad config
(setq kill-whole-line t)

;; custom splash image
(setq fancy-splash-image
      (concat doom-user-dir "splash/plankton.jpeg"))

(setq doom-dashboard-footer "AH SHIT, HERE WE GO AGAIN")

;; bindings
(global-set-key (kbd "s-b") #'lsp-find-declaraion)
(global-set-key (kbd "s-D") #'+doom-dashboard/open)
(global-unset-key (kbd "C-z"))

;; common lisp
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/opt/homebrew/bin/sbcl")
(setq slime-contribs '(slime-fancy))
(add-hook 'slime-mode-hook #'mod-prettify-symbols)

(defun mod-prettify-symbols ()
  (push '("lambda"  . ?λ) prettify-symbols-alist)
  (push '(">=" . ?≥) prettify-symbols-alist)
  (push '("<=" . ?≤) prettify-symbols-alist)
  ;;(push '("defun" . ?𝒇) prettify-symbols-alist)
  (push '("/=" . ?≠) prettify-symbols-alist)
  ;;(push '("nil" . ?∅) prettify-symbols-alist)
  )

(setq lisp-indent-function  'common-lisp-indent-function)

(defun lisp-add-keywords (face-name keyword-rules)
  (let* ((keyword-list (mapcar #'(lambda (x)
                                   (symbol-name (cdr x)))
                               keyword-rules))
         (keyword-regexp (concat "(\\("
                                 (regexp-opt keyword-list)
                                 "\\)[ \n]")))
    (font-lock-add-keywords 'lisp-mode
                            `((,keyword-regexp 1 ',face-name))))
  (mapc #'(lambda (x)
            (put (cdr x)
                 ;; scheme-indent-function
                 'common-lisp-indent-function
                 (car x)))
        keyword-rules))

(lisp-add-keywords
 'font-lock-keyword-face
 '((1 . aif)
   (1 . awhen)))

(global-prettify-symbols-mode)
(add-hook 'lisp-mode-hook #'mod-prettify-symbols)

;; reverse auth info
;; (after! auth-source
;;   (setq auth-source (nreverse auth-source)))
