;; Remus Lazar's Emacs Setup
;; =========================

;; see README.md

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ede-project-directories (quote ("/Users/lazarrs/Developer/Hardware/ArduinoTest")))
 '(inhibit-startup-screen t)
 '(ispell-dictionary "english")
 '(nxml-slash-auto-complete-flag t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; W32 specific settings, e.g. use aspell
(when (eq window-system 'w32)
  (add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/")
  (add-to-list 'exec-path "C:/Program Files (x86)/PuTTY")
  (setq ispell-program-name "aspell")
  (setenv "PROMPT" "$p$g")
  ;; use Source Code Pro font with Windows
  (custom-set-faces
   '(default ((t (:family "Source Code Pro" :foundry "outline" :slant normal :weight normal :height 90 :width normal)))))

  ;; tramp settings (remote files using ssh)
  (set-default 'tramp-auto-save-directory "C:/Users/lazarrs/AppData/Local/Temp")
  (set-default 'tramp-default-method "plink")
  (setq
   tramp-default-user "lazarrs"
   tramp-default-host "dev.cron.eu"
   tramp-terminal-type "dumb"
   )
  (require 'tramp)
  (require 'ispell))

;; use utf-8
(prefer-coding-system 'utf-8-unix)

;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-key-is-meta nil)
  (setq mac-option-modifier nil)
  (setq mac-command-key-is-meta t)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )

;; Some libs not available on MELPA (e.g. ts-mode)
(add-to-list 'load-path "~/.emacs.d/vendor")

;; Melpa Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; my package list (autoinstall)
(require 'cl)
(setq package-list '(jade-mode stylus-mode php-mode smart-tabs-mode auto-complete expand-region web-mode autopair markdown-mode json-mode js3-mode yaml-mode iedit tern tern-auto-complete))

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

;; default width of the fill-mode
(setq-default fill-column 80)

;; Default settings: indend with spaces, offset default 4 chars
(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil)

;; JavaScript: indend-level is 2, use spaces, no TABs
(setq js-indent-level 2)
(add-hook 'js-mode-hook
          (lambda ()
			(tern-mode t)
            (setq indent-tabs-mode nil)))

(add-hook 'js3-mode-hook
          (lambda () (tern-mode t)))

(add-hook 'json-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)))

(eval-after-load 'tern
  '(progn
	 (require 'tern-auto-complete)
	 (tern-ac-setup)))

;; Markdown mode, use auto-fill and flyspell
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-hook 'markdown-mode-hook
          (lambda ()
            (flyspell-mode)
            (auto-fill-mode)
            ))

;; TYPO3 TypoScript, do use TABs, TAB-width is 4
(require 'ts-mode)
(add-to-list 'auto-mode-alist '("\\.ts$" . ts-mode))
;; use the TypoScript ts-mode for TypoScript2, as well
(add-to-list 'auto-mode-alist '("\\.ts2$" . ts-mode))
;; add TS-Mode for text-files if they are inside a `Configuration`
;; directory
(add-to-list 'auto-mode-alist '("setup\\.txt$" . ts-mode))
(add-to-list 'auto-mode-alist '("constants\\.txt$" . ts-mode))
(add-hook 'ts-mode-hook
          (lambda ()
			(setq indent-tabs-mode t)
            (setq ts-block-indentation 4)))

;; PHP use defaults

;;(add-hook 'python-mode-hook guess-style-guess-tabs-mode)
(add-hook 'python-mode-hook
          (lambda ()
            (when indent-tabs-mode
              (guess-style-guess-tab-width))))

;; Use smart-tabs for this major modes (nxml for PHP-Mode)
(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl
                      'ruby 'nxml)

;; HTML tab-width 2, indend with spaces
(add-hook 'html-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq tab-width 2)))

;; for xml files use the same settings
(add-hook 'nxml-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq tab-width 2)))

;; CSS tab-width 4, indend with TABs (default)
;; (add-hook 'css-mode-hook
;;           (lambda ()
;;             (setq tab-width 4)))

;; c++ mode indending
(add-hook 'c++-mode-hook
          (lambda ()
            (setq tab-width 4)))

;; Auto cleanup all the whitespace before save.
;; Cleanup only the trailing spaces, dont convert
;; spaces to tabs and vice-versa
(setq whitespace-style (quote
                        ( empty trailing )))

(add-hook 'before-save-hook 'whitespace-cleanup)

(require 'autopair)
;; (autopair-global-mode) ;; enable autopair in all buffers
(add-to-list 'auto-mode-alist '("\\.ino$" . c-mode))

(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
;;(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)

;; Enable Semantic
(semantic-mode 1)

;; Enable EDE (Project Management) features
(global-ede-mode 1)

(defun my-semantic-hook ()
  (semantic-add-system-include "~/.arduino/lib/arduino" 'c-mode)
  (semantic-add-system-include "~/.arduino/lib/leonardo" 'c-mode))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key (kbd "M-{") 'move-line-up)
(global-set-key (kbd "M-}") 'move-line-down)
