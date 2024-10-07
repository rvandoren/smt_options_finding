(set-option :random-seed 42)
(set-option :produce-models true)
;
(set-info :status sat)
(declare-fun tmp_str0 () string)
(assert
(let (($x444 (str.contains tmp_str0 tmp_str0)))
(let ((?x16 (re.range tmp_str0 tmp_str0)))
(let ((?x598 (str.replace tmp_str0 tmp_str0 tmp_str0)))
(let (($x602 (str.in_re ?x598 ?x16)))
(= $x602 $x444))))))
(check-sat)