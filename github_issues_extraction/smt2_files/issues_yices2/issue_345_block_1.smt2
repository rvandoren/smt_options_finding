(set-option :produce-unsat-model-interpolants true)
(set-logic QF_NRA)

(declare-fun x () Real)
(declare-fun y () Real)

(assert (not (<= (/ 1 4) (+ (* (+ x (- 1)) (+ x (- 1))) (* (+ 1 y) (+ 1 y))))))

;; model to refute:
;; (= b false)
;; (= y -17/32)
;; (= x 23/16)
(check-sat-assuming-model (y x) ((/ (- 17) 32) (/ 23 16)))