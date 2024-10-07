(set-option :proof true)
(declare-fun a () string)
(assert (= (str.replace "b" (str.replace "" a "a") "") (str.replace "b" a "")))
(check-sat)