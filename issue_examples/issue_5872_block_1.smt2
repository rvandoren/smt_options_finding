(set-option :produce-unsat-cores true)
;
(set-info :status unsat)
(assert (!
(let ((?x844 ((_ re.loop 0) re.all)))
(= ?x844 re.all)) :named a0))
(check-sat)