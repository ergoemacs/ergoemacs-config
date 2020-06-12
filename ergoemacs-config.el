;;; ergoemacs-config.el --- Sample ergoemacs configuration
;; 
;; Filename: ergoemacs-config.el
;; Description: Suggested ergoemacs-mode configuration
;; Author: Matthew L. Fidler
;; Maintainer: Matthew L. Fidler
;; Created: Fri Sep  4 09:37:09 2015 (-0500)
;; Version: 0.1
;; Package-Requires: (ergoemacs-mode)
;; 
;; Features that might be required by this library:
;;
;;   None
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Commentary:
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Change Log:
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:

(ergoemacs-package golden-ratio
    :ensure t
    :defer 1
    
    (defun ergoemacs-golden-ratio-exclude-minimap-p ()
      (memq this-command '(minimap-toggle)))
    (setq golden-ratio-inhibit-functions '(ergoemacs-golden-ratio-exclude-minimap-p))
    (setq golden-ratio-exclude-modes '("bs-mode"
                                       "calc-mode"
                                       "ediff-mode"
                                       "dired-mode"
                                       "gud-mode"
                                       "gdb-locals-mode"
                                       "gdb-registers-mode"
                                       "gdb-breakpoints-mode"
                                       "gdb-threads-mode"
                                       "gdb-frames-mode"
                                       "gdb-inferior-io-mode"
                                       "gud-mode"
                                       "gdb-inferior-io-mode"
                                       "gdb-disassembly-mode"
                                       "gdb-memory-mode"
                                       "restclient-mode"
                                       "speedbar-mode"
				       "minimap-mode"))
    (setq golden-ratio-extra-commands
          (append golden-ratio-extra-commands
                  '(ace-window
                    switch-window
                    delete-other-window
                    ace-delete-window
                    ace-select-window
                    ace-swap-window
                    ace-maximize-window
                    avy-pop-mark
                    windmove-left
                    windmove-right
                    windmove-up
                    windmove-down
                    select-window-0
                    select-window-1
                    select-window-2
                    select-window-3
                    select-window-4
                    select-window-5
                    select-window-6
                    select-window-7
                    select-window-8
                    select-window-9
                    buf-move-left
                    buf-move-right
                    buf-move-up
                    buf-move-down
                    ess-eval-buffer-and-go
                    ess-eval-function-and-go
                    ess-eval-line-and-go)))
    (add-to-list 'golden-ratio-exclude-buffer-regexp "^\\*[hH]elm.*")
    (add-to-list 'golden-ratio-exclude-buffer-regexp "^\\*MINIMAP\\*")
    (add-to-list 'golden-ratio-exclude-buffer-names " *NeoTree*")
    (add-to-list 'golden-ratio-exclude-buffer-names "*LV*")
    (add-to-list 'golden-ratio-exclude-buffer-names " *which-key*")
    (golden-ratio-mode t))

(ergoemacs-package flycheck
    :ensure t
    :defer 2
    (global-flycheck-mode 1))

(ergoemacs-autoload adaptive-wrap
    :ensure t
    :defer 1
    (add-hook 'visual-line-mode-hook 'adaptive-wrap-prefix-mode))

(ergoemacs-autoload aggressive-indent
    :ensure t
    :commands (aggressive-indent-mode global-aggressive-indent-mode)
    (push 'esn-mode excluded-modes)
    (global-aggressive-indent-mode 1))


;; (ergoemacs-package smartparens
;;     :ensure t
;;     :defer t
;;     (dolist (hook '(prog-mode-hook))
;;       (add-hook hook 'smartparens-mode))

;;     ;; enable smartparens-mode in `eval-expression'
;;     (defun ergoemacs-conditionally-enable-smartparens-mode ()
;;       "Enable `smartparens-mode' during `eval-expression'."
;;       (if (eq this-command 'eval-expression)
;;           (smartparens-mode)))
;;     (add-hook 'minibuffer-setup-hook 'ergoemacs-conditionally-enable-smartparens-mode)

;;     (require 'smartparens-config)
;;     (setq sp-show-pair-delay 0
;;           sp-show-pair-from-inside t ; fix paren highlighting in normal mode
;;           sp-cancel-autoskip-on-backward-movement nil)
;;     (define-key emacs-lisp-mode-map (kbd ")") 'sp-up-sexp)

;;     (defun emacsmate-smartparens-emacs-mode-hook ()
;;       "Change `sp-navigate-close-if-unbalanced' to be non-nil in emacs-buffers"
;;       (set (make-local-variable 'sp-navigate-close-if-unbalanced) t))
    
;;     (add-hook 'emacs-lisp-mode-hook
;;               'emacsmate-smartparens-emacs-mode-hook)
;;     (show-smartparens-global-mode +1)
    
;;     ;; don't create a pair with single quote in minibuffer
;;     (sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)
;;     (smartparens-global-mode 1))

(ergoemacs-package evil-numbers
    :ensure t
    :defer 1
    (global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
    (global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt))

(ergoemacs-autoload helm
    :ensure t
    (helm-mode)
    (helm-autoresize-mode t))

(ergoemacs-package ido
    :ensure (ido-completing-read+ ido-vertical-mode smex flx-ido)
    ;; Remove extensions from ido completion
    (dolist (ext '("elc" "exe" "com" "org_archive" "png" "gif" "csv" "jpg" "jpeg"))
      (push ext completion-ignored-extensions))
    (setq ido-enable-prefix t
          ido-enable-flex-matching t
          ido-create-new-buffer 'always
          ido-use-filename-at-point nil
          ido-enable-tramp-completion t
          ido-everywhere t
          org-completion-use-ido t
          ido-max-prospects 10
          ido-use-virtual-buffers t
          ido-default-file-method 'selected-window
          ido-ignore-extensions t
          ido-file-extensions-order '(".org" ".R" ".ctl" ".pltc" ".nsi" ".txt" ".py" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf" ".nsi" ".nsh")
          org-completion-use-ido t
          magit-completing-read-function 'magit-ido-completing-read
          gnus-completing-read-function 'gnus-ido-completing-read
          ido-enable-flex-matching t
          ido-use-faces nil
          flx-ido-threshold 10000
          gc-cons-threshold 20000000)
    (ido-mode 1)
    (ido-everywhere 1)
    (require 'ido-completing-read+)
    (ido-ubiquitous-mode 1)
    (smex-initialize)
    (ido-vertical-mode 1)
    (flx-ido-mode 1))

;; (ergoemacs-package auto-highlight-symbol
;;     :ensure t
;;     :defer 3
;;     (dolist (hook '(prog-mode-hook markdown-mode-hook))
;;       (add-hook 'auto-highlight-symbol-mode hook))
;;     (setq ahs-case-fold-search nil
;;           ahs-default-range 'ahs-range-whole-buffer
;;           ahs-inhibit-face-list nil)
;;     ;; FIXME: Think about keys for `ahs-forward', `ahs-backward' `ahs-back-to-start'
;;     )

;; (ergoemacs-package anzu
;;     :ensure t
;;     :defer 1
;;     (global-anzu-mode 1)
;;     (global-set-key [remap query-replace] 'anzu-query-replace))

(ergoemacs-autoload visual-regexp
    :ensure t
    :commands vr/query-replace
    :bind (("M-%" vr/query-replace)
           ("M-5" vr/replace)))

(ergoemacs-package fill-column-indicator
    :ensure t
    :defer 1
    :commands fci-mode
    (setq fci-rule-width 3
          whitespace-style '(face trailing))
    (dolist (hook '(prog-mode-hook))
      (add-hook 'fci-mode hook)))

(ergoemacs-autoload guide-key
    :ensure t
    :defer 2
    (guide-key-mode 1)
    (setq guide-key/recursive-key-sequence-flag t
          guide-key/popup-window-position 'bottom
          guide-key/idle-delay 0.1
          guide-key/text-scale-amount 0))

;; (ergoemacs-package eval-sexp-fu
;;     :ensure t
;;     (require 'eval-sexp-fu))


(ergoemacs-package rainbow-delimiters
    :ensure t
    :defer 2
    (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(ergoemacs-package rainbow-mode
    :ensure t
    :defer 3
    (rainbow-mode t))

(ergoemacs-autoload indent-guide
    :ensure t
    :defer 3
    (indent-guide-global-mode 1))

(ergoemacs-package page-break-lines
    :ensure t
    :defer 3
    (global-page-break-lines-mode t))

(ergoemacs-package volatile-highlights
    :ensure t
    :defer 3
    (volatile-highlights-mode))

(ergoemacs-autoload desktop-save
    (desktop-save-mode 1)
  (setq desktop-save t)
  (when (not (file-exists-p desktop-dirname))
    (make-directory desktop-dirname t))
  
  (defun ergoemacs-emacs-process-p (pid)
    "If pid is the process ID of an emacs process, return t, else nil.
Also returns nil if pid is nil."
    (when pid
      (let ((attributes (process-attributes pid)) (cmd))
        (dolist (attr attributes)
          (if (string= "comm" (car attr))
              (setq cmd (cdr attr))))
        (if (and cmd (string-match-p "[Ee]macs")) t))))
  
  (ergoemacs-advice desktop-owner (&optional dirname)
    "Don't allow dead emacs process to claim file."
    :type :after
    (when (not (ergoemacs-emacs-process-p ad-return-value))
      (setq ad-return-value nil))))

(ergoemacs-autoload visual-line-mode
    :defer 3
    (global-visual-line-mode 1))

(ergoemacs-autoload global-hl-line-mode
    (global-hl-line-mode 1))

(ergoemacs-package i-beam-display
    (modify-all-frames-parameters (list (cons 'cursor-type 'bar))))

(ergoemacs-autoload pop-up-frames
    (setq pop-up-frames 'graphic-only))

(ergoemacs-package tabbar-ruler
    :ensure t
    :defer 1
    (setq tabbar-ruler-global-tabbar t ; If you want tabbar
          ;;tabbar-ruler-global-ruler t ; if you want a global ruler
          ;;tabbar-ruler-popup-menu nil ; If you want a popup menu.
          ;;tabbar-ruler-popup-toolbar nil ; If you want a popup toolbar
          ;;tabbar-ruler-popup-scrollbar nil
          ;; tabbar-ruler-style 'firefox-circle
	  ) ; Popup scrollbar
    (require 'tabbar-ruler))

(ergoemacs-package tab-setup
    (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  (setq-default tab-always-indent 'complete))

(ergoemacs-package stop-cursor-in-minibuffer-prompt
    (setq minibuffer-prompt-properties (quote (read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt))))

(ergoemacs-package whitespace-mode
    (setq whitespace-style (quote (spaces tabs newline space-mark tab-mark newline-mark)) ;; make whitespace-mode use just basic coloring
          whitespace-display-mappings '((space-mark 32 [183] [46]) ; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
                                        (newline-mark 10 [182 10]) ; 10 LINE FEED
                                        (tab-mark 9 [9655 9] [92 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
                                        )))

(ergoemacs-package mouse-wheel-mode
    :defer 0.5
    (mouse-wheel-mode t))

(ergoemacs-package sane-defaults
    (setq-default indent-tabs-mode nil
                  indicate-empty-lines t
                  imenu-auto-rescan t
                  text-mode-hook 'turn-on-auto-fill
                  text-mode-hook 'turn-on-flyspell)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (put 'narrow-to-region 'disabled nil)
  (put 'upcase-region 'disabled nil)
  (put 'downcase-region 'disabled nil)
  (put 'erase-buffer 'disabled nil)
  (put 'scroll-left 'disabled nil)
  (put 'dired-find-alternate-file 'disabled nil)
  (setq visible-bell t
        echo-keystrokes 0.1
        font-lock-maximum-decoration t
        inhibit-startup-message t
        color-theme-is-global t
        delete-by-moving-to-trash t
        shift-select-mode nil
        truncate-partial-width-windows nil
        uniquify-buffer-name-style 'forward
        whitespace-style '(trailing lines space-before-tab indentation space-after-tab)
        whitespace-line-column 100
        ediff-window-setup-function 'ediff-setup-windows-plain
        xterm-mouse-mode t
        save-place-file (expand-file-name "saveplace.el" user-emacs-directory)
        save-place t)
  (transient-mark-mode t)
  (defalias 'yes-or-no-p 'y-or-n-p))

(ergoemacs-package savehist-mode
    :defer 1
    (savehist-mode 1))

(ergoemacs-package allow-set-mark-repeat-pop-mark
    (setq set-mark-command-repeat-pop t))

(ergoemacs-package backup-in-temp-dir
    (setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))

  (setq auto-save-file-name-transforms
        `((".*" ,temporary-file-directory t))))

(ergoemacs-package keyfreq
    :ensure t
    (setq keyfreq-file (expand-file-name ".emacs.keyfreq" user-emacs-directory)
          keyfreq-file-lock (expand-file-name ".emacs.keyfreq.lock" user-emacs-directory))
    (require 'keyfreq)
    (keyfreq-mode 1)
    (keyfreq-autosave-mode 1))

;; (ergoemacs-package info+
;;     :ensure t
;;     :defer 1)

;; (ergoemacs-package dired+
;;     :ensure t
;;     :defer 1)

(ergoemacs-package auto-compression
    :defer 1
    (auto-compression-mode t))

(ergoemacs-package linum-off
    :ensure t
    :defer 0.5
    (global-linum-mode 1))

(ergoemacs-package subword-mode
    :defer 1
    (global-subword-mode 1))


(ergoemacs-package emacs-lisp-mode
    ;; This does the following:
    ;; - Turn on el-doc
    ;; - Turn on coding hook
    ;; - Removes =.elc= files on save.
    ;; - Add =C-c v= to be `eval-buffer'
    (define-key emacs-lisp-mode-map (kbd "C-c v") #'eval-buffer)
  (define-key emacs-lisp-mode-map (kbd "C-c C-c") #'eval-defun)

  (defun ergoemacs-remove-elc-on-save ()
    "If you're saving an elisp file, likely the .elc is no longer valid."
    (make-local-variable 'after-save-hook)
    (add-hook 'after-save-hook
              (lambda ()
                (if (file-exists-p (concat buffer-file-name "c"))
                    (delete-file (concat buffer-file-name "c"))))))
  (add-hook 'emacs-lisp-mode-hook #'ergoemacs-remove-elc-on-save)
  (add-hook 'emacs-lisp-mode-hook #'turn-on-eldoc-mode))


(ergoemacs-package magit
    :ensure (magit)
    :commands (magit-status)
    ;; (add-hook 'magit-mode-hook #'turn-on-magit-gh-pulls)
    )

;; (ergoemacs-package use-cperl
;;     ;; use cperl-mode instead of perl-mode
;;     (setq auto-mode-alist (rassq-delete-all 'perl-mode auto-mode-alist))
;;   (add-to-list 'auto-mode-alist '("\\.\\(p\\([lm]\\)\\)\\'" . cperl-mode))
;;   (setq interpreter-mode-alist (rassq-delete-all 'perl-mode interpreter-mode-alist))
;;   (add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
;;   (add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
;;   (add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode)))

;;; Org mode

(ergoemacs-package org-indent
    (add-hook 'org-mode-hook #'org-indent-mode))

(ergoemacs-package org
    (when (not (file-exists-p "~/org"))
      (make-directory "~/org"))
  (setq org-log-done t
        org-agenda-files '("~/org/refile.org" "~/org/todo.org")
        org-todo-keywords '((sequence "TODO(t)"  "|"  "DONE(d!)")
                            (sequence "WAIT(w@)" "|")
                            (sequence "|" "SOMEDAY(s@)")
                            (sequence "|" "CANCELED(c@)"))

        org-tag-alist '(("@work" . ?w) ("@home" . ?h))
        org-use-fast-todo-selection t
        org-enforce-todo-dependencies t
        org-agenda-overriding-columns-format "%38ITEM(Details) %TAGS(Context) %7TODO(To Do) %5Effort(Time){:} %6CLOCKSUM_T{Today}"
        org-default-notes-file "~/org/refile.org"
        org-capture-templates `(("t" "todo" entry (file "~/org/refile.org")
                                 "* TODO %?\n%U\n%a\n  %i" :clock-in t :clock-resume t)
                                ("d" "Daily Review" plain (file+datetree "~/org/daily.org")
                                 ,(format "%%[%s/five-minute.org]"
                                          (expand-file-name "etc" "~EmacsMate/")) :clock-in t :clock-resume t)
                                ;; ("k" "Weekly Review" plain (file+datetree "~/org/weekly.org")
                                ;;  ,(format "%%[%s/gtd-weekly.org]"
                                ;;           (expand-file-name "etc"
                                ;;                             emacsmate-dir))
                                ;;  :clock-in t :clock-resume t)
                                ("n" "note" entry (file "~/org/refile.org")
                                 "* %? :NOTE:\n%U\n%a\n  %i" :clock-in t :clock-resume t)
                                ("j" "Journal" entry (file+datetree "~/org/diary.org")
                                 "* %?\n%U\n  %i" :clock-in t :clock-resume t)
                                ("w" "org-protocol" entry (file "~/org/refile.org")
                                 "* TODO Review %c\n%U\n  %i" :immediate-finish t)
                                ("o" "org-outlook" entry (file "~/org/refile.org") "* TODO Email %c %?\n  %i\n %U"
                                 :clock-in t :clock-resume t)
                                ("h" "Habit" entry (file "~/org/refile.org")
                                 "* NEXT %?\n%U\n%a\nSCHEDULED: %t .+1d/3d\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n  %i"))
        ;; Show lot of clocking history so it's easy to pick items off the C-F11 list
        org-clock-history-length 23
        ;; Resume clocking task on clock-in if the clock is open
        org-clock-in-resume t
        ;; Separate drawers for clocking and logs
        org-drawers (quote ("PROPERTIES" "LOGBOOK"))
        ;; Save clock data and state changes and notes in the LOGBOOK drawer
        org-clock-into-drawer t
        ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
        org-clock-out-remove-zero-time-clocks t
        ;; Clock out when moving task to a done state
        org-clock-out-when-done t
        ;; Save the running clock and all clock history when exiting Emacs, load it on startup
        org-clock-persist t
        ;; Do not prompt to resume an active clock
        org-clock-persist-query-resume nil
        ;; Enable auto clock resolution for finding open clocks
        org-clock-auto-clock-resolution (quote when-no-clock-is-running)
        ;; Include current clocking task in clock reports
        org-clock-report-include-clocking-task t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-cycle-separator-lines 0
        org-blank-before-new-entry (quote ((heading) (plain-list-item)))
        org-src-window-setup 'current-window)
  ;; (add-hook 'org-after-refile-insert-hook #'save-buffer)
  ;; (add-hook 'org-capture-after-finalize-hook #'save-buffer)
  ;;
  ;; Resume clocking task when emacs is restarted
  (org-clock-persistence-insinuate)
  (ergoemacs-advice org-refile (&optional goto default-buffer rfloc msg)
    "Save buffer after refile."
    :type :after
    (save-buffer)))



;;; Color theme options.

(ergoemacs-package solarized-theme
    :ensure t
    (load-theme 'solarized-light))

;; (ergoemacs-package smart-mode-line
;;     :ensure nil
;;     :defer 2
;;     ;; (setq sml/no-confirm-load-theme t)
;;     ;; (sml/setup)
;;     ;; (ergoemacs-mode-line-format)
;;     ;; 	      ;; 
;;     ;; 	      ;; mode-line-misc-info
;;     ;; 	      ;; mode-line-end-spaces
;;     ;; 	      )))
;;     )


;;; ergoemacs-options
(ergoemacs-package ergoemacs-options
    (setq ergoemacs-beginning-or-end-of-line-and-what 'page
          ergoemacs-smart-paste t))


;;; ess-mode

(ergoemacs-package ess-site
    :mode (("\\.sp\\'"          . S-mode) ;; re: Don MacQueen <macq@llnl.gov>
           ("/R/.*\\.q\\'"      . R-mode) ;; R/*.q is R code (e.g., in package)
           ("\\.[qsS]\\'"       . S-mode) ;; s,S [see ess-restore-asm-extns above!]
           ("\\.ssc\\'"         . S-mode) ;; Splus (>= 4.x) script files.
           ("\\.SSC\\'"         . S-mode) ;; ditto for windoze
           ("\\.[rR]\\'"        . R-mode)
           ("\\.[rR]nw\\'"      . Rnw-mode)
           ("\\.[sS]nw\\'"      . Snw-mode); currently identical to Rnw-mode
           ("\\.[rR]profile\\'" . R-mode)
           ("NAMESPACE\\'"      . R-mode)
           ("CITATION\\'"       . R-mode)
           ("\\.omg\\'"         . omegahat-mode)
           ("\\.hat\\'"         . omegahat-mode)
           ("\\.lsp\\'"         . XLS-mode)
           ("\\.do\\'"          . STA-mode)
           ("\\.ado\\'"         . STA-mode)
           ("\\.[Ss][Aa][Ss]\\'"        . SAS-mode)
           ;; Many .log/.lst files, not just SAS
           ;;("\\.log\\'"       . SAS-log-mode)
           ;;("\\.[Ll][Ss][Tt]\\'"      . SAS-listing-mode)
           ("\\.[Ss]t\\'"       . S-transcript-mode)
           ("\\.Sout"           . S-transcript-mode)
           ;;("\\.[Rr]t\\'"       . R-transcript-mode)
           ("\\.[Rr]out"        . R-transcript-mode)
           ("\\.Rd\\'"          . Rd-mode)
           ("\\.[Bb][Uu][Gg]\\'"         . ess-bugs-mode)
           ("\\.[Bb][Oo][Gg]\\'"         . ess-bugs-mode)
           ("\\.[Bb][Mm][Dd]\\'"         . ess-bugs-mode)
           ("\\.[Jj][Aa][Gg]\\'"         . ess-jags-mode)
           ("\\.[Jj][Oo][Gg]\\'"         . ess-jags-mode)
           ("\\.[Jj][Mm][Dd]\\'"         . ess-jags-mode)
	   ;; ("\\.[Rr][mM][Dd]\\'"         . poly-markdown+r-mode)
	   )
    :interpreter (("Rscript" . r-mode)
                  ("r" . r-mode))
    :ensure (ess polymode markdown-mode electric-operator)
    ;; (defun ergoemacs-turn-on-ess-eldoc ()
    ;;   (require 'ess-eldoc))
    ;; (add-hook 'ess-mode-hook 'ergoemacs-turn-on-ess-eldoc)
    (add-hook 'ess-mmode-hook 'flyspell-mode)
    (when (file-exists-p "~src/Rstartup/Rstartup.R")
      (setenv "R_PROFILE_USER" (expand-file-name "~src/Rstartup/Rstartup.R")))
    
    ;; Make TeX and RefTex aware of Snw and Rnw files
    (setq reftex-file-extensions
          '(("Snw" "Rnw" "nw" "tex" ".tex" ".ltx") ("bib" ".bib")))
    (setq TeX-file-extensions
          '("Snw" "Rnw" "nw" "tex" "sty" "cls" "ltx" "texi" "texinfo"))

    ;; Lets you do 'C-c C-c Sweave' from your Rnw file
    (defun ergoemacs-add-Sweave ()
      (add-to-list 'TeX-command-list
                   '("Sweave" "R CMD Sweave %s"
                     TeX-run-command nil (latex-mode) :help "Run Sweave") t)
      (add-to-list 'TeX-command-list
                   '("LatexSweave" "%l %(mode) %s"
                     TeX-run-TeX nil (latex-mode) :help "Run Latex after Sweave") t)
      (setq TeX-command-default "Sweave"))
    (add-hook 'Rnw-mode-hook 'emacsmate-add-Sweave)

    (setq ess-ask-for-ess-directory nil
          ess-local-process-name "R"
          ansi-color-for-comint-mode 'filter
          comint-scroll-to-bottom-on-input t
          comint-scroll-to-bottom-on-output t
          comint-move-point-for-output t)
    (setenv "PATH"
	    (let (full)			;(let (full)
              ;; (push (getenv "PATH") full)
              (dolist (f '(;; "C:/RTOOLS/gcc-4.6.3/bin"  
                           ;; "C:/RTOOLS/bin"
                           ;; "c:/Progra~1/Putty"
			   "C:/ProgramData/Microsoft/AppV/Client/Integration/1CA54D47-052B-48ED-B054-75DAC0BF58BF/Root"
			   ))
                (when (file-exists-p f)
                  (push f full)))
	      
              (concat
	       (mapconcat (lambda (x) x) full ";")
	       ";" (getenv "PATH"))))
    ;; (setenv "R_LIBS"
    ;; 	    (let (full)
    ;; 	      (dolist (f '("c:/R/R-3.2.3/library" "c:/MS/R/3.0" "c:/SVN/R/Rlib"
    ;; 			   "c:/SVN/R/PMXStan"
    ;; 			   "c:/SVN/Wenping/Rlib"))
    ;; 		(when (file-exists-p f)
    ;; 		  (push f full)))
    ;; 	      (mapconcat (lambda (x) x) full ";")))
    (setenv "R_LIBS" "c:/Rlibs-RxODE")
    ;; (require 'poly-R)
    ;; (require 'poly-markdown)
    ;; (when (and (getenv "ProgramFiles")
    ;; 	       (file-exists-p (format "%s/LLVM/bin" (getenv "ProgramFiles")))
    ;; 	       (file-exists-p "c:/mingw32/bin"))
    ;;   (setenv "PATH" (format "%s/LLVM/bin;c:/mingw32/bin;%s" (getenv "ProgramFiles") (getenv "PATH"))))
    ;; Use R core team's recommendations for ESS.
    ;; See http://stackoverflow.com/questions/7502540/make-emacs-ess-follow-r-style-guide
    (add-hook 'ess-mode-hook
	      (lambda()
		(ess-set-style 'RStudio 'quiet)
		(add-hook 'local-write-file-hooks
                          (lambda ()
                            (ess-nuke-trailing-whitespace)))
		(electric-operator-mode)))
    (setq ess-nuke-trailing-whitespace-p t))

(ergoemacs-package ess-smart-underscore
    :ensure t)


(ergoemacs-package yasnippet
    :ensure t
    :defer 2
    (yas-global-mode 1)
    ;; (when (file-exists-p "~data/snippets")
    ;;   (yas-load-directory "~data/snippets"))
    
    ;; (when (emacsmate-package-load-path 'textmate-to-yas)
    ;;   (require 'textmate-to-yas))
    ;; ;; (yas-global-mode)
    

    ;; (yas-load-directory (expand-file-name "snippets" emacsmate-dir))

    ;; (defun yas-org-very-safe-expand ()
    ;;   (let ((yas-fallback-behavior 'return-nil)) (yas-expand)))

    ;; (defun yas-org-setup ()
    ;;   ;; yasnippet (using the new org-cycle hooks)
    ;;   (when (boundp 'yas-trigger-key)
    ;;     (set (make-local-variable 'yas-trigger-key) [tab]))
    ;;   (when (boundp 'org-tab-first-hook)
    ;;     (add-to-list 'org-tab-first-hook 'yas-org-very-safe-expand))
    ;;   (when (boundp 'yas-keymap)
    ;;     (define-key yas-keymap [tab] 'yas-next-field)))

    ;; (when (boundp 'org-mode-hook)
    ;;   (add-hook 'org-mode-hook #'yas-org-setup))
    )

;; (ergoemacs-package extend-dnd
;;     :ensure t
;;     (extend-dnd-activate))

(ergoemacs-autoload ace-window
    "Ace Window"
  :bind ("M-s" 'ace-window)
  :ensure t
  ;; layout based aw-keys
  (setq aw-keys (mapcar
                 (lambda(key)
                   (ergoemacs-translate--event-layout key ergoemacs-keyboard-layout "us"))
                 (list ?f ?j ?d ?k ?r ?u ?e ?i ?s ?l ?w ?o))))

(ergoemacs-package other-window-is-below
    "Make other window below current window"
    (setq split-height-threshold 0))


;; highlight-indentation
;; highlight-numbers
;; highlight-parentheses
;; hl-anything
;; hungry-delete
;; google-translate
;; desktop
;; bookmark
;; php-mode
;; js2-mode
;; visual-basic-mode
;; csharp-mode
;; powershell
;; clojure-mode
;; autohotkey-mode
;; xlsl-mode
;; pov-mode
;; Haskell-mode
;; erlang
;; scala
;; nl/caml/ocaml
;; bbcode
;; xub-mode?
;; xmsi-mode?
;; spellcheck?
;; Speck?
;; Yasnipped
;; auto-complete
;; company
;; bookmark+
;; dired+
;; highlight-symbol
;; keyfreq
;; dictionary lookup
;; Powerline


(ergoemacs-package drag-stuff
    :ensure t
    (push 'org-mode drag-stuff-except-modes)
    (drag-stuff-global-mode))

(ergoemacs-package projectile
    :ensure t
    (defun projectile-project-template-root (dir)
      "Is this a project template root directory?"
      (catch 'not-found
	(dolist (sub '("cache" "config" "data" "diagnostics" "doc" "graphs" "lib" "logs" "munge" "reports" "src" "tests"))
	  (unless (file-exists-p (expand-file-name sub dir))
	    (throw 'not-found nil)))
	dir))
    (add-to-list 'projectile-project-root-files-function 'projectile-project-template-root))


;; (ergoemacs-package c-spc-set-mark
;;     (global-set-key (kbd "C-SPC") 'set-mark-command))

(provide 'ergoemacs-config)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ergoemacs-config.el ends here
;; Local Variables:
;; coding: utf-8-emacs
;; End:
