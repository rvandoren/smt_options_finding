(set-option :rewriter.push_ite_arith true)
(set-option :smt.arith.solver 3)
(set-option :smt.phase_selection 5)
(declare-fun b () int)
(declare-fun c () int)
(declare-fun al (int) bool)
(declare-fun m (int) bool)
(declare-fun ap (int) bool)
(declare-fun ar (int) bool)
(declare-fun e (int) int)
(declare-fun n (int) int)
(declare-fun f (int) bool)
(declare-fun o (int) bool)
(declare-fun ab (int) bool)
(declare-fun a (int) bool)
(assert (let ((a (o 1)) (am (n 2))) (let ((g (<= 1 am))) (= g a))))
(assert
(let ((an (e 0)) (cd 0) (h 0) (i (f 0)))
(let ((j (ite i cd an)) (ao (a (- 1))))
(let ((k (ite ao j h)) (l (= b 0)))
(let ((p (ite l 0 k)) (d 0)) (= d p))))))
(assert
(let ((cg c) (ax (+ c (- 1))))
(let ((ba ax))
(let ((bb (+ 1 ba)) (bc (a c)))
(let ((bd (ite bc bb ba)) (be (ar c)))
(let ((bf (ite be bd ba)) (bg (ab c)))
(let ((bh (ite bg 1 ba)) (bi (ap c)))
(let ((bj (ite bi bh bf)) (bk 0) (aw (o c)))
(let ((bl (ite aw bk ba)) (bm (m c)))
(let ((bn (ite bm bl bj)) (bo (f c)))
(let ((ch (ite bo b ba)) (bp (al c)))
(let ((bq (ite bp ch bn)) (br (= c b)))
(let ((bs (ite br 0 bq))) (= bs cg))))))))))))))
(check-sat)