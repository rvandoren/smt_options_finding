(set-option :smt.threads 2)
(declare-fun a () int)
(declare-fun b () int)
(declare-fun c () int)
(declare-fun d () int)
(declare-fun m () int)
(declare-fun e () int)
(declare-fun f () int)
(declare-fun n () int)
(declare-fun g () int)
(declare-fun h () int)
(declare-fun i () int)
(declare-fun j () int)
(declare-fun k () int)
(declare-fun l () int)
(declare-fun o () int)
(declare-fun w () int)
(declare-fun p () int)
(declare-fun q () int)
(declare-fun r () int)
(declare-fun s () int)
(declare-fun x () int)
(declare-fun t () int)
(declare-fun y () int)
(declare-fun u () int)
(declare-fun v () int)
(assert (or (= a 0) (= a 1)))
(assert (or (= n 0) (= n 1) (= g 0) (= g 1)))
(assert (xor (= h 0) (= i 1)))
(assert (<= 7 (+ b c d m e f n)))
(assert (<= (+ o w p) 1))
(assert (<= (* 2 (+ a b c d m n)) (* 3 (+ g h j k l)) p r s 1))
(assert (<= b 1 (+ o c) 1))
(assert (<= (+ q t) 1))
(assert (<= (+ r y  n) 1))
(assert (<= (+ s l) 1))
(assert (<= (+ y k  1) 1))
(assert (<= (* e 2) (* j t) v))
(assert (<= (+ (* f 2)) (* y 4) x))
(minimize u)
(check-sat)