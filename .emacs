;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(load "~/.emacs.d/init-packages")

;; Used in zsh theme to set an appropriate prompt.
(setenv "EMACS" "true")

;; Appearance
(load-theme 'cyberpunk t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-message t
      ring-bell-function (lambda ()))

;; Spaces and Columns and Tabs...
(column-enforce-mode)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(add-to-list 'completion-ignored-extensions ".#")

(require 'window-number)
(window-number-mode 1)

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

(require 's)

;; Key Bindings
(global-set-key "\M-`" 'other-frame)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-xj" 'open-junk-file)
(define-key input-decode-map "\e\eOA" [(meta up)])
(define-key input-decode-map "\e\eOB" [(meta down)])
(global-set-key [(meta down)] 'forward-paragraph)
(global-set-key [(meta up)] 'backward-paragraph)
(global-set-key (kbd "C-c C-f") 'eshell)
(global-set-key (kbd "C-c C-j") 'join-line)

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

;; eshell

(setenv "PAGER" "cat")
(use-package eshell
  :init
  (setq eshell-scroll-to-bottom-on-input 'all
        eshell-error-if-no-glob t
        eshell-hist-ignoredups t
        eshell-save-history-on-exit t
        eshell-prefer-lisp-functions nil
        eshell-destroy-buffer-when-process-dies t))

(add-hook 'eshell-mode-hook
          (lambda ()
            (eshell/alias "e" "find-file $1")
            (eshell/alias "ff" "find-file $1")
            (eshell/alias "emacs" "find-file $1")
            (eshell/alias "ee" "find-file-other-window $1")
            
            (eshell/alias "gd" "magit-diff-unstaged")
            (eshell/alias "gds" "magit-diff-staged")
            (eshell/alias "d" "dired $1")
            
            ;; The 'ls' executable requires the Gnu version on the Mac
            (let ((ls (if (file-exists-p "/usr/local/bin/gls")
                          "/usr/local/bin/gls"
                        "/bin/ls")))
              (eshell/alias "ll" (concat ls " -AlohG --color=always")))))

(defun eshell/gst (&rest args)
  (magit-status (pop args) nil)
  (eshell/echo))

(defun curr-dir-git-branch-string (pwd)
  "Returns current git branch as a string, or the empty string if
PWD is not in a git repo (or the git command is not found)."
  (interactive)
  (when (and (not (file-remote-p pwd))
             (eshell-search-path "git")
             (locate-dominating-file pwd ".git"))
    (let* ((git-url (shell-command-to-string
                     "git config --get remote.origin.url"))
           (git-repo (file-name-base (s-trim git-url)))
           (git-output (shell-command-to-string
                        (concat "git rev-parse --abbrev-ref HEAD")))
           (git-branch (s-trim git-output))
           (git-clean `(:foreground "green"))
           (git-dirty `(:foreground "red"))
           (git-face `(:foreground "brightblack"))
           (git-separator
            (if (equal (shell-command-to-string "git status -s") "")
                (propertize "·" 'face git-clean)
              (propertize "·" 'face git-dirty))))
      (concat (propertize "«" 'face git-face)
              (propertize git-repo 'face git-face)
              git-separator
              (propertize git-branch 'face git-face)
              (propertize "»" 'face git-face)))))

(defun pwd-replace-home (pwd)
  "Replace home in PWD with tilde (~) character."
  (interactive)
  (let* ((home (expand-file-name (getenv "HOME")))
         (home-len (length home)))
    (if (and
         (>= (length pwd) home-len)
         (equal home (substring pwd 0 home-len)))
        (concat "~" (substring pwd home-len))
      pwd)))

(defun pwd-shorten-dirs (pwd)
  "Shorten all directory names in PWD except the last two."
  (let ((p-lst (split-string pwd "/")))
    (if (> (length p-lst) 2)
        (concat
         (mapconcat (lambda (elm) (if (zerop (length elm)) ""
                                    (substring elm 0 1)))
                    (butlast p-lst 2)
                    "/")
         "/"
         (mapconcat (lambda (elm) elm)
                    (last p-lst 2)
                    "/"))
      pwd)))

(defun split-directory-prompt (directory)
  (if (string-match-p ".*/.*" directory)
      (list (file-name-directory directory) (file-name-base directory))
    (list "" directory)))

(defun eshell/eshell-local-prompt-function ()
  (interactive)
  (let* ((pwd (eshell/pwd))
          (directory (split-directory-prompt
                      (pwd-shorten-dirs
                       (pwd-replace-home pwd))))
          (parent (car directory))
          (name (cadr directory))
          (branch (curr-dir-git-branch-string pwd))
          (dark-env (eq 'dark (frame-parameter nil 'background-mode)))
          (for-bars                 `(:weight bold))
          (for-parent  (if dark-env
                           `(:foreground "dark orange")
                         `(:foreground "blue")))
          (for-dir     (if dark-env
                           `(:foreground "orange" :weight bold)
                         `(:foreground "blue" :weight bold)))
          (for-git    `(:foreground "green")))
    (concat
     (propertize parent 'face for-parent)
     (propertize name   'face for-dir)
     (when branch
       (concat (propertize "·" 'face for-bars) branch))
;               (propertize branch 'face for-git))) 
     (propertize ": " 'face for-bars))))

(setq-default eshell-prompt-function #'eshell/eshell-local-prompt-function)
(setq eshell-highlight-prompt nil)

(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(bind-key (kbd "C-c C-h") 'eshell-here)

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
    (mmm-mode use-package window-number cyberpunk-theme dired-rainbow web-mode alchemist apache-mode boxquote buffer-flip buffer-move colormaps column-enforce-mode com-css-sort csv csv-mode dad-joke dired-imenu distel-completion-lib docean docker-api docker-cli docker-compose-mode edbi edbi-minor-mode edts elm-mode emamux erlang filladapt fontawesome gh gh-md gitlab ido-hacks jinja2-mode jsonrpc magit markdown-mode markdown-mode+ markdown-preview-mode open-junk-file pg php-mode python python-mode restclient restclient-test salt-mode scss-mode tramp yaml-mode dockerfile-mode docker))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "color-172" :slant italic))))
 '(vertical-border ((t (:background "#000000" :foreground "#aaa"))))
 '(window-number-face ((t (:background "black" :foreground "red"))) t))
