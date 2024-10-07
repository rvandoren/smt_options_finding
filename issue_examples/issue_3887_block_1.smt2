(set-option :proof true)
(declare-datatypes () ((a (b (c int) (d a)) f)))
(assert (forall ((e a)) (= (c e) 0)))
(check-sat)