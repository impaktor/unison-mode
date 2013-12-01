;;; unison-mode.el --- Syntax highlighting for unison file synchronization program

;; Copyright (C) 2013  Karl Fogelmark

;; Author: Karl Fogelmark <karlfogel@gmail.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;; Latest versio available at https://github.com/impaktor/unison-mode

;; Install by putting this file in ~/.emacs.d/elisp/ and this code in your
;; emacs configuration (~/.emacs):
;;
;; (add-to-list 'load-path "~/.emacs.d/elisp/")
;; (autoload 'unison-mode "unison-mode" "my unison mode" t)
;; (setq auto-mode-alist (append '(("\\.prf$" . unison-mode)) auto-mode-alist))

;;  Resources used when making this mode:
;;  http://www.emacswiki.org/emacs/ModeTutorial
;;  http://www.ergoemacs.org/emacs/elisp_syntax_coloring.html
;;  http://www.cis.upenn.edu/~bcpierce/unison/download/releases/stable/unison-manual.html#tutorial


;;; Code:

;; allow users to have hooks with this mode
(defvar unison-mode-hook nil "Hook run after `unison-mode'.")


(defvar unison-basic
  (regexp-opt
   '("auto" "batch" "fat" "group" "ignore" "nocreation" "nodeletion"
     "noupdate" "owner" "path" "perms" "root" "silent" "terse"
     "testserver" "times" "version")
   'words)
  "basic unison options")


(defvar unison-advanced
  (regexp-opt
   '("addprefsto" "addversionno" "backup" "backupcurr" "backupcurrnot"
     "backupdir" "backuploc" "backupnot" "backupprefix" "backups"
     "confirmbigdel" "confirmmerge" "contactquietly" "copyprog"
     "copyprogrest" "copyquoterem" "copythreshold" "debug" "diff"
     "dontchmod" "dumbtty" "fastcheck" "follow" "force" "forcepartial"
     "halfduplex" "height" "host" "ignorecase" "ignoreinodenumbers"
     "ignorelocks" "immutable" "immutablenot" "key" "killserver" "label"
     "links" "log" "logfile" "maxbackups" "maxerrors" "maxthreads"
     "merge" "nocreationpartial" "nodeletionpartial" "noupdatepartial"
     "numericids" "prefer" "preferpartial" "repeat" "retry" "rootalias"
     "rsrc" "rsync" "selftest" "servercmd" "showarchive" "sortbysize"
     "sortfirst" "sortlast" "sortnewfirst" "sshargs" "sshcmd" "stream"
     "ui" "unicode" "xferbycopying")
   'words)
  "advanced unison options")


(defvar unison-other
  (regexp-opt
   '("rshargs" "include")
   'words)
  "random words")


(defvar unison-foo
  (regexp-opt
   '("Path" "Name" "Regex")
   'words)
  "random words")


;; "<>" is used to match only whole words, i.e. preceeded and/or
;; followed by new line, or space.
(defvar unison-font-lock-keywords
  `((,unison-basic    . font-lock-function-name-face)
    (,unison-advanced . font-lock-builtin-face)
    (,unison-foo      . font-lock-keyword-face)
    (,unison-other    . font-lock-type-face)
    ("\\<\\(true\\|false\\)\\>" . font-lock-constant-face)))


;; Tell emacs what is a word, etc. Usied by syntax highlighting
;; package font-lock function will read this. Character (to modify)
;; are prefixed with a "?".
(defvar unison-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?_  "w"  st)  ; word constituent
    (modify-syntax-entry ?#  "<"  st)  ; coment start
    (modify-syntax-entry ?\n ">"  st)  ; coment end
    st)
  "Syntax table for unison-mode")


;; entry function, to be called by emacs when we enter the mode:
;;;###autoload
(define-derived-mode unison-mode prog-mode "Unison"
  "Majoe mode for font-lcoking unison configuration files"
  :syntax-table unison-mode-syntax-table

  (set (make-local-variable 'font-lock-defaults)      ; font lock
       '(unison-font-lock-keywords))

  ;; comment syntax for `newcomment.el'
  (set (make-local-variable 'comment-start)      "# ")
  (set (make-local-variable 'comment-end)        "")
  (set (make-local-variable 'comment-start-skip) "#+\\s-*")

  (run-hooks 'unison-mode-hook))  ; run user hooks last.

(provide 'unison-mode)
;;; unison-mode.el ends here
