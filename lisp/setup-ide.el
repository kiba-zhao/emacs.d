(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "pandoc"))

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

(use-package go-mode
  :ensure t
  :mode ("\\.go\\'")
  :interpreter "go"
  :config
  (message "config go-mode"))

(use-package typescript-mode
  :ensure t
  :mode ("\\.ts\\'" "\\.tsx\\'")
  :interpreter "typescript"
  :config
  (message "config typescript-mode")
  :init
  (setq typescript-indent-level 2))

(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'" "\\.jsx\\'")
  :interpreter "javascript"
  :config
  (message "config js2-mode")
  :init
  (setq js2-basic-offset 2)
  (setq js-indent-level 2))

(use-package sh-mode
    :mode ("\\.sh\\'")
    :interpreter "shell"
    :config
    (message "config sh-mode"))

(use-package c-mode
    :mode ("\\.c\\'")
    :config
    (message "config c-mode"))

(use-package c++-mode
    :mode ("\\.cpp\\'")
    :config
    (message "config c++-mode"))

;; base
(use-package yasnippet-snippets
  :ensure t
  :config
  (message "config yasnippet-snippets")
  (add-to-list 'yas-snippet-dirs (expand-file-name "snippets" user-emacs-directory) t))

(use-package yasnippet
  :ensure t
  :hook ((typescript-mode . yas-minor-mode)
         (sh-mode . yas-minor-mode)
         (c-mode . yas-minor-mode)
         (c++-mode . yas-minor-mode)
         (go-mode . yas-minor-mode)         
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
         (sh-mode . flycheck-mode)
         (c-mode . flycheck-mode)
         (c++-mode . flycheck-mode)
         (go-mode . flycheck-mode)
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
  :hook ((typescript-mode . lsp-deferred)
         (json-mode . lsp-deferred)
         (js2-mode . lsp-deferred)
         (go-mode . lsp-deferred)
         (sh-mode . lsp-deferred)
         (c-mode . lsp-deferred)
         (c++-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  (message "config lsp-mode")
  (with-eval-after-load 'js
    (define-key js-mode-map (kbd "M-.") nil))
  :commands (lsp lsp-deferred))

(use-package lsp-java
  :ensure t
  :hook (java-mode . lsp)
  :after (yasnippet-snippets)
  :config
  (message "config lsp-java"))


;; (use-package lsp-mode
;;   :ensure t
;;   :init
;;   :after (:all (flycheck which-key) (:any go-mode sh-mode c-mode c++-mode))
;;   :hook ((go-mode . lsp)
;;          (sh-mode . lsp)
;;          (c-mode . lsp)
;;          (c++-mode . lsp)
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :config
;;   (message "config lsp-mode")
;;   (setq lsp-clangd-binary-path /usr/bin/clangd)
;;   :commands lsp)

(defun js-setup ()
  (message "setup js")
  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra)))
  (require 'dap-node)
  (dap-node-setup))

(defun clang-setup ()
  (message "setup clang")
  (dap-cpptools-setup)
  (require 'dap-cpptools))

(use-package dap-mode
  :ensure t
  :hook ((typescript-mode .js-setup)
         (js2-mode .js-setup)
         (c++-mode .clang-setup)
         (c-mode .clang-setup))
  :after lsp-mode
  :config
  (message "config dap-mode"))
  
;; (use-package dap-mode
;;   :ensure t
;;   :hook ((c-mode . lsp)
;;          (c++-mode . lsp))
;;   :after (:all (lsp-mode) (:any c++-mode c-mode))
;;   :config
;;   (message "config dap-mode with clang")
;;   (dap-cpptools-setup)
;;   (require 'dap-cpptools))

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

(use-package js-doc
  :after (js2-mode)
  :config
  (message "config js-doc")
 (setq js-doc-mail-address "kiba.rain@qq.com"
       js-doc-author (format "kiba.x.zhao <%s>" js-doc-mail-address)
       js-doc-url "https://github.com/kiba-zhao"
       js-doc-license "MIT"))

(use-package helm
  :ensure t
  :config
  (message "config helm")
  )

(use-package helm-lsp
  :ensure t
  :after (helm)
  :config
  (message "config helm-lsp"))

(use-package helm-xref
  :ensure t
  :after (helm helm-lsp)
  :config
  (message "config helm-xref")
  (define-key global-map [remap find-file] #'helm-find-files)
  (define-key global-map [remap execute-extended-command] #'helm-M-x)
  (define-key global-map [remap switch-to-buffer] #'helm-mini))

;; (use-package eglot
;;   :ensure t
;;   :after (:any c++-mode c-mode)
;;   :hook ((c-mode . eglot-ensure)
;;          (c++-mode . eglot-ensure))
;;   :config
;;   (message "config eglot")
;;   (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd")))

(provide 'setup-ide)
