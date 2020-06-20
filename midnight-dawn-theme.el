;;; midnight-dawn-theme.el --- midnight theme

;; Copyright (C) 2000 by Gordon Messmer
;; Copyright (C) 2013 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>
;; URL: https://github.com/emacs-jp/replace-colorthemes
;; Version: 0.01

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Port of midnight theme from `color-themes'

;;; Code:

(deftheme midnight-dawn
  "midnight-dawn theme")

(custom-theme-set-faces
 'midnight-dawn

 ;'(default ((t (:background "black" :foreground "grey85"))))
 '(default ((t (:background "black" :foreground "#d3d7cf"))))
 '(mouse ((t (:foregound "grey85"))))
 '(cursor ((t (:foregound "grey85"))))

 '(font-lock-comment-face ((t (:italic t :foreground "grey60"))))
 '(font-lock-string-face ((t (:foreground "LightSalmon4"))))
 '(font-lock-keyword-face ((t (:foreground "SteelBlue3"))))
 '(font-lock-warning-face ((t (:bold t :foreground "LightPink"))))
 '(font-lock-constant-face ((t (:foreground "OliveDrab"))))
 '(font-lock-type-face ((t (:foreground "DarkCyan"))))
 '(font-lock-variable-name-face ((t (:foreground "DarkGoldenrod4"))))
 '(font-lock-function-name-face ((t (:foreground "PaleGreen4"))))
 '(font-lock-builtin-face ((t (:foreground "RoyalBlue2"))))
 '(highline-face ((t (:background "grey12"))))
 '(setnu-line-number-face ((t (:background "Grey15" :foreground "White" :bold t))))
 '(show-paren-match-face ((t (:background "grey30"))))
 '(highlight ((t (:background "gray72" :foreground "black" :weight bold))))
 '(region ((t (:background "#525353" :foreground "darkgray"))))
;'(highlight ((t (:background "blue"))))
;'(region ((t (:background "grey18"))))
 '(secondary-selection ((t (:background "navy"))))
 '(widget-field-face ((t (:background "navy"))))
 '(widget-single-line-field-face ((t (:background "royalblue"))))

 '(link ((t (:foreground "#729fcf" :underline t))))
 '(link-visited ((t (:underline t :foreground "#3465a4"))))
 ;'(gui-element ((t (:background "#2a2a2a" :foreground "#2a2a2a"))))
 
 '(minibuffer-prompt ((t (:foreground "CadetBlue3"))))

 '(mode-line ((t (:background "grey30" :foreground "#d3d7cf" :height 0.9))))
 '(mode-line-inactive ((t (:background "#2a2a2a" :foreground "#d3d7cf" :height 0.9))))
 '(mode-line-buffer-id ((t (:background nil :foreground "#c397d8" :height 0.9)))) 
 '(mode-line-emphasis ((t (:bold t :weight bold))))
 '(mode-line-highlight ((t (:foreground "#c397d8" :box nil :weight bold))))

 '(ido-subdir ((t (:foreground "PaleVioletRed3"))))

 '(speedbar-button-face ((t (:foreground "PaleGreen4"))))
 '(speedbar-directory-face ((t (:foreground "royalblue"))))
 '(speedbar-file-face ((t (:foreground "cyan4"))))
 '(speedbar-highlight-face ((t (:background "green4"))))
 '(speedbar-selected-face ((t (:foreground "PaleVioletRed4" :underline t))))
 '(speedbar-tag-face ((t (:foreground "brown"))))

 '(company-preview ((t (:foreground "darkgray" ::underline t))))
 '(company-preview-common ((t (:inherit company-preview))))
 '(company-scrollbar-bg ((t (:background "gray13" :foreground "darkgray"))))
 '(company-scrollbar-fg ((t (:background "darkgray" :foreground "gray13"))))
 '(company-tooltip ((t (:background "gray13" :foreground "darkgray"))))
 '(company-tooltip-common ((((type x)) (:inherit company-tooltip :weight bold)) (t (:inherit company-tooltip))))
 '(company-tooltip-selection ((t (:background "steelblue" :foreground "darkgray"))))
 '(company-tooltip-common-selection ((((type x)) (:inherit company-tooltip-selection :weight bold)) (t (:inherit company-tooltip-selection))))
 '(company-tooltip-annotation ((t (:foreground "gray31" :weight bold))))

)

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'midnight-dawn)

;;; midnight-dawn-theme.el ends here
