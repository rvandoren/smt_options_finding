(set-option :proof true)
(set-option :smt.clause_proof true)
(declare-fun a () real)
(declare-fun b () real)
(declare-fun c () real)
(assert (= (< c a) (< 0 (* (- a c) b))))
(check-sat)