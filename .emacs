(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Theme
(load-theme 'cyberpunk t)

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


;; Custom ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("6bc387a588201caf31151205e4e468f382ecc0b888bac98b2b525006f7cb3307" "8b4d8679804cdca97f35d1b6ba48627e4d733531c64f7324f764036071af6534" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(package-selected-packages
   (quote
    (cyberpunk-theme flatui-dark-theme dired-rainbow color-theme-solarized web-mode alchemist apache-mode boxquote buffer-flip buffer-move colormaps column-enforce-mode com-css-sort csv csv-mode dad-joke dired-imenu distel-completion-lib docean docker-api docker-cli docker-compose-mode edbi edbi-minor-mode edts elm-mode emamux erlang filladapt fontawesome gh gh-md gitlab ido-hacks jinja2-mode jsonrpc magit markdown-mode markdown-mode+ markdown-preview-mode open-junk-file pg php-mode python python-mode restclient restclient-test salt-mode scss-mode tramp yaml-mode dockerfile-mode docker))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
