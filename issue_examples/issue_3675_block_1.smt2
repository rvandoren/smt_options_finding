(set-option :sat.prob_search true)
(declare-fun a () bool)
(declare-fun b () bool)
(assert a)
(assert b)
(check-sat)