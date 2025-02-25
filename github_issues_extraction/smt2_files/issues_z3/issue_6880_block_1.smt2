(set-option :auto_config false)
(set-option :smt.mbqi false)

(declare-sort Foo)
(declare-fun one (Foo) Bool)
(declare-fun two (Foo) Bool)

(declare-fun dummy_pattern (Foo) Bool)

(assert
(forall ((f Foo)) (!
(=>
(one f)
(two f)
)
:pattern (dummy_pattern f)
:qid forall_f_one_two
))
)

(declare-const f1 Foo)
(assert (not
(=>
(one f1)
(two f1)
)
))

(check-sat)