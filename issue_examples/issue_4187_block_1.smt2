(set-option :proof true)
(set-option :rewriter.pull_cheap_ite true)
(declare-datatypes ((a 0)) (((j) (b))))
(declare-sort c 0)
(declare-fun d () (array c a))
(declare-fun f () (array c a))
(declare-fun h () (array c a))
(declare-fun k () (array c (array c a)))
(declare-fun l () (array c (array c a)))
(assert (forall ((e c)) (= (select k e) d)))
(assert (forall ((m c)) (= (select f m) j)))
(assert (forall ((g c)) (= (select l g) f)))
(assert (forall ((i c)) (= (select h i) b)))
(check-sat)