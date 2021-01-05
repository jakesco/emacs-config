;;; Emacs Config

;;; Disable startup message, bell, and follow symlink prompt
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t
      ring-bell-function 'ignore
      vc-follow-symlinks t)

(fset 'yes-or-no-p 'y-or-n-p)

;;; Disable the extra ui elements
(scroll-bar-mode -1)
(tooltip-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;;; Highlight matching parens
(show-paren-mode 1)

;;; Font Settings
(defvar jake/font-size 11)

(set-face-attribute 'default nil :font "Source Code Pro" :height (* jake/font-size 10))

;;; Set global line numbers
(column-number-mode t)
(global-display-line-numbers-mode t)

(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook
                Man-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode -1))))

;;; Delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; Activate auto indent
(define-key global-map (kbd "RET") 'newline-and-indent)

;;; Move backup and autosave files to /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;; Set startup frame size
;;;(setq initial-frame-alist '((top . 0) (left . 0) (width . 120) (height . 80)))

;;; Save settings from 'customize' in separate file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file :noerror)

;;; IDO Mode
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;;; Packages
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;;; Evil Mode
(unless (package-installed-p 'evil)
  (package-install 'evil))

(setq evil-respect-visual-line-mode t)
(require 'evil)
(evil-mode 1)

;;; Modus Vivendi Theme
(unless (package-installed-p 'modus-vivendi-theme)
  (package-install 'modus-vivendi-theme))
(load-theme 'modus-vivendi t)

;;; YAML
(unless (package-installed-p 'yaml-mode)
  (package-install 'yaml-mode))

;;; Markdown
(unless (package-installed-p 'markdown-mode)
  (package-install 'markdown-mode))

;;; SLIME for Common Lisp Development
(unless (package-installed-p 'slime)
  (package-install 'slime))
(setq inferior-lisp-program "/usr/bin/sbcl")
