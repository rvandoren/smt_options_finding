(assert
(forall ((a1 real))
(= (^ a1 4.0) (* (^ a1 2.0) (^ a1 2.0)) )
)
)
(check-sat)