(get-info :version)
; (:version "4.13.0")
; Started: 2024-09-24 15:18:03
; Silicon.version: 1.1-SNAPSHOT (b737e366)
; Input file: /Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr
; Verifier id: 00
; ------------------------------------------------------------
; Begin preamble
; ////////// Static preamble
; 
; ; /z3config.smt2
(set-option :print-success true) ; Boogie: false
(set-option :global-decls true) ; Necessary for push pop mode
(set-option :auto_config false)
(set-option :smt.case_split 3)
(set-option :smt.delay_units true)
(set-option :type_check true)
(set-option :smt.mbqi false)
(set-option :pp.bv_literals false)
(set-option :smt.qi.eager_threshold 100)
(set-option :smt.arith.solver 2)
(set-option :model.v2 true)
(set-option :smt.qi.max_multi_patterns 1000)
; 
; ; /preamble.smt2
(declare-datatypes (($Snap 0)) ((
    ($Snap.unit)
    ($Snap.combine ($Snap.first $Snap) ($Snap.second $Snap)))))
(declare-sort $Ref 0)
(declare-const $Ref.null $Ref)
(declare-sort $FPM 0)
(declare-sort $PPM 0)
(define-sort $Perm () Real)
(define-const $Perm.Write $Perm 1.0)
(define-const $Perm.No $Perm 0.0)
(define-fun $Perm.isValidVar ((p $Perm)) Bool
	(<= $Perm.No p))
(define-fun $Perm.isReadVar ((p $Perm)) Bool
    (and ($Perm.isValidVar p)
         (not (= p $Perm.No))))
(define-fun $Perm.min ((p1 $Perm) (p2 $Perm)) Real
    (ite (<= p1 p2) p1 p2))
(define-fun $Math.min ((a Int) (b Int)) Int
    (ite (<= a b) a b))
(define-fun $Math.clip ((a Int)) Int
    (ite (< a 0) 0 a))
; ////////// Sorts
(declare-sort Seq<Int> 0)
; ////////// Sort wrappers
; Declaring additional sort wrappers
(declare-fun $SortWrappers.IntTo$Snap (Int) $Snap)
(declare-fun $SortWrappers.$SnapToInt ($Snap) Int)
(assert (forall ((x Int)) (!
    (= x ($SortWrappers.$SnapToInt($SortWrappers.IntTo$Snap x)))
    :pattern (($SortWrappers.IntTo$Snap x))
    :qid |$Snap.$SnapToIntTo$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.IntTo$Snap($SortWrappers.$SnapToInt x)))
    :pattern (($SortWrappers.$SnapToInt x))
    :qid |$Snap.IntTo$SnapToInt|
    )))
(declare-fun $SortWrappers.BoolTo$Snap (Bool) $Snap)
(declare-fun $SortWrappers.$SnapToBool ($Snap) Bool)
(assert (forall ((x Bool)) (!
    (= x ($SortWrappers.$SnapToBool($SortWrappers.BoolTo$Snap x)))
    :pattern (($SortWrappers.BoolTo$Snap x))
    :qid |$Snap.$SnapToBoolTo$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.BoolTo$Snap($SortWrappers.$SnapToBool x)))
    :pattern (($SortWrappers.$SnapToBool x))
    :qid |$Snap.BoolTo$SnapToBool|
    )))
(declare-fun $SortWrappers.$RefTo$Snap ($Ref) $Snap)
(declare-fun $SortWrappers.$SnapTo$Ref ($Snap) $Ref)
(assert (forall ((x $Ref)) (!
    (= x ($SortWrappers.$SnapTo$Ref($SortWrappers.$RefTo$Snap x)))
    :pattern (($SortWrappers.$RefTo$Snap x))
    :qid |$Snap.$SnapTo$RefTo$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.$RefTo$Snap($SortWrappers.$SnapTo$Ref x)))
    :pattern (($SortWrappers.$SnapTo$Ref x))
    :qid |$Snap.$RefTo$SnapTo$Ref|
    )))
(declare-fun $SortWrappers.$PermTo$Snap ($Perm) $Snap)
(declare-fun $SortWrappers.$SnapTo$Perm ($Snap) $Perm)
(assert (forall ((x $Perm)) (!
    (= x ($SortWrappers.$SnapTo$Perm($SortWrappers.$PermTo$Snap x)))
    :pattern (($SortWrappers.$PermTo$Snap x))
    :qid |$Snap.$SnapTo$PermTo$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.$PermTo$Snap($SortWrappers.$SnapTo$Perm x)))
    :pattern (($SortWrappers.$SnapTo$Perm x))
    :qid |$Snap.$PermTo$SnapTo$Perm|
    )))
; Declaring additional sort wrappers
(declare-fun $SortWrappers.Seq<Int>To$Snap (Seq<Int>) $Snap)
(declare-fun $SortWrappers.$SnapToSeq<Int> ($Snap) Seq<Int>)
(assert (forall ((x Seq<Int>)) (!
    (= x ($SortWrappers.$SnapToSeq<Int>($SortWrappers.Seq<Int>To$Snap x)))
    :pattern (($SortWrappers.Seq<Int>To$Snap x))
    :qid |$Snap.$SnapToSeq<Int>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.Seq<Int>To$Snap($SortWrappers.$SnapToSeq<Int> x)))
    :pattern (($SortWrappers.$SnapToSeq<Int> x))
    :qid |$Snap.Seq<Int>To$SnapToSeq<Int>|
    )))
; ////////// Symbols
(declare-fun Seq_length (Seq<Int>) Int)
(declare-const Seq_empty Seq<Int>)
(declare-fun Seq_singleton (Int) Seq<Int>)
(declare-fun Seq_append (Seq<Int> Seq<Int>) Seq<Int>)
(declare-fun Seq_index (Seq<Int> Int) Int)
(declare-fun Seq_add (Int Int) Int)
(declare-fun Seq_sub (Int Int) Int)
(declare-fun Seq_update (Seq<Int> Int Int) Seq<Int>)
(declare-fun Seq_take (Seq<Int> Int) Seq<Int>)
(declare-fun Seq_drop (Seq<Int> Int) Seq<Int>)
(declare-fun Seq_contains (Seq<Int> Int) Bool)
(declare-fun Seq_contains_trigger (Seq<Int> Int) Bool)
(declare-fun Seq_skolem (Seq<Int> Int) Int)
(declare-fun Seq_equal (Seq<Int> Seq<Int>) Bool)
(declare-fun Seq_skolem_diff (Seq<Int> Seq<Int>) Int)
(declare-fun Seq_range (Int Int) Seq<Int>)
; Declaring symbols related to program functions (from program analysis)
; Snapshot variable to be used during function verification
(declare-fun s@$ () $Snap)
; Declaring predicate trigger functions
; ////////// Uniqueness assumptions from domains
; ////////// Axioms
(assert (forall ((s Seq<Int>)) (!
  (<= 0 (Seq_length s))
  :pattern ((Seq_length s))
  )))
(assert (= (Seq_length (as Seq_empty  Seq<Int>)) 0))
(assert (forall ((s Seq<Int>)) (!
  (=> (= (Seq_length s) 0) (= s (as Seq_empty  Seq<Int>)))
  :pattern ((Seq_length s))
  )))
(assert (forall ((e Int)) (!
  (= (Seq_length (Seq_singleton e)) 1)
  :pattern ((Seq_singleton e))
  )))
(assert (forall ((s0 Seq<Int>) (s1 Seq<Int>)) (!
  (=>
    (and
      (not (= s0 (as Seq_empty  Seq<Int>)))
      (not (= s1 (as Seq_empty  Seq<Int>))))
    (= (Seq_length (Seq_append s0 s1)) (+ (Seq_length s0) (Seq_length s1))))
  :pattern ((Seq_length (Seq_append s0 s1)))
  )))
(assert (forall ((s0 Seq<Int>) (s1 Seq<Int>)) (!
  (and
    (=> (= s0 (as Seq_empty  Seq<Int>)) (= (Seq_append s0 s1) s1))
    (=> (= s1 (as Seq_empty  Seq<Int>)) (= (Seq_append s0 s1) s0)))
  :pattern ((Seq_append s0 s1))
  )))
(assert (forall ((e Int)) (!
  (= (Seq_index (Seq_singleton e) 0) e)
  :pattern ((Seq_singleton e))
  )))
(assert (forall ((i Int) (j Int)) (!
  (= (Seq_add i j) (+ i j))
  :pattern ((Seq_add i j))
  )))
(assert (forall ((i Int) (j Int)) (!
  (= (Seq_sub i j) (- i j))
  :pattern ((Seq_sub i j))
  )))
(assert (forall ((s0 Seq<Int>) (s1 Seq<Int>) (n Int)) (!
  (=>
    (and
      (not (= s0 (as Seq_empty  Seq<Int>)))
      (and
        (not (= s1 (as Seq_empty  Seq<Int>)))
        (and (<= 0 n) (< n (Seq_length s0)))))
    (= (Seq_index (Seq_append s0 s1) n) (Seq_index s0 n)))
  :pattern ((Seq_index (Seq_append s0 s1) n))
  :pattern ((Seq_index s0 n) (Seq_append s0 s1))
  )))
(assert (forall ((s0 Seq<Int>) (s1 Seq<Int>) (n Int)) (!
  (=>
    (and
      (not (= s0 (as Seq_empty  Seq<Int>)))
      (and
        (not (= s1 (as Seq_empty  Seq<Int>)))
        (and (<= (Seq_length s0) n) (< n (Seq_length (Seq_append s0 s1))))))
    (and
      (= (Seq_add (Seq_sub n (Seq_length s0)) (Seq_length s0)) n)
      (=
        (Seq_index (Seq_append s0 s1) n)
        (Seq_index s1 (Seq_sub n (Seq_length s0))))))
  :pattern ((Seq_index (Seq_append s0 s1) n))
  )))
(assert (forall ((s0 Seq<Int>) (s1 Seq<Int>) (m Int)) (!
  (=>
    (and
      (not (= s0 (as Seq_empty  Seq<Int>)))
      (and
        (not (= s1 (as Seq_empty  Seq<Int>)))
        (and (<= 0 m) (< m (Seq_length s1)))))
    (and
      (= (Seq_sub (Seq_add m (Seq_length s0)) (Seq_length s0)) m)
      (=
        (Seq_index (Seq_append s0 s1) (Seq_add m (Seq_length s0)))
        (Seq_index s1 m))))
  :pattern ((Seq_index s1 m) (Seq_append s0 s1))
  )))
(assert (forall ((s Seq<Int>) (i Int) (v Int)) (!
  (=>
    (and (<= 0 i) (< i (Seq_length s)))
    (= (Seq_length (Seq_update s i v)) (Seq_length s)))
  :pattern ((Seq_length (Seq_update s i v)))
  :pattern ((Seq_length s) (Seq_update s i v))
  )))
(assert (forall ((s Seq<Int>) (i Int) (v Int) (n Int)) (!
  (=>
    (and (<= 0 n) (< n (Seq_length s)))
    (and
      (=> (= i n) (= (Seq_index (Seq_update s i v) n) v))
      (=> (not (= i n)) (= (Seq_index (Seq_update s i v) n) (Seq_index s n)))))
  :pattern ((Seq_index (Seq_update s i v) n))
  :pattern ((Seq_index s n) (Seq_update s i v))
  )))
(assert (forall ((s Seq<Int>) (n Int)) (!
  (and
    (=>
      (<= 0 n)
      (and
        (=> (<= n (Seq_length s)) (= (Seq_length (Seq_take s n)) n))
        (=> (< (Seq_length s) n) (= (Seq_length (Seq_take s n)) (Seq_length s)))))
    (=> (< n 0) (= (Seq_length (Seq_take s n)) 0)))
  :pattern ((Seq_length (Seq_take s n)))
  :pattern ((Seq_take s n) (Seq_length s))
  )))
(assert (forall ((s Seq<Int>) (n Int) (j Int)) (!
  (=>
    (and (<= 0 j) (and (< j n) (< j (Seq_length s))))
    (= (Seq_index (Seq_take s n) j) (Seq_index s j)))
  :pattern ((Seq_index (Seq_take s n) j))
  :pattern ((Seq_index s j) (Seq_take s n))
  )))
(assert (forall ((s Seq<Int>) (n Int)) (!
  (and
    (=>
      (<= 0 n)
      (and
        (=>
          (<= n (Seq_length s))
          (= (Seq_length (Seq_drop s n)) (- (Seq_length s) n)))
        (=> (< (Seq_length s) n) (= (Seq_length (Seq_drop s n)) 0))))
    (=> (< n 0) (= (Seq_length (Seq_drop s n)) (Seq_length s))))
  :pattern ((Seq_length (Seq_drop s n)))
  :pattern ((Seq_length s) (Seq_drop s n))
  )))
(assert (forall ((s Seq<Int>) (n Int) (j Int)) (!
  (=>
    (and (< 0 n) (and (<= 0 j) (< j (- (Seq_length s) n))))
    (and
      (= (Seq_sub (Seq_add j n) n) j)
      (= (Seq_index (Seq_drop s n) j) (Seq_index s (Seq_add j n)))))
  :pattern ((Seq_index (Seq_drop s n) j))
  )))
(assert (forall ((s Seq<Int>) (n Int) (i Int)) (!
  (=>
    (and (< 0 n) (and (<= n i) (< i (Seq_length s))))
    (and
      (= (Seq_add (Seq_sub i n) n) i)
      (= (Seq_index (Seq_drop s n) (Seq_sub i n)) (Seq_index s i))))
  :pattern ((Seq_drop s n) (Seq_index s i))
  )))
(assert (forall ((s Seq<Int>) (t Seq<Int>) (n Int)) (!
  (=>
    (and (< 0 n) (<= n (Seq_length s)))
    (= (Seq_take (Seq_append s t) n) (Seq_take s n)))
  :pattern ((Seq_take (Seq_append s t) n))
  )))
(assert (forall ((s Seq<Int>) (t Seq<Int>) (n Int)) (!
  (=>
    (and (> n 0) (> n (Seq_length s)))
    (and
      (= (Seq_add (Seq_sub n (Seq_length s)) (Seq_length s)) n)
      (=
        (Seq_take (Seq_append s t) n)
        (Seq_append s (Seq_take t (Seq_sub n (Seq_length s)))))))
  :pattern ((Seq_take (Seq_append s t) n))
  )))
(assert (forall ((s Seq<Int>) (t Seq<Int>) (n Int)) (!
  (=>
    (and (< 0 n) (<= n (Seq_length s)))
    (= (Seq_drop (Seq_append s t) n) (Seq_append (Seq_drop s n) t)))
  :pattern ((Seq_drop (Seq_append s t) n))
  )))
(assert (forall ((s Seq<Int>) (t Seq<Int>) (n Int)) (!
  (=>
    (and (> n 0) (> n (Seq_length s)))
    (and
      (= (Seq_add (Seq_sub n (Seq_length s)) (Seq_length s)) n)
      (= (Seq_drop (Seq_append s t) n) (Seq_drop t (Seq_sub n (Seq_length s))))))
  :pattern ((Seq_drop (Seq_append s t) n))
  )))
(assert (forall ((s Seq<Int>) (n Int)) (!
  (=> (<= n 0) (= (Seq_take s n) (as Seq_empty  Seq<Int>)))
  :pattern ((Seq_take s n))
  )))
(assert (forall ((s Seq<Int>) (n Int)) (!
  (=> (<= n 0) (= (Seq_drop s n) s))
  :pattern ((Seq_drop s n))
  )))
(assert (forall ((s Seq<Int>) (n Int)) (!
  (=> (>= n (Seq_length s)) (= (Seq_take s n) s))
  :pattern ((Seq_take s n))
  )))
(assert (forall ((s Seq<Int>) (n Int)) (!
  (=> (>= n (Seq_length s)) (= (Seq_drop s n) (as Seq_empty  Seq<Int>)))
  :pattern ((Seq_drop s n))
  )))
(assert (forall ((s Seq<Int>) (x Int)) (!
  (=>
    (Seq_contains s x)
    (and
      (<= 0 (Seq_skolem s x))
      (and
        (< (Seq_skolem s x) (Seq_length s))
        (= (Seq_index s (Seq_skolem s x)) x))))
  :pattern ((Seq_contains s x))
  )))
(assert (forall ((s Seq<Int>) (x Int) (i Int)) (!
  (=>
    (and (<= 0 i) (and (< i (Seq_length s)) (= (Seq_index s i) x)))
    (Seq_contains s x))
  :pattern ((Seq_contains s x) (Seq_index s i))
  )))
(assert (forall ((s Seq<Int>) (i Int)) (!
  (=>
    (and (<= 0 i) (< i (Seq_length s)))
    (Seq_contains_trigger s (Seq_index s i)))
  :pattern ((Seq_index s i))
  )))
(assert (forall ((s0 Seq<Int>) (s1 Seq<Int>)) (!
  (or
    (and (= s0 s1) (Seq_equal s0 s1))
    (or
      (and
        (not (= s0 s1))
        (and (not (Seq_equal s0 s1)) (not (= (Seq_length s0) (Seq_length s1)))))
      (and
        (not (= s0 s1))
        (and
          (not (Seq_equal s0 s1))
          (and
            (= (Seq_length s0) (Seq_length s1))
            (and
              (= (Seq_skolem_diff s0 s1) (Seq_skolem_diff s1 s0))
              (and
                (<= 0 (Seq_skolem_diff s0 s1))
                (and
                  (< (Seq_skolem_diff s0 s1) (Seq_length s0))
                  (not
                    (=
                      (Seq_index s0 (Seq_skolem_diff s0 s1))
                      (Seq_index s1 (Seq_skolem_diff s0 s1))))))))))))
  :pattern ((Seq_equal s0 s1))
  )))
(assert (forall ((a Seq<Int>) (b Seq<Int>)) (!
  (=> (Seq_equal a b) (= a b))
  :pattern ((Seq_equal a b))
  )))
(assert (forall ((x Int) (y Int)) (!
  (= (Seq_contains (Seq_singleton x) y) (= x y))
  :pattern ((Seq_contains (Seq_singleton x) y))
  )))
(assert (forall ((min_ Int) (max Int)) (!
  (and
    (=> (< min_ max) (= (Seq_length (Seq_range min_ max)) (- max min_)))
    (=> (<= max min_) (= (Seq_length (Seq_range min_ max)) 0)))
  :pattern ((Seq_length (Seq_range min_ max)))
  :qid |$Seq[Int]_prog.ranged_seq_length|)))
(assert (forall ((min_ Int) (max Int) (j Int)) (!
  (=>
    (and (<= 0 j) (< j (- max min_)))
    (= (Seq_index (Seq_range min_ max) j) (+ min_ j)))
  :pattern ((Seq_index (Seq_range min_ max) j))
  :qid |$Seq[Int]_prog.ranged_seq_index|)))
(assert (forall ((min_ Int) (max Int) (v Int)) (!
  (= (Seq_contains (Seq_range min_ max) v) (and (<= min_ v) (< v max)))
  :pattern ((Seq_contains (Seq_range min_ max) v))
  :qid |$Seq[Int]_prog.ranged_seq_contains|)))
; End preamble
; ------------------------------------------------------------
; State saturation: after preamble
(set-option :timeout 100)
(check-sat)
; unknown
; ------------------------------------------------------------
; Begin function- and predicate-related preamble
; Declaring symbols related to program functions (from verification)
; End function- and predicate-related preamble
; ------------------------------------------------------------
; ---------- binary_search ----------
(declare-const xs@0@12 Seq<Int>)
(declare-const key@1@12 Int)
(declare-const index@2@12 Int)
(declare-const xs@3@12 Seq<Int>)
(declare-const key@4@12 Int)
(declare-const index@5@12 Int)
(set-option :timeout 0)
(push) ; 1
(declare-const $t@6@12 $Snap)
(assert (= $t@6@12 $Snap.unit))
; [eval] (forall i: Int, j: Int :: { xs[i], xs[j] } 0 <= i && (j < |xs| && i < j) ==> xs[i] < xs[j])
(declare-const i@7@12 Int)
(declare-const j@8@12 Int)
(push) ; 2
; [eval] 0 <= i && (j < |xs| && i < j) ==> xs[i] < xs[j]
; [eval] 0 <= i && (j < |xs| && i < j)
; [eval] 0 <= i
(push) ; 3
; [then-branch: 0 | !(0 <= i@7@12) | live]
; [else-branch: 0 | 0 <= i@7@12 | live]
(push) ; 4
; [then-branch: 0 | !(0 <= i@7@12)]
(assert (not (<= 0 i@7@12)))
(pop) ; 4
(push) ; 4
; [else-branch: 0 | 0 <= i@7@12]
(assert (<= 0 i@7@12))
; [eval] j < |xs|
; [eval] |xs|
(push) ; 5
; [then-branch: 1 | !(j@8@12 < |xs@3@12|) | live]
; [else-branch: 1 | j@8@12 < |xs@3@12| | live]
(push) ; 6
; [then-branch: 1 | !(j@8@12 < |xs@3@12|)]
(assert (not (< j@8@12 (Seq_length xs@3@12))))
(pop) ; 6
(push) ; 6
; [else-branch: 1 | j@8@12 < |xs@3@12|]
(assert (< j@8@12 (Seq_length xs@3@12)))
; [eval] i < j
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (< j@8@12 (Seq_length xs@3@12)) (not (< j@8@12 (Seq_length xs@3@12)))))
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= 0 i@7@12)
  (and
    (<= 0 i@7@12)
    (or (< j@8@12 (Seq_length xs@3@12)) (not (< j@8@12 (Seq_length xs@3@12)))))))
(assert (or (<= 0 i@7@12) (not (<= 0 i@7@12))))
(push) ; 3
; [then-branch: 2 | 0 <= i@7@12 && j@8@12 < |xs@3@12| && i@7@12 < j@8@12 | live]
; [else-branch: 2 | !(0 <= i@7@12 && j@8@12 < |xs@3@12| && i@7@12 < j@8@12) | live]
(push) ; 4
; [then-branch: 2 | 0 <= i@7@12 && j@8@12 < |xs@3@12| && i@7@12 < j@8@12]
(assert (and (<= 0 i@7@12) (and (< j@8@12 (Seq_length xs@3@12)) (< i@7@12 j@8@12))))
; [eval] xs[i] < xs[j]
; [eval] xs[i]
(push) ; 5
(assert (not (>= i@7@12 0)))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(push) ; 5
(assert (not (< i@7@12 (Seq_length xs@3@12))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [eval] xs[j]
(push) ; 5
(assert (not (>= j@8@12 0)))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(pop) ; 4
(push) ; 4
; [else-branch: 2 | !(0 <= i@7@12 && j@8@12 < |xs@3@12| && i@7@12 < j@8@12)]
(assert (not (and (<= 0 i@7@12) (and (< j@8@12 (Seq_length xs@3@12)) (< i@7@12 j@8@12)))))
(pop) ; 4
(pop) ; 3
; Joined path conditions
(assert (=>
  (and (<= 0 i@7@12) (and (< j@8@12 (Seq_length xs@3@12)) (< i@7@12 j@8@12)))
  (and (<= 0 i@7@12) (< j@8@12 (Seq_length xs@3@12)) (< i@7@12 j@8@12))))
; Joined path conditions
(assert (or
  (not
    (and (<= 0 i@7@12) (and (< j@8@12 (Seq_length xs@3@12)) (< i@7@12 j@8@12))))
  (and (<= 0 i@7@12) (and (< j@8@12 (Seq_length xs@3@12)) (< i@7@12 j@8@12)))))
(pop) ; 2
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@7@12 Int) (j@8@12 Int)) (!
  (and
    (=>
      (<= 0 i@7@12)
      (and
        (<= 0 i@7@12)
        (or
          (< j@8@12 (Seq_length xs@3@12))
          (not (< j@8@12 (Seq_length xs@3@12))))))
    (or (<= 0 i@7@12) (not (<= 0 i@7@12)))
    (=>
      (and (<= 0 i@7@12) (and (< j@8@12 (Seq_length xs@3@12)) (< i@7@12 j@8@12)))
      (and (<= 0 i@7@12) (< j@8@12 (Seq_length xs@3@12)) (< i@7@12 j@8@12)))
    (or
      (not
        (and
          (<= 0 i@7@12)
          (and (< j@8@12 (Seq_length xs@3@12)) (< i@7@12 j@8@12))))
      (and (<= 0 i@7@12) (and (< j@8@12 (Seq_length xs@3@12)) (< i@7@12 j@8@12)))))
  :pattern ((Seq_index xs@3@12 i@7@12) (Seq_index xs@3@12 j@8@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@7@13@7@83-aux|)))
(assert (forall ((i@7@12 Int) (j@8@12 Int)) (!
  (=>
    (and (<= 0 i@7@12) (and (< j@8@12 (Seq_length xs@3@12)) (< i@7@12 j@8@12)))
    (< (Seq_index xs@3@12 i@7@12) (Seq_index xs@3@12 j@8@12)))
  :pattern ((Seq_index xs@3@12 i@7@12) (Seq_index xs@3@12 j@8@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@7@13@7@83|)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
(set-option :timeout 0)
(push) ; 2
(declare-const $t@9@12 $Snap)
(assert (= $t@9@12 ($Snap.combine ($Snap.first $t@9@12) ($Snap.second $t@9@12))))
(assert (= ($Snap.first $t@9@12) $Snap.unit))
; [eval] -1 <= index
; [eval] -1
(assert (<= (- 0 1) index@5@12))
(assert (=
  ($Snap.second $t@9@12)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@9@12))
    ($Snap.second ($Snap.second $t@9@12)))))
(assert (= ($Snap.first ($Snap.second $t@9@12)) $Snap.unit))
; [eval] index < |xs|
; [eval] |xs|
(assert (< index@5@12 (Seq_length xs@3@12)))
(assert (=
  ($Snap.second ($Snap.second $t@9@12))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@9@12)))
    ($Snap.second ($Snap.second ($Snap.second $t@9@12))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@9@12))) $Snap.unit))
; [eval] 0 <= index ==> xs[index] == key
; [eval] 0 <= index
(push) ; 3
(push) ; 4
(set-option :timeout 10)
(assert (not (not (<= 0 index@5@12))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 10)
(assert (not (<= 0 index@5@12)))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; [then-branch: 3 | 0 <= index@5@12 | live]
; [else-branch: 3 | !(0 <= index@5@12) | live]
(set-option :timeout 0)
(push) ; 4
; [then-branch: 3 | 0 <= index@5@12]
(assert (<= 0 index@5@12))
; [eval] xs[index] == key
; [eval] xs[index]
(push) ; 5
(assert (not (>= index@5@12 0)))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(pop) ; 4
(push) ; 4
; [else-branch: 3 | !(0 <= index@5@12)]
(assert (not (<= 0 index@5@12)))
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (or (not (<= 0 index@5@12)) (<= 0 index@5@12)))
(assert (=> (<= 0 index@5@12) (= (Seq_index xs@3@12 index@5@12) key@4@12)))
(assert (= ($Snap.second ($Snap.second ($Snap.second $t@9@12))) $Snap.unit))
; [eval] -1 == index ==> (forall i: Int :: { xs[i] } 0 <= i && i < |xs| ==> xs[i] != key)
; [eval] -1 == index
; [eval] -1
(push) ; 3
(push) ; 4
(set-option :timeout 10)
(assert (not (not (= (- 0 1) index@5@12))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 10)
(assert (not (= (- 0 1) index@5@12)))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; [then-branch: 4 | -1 == index@5@12 | live]
; [else-branch: 4 | -1 != index@5@12 | live]
(set-option :timeout 0)
(push) ; 4
; [then-branch: 4 | -1 == index@5@12]
(assert (= (- 0 1) index@5@12))
; [eval] (forall i: Int :: { xs[i] } 0 <= i && i < |xs| ==> xs[i] != key)
(declare-const i@10@12 Int)
(push) ; 5
; [eval] 0 <= i && i < |xs| ==> xs[i] != key
; [eval] 0 <= i && i < |xs|
; [eval] 0 <= i
(push) ; 6
; [then-branch: 5 | !(0 <= i@10@12) | live]
; [else-branch: 5 | 0 <= i@10@12 | live]
(push) ; 7
; [then-branch: 5 | !(0 <= i@10@12)]
(assert (not (<= 0 i@10@12)))
(pop) ; 7
(push) ; 7
; [else-branch: 5 | 0 <= i@10@12]
(assert (<= 0 i@10@12))
; [eval] i < |xs|
; [eval] |xs|
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@10@12) (not (<= 0 i@10@12))))
(push) ; 6
; [then-branch: 6 | 0 <= i@10@12 && i@10@12 < |xs@3@12| | live]
; [else-branch: 6 | !(0 <= i@10@12 && i@10@12 < |xs@3@12|) | live]
(push) ; 7
; [then-branch: 6 | 0 <= i@10@12 && i@10@12 < |xs@3@12|]
(assert (and (<= 0 i@10@12) (< i@10@12 (Seq_length xs@3@12))))
; [eval] xs[i] != key
; [eval] xs[i]
(push) ; 8
(assert (not (>= i@10@12 0)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 6 | !(0 <= i@10@12 && i@10@12 < |xs@3@12|)]
(assert (not (and (<= 0 i@10@12) (< i@10@12 (Seq_length xs@3@12)))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= 0 i@10@12) (< i@10@12 (Seq_length xs@3@12))))
  (and (<= 0 i@10@12) (< i@10@12 (Seq_length xs@3@12)))))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@10@12 Int)) (!
  (and
    (or (<= 0 i@10@12) (not (<= 0 i@10@12)))
    (or
      (not (and (<= 0 i@10@12) (< i@10@12 (Seq_length xs@3@12))))
      (and (<= 0 i@10@12) (< i@10@12 (Seq_length xs@3@12)))))
  :pattern ((Seq_index xs@3@12 i@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@10@29@10@81-aux|)))
(pop) ; 4
(push) ; 4
; [else-branch: 4 | -1 != index@5@12]
(assert (not (= (- 0 1) index@5@12)))
(pop) ; 4
(pop) ; 3
; Joined path conditions
(assert (=>
  (= (- 0 1) index@5@12)
  (and
    (= (- 0 1) index@5@12)
    (forall ((i@10@12 Int)) (!
      (and
        (or (<= 0 i@10@12) (not (<= 0 i@10@12)))
        (or
          (not (and (<= 0 i@10@12) (< i@10@12 (Seq_length xs@3@12))))
          (and (<= 0 i@10@12) (< i@10@12 (Seq_length xs@3@12)))))
      :pattern ((Seq_index xs@3@12 i@10@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@10@29@10@81-aux|)))))
; Joined path conditions
(assert (or (not (= (- 0 1) index@5@12)) (= (- 0 1) index@5@12)))
(assert (=>
  (= (- 0 1) index@5@12)
  (forall ((i@10@12 Int)) (!
    (=>
      (and (<= 0 i@10@12) (< i@10@12 (Seq_length xs@3@12)))
      (not (= (Seq_index xs@3@12 i@10@12) key@4@12)))
    :pattern ((Seq_index xs@3@12 i@10@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@10@29@10@81|))))
(pop) ; 2
(push) ; 2
; [exec]
; var low: Int
(declare-const low@11@12 Int)
; [exec]
; var high: Int
(declare-const high@12@12 Int)
; [exec]
; low := 0
; [exec]
; high := |xs|
; [eval] |xs|
(declare-const high@13@12 Int)
(assert (= high@13@12 (Seq_length xs@3@12)))
; [exec]
; index := -1
; [eval] -1
(declare-const mid@14@12 Int)
(declare-const low@15@12 Int)
(declare-const high@16@12 Int)
(declare-const index@17@12 Int)
(push) ; 3
; Loop head block: Check well-definedness of invariant
(declare-const $t@18@12 $Snap)
(assert (= $t@18@12 ($Snap.combine ($Snap.first $t@18@12) ($Snap.second $t@18@12))))
(assert (= ($Snap.first $t@18@12) $Snap.unit))
; [eval] 0 <= low
(assert (<= 0 low@15@12))
(assert (=
  ($Snap.second $t@18@12)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@18@12))
    ($Snap.second ($Snap.second $t@18@12)))))
(assert (= ($Snap.first ($Snap.second $t@18@12)) $Snap.unit))
; [eval] low <= high
(assert (<= low@15@12 high@16@12))
(assert (=
  ($Snap.second ($Snap.second $t@18@12))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@18@12)))
    ($Snap.second ($Snap.second ($Snap.second $t@18@12))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@18@12))) $Snap.unit))
; [eval] high <= |xs|
; [eval] |xs|
(assert (<= high@16@12 (Seq_length xs@3@12)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@18@12)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@18@12))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@18@12))))
  $Snap.unit))
; [eval] index == -1 ==> (forall i: Int :: { xs[i] } 0 <= i && (i < |xs| && !(low <= i && i < high)) ==> xs[i] != key)
; [eval] index == -1
; [eval] -1
(push) ; 4
(push) ; 5
(set-option :timeout 10)
(assert (not (not (= index@17@12 (- 0 1)))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 10)
(assert (not (= index@17@12 (- 0 1))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [then-branch: 7 | index@17@12 == -1 | live]
; [else-branch: 7 | index@17@12 != -1 | live]
(set-option :timeout 0)
(push) ; 5
; [then-branch: 7 | index@17@12 == -1]
(assert (= index@17@12 (- 0 1)))
; [eval] (forall i: Int :: { xs[i] } 0 <= i && (i < |xs| && !(low <= i && i < high)) ==> xs[i] != key)
(declare-const i@19@12 Int)
(push) ; 6
; [eval] 0 <= i && (i < |xs| && !(low <= i && i < high)) ==> xs[i] != key
; [eval] 0 <= i && (i < |xs| && !(low <= i && i < high))
; [eval] 0 <= i
(push) ; 7
; [then-branch: 8 | !(0 <= i@19@12) | live]
; [else-branch: 8 | 0 <= i@19@12 | live]
(push) ; 8
; [then-branch: 8 | !(0 <= i@19@12)]
(assert (not (<= 0 i@19@12)))
(pop) ; 8
(push) ; 8
; [else-branch: 8 | 0 <= i@19@12]
(assert (<= 0 i@19@12))
; [eval] i < |xs|
; [eval] |xs|
(push) ; 9
; [then-branch: 9 | !(i@19@12 < |xs@3@12|) | live]
; [else-branch: 9 | i@19@12 < |xs@3@12| | live]
(push) ; 10
; [then-branch: 9 | !(i@19@12 < |xs@3@12|)]
(assert (not (< i@19@12 (Seq_length xs@3@12))))
(pop) ; 10
(push) ; 10
; [else-branch: 9 | i@19@12 < |xs@3@12|]
(assert (< i@19@12 (Seq_length xs@3@12)))
; [eval] !(low <= i && i < high)
; [eval] low <= i && i < high
; [eval] low <= i
(push) ; 11
; [then-branch: 10 | !(low@15@12 <= i@19@12) | live]
; [else-branch: 10 | low@15@12 <= i@19@12 | live]
(push) ; 12
; [then-branch: 10 | !(low@15@12 <= i@19@12)]
(assert (not (<= low@15@12 i@19@12)))
(pop) ; 12
(push) ; 12
; [else-branch: 10 | low@15@12 <= i@19@12]
(assert (<= low@15@12 i@19@12))
; [eval] i < high
(pop) ; 12
(pop) ; 11
; Joined path conditions
; Joined path conditions
(assert (or (<= low@15@12 i@19@12) (not (<= low@15@12 i@19@12))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (=>
  (< i@19@12 (Seq_length xs@3@12))
  (and
    (< i@19@12 (Seq_length xs@3@12))
    (or (<= low@15@12 i@19@12) (not (<= low@15@12 i@19@12))))))
(assert (or (< i@19@12 (Seq_length xs@3@12)) (not (< i@19@12 (Seq_length xs@3@12)))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= 0 i@19@12)
  (and
    (<= 0 i@19@12)
    (=>
      (< i@19@12 (Seq_length xs@3@12))
      (and
        (< i@19@12 (Seq_length xs@3@12))
        (or (<= low@15@12 i@19@12) (not (<= low@15@12 i@19@12)))))
    (or (< i@19@12 (Seq_length xs@3@12)) (not (< i@19@12 (Seq_length xs@3@12)))))))
(assert (or (<= 0 i@19@12) (not (<= 0 i@19@12))))
(push) ; 7
; [then-branch: 11 | 0 <= i@19@12 && i@19@12 < |xs@3@12| && !(low@15@12 <= i@19@12 && i@19@12 < high@16@12) | live]
; [else-branch: 11 | !(0 <= i@19@12 && i@19@12 < |xs@3@12| && !(low@15@12 <= i@19@12 && i@19@12 < high@16@12)) | live]
(push) ; 8
; [then-branch: 11 | 0 <= i@19@12 && i@19@12 < |xs@3@12| && !(low@15@12 <= i@19@12 && i@19@12 < high@16@12)]
(assert (and
  (<= 0 i@19@12)
  (and
    (< i@19@12 (Seq_length xs@3@12))
    (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12))))))
; [eval] xs[i] != key
; [eval] xs[i]
(push) ; 9
(assert (not (>= i@19@12 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 11 | !(0 <= i@19@12 && i@19@12 < |xs@3@12| && !(low@15@12 <= i@19@12 && i@19@12 < high@16@12))]
(assert (not
  (and
    (<= 0 i@19@12)
    (and
      (< i@19@12 (Seq_length xs@3@12))
      (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12)))))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (=>
  (and
    (<= 0 i@19@12)
    (and
      (< i@19@12 (Seq_length xs@3@12))
      (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12)))))
  (and
    (<= 0 i@19@12)
    (< i@19@12 (Seq_length xs@3@12))
    (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12))))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= 0 i@19@12)
      (and
        (< i@19@12 (Seq_length xs@3@12))
        (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12))))))
  (and
    (<= 0 i@19@12)
    (and
      (< i@19@12 (Seq_length xs@3@12))
      (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12)))))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@19@12 Int)) (!
  (and
    (=>
      (<= 0 i@19@12)
      (and
        (<= 0 i@19@12)
        (=>
          (< i@19@12 (Seq_length xs@3@12))
          (and
            (< i@19@12 (Seq_length xs@3@12))
            (or (<= low@15@12 i@19@12) (not (<= low@15@12 i@19@12)))))
        (or
          (< i@19@12 (Seq_length xs@3@12))
          (not (< i@19@12 (Seq_length xs@3@12))))))
    (or (<= 0 i@19@12) (not (<= 0 i@19@12)))
    (=>
      (and
        (<= 0 i@19@12)
        (and
          (< i@19@12 (Seq_length xs@3@12))
          (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12)))))
      (and
        (<= 0 i@19@12)
        (< i@19@12 (Seq_length xs@3@12))
        (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12)))))
    (or
      (not
        (and
          (<= 0 i@19@12)
          (and
            (< i@19@12 (Seq_length xs@3@12))
            (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12))))))
      (and
        (<= 0 i@19@12)
        (and
          (< i@19@12 (Seq_length xs@3@12))
          (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12)))))))
  :pattern ((Seq_index xs@3@12 i@19@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114-aux|)))
(pop) ; 5
(push) ; 5
; [else-branch: 7 | index@17@12 != -1]
(assert (not (= index@17@12 (- 0 1))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (=>
  (= index@17@12 (- 0 1))
  (and
    (= index@17@12 (- 0 1))
    (forall ((i@19@12 Int)) (!
      (and
        (=>
          (<= 0 i@19@12)
          (and
            (<= 0 i@19@12)
            (=>
              (< i@19@12 (Seq_length xs@3@12))
              (and
                (< i@19@12 (Seq_length xs@3@12))
                (or (<= low@15@12 i@19@12) (not (<= low@15@12 i@19@12)))))
            (or
              (< i@19@12 (Seq_length xs@3@12))
              (not (< i@19@12 (Seq_length xs@3@12))))))
        (or (<= 0 i@19@12) (not (<= 0 i@19@12)))
        (=>
          (and
            (<= 0 i@19@12)
            (and
              (< i@19@12 (Seq_length xs@3@12))
              (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12)))))
          (and
            (<= 0 i@19@12)
            (< i@19@12 (Seq_length xs@3@12))
            (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12)))))
        (or
          (not
            (and
              (<= 0 i@19@12)
              (and
                (< i@19@12 (Seq_length xs@3@12))
                (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12))))))
          (and
            (<= 0 i@19@12)
            (and
              (< i@19@12 (Seq_length xs@3@12))
              (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12)))))))
      :pattern ((Seq_index xs@3@12 i@19@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114-aux|)))))
; Joined path conditions
(assert (or (not (= index@17@12 (- 0 1))) (= index@17@12 (- 0 1))))
(assert (=>
  (= index@17@12 (- 0 1))
  (forall ((i@19@12 Int)) (!
    (=>
      (and
        (<= 0 i@19@12)
        (and
          (< i@19@12 (Seq_length xs@3@12))
          (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12)))))
      (not (= (Seq_index xs@3@12 i@19@12) key@4@12)))
    :pattern ((Seq_index xs@3@12 i@19@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114|))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12)))))
  $Snap.unit))
; [eval] -1 <= index
; [eval] -1
(assert (<= (- 0 1) index@17@12))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12))))))
  $Snap.unit))
; [eval] index < |xs|
; [eval] |xs|
(assert (< index@17@12 (Seq_length xs@3@12)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12))))))
  $Snap.unit))
; [eval] 0 <= index ==> xs[index] == key
; [eval] 0 <= index
(push) ; 4
(push) ; 5
(set-option :timeout 10)
(assert (not (not (<= 0 index@17@12))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 10)
(assert (not (<= 0 index@17@12)))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [then-branch: 12 | 0 <= index@17@12 | live]
; [else-branch: 12 | !(0 <= index@17@12) | live]
(set-option :timeout 0)
(push) ; 5
; [then-branch: 12 | 0 <= index@17@12]
(assert (<= 0 index@17@12))
; [eval] xs[index] == key
; [eval] xs[index]
(push) ; 6
(assert (not (>= index@17@12 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 12 | !(0 <= index@17@12)]
(assert (not (<= 0 index@17@12)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (not (<= 0 index@17@12)) (<= 0 index@17@12)))
(assert (=> (<= 0 index@17@12) (= (Seq_index xs@3@12 index@17@12) key@4@12)))
(pop) ; 3
(push) ; 3
; Loop head block: Establish invariant
; [eval] 0 <= low
; [eval] low <= high
(push) ; 4
(assert (not (<= 0 high@13@12)))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 high@13@12))
; [eval] high <= |xs|
; [eval] |xs|
(push) ; 4
(assert (not (<= high@13@12 (Seq_length xs@3@12))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (<= high@13@12 (Seq_length xs@3@12)))
; [eval] index == -1 ==> (forall i: Int :: { xs[i] } 0 <= i && (i < |xs| && !(low <= i && i < high)) ==> xs[i] != key)
; [eval] index == -1
; [eval] -1
(push) ; 4
(push) ; 5
(set-option :timeout 10)
(assert (not false))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [then-branch: 13 | True | live]
; [else-branch: 13 | False | dead]
(set-option :timeout 0)
(push) ; 5
; [then-branch: 13 | True]
; [eval] (forall i: Int :: { xs[i] } 0 <= i && (i < |xs| && !(low <= i && i < high)) ==> xs[i] != key)
(declare-const i@20@12 Int)
(push) ; 6
; [eval] 0 <= i && (i < |xs| && !(low <= i && i < high)) ==> xs[i] != key
; [eval] 0 <= i && (i < |xs| && !(low <= i && i < high))
; [eval] 0 <= i
(push) ; 7
; [then-branch: 14 | !(0 <= i@20@12) | live]
; [else-branch: 14 | 0 <= i@20@12 | live]
(push) ; 8
; [then-branch: 14 | !(0 <= i@20@12)]
(assert (not (<= 0 i@20@12)))
(pop) ; 8
(push) ; 8
; [else-branch: 14 | 0 <= i@20@12]
(assert (<= 0 i@20@12))
; [eval] i < |xs|
; [eval] |xs|
(push) ; 9
; [then-branch: 15 | !(i@20@12 < |xs@3@12|) | live]
; [else-branch: 15 | i@20@12 < |xs@3@12| | live]
(push) ; 10
; [then-branch: 15 | !(i@20@12 < |xs@3@12|)]
(assert (not (< i@20@12 (Seq_length xs@3@12))))
(pop) ; 10
(push) ; 10
; [else-branch: 15 | i@20@12 < |xs@3@12|]
(assert (< i@20@12 (Seq_length xs@3@12)))
; [eval] !(low <= i && i < high)
; [eval] low <= i && i < high
; [eval] low <= i
(push) ; 11
; [then-branch: 16 | !(0 <= i@20@12) | live]
; [else-branch: 16 | 0 <= i@20@12 | live]
(push) ; 12
; [then-branch: 16 | !(0 <= i@20@12)]
(assert (not (<= 0 i@20@12)))
(pop) ; 12
(push) ; 12
; [else-branch: 16 | 0 <= i@20@12]
; [eval] i < high
(pop) ; 12
(pop) ; 11
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@20@12) (not (<= 0 i@20@12))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (=>
  (< i@20@12 (Seq_length xs@3@12))
  (and (< i@20@12 (Seq_length xs@3@12)) (or (<= 0 i@20@12) (not (<= 0 i@20@12))))))
(assert (or (< i@20@12 (Seq_length xs@3@12)) (not (< i@20@12 (Seq_length xs@3@12)))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= 0 i@20@12)
  (and
    (<= 0 i@20@12)
    (=>
      (< i@20@12 (Seq_length xs@3@12))
      (and
        (< i@20@12 (Seq_length xs@3@12))
        (or (<= 0 i@20@12) (not (<= 0 i@20@12)))))
    (or (< i@20@12 (Seq_length xs@3@12)) (not (< i@20@12 (Seq_length xs@3@12)))))))
(assert (or (<= 0 i@20@12) (not (<= 0 i@20@12))))
(push) ; 7
; [then-branch: 17 | 0 <= i@20@12 && i@20@12 < |xs@3@12| && !(0 <= i@20@12 && i@20@12 < high@13@12) | live]
; [else-branch: 17 | !(0 <= i@20@12 && i@20@12 < |xs@3@12| && !(0 <= i@20@12 && i@20@12 < high@13@12)) | live]
(push) ; 8
; [then-branch: 17 | 0 <= i@20@12 && i@20@12 < |xs@3@12| && !(0 <= i@20@12 && i@20@12 < high@13@12)]
(assert (and
  (<= 0 i@20@12)
  (and
    (< i@20@12 (Seq_length xs@3@12))
    (not (and (<= 0 i@20@12) (< i@20@12 high@13@12))))))
; [eval] xs[i] != key
; [eval] xs[i]
(push) ; 9
(assert (not (>= i@20@12 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 17 | !(0 <= i@20@12 && i@20@12 < |xs@3@12| && !(0 <= i@20@12 && i@20@12 < high@13@12))]
(assert (not
  (and
    (<= 0 i@20@12)
    (and
      (< i@20@12 (Seq_length xs@3@12))
      (not (and (<= 0 i@20@12) (< i@20@12 high@13@12)))))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (=>
  (and
    (<= 0 i@20@12)
    (and
      (< i@20@12 (Seq_length xs@3@12))
      (not (and (<= 0 i@20@12) (< i@20@12 high@13@12)))))
  (and
    (<= 0 i@20@12)
    (< i@20@12 (Seq_length xs@3@12))
    (not (and (<= 0 i@20@12) (< i@20@12 high@13@12))))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= 0 i@20@12)
      (and
        (< i@20@12 (Seq_length xs@3@12))
        (not (and (<= 0 i@20@12) (< i@20@12 high@13@12))))))
  (and
    (<= 0 i@20@12)
    (and
      (< i@20@12 (Seq_length xs@3@12))
      (not (and (<= 0 i@20@12) (< i@20@12 high@13@12)))))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@20@12 Int)) (!
  (and
    (=>
      (<= 0 i@20@12)
      (and
        (<= 0 i@20@12)
        (=>
          (< i@20@12 (Seq_length xs@3@12))
          (and
            (< i@20@12 (Seq_length xs@3@12))
            (or (<= 0 i@20@12) (not (<= 0 i@20@12)))))
        (or
          (< i@20@12 (Seq_length xs@3@12))
          (not (< i@20@12 (Seq_length xs@3@12))))))
    (or (<= 0 i@20@12) (not (<= 0 i@20@12)))
    (=>
      (and
        (<= 0 i@20@12)
        (and
          (< i@20@12 (Seq_length xs@3@12))
          (not (and (<= 0 i@20@12) (< i@20@12 high@13@12)))))
      (and
        (<= 0 i@20@12)
        (< i@20@12 (Seq_length xs@3@12))
        (not (and (<= 0 i@20@12) (< i@20@12 high@13@12)))))
    (or
      (not
        (and
          (<= 0 i@20@12)
          (and
            (< i@20@12 (Seq_length xs@3@12))
            (not (and (<= 0 i@20@12) (< i@20@12 high@13@12))))))
      (and
        (<= 0 i@20@12)
        (and
          (< i@20@12 (Seq_length xs@3@12))
          (not (and (<= 0 i@20@12) (< i@20@12 high@13@12)))))))
  :pattern ((Seq_index xs@3@12 i@20@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114-aux|)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((i@20@12 Int)) (!
  (and
    (=>
      (<= 0 i@20@12)
      (and
        (<= 0 i@20@12)
        (=>
          (< i@20@12 (Seq_length xs@3@12))
          (and
            (< i@20@12 (Seq_length xs@3@12))
            (or (<= 0 i@20@12) (not (<= 0 i@20@12)))))
        (or
          (< i@20@12 (Seq_length xs@3@12))
          (not (< i@20@12 (Seq_length xs@3@12))))))
    (or (<= 0 i@20@12) (not (<= 0 i@20@12)))
    (=>
      (and
        (<= 0 i@20@12)
        (and
          (< i@20@12 (Seq_length xs@3@12))
          (not (and (<= 0 i@20@12) (< i@20@12 high@13@12)))))
      (and
        (<= 0 i@20@12)
        (< i@20@12 (Seq_length xs@3@12))
        (not (and (<= 0 i@20@12) (< i@20@12 high@13@12)))))
    (or
      (not
        (and
          (<= 0 i@20@12)
          (and
            (< i@20@12 (Seq_length xs@3@12))
            (not (and (<= 0 i@20@12) (< i@20@12 high@13@12))))))
      (and
        (<= 0 i@20@12)
        (and
          (< i@20@12 (Seq_length xs@3@12))
          (not (and (<= 0 i@20@12) (< i@20@12 high@13@12)))))))
  :pattern ((Seq_index xs@3@12 i@20@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114-aux|)))
(push) ; 4
(assert (not (forall ((i@20@12 Int)) (!
  (=>
    (and
      (<= 0 i@20@12)
      (and
        (< i@20@12 (Seq_length xs@3@12))
        (not (and (<= 0 i@20@12) (< i@20@12 high@13@12)))))
    (not (= (Seq_index xs@3@12 i@20@12) key@4@12)))
  :pattern ((Seq_index xs@3@12 i@20@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@20@12 Int)) (!
  (=>
    (and
      (<= 0 i@20@12)
      (and
        (< i@20@12 (Seq_length xs@3@12))
        (not (and (<= 0 i@20@12) (< i@20@12 high@13@12)))))
    (not (= (Seq_index xs@3@12 i@20@12) key@4@12)))
  :pattern ((Seq_index xs@3@12 i@20@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114|)))
; [eval] -1 <= index
; [eval] -1
; [eval] index < |xs|
; [eval] |xs|
(push) ; 4
(assert (not (< (- 0 1) (Seq_length xs@3@12))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (< (- 0 1) (Seq_length xs@3@12)))
; [eval] 0 <= index ==> xs[index] == key
; [eval] 0 <= index
(push) ; 4
; [then-branch: 18 | False | dead]
; [else-branch: 18 | True | live]
(push) ; 5
; [else-branch: 18 | True]
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Loop head block: Execute statements of loop head block (in invariant state)
(push) ; 4
(assert (= $t@18@12 ($Snap.combine ($Snap.first $t@18@12) ($Snap.second $t@18@12))))
(assert (= ($Snap.first $t@18@12) $Snap.unit))
(assert (<= 0 low@15@12))
(assert (=
  ($Snap.second $t@18@12)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@18@12))
    ($Snap.second ($Snap.second $t@18@12)))))
(assert (= ($Snap.first ($Snap.second $t@18@12)) $Snap.unit))
(assert (<= low@15@12 high@16@12))
(assert (=
  ($Snap.second ($Snap.second $t@18@12))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@18@12)))
    ($Snap.second ($Snap.second ($Snap.second $t@18@12))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@18@12))) $Snap.unit))
(assert (<= high@16@12 (Seq_length xs@3@12)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@18@12)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@18@12))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@18@12))))
  $Snap.unit))
(assert (=>
  (= index@17@12 (- 0 1))
  (and
    (= index@17@12 (- 0 1))
    (forall ((i@19@12 Int)) (!
      (and
        (=>
          (<= 0 i@19@12)
          (and
            (<= 0 i@19@12)
            (=>
              (< i@19@12 (Seq_length xs@3@12))
              (and
                (< i@19@12 (Seq_length xs@3@12))
                (or (<= low@15@12 i@19@12) (not (<= low@15@12 i@19@12)))))
            (or
              (< i@19@12 (Seq_length xs@3@12))
              (not (< i@19@12 (Seq_length xs@3@12))))))
        (or (<= 0 i@19@12) (not (<= 0 i@19@12)))
        (=>
          (and
            (<= 0 i@19@12)
            (and
              (< i@19@12 (Seq_length xs@3@12))
              (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12)))))
          (and
            (<= 0 i@19@12)
            (< i@19@12 (Seq_length xs@3@12))
            (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12)))))
        (or
          (not
            (and
              (<= 0 i@19@12)
              (and
                (< i@19@12 (Seq_length xs@3@12))
                (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12))))))
          (and
            (<= 0 i@19@12)
            (and
              (< i@19@12 (Seq_length xs@3@12))
              (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12)))))))
      :pattern ((Seq_index xs@3@12 i@19@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114-aux|)))))
(assert (or (not (= index@17@12 (- 0 1))) (= index@17@12 (- 0 1))))
(assert (=>
  (= index@17@12 (- 0 1))
  (forall ((i@19@12 Int)) (!
    (=>
      (and
        (<= 0 i@19@12)
        (and
          (< i@19@12 (Seq_length xs@3@12))
          (not (and (<= low@15@12 i@19@12) (< i@19@12 high@16@12)))))
      (not (= (Seq_index xs@3@12 i@19@12) key@4@12)))
    :pattern ((Seq_index xs@3@12 i@19@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114|))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12)))))
  $Snap.unit))
(assert (<= (- 0 1) index@17@12))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12))))))
  $Snap.unit))
(assert (< index@17@12 (Seq_length xs@3@12)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@18@12))))))
  $Snap.unit))
(assert (or (not (<= 0 index@17@12)) (<= 0 index@17@12)))
(assert (=> (<= 0 index@17@12) (= (Seq_index xs@3@12 index@17@12) key@4@12)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
(set-option :timeout 10)
(check-sat)
; unknown
; Loop head block: Check well-definedness of edge conditions
(set-option :timeout 0)
(push) ; 5
; [eval] low < high && index == -1
; [eval] low < high
(push) ; 6
; [then-branch: 19 | !(low@15@12 < high@16@12) | live]
; [else-branch: 19 | low@15@12 < high@16@12 | live]
(push) ; 7
; [then-branch: 19 | !(low@15@12 < high@16@12)]
(assert (not (< low@15@12 high@16@12)))
(pop) ; 7
(push) ; 7
; [else-branch: 19 | low@15@12 < high@16@12]
(assert (< low@15@12 high@16@12))
; [eval] index == -1
; [eval] -1
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (< low@15@12 high@16@12) (not (< low@15@12 high@16@12))))
(pop) ; 5
(push) ; 5
; [eval] !(low < high && index == -1)
; [eval] low < high && index == -1
; [eval] low < high
(push) ; 6
; [then-branch: 20 | !(low@15@12 < high@16@12) | live]
; [else-branch: 20 | low@15@12 < high@16@12 | live]
(push) ; 7
; [then-branch: 20 | !(low@15@12 < high@16@12)]
(assert (not (< low@15@12 high@16@12)))
(pop) ; 7
(push) ; 7
; [else-branch: 20 | low@15@12 < high@16@12]
(assert (< low@15@12 high@16@12))
; [eval] index == -1
; [eval] -1
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (< low@15@12 high@16@12) (not (< low@15@12 high@16@12))))
(pop) ; 5
; Loop head block: Follow loop-internal edges
; [eval] low < high && index == -1
; [eval] low < high
(push) ; 5
; [then-branch: 21 | !(low@15@12 < high@16@12) | live]
; [else-branch: 21 | low@15@12 < high@16@12 | live]
(push) ; 6
; [then-branch: 21 | !(low@15@12 < high@16@12)]
(assert (not (< low@15@12 high@16@12)))
(pop) ; 6
(push) ; 6
; [else-branch: 21 | low@15@12 < high@16@12]
(assert (< low@15@12 high@16@12))
; [eval] index == -1
; [eval] -1
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (< low@15@12 high@16@12) (not (< low@15@12 high@16@12))))
(push) ; 5
(set-option :timeout 10)
(assert (not (not (and (< low@15@12 high@16@12) (= index@17@12 (- 0 1))))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 10)
(assert (not (and (< low@15@12 high@16@12) (= index@17@12 (- 0 1)))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [then-branch: 22 | low@15@12 < high@16@12 && index@17@12 == -1 | live]
; [else-branch: 22 | !(low@15@12 < high@16@12 && index@17@12 == -1) | live]
(set-option :timeout 0)
(push) ; 5
; [then-branch: 22 | low@15@12 < high@16@12 && index@17@12 == -1]
(assert (and (< low@15@12 high@16@12) (= index@17@12 (- 0 1))))
; [exec]
; var mid: Int
(declare-const mid@21@12 Int)
; [exec]
; mid := (low + high) / 2
; [eval] (low + high) / 2
; [eval] low + high
(declare-const mid@22@12 Int)
(assert (= mid@22@12 (div (+ low@15@12 high@16@12) 2)))
; [eval] xs[mid] < key
; [eval] xs[mid]
(push) ; 6
(assert (not (>= mid@22@12 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (< mid@22@12 (Seq_length xs@3@12))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(set-option :timeout 10)
(assert (not (not (< (Seq_index xs@3@12 mid@22@12) key@4@12))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 10)
(assert (not (< (Seq_index xs@3@12 mid@22@12) key@4@12)))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [then-branch: 23 | xs@3@12[mid@22@12] < key@4@12 | live]
; [else-branch: 23 | !(xs@3@12[mid@22@12] < key@4@12) | live]
(set-option :timeout 0)
(push) ; 6
; [then-branch: 23 | xs@3@12[mid@22@12] < key@4@12]
(assert (< (Seq_index xs@3@12 mid@22@12) key@4@12))
; [exec]
; low := mid + 1
; [eval] mid + 1
(declare-const low@23@12 Int)
(assert (= low@23@12 (+ mid@22@12 1)))
; Loop head block: Re-establish invariant
; [eval] 0 <= low
(push) ; 7
(assert (not (<= 0 low@23@12)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 low@23@12))
; [eval] low <= high
(push) ; 7
(assert (not (<= low@23@12 high@16@12)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (<= low@23@12 high@16@12))
; [eval] high <= |xs|
; [eval] |xs|
; [eval] index == -1 ==> (forall i: Int :: { xs[i] } 0 <= i && (i < |xs| && !(low <= i && i < high)) ==> xs[i] != key)
; [eval] index == -1
; [eval] -1
(push) ; 7
(push) ; 8
(set-option :timeout 10)
(assert (not (not (= index@17@12 (- 0 1)))))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [then-branch: 24 | index@17@12 == -1 | live]
; [else-branch: 24 | index@17@12 != -1 | dead]
(set-option :timeout 0)
(push) ; 8
; [then-branch: 24 | index@17@12 == -1]
; [eval] (forall i: Int :: { xs[i] } 0 <= i && (i < |xs| && !(low <= i && i < high)) ==> xs[i] != key)
(declare-const i@24@12 Int)
(push) ; 9
; [eval] 0 <= i && (i < |xs| && !(low <= i && i < high)) ==> xs[i] != key
; [eval] 0 <= i && (i < |xs| && !(low <= i && i < high))
; [eval] 0 <= i
(push) ; 10
; [then-branch: 25 | !(0 <= i@24@12) | live]
; [else-branch: 25 | 0 <= i@24@12 | live]
(push) ; 11
; [then-branch: 25 | !(0 <= i@24@12)]
(assert (not (<= 0 i@24@12)))
(pop) ; 11
(push) ; 11
; [else-branch: 25 | 0 <= i@24@12]
(assert (<= 0 i@24@12))
; [eval] i < |xs|
; [eval] |xs|
(push) ; 12
; [then-branch: 26 | !(i@24@12 < |xs@3@12|) | live]
; [else-branch: 26 | i@24@12 < |xs@3@12| | live]
(push) ; 13
; [then-branch: 26 | !(i@24@12 < |xs@3@12|)]
(assert (not (< i@24@12 (Seq_length xs@3@12))))
(pop) ; 13
(push) ; 13
; [else-branch: 26 | i@24@12 < |xs@3@12|]
(assert (< i@24@12 (Seq_length xs@3@12)))
; [eval] !(low <= i && i < high)
; [eval] low <= i && i < high
; [eval] low <= i
(push) ; 14
; [then-branch: 27 | !(low@23@12 <= i@24@12) | live]
; [else-branch: 27 | low@23@12 <= i@24@12 | live]
(push) ; 15
; [then-branch: 27 | !(low@23@12 <= i@24@12)]
(assert (not (<= low@23@12 i@24@12)))
(pop) ; 15
(push) ; 15
; [else-branch: 27 | low@23@12 <= i@24@12]
(assert (<= low@23@12 i@24@12))
; [eval] i < high
(pop) ; 15
(pop) ; 14
; Joined path conditions
; Joined path conditions
(assert (or (<= low@23@12 i@24@12) (not (<= low@23@12 i@24@12))))
(pop) ; 13
(pop) ; 12
; Joined path conditions
; Joined path conditions
(assert (=>
  (< i@24@12 (Seq_length xs@3@12))
  (and
    (< i@24@12 (Seq_length xs@3@12))
    (or (<= low@23@12 i@24@12) (not (<= low@23@12 i@24@12))))))
(assert (or (< i@24@12 (Seq_length xs@3@12)) (not (< i@24@12 (Seq_length xs@3@12)))))
(pop) ; 11
(pop) ; 10
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= 0 i@24@12)
  (and
    (<= 0 i@24@12)
    (=>
      (< i@24@12 (Seq_length xs@3@12))
      (and
        (< i@24@12 (Seq_length xs@3@12))
        (or (<= low@23@12 i@24@12) (not (<= low@23@12 i@24@12)))))
    (or (< i@24@12 (Seq_length xs@3@12)) (not (< i@24@12 (Seq_length xs@3@12)))))))
(assert (or (<= 0 i@24@12) (not (<= 0 i@24@12))))
(push) ; 10
; [then-branch: 28 | 0 <= i@24@12 && i@24@12 < |xs@3@12| && !(low@23@12 <= i@24@12 && i@24@12 < high@16@12) | live]
; [else-branch: 28 | !(0 <= i@24@12 && i@24@12 < |xs@3@12| && !(low@23@12 <= i@24@12 && i@24@12 < high@16@12)) | live]
(push) ; 11
; [then-branch: 28 | 0 <= i@24@12 && i@24@12 < |xs@3@12| && !(low@23@12 <= i@24@12 && i@24@12 < high@16@12)]
(assert (and
  (<= 0 i@24@12)
  (and
    (< i@24@12 (Seq_length xs@3@12))
    (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12))))))
; [eval] xs[i] != key
; [eval] xs[i]
(push) ; 12
(assert (not (>= i@24@12 0)))
(check-sat)
; unsat
(pop) ; 12
; 0.00s
; (get-info :all-statistics)
(pop) ; 11
(push) ; 11
; [else-branch: 28 | !(0 <= i@24@12 && i@24@12 < |xs@3@12| && !(low@23@12 <= i@24@12 && i@24@12 < high@16@12))]
(assert (not
  (and
    (<= 0 i@24@12)
    (and
      (< i@24@12 (Seq_length xs@3@12))
      (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12)))))))
(pop) ; 11
(pop) ; 10
; Joined path conditions
(assert (=>
  (and
    (<= 0 i@24@12)
    (and
      (< i@24@12 (Seq_length xs@3@12))
      (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12)))))
  (and
    (<= 0 i@24@12)
    (< i@24@12 (Seq_length xs@3@12))
    (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12))))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= 0 i@24@12)
      (and
        (< i@24@12 (Seq_length xs@3@12))
        (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12))))))
  (and
    (<= 0 i@24@12)
    (and
      (< i@24@12 (Seq_length xs@3@12))
      (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12)))))))
(pop) ; 9
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@24@12 Int)) (!
  (and
    (=>
      (<= 0 i@24@12)
      (and
        (<= 0 i@24@12)
        (=>
          (< i@24@12 (Seq_length xs@3@12))
          (and
            (< i@24@12 (Seq_length xs@3@12))
            (or (<= low@23@12 i@24@12) (not (<= low@23@12 i@24@12)))))
        (or
          (< i@24@12 (Seq_length xs@3@12))
          (not (< i@24@12 (Seq_length xs@3@12))))))
    (or (<= 0 i@24@12) (not (<= 0 i@24@12)))
    (=>
      (and
        (<= 0 i@24@12)
        (and
          (< i@24@12 (Seq_length xs@3@12))
          (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12)))))
      (and
        (<= 0 i@24@12)
        (< i@24@12 (Seq_length xs@3@12))
        (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12)))))
    (or
      (not
        (and
          (<= 0 i@24@12)
          (and
            (< i@24@12 (Seq_length xs@3@12))
            (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12))))))
      (and
        (<= 0 i@24@12)
        (and
          (< i@24@12 (Seq_length xs@3@12))
          (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12)))))))
  :pattern ((Seq_index xs@3@12 i@24@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114-aux|)))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (=>
  (= index@17@12 (- 0 1))
  (forall ((i@24@12 Int)) (!
    (and
      (=>
        (<= 0 i@24@12)
        (and
          (<= 0 i@24@12)
          (=>
            (< i@24@12 (Seq_length xs@3@12))
            (and
              (< i@24@12 (Seq_length xs@3@12))
              (or (<= low@23@12 i@24@12) (not (<= low@23@12 i@24@12)))))
          (or
            (< i@24@12 (Seq_length xs@3@12))
            (not (< i@24@12 (Seq_length xs@3@12))))))
      (or (<= 0 i@24@12) (not (<= 0 i@24@12)))
      (=>
        (and
          (<= 0 i@24@12)
          (and
            (< i@24@12 (Seq_length xs@3@12))
            (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12)))))
        (and
          (<= 0 i@24@12)
          (< i@24@12 (Seq_length xs@3@12))
          (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12)))))
      (or
        (not
          (and
            (<= 0 i@24@12)
            (and
              (< i@24@12 (Seq_length xs@3@12))
              (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12))))))
        (and
          (<= 0 i@24@12)
          (and
            (< i@24@12 (Seq_length xs@3@12))
            (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12)))))))
    :pattern ((Seq_index xs@3@12 i@24@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114-aux|))))
(push) ; 7
(assert (not (=>
  (= index@17@12 (- 0 1))
  (forall ((i@24@12 Int)) (!
    (=>
      (and
        (<= 0 i@24@12)
        (and
          (< i@24@12 (Seq_length xs@3@12))
          (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12)))))
      (not (= (Seq_index xs@3@12 i@24@12) key@4@12)))
    :pattern ((Seq_index xs@3@12 i@24@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114|)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (=>
  (= index@17@12 (- 0 1))
  (forall ((i@24@12 Int)) (!
    (=>
      (and
        (<= 0 i@24@12)
        (and
          (< i@24@12 (Seq_length xs@3@12))
          (not (and (<= low@23@12 i@24@12) (< i@24@12 high@16@12)))))
      (not (= (Seq_index xs@3@12 i@24@12) key@4@12)))
    :pattern ((Seq_index xs@3@12 i@24@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114|))))
; [eval] -1 <= index
; [eval] -1
; [eval] index < |xs|
; [eval] |xs|
; [eval] 0 <= index ==> xs[index] == key
; [eval] 0 <= index
(push) ; 7
(push) ; 8
(set-option :timeout 10)
(assert (not (not (<= 0 index@17@12))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [then-branch: 29 | 0 <= index@17@12 | dead]
; [else-branch: 29 | !(0 <= index@17@12) | live]
(set-option :timeout 0)
(push) ; 8
; [else-branch: 29 | !(0 <= index@17@12)]
(assert (not (<= 0 index@17@12)))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (not (<= 0 index@17@12)))
(pop) ; 6
(push) ; 6
; [else-branch: 23 | !(xs@3@12[mid@22@12] < key@4@12)]
(assert (not (< (Seq_index xs@3@12 mid@22@12) key@4@12)))
(pop) ; 6
; [eval] !(xs[mid] < key)
; [eval] xs[mid] < key
; [eval] xs[mid]
(push) ; 6
(assert (not (>= mid@22@12 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (< mid@22@12 (Seq_length xs@3@12))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(set-option :timeout 10)
(assert (not (< (Seq_index xs@3@12 mid@22@12) key@4@12)))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 10)
(assert (not (not (< (Seq_index xs@3@12 mid@22@12) key@4@12))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [then-branch: 30 | !(xs@3@12[mid@22@12] < key@4@12) | live]
; [else-branch: 30 | xs@3@12[mid@22@12] < key@4@12 | live]
(set-option :timeout 0)
(push) ; 6
; [then-branch: 30 | !(xs@3@12[mid@22@12] < key@4@12)]
(assert (not (< (Seq_index xs@3@12 mid@22@12) key@4@12)))
; [eval] key < xs[mid]
; [eval] xs[mid]
(push) ; 7
(assert (not (>= mid@22@12 0)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(assert (not (< mid@22@12 (Seq_length xs@3@12))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(set-option :timeout 10)
(assert (not (not (< key@4@12 (Seq_index xs@3@12 mid@22@12)))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (< key@4@12 (Seq_index xs@3@12 mid@22@12))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [then-branch: 31 | key@4@12 < xs@3@12[mid@22@12] | live]
; [else-branch: 31 | !(key@4@12 < xs@3@12[mid@22@12]) | live]
(set-option :timeout 0)
(push) ; 7
; [then-branch: 31 | key@4@12 < xs@3@12[mid@22@12]]
(assert (< key@4@12 (Seq_index xs@3@12 mid@22@12)))
; [exec]
; high := mid
; Loop head block: Re-establish invariant
; [eval] 0 <= low
; [eval] low <= high
(push) ; 8
(assert (not (<= low@15@12 mid@22@12)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (<= low@15@12 mid@22@12))
; [eval] high <= |xs|
; [eval] |xs|
(push) ; 8
(assert (not (<= mid@22@12 (Seq_length xs@3@12))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (<= mid@22@12 (Seq_length xs@3@12)))
; [eval] index == -1 ==> (forall i: Int :: { xs[i] } 0 <= i && (i < |xs| && !(low <= i && i < high)) ==> xs[i] != key)
; [eval] index == -1
; [eval] -1
(push) ; 8
(push) ; 9
(set-option :timeout 10)
(assert (not (not (= index@17@12 (- 0 1)))))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [then-branch: 32 | index@17@12 == -1 | live]
; [else-branch: 32 | index@17@12 != -1 | dead]
(set-option :timeout 0)
(push) ; 9
; [then-branch: 32 | index@17@12 == -1]
; [eval] (forall i: Int :: { xs[i] } 0 <= i && (i < |xs| && !(low <= i && i < high)) ==> xs[i] != key)
(declare-const i@25@12 Int)
(push) ; 10
; [eval] 0 <= i && (i < |xs| && !(low <= i && i < high)) ==> xs[i] != key
; [eval] 0 <= i && (i < |xs| && !(low <= i && i < high))
; [eval] 0 <= i
(push) ; 11
; [then-branch: 33 | !(0 <= i@25@12) | live]
; [else-branch: 33 | 0 <= i@25@12 | live]
(push) ; 12
; [then-branch: 33 | !(0 <= i@25@12)]
(assert (not (<= 0 i@25@12)))
(pop) ; 12
(push) ; 12
; [else-branch: 33 | 0 <= i@25@12]
(assert (<= 0 i@25@12))
; [eval] i < |xs|
; [eval] |xs|
(push) ; 13
; [then-branch: 34 | !(i@25@12 < |xs@3@12|) | live]
; [else-branch: 34 | i@25@12 < |xs@3@12| | live]
(push) ; 14
; [then-branch: 34 | !(i@25@12 < |xs@3@12|)]
(assert (not (< i@25@12 (Seq_length xs@3@12))))
(pop) ; 14
(push) ; 14
; [else-branch: 34 | i@25@12 < |xs@3@12|]
(assert (< i@25@12 (Seq_length xs@3@12)))
; [eval] !(low <= i && i < high)
; [eval] low <= i && i < high
; [eval] low <= i
(push) ; 15
; [then-branch: 35 | !(low@15@12 <= i@25@12) | live]
; [else-branch: 35 | low@15@12 <= i@25@12 | live]
(push) ; 16
; [then-branch: 35 | !(low@15@12 <= i@25@12)]
(assert (not (<= low@15@12 i@25@12)))
(pop) ; 16
(push) ; 16
; [else-branch: 35 | low@15@12 <= i@25@12]
(assert (<= low@15@12 i@25@12))
; [eval] i < high
(pop) ; 16
(pop) ; 15
; Joined path conditions
; Joined path conditions
(assert (or (<= low@15@12 i@25@12) (not (<= low@15@12 i@25@12))))
(pop) ; 14
(pop) ; 13
; Joined path conditions
; Joined path conditions
(assert (=>
  (< i@25@12 (Seq_length xs@3@12))
  (and
    (< i@25@12 (Seq_length xs@3@12))
    (or (<= low@15@12 i@25@12) (not (<= low@15@12 i@25@12))))))
(assert (or (< i@25@12 (Seq_length xs@3@12)) (not (< i@25@12 (Seq_length xs@3@12)))))
(pop) ; 12
(pop) ; 11
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= 0 i@25@12)
  (and
    (<= 0 i@25@12)
    (=>
      (< i@25@12 (Seq_length xs@3@12))
      (and
        (< i@25@12 (Seq_length xs@3@12))
        (or (<= low@15@12 i@25@12) (not (<= low@15@12 i@25@12)))))
    (or (< i@25@12 (Seq_length xs@3@12)) (not (< i@25@12 (Seq_length xs@3@12)))))))
(assert (or (<= 0 i@25@12) (not (<= 0 i@25@12))))
(push) ; 11
; [then-branch: 36 | 0 <= i@25@12 && i@25@12 < |xs@3@12| && !(low@15@12 <= i@25@12 && i@25@12 < mid@22@12) | live]
; [else-branch: 36 | !(0 <= i@25@12 && i@25@12 < |xs@3@12| && !(low@15@12 <= i@25@12 && i@25@12 < mid@22@12)) | live]
(push) ; 12
; [then-branch: 36 | 0 <= i@25@12 && i@25@12 < |xs@3@12| && !(low@15@12 <= i@25@12 && i@25@12 < mid@22@12)]
(assert (and
  (<= 0 i@25@12)
  (and
    (< i@25@12 (Seq_length xs@3@12))
    (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12))))))
; [eval] xs[i] != key
; [eval] xs[i]
(push) ; 13
(assert (not (>= i@25@12 0)))
(check-sat)
; unsat
(pop) ; 13
; 0.00s
; (get-info :all-statistics)
(pop) ; 12
(push) ; 12
; [else-branch: 36 | !(0 <= i@25@12 && i@25@12 < |xs@3@12| && !(low@15@12 <= i@25@12 && i@25@12 < mid@22@12))]
(assert (not
  (and
    (<= 0 i@25@12)
    (and
      (< i@25@12 (Seq_length xs@3@12))
      (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12)))))))
(pop) ; 12
(pop) ; 11
; Joined path conditions
(assert (=>
  (and
    (<= 0 i@25@12)
    (and
      (< i@25@12 (Seq_length xs@3@12))
      (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12)))))
  (and
    (<= 0 i@25@12)
    (< i@25@12 (Seq_length xs@3@12))
    (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12))))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= 0 i@25@12)
      (and
        (< i@25@12 (Seq_length xs@3@12))
        (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12))))))
  (and
    (<= 0 i@25@12)
    (and
      (< i@25@12 (Seq_length xs@3@12))
      (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12)))))))
(pop) ; 10
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@25@12 Int)) (!
  (and
    (=>
      (<= 0 i@25@12)
      (and
        (<= 0 i@25@12)
        (=>
          (< i@25@12 (Seq_length xs@3@12))
          (and
            (< i@25@12 (Seq_length xs@3@12))
            (or (<= low@15@12 i@25@12) (not (<= low@15@12 i@25@12)))))
        (or
          (< i@25@12 (Seq_length xs@3@12))
          (not (< i@25@12 (Seq_length xs@3@12))))))
    (or (<= 0 i@25@12) (not (<= 0 i@25@12)))
    (=>
      (and
        (<= 0 i@25@12)
        (and
          (< i@25@12 (Seq_length xs@3@12))
          (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12)))))
      (and
        (<= 0 i@25@12)
        (< i@25@12 (Seq_length xs@3@12))
        (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12)))))
    (or
      (not
        (and
          (<= 0 i@25@12)
          (and
            (< i@25@12 (Seq_length xs@3@12))
            (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12))))))
      (and
        (<= 0 i@25@12)
        (and
          (< i@25@12 (Seq_length xs@3@12))
          (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12)))))))
  :pattern ((Seq_index xs@3@12 i@25@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114-aux|)))
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (=>
  (= index@17@12 (- 0 1))
  (forall ((i@25@12 Int)) (!
    (and
      (=>
        (<= 0 i@25@12)
        (and
          (<= 0 i@25@12)
          (=>
            (< i@25@12 (Seq_length xs@3@12))
            (and
              (< i@25@12 (Seq_length xs@3@12))
              (or (<= low@15@12 i@25@12) (not (<= low@15@12 i@25@12)))))
          (or
            (< i@25@12 (Seq_length xs@3@12))
            (not (< i@25@12 (Seq_length xs@3@12))))))
      (or (<= 0 i@25@12) (not (<= 0 i@25@12)))
      (=>
        (and
          (<= 0 i@25@12)
          (and
            (< i@25@12 (Seq_length xs@3@12))
            (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12)))))
        (and
          (<= 0 i@25@12)
          (< i@25@12 (Seq_length xs@3@12))
          (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12)))))
      (or
        (not
          (and
            (<= 0 i@25@12)
            (and
              (< i@25@12 (Seq_length xs@3@12))
              (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12))))))
        (and
          (<= 0 i@25@12)
          (and
            (< i@25@12 (Seq_length xs@3@12))
            (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12)))))))
    :pattern ((Seq_index xs@3@12 i@25@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114-aux|))))
(push) ; 8
(assert (not (=>
  (= index@17@12 (- 0 1))
  (forall ((i@25@12 Int)) (!
    (=>
      (and
        (<= 0 i@25@12)
        (and
          (< i@25@12 (Seq_length xs@3@12))
          (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12)))))
      (not (= (Seq_index xs@3@12 i@25@12) key@4@12)))
    :pattern ((Seq_index xs@3@12 i@25@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114|)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (=>
  (= index@17@12 (- 0 1))
  (forall ((i@25@12 Int)) (!
    (=>
      (and
        (<= 0 i@25@12)
        (and
          (< i@25@12 (Seq_length xs@3@12))
          (not (and (<= low@15@12 i@25@12) (< i@25@12 mid@22@12)))))
      (not (= (Seq_index xs@3@12 i@25@12) key@4@12)))
    :pattern ((Seq_index xs@3@12 i@25@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@18@33@18@114|))))
; [eval] -1 <= index
; [eval] -1
; [eval] index < |xs|
; [eval] |xs|
; [eval] 0 <= index ==> xs[index] == key
; [eval] 0 <= index
(push) ; 8
(push) ; 9
(set-option :timeout 10)
(assert (not (not (<= 0 index@17@12))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [then-branch: 37 | 0 <= index@17@12 | dead]
; [else-branch: 37 | !(0 <= index@17@12) | live]
(set-option :timeout 0)
(push) ; 9
; [else-branch: 37 | !(0 <= index@17@12)]
(assert (not (<= 0 index@17@12)))
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (not (<= 0 index@17@12)))
(pop) ; 7
(push) ; 7
; [else-branch: 31 | !(key@4@12 < xs@3@12[mid@22@12])]
(assert (not (< key@4@12 (Seq_index xs@3@12 mid@22@12))))
(pop) ; 7
; [eval] !(key < xs[mid])
; [eval] key < xs[mid]
; [eval] xs[mid]
(push) ; 7
(assert (not (>= mid@22@12 0)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(assert (not (< mid@22@12 (Seq_length xs@3@12))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(set-option :timeout 10)
(assert (not (< key@4@12 (Seq_index xs@3@12 mid@22@12))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (not (< key@4@12 (Seq_index xs@3@12 mid@22@12)))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [then-branch: 38 | !(key@4@12 < xs@3@12[mid@22@12]) | live]
; [else-branch: 38 | key@4@12 < xs@3@12[mid@22@12] | live]
(set-option :timeout 0)
(push) ; 7
; [then-branch: 38 | !(key@4@12 < xs@3@12[mid@22@12])]
(assert (not (< key@4@12 (Seq_index xs@3@12 mid@22@12))))
; [exec]
; index := mid
; [exec]
; high := mid
; Loop head block: Re-establish invariant
; [eval] 0 <= low
; [eval] low <= high
(push) ; 8
(assert (not (<= low@15@12 mid@22@12)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (<= low@15@12 mid@22@12))
; [eval] high <= |xs|
; [eval] |xs|
(push) ; 8
(assert (not (<= mid@22@12 (Seq_length xs@3@12))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (<= mid@22@12 (Seq_length xs@3@12)))
; [eval] index == -1 ==> (forall i: Int :: { xs[i] } 0 <= i && (i < |xs| && !(low <= i && i < high)) ==> xs[i] != key)
; [eval] index == -1
; [eval] -1
(push) ; 8
(push) ; 9
(set-option :timeout 10)
(assert (not (not (= mid@22@12 (- 0 1)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [then-branch: 39 | mid@22@12 == -1 | dead]
; [else-branch: 39 | mid@22@12 != -1 | live]
(set-option :timeout 0)
(push) ; 9
; [else-branch: 39 | mid@22@12 != -1]
(assert (not (= mid@22@12 (- 0 1))))
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (not (= mid@22@12 (- 0 1))))
; [eval] -1 <= index
; [eval] -1
(push) ; 8
(assert (not (<= (- 0 1) mid@22@12)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (<= (- 0 1) mid@22@12))
; [eval] index < |xs|
; [eval] |xs|
(push) ; 8
(assert (not (< mid@22@12 (Seq_length xs@3@12))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (< mid@22@12 (Seq_length xs@3@12)))
; [eval] 0 <= index ==> xs[index] == key
; [eval] 0 <= index
(push) ; 8
(push) ; 9
(set-option :timeout 10)
(assert (not (not (<= 0 mid@22@12))))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 9
(set-option :timeout 10)
(assert (not (<= 0 mid@22@12)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [then-branch: 40 | 0 <= mid@22@12 | live]
; [else-branch: 40 | !(0 <= mid@22@12) | dead]
(set-option :timeout 0)
(push) ; 9
; [then-branch: 40 | 0 <= mid@22@12]
(assert (<= 0 mid@22@12))
; [eval] xs[index] == key
; [eval] xs[index]
(push) ; 10
(assert (not (>= mid@22@12 0)))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (<= 0 mid@22@12))
(push) ; 8
(assert (not (=> (<= 0 mid@22@12) (= (Seq_index xs@3@12 mid@22@12) key@4@12))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (=> (<= 0 mid@22@12) (= (Seq_index xs@3@12 mid@22@12) key@4@12)))
(pop) ; 7
(push) ; 7
; [else-branch: 38 | key@4@12 < xs@3@12[mid@22@12]]
(assert (< key@4@12 (Seq_index xs@3@12 mid@22@12)))
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch: 30 | xs@3@12[mid@22@12] < key@4@12]
(assert (< (Seq_index xs@3@12 mid@22@12) key@4@12))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch: 22 | !(low@15@12 < high@16@12 && index@17@12 == -1)]
(assert (not (and (< low@15@12 high@16@12) (= index@17@12 (- 0 1)))))
(pop) ; 5
; [eval] !(low < high && index == -1)
; [eval] low < high && index == -1
; [eval] low < high
(push) ; 5
; [then-branch: 41 | !(low@15@12 < high@16@12) | live]
; [else-branch: 41 | low@15@12 < high@16@12 | live]
(push) ; 6
; [then-branch: 41 | !(low@15@12 < high@16@12)]
(assert (not (< low@15@12 high@16@12)))
(pop) ; 6
(push) ; 6
; [else-branch: 41 | low@15@12 < high@16@12]
(assert (< low@15@12 high@16@12))
; [eval] index == -1
; [eval] -1
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(push) ; 5
(set-option :timeout 10)
(assert (not (and (< low@15@12 high@16@12) (= index@17@12 (- 0 1)))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 10)
(assert (not (not (and (< low@15@12 high@16@12) (= index@17@12 (- 0 1))))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [then-branch: 42 | !(low@15@12 < high@16@12 && index@17@12 == -1) | live]
; [else-branch: 42 | low@15@12 < high@16@12 && index@17@12 == -1 | live]
(set-option :timeout 0)
(push) ; 5
; [then-branch: 42 | !(low@15@12 < high@16@12 && index@17@12 == -1)]
(assert (not (and (< low@15@12 high@16@12) (= index@17@12 (- 0 1)))))
; [eval] -1 <= index
; [eval] -1
; [eval] index < |xs|
; [eval] |xs|
; [eval] 0 <= index ==> xs[index] == key
; [eval] 0 <= index
(push) ; 6
(push) ; 7
(set-option :timeout 10)
(assert (not (not (<= 0 index@17@12))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (<= 0 index@17@12)))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [then-branch: 43 | 0 <= index@17@12 | live]
; [else-branch: 43 | !(0 <= index@17@12) | live]
(set-option :timeout 0)
(push) ; 7
; [then-branch: 43 | 0 <= index@17@12]
(assert (<= 0 index@17@12))
; [eval] xs[index] == key
; [eval] xs[index]
(push) ; 8
(assert (not (>= index@17@12 0)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 43 | !(0 <= index@17@12)]
(assert (not (<= 0 index@17@12)))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
; [eval] -1 == index ==> (forall i: Int :: { xs[i] } 0 <= i && i < |xs| ==> xs[i] != key)
; [eval] -1 == index
; [eval] -1
(push) ; 6
(push) ; 7
(set-option :timeout 10)
(assert (not (not (= (- 0 1) index@17@12))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (= (- 0 1) index@17@12)))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [then-branch: 44 | -1 == index@17@12 | live]
; [else-branch: 44 | -1 != index@17@12 | live]
(set-option :timeout 0)
(push) ; 7
; [then-branch: 44 | -1 == index@17@12]
(assert (= (- 0 1) index@17@12))
; [eval] (forall i: Int :: { xs[i] } 0 <= i && i < |xs| ==> xs[i] != key)
(declare-const i@26@12 Int)
(push) ; 8
; [eval] 0 <= i && i < |xs| ==> xs[i] != key
; [eval] 0 <= i && i < |xs|
; [eval] 0 <= i
(push) ; 9
; [then-branch: 45 | !(0 <= i@26@12) | live]
; [else-branch: 45 | 0 <= i@26@12 | live]
(push) ; 10
; [then-branch: 45 | !(0 <= i@26@12)]
(assert (not (<= 0 i@26@12)))
(pop) ; 10
(push) ; 10
; [else-branch: 45 | 0 <= i@26@12]
(assert (<= 0 i@26@12))
; [eval] i < |xs|
; [eval] |xs|
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@26@12) (not (<= 0 i@26@12))))
(push) ; 9
; [then-branch: 46 | 0 <= i@26@12 && i@26@12 < |xs@3@12| | live]
; [else-branch: 46 | !(0 <= i@26@12 && i@26@12 < |xs@3@12|) | live]
(push) ; 10
; [then-branch: 46 | 0 <= i@26@12 && i@26@12 < |xs@3@12|]
(assert (and (<= 0 i@26@12) (< i@26@12 (Seq_length xs@3@12))))
; [eval] xs[i] != key
; [eval] xs[i]
(push) ; 11
(assert (not (>= i@26@12 0)))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(pop) ; 10
(push) ; 10
; [else-branch: 46 | !(0 <= i@26@12 && i@26@12 < |xs@3@12|)]
(assert (not (and (<= 0 i@26@12) (< i@26@12 (Seq_length xs@3@12)))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= 0 i@26@12) (< i@26@12 (Seq_length xs@3@12))))
  (and (<= 0 i@26@12) (< i@26@12 (Seq_length xs@3@12)))))
(pop) ; 8
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@26@12 Int)) (!
  (and
    (or (<= 0 i@26@12) (not (<= 0 i@26@12)))
    (or
      (not (and (<= 0 i@26@12) (< i@26@12 (Seq_length xs@3@12))))
      (and (<= 0 i@26@12) (< i@26@12 (Seq_length xs@3@12)))))
  :pattern ((Seq_index xs@3@12 i@26@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@10@29@10@81-aux|)))
(pop) ; 7
(push) ; 7
; [else-branch: 44 | -1 != index@17@12]
(assert (not (= (- 0 1) index@17@12)))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (=>
  (= (- 0 1) index@17@12)
  (and
    (= (- 0 1) index@17@12)
    (forall ((i@26@12 Int)) (!
      (and
        (or (<= 0 i@26@12) (not (<= 0 i@26@12)))
        (or
          (not (and (<= 0 i@26@12) (< i@26@12 (Seq_length xs@3@12))))
          (and (<= 0 i@26@12) (< i@26@12 (Seq_length xs@3@12)))))
      :pattern ((Seq_index xs@3@12 i@26@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@10@29@10@81-aux|)))))
; Joined path conditions
(assert (or (not (= (- 0 1) index@17@12)) (= (- 0 1) index@17@12)))
(push) ; 6
(assert (not (=>
  (= (- 0 1) index@17@12)
  (forall ((i@26@12 Int)) (!
    (=>
      (and (<= 0 i@26@12) (< i@26@12 (Seq_length xs@3@12)))
      (not (= (Seq_index xs@3@12 i@26@12) key@4@12)))
    :pattern ((Seq_index xs@3@12 i@26@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@10@29@10@81|)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (=>
  (= (- 0 1) index@17@12)
  (forall ((i@26@12 Int)) (!
    (=>
      (and (<= 0 i@26@12) (< i@26@12 (Seq_length xs@3@12)))
      (not (= (Seq_index xs@3@12 i@26@12) key@4@12)))
    :pattern ((Seq_index xs@3@12 i@26@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/binary-search/binary-search-seq.vpr@10@29@10@81|))))
(pop) ; 5
(push) ; 5
; [else-branch: 42 | low@15@12 < high@16@12 && index@17@12 == -1]
(assert (and (< low@15@12 high@16@12) (= index@17@12 (- 0 1))))
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
(pop) ; 1
