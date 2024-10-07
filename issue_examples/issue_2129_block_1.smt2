(set-option :produce-models true)
(set-logic all)
(declare-fun f ((_ bitvec 32) bool int) (_ bitvec 16))
(check-sat)