(set-logic ALL) ; Has to be set for yices
(set-option :global-decls true)
(set-option :auto_config false) ; unsupported: cvc5, yices
(set-option :smt.case_split 3) ; unsupported: cvc5, yices
(set-option :smt.delay_units true) ; unsupported: cvc5, yices
(set-option :type_check false)
(set-option :smt.mbqi false)
(set-option :pp.bv_literals false)
(set-option :smt.qi.eager_threshold 100)
(set-option :smt.arith.solver 2)
(set-option :smt.qi.max_multi_patterns 1000)
(set-option :smt.phase_selection 5)
(set-option :proof true)
(set-option :sat.branching.heuristic symbol)
(set-option :sat.restart symbol)
(set-option :sat.elim_vars false)
(set-option :sat.local_search true)
(set-option :smt.arith.solver 4)
(set-option :smt.arith.nl false)
(set-option :smt.elim_unconstrained false)

(declare-fun x () Int)
(declare-fun y1 () Int)
(declare-fun y2 () Int)
(declare-fun z () Int)

(assert (= x y1))
(assert (not (= y1 z)))
(assert (= x y2))
(assert (and (> y2 0) (< y2 5)))

(check-sat)