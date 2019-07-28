(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(setq package-list
      '(mmm-mode use-package window-number cyberpunk-theme
        dired-rainbow web-mode alchemist apache-mode boxquote buffer-flip
        buffer-move colormaps column-enforce-mode com-css-sort csv csv-mode
        dad-joke dired-imenu distel-completion-lib docean docker-api docker-cli
        docker-compose-mode edbi edbi-minor-mode edts elm-mode emamux erlang
        filladapt fontawesome gh gh-md gitlab ido-hacks jinja2-mode jsonrpc
        magit markdown-mode markdown-mode+ markdown-preview-mode open-junk-file
        pg php-mode python python-mode restclient restclient-test salt-mode
        scss-mode tramp yaml-mode dockerfile-mode docker))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
