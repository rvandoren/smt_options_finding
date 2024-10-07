(set-option :rewriter.eq2ineq true)
(set-option :smt.core.extend_patterns true)
(assert (forall ((a int) (b int)) (distinct b a)))
(check-sat)