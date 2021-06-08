;; 主题
(use-package zenburn-theme
  :ensure t
  :config
  ;; 默认设置
  (setq-default indent-tabs-mode nil)
  (setq default-tab-width 2)
  (desktop-save-mode 1)
  (global-auto-revert-mode t)
  (global-linum-mode)
  (load-theme 'zenburn t)
  (message "zenburn-theme"))

(use-package hydra
  :ensure t
  :config
  (message "config hydra")
  (require 'def-hydra))

  ;; (defhydra hydra-zoom (global-map "<f2>")
  ;;   "zoom"
  ;;   ("g" text-scale-increase "in")
  ;;   ("l" text-scale-decrease "out"))

(provide 'setup-basic)
