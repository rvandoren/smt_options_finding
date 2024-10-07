(set-option :auto_config false)
(get-option :smt.relevancy) ;; yields 2 in both versions
; (set-option :smt.relevancy 2) ;; tried this
(set-option :smt.case_split 3)
(check-sat)