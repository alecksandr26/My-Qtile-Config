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
 '(package-selected-packages
   '(cython-mode multi-vterm projectile iedit yasnippet-snippets yasnippet auto-complete-c-headers auto-complete company))
 '(scroll-bar-mode nil)
 '(tab-width 4)
 '(tool-bar-mode nil))


;; To hide the started screen of emacs
(setq inhibit-startup-screen t)


(defun fontify-frame (frame)
  (set-frame-parameter frame 'font "Source Code Pro SemiBold-10"))
;; Fontify current frame
(fontify-frame nil)
;; Fontify any future frames
(push 'fontify-frame after-make-frame-functions)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)


;; To make more slower the mouse scroll
(setq mouse-wheel-progressive-speed nil)


;; To manipulate the idetnation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4) ; Assuming you want your tabs to be four spaces wide

(defvaralias 'c-basic-offset 'tab-width)
(setq c-guess-make-basic-offset t)
(setq c-guess-guessed-basic-offset-verbose nil)
(setq js-indent-level 4)
(setq sgml-basic-offset 4)
(setq python-indent-guess-indent-offset t)
(setq python-indent-guess-indent-offset-verbose nil)


;; Desactivate the backup files
(setq make-backup-files nil)
(setq auto-save-default nil) ; stop creating #autosave# files
(put 'erase-buffer 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Load the monokai theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai t)

;; To autocomplete brackets
(electric-pair-mode)

;; start package.el with emacs
(require 'package)
;; add MELPA to repository list
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
;; initialize package.el
(package-initialize)

;; Here I start my packages



;; start auto-complete
(require 'auto-complete)
;; do default config for auto-compelte
(require 'auto-complete-config)
(ac-config-default)

;; To active the company
;; (add-hook 'after-init-hook 'global-company-mode)

(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)

(yas-global-mode 1)

;; define iedit variable
(define-key global-map (kbd "C-x ;") 'iedit-mode)


;; Lets start projectile
(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; my projects paths
(setq projectile-project-search-path '("~/Documents/projects/"))


;; start neotree
(add-to-list 'load-path "~/.emacs.d/neotree/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)


;; adding vterm
(add-to-list 'load-path "~/.emacs.d/emacs-libvterm")
(require 'vterm)



;; lets define the auto-complete-c-headers 
(defun my:ac-c-headers-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/local/include")
  )
;; now lets call this function
(add-hook 'c++-mode-hook 'my:ac-c-headers-init)
(add-hook 'c-mode-hook 'my:ac-c-headers-init)

