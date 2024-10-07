(set-option :smt.arith.solver 1)
(declare-fun a () string)
(assert (str.in.re a (re.* (str.to.re "a"))))
(check-sat)