;;; com-css-sort-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "com-css-sort" "com-css-sort.el" (23855 26030
;;;;;;  875819 542000))
;;; Generated autoloads from com-css-sort.el

(autoload 'com-css-sort-move-line-up "com-css-sort" "\
Move up the current line.

\(fn)" nil nil)

(autoload 'com-css-sort-move-line-down "com-css-sort" "\
Move down the current line.

\(fn)" nil nil)

(autoload 'com-css-sort-back-to-indentation-or-beginning "com-css-sort" "\
Toggle between first character and beginning of line.

\(fn)" nil nil)

(autoload 'com-css-sort-goto-first-char-in-line "com-css-sort" "\
Goto beginning of line but ignore 'empty characters'(spaces/tabs).

\(fn)" nil nil)

(autoload 'com-css-sort-current-line-empty-p "com-css-sort" "\
Current line empty, but accept spaces/tabs in there.  (not absolute).

\(fn)" nil nil)

(autoload 'com-css-sort-next-blank-or-comment-line "com-css-sort" "\
Move to the next line containing nothing but whitespace or first character is a comment line.

\(fn)" nil nil)

(autoload 'com-css-sort-next-non-blank-or-comment-line "com-css-sort" "\
Move to the next line that is exactly the code.
Not the comment or empty line.

\(fn)" nil nil)

(autoload 'com-css-sort-attributes-block "com-css-sort" "\
Sort CSS attributes in the block.
NO-BACK-TO-LINE : Do not go back to the original line.

\(fn &optional NO-BACK-TO-LINE)" t nil)

(autoload 'com-css-sort-attributes-document "com-css-sort" "\
Sort CSS attributes the whole documents.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; com-css-sort-autoloads.el ends here
