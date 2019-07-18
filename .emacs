(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(show-paren-mode t)
(setq show-paren-style 'expression)
(setq ido-enable-flex-matching t
      ido-everywhere t)
(ido-mode 1)

(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (web-mode alchemist apache-mode boxquote buffer-flip buffer-move colormaps column-enforce-mode com-css-sort csv csv-mode dad-joke dired-imenu distel-completion-lib docean docker-api docker-cli docker-compose-mode edbi edbi-minor-mode edts elm-mode emamux erlang filladapt fontawesome gh gh-md gitlab ido-hacks jinja2-mode jsonrpc magit markdown-mode markdown-mode+ markdown-preview-mode open-junk-file pg php-mode python python-mode restclient restclient-test salt-mode scss-mode tramp yaml-mode dockerfile-mode docker))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
