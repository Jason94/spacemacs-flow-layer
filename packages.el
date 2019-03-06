;;; packages.el --- HTML Layer packages File for Spacemacs

(setq flow-packages
  '(flow-minor-mode
    web-mode
    flycheck
    (flycheck-flow :toggle (configuration-layer/package-usedp 'flycheck))
    company
    (company-flow :toggle (configuration-layer/package-usedp 'company))
    ))

(defun flow/init-flow-minor-mode ()
  (use-package flow-minor-mode
    :defer t))

(defun flow/post-init-flow-minor-mode ()
  (add-hook 'flow-minor-mode-hook #'spacemacs//flow-use-flow-from-node-modules t))

(defun flow/init-flycheck-flow  ()
  (use-package flycheck-flow))

(defun flow/post-init-flycheck-flow ()
  (with-eval-after-load 'flycheck
    (with-eval-after-load 'flycheck-flow
      (flycheck-add-mode 'javascript-flow 'flow-minor-mode)
      (flycheck-add-mode 'javascript-eslint 'flow-minor-mode)
      (flycheck-add-next-checker 'javascript-flow 'javascript-eslint)))
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint)))
  (add-hook 'flow-minor-mode-hook #'spacemacs//flow-use-eslint-from-node-modules)
  (spacemacs/add-flycheck-hook 'flow-minor-mode))

(defun flow/post-init-web-mode ()
  (add-hook 'web-mode-hook 'flow-minor-enable-automatically)
  (spacemacs/add-flycheck-hook 'web-mode)
  (spacemacs//flow-customize-web-mode))

(defun flow/post-init-company ()
  (spacemacs|add-company-hook flow-minor-mode))

(defun flow/init-company-flow ()
  (use-package company-flow))

(defun flow/post-init-company-flow ()
  (add-to-list 'company-backends 'company-flow)
  (add-to-list 'company-flow-modes 'web-mode)
  (add-hook 'web-mode-hook #'spacemacs//flow-force-company-flow))


