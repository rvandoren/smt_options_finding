(set-option :sat.phase sticky)
(set-logic qf_nia)
(declare-fun x () int)
(declare-fun y () int)
(assert (= (* x x x) (+ (* y y) 1)))
(assert (>= x 0))
(assert (< y 10))
(check-sat)