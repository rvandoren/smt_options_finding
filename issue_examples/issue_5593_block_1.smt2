(set-option :random-seed 0)
(set-option :produce-models true)
(set-option :produce-unsat-cores true)
;
(set-info :status unsat)
(assert (!
(let ((?x277 ((as const (array (_ bitvec 4) string)) "")))
(let ((?x225 (store ?x277 (_ bv2 4) "a")))
(let ((?x467 ((as const (array (_ bitvec 4) string)) "a")))
(let ((?x146 (store ?x467 (_ bv0 4) "")))
(= ?x146 ?x225))))) :named a0))
(check-sat)