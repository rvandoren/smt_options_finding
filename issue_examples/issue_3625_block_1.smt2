(set-option :trace true)
(set-option :smt.random_seed 1)
(declare-fun a () int)
(declare-fun b () int)
(declare-fun c () int)
(declare-fun d () int)
(declare-fun h () int)
(declare-fun e () int)
(declare-fun f () int)
(declare-fun g () int)
(declare-fun i () int)
(assert (and (or (not (<= 6 e)) (= e (+ (* (/ d i)) 2) 0))
(= (not (<= (+ (+ (/ a (/ b h)))) 6)) (= (+ (+ f (/ d i))) 0))
(= (+ (* (/ c g))) 1)))
(check-sat)