;; use-package calls, idealy keep configuration of packages here short, extended configuration should
;; go in config.el
;; so organized!
(use-package org
  :config
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook
            '(lambda ()
               (visual-line-mode 1))))

;; indents in outline
(use-package org-indent
  :diminish org-indent-mode)

;; cute org bullets
(use-package org-bullets
    :ensure t
        :init
        (add-hook 'org-mode-hook (lambda ()
                            (org-bullets-mode 1))))

;; convert buffer text & decorations to HTML
(use-package htmlize
  :ensure t)

;; auto-package-update to automatically update and remove old packages
(use-package auto-package-update
  :defer nil
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; hides minor modes to prevent modeline clutter
(use-package diminish
  :ensure t)

;; all-the-icons for pwetty icons
(use-package all-the-icons
  :ensure t)

;; doom sure is pretty let's take it's themes
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; da pwettyiest modeline
(use-package doom-modeline
      :ensure t
      :hook (after-init . doom-modeline-mode)
	  :config
	  (setq doom-modeline-buffer-file-name-style 'relative-from-project)
	  (setq doom-modeline-major-mode-icon t)
	  (setq doom-modeline-major-mode-color-icon t)
	  (setq doom-modeline-unicode-fallback t))

(use-package dashboard
  :ensure t
  :defer nil
  :preface
  (defun create-scratch-buffer ()
    "Create a scratch buffer"
    (interactive)
    (switch-to-buffer (get-buffer-create "*scratch*"))
    (lisp-interaction-mode))
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 5)))
  (setq dashboard-banner-logo-title "⑨macs")
  (setq dashboard-startup-banner "~/.emacs.d/cirno-dash.png")
  (setq dashboard-center-content t)
  (setq dashboard-show-shortcuts nil)
  (setq dashboard-set-init-info t)
  (setq dashboard-init-info (format "%d frogs unfrozen in %s"
                                    (length package-activated-list) (emacs-init-time)))
  (setq dashboard-set-footer nil)
  (setq dashboard-set-navigator t)
  (setq dashboard-navigator-buttons
        `(
	  ((,nil
            "Open scratch buffer"
            "Switch to the scratch buffer"
            (lambda (&rest _) (create-scratch-buffer))
            'default)))))

;; gives a buffer with command completions
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init
  (which-key-mode))

(use-package evil
  :ensure t
  :defer nil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  ;(setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; highligh cursor position on switching buffers or windows
(use-package beacon
  :ensure t
  :diminish beacon-mode
  :init
  (beacon-mode 1))

;; allows moving to far away lind with M-s and typing the character to move to
(use-package avy
	:ensure t
	:bind
	("M-s" . avy-goto-char))

;; switch windows with C-x o and pressing the assigned key
(use-package switch-window
	:ensure t
	:config
	(setq switch-window-input-style 'minibuffer)
	(setq switch-window-increase 4)
	(setq switch-window-threshold 2)
	(setq switch-window-shortcut-style 'qwerty)
	(setq switch-window-qwerty-shortcuts
		  '("a" "s" "d" "f" "j" "k" "l"))
	:bind
	([remap other-window] . switch-window))

;; ido allows for nicer switching and killing of buffers
(use-package ido
  :init
  (ido-mode 1)
  :config
  (setq ido-enable-flex-matching nil)
  (setq ido-create-new-buffer 'always)
  (setq ido-everywhere t))

(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1))

;; use async processes when we can
(use-package async
	:ensure t
	:config
	(dired-async-mode 1))

;; nicer looking page breaks
(use-package page-break-lines
  :ensure t
  :diminish (page-break-lines-mode visual-line-mode))

;; evil-mode wants this
(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode)

;; qt treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if (executable-find "python3") 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-follow-delay             0.2
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-desc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-width                         30)
    (treemacs-resize-icons 11)
	
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
    :ensure t)

(use-package treemacs-icons-dired
    :after treemacs dired
    :ensure t
    :config (treemacs-icons-dired-mode))

(use-package restart-emacs
  :ensure t
  :defer t)

;; programming bits!
;; supposed to be bretty gud
(use-package magit
  :ensure t)

;; epic function signatures in the echo area
(use-package eldoc
  :diminish eldoc-mode)

;; cc-mode for all those pesky ceeeee langs
(use-package cc-mode)

;; javashit major-mode
(use-package js2-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'interpreter-mode-alist '("node" . js2-mode)))

;; support for the c/c++ lsp client ccls
(use-package ccls
  :ensure t
  :config
  (setq ccls-executable "/usr/local/bin/ccls"))

;; flycheck provides syntax checking extensions for emacs, and various ui modules to go along with it
(use-package flycheck
  :ensure t
  :init (add-hook 'after-init-hook #'global-flycheck-mode))

;; lsp-mode for languages with lsp servers
(use-package lsp-mode
  :ensure t
  :hook ((c-mode c++-mode js2-mode) . lsp)
  :commands lsp)

;; lsp-ui provides flycheck intergration + some ui modules for lsp-mode
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; company backend for lsp mode
(use-package company-lsp
  :ensure t
  :commands company-lsp)

;; company autocompletion frontend
(use-package company
  :ensure t
  :diminish (company-mode lsp-mode)
  :init (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "SPC") #'company-abort)
  :hook
  ((c-mode c++-mode js2-mode) . company-mode))

(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.riot\\'" . web-mode)))
