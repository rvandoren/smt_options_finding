(set-option :sat.local_search true)
(set-option :sat.xor.solver true)
(declare-fun x0 () bool)
(declare-fun x2 () bool)
(declare-fun x3 () bool)
(assert (xor (or x2 x3) (xor x3 (or x0 x3))))
(check-sat)