(get-info :version)
; (:version "4.13.0")
; Started: 2024-09-24 15:32:52
; Silicon.version: 1.1-SNAPSHOT (b737e366)
; Input file: /Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates-with-wands.vpr
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
(declare-sort $MWSF 0)
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
; Declaring additional sort wrappers
(declare-fun $SortWrappers.$MWSFTo$Snap ($MWSF) $Snap)
(declare-fun $SortWrappers.$SnapTo$MWSF ($Snap) $MWSF)
(assert (forall ((x $MWSF)) (!
    (= x ($SortWrappers.$SnapTo$MWSF($SortWrappers.$MWSFTo$Snap x)))
    :pattern (($SortWrappers.$MWSFTo$Snap x))
    :qid |$Snap.$SnapTo$MWSFTo$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.$MWSFTo$Snap($SortWrappers.$SnapTo$MWSF x)))
    :pattern (($SortWrappers.$SnapTo$MWSF x))
    :qid |$Snap.$MWSFTo$SnapTo$MWSF|
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
(declare-fun MWSF_apply ($MWSF $Snap) $Snap)
; Declaring symbols related to program functions (from program analysis)
(declare-fun contentNodes ($Snap $Ref $Ref) Seq<Int>)
(declare-fun contentNodes%limited ($Snap $Ref $Ref) Seq<Int>)
(declare-fun contentNodes%stateless ($Ref $Ref) Bool)
(declare-fun contentNodes%precondition ($Snap $Ref $Ref) Bool)
(declare-fun lengthNodes ($Snap $Ref $Ref) Int)
(declare-fun lengthNodes%limited ($Snap $Ref $Ref) Int)
(declare-fun lengthNodes%stateless ($Ref $Ref) Bool)
(declare-fun lengthNodes%precondition ($Snap $Ref $Ref) Bool)
(declare-fun content ($Snap $Ref) Seq<Int>)
(declare-fun content%limited ($Snap $Ref) Seq<Int>)
(declare-fun content%stateless ($Ref) Bool)
(declare-fun content%precondition ($Snap $Ref) Bool)
(declare-fun length ($Snap $Ref) Int)
(declare-fun length%limited ($Snap $Ref) Int)
(declare-fun length%stateless ($Ref) Bool)
(declare-fun length%precondition ($Snap $Ref) Bool)
(declare-fun peek ($Snap $Ref) Int)
(declare-fun peek%limited ($Snap $Ref) Int)
(declare-fun peek%stateless ($Ref) Bool)
(declare-fun peek%precondition ($Snap $Ref) Bool)
; Snapshot variable to be used during function verification
(declare-fun s@$ () $Snap)
; Declaring predicate trigger functions
(declare-fun lseg%trigger ($Snap $Ref $Ref) Bool)
(declare-fun List%trigger ($Snap $Ref) Bool)
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
(declare-fun joined_unfolding@14@00 ($Snap $Ref $Ref) Bool)
(declare-fun joined_unfolding@18@00 ($Snap $Ref $Ref) Bool)
(declare-fun joined_unfolding@20@00 ($Snap $Ref $Ref) Bool)
(declare-fun joined_unfolding@25@00 ($Snap $Ref $Ref) Bool)
(declare-fun joined_unfolding@26@00 ($Snap $Ref $Ref) Int)
(declare-fun joined_unfolding@35@00 ($Snap $Ref) Bool)
(assert (forall ((s@$ $Snap) (this@0@00 $Ref) (end@1@00 $Ref)) (!
  (=
    (contentNodes%limited s@$ this@0@00 end@1@00)
    (contentNodes s@$ this@0@00 end@1@00))
  :pattern ((contentNodes s@$ this@0@00 end@1@00))
  :qid |quant-u-0|)))
(assert (forall ((s@$ $Snap) (this@0@00 $Ref) (end@1@00 $Ref)) (!
  (contentNodes%stateless this@0@00 end@1@00)
  :pattern ((contentNodes%limited s@$ this@0@00 end@1@00))
  :qid |quant-u-1|)))
(assert (forall ((s@$ $Snap) (this@0@00 $Ref) (end@1@00 $Ref)) (!
  (let ((result@2@00 (contentNodes%limited s@$ this@0@00 end@1@00))) (=>
    (contentNodes%precondition s@$ this@0@00 end@1@00)
    (and
      (=>
        (= this@0@00 end@1@00)
        (Seq_equal result@2@00 (as Seq_empty  Seq<Int>)))
      (=>
        (not (= this@0@00 end@1@00))
        (and
          (> (Seq_length result@2@00) 0)
          (=
            (Seq_index result@2@00 0)
            ($SortWrappers.$SnapToInt ($Snap.first s@$)))))
      (forall ((i Int) (j Int)) (!
        (=>
          (and (<= 0 i) (and (< i j) (< j (Seq_length result@2@00))))
          (<= (Seq_index result@2@00 i) (Seq_index result@2@00 j)))
        :pattern ((Seq_index result@2@00 i) (Seq_index result@2@00 j))
        )))))
  :pattern ((contentNodes%limited s@$ this@0@00 end@1@00))
  :qid |quant-u-10|)))
(assert (forall ((s@$ $Snap) (this@0@00 $Ref) (end@1@00 $Ref)) (!
  (let ((result@2@00 (contentNodes%limited s@$ this@0@00 end@1@00))) true)
  :pattern ((contentNodes%limited s@$ this@0@00 end@1@00))
  :qid |quant-u-11|)))
(assert (forall ((s@$ $Snap) (this@0@00 $Ref) (end@1@00 $Ref)) (!
  (let ((result@2@00 (contentNodes%limited s@$ this@0@00 end@1@00))) true)
  :pattern ((contentNodes%limited s@$ this@0@00 end@1@00))
  :qid |quant-u-12|)))
(assert (forall ((s@$ $Snap) (this@0@00 $Ref) (end@1@00 $Ref)) (!
  (let ((result@2@00 (contentNodes%limited s@$ this@0@00 end@1@00))) true)
  :pattern ((contentNodes%limited s@$ this@0@00 end@1@00))
  :qid |quant-u-13|)))
(assert (forall ((s@$ $Snap) (this@0@00 $Ref) (end@1@00 $Ref)) (!
  (=>
    (contentNodes%precondition s@$ this@0@00 end@1@00)
    (=
      (contentNodes s@$ this@0@00 end@1@00)
      (ite
        (= this@0@00 end@1@00)
        (as Seq_empty  Seq<Int>)
        (Seq_append
          (Seq_singleton ($SortWrappers.$SnapToInt ($Snap.first s@$)))
          (contentNodes%limited ($Snap.first ($Snap.second ($Snap.second s@$))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second s@$))) end@1@00)))))
  :pattern ((contentNodes s@$ this@0@00 end@1@00))
  :pattern ((contentNodes%stateless this@0@00 end@1@00) (lseg%trigger s@$ this@0@00 end@1@00))
  :qid |quant-u-14|)))
(assert (forall ((s@$ $Snap) (this@0@00 $Ref) (end@1@00 $Ref)) (!
  (=>
    (contentNodes%precondition s@$ this@0@00 end@1@00)
    (ite
      (= this@0@00 end@1@00)
      true
      (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second s@$))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second s@$))) end@1@00)))
  :pattern ((contentNodes s@$ this@0@00 end@1@00))
  :qid |quant-u-15|)))
(assert (forall ((s@$ $Snap) (this@3@00 $Ref) (end@4@00 $Ref)) (!
  (=
    (lengthNodes%limited s@$ this@3@00 end@4@00)
    (lengthNodes s@$ this@3@00 end@4@00))
  :pattern ((lengthNodes s@$ this@3@00 end@4@00))
  :qid |quant-u-2|)))
(assert (forall ((s@$ $Snap) (this@3@00 $Ref) (end@4@00 $Ref)) (!
  (lengthNodes%stateless this@3@00 end@4@00)
  :pattern ((lengthNodes%limited s@$ this@3@00 end@4@00))
  :qid |quant-u-3|)))
(assert (forall ((s@$ $Snap) (this@3@00 $Ref) (end@4@00 $Ref)) (!
  (let ((result@5@00 (lengthNodes%limited s@$ this@3@00 end@4@00))) (=>
    (lengthNodes%precondition s@$ this@3@00 end@4@00)
    (= result@5@00 (Seq_length (contentNodes s@$ this@3@00 end@4@00)))))
  :pattern ((lengthNodes%limited s@$ this@3@00 end@4@00))
  :qid |quant-u-16|)))
(assert (forall ((s@$ $Snap) (this@3@00 $Ref) (end@4@00 $Ref)) (!
  (let ((result@5@00 (lengthNodes%limited s@$ this@3@00 end@4@00))) (=>
    (lengthNodes%precondition s@$ this@3@00 end@4@00)
    (contentNodes%precondition s@$ this@3@00 end@4@00)))
  :pattern ((lengthNodes%limited s@$ this@3@00 end@4@00))
  :qid |quant-u-17|)))
(assert (forall ((s@$ $Snap) (this@3@00 $Ref) (end@4@00 $Ref)) (!
  (=>
    (lengthNodes%precondition s@$ this@3@00 end@4@00)
    (=
      (lengthNodes s@$ this@3@00 end@4@00)
      (ite
        (= this@3@00 end@4@00)
        0
        (+
          1
          (lengthNodes%limited ($Snap.first ($Snap.second ($Snap.second s@$))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second s@$))) end@4@00)))))
  :pattern ((lengthNodes s@$ this@3@00 end@4@00))
  :pattern ((lengthNodes%stateless this@3@00 end@4@00) (lseg%trigger s@$ this@3@00 end@4@00))
  :qid |quant-u-18|)))
(assert (forall ((s@$ $Snap) (this@3@00 $Ref) (end@4@00 $Ref)) (!
  (=>
    (lengthNodes%precondition s@$ this@3@00 end@4@00)
    (ite
      (= this@3@00 end@4@00)
      true
      (lengthNodes%precondition ($Snap.first ($Snap.second ($Snap.second s@$))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second s@$))) end@4@00)))
  :pattern ((lengthNodes s@$ this@3@00 end@4@00))
  :qid |quant-u-19|)))
(assert (forall ((s@$ $Snap) (this@6@00 $Ref)) (!
  (= (content%limited s@$ this@6@00) (content s@$ this@6@00))
  :pattern ((content s@$ this@6@00))
  :qid |quant-u-4|)))
(assert (forall ((s@$ $Snap) (this@6@00 $Ref)) (!
  (content%stateless this@6@00)
  :pattern ((content%limited s@$ this@6@00))
  :qid |quant-u-5|)))
(assert (forall ((s@$ $Snap) (this@6@00 $Ref)) (!
  (let ((result@7@00 (content%limited s@$ this@6@00))) (=>
    (content%precondition s@$ this@6@00)
    (forall ((i Int) (j Int)) (!
      (=>
        (and (<= 0 i) (and (< i j) (< j (Seq_length result@7@00))))
        (<= (Seq_index result@7@00 i) (Seq_index result@7@00 j)))
      :pattern ((Seq_index result@7@00 i) (Seq_index result@7@00 j))
      ))))
  :pattern ((content%limited s@$ this@6@00))
  :qid |quant-u-20|)))
(assert (forall ((s@$ $Snap) (this@6@00 $Ref)) (!
  (let ((result@7@00 (content%limited s@$ this@6@00))) true)
  :pattern ((content%limited s@$ this@6@00))
  :qid |quant-u-21|)))
(assert (forall ((s@$ $Snap) (this@6@00 $Ref)) (!
  (=>
    (content%precondition s@$ this@6@00)
    (=
      (content s@$ this@6@00)
      (contentNodes ($Snap.second s@$) ($SortWrappers.$SnapTo$Ref ($Snap.first s@$)) $Ref.null)))
  :pattern ((content s@$ this@6@00))
  :pattern ((content%stateless this@6@00) (List%trigger s@$ this@6@00))
  :qid |quant-u-22|)))
(assert (forall ((s@$ $Snap) (this@6@00 $Ref)) (!
  (=>
    (content%precondition s@$ this@6@00)
    (contentNodes%precondition ($Snap.second s@$) ($SortWrappers.$SnapTo$Ref ($Snap.first s@$)) $Ref.null))
  :pattern ((content s@$ this@6@00))
  :qid |quant-u-23|)))
(assert (forall ((s@$ $Snap) (this@8@00 $Ref)) (!
  (= (length%limited s@$ this@8@00) (length s@$ this@8@00))
  :pattern ((length s@$ this@8@00))
  :qid |quant-u-6|)))
(assert (forall ((s@$ $Snap) (this@8@00 $Ref)) (!
  (length%stateless this@8@00)
  :pattern ((length%limited s@$ this@8@00))
  :qid |quant-u-7|)))
(assert (forall ((s@$ $Snap) (this@8@00 $Ref)) (!
  (let ((result@9@00 (length%limited s@$ this@8@00))) (=>
    (length%precondition s@$ this@8@00)
    (= result@9@00 (Seq_length (content s@$ this@8@00)))))
  :pattern ((length%limited s@$ this@8@00))
  :qid |quant-u-24|)))
(assert (forall ((s@$ $Snap) (this@8@00 $Ref)) (!
  (let ((result@9@00 (length%limited s@$ this@8@00))) (=>
    (length%precondition s@$ this@8@00)
    (content%precondition s@$ this@8@00)))
  :pattern ((length%limited s@$ this@8@00))
  :qid |quant-u-25|)))
(assert (forall ((s@$ $Snap) (this@8@00 $Ref)) (!
  (=>
    (length%precondition s@$ this@8@00)
    (=
      (length s@$ this@8@00)
      (lengthNodes ($Snap.second s@$) ($SortWrappers.$SnapTo$Ref ($Snap.first s@$)) $Ref.null)))
  :pattern ((length s@$ this@8@00))
  :pattern ((length%stateless this@8@00) (List%trigger s@$ this@8@00))
  :qid |quant-u-26|)))
(assert (forall ((s@$ $Snap) (this@8@00 $Ref)) (!
  (=>
    (length%precondition s@$ this@8@00)
    (lengthNodes%precondition ($Snap.second s@$) ($SortWrappers.$SnapTo$Ref ($Snap.first s@$)) $Ref.null))
  :pattern ((length s@$ this@8@00))
  :qid |quant-u-27|)))
(assert (forall ((s@$ $Snap) (this@10@00 $Ref)) (!
  (= (peek%limited s@$ this@10@00) (peek s@$ this@10@00))
  :pattern ((peek s@$ this@10@00))
  :qid |quant-u-8|)))
(assert (forall ((s@$ $Snap) (this@10@00 $Ref)) (!
  (peek%stateless this@10@00)
  :pattern ((peek%limited s@$ this@10@00))
  :qid |quant-u-9|)))
(assert (forall ((s@$ $Snap) (this@10@00 $Ref)) (!
  (let ((result@11@00 (peek%limited s@$ this@10@00))) (=>
    (peek%precondition s@$ this@10@00)
    (= result@11@00 (Seq_index (content ($Snap.first s@$) this@10@00) 0))))
  :pattern ((peek%limited s@$ this@10@00))
  :qid |quant-u-28|)))
(assert (forall ((s@$ $Snap) (this@10@00 $Ref)) (!
  (let ((result@11@00 (peek%limited s@$ this@10@00))) (=>
    (peek%precondition s@$ this@10@00)
    (content%precondition ($Snap.first s@$) this@10@00)))
  :pattern ((peek%limited s@$ this@10@00))
  :qid |quant-u-29|)))
(assert (forall ((s@$ $Snap) (this@10@00 $Ref)) (!
  (=>
    (peek%precondition s@$ this@10@00)
    (=
      (peek s@$ this@10@00)
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first s@$))))))
  :pattern ((peek s@$ this@10@00))
  :qid |quant-u-30|)))
(assert (forall ((s@$ $Snap) (this@10@00 $Ref)) (!
  true
  :pattern ((peek s@$ this@10@00))
  :qid |quant-u-31|)))
; End function- and predicate-related preamble
; ------------------------------------------------------------
