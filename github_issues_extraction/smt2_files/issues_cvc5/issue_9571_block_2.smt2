(set-logic QF_ALL)
(set-info :smt-lib-version 2.6)

(set-option :produce-models true)

; Heap declaration

(declare-heap (Int Int))

(declare-const v Int)

(assert (not (sep
(pto 1 v)
(pto 2 v)
)))

(check-sat)
(get-model)