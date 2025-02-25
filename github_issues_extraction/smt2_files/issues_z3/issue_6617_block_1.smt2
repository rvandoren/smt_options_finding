(set-logic HORN)

(declare-fun |P1| ( Int Int Int Int ) Bool)
(declare-fun |P2| ( Int Int Int Int ) Bool)
(declare-fun |P3| ( Int Int Int Int ) Bool)

(assert (forall ((A Int) (B Int) (C Int) (D Int))
(or (not (P1 A B C D)) (P3 A B C D))))

(assert (forall ((A Int) (B Int) (C Int) (D Int))
(or (not (P2 A B C D)) (P3 A B C D))))

(assert (forall ((A Int) (B Int) (C Int)) (P1 A B C (- 2))))

(assert (forall ((A Int) (B Int) (C Int) (D Int) (E Int)
(F Int) (G Int) (H Int) (I Int) (J Int) (K Int))
(or (not (P1 H I J K)) (not (P1 D E F G)) (P2 C B A (+ G K)))))

(assert (not (P3 0 2 3 1)))

(check-sat)