(set-option :smt.threads 2)
(declare-fun a () real)
(declare-fun b () real)
(declare-fun c () real)
(declare-fun d () real)
(declare-fun aa () real)
(declare-fun e () real)
(assert (not (exists ((f real))
(= (=> (<= 0.0 f b)
(<= 0.0 (+ (/ (*  (- a aa)) f (* (div a aa)) f)) d))
(distinct e 2.0)))))
(assert (= a (+ c aa)))
(check-sat)