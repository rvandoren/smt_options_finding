(set-option :produce-models true)
(set-logic all)
(declare-datatypes ((state 0)) (((idle) (ready) (critical))))
(define-fun state_constrindex ((x state)) int
(ite (= x idle) 0 (ite (= x ready) 1 2))
)
(define-fun s4 () int 3)
(define-fun s6 () state idle)
(define-fun s7 () int 0)
(define-fun s10 () state ready)
(define-fun s13 () int 1)
(define-fun s26 () state critical)
(define-fun s69 () int 2)
(define-fun s126 () (seq bool) (as seq.empty (seq bool)))
(declare-fun s0 () (seq state))
(declare-fun s1 () (seq state))
(declare-fun s2 () (seq int))
(define-fun s3 () int (seq.len s0))
(define-fun s5 () bool (= s3 s4))
(define-fun s8 () state (seq.nth s0 s7))
(define-fun s9 () bool (= s6 s8))
(define-fun s11 () bool (= s8 s10))
(define-fun s12 () bool (or s9 s11))
(define-fun s14 () int (- s3 s13))
(define-fun s15 () (seq state) (seq.extract s0 s13 s14))
(define-fun s16 () state (seq.nth s15 s7))
(define-fun s17 () bool (= s6 s16))
(define-fun s18 () bool (= s10 s16))
(define-fun s19 () bool (or s17 s18))
(define-fun s20 () int (seq.len s2))
(define-fun s21 () int (- s20 s13))
(define-fun s22 () (seq int) (seq.extract s2 s13 s21))
(define-fun s23 () int (seq.nth s22 s7))
(define-fun s24 () bool (= s13 s23))
(define-fun s25 () bool (and s11 s24))
(define-fun s27 () bool (= s16 s26))
(define-fun s28 () bool (= s8 s26))
(define-fun s29 () bool (or s17 s27))
(define-fun s30 () bool (= s8 s16))
(define-fun s31 () bool (ite s28 s29 s30))
(define-fun s32 () bool (ite s25 s27 s31))
(define-fun s33 () bool (ite s9 s19 s32))
(define-fun s34 () int (seq.len s15))
(define-fun s35 () int (- s34 s13))
(define-fun s36 () (seq state) (seq.extract s15 s13 s35))
(define-fun s37 () state (seq.nth s36 s7))
(define-fun s38 () bool (= s6 s37))
(define-fun s39 () bool (= s10 s37))
(define-fun s40 () bool (or s38 s39))
(define-fun s41 () int (seq.len s22))
(define-fun s42 () int (- s41 s13))
(define-fun s43 () (seq int) (seq.extract s22 s13 s42))
(define-fun s44 () int (seq.nth s43 s7))
(define-fun s45 () bool (= s13 s44))
(define-fun s46 () bool (and s18 s45))
(define-fun s47 () bool (= s26 s37))
(define-fun s48 () bool (or s38 s47))
(define-fun s49 () bool (= s16 s37))
(define-fun s50 () bool (ite s27 s48 s49))
(define-fun s51 () bool (ite s46 s47 s50))
(define-fun s52 () bool (ite s17 s40 s51))
(define-fun s53 () bool (and s33 s52))
(define-fun s54 () bool (and s12 s53))
(define-fun s55 () bool (and s9 s54))
(define-fun s56 () bool (and s5 s55))
(define-fun s57 () int (seq.len s1))
(define-fun s58 () bool (= s4 s57))
(define-fun s59 () state (seq.nth s1 s7))
(define-fun s60 () bool (= s6 s59))
(define-fun s61 () bool (= s10 s59))
(define-fun s62 () bool (or s60 s61))
(define-fun s63 () int (- s57 s13))
(define-fun s64 () (seq state) (seq.extract s1 s13 s63))
(define-fun s65 () state (seq.nth s64 s7))
(define-fun s66 () bool (= s6 s65))
(define-fun s67 () bool (= s10 s65))
(define-fun s68 () bool (or s66 s67))
(define-fun s70 () bool (= s23 s69))
(define-fun s71 () bool (and s61 s70))
(define-fun s72 () bool (= s26 s65))
(define-fun s73 () bool (= s26 s59))
(define-fun s74 () bool (or s66 s72))
(define-fun s75 () bool (= s59 s65))
(define-fun s76 () bool (ite s73 s74 s75))
(define-fun s77 () bool (ite s71 s72 s76))
(define-fun s78 () bool (ite s60 s68 s77))
(define-fun s79 () int (seq.len s64))
(define-fun s80 () int (- s79 s13))
(define-fun s81 () (seq state) (seq.extract s64 s13 s80))
(define-fun s82 () state (seq.nth s81 s7))
(define-fun s83 () bool (= s6 s82))
(define-fun s84 () bool (= s10 s82))
(define-fun s85 () bool (or s83 s84))
(define-fun s86 () bool (= s44 s69))
(define-fun s87 () bool (and s67 s86))
(define-fun s88 () bool (= s26 s82))
(define-fun s89 () bool (or s83 s88))
(define-fun s90 () bool (= s65 s82))
(define-fun s91 () bool (ite s72 s89 s90))
(define-fun s92 () bool (ite s87 s88 s91))
(define-fun s93 () bool (ite s66 s85 s92))
(define-fun s94 () bool (and s78 s93))
(define-fun s95 () bool (and s62 s94))
(define-fun s96 () bool (and s60 s95))
(define-fun s97 () bool (and s58 s96))
(define-fun s98 () bool (= s4 s20))
(define-fun s99 () int (seq.nth s2 s7))
(define-fun s100 () bool (= s13 s99))
(define-fun s101 () bool (= s69 s99))
(define-fun s102 () bool (or s100 s101))
(define-fun s103 () bool (or s28 s73))
(define-fun s104 () bool (not s103))
(define-fun s105 () bool (or s100 s104))
(define-fun s106 () bool (or s24 s70))
(define-fun s107 () bool (or s27 s72))
(define-fun s108 () bool (not s107))
(define-fun s109 () bool (= s23 s99))
(define-fun s110 () bool (or s108 s109))
(define-fun s111 () bool (or s45 s86))
(define-fun s112 () bool (or s47 s88))
(define-fun s113 () bool (not s112))
(define-fun s114 () bool (= s23 s44))
(define-fun s115 () bool (or s113 s114))
(define-fun s116 () bool (and s111 s115))
(define-fun s117 () bool (and s110 s116))
(define-fun s118 () bool (and s106 s117))
(define-fun s119 () bool (and s105 s118))
(define-fun s120 () bool (and s102 s119))
(define-fun s121 () bool (and s100 s120))
(define-fun s122 () bool (and s98 s121))
(define-fun s123 () bool (= s3 s7))
(define-fun s124 () bool (= s7 s57))
(define-fun s125 () bool (or s123 s124))
(define-fun s127 () bool (distinct s8 s26))
(define-fun s128 () bool (distinct s26 s59))
(define-fun s129 () bool (or s127 s128))
(define-fun s130 () (seq bool) (seq.unit s129))
(define-fun s131 () bool (= s7 s34))
(define-fun s132 () bool (= s7 s79))
(define-fun s133 () bool (or s131 s132))
(define-fun s134 () bool (distinct s16 s26))
(define-fun s135 () bool (distinct s26 s65))
(define-fun s136 () bool (or s134 s135))
(define-fun s137 () (seq bool) (seq.unit s136))
(define-fun s138 () int (seq.len s36))
(define-fun s139 () bool (= s7 s138))
(define-fun s140 () int (seq.len s81))
(define-fun s141 () bool (= s7 s140))
(define-fun s142 () bool (or s139 s141))
(define-fun s143 () bool (distinct s26 s37))
(define-fun s144 () bool (distinct s26 s82))
(define-fun s145 () bool (or s143 s144))
(define-fun s146 () (seq bool) (seq.unit s145))
(define-fun s147 () (seq bool) (ite s142 s126 s146))
(define-fun s148 () (seq bool) (seq.++ s137 s147))
(define-fun s149 () (seq bool) (ite s133 s126 s148))
(define-fun s150 () (seq bool) (seq.++ s130 s149))
(define-fun s151 () (seq bool) (ite s125 s126 s150))
(define-fun s152 () int (seq.len s151))
(define-fun s153 () bool (= s7 s152))
(define-fun s154 () bool (seq.nth s151 s7))
(define-fun s155 () int (- s152 s13))
(define-fun s156 () (seq bool) (seq.extract s151 s13 s155))
(define-fun s157 () int (seq.len s156))
(define-fun s158 () bool (= s7 s157))
(define-fun s159 () bool (seq.nth s156 s7))
(define-fun s160 () int (- s157 s13))
(define-fun s161 () (seq bool) (seq.extract s156 s13 s160))
(define-fun s162 () int (seq.len s161))
(define-fun s163 () bool (= s7 s162))
(define-fun s164 () bool (seq.nth s161 s7))
(define-fun s165 () bool (or s163 s164))
(define-fun s166 () bool (and s159 s165))
(define-fun s167 () bool (or s158 s166))
(define-fun s168 () bool (and s154 s167))
(define-fun s169 () bool (or s153 s168))
(define-fun s170 () bool (not s169))
(assert s56)
(assert s97)
(assert s122)
(assert s170)
(check-sat)