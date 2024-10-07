(set-option :fp.xform.instantiate_arrays true)
(assert (exists ((x int)) (forall ((y int)) (distinct x y))))
(check-sat)