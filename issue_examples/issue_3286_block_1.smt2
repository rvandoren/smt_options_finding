(set-option :proof true)
(declare-fun a () int)
(declare-fun b () int)
(assert (>= a 0 a ( * a b)))
(check-sat)