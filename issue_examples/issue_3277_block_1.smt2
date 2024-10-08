(set-logic all)
(set-option :model_validate true)
(set-option :model true)
(set-option :smt.arith.solver 4)
(declare-const v0 bool)
(declare-const v1 bool)
(declare-const v2 bool)
(declare-const v3 bool)
(declare-const v4 bool)
(declare-const v5 bool)
(declare-const i1 int)
(declare-const i2 int)
(declare-const r0 real)
(declare-const r4 real)
(declare-const r6 real)
(assert (= v4 (< i2 i2) v4 v1 v4 (< i2 i2)))
(declare-sort s0 0)
(declare-const bv_14-0 (_ bitvec 14))
(declare-const v6 bool)
(declare-const v7 bool)
(declare-const v8 bool)
(declare-const r9 real)
(assert v7)
(declare-const s0-0 s0)
(assert (not v1))
(declare-const i4 int)
(declare-const s0-1 s0)
(declare-const bv_18-0 (_ bitvec 18))
(assert (<= 14117.811 r6 0.0))
(assert (> 51605.0 (/ r6 8.4853719) r4))
(check-sat)