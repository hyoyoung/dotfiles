;;;##############################################################
;;; linux settings
;;;##############################################################
(defun my-linux-conf ()
  (if (eq window-system 'x)
    (progn
      (set-face-attribute 'default nil :family "Hack")
      (set-fontset-font t 'hangul
                  (font-spec :name "D2Coding"))
      ;(setq face-font-rescale-alist '(("D2Coding" . 1.23)))
      
      (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "x-www-browser")

      ; unset unused keys
      (global-unset-key (kbd "<f9>")) ; change to hanja

      (global-set-key [(Hangul)] 'toggle-input-method)
      (global-set-key [(Hangul_Hanja)] 'hangul-to-hanja-conversion)))
)

;;;##############################################################
;;; darwin settings
;;;##############################################################
(defun my-darwin-conf ()
  (set-face-attribute 'default nil :family "Menlo")
  ;; To enable sRGB
  (setq ns-use-srgb-colorspace t)
  
  ;; key bindings
  (setq mac-option-modifier 'meta)

  (defun copy-from-osx ()
    (shell-command-to-string "pbpaste"))
  (defun paste-to-osx (text &optional push)
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))
  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx)

  ;; add brew path
  (setq brew-bin-path "/usr/local/bin/")
  (add-to-list 'exec-path brew-bin-path)
  ;; shell-command-to-string error
  (setenv "PATH" (concat brew-bin-path ":" (getenv "PATH")))
  ;; add brew path to eshell's path
  (add-hook 'eshell-mode-hook
     '(lambda nil
       (setq eshell-path-env (concat brew-bin-path ":" eshell-path-env))))
)

;;;##############################################################
;;; jump to each conf functions
;;;##############################################################
(cond
  ((string-equal system-type "darwin")   ; Mac OS X
    (progn
      (setq my-frame-height 50)
      (setq my-frame-width 160)
      (setq my-font-height 140)

      (my-darwin-conf)))
  ((string-equal system-type "gnu/linux") ; linux
    (progn
      (setq my-frame-x 20)
      (setq my-frame-y 20)
      (setq my-frame-height 45)
      (setq my-frame-width 150)
      (setq my-font-height 85)

      (my-linux-conf)))
)

;;;##############################################################
;;; window size
;;;##############################################################

; default window width and height
(defun custom-set-frame-size ()
  (if (boundp 'my-frame-x)
    (add-to-list 'default-frame-alist `(top . ,my-frame-x)))
  (if (boundp 'my-frame-y)
    (add-to-list 'default-frame-alist `(left . ,my-frame-y)))
  (add-to-list 'default-frame-alist `(height . ,my-frame-height))
  (add-to-list 'default-frame-alist `(width . ,my-frame-width)))
(custom-set-frame-size)
(add-hook 'before-make-frame-hook #'custom-set-frame-size)

;;;##############################################################
;;; font conf
;;;##############################################################

;; default font size (point * 10)
;;
;; WARNING!  Depending on the default font,
;; if the size is not supported very well, the frame will be clipped
;; so that the beginning of the buffer may not be visible correctly. 
(if (boundp 'my-font-height)
  (set-face-attribute 'default nil :height my-font-height))

;;;##############################################################
;;; package managers
;;;##############################################################
  
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))

;; Initialise the packages, avoiding a re-initialisation.
(unless (bound-and-true-p package--initialized)
  (setq package-enable-at-startup nil)
  (package-initialize))

;; Make sure `use-package' is available.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Configure `use-package' prior to loading it.
(eval-and-compile
  (setq use-package-always-defer nil)
  (setq use-package-always-demand nil)
  (setq use-package-expand-minimally nil)
  (setq use-package-enable-imenu-support t)
  ;; The following is VERY IMPORTANT.  Write hooks using their real name
  ;; instead of a shorter version: after-init ==> `after-init-hook'.
  ;;
  ;; This is to empower help commands with their contextual awareness,
  ;; such as `describe-symbol'.
  (setq use-package-hook-name-suffix nil))

(eval-when-compile
  (require 'use-package))

;;;##############################################################
;;; installs packages
;;;#############################################################

(defvar my-packages
  '(flycheck py-autopep8 blacken magit))
(defun install-my-packages (package)
  (unless (package-installed-p package)
    (package-install package)))
(mapc #'install-my-packages my-packages)
  
;;;##############################################################
;;; load site-lisp
;;;#############################################################
(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'custom-theme-load-path
  (file-name-as-directory "~/.emacs.d/site-lisp/midnight-dawn-theme"))

;;;##############################################################
;;; global setting
;;;##############################################################
(setq inhibit-startup-message t)
(setq column-number-mode t)
(display-time)
(defalias 'yes-or-no-p 'y-or-n-p)       ; use y/n instead of yes/no

(show-paren-mode t) ; turn on paren match highlighting
(setq show-paren-style 'mixed) 

;; show file size
(size-indication-mode)

;; auto save when lose input focus
(defun my-focus-out-hook ()
  (save-some-buffers t))
(add-hook 'focus-out-hook #'my-focus-out-hook)
(auto-save-visited-mode) ; auto save files every 5 seconds

(require 'icomplete)
(icomplete-mode 1)                      ; incremental minibuffer completion
(setq icomplete-in-buffer t)
(auto-compression-mode t)               ; auto handling with zipped files

;;;InteractivelyDoThings mode to auto complete in minibuffer
(require 'ido)
(require 'ido-completing-read+)
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-complete-space-or-hyphen-mode t)
(setq ido-confirm-unique-completion t)
(setq ido-ubiquitous-mode t)

(require 'amx)
(amx-mode 1)
(global-set-key (kbd "M-x") 'amx)
(global-set-key (kbd "M-X") 'amx-major-mode-commands)
;;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; font-lock-mode
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

; enable color in console mode
(add-hook 'shell-mode-hook #'ansi-color-for-comint-mode-on)

;; Display line number on the left
(if (version<= "27.0" emacs-version)
  (progn
    (require 'display-line-numbers)
    (add-hook 'prog-mode-hook #'display-line-numbers-mode)
    (setq-default display-line-numbers-grow-only t)
    (setq-default display-line-numbers-width 3)))

;; focus to the main buffer
(setq initial-buffer-choice t)

; for mule
(define-coding-system-alias 'utf8 'utf-8)

;; autocomplete paired brackets
(electric-pair-mode 1)

(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR." t)

;; https://www.emacswiki.org/emacs/SavePlace
(save-place-mode 1)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-z") 'zap-up-to-char)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(global-set-key (kbd "<home>") 'move-beginning-of-line)
(global-set-key (kbd "<end>") 'move-end-of-line)

; unset unused keys
(global-unset-key (kbd "S-SPC")) ; switch input method
(global-unset-key (kbd "C-x f")) ; don't set fill column
(global-unset-key (kbd "C-x C-n")) ; don't set-goal-column
(when window-system (global-unset-key (kbd "C-z"))) ; don't minimize
(global-unset-key (kbd "C-x C-z")) ; don't suspend
(global-unset-key (kbd "C-x z")) ; don't repeat
(global-unset-key [mode-line mouse-3]) ; don't enlarge mode-line

;;; clean up the mode line
(require 'minions)
(setq minions-mode-line-lighter "☰")
(minions-mode 1)
(setq minions-direct '(projectile-mode flycheck-mode))

(require 'simple-modeline)
(simple-modeline-mode)

(setq save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      load-prefer-newer t)

(if (version<= "27.0" emacs-version)
  (progn
    (require 'display-fill-column-indicator)
    (setq-default fill-column 100)
    (add-hook 'text-mode-hook #'display-fill-column-indicator-mode)
    (add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)))

(global-whitespace-mode 1)
(setq
   whitespace-style
   '(face ; viz via faces
     trailing ; trailing blanks visualized
     lines-tail ; lines beyond whitespace-line-column
     space-before-tab
     space-after-tab
     newline ; lines with only blanks
     indentation ; spaces used for indent when config wants tabs
     empty ; empty lines at beginning or end
     )
   whitespace-line-column 100 ; whitespace-mode says the line is too long
)

;(display-battery-mode 1)

(use-package undo-tree
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))

;;; show color codes in buffer
(use-package rainbow-mode
  :config
    (progn
      (setq rainbow-x-colors nil)
      (add-hook 'prog-mode-hook 'rainbow-mode)))

;;;##############################################################
;;; load theme
;;;#############################################################
(load-theme 'midnight-dawn t)

;;;##############################################################
;;; 프로그래밍 모드
;;;##############################################################

(require 'flycheck)
(defun my-flycheck-mode-hook ()
  (flycheck-color-mode-line-mode))
  ; the default value was '(save idle-change new-line mode-enabled)
  (setq flycheck-check-syntax-automatically '(save idle-change idle-buffer-switch))
  (setq flycheck-idle-change-delay 3.0)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'my-flycheck-mode-hook))

;;;##############################################################
;;; 프로그래밍 모드 - lsp
;;;##############################################################

(setenv "GOPATH" (expand-file-name "~/local/go"))
(add-to-list 'exec-path (expand-file-name "~/local/go/bin"))

(setq lsp-prefer-capf t)
(setq lsp-signature-render-documentation nil) ; show only functions' signature
(setq lsp-signature-function #'eldoc-message) ; workaround signature two lines

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook
    ((python-mode-hook . lsp-deferred)
      (go-mode-hook . lsp-deferred))
  :config
    (progn
      (setq lsp-prefer-flymake nil)
      (setq lsp-enable-snippet nil)
      (setq lsp-auto-guess-root t) ; lsp with projectile
      ;(setq lsp-log-io nil)
      (setq lsp-enable-folding nil)
      (setq lsp-enable-symbol-highlighting nil)
      (setq lsp-enable-links nil)
      (setq lsp-client-packages '(lsp-pyls lsp-go))
      (push "[/\\\\][^/\\\\]*\\.\\(mod\\|sum\\)$" lsp-file-watch-ignored)
      (setq lsp-restart 'auto-restart)
      (lsp-register-custom-settings
        '(("gopls.completeUnimported" t t)
          ("gopls.staticcheck" t t)))
      (lsp-register-custom-settings
        '(("pyls.plugins.pyls_mypy.enabled" t t)
          ("pyls.plugins.pyls_mypy.live_mode" nil t)
          ("pyls.plugins.pyls_black.enabled" t t)
          ("pyls.plugins.pyls_isort.enabled" t t)))))

;;Optional - provides fancier overlays.
(use-package lsp-ui
  :requires lsp-mode flycheck
  :commands lsp-ui-mode)
(setq
  lsp-modeline-code-actions-enable nil
  lsp-ui-doc-position 'top
  lsp-ui-doc-include-signature t
  lsp-ui-doc-delay 0.5
  lsp-ui-sideline-update-mode 'line
  lsp-ui-sideline-delay 0.5
  lsp-ui-sideline-code-actions-prefix "💡 "
  lsp-ui-sideline-diagnostic-max-lines 3
  lsp-ui-sideline-ignore-duplicate t)

;;;##############################################################
;;; 프로그래밍 모드 - company
;;;##############################################################

(use-package company
  :config
    (setq company-idle-delay 0.5)
    (global-company-mode 1)
    (global-set-key (kbd "C-<tab>") 'company-complete))

;;;##############################################################
;;; 프로그래밍 모드 - yasnippet
;;;##############################################################

(use-package yasnippet
  :commands yas-minor-mode
  :hook (go-mode-hook . yas-minor-mode))

;;;##############################################################
;;; 프로그래밍 모드 - python
;;;##############################################################

;;; example of .dir-locals.el
;;; (
;;;   (python-mode . ((project-venv-path . "~/envs/some_env")))
;;;   (python-mode . ((lsp-pyls-server-command . ("/home/user/envs/some_env/bin/pyls"))))
;;;   (python-mode . ((pyvenv-activate . "~/envs/some_env")
;;;                 (subdirs . nil)))
;;; )

(defun my-python-mode-hook ()
    (setq indent-tabs-mode nil)
    (setq default-tab-width 4)
    (setq python-indent-offset 4)
    (setq python-indent-guess-indent-offset-verbose nil)
    (setq show-trailing-whitespace t)
    (setq my-default-venv-path (expand-file-name "~/.emacs.d/venv/"))
    (pyvenv-activate my-default-venv-path)
    (setenv "WORKON_HOME" "~/local/anaconda3/envs") ; to use conda
    (pyvenv-mode 1)
    (pyvenv-tracking-mode 1))
(add-hook 'python-mode-hook #'my-python-mode-hook)

(require 'pyvenv)
(defun my-venv-with-window-buffer-change (newframe)
  (if (eq major-mode 'python-mode)
    (progn
      (if (boundp 'project-venv-path)
        (if (not (string-equal pyvenv-virtual-env project-venv-path))
          (progn
            (message "Activating %s." project-venv-path)
            (hack-local-variables)
            (pyvenv-activate project-venv-path)))
        (if (not (string-equal pyvenv-virtual-env my-default-venv-path))
          (progn
            (message "Change to default venv.")
            (hack-local-variables)
            (pyvenv-activate my-default-venv-path)))))))
; after emacs 27.1
;(if (version<= "27.0" emacs-version)
;  (add-hook 'window-buffer-change-functions #'my-venv-with-window-buffer-change))

; pip install python-language-server[all]
; pip install pyls-mypy pyls-black pyls-isort
(defun lsp-python-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t))
(add-hook 'python-mode-hook #'lsp-python-install-save-hooks)

(setq lsp-pyls-plugins-pycodestyle-max-line-length 100)
;(setq lsp-pyls-plugins-pycodestyle-ignore '("E501")) ; long line warning


;;;##############################################################
;;; 프로그래밍 모드 - jinja2
;;;##############################################################

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-engines-alist 
  '(("django" . "\\.html\\'")
    ("php" . "\\.php\\.")) )

;;;##############################################################
;;; 프로그래밍 모드 - golang
;;;##############################################################
(require 'go-mode)
    (add-to-list 'auto-mode-alist (cons "\\.go\\'" 'go-mode))

; go get github.com/golangci/golangci-lint/cmd/golangci-lint
; # binary will be $(go env GOPATH)/bin/golangci-lint
; curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.27.0

(defun my-golang-mode-hook ()
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet && golangci-lint run"))

  (local-set-key (kbd "M-.") 'lsp-find-definition)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  (local-set-key (kbd "M-p") 'compile)
  (local-set-key (kbd "M-P") 'recompile)
  (local-set-key (kbd "M-]") 'next-error)
  (local-set-key (kbd "M-[") 'previous-error)

  (setq exec-path (append exec-path '("~/local/go/bin/")))
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq show-trailing-whitespace t))
(add-hook 'go-mode-hook #'my-golang-mode-hook)

;go get -u golang.org/x/tools/gopls
;go get -u honnef.co/go/tools/cmd/staticcheck

;;Set up before-save hooks to format buffer and add/delete imports.
;;Make sure you don't have other gofmt/goimports hooks enabled.
(defun my-lsp-golang-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'my-lsp-golang-install-save-hooks)

;;;##############################################################
;;; slime
;;;##############################################################
(require 'slime-autoloads)

;; Set your lisp system and, optionally, some contribs
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq slime-contribs '(slime-fancy))

;;;##############################################################
;;; rainbow-delimiter
;;;##############################################################
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;;##############################################################
;; neotree
;;;##############################################################

(defun my-neotree-skip-other-window-hook (created)
  (if (member 'window created)
    (set-window-parameter neo-global--window 'no-other-window t)))
(use-package neotree
  :init
    (add-hook 'neo-after-create-hook #'my-neotree-skip-other-window-hook)
  :config
    (progn
      (setq neo-smart-open t)
      (setq neo-autorefresh t)
      (setq neo-toggle-window-keep-p t)
      (setq neo-theme 'ascii)
      (setq neo-hide-cursor t)
      (neotree-show)))

;;;##############################################################
;; search mode hook - like vim * search
;;;##############################################################
(defun my-isearch-word-at-point ()
  (interactive)
  (call-interactively 'isearch-forward-regexp))
(defun my-isearch-yank-word-hook ()
  (when (equal this-command 'my-isearch-word-at-point)
    (let ((string (concat "\\<"
                          (buffer-substring-no-properties
                           (progn (skip-syntax-backward "w_") (point))
                           (progn (skip-syntax-forward "w_") (point)))
                          "\\>")))
      (if (and isearch-case-fold-search
               (eq 'not-yanks search-upper-case))
          (setq string (downcase string)))
      (setq isearch-string string
            isearch-message
            (concat isearch-message
                    (mapconcat 'isearch-text-char-description
                               string ""))
            isearch-yank-flag t)
      (isearch-search-and-update))))
(add-hook 'isearch-mode-hook #'my-isearch-yank-word-hook)
(global-set-key (kbd "C-*") 'my-isearch-word-at-point)

;;;##############################################################
;;; dot emacs 설정
;;;##############################################################
(defun edit-dot-emacs ()
  "Load the .emacs file into a buffer for editing."
  (interactive)
  (find-file "~/.emacs"))
(defun reload-dot-emacs ()
  "Save .emacs, if it is in a buffer, and reload it."
  (interactive)
  (if (bufferp (get-file-buffer "~/.emacs"))
    (save-buffer (get-buffer "~/.emacs")))
  (load-file "~/.emacs"))

;;;##############################################################
;; highlight-symbol
;;;##############################################################
;(add-to-list 'load-path "~/.emacs.d/site-lisp/highlight-symbol/")
(require 'highlight-symbol)
(global-set-key (kbd "<M-up>") 'highlight-symbol-remove-all)
(global-set-key (kbd "<M-down>") 'highlight-symbol-at-point)
(setq highlight-symbol-on-navigation-p t)

(defun my-highlight-symbol-hook ()
  (highlight-symbol-nav-mode t))
(when window-system
    (add-hook 'prog-mode-hook #'my-highlight-symbol-hook))

;;;##############################################################
;; window-move
;;;##############################################################
;(if window-system
;    (windmove-default-keybindings 'meta)
;  (progn
;    (global-set-key [(alt left)]  'windmove-left)
;    (global-set-key [(alt up)]    'windmove-up)
;    (global-set-key [(alt right)] 'windmove-right)
;    (global-set-key [(alt down)]  'windmove-down)))

;;;##############################################################
;;; misc - vi style behaviours
;;;#############################################################
;;---
(defun kill-word-vi-style (arg)
  "Delete continuous whitespaces or a word.

If the char under cursor is whitespace or tab, this would delete
the continuous whitespaces.  If current cursor is at the end of
the line, this would delete the NEWLINE char and all leading
whitespaces of the next line. Otherwise it would kill current word."
  (interactive "p")
  (let ( (char (char-after (point))))
    (if (or (char-equal char ?\x020)
            (char-equal char ?\t))
        (delete-horizontal-space)
       (if (eolp)
          (delete-indentation t)
        (kill-word arg)))))
(global-set-key (kbd "C-d") 'kill-word-vi-style)

;;;##############################################################
;;; projectile
;;;##############################################################

(require 'projectile)

(setq projectile-enable-caching t
      projectile-remember-window-configs t
      projectile-indexing-method 'native
      projectile-completion-system (quote ivy)
      projectile-switch-project-action (quote projectile-dired))

(defun my-projectile-mode ()
  (projectile-mode 1))
(add-hook 'prog-mode-hook #'my-projectile-mode)

;(setq projectile-globally-ignored-files '("TAGS" "GPATH" "GRTAGS" "GSYMS" "GTAGS"))

(eval-after-load 'projectile
  (setq-default projectile-mode-line-prefix " Proj"))

;;;##############################################################
;;; flyspell
;;;#############################################################

(require 'flyspell)
(setq flyspell-issue-message-flag nil
      ispell-dictionary "en_US"
      ispell-program-name "aspell"
      ispell-extra-args '("--sug-mode=ultra"))

(add-hook 'text-mode-hook #'flyspell-mode)
(add-hook 'prog-mode-hook #'flyspell-prog-mode)

;;;##############################################################
;;; misc
;;;#############################################################
(require 'tramp)
(setq tramp-default-method "ssh")
;(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
;(setq tramp-debug-buffer t)
;(setq tramp-verbose 10)


;eshell completion
(add-hook
 'eshell-mode-hook
 (lambda ()
   (setq pcomplete-cycle-completions nil)))
;(setq eshell-cmpl-cycle-completions nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(rainbow-mode undo-tree neotree web-mode blacken exec-path-from-shell minions simple-modeline fill-column-indicator magit py-autopep8 projectile pyvenv ido-completing-read+ amx highlight-symbol rainbow-delimiters yasnippet use-package company lsp-ui lsp-mode flycheck-color-mode-line go-mode popup 0xc w3m org jedi fuzzy flycheck f)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
