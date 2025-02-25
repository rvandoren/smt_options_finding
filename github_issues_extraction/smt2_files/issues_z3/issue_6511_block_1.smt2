(set-option :smt.mbqi false)
(declare-sort P 0)
(declare-const someP P)

(push) ;; When commented out: unsat, otherwise: unknown

(assert (not (exists ((otherP P))
(= otherP someP)
)))
(check-sat)