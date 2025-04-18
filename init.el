;; Minimal Emacs 30 setup for Rust and LSP

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")))
(setq package-check-signature 'allow-unsigned)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; lsp-mode for Rust (lsp-rust not needed)
(use-package lsp-mode
  :ensure t
  :hook (rust-mode . lsp)
  :config
  (setq lsp-completion-provider :none)  ;; disable autocomplete
  (setq lsp-rust-analyzer-server-command '("rust-analyzer")))


(defun rust-cheatsheet ()
  "Open a cheatsheet buffer with common Rust Analyzer commands."
  (interactive)
  (let ((buf (get-buffer-create "*Rust Cheatsheet*")))
    (with-current-buffer buf
      (erase-buffer)
      (insert "🦀 Rust Analyzer Cheatsheet\n")
      (insert "=============================\n\n")
      (insert "🏗  Navigation & Info:\n")
      (insert "  M-.         → lsp-find-definition\n")
      (insert "  M-?         → lsp-find-references\n")
      (insert "  C-c C-d     → lsp-hover\n")
      (insert "  C-c C-a     → lsp-execute-code-action\n")
      (insert "  M-x lsp-describe-session\n")
      (insert "\n🔧 Refactoring:\n")
      (insert "  M-x lsp-rename           → Rename symbol\n")
      (insert "  M-x lsp-format-buffer    → Format code\n")
      (insert "\n🚀 Running & Testing:\n")
      (insert "  C-c r r     → Run at point (lsp-rust-analyzer-run)\n")
      (insert "  C-c r t     → Run tests   (lsp-rust-analyzer-run-tests)\n")
      (insert "\n🔍 Extras:\n")
      (insert "  M-x lsp-rust-analyzer-expand-macro\n")
      (insert "  M-x lsp-rust-analyzer-inlay-hints-mode\n")
      (goto-char (point-min))
      (view-mode))
    (pop-to-buffer buf)))

(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))


(use-package clojure-mode
  :ensure t)
(use-package cider
  :ensure t)

(use-package ess
  :ensure t)
	  

;; Rainbow Delimiters
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; Basic UI
(load-theme 'tango t) ;; pick a better theme if needed
(set-cursor-color "black")

;; (global-display-line-numbers-mode t)
;; (setq display-line-numbers-type 'visual)

;; Disable autosave/backup
(setq make-backup-files nil)
(setq auto-save-default nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(cargo cider company company-org-block ess flycheck flycheck-rust
	   hydra lsp-mode org-modern projectile rainbow-delimiters
	   rust-mode use-package which-key-posframe)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
