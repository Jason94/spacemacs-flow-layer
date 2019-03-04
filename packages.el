;;; packages.el --- HTML Layer packages File for Spacemacs

(setq flow-packages
  '(flow-minor-mode
    (company-flow :toggle (configuration-layer/package-usedp 'company))
    (flycheck-flow :toggle (configuration-layer/package-usedp 'flycheck))
    web-mode
    ))

(defun flow/init-flow-minor-mode ()
  (use-package flow-minor-mode
    :defer t))

(defun flow/init-flycheck-flow  ()
  (use-package flycheck-flow
    :defer t))

(defun flow/post-init-flycheck ()
  (with-eval-after-load 'flycheck
    (flycheck-add-mode 'javascript-flow 'flow-minor-mode)
    (flycheck-add-mode 'javascript-eslint 'flow-minor-mode)
    (flycheck-add-next-checker 'javascript-flow 'javascript-eslint))
  (add-hook 'flow-minor-mode-hook #'spacemacs//flow-use-eslint-from-node-modules)
  (spacemacs/add-flycheck-hook 'flow-minor-mode))
  
