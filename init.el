;; Remus Lazar's Emacs Setup
;; =========================

;; see README.md

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(nxml-slash-auto-complete-flag t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-key-is-meta nil)
  (setq mac-option-modifier nil)
  (setq mac-command-key-is-meta t)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )
(iswitchb-mode 1)

;; Some libs not available on MELPA (e.g. ts-mode)
(add-to-list 'load-path "~/.emacs.d/vendor")

;; Melpa Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; my package list (autoinstall)
(setq package-list '(jade-mode stylus-mode php-mode smart-tabs-mode auto-complete expand-region web-mode autopair))

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'stylus-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . stylus-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; Don't use TABs by detault
;; Do use TABs only for some specific modes
(setq-default indent-tabs-mode nil)

;; JavaScript: indend-level is 2, use spaces, no TABs
(setq js-indent-level 2)

;; TYPO3 TypoScript, do use TABs, TAB-width is 4
(require 'ts-mode)
(add-to-list 'auto-mode-alist '("\\.ts$" . ts-mode))
(add-hook 'ts-mode-common-hook
          (lambda () (setq indent-tabs-mode t)))
(add-hook 'ts-mode-common-hook
          (lambda () (setq tab-width 4)))

;; C, PHP, indent with tabs, TAB width is 4
(add-hook 'c-mode-common-hook
          (lambda () (setq indent-tabs-mode t)))
(add-hook 'c-mode-common-hook
          (lambda () (setq tab-width 4)))

;; Use smart-tabs for this major modes (nxml for PHP-Mode)
(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python
                      'ruby 'nxml)

;; HTML tab-width 2, indend with TABs using Smart Tabs
(add-hook 'html-mode-common-hook
		  (lambda () (setq indent-tabs-mode t)))
(add-hook 'html-mode-common-hook
		  (lambda () (setq tab-width 2)))
(add-hook 'nxml-mode-common-hook
		  (lambda () (setq tab-width 2)))

;; Auto cleanup all the whitespace before save.
;; Cleanup only the trailing spaces, dont convert
;; spaces to tabs and vice-versa
(setq whitespace-style (quote
                        ( empty trailing )))

(add-hook 'before-save-hook 'whitespace-cleanup)

(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers
