(set-option :random-seed 42)
(set-option :produce-models true)
;
(set-info :status sat)
(declare-fun tmp_reglan0 () (regex string))
(assert
(let ((?x1276 (re.* re.allchar)))
(let ((?x1279 (re.* tmp_reglan0)))
(= ?x1279 ?x1276))))
(check-sat)