(set-logic horn)
(set-option :fp.spacer.gpdr true)
(set-option :fp.spacer.mbqi false)
(assert (exists ((a int)) (= a 0)))
(check-sat)