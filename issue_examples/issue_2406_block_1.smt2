(set-option :produce-unsat-cores true)
(set-logic qf_idl)
(declare-const f1 int)
(declare-const f2 int)
(declare-const f3 int)
(assert (! (< f1 f2 ) :named a))
(assert (! (< f3 f1 ) :named b))
(check-sat)
(get-model)