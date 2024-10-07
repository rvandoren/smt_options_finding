(declare-fun |byte#0| () int)
(set-option :timeout 0)
(assert (not
(let ((anon0_correct (= (concat #x000000000000000000000000000000 ((_ int2bv 8) |byte#0|)) ((_ int2bv 128) |byte#0|))))
(=> (and (<= 0 |byte#0|) (<= |byte#0| 255)) anon0_correct))
))
(check-sat)