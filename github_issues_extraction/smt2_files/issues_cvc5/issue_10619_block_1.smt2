(set-logic QF_BVFP)
(set-option :produce-unsat-assumptions true)

(declare-fun a () Bool)
(declare-fun b () Bool)
(declare-fun c () Bool)
(declare-fun d () Bool)
(declare-fun e () Bool)

(assert (or a b))
(assert (or a (not b)))
(assert (or (or c d) e))

(check-sat-assuming ((not a) c d e))