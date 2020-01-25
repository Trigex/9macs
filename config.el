;; this file is used for post use-package configuration, do the chunk of configuration and function definitions here
;; theming
(load-theme 'doom-nord t)
;; fonts
(set-face-attribute 'default nil :font "JetBrains Mono-11:style=Regular")
(setq line-spacing 1.2)

;; line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)

;; don't use --dired since it's not a FreeBSD ls option
(setq dired-use-ls-dired nil)

;; show parent parentheses
(show-paren-mode 1)

;; copy-pasting outside of emacs
(setq x-select-enable-clipboard t)

;; disable auto backup files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; whatever conservative scrolling is, I'm in
(setq scroll-conservatively 100)

;; who said you can beep at me?
(setq ring-bell-function 'ignore)

;; epic indentation
(setq-default tab-width 4)
(setq-default standard-indent 4)
(setq c-basic-offset tab-width)
(setq-default electric-indent-inhibit t)
(setq-default indent-tabs-mode t)
(setq backward-delete-char-untabify-method 'nil)

;; symbols so pretty
(global-prettify-symbols-mode t)

;; bracket pair matching
(setq electric-pair-pairs '(
                            (?\{ . ?\})
                            (?\( . ?\))
                            (?\[ . ?\])
                            (?\" . ?\")
                            ))
(electric-pair-mode t)

;; switch cursor to newly created windows
(defun split-and-follow-horizontally ()
	(interactive)
	(split-window-below)
	(balance-windows)
	(other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
	(interactive)
	(split-window-right)
	(balance-windows)
	(other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

;; yes-or-no to y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;; better resize bindings (Super - Control - <Arrowkey>)
(global-set-key (kbd "s-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "s-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "s-C-<down>") 'shrink-window)
(global-set-key (kbd "s-C-<up>") 'enlarge-window)

;; highlight current line
(global-hl-line-mode t)

;; defer package loading for quicker startup
(setq use-package-always-defer t)

;; eshell for maximum staying in emacs
(setq eshell-prompt-regexp "^[^αλ\n]*[αλ] ")
(setq eshell-prompt-function
      (lambda nil
        (concat
         (if (string= (eshell/pwd) (getenv "HOME"))
             (propertize "~" 'face `(:foreground "#99CCFF"))
           (replace-regexp-in-string
            (getenv "HOME")
            (propertize "~" 'face `(:foreground "#99CCFF"))
            (propertize (eshell/pwd) 'face `(:foreground "#99CCFF"))))
         (if (= (user-uid) 0)
             (propertize " α " 'face `(:foreground "#FF6666"))
         (propertize "  " 'face `(:foreground "#BF616A"))))))

(setq eshell-highlight-prompt nil)

;; command aliases
;; open a file in emacs from eshell
(defalias 'open 'find-file-other-window)
;; too used to typing clear for, well, clear lol
(defalias 'clean 'eshell/clear-scrollback)

;; custom functions for eshell

;; open files as root
(defun eshell/sudo-open (filename)
  "Open a file as root in Eshell."
    (let ((qual-filename (if (string-match "^/" filename)
                           filename
                         (concat (expand-file-name (eshell/pwd)) "/" filename))))
    (switch-to-buffer
     (find-file-noselect
      (concat "/doas::" qual-filename)))))

;; C-s-return to open Eshell
(defun eshell-other-window ()
  "Create or visit an eshell buffer in a split window."
  (interactive)
  (if (not (get-buffer "*eshell*"))
      (progn
        (split-window-sensibly (selected-window))
        (other-window 1)
        (eshell))
    (switch-to-buffer-other-window "*eshell*")))

;; M-s-return to open eshell and close other windows (because it's the *Alt*ernate opening mode)
(defun eshell-close-other-windows ()
  "Create or visit an eshell buffer in a new, single window, closing others if existant."
  (interactive)
  (if (not (get-buffer "*eshell*"))
	  (progn
		(split-window-sensibly (selected-window))
		(other-window 1)
		(delete-other-windows)
		(eshell))
	(progn
	  (delete-other-windows)
	  (switch-to-buffer "*eshell*"))))

(global-set-key (kbd "<s-C-return>") 'eshell-other-window)
(global-set-key (kbd "<M-s-return>") 'eshell-close-other-windows)

(setq ido-vertical-define-keys 'C-n-C-p-up-and-down)

;; bind C-x C-r to restart-emacs
(global-set-key (kbd "C-x C-r") 'restart-emacs)

;; open config.el
(global-set-key (kbd "C-x <f8>") (lambda () (interactive) (find-file "~/.emacs.d/config.el")))
;; open packages.el
(global-set-key (kbd "C-x <f7>") (lambda () (interactive) (find-file "~/.emacs.d/packages.el")))
;; open init.el
(global-set-key (kbd "C-x <f6>") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
