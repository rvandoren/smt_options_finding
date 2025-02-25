(set-option :produce-unsat-model-interpolants true)
(set-logic QF_NRA)

(declare-fun b1 () Bool)
(declare-fun b2 () Bool)
(declare-fun x () Real)
(declare-fun y () Real)

(assert (and (not b2) (not (<= (/ 1 16) (+ (* (+ x (- (/ 3333333333333333 10000000000000000))) (+ x (- (/ 3333333333333333 10000000000000000)))) (* (+ (- (/ 3333333333333333 10000000000000000)) y) (+ (- (/ 3333333333333333 10000000000000000)) y)))))))

(check-sat-assuming-model (x) ((- 2)))