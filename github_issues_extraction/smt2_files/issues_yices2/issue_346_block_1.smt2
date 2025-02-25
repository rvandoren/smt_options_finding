(set-option :produce-unsat-model-interpolants true)
(set-logic QF_NRA)

(declare-fun x () Real)
(declare-fun y () Real)
(declare-fun z () Real)

(assert (< x 1))
(assert (< y 1))
(assert (> x (- 1)))
(assert (> y (- 1)))

(assert
(or
(> (+ (* x x) (* y y)) 2)
(> z 0)
)
)

(check-sat-assuming-model (z) (0))