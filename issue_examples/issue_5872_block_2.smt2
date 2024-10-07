(set-option :random-seed 42)
(set-option :produce-models true)
;
(set-info :status sat)
(declare-fun tmp_reglan1 () (regex string))
(assert
(let ((?x56 (str.to_re "b")))
(let ((?x1007 (re.comp ?x56)))
(let ((?x1008 (re.inter re.allchar ?x1007)))
(let ((?x991 (re.diff re.allchar tmp_reglan1)))
(= ?x991 ?x1008))))))
(check-sat)