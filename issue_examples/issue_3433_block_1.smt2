(set-option :smt.phase_selection 5)
(set-option :smt.threads 10)
(declare-fun a () string)
(assert (distinct (str.len a) 83))
(check-sat)