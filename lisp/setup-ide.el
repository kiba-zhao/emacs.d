(use-package web-mode
  :ensure t
  :mode ("\\.html\\'" "\\.htm\\'")
  :config
  (message "config web-mode"))

(use-package yaml-mode
  :ensure t
  :mode ("\\.yml\\'")
  :config
  (message "config yaml-mode"))

(use-package json-mode
  :ensure t
  :mode ("\\.json\\'")
  :config
  (message "config json-mode"))

(use-package typescript-mode
  :ensure t
  :mode ("\\.ts\\'")
  :interpreter "typescript"
  :config
  (message "config typescript-mode")
  :init
  (setq typescript-indent-level 2))

(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'")
  :interpreter "javascript"
  :config
  (message "config js2-mode")
  :init
  (setq js2-basic-offset 2)
  (setq js-indent-level 2))

;; base
(use-package yasnippet-snippets
  :ensure t
  :config
  (message "config yasnippet-snippets")
  (add-to-list 'yas-snippet-dirs (expand-file-name "snippets" user-emacs-directory) t))

(use-package yasnippet
  :ensure t
  :hook ((typescript-mode . yas-minor-mode)
         (json-mode . yas-minor-mode)
         (yaml-mode . yas-minor-mode)
         (web-mode . yas-minor-mode)
         (js2-mode . yas-minor-mode))
  :after (yasnippet-snippets)
  :config
  (message "config yasnippet")
  (yas-reload-all))

(use-package flycheck
  :ensure t
  :hook ((typescript-mode . flycheck-mode)
         (json-mode . flycheck-mode)
         (yaml-mode . flycheck-mode)
         (web-mode . flycheck-mode)
         (js2-mode . flycheck-mode))
  :config
  (message "config flycheck"))

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :after (flycheck which-key)
  :hook ((typescript-mode . lsp)
         (js2-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  (message "config lsp-mode")
  (setq lsp-enabled-clients '(ts-ls json-ls))
  (with-eval-after-load 'js
    (define-key js-mode-map (kbd "M-.") nil))
  :commands lsp)

(use-package dap-mode
  :ensure t
  :hook (lsp-mode . dap-mode)
  :after (hydra)
  :config
  (message "config dap-mode")
  (add-hook 'dap-stopped-hook
          (lambda (arg) (call-interactively #'dap-hydra)))
  (require 'dap-node)
  (dap-node-setup))

(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (message "config company-mode"))

(use-package which-key
  :ensure t
  :config
  (message "config which-key")
  (which-key-mode))

(use-package projectile
  :ensure t
  :config
  (message "config projectile"))

(provide 'setup-ide)
