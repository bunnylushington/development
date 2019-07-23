(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Appearance
(load-theme 'cyberpunk t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-message t
      ring-bell-function (lambda ()))

(column-enforce-mode)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(add-to-list 'completion-ignored-extensions ".#")

(defun ii/switch-to-other-buffer ()
    (interactive)
    (switch-to-buffer (other-buffer)))
(global-set-key "\M-\C-l" 'ii/switch-to-other-buffer)

(xterm-mouse-mode 1)

(load "server")
(unless (server-running-p) (server-start))
(setq disabled-command-hook nil)
(setq default-major-mode 'fundamental-mode
      initial-major-mode 'lisp-interaction-mode)



;; Key Bindings
(global-set-key "\M-`" 'other-frame)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-xj" 'open-junk-file)
(define-key input-decode-map "\e\eOA" [(meta up)])
(define-key input-decode-map "\e\eOB" [(meta down)])
(global-set-key [(meta down)] 'forward-paragraph)
(global-set-key [(meta up)] 'backward-paragraph)

;; Parenthesis
(show-paren-mode t)
(setq show-paren-style 'expression)

;; ido Completion
(setq ido-enable-flex-matching t
      ido-everywhere t)
(load-library "ido-hacks")
(ido-mode 1)

;; Whitespace
(require 'whitespace)
(setq whitespace-style '(face lines-tail))
(global-whitespace-mode t)

;; Perl Mode
(defalias 'perl-mode 'cperl-mode)
(setq cperl-invalid-face nil)
(add-to-list 'auto-mode-alist '("\\.pm$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.t$"  . cperl-mode))
(setq auto-mode-alist
      (append auto-mode-alist '(("\\.p[lm]"))))


;; Web Mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.dtl\\'" . web-mode))
(setq web-mode-engines-alist
      '(("django" . "\\.dtl\\'")))

;; Markdown Mode
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

;; Custom Functions
(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(defun now ()
  (interactive)
  (insert (format-time-string "%e-%b-%y %T")))

(defun func-region (start end func)
  "run a function over the region between START and END in current buffer."
  (save-excursion
    (let ((text (delete-and-extract-region start end)))
      (insert (funcall func text)))))

(defun hex-region (start end)
  "urlencode the region between START and END in current buffer."
  (interactive "r")
  (func-region start end #'url-hexify-string))

(defun unhex-region (start end)
  "de-urlencode the region between START and END in current buffer."
  (interactive "r")
  (func-region start end #'url-unhex-string))

;; Custom ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("6bc387a588201caf31151205e4e468f382ecc0b888bac98b2b525006f7cb3307" "8b4d8679804cdca97f35d1b6ba48627e4d733531c64f7324f764036071af6534" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(erlang-indent-level 2)
 '(package-selected-packages
   (quote
    (cyberpunk-theme flatui-dark-theme dired-rainbow color-theme-solarized web-mode alchemist apache-mode boxquote buffer-flip buffer-move colormaps column-enforce-mode com-css-sort csv csv-mode dad-joke dired-imenu distel-completion-lib docean docker-api docker-cli docker-compose-mode edbi edbi-minor-mode edts elm-mode emamux erlang filladapt fontawesome gh gh-md gitlab ido-hacks jinja2-mode jsonrpc magit markdown-mode markdown-mode+ markdown-preview-mode open-junk-file pg php-mode python python-mode restclient restclient-test salt-mode scss-mode tramp yaml-mode dockerfile-mode docker))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
