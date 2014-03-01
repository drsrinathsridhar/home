;; This is .emacs of Srinath Sridhar (www.srinathsridhar.com)
;; Tested in GNU Emacs 24.3 under Debian Wheezy
;; Updated: 16-Feb-2014

;; Functions to load user's config files
(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

;; Set ELPA repositories - GNU
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/"))

;; Marmalade
require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; ===============================
;; APPEARANCE
;; ===============================
;; Zenburn theme (package zenburn-theme on ELPA)
(load-theme 'zenburn t)

;; ;; tomorrow-theme
;; (load-file "~/.emacs.d/themes/tomorrow-theme/color-theme-tomorrow.el")
;; (require 'color-theme-tomorrow)
;; ;;(color-theme-tomorrow--define-theme night)
;; (color-theme-tomorrow--define-theme night-bright)

;; Solarized load theme either light or dark
;;(load-theme 'solarized-light t)
;; (load-theme 'solarized-dark t)
;; ;; https://github.com/sellout/emacs-color-theme-solarized/issues/60
;; ;; Work around broken solarized colours in emacsclient -t by reloading the theme
;; ;; whenever a frame is create/deleted and when the server is done editing
;; (defun thj-reload-solarized (frame)
;;   (select-frame frame)
;;   (load-theme 'solarized-dark))
;; (defun thj-reload-solarized-on-delete (&optional frame)
;;     (load-theme 'solarized-dark))
;; (add-hook 'delete-frame-functions 'thj-reload-solarized-on-delete)
;; (add-hook 'server-done-hook 'thj-reload-solarized-on-delete)
;; (add-hook 'after-make-frame-functions 'thj-reload-solarized)

;; Set font size at 10 pt
(set-face-attribute 'default nil :height 102)
;; Comment mode style
(setq comment-style 'indent)
;; Define cursor type
(set-default 'cursor-type 'hbar)
;; Overwite selected text
(delete-selection-mode t)
;; Toggle fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; Disable toolbar/menu bar
(tool-bar-mode -1)
(menu-bar-mode 0)
;; Hide splash-screen and startup-message
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
;; Enable Mouse Avoidance
;;(mouse-avoidance-mode 1)

;; ===============================
;; Programming
;; ===============================
;; Show word count
(require 'wc-mode)
(global-set-key "\C-cw" 'wc-mode)

;; Separate file for loading IDE
(load-user-file "config/ide.el")
;; Enable Line and Column Numbering
;; Don't show line-number in the mode line
(line-number-mode 0)
;; Display line number on the side
(global-linum-mode t)
;; Show column-number in the mode line
(column-number-mode t)
;; Enable better window navigation using Wind Move. Default key bindings interfere with selection
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings 'meta))
;; Goto line shortcut key                                                                                                   
(global-set-key "\C-l" 'goto-line)
;; Set indentation style - Using Allman (bsd) style
(setq c-default-style "bsd" c-basic-offset 4)
;; Spell check comments in prog-mode
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
;; Highlight current line
;; In every buffer, the line which contains the cursor will be fully highlighted
(global-hl-line-mode 1)
;; Show matching brackets
(show-paren-mode 1)
;; 80 character line
(require 'fill-column-indicator)
(setq fci-rule-width 1)
(setq fci-rule-color "white")
(add-hook 'after-change-major-mode-hook 'fci-mode)
(fci-mode 1)
;; Highlight FIXME and other keywords
(defun font-lock-comment-annotations ()
  "Highlight a bunch of well known comment annotations.

This functions should be added to the hooks of major modes for programming."
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):"
          1 font-lock-warning-face t))))
(add-hook 'prog-mode-hook 'font-lock-comment-annotations)

;; For cmake
(setq load-path (cons (expand-file-name "~/.emacs.d/plugins") load-path))
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

;; AuCTeX Stuff for LaTeX
;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
;; (setq-default TeX-master nil)


;; ===============================
;; KEYBOARD SHORTCUTS AND COMMANDS
;; ===============================
;; Shortcut for eshell
(global-set-key (kbd "C-S-s") 'eshell)
;; Make PDFLaTeX the default LaTeX command
(setq latex-run-command "pdflatex")
;; Recently opened files
(require 'recentf)
    (recentf-mode 1)
    (setq recentf-max-menu-items 25)
    (global-set-key "\C-x\ \C-r" 'recentf-open-files)
;; Toggle line wrap
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)

;; ===============================
;; EMACS MODES
;; ===============================
;; Fix flyspell problem and start it by default
(setq flyspell-issue-welcome-flag nil)
(defun turn-on-flyspell () (flyspell-mode 1))
(add-hook 'find-file-hooks 'turn-on-flyspell)


;; ===============================
;; MISCELLNEAOUS
;; ===============================
;; Load the plugins directory
(add-to-list 'load-path
	     "~/.emacs.d/plugins/")

;; Unique buffer name for similar files
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Delete selection mode allows killing of selected region
(delete-selection-mode 1)
;; System-wide copy in Emacs
(setq x-select-enable-clipboard t)
;; Support Wheel Mouse Scrolling
(mouse-wheel-mode t)
;; Smooth scroll
(setq scroll-conservatively most-positive-fixnum)
;; Stop creating ~ backup files
(setq make-backup-files nil)
;; Stop asking for buffer close confirmation. This is for emacsclient
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)
;; Refresh buffer to mirror change on disc
(global-auto-revert-mode t)
;; Enable upper case and lower case
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Automatically load abbreviations table
;; Note that emacs chooses, by default, the filename
;; "~/.abbrev_defs", so don't try to be too clever
;; by changing its name
;(setq-default abbrev-mode t)
;(read-abbrev-file "~/.abbrev_defs")
;(setq save-abbrevs t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(background-color "#7f7f7f")
 '(background-mode dark)
 '(cursor-color "#5c5cff")
 '(custom-safe-themes (quote ("dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(foreground-color "#5c5cff")
 '(preview-gs-options (quote ("-q" "-dSAFER" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4" "-dSAFER"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Enable ido-mode everywhere
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1) 

;; Powerline
(require 'powerline)

;; ===============================
;; EMAIL
;; ===============================
; The first is for the default MUA, the second for Message/Gnus.
(setq send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it)

; SMTP authentication.
(setq smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-auth-credentials '(("smtp.gmail.com" 587
                                   srinath1905 nil))
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil)))

; Mail reading.
(setq read-mail-command 'gnus
      gnus-agent-go-online t
      gnus-inhibit-startup-message t
      gnus-large-newsgroup nil
      gnus-select-method  '(nnimap "mail"
                                   (nnimap-address "imap.gmail.com")
                                   (nnimap-authinfo-file "~/.netrc")
                                   (nnimap-stream ssl))
      gnus-summary-line-format "%U%R%z%B%(%[%4L: %-23,23f%]%) %s\n")

;; ===============================
;; PAPER WRITING
;; ===============================
; From Matt Might's suggestions
;(add-to-list 'load-path "")
(require 'writegood-mode)
(global-set-key "\C-cg" 'writegood-mode)
