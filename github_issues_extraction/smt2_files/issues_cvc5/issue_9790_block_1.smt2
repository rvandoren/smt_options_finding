(set-logic QF_ALL)
(set-option :produce-models true)
;(set-option :strings-exp true)

(declare-const z Int)
;(assert (= "5" (str.from_int z)))
(assert (= 5 z))
(check-sat)
(get-model)