(set-option :proof true)
(declare-fun a () string)
(declare-fun b () string)
(declare-fun c () string)
(declare-fun d () string)
(declare-fun e () string)
(declare-fun f () bool)
(declare-fun g () string)
(declare-fun h () int)
(declare-fun i () int)
(declare-fun j () string)
(declare-fun k () bool)
(declare-fun l () bool)
(declare-fun m () string)
(declare-fun n () string)
(declare-fun o () string)
(assert (ite k (xor (distinct i h (str.len (str.substr o 2 (str.len j)))))
(str.in.re (str.substr b 2 0) (str.to.re "."))))
(assert (= l (= "" (str.substr g 10 (str.len m))) (xor (= f l))
(distinct ""
(str.substr a 0
(str.len
(str.substr c 0
(str.len
(str.substr d 0
(str.len
(str.substr o
(str.len j)
(str.len (str.substr e 0 (str.len n)))))))))))))
(assert (distinct f l))
(assert (= a (str.++ n) c d o e))
(check-sat)