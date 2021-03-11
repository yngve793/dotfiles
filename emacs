
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
	 (quote
		("0058b7d3e399b6f7681b7e44496ea835e635b1501223797bad7dd5f5d55bb450" default)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 
;;Font size
(set-face-attribute 'default (selected-frame) :height 100)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(setq-default c-basic-offset 2 c-default-style "linux")
(setq-default tab-width 2 indent-tabs-mode t)

(load-theme 'wombat)

(add-to-list 'load-path
              "~/.emacs.d/elpa/yasnippet-0.8.0")
 
(require 'yasnippet)
(setq yas-snippet-dirs
    '("~/.emacs.d/snippets"                 ;; personal snippets
    	"~/.emacs.d/elpa/yasnippet-0.8.0/snippets"
     ))
(yas-global-mode 1)

(global-linum-mode 1) ; display line numbers in margin. Emacs 23 only.

(show-paren-mode 1) ; turn on paren match highlighting
(setq show-paren-style 'expression) ; highlight entire bracket expression
(electric-pair-mode 1) ; create closed brackets

;;Matlab mode
(add-to-list 'load-path "~/.emacs.d/matlab-emacs")
(require 'matlab-load)
;;(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
;; (add-to-list 
;;	'auto-mode-alist
;;  '("\\.m$" . matlab-mode))
;;(setq matlab-indent-function t)
;;(setq matlab-shell-command "matlab")
