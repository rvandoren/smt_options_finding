(set-logic ALL) ; Has to be set for yices
(set-option :global-declarations true)
;(set-option :auto_config false) ; unsupported: cvc5, yices
;(set-option :smt.case_split 3) ; unsupported: cvc5, yices
;(set-option :smt.delay_units true) ; unsupported: cvc5, yices
;(set-option :type_check true)
;(set-option :smt.mbqi false)
;(set-option :pp.bv_literals false)
;(set-option :smt.qi.eager_threshold 100)
;(set-option :smt.arith.solver 2)
;(set-option :model.v2 true)
;(set-option :smt.qi.max_multi_patterns 1000)
;(set-option :smt.arith.solver 4)
;(set-option :smt.phase_selection 5)
;(set-option :rewriter.eq2ineq true)
;(set-option :rewriter.arith_ineq_lhs true)
;(set-option :rewriter.hoist_mul true)
;(set-option :model_evaluator.array_equalities false)


(set-option :seed 0)
(set-option :sat-random-seed 0)
(set-option :incremental true)
(set-option :condense-function-values false)
(set-option :strict-parsing false)
(set-option :produce-models true)
(set-option :global-declarations true)
(set-option :type-checking true)

(declare-fun x () Int)
(declare-fun y1 () Int)
(declare-fun y2 () Int)
(declare-fun z () Int)

(assert (= x y1))
(assert (not (= y1 z)))
(assert (= x y2))
(assert (and (> y2 0) (< y2 5)))

(check-sat)