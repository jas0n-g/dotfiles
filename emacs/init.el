(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))
(cua-mode t)
(use-package undo-tree :config (global-undo-tree-mode 1))
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

(use-package evil-tutor)
;; general keybinds
(evil-set-leader 'normal (kbd "<SPC>"))
(evil-define-key 'normal 'global (kbd "<leader>e") 'eshell)
(evil-define-key 'normal 'global (kbd "<leader>s") 'save-buffer)
(evil-define-key 'normal 'global (kbd "<leader>QQ") 'save-buffers-kill-emacs)
(evil-define-key 'normal 'global (kbd "<leader>mx") 'execute-extended-command)
(evil-define-key 'normal 'global (kbd "<leader>;") 'execute-extended-command)
(evil-define-key 'normal 'global (kbd "<leader>vb") 'evil-visual-block)

;; window management
(evil-define-key 'normal 'global (kbd "<leader>wh") 'evil-window-left)
(evil-define-key 'normal 'global (kbd "<leader>wj") 'evil-window-down)
(evil-define-key 'normal 'global (kbd "<leader>wk") 'evil-window-up)
(evil-define-key 'normal 'global (kbd "<leader>wl") 'evil-window-right)
(evil-define-key 'normal 'global (kbd "<leader>wH") 'evil-window-move-far-left)
(evil-define-key 'normal 'global (kbd "<leader>wJ") 'evil-window-move-very-bottom)
(evil-define-key 'normal 'global (kbd "<leader>wK") 'evil-window-move-very-top)
(evil-define-key 'normal 'global (kbd "<leader>wL") 'evil-window-move-far-right)
(evil-define-key 'normal 'global (kbd "<leader>wx") 'evil-window-exchange)
(evil-define-key 'normal 'global (kbd "<leader>wd") 'evil-window-delete)
(evil-define-key 'normal 'global (kbd "<leader>wD") 'kill-buffer-and-window)
(evil-define-key 'normal 'global (kbd "<leader>wn") 'evil-window-new)
(evil-define-key 'normal 'global (kbd "<leader>we") '(lambda () (interactive) (evil-window-vsplit) (eshell)))
(evil-define-key 'normal 'global (kbd "C--") 'evil-window-decrease-height)
(evil-define-key 'normal 'global (kbd "C-=") 'evil-window-increase-height)
(evil-define-key 'normal 'global (kbd "C-,") 'evil-window-decrease-width)
(evil-define-key 'normal 'global (kbd "C-.") 'evil-window-increase-width)

;; buffer management
(evil-define-key 'normal 'global (kbd "<leader>bb") 'buffer-menu)
(evil-define-key 'normal 'global (kbd "<leader>bn") 'next-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bp") 'prev-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bd") 'kill-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bD") 'kill-buffer-and-window)

;; CUA mode
(evil-define-key 'normal 'global (kbd "C-v") 'evil-visual-block)
(evil-define-key 'insert 'global (kbd "C-v") 'cua-paste)
(evil-define-key 'insert 'global (kbd "C-x") 'cua-cut-region)
(evil-define-key 'insert 'global (kbd "C-c") 'cua-copy-region)
(evil-define-key 'insert 'global (kbd "C-z") 'undo-tree-undo)
(evil-define-key 'insert 'global (kbd "C-y") 'undo-tree-redo)

(defun my-jk ()
  (interactive)
  (let* ((initial-key ?j)
         (final-key ?k)
         (timeout 0.5)
         (event (read-event nil nil timeout)))
    (if event
        (if (and (characterp event) (= event final-key))
            (evil-normal-state)
          (insert initial-key)
          (push event unread-command-events))
      (insert initial-key))))
(define-key evil-insert-state-map (kbd "j") 'my-jk)
(use-package edit-indirect :ensure t)
(use-package markdown-mode
	:ensure t
	:init (setq markdown-fontify-code-blocks-natively 't)
	:hook (markdown-mode . visual-line-mode)
	      (markdown-mode . display-line-numbers-mode)
		  (markdown-mode . evil-close-folds))
(use-package eshell :ensure t)

(defun epe-fish-path (path &optional max-len)
  "Return a potentially trimmed-down version of the directory PATH.
Replacing parent directories with their initial characters to try
to get the character length of PATH (sans directory slashes) down
to MAX-LEN."
  (let* ((components (split-string (abbreviate-file-name path) "/"))
         (max-len (or max-len 30))
         (len (+ (1- (length components))
                 (cl-reduce '+ components :key 'length)))
         (str ""))
    (while (and (> len max-len)
                (cdr components))
      (setq str (concat str
                        (cond ((= 0 (length (car components))) "/")
                              ((= 1 (length (car components)))
                               (concat (car components) "/"))
                              (t
                               (if (string= "."
                                            (string (elt (car components) 0)))
                                   (concat (substring (car components) 0 2)
                                           "/")
                                 (string (elt (car components) 0) ?/)))))
            len (- len (1- (length (car components))))
            components (cdr components)))
    (concat str (cl-reduce (lambda (a b) (concat a "/" b)) components))))

(setq eshell-prompt-regexp "^.+$"
      eshell-prompt-function
      (lambda nil
	(concat
	 (propertize (epe-fish-path (eshell/pwd) 30) 'face `(:foreground "cornflower blue"))
	 (if (= eshell-last-command-status 0)
	     (propertize " ) " 'face `(:foreground "sea green"))
	   (propertize (format " %s ) " eshell-last-command-status) 'face `(:foreground "firebrick"))))))
(setq eshell-highlight-prompt nil)

(use-package eshell-syntax-highlighting
  :ensure t
  :config
  (eshell-syntax-highlighting-global-mode +1))

(use-package eaf
    :load-path "~/.config/emacs/site-lisp/emacs-application-framework/"
    :custom
    (eaf-browse-blank-page-url "https://duckduckgo.com")
    (eaf-browser-default-search-engine "duckduckgo")
    (eaf-browser-remember-history nil)
    (eaf-browser-enable-adblock t)
    (eaf-browser-dark-mode "force")
    (browse-url-browser-function 'eaf-open-browser)
    :config
    (defalias 'browse-web #'eaf-open-browser))

(require 'eaf-browser)
(load-theme 'wombat)
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(set-face-attribute 'default nil :family "Uiua386Color" :height 125 :weight 'normal)
(set-face-attribute 'fixed-pitch nil :family "Uiua386Color" :height 125 :weight 'normal)
(set-face-attribute 'variable-pitch nil :family "LDFComicSans" :height 125 :weight 'normal)
(set-face-attribute 'line-number nil :inherit 'fixed-pitch :foreground "khaki")
(setq buffer-face-mode-face 'variable-pitch)

;; Markdown fonts
(require 'markdown-mode)
(add-hook 'markdown-mode-hook 'buffer-face-mode)
(add-hook 'markdown-mode-hook 'markdown-toggle-markup-hiding)
(set-face-attribute 'markdown-header-face-1 nil :inherit 'variable-pitch :height 170 :foreground "blue violet")
(set-face-attribute 'markdown-header-face-2 nil :inherit 'variable-pitch :height 165 :foreground "royal blue")
(set-face-attribute 'markdown-header-face-3 nil :inherit 'variable-pitch :height 160 :foreground "sea green")
(set-face-attribute 'markdown-header-face-4 nil :inherit 'variable-pitch :height 155 :foreground "goldenrod")
(set-face-attribute 'markdown-header-face-5 nil :inherit 'variable-pitch :height 150 :foreground "dark orange")
(set-face-attribute 'markdown-header-face-6 nil :inherit 'variable-pitch :height 145 :foreground "firebrick")
(set-face-attribute 'markdown-code-face nil :inherit 'fixed-pitch :background "#25292b" :height 115 :extend t)
(set-face-attribute 'mode-line-inactive nil :underline t :background "white" :foreground "white" :height 1)
(set-face-attribute 'mode-line nil :inherit 'fixed-pitch :background "blue violet" :foreground "white" :height 150)

(setq-default mode-line-format (list (quote ("%e [ <%b> | <%*> |" evil-mode-line-tag "| <%p %l:%c> ]"))))