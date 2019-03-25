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
      (setq-local company-flow-exeuctable flow)
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
  ;; (setq company-backends-js2-mode '(company-flow company-tern
  ;;                                                (company-dabbrev-code company-gtags company-etags company-keywords)
  ;;                                                company-files company-dabbrev))
  ;; (setq company-backends-js2-mode '(company-flow company-tern
  ;;                                                (company-dabbrev-code company-gtags company-etags company-keywords)
  ;;                                                company-files company-dabbrev))
  ;; (setq company-backends-react-mode '(company-flow company-tern
  ;;                                                  (company-dabbrev-code company-gtags company-etags company-keywords)
  ;;                                                  company-files company-dabbrev))

  ;; (add-hook 'js-mode-hook 'company-force-flow)
  ;; (add-hook 'rjsx-mode-hook 'company-force-flow)
  ;;(add-hook 'react-mode-hook 'company-force-flow)
  (setq company-backends-web-mode '(company-psc-ide-backend company-flow company-bbdb company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files
                                                            (company-dabbrev-code company-gtags company-etags company-keywords)
                                                            company-oddmuse company-dabbrev)))
;; company-tern
;;(company-dabbrev-code company-gtags company-etags company-keywords)
;;company-files company-dabbrev)))
