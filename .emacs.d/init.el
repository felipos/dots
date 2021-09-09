;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                            ("org" . "https://orgmode.org/elpa/")
                            ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
    (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
    (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ivy-mode t)
 '(package-selected-packages
   '(vterm visual-fill-column org-bullets magit hydra
     evil-collection evil general counsel ivy-rich doom-themes which-key
     rainbow-delimiters doom-modeline ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)          ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

(set-face-attribute 'default nil :font "InconsolataGo Nerd Font Mono" :height 140)

(load-theme 'wombat)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Numbering lines
(column-number-mode)

;; Enable line numbers for some modes
(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda ()
                   (display-line-numbers-mode 1)
                   (setq display-line-numbers 'relative))
                  )
)

;; Override some modes which derive from the above
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :demand t
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         ;; ("C-M-j" . counsel-switch-buffer)
         ("C-M-l" . counsel-imenu)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

; enabling fuzzy matching
(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))

; enable prompt selection to be able to create everynote in org-roam
(setq ivy-use-selectable-prompt t)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-dracula t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-dracula") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(defun reload-initel ()
  (interactive)
  (load-file user-init-file)
)

(global-set-key (kbd "<f12>") 'reload-initel)

(use-package general
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

(rune/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
))

(general-define-key
 "C-M-j" 'counsel-switch-buffer)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

; save buffer with shift+w
(define-key evil-normal-state-map (kbd "W") 'save-buffer)

; open buffer list with ,,
(define-key evil-normal-state-map (kbd ",,") 'counsel-ibuffer)

; open file finding
(define-key evil-normal-state-map (kbd ",f") 'counsel-find-file)

; open org-roam notes
(define-key evil-normal-state-map (kbd ",n") 'org-roam-node-find)

; kills the current buffer
(define-key evil-normal-state-map (kbd "E") 'kill-this-buffer)

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(rune/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1))

; fold items automatically when open an org file
(setq org-startup-folded t)

; follow org mode links pressing the ENTER key
(with-eval-after-load 'evil-maps
  ;(define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil))
  ;(define-key evil-motion-state-map (kbd "TAB") nil))

(setq org-return-follows-link t)

; Go back after follow a link
(define-key global-map [(control backspace)] 'org-mark-ring-goto)

;; display inline images
(setq org-startup-with-inline-images t)

(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t
  ))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)

(setq org-agenda-files
  '("~/orgmode/tasks.org"
    "~/orgmode/habits.org"
    "~/orgmode/birthdays.org"))


(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)

(define-key global-map (kbd "C-c a")
    (lambda () (interactive) (org-agenda-list nil)))

(setq org-refile-targets
'(("archive.org" :maxlevel . 1)
    ("tasks.org" :maxlevel . 1)))

;; Save Org buffers after refiling!
(advice-add 'org-refile :after 'org-save-all-org-buffers)

(define-key global-map (kbd "C-c c")
    (lambda () (interactive) (org-capture nil)))

(setq org-capture-templates
`(("t" "Tasks / Projects")
    ("tt" "Task" entry (file+olp "~/orgmode/tasks.org" "Tasks")
        "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

    ("j" "Journal Entries")
    ("jj" "Journal" entry
        (file+olp+datetree "~/orgmode/journal.org")
        "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
        ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
        :clock-in :clock-resume
        :empty-lines 1)
    ("jm" "Meeting" entry
        (file+olp+datetree "~/orgmode/journal.org")
        "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
        :clock-in :clock-resume
        :empty-lines 1)

    ("w" "Workflows")
    ("we" "Checking Email" entry (file+olp+datetree "~/orgmode/journal.org")
        "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

    ("m" "Metrics Capture")
    ("mw" "Weight" table-line (file+headline "~/orgmode/metrics.org" "Weight")
    "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

(setq org-confirm-babel-evaluate nil) 
(require 'org-tempo)

;(add-to-list 'org-structure-template-alist '("c" .  "src c"))
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("j" .  "src js"))
;(add-to-list 'org-structure-template-alist '("awk" . "src awk"))
;(add-to-list 'org-structure-template-alist '("cpp" . "src c++"))
;(add-to-list 'org-structure-template-alist '("gp" . "src gnuplot"))
;(add-to-list 'org-structure-template-alist '("tex" . "src latex"))
;(add-to-list 'org-structure-template-alist '("org" . "src orgmode"))

; syntax highlighting for unix config files
(push '("conf-unix" . conf-unix) org-src-lang-modes)

(defun efs/org-babel-tangle-config ()
   (when (string-equal (buffer-file-name)
                       (expand-file-name "~/orgmode/emacs-configuration.org"))
     ;; Dynamic scoping to the rescue
     (let ((org-confirm-babel-evaluate nil))
       (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/orgmode/roam-notes")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
  '(("d" "default" plain
    "%?"
    :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n")
    :unnarrowed t)
   ("l" "Programming Language" plain
    (file "~/orgmode/roam-notes/templates/programming-language-template.org")
    :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n")
    :unnarrowed t)
   ("b" "Book Notes" plain
    (file "~/orgmode/roam-notes/templates/book-notes-template.org")
    :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n")
    :unnarrowed t)
    ("p" "Project" plain
    (file "~/orgmode/roam-notes/templates/project-template.org")
     :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: project\n#+date: %U\n")
     :unnarrowed t)
    )
   )
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insertly)
         :map org-mode-map
         ("C-M-i"    . completion-at-point)
  :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies) ;; Ensure the keymap is available
  (org-roam-db-autosync-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;(defun efs/lsp-mode-setup ()
;  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
;  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  ;:hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))


(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-ivy)

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

; icons config
(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package lsp-treemacs
  :after lsp)

(use-package evil-nerd-commenter
  :bind ("C-/" . evilnc-comment-or-uncomment-lines))

(use-package term
  :config
  (setq explicit-shell-file-name "zsh")
  ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args

  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  ;;(setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
)

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000))

;; (add-hook 'vterm-mode-hook
;;   (lambda ()
;;     (set (make-local-variable 'buffer-face-mode-face) 'inconsolata)
;;       (buffer-face-mode t)))


(setq vterm-timer-delay 0.001)
;;(set-face-attribute 'default nil :font "InconsolataGo Nerd Font Mono" :height 140)
