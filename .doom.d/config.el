;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Alex Egger")
(if (string= (system-name) "Titanic")
    (setq user-mail-address "alex.egger@mixed-mode.de")
  (setq user-mail-address "alex.egger96@gmail.com"))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(if (string= (system-name) "Titanic")
    (setq
     doom-font (font-spec :family "Iosevka" :size 28 :weight 'semi-light)
     doom-variable-pitch-font (font-spec :family "OpenSans" :size 22))
  (setq doom-font (font-spec :family "Fira Code" :size 14)))
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula
      doom-themes-enable-italic nil
      doom-themes-enable-bold nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(map!
 :nv "C-c /" 'counsel-projectile-rg
 :nv "C-x g" 'magit-status-here
 :nvi "C-c z" 'magit-dispatch
 )

;; Org Mode
(after! org
  ;; General
  (setq
   org-agenda-window-setup 'reorganize-frame
   org-archive-location (concat (expand-file-name "%s_archive" (expand-file-name "archive" org-directory)) "::")
   org-tags-column -77
   )

  ;; Todo keywords
  (setq org-todo-keywords
        '("TODO(t)" "NEXT(n)" "WAIT(w)" "|" "DONE(d)"))

  (custom-declare-face '+org-todo-todo-face '((t (:inherit org-todo))) "Face for Org Mode TODO items.")
  (custom-declare-face '+org-todo-next-face '((t (:inherit org-todo :box 1))) "Face for Org Mode NEXT items.")
  (custom-declare-face '+org-todo-wait-face '((t (:inherit warning org-todo))) "Face for Org Mode WAIT items.")
  (custom-declare-face '+org-todo-done-face '((t (:inherit org-done :bold nil :foreground "dim gray" :strike-through nil))) "Face for Org Mode DONE items.")
  (custom-set-faces!
    '(org-headline-done :foreground "dim gray" :strike-through "dim gray"))

  (setq org-todo-keyword-faces
        '(("TODO" . +org-todo-todo-face)
          ("NEXT" . +org-todo-next-face)
          ("WAIT" . +org-todo-wait-face)
          ("DONE" . +org-todo-done-face)))

  ;; Capture templates
  (setq org-inbox-file (expand-file-name "inbox.org" org-directory)
        org-notes-file (expand-file-name "notes.org" org-directory))
  (setq org-capture-templates
        '(("t" "Todo" entry (file org-inbox-file) "* TODO %?")
          ("n" "Note" plain (file+olp+datetree org-notes-file) "%U %?\n")
          ("c" "Comment" plain (file+olp+datetree org-notes-file) "%U %?\n%a")))

  ;; Keybindings
  (map! :map (org-mode-map
               org-agenda-mode-map)
        :nvi "C-c a" 'org-agenda)
  (map! :nv "C-c c" 'org-capture)

  ;; FIXME: Add custom timestamp format for exporting
  ;; Adapted from: https://endlessparentheses.com/better-time-stamps-in-org-export.html
  (require 'ox)
  (add-to-list 'org-export-filter-timestamp-functions
               #'eleks/org-filter-timestamp-remove-brackets)

  (setq-default org-display-custom-times 't)
  (setq org-time-stamp-custom-formats
        '("<%y-%m-%d>" . "%F"))
)

(defun eleks/org-filter-timestamp-remove-brackets (trans backend _comm)
  "Remove <> around a timestamp."
  (cond
   ((org-export-derived-backend-p backend 'md)
    (replace-regexp-in-string "&[lg]t;\\|[][]" "" trans))))
