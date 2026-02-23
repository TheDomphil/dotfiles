;; Dont show splash screen:
(setq inhibit-startup-message t)
(setq use-file-dialog nil)

(setq initial-scratch-message
      ";;Hello Adam, Welcome!\n
;; Important keys:\n
;; C-x C-f\tFind File
;; C-g\t\tCancel Command
;; C-x b\tSwitch Buffer
;; C-x 1\tKill everything except current window
;; C-x o\tSwitch to other window
;; M-x\t\tRun command
;; C-h\t\tHelp
;; C-x C-f /sudo::/path/to/file\tOpen file in sudo
;; C-/\t\tUndo
;; C-Space\tSet mark
;; C-w\t\tCut from mark
;; C-x- g\tMagit
;; S\tStage (git add .)
;; c c\tCommit (git commit)
;; C-c C-c\t(save the message)
;; P p\tPush 
")

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; THEME
(load-theme 'doom-manegarm' t)
;;(load-theme 'deeper-blue' t)

;; TRANSPARENCY

;; Setting transparency
(defun my/apply-terminal-transparency ()
  (when (not (display-graphic-p))
    (set-face-background 'default "none")
    ;;(set-face-background 'line-number "none")
    (set-face-background 'vertical-border "none")))

;; Run it now and whenever a theme is loaded
(my/apply-terminal-transparency)
(add-hook 'after-make-frame-functions (lambda (frame) (my/apply-terminal-transparency)))
(advice-add 'load-theme :after #'my/apply-terminal-transparency)   


;; To find out a specific face: Alt+X over a face then "describe-face"
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "#acacac")))) ;;Change this maybe
 '(font-lock-comment-face ((t (:foreground "#acacac"))))
 '(line-number ((t (:foreground "#acacac")))))

;; PACKAGES

(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))


(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; ACTUAL PACKAGES

;;Git Integration
(use-package magit)

;;Showing keybindings
(use-package which-key
  :config (which-key-mode))

;; LSP - Language Server Protocol
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (c-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; V-Term - No line numbers for vterm
(use-package vterm
  :ensure t
  :config
  (add-hook 'vterm-mode-hook
	    (lambda()
	      (display-line-numbers-mode 0))))



;; Vertico (Completion)
(use-package vertico
  :config (vertico-mode))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
