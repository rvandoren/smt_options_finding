(set-option :random-seed 0)
(set-option :produce-models true)
(set-option :produce-unsat-cores true)
(declare-fun tmp_int3 () int)
(declare-fun tmp_str2_fresh () string)
(declare-fun integer () int)
(declare-fun result () string)
(assert (!
(and (= (int.to.str tmp_int3) tmp_str2_fresh) (= (= tmp_int3 0) true)) :named a1))
(assert (!
(let ((?x105 (mod integer 10)))
(let ((?x106 (int.to.str ?x105)))
(let ((?x103 (div integer 10)))
(let ((?x104 (int.to.str ?x103)))
(let ((?x107 (str.++ ?x104 ?x106)))
(let (($x108 (= result ?x107)))
(let (($x109 (= $x108 true)))
(let (($x102 (>= integer 10)))
(let (($x110 (=> $x102 $x109)))
(let (($x89 (= result "9")))
(let (($x90 (= $x89 true)))
(let (($x86 (= integer 9)))
(let (($x87 (= $x86 true)))
(let (($x91 (=> $x87 $x90)))
(let (($x82 (= result "8")))
(let (($x83 (= $x82 true)))
(let (($x79 (= integer 8)))
(let (($x80 (= $x79 true)))
(let (($x84 (=> $x80 $x83)))
(let (($x92 (and $x84 $x91)))
(let (($x75 (= result "7")))
(let (($x76 (= $x75 true)))
(let (($x72 (= integer 7)))
(let (($x73 (= $x72 true)))
(let (($x77 (=> $x73 $x76)))
(let (($x93 (and $x77 $x92)))
(let (($x68 (= result "6")))
(let (($x69 (= $x68 true)))
(let (($x65 (= integer 6)))
(let (($x66 (= $x65 true)))
(let (($x70 (=> $x66 $x69)))
(let (($x94 (and $x70 $x93)))
(let (($x61 (= result "5")))
(let (($x62 (= $x61 true)))
(let (($x58 (= integer 5)))
(let (($x59 (= $x58 true)))
(let (($x63 (=> $x59 $x62)))
(let (($x95 (and $x63 $x94)))
(let (($x54 (= result "4")))
(let (($x55 (= $x54 true)))
(let (($x51 (= integer 4)))
(let (($x52 (= $x51 true)))
(let (($x56 (=> $x52 $x55)))
(let (($x96 (and $x56 $x95)))
(let (($x47 (= result "3")))
(let (($x48 (= $x47 true)))
(let (($x44 (= integer 3)))
(let (($x45 (= $x44 true)))
(let (($x49 (=> $x45 $x48)))
(let (($x97 (and $x49 $x96)))
(let (($x40 (= result "2")))
(let (($x41 (= $x40 true)))
(let (($x37 (= integer 2)))
(let (($x38 (= $x37 true)))
(let (($x42 (=> $x38 $x41)))
(let (($x98 (and $x42 $x97)))
(let (($x33 (= result "1")))
(let (($x34 (= $x33 true)))
(let (($x30 (= integer 1)))
(let (($x31 (= $x30 true)))
(let (($x35 (=> $x31 $x34)))
(let (($x99 (and $x35 $x98)))
(let (($x24 (= integer 0)))
(let (($x25 (= $x24 true)))
(let (($x665 (and (and (=> $x25 (= (= result tmp_str2_fresh) true)) $x99) $x110)))
(let (($x21 (= result "")))
(let (($x22 (= $x21 true)))
(let (($x19 (< integer 0)))
(let (($x23 (=> $x19 $x22)))
(and $x23 $x665)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) :named a2))
(assert (!
(let ((?x15 (int.to.str integer)))
(let (($x16 (= ?x15 result)))
(not $x16))) :named a0))
(check-sat)
(get-model)