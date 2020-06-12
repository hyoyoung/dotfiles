;;;##############################################################
;;; linux settings
;;;##############################################################
(defun my-linux-conf ()
  ;;;##############################################################
  ;;; 폰트 및 창 크기 설정
  ;;;##############################################################
  
  (if (eq window-system 'x)
    (progn
      (set-default-font "Bitstream Vera Sans Mono:style=Roman")
      (set-fontset-font "fontset-default" '(#x1100 . #xffdc)
        '("NanumGothic" . "unicode-bmp")) ;;; 유니코드 한글영역
      (set-fontset-font "fontset-default" '(#xe0bc . #xf66e)
        '("NanumGothic" . "unicode-bmp")) ;;; 유니코드 한글영역
      (set-fontset-font "fontset-default" 'han
        '("Bitstream Vera Sans Mono:style=Roman" . "unicode-bmp"))
      
      (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "x-www-browser")

      ; unset unused keys
      (global-unset-key (kbd "S-SPC")) ; switch input method
      (global-unset-key (kbd "<f9>")) ; change to hanja

      ;;;##############################################################
      ;;; 한국어 사용을 위한 설정
      ;;;##############################################################
      
      (global-set-key [(Hangul)] 'toggle-input-method)
      (global-set-key [(Hangul_Hanja)] 'hangul-to-hanja-conversion)

      (global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
      (global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
      (global-set-key (kbd "S-C-<down>") 'shrink-window)
      (global-set-key (kbd "S-C-<up>") 'enlarge-window)
    )
  )
)

;;;##############################################################
;;; darwin settings
;;;##############################################################
(defun my-darwin-conf ()
  ;;;##############################################################
  ;;; mac default settings
  ;;;##############################################################
  ;; To enable sRGB
  (setq ns-use-srgb-colorspace t)
  
  ;; key bindings
  ;(setq mac-option-modifier 'super)
  ;(setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'meta)
  (define-key global-map [home] 'beginning-of-line)
  (define-key global-map [end] 'end-of-line)
  (define-key global-map [help] 'overwrite-mode)
  (define-key global-map [S-help] 'clipboard-yank)

  ; unset unused keys
  (global-unset-key (kbd "S-SPC")) ; switch input method

  ;; path
  (setq brew-bin-path "/usr/local/bin/")
  ;; add brew path
  (add-to-list 'exec-path brew-bin-path)
  ;; shell-command-to-string error
  (setenv "PATH" 
          (concat brew-bin-path ":"
                  (getenv "PATH"))
  )
  (setenv "GOPATH" "/Users/hyoyoung/local/go")
  ;; add brew path to eshell's path
  (add-hook 'eshell-mode-hook
     '(lambda nil
     (setq eshell-path-env (concat brew-bin-path ":" eshell-path-env)))
  )
)

;;;##############################################################
;;; jump to each conf functions
;;;##############################################################
(cond
  ((string-equal system-type "darwin")   ; Mac OS X
    (progn
      (setq my-frame-height 45)
      (setq my-frame-width 180)
      (setq my-font-height 140)

      (my-darwin-conf)
    )
  )
  ((string-equal system-type "gnu/linux") ; linux
    (progn
      ;;;##############################################################
      ;;; linux default settings
      ;;;##############################################################
      (setq my-frame-x 20)
      (setq my-frame-y 20)
      (setq my-frame-height 40)
      (setq my-frame-width 135)
      (setq my-font-height 85)

      (my-linux-conf)
    )
  )
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
(add-hook 'before-make-frame-hook 'custom-set-frame-size)

;;;##############################################################
;;; font conf
;;;##############################################################

;; default Latin font (e.g. Consolas)
;(set-face-attribute 'default nil :family "Consolas")

;; default font size (point * 10)
;;
;; WARNING!  Depending on the default font,
;; if the size is not supported very well, the frame will be clipped
;; so that the beginning of the buffer may not be visible correctly. 
(if (boundp 'my-font-height)
  (set-face-attribute 'default nil :height my-font-height))

;; use specific font for Korean charset.
;; if you want to use different font size for specific charset,
;; add :size POINT-SIZE in the font-spec.
;; (set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding"))

;;;##############################################################
;;; package managers
;;;##############################################################
  
(require 'package)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
  
;;;##############################################################
;;; package managers - el-get
;;;##############################################################
  
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(el-get 'sync)
  
;;;##############################################################
;;; load site-lisp
;;;#############################################################
(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'custom-theme-load-path
  (file-name-as-directory "~/.emacs.d/site-lisp/midnight-dawn-theme"))
;; https://github.com/emacs-jp/replace-colorthemes
;(add-to-list 'custom-theme-load-path
;  (file-name-as-directory "~/.emacs.d/site-lisp/replace-colorthemes"))
;; https://github.com/ChrisKempson/Tomorrow-Theme
;(add-to-list 'custom-theme-load-path
;  (file-name-as-directory "~/.emacs.d/site-lisp/tomorrow-theme"))

;;;##############################################################
;;; global setting
;;;##############################################################
(setq column-number-mode t)
(display-time)
(defalias 'yes-or-no-p 'y-or-n-p)       ; use y/n instead of yes/no
(show-paren-mode t) ; turn on paren match highlighting
;(setq show-paren-style 'expression) ; highlight entire bracket expression
(setq show-paren-style 'mixed) 

;; show file size
(size-indication-mode)

;; turn off word wrap
;(setq default-truncate-lines t)

;(setq-default indent-tabs-mode nil)    ; prevent Extraneous Tabs
(icomplete-mode)                        ; incremental minibuffer completion
(auto-compression-mode t)               ; auto handling with zipped files

;InteractivelyDoThings mode to auto complete in minibuffer
(require 'ido)
(ido-mode t)

;;; Smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; font-lock-mode
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

; enable color in console mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Display line number on the left
;(global-linum-mode t)
;;(set-face-attribute 'linum nil :background "#222")
;(setq linum-format "%4d\u2502")

(setq initial-buffer-choice t)

; for mule
(define-coding-system-alias 'utf8 'utf-8)

;;;##############################################################
;;; load theme
;;;#############################################################
;(load-theme 'tomorrow-night-dawn t)
(load-theme 'midnight-dawn t)

;;;##############################################################
;;; 프로그래밍 모드
;;;##############################################################

; flymake done right for syntax checking
;(add-hook 'after-init-hook #'global-flycheck-mode)

;;;##############################################################
;;; 프로그래밍 모드 - python
;;;##############################################################
;;; ref : http://caisah.info/emacs-for-python/

(add-hook 'python-mode-hook
  (lambda ()
    (setq indent-tabs-mode nil)
    (setq default-tab-width 4)
    (setq python-indent-offset 4) 
    (setq show-trailing-whitespace t)))

;(setq jedi:environment-virtualenv
;      (list "pyvenv-3.6" "--system-site-packages"))
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

;; ipython
(setq
  python-shell-interpreter "ipython"
  python-shell-interpreter-args ""
  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
  python-shell-completion-setup-code
    "from IPython.core.completerlib import module_completion"
  python-shell-completion-module-string-code
    "';'.join(module_completion('''%s'''))\n"
  python-shell-completion-string-code
    "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

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

; go get golang.org/x/tools/cmd/guru
(require 'go-guru)

(defun my-go-mode-hook ()
  ;; prefer goimports, if present
  (if (executable-find "goimports")
    (setq gofmt-command "goimports"))

  (add-hook 'before-save-hook 'gofmt-before-save)

  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))

  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark))

  (go-eldoc-setup)
  (setq exec-path (append exec-path '("~/local/go/bin/")))
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (setq show-trailing-whitespace t)
(add-hook 'go-mode-hook 'my-go-mode-hook)

;github.com/stamblerre/gocode
(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

(with-eval-after-load 'go-mode
   (require 'go-autocomplete))

(add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)


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
;; sr-speedbar
;;;##############################################################

;it's removed in emacs24 - copied from http://www.emacswiki.org/emacs/SrSpeedbar
(defun ad-advised-definition-p (definition) 
  "Return non-nil if DEFINITION was generated from advice information."
  (if 
    (or (ad-lambda-p definition) 
      (macrop definition)
      (ad-compiled-p definition))
    (let ((docstring (ad-docstring definition)))
      (and (stringp docstring) 
        (get-text-property 0 ‘dynamic-docstring-function docstring)))))

(require 'sr-speedbar)
;(global-set-key (kbd "s-s") 'sr-speedbar-toggle)
(setq speedbar-hide-button-brackets-flag t)
(setq speedbar-show-unknown-files t)
(setq speedbar-smart-directory-expand-flag t)
(setq speedbar-use-images nil)
(setq sr-speedbar-skip-other-window-p t)
(setq sr-speedbar-max-width 15)
(setq sr-speedbar-width 15)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width-console 10)

(when window-system
  (defadvice sr-speedbar-open (after sr-speedbar-open-resize-frame activate)
    (set-frame-width (selected-frame)
                     (+ (frame-width) sr-speedbar-width)))
  (ad-enable-advice 'sr-speedbar-open 'after 'sr-speedbar-open-resize-frame)

  (defadvice sr-speedbar-close (after sr-speedbar-close-resize-frame activate)
    (sr-speedbar-recalculate-width)
    (set-frame-width (selected-frame)
                     (- (frame-width) sr-speedbar-width)))
  (ad-enable-advice 'sr-speedbar-close 'after 'sr-speedbar-close-resize-frame))

(add-hook 'speedbar-mode-hook' (lambda () (linum-mode -1)))

(when window-system          ; start speedbar if we're using a window system
  (sr-speedbar-open))

(when window-system
  (with-current-buffer sr-speedbar-buffer-name
    (setq window-size-fixed 'width)))

(setq cursor-in-non-selected-windows nil)

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
(add-hook 'isearch-mode-hook 'my-isearch-yank-word-hook)
;(global-set-key [f9] 'my-isearch-word-at-point)
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
;(global-set-key (kbd "<M-left>") 'highlight-symbol-next)
;(global-set-key (kbd "<M-right>") 'highlight-symbol-prev)
(setq highlight-symbol-on-navigation-p t)

(when window-system
  ;(setq highlight-symbol-idle-delay 0.5)
  (dolist (hook '(emacs-lisp-mode-hook lisp-interaction-mode-hook java-mode-hook
                   c-mode-common-hook python-mode-hook ruby-mode-hook html-mode-hook
                   go-mode-hook
                   sh-mode-hook Info-mode-hook))
    (add-hook hook 
      (lambda ()
        ;(highlight-symbol-mode t)
        (highlight-symbol-nav-mode t)))))

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
        (kill-word arg)))
      ))
(global-set-key (kbd "C-d") 'kill-word-vi-style)

;;---
;; http://www.emacswiki.org/emacs/ParenthesisMatching
(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert %.
vi style of % jumping to matching brace."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
(global-set-key "%" 'goto-match-paren)

(defun top-join-line ()
  "Join the following line with current line"
  (interactive)
  (delete-indentation 1))
(global-set-key (kbd "C-^") 'top-join-line)

;;;##############################################################
;;; misc
;;;#############################################################
(require 'tramp)
(setq tramp-default-method "ssh")
;(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
;(setq tramp-debug-buffer t)
;(setq tramp-verbose 10)

; unset unused keys
(global-unset-key "\C-x\C-n") ; set-goal-column
(when window-system (global-unset-key "\C-z")) ; don't minize
(global-unset-key "\C-x\C-z") ; don't suspend
;(global-unset-key "\C-xz") ; don't repeat

;; auto save when lose input focus
;(add-hook 'focus-out-hook 'save-buffer)
(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))

;show empty lines
;(setq-default indicate-empty-lines t)
;(when (not indicate-empty-lines)
;  (toggle-indicate-empty-lines))

;(require 'w3m)
;(setq w3m-use-cookies t)
;(setq w3m-default-display-inline-images t)

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
   (quote
    (go-guru go-autocomplete flycheck-golangci-lint go-eldoc go-mode popup 0xc w3m org jedi fuzzy flycheck f))))

; https://github.com/purcell/exec-path-from-shell
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
