(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(buffers-menu-show-status nil)
 '(cursor-type 'bar)
 '(custom-enabled-themes '(monokai))
 '(custom-safe-themes
   '("78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" default))
 '(menu-bar-mode nil)
 '(menu-prompting nil)
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
	 ("melpa" . "https://melpa.org/packages/")))
 '(package-selected-packages
   '(projectile ac-html company auctex pdf-tools csharp-mode sublimity minimap monokai-theme))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun fontify-frame (frame)
  (set-frame-parameter frame 'font "Source Code Pro SemiBold-11"))
;; Fontify current frame
(fontify-frame nil)
;; Fontify any future frames
(push 'fontify-frame after-make-frame-functions)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; To manipulate the idetnation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4) ; Assuming you want your tabs to be four spaces wide
(custom-set-variables
 '(tab-width 4))
(defvaralias 'c-basic-offset 'tab-width)
(setq c-guess-make-basic-offset t)
(setq c-guess-guessed-basic-offset-verbose nil)
(setq js-indent-level 4)
(setq sgml-basic-offset 4)
(setq python-indent-guess-indent-offset t)
(setq python-indent-guess-indent-offset-verbose nil)

;; To delete the highlights
(setq-default show-paren-mode nil)
(setq-default show-paren-delay 0)


;; To enable column numbers
(setq line-number-mode t)
(setq column-number-mode t)


;; To autocomplete brackets
(electric-pair-mode)


;; To hide the started screen of emacs 
(setq inhibit-startup-screen t)

;; To add the smoth minimap
(add-to-list 'load-path "/path/to/.emacs.d/sublimity/")
(require 'sublimity)
(require 'sublimity-scroll)
(require 'sublimity-map)

;; To disable the backups files
(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq auto-save-default nil)

;; To enable the autocomplete
(require 'use-package)

;; To be able to use pdf 
(use-package pdf-tools
   :pin manual
   :config
   (pdf-tools-install)
   (setq-default pdf-view-display-size 'fit-width)
   (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
   :custom
   (pdf-annot-activate-created-annotations t "automatically annotate highlights"))

(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
      TeX-source-correlate-start-server t)

(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)

;; To disable the control z
(global-set-key (kbd "C-z") 'undo)



;; To rewrite a buffer or file name
;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

;; Here we add the short cut
(global-set-key (kbd "C-x r")  #'rename-file-and-buffer)


;; To put able the autocomplete
(add-hook 'after-init-hook 'global-company-mode)


;; To make more slower the mouse scroll 
(setq mouse-wheel-progressive-speed nil)



;; To autocomplete html
(defun setup-ac-for-haml ()
  ;; Require ac-haml since we are setup haml auto completion
  (require 'ac-haml)
  ;; Require default data provider if you want to use
  (require 'ac-html-default-data-provider)
  ;; Enable data providers,
  ;; currently only default data provider available
  (ac-html-enable-data-provider 'ac-html-default-data-provider)
  ;; Let ac-haml do some setup
  (ac-haml-setup)
  ;; Set your ac-source
  (setq ac-sources '(ac-source-haml-tag
                     ac-source-haml-attr
                     ac-source-haml-attrv))
  ;; Enable auto complete mode
  (auto-complete-mode))

(add-hook 'haml-mode-hook 'setup-ac-for-haml)

;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(80 . 80))
(add-to-list 'default-frame-alist '(alpha . (80 . 80)))

