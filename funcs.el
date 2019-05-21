;; web mode

(defun spacemacs//flow-customize-web-mode ()
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-attr-indent-offset 2)
  (add-to-list 'auto-mode-alist '("\\.js[x]?\\'" . web-mode))
  (setq web-mode-content-types-alist
        '(("jsx" . "\\.js\\'")
          ("jsx" . "\\.jsx\\'"))))

;; flow

(defun spacemacs//flow-use-flow-from-node-modules ()
  (let* ((os (pcase system-type
               ('darwin "osx")
               ('gnu/linux "linux64")
               (_ nil)))
         (root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (global-flow (executable-find "flow"))
         (local-flow (expand-file-name "node_modules/.bin/flow"
                                       root))
         (flow (if (file-executable-p local-flow)
                   local-flow
                 global-flow)))
    (when (and flow (file-executable-p flow))
      (setq-local company-flow-executable flow)
      (setq-local flow-minor-default-binary flow)
      (setq-local flycheck-javascript-flow-executable flow))))

;; flycheck

(defun spacemacs//flow-use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (global-eslint (executable-find "eslint"))
         (local-eslint (expand-file-name "node_modules/.bin/eslint"
                                         root))
         (eslint (if (file-executable-p local-eslint)
                     local-eslint
                   global-eslint)))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))

;; company

;; Thanks to https://github.com/tbinetruy/config/blob/master/spacemacs/flow/flow.el
(defun spacemacs//flow-force-company-flow ()
  (let ((backends '(company-flow)))
    (setq company-backends-web-mode backends)))
