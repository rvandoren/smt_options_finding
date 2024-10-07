(set-option :produce-models true)
(set-info :status sat)
(declare-fun tmp_int2 () int)
(assert
(= (str.indexof "" "" tmp_int2) (- 1)))
(check-sat)