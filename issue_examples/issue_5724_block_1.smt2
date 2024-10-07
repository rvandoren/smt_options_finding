(set-option :encoding ascii)
(declare-fun x () string)
(assert (not (str.in.re x (re.* (re.union (re.range "\u{0}" "\u{7f}") (re.range "\u{80}" "\u{ff}"))))))
(check-sat)