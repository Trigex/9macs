;; init.el
;; completely, shamelessly stolen from Witchmacs

;; Make emacs startup faster
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)
 
(defvar startup/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
 
(defun startup/revert-file-name-handler-alist ()
  (setq file-name-handler-alist startup/file-name-handler-alist))
 
(defun startup/reset-gc ()
  (setq gc-cons-threshold 16777216
    gc-cons-percentage 0.1))
 
(add-hook 'emacs-startup-hook 'startup/revert-file-name-handler-alist)
(add-hook 'emacs-startup-hook 'startup/reset-gc)

;; these two visual config bits are here so they're all disabled quickly as possible, get that ugly flash done sooner than later
;; disable default startup screen
(setq inhibit-startup-message t)

;; disable gui elements
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Initialize melpa repo
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
        '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Initialize use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; packages
(load "~/.emacs.d/packages.el")
;; post-package install configurations
(load "~/.emacs.d/config.el")
