(get-info :version)
; (:version "4.13.0")
; Started: 2024-09-24 15:33:17
; Silicon.version: 1.1-SNAPSHOT (b737e366)
; Input file: /Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr
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
(declare-sort Set<Int> 0)
(declare-sort Set<$Ref> 0)
(declare-sort Set<Bool> 0)
(declare-sort Set<$Snap> 0)
(declare-sort $FVF<head> 0)
(declare-sort $FVF<next> 0)
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
(declare-fun $SortWrappers.Set<Int>To$Snap (Set<Int>) $Snap)
(declare-fun $SortWrappers.$SnapToSet<Int> ($Snap) Set<Int>)
(assert (forall ((x Set<Int>)) (!
    (= x ($SortWrappers.$SnapToSet<Int>($SortWrappers.Set<Int>To$Snap x)))
    :pattern (($SortWrappers.Set<Int>To$Snap x))
    :qid |$Snap.$SnapToSet<Int>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.Set<Int>To$Snap($SortWrappers.$SnapToSet<Int> x)))
    :pattern (($SortWrappers.$SnapToSet<Int> x))
    :qid |$Snap.Set<Int>To$SnapToSet<Int>|
    )))
(declare-fun $SortWrappers.Set<$Ref>To$Snap (Set<$Ref>) $Snap)
(declare-fun $SortWrappers.$SnapToSet<$Ref> ($Snap) Set<$Ref>)
(assert (forall ((x Set<$Ref>)) (!
    (= x ($SortWrappers.$SnapToSet<$Ref>($SortWrappers.Set<$Ref>To$Snap x)))
    :pattern (($SortWrappers.Set<$Ref>To$Snap x))
    :qid |$Snap.$SnapToSet<$Ref>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.Set<$Ref>To$Snap($SortWrappers.$SnapToSet<$Ref> x)))
    :pattern (($SortWrappers.$SnapToSet<$Ref> x))
    :qid |$Snap.Set<$Ref>To$SnapToSet<$Ref>|
    )))
(declare-fun $SortWrappers.Set<Bool>To$Snap (Set<Bool>) $Snap)
(declare-fun $SortWrappers.$SnapToSet<Bool> ($Snap) Set<Bool>)
(assert (forall ((x Set<Bool>)) (!
    (= x ($SortWrappers.$SnapToSet<Bool>($SortWrappers.Set<Bool>To$Snap x)))
    :pattern (($SortWrappers.Set<Bool>To$Snap x))
    :qid |$Snap.$SnapToSet<Bool>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.Set<Bool>To$Snap($SortWrappers.$SnapToSet<Bool> x)))
    :pattern (($SortWrappers.$SnapToSet<Bool> x))
    :qid |$Snap.Set<Bool>To$SnapToSet<Bool>|
    )))
(declare-fun $SortWrappers.Set<$Snap>To$Snap (Set<$Snap>) $Snap)
(declare-fun $SortWrappers.$SnapToSet<$Snap> ($Snap) Set<$Snap>)
(assert (forall ((x Set<$Snap>)) (!
    (= x ($SortWrappers.$SnapToSet<$Snap>($SortWrappers.Set<$Snap>To$Snap x)))
    :pattern (($SortWrappers.Set<$Snap>To$Snap x))
    :qid |$Snap.$SnapToSet<$Snap>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.Set<$Snap>To$Snap($SortWrappers.$SnapToSet<$Snap> x)))
    :pattern (($SortWrappers.$SnapToSet<$Snap> x))
    :qid |$Snap.Set<$Snap>To$SnapToSet<$Snap>|
    )))
; Declaring additional sort wrappers
(declare-fun $SortWrappers.$FVF<head>To$Snap ($FVF<head>) $Snap)
(declare-fun $SortWrappers.$SnapTo$FVF<head> ($Snap) $FVF<head>)
(assert (forall ((x $FVF<head>)) (!
    (= x ($SortWrappers.$SnapTo$FVF<head>($SortWrappers.$FVF<head>To$Snap x)))
    :pattern (($SortWrappers.$FVF<head>To$Snap x))
    :qid |$Snap.$SnapTo$FVF<head>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.$FVF<head>To$Snap($SortWrappers.$SnapTo$FVF<head> x)))
    :pattern (($SortWrappers.$SnapTo$FVF<head> x))
    :qid |$Snap.$FVF<head>To$SnapTo$FVF<head>|
    )))
(declare-fun $SortWrappers.$FVF<next>To$Snap ($FVF<next>) $Snap)
(declare-fun $SortWrappers.$SnapTo$FVF<next> ($Snap) $FVF<next>)
(assert (forall ((x $FVF<next>)) (!
    (= x ($SortWrappers.$SnapTo$FVF<next>($SortWrappers.$FVF<next>To$Snap x)))
    :pattern (($SortWrappers.$FVF<next>To$Snap x))
    :qid |$Snap.$SnapTo$FVF<next>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.$FVF<next>To$Snap($SortWrappers.$SnapTo$FVF<next> x)))
    :pattern (($SortWrappers.$SnapTo$FVF<next> x))
    :qid |$Snap.$FVF<next>To$SnapTo$FVF<next>|
    )))
; ////////// Symbols
(declare-fun Set_card (Set<Int>) Int)
(declare-const Set_empty Set<Int>)
(declare-fun Set_in (Int Set<Int>) Bool)
(declare-fun Set_singleton (Int) Set<Int>)
(declare-fun Set_unionone (Set<Int> Int) Set<Int>)
(declare-fun Set_union (Set<Int> Set<Int>) Set<Int>)
(declare-fun Set_intersection (Set<Int> Set<Int>) Set<Int>)
(declare-fun Set_difference (Set<Int> Set<Int>) Set<Int>)
(declare-fun Set_subset (Set<Int> Set<Int>) Bool)
(declare-fun Set_equal (Set<Int> Set<Int>) Bool)
(declare-fun Set_skolem_diff (Set<Int> Set<Int>) Int)
(declare-fun Set_card (Set<$Ref>) Int)
(declare-const Set_empty Set<$Ref>)
(declare-fun Set_in ($Ref Set<$Ref>) Bool)
(declare-fun Set_singleton ($Ref) Set<$Ref>)
(declare-fun Set_unionone (Set<$Ref> $Ref) Set<$Ref>)
(declare-fun Set_union (Set<$Ref> Set<$Ref>) Set<$Ref>)
(declare-fun Set_intersection (Set<$Ref> Set<$Ref>) Set<$Ref>)
(declare-fun Set_difference (Set<$Ref> Set<$Ref>) Set<$Ref>)
(declare-fun Set_subset (Set<$Ref> Set<$Ref>) Bool)
(declare-fun Set_equal (Set<$Ref> Set<$Ref>) Bool)
(declare-fun Set_skolem_diff (Set<$Ref> Set<$Ref>) $Ref)
(declare-fun Set_card (Set<Bool>) Int)
(declare-const Set_empty Set<Bool>)
(declare-fun Set_in (Bool Set<Bool>) Bool)
(declare-fun Set_singleton (Bool) Set<Bool>)
(declare-fun Set_unionone (Set<Bool> Bool) Set<Bool>)
(declare-fun Set_union (Set<Bool> Set<Bool>) Set<Bool>)
(declare-fun Set_intersection (Set<Bool> Set<Bool>) Set<Bool>)
(declare-fun Set_difference (Set<Bool> Set<Bool>) Set<Bool>)
(declare-fun Set_subset (Set<Bool> Set<Bool>) Bool)
(declare-fun Set_equal (Set<Bool> Set<Bool>) Bool)
(declare-fun Set_skolem_diff (Set<Bool> Set<Bool>) Bool)
(declare-fun Set_card (Set<$Snap>) Int)
(declare-const Set_empty Set<$Snap>)
(declare-fun Set_in ($Snap Set<$Snap>) Bool)
(declare-fun Set_singleton ($Snap) Set<$Snap>)
(declare-fun Set_unionone (Set<$Snap> $Snap) Set<$Snap>)
(declare-fun Set_union (Set<$Snap> Set<$Snap>) Set<$Snap>)
(declare-fun Set_intersection (Set<$Snap> Set<$Snap>) Set<$Snap>)
(declare-fun Set_difference (Set<$Snap> Set<$Snap>) Set<$Snap>)
(declare-fun Set_subset (Set<$Snap> Set<$Snap>) Bool)
(declare-fun Set_equal (Set<$Snap> Set<$Snap>) Bool)
(declare-fun Set_skolem_diff (Set<$Snap> Set<$Snap>) $Snap)
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
; /field_value_functions_declarations.smt2 [head: Ref]
(declare-fun $FVF.domain_head ($FVF<head>) Set<$Ref>)
(declare-fun $FVF.lookup_head ($FVF<head> $Ref) $Ref)
(declare-fun $FVF.after_head ($FVF<head> $FVF<head>) Bool)
(declare-fun $FVF.loc_head ($Ref $Ref) Bool)
(declare-fun $FVF.perm_head ($FPM $Ref) $Perm)
(declare-const $fvfTOP_head $FVF<head>)
; /field_value_functions_declarations.smt2 [next: Ref]
(declare-fun $FVF.domain_next ($FVF<next>) Set<$Ref>)
(declare-fun $FVF.lookup_next ($FVF<next> $Ref) $Ref)
(declare-fun $FVF.after_next ($FVF<next> $FVF<next>) Bool)
(declare-fun $FVF.loc_next ($Ref $Ref) Bool)
(declare-fun $FVF.perm_next ($FPM $Ref) $Perm)
(declare-const $fvfTOP_next $FVF<next>)
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
(assert (forall ((s Set<Int>)) (!
  (<= 0 (Set_card s))
  :pattern ((Set_card s))
  )))
(assert (forall ((o Int)) (!
  (not (Set_in o (as Set_empty  Set<Int>)))
  :pattern ((Set_in o (as Set_empty  Set<Int>)))
  )))
(assert (forall ((s Set<Int>)) (!
  (and
    (=> (= (Set_card s) 0) (= s (as Set_empty  Set<Int>)))
    (=> (not (= (Set_card s) 0)) (exists ((x Int))  (Set_in x s))))
  :pattern ((Set_card s))
  )))
(assert (forall ((r Int)) (!
  (Set_in r (Set_singleton r))
  :pattern ((Set_singleton r))
  )))
(assert (forall ((r Int) (o Int)) (!
  (= (Set_in o (Set_singleton r)) (= r o))
  :pattern ((Set_in o (Set_singleton r)))
  )))
(assert (forall ((r Int)) (!
  (= (Set_card (Set_singleton r)) 1)
  :pattern ((Set_card (Set_singleton r)))
  )))
(assert (forall ((a Set<Int>) (x Int) (o Int)) (!
  (= (Set_in o (Set_unionone a x)) (or (= o x) (Set_in o a)))
  :pattern ((Set_in o (Set_unionone a x)))
  )))
(assert (forall ((a Set<Int>) (x Int)) (!
  (Set_in x (Set_unionone a x))
  :pattern ((Set_unionone a x))
  )))
(assert (forall ((a Set<Int>) (x Int) (y Int)) (!
  (=> (Set_in y a) (Set_in y (Set_unionone a x)))
  :pattern ((Set_unionone a x) (Set_in y a))
  )))
(assert (forall ((a Set<Int>) (x Int)) (!
  (=> (Set_in x a) (= (Set_card (Set_unionone a x)) (Set_card a)))
  :pattern ((Set_card (Set_unionone a x)))
  )))
(assert (forall ((a Set<Int>) (x Int)) (!
  (=> (not (Set_in x a)) (= (Set_card (Set_unionone a x)) (+ (Set_card a) 1)))
  :pattern ((Set_card (Set_unionone a x)))
  )))
(assert (forall ((a Set<Int>) (b Set<Int>) (o Int)) (!
  (= (Set_in o (Set_union a b)) (or (Set_in o a) (Set_in o b)))
  :pattern ((Set_in o (Set_union a b)))
  )))
(assert (forall ((a Set<Int>) (b Set<Int>) (y Int)) (!
  (=> (Set_in y a) (Set_in y (Set_union a b)))
  :pattern ((Set_union a b) (Set_in y a))
  )))
(assert (forall ((a Set<Int>) (b Set<Int>) (y Int)) (!
  (=> (Set_in y b) (Set_in y (Set_union a b)))
  :pattern ((Set_union a b) (Set_in y b))
  )))
(assert (forall ((a Set<Int>) (b Set<Int>) (o Int)) (!
  (= (Set_in o (Set_intersection a b)) (and (Set_in o a) (Set_in o b)))
  :pattern ((Set_in o (Set_intersection a b)))
  :pattern ((Set_intersection a b) (Set_in o a))
  :pattern ((Set_intersection a b) (Set_in o b))
  )))
(assert (forall ((a Set<Int>) (b Set<Int>)) (!
  (= (Set_union (Set_union a b) b) (Set_union a b))
  :pattern ((Set_union (Set_union a b) b))
  )))
(assert (forall ((a Set<Int>) (b Set<Int>)) (!
  (= (Set_union a (Set_union a b)) (Set_union a b))
  :pattern ((Set_union a (Set_union a b)))
  )))
(assert (forall ((a Set<Int>) (b Set<Int>)) (!
  (= (Set_intersection (Set_intersection a b) b) (Set_intersection a b))
  :pattern ((Set_intersection (Set_intersection a b) b))
  )))
(assert (forall ((a Set<Int>) (b Set<Int>)) (!
  (= (Set_intersection a (Set_intersection a b)) (Set_intersection a b))
  :pattern ((Set_intersection a (Set_intersection a b)))
  )))
(assert (forall ((a Set<Int>) (b Set<Int>)) (!
  (=
    (+ (Set_card (Set_union a b)) (Set_card (Set_intersection a b)))
    (+ (Set_card a) (Set_card b)))
  :pattern ((Set_card (Set_union a b)))
  :pattern ((Set_card (Set_intersection a b)))
  )))
(assert (forall ((a Set<Int>) (b Set<Int>) (o Int)) (!
  (= (Set_in o (Set_difference a b)) (and (Set_in o a) (not (Set_in o b))))
  :pattern ((Set_in o (Set_difference a b)))
  :pattern ((Set_difference a b) (Set_in o a))
  )))
(assert (forall ((a Set<Int>) (b Set<Int>) (y Int)) (!
  (=> (Set_in y b) (not (Set_in y (Set_difference a b))))
  :pattern ((Set_difference a b) (Set_in y b))
  )))
(assert (forall ((a Set<Int>) (b Set<Int>)) (!
  (and
    (=
      (+
        (+ (Set_card (Set_difference a b)) (Set_card (Set_difference b a)))
        (Set_card (Set_intersection a b)))
      (Set_card (Set_union a b)))
    (=
      (Set_card (Set_difference a b))
      (- (Set_card a) (Set_card (Set_intersection a b)))))
  :pattern ((Set_card (Set_difference a b)))
  )))
(assert (forall ((a Set<Int>) (b Set<Int>)) (!
  (=
    (Set_subset a b)
    (forall ((o Int)) (!
      (=> (Set_in o a) (Set_in o b))
      :pattern ((Set_in o a))
      :pattern ((Set_in o b))
      )))
  :pattern ((Set_subset a b))
  )))
(assert (forall ((a Set<Int>) (b Set<Int>)) (!
  (or
    (and (Set_equal a b) (= a b))
    (and
      (not (Set_equal a b))
      (and
        (not (= a b))
        (and
          (= (Set_skolem_diff a b) (Set_skolem_diff b a))
          (not
            (= (Set_in (Set_skolem_diff a b) a) (Set_in (Set_skolem_diff a b) b)))))))
  :pattern ((Set_equal a b))
  )))
(assert (forall ((a Set<Int>) (b Set<Int>)) (!
  (=> (Set_equal a b) (= a b))
  :pattern ((Set_equal a b))
  )))
(assert (forall ((s Set<$Ref>)) (!
  (<= 0 (Set_card s))
  :pattern ((Set_card s))
  )))
(assert (forall ((o $Ref)) (!
  (not (Set_in o (as Set_empty  Set<$Ref>)))
  :pattern ((Set_in o (as Set_empty  Set<$Ref>)))
  )))
(assert (forall ((s Set<$Ref>)) (!
  (and
    (=> (= (Set_card s) 0) (= s (as Set_empty  Set<$Ref>)))
    (=> (not (= (Set_card s) 0)) (exists ((x $Ref))  (Set_in x s))))
  :pattern ((Set_card s))
  )))
(assert (forall ((r $Ref)) (!
  (Set_in r (Set_singleton r))
  :pattern ((Set_singleton r))
  )))
(assert (forall ((r $Ref) (o $Ref)) (!
  (= (Set_in o (Set_singleton r)) (= r o))
  :pattern ((Set_in o (Set_singleton r)))
  )))
(assert (forall ((r $Ref)) (!
  (= (Set_card (Set_singleton r)) 1)
  :pattern ((Set_card (Set_singleton r)))
  )))
(assert (forall ((a Set<$Ref>) (x $Ref) (o $Ref)) (!
  (= (Set_in o (Set_unionone a x)) (or (= o x) (Set_in o a)))
  :pattern ((Set_in o (Set_unionone a x)))
  )))
(assert (forall ((a Set<$Ref>) (x $Ref)) (!
  (Set_in x (Set_unionone a x))
  :pattern ((Set_unionone a x))
  )))
(assert (forall ((a Set<$Ref>) (x $Ref) (y $Ref)) (!
  (=> (Set_in y a) (Set_in y (Set_unionone a x)))
  :pattern ((Set_unionone a x) (Set_in y a))
  )))
(assert (forall ((a Set<$Ref>) (x $Ref)) (!
  (=> (Set_in x a) (= (Set_card (Set_unionone a x)) (Set_card a)))
  :pattern ((Set_card (Set_unionone a x)))
  )))
(assert (forall ((a Set<$Ref>) (x $Ref)) (!
  (=> (not (Set_in x a)) (= (Set_card (Set_unionone a x)) (+ (Set_card a) 1)))
  :pattern ((Set_card (Set_unionone a x)))
  )))
(assert (forall ((a Set<$Ref>) (b Set<$Ref>) (o $Ref)) (!
  (= (Set_in o (Set_union a b)) (or (Set_in o a) (Set_in o b)))
  :pattern ((Set_in o (Set_union a b)))
  )))
(assert (forall ((a Set<$Ref>) (b Set<$Ref>) (y $Ref)) (!
  (=> (Set_in y a) (Set_in y (Set_union a b)))
  :pattern ((Set_union a b) (Set_in y a))
  )))
(assert (forall ((a Set<$Ref>) (b Set<$Ref>) (y $Ref)) (!
  (=> (Set_in y b) (Set_in y (Set_union a b)))
  :pattern ((Set_union a b) (Set_in y b))
  )))
(assert (forall ((a Set<$Ref>) (b Set<$Ref>) (o $Ref)) (!
  (= (Set_in o (Set_intersection a b)) (and (Set_in o a) (Set_in o b)))
  :pattern ((Set_in o (Set_intersection a b)))
  :pattern ((Set_intersection a b) (Set_in o a))
  :pattern ((Set_intersection a b) (Set_in o b))
  )))
(assert (forall ((a Set<$Ref>) (b Set<$Ref>)) (!
  (= (Set_union (Set_union a b) b) (Set_union a b))
  :pattern ((Set_union (Set_union a b) b))
  )))
(assert (forall ((a Set<$Ref>) (b Set<$Ref>)) (!
  (= (Set_union a (Set_union a b)) (Set_union a b))
  :pattern ((Set_union a (Set_union a b)))
  )))
(assert (forall ((a Set<$Ref>) (b Set<$Ref>)) (!
  (= (Set_intersection (Set_intersection a b) b) (Set_intersection a b))
  :pattern ((Set_intersection (Set_intersection a b) b))
  )))
(assert (forall ((a Set<$Ref>) (b Set<$Ref>)) (!
  (= (Set_intersection a (Set_intersection a b)) (Set_intersection a b))
  :pattern ((Set_intersection a (Set_intersection a b)))
  )))
(assert (forall ((a Set<$Ref>) (b Set<$Ref>)) (!
  (=
    (+ (Set_card (Set_union a b)) (Set_card (Set_intersection a b)))
    (+ (Set_card a) (Set_card b)))
  :pattern ((Set_card (Set_union a b)))
  :pattern ((Set_card (Set_intersection a b)))
  )))
(assert (forall ((a Set<$Ref>) (b Set<$Ref>) (o $Ref)) (!
  (= (Set_in o (Set_difference a b)) (and (Set_in o a) (not (Set_in o b))))
  :pattern ((Set_in o (Set_difference a b)))
  :pattern ((Set_difference a b) (Set_in o a))
  )))
(assert (forall ((a Set<$Ref>) (b Set<$Ref>) (y $Ref)) (!
  (=> (Set_in y b) (not (Set_in y (Set_difference a b))))
  :pattern ((Set_difference a b) (Set_in y b))
  )))
(assert (forall ((a Set<$Ref>) (b Set<$Ref>)) (!
  (and
    (=
      (+
        (+ (Set_card (Set_difference a b)) (Set_card (Set_difference b a)))
        (Set_card (Set_intersection a b)))
      (Set_card (Set_union a b)))
    (=
      (Set_card (Set_difference a b))
      (- (Set_card a) (Set_card (Set_intersection a b)))))
  :pattern ((Set_card (Set_difference a b)))
  )))
(assert (forall ((a Set<$Ref>) (b Set<$Ref>)) (!
  (=
    (Set_subset a b)
    (forall ((o $Ref)) (!
      (=> (Set_in o a) (Set_in o b))
      :pattern ((Set_in o a))
      :pattern ((Set_in o b))
      )))
  :pattern ((Set_subset a b))
  )))
(assert (forall ((a Set<$Ref>) (b Set<$Ref>)) (!
  (or
    (and (Set_equal a b) (= a b))
    (and
      (not (Set_equal a b))
      (and
        (not (= a b))
        (and
          (= (Set_skolem_diff a b) (Set_skolem_diff b a))
          (not
            (= (Set_in (Set_skolem_diff a b) a) (Set_in (Set_skolem_diff a b) b)))))))
  :pattern ((Set_equal a b))
  )))
(assert (forall ((a Set<$Ref>) (b Set<$Ref>)) (!
  (=> (Set_equal a b) (= a b))
  :pattern ((Set_equal a b))
  )))
(assert (forall ((s Set<Bool>)) (!
  (<= 0 (Set_card s))
  :pattern ((Set_card s))
  )))
(assert (forall ((o Bool)) (!
  (not (Set_in o (as Set_empty  Set<Bool>)))
  :pattern ((Set_in o (as Set_empty  Set<Bool>)))
  )))
(assert (forall ((s Set<Bool>)) (!
  (and
    (=> (= (Set_card s) 0) (= s (as Set_empty  Set<Bool>)))
    (=> (not (= (Set_card s) 0)) (exists ((x Bool))  (Set_in x s))))
  :pattern ((Set_card s))
  )))
(assert (forall ((r Bool)) (!
  (Set_in r (Set_singleton r))
  :pattern ((Set_singleton r))
  )))
(assert (forall ((r Bool) (o Bool)) (!
  (= (Set_in o (Set_singleton r)) (= r o))
  :pattern ((Set_in o (Set_singleton r)))
  )))
(assert (forall ((r Bool)) (!
  (= (Set_card (Set_singleton r)) 1)
  :pattern ((Set_card (Set_singleton r)))
  )))
(assert (forall ((a Set<Bool>) (x Bool) (o Bool)) (!
  (= (Set_in o (Set_unionone a x)) (or (= o x) (Set_in o a)))
  :pattern ((Set_in o (Set_unionone a x)))
  )))
(assert (forall ((a Set<Bool>) (x Bool)) (!
  (Set_in x (Set_unionone a x))
  :pattern ((Set_unionone a x))
  )))
(assert (forall ((a Set<Bool>) (x Bool) (y Bool)) (!
  (=> (Set_in y a) (Set_in y (Set_unionone a x)))
  :pattern ((Set_unionone a x) (Set_in y a))
  )))
(assert (forall ((a Set<Bool>) (x Bool)) (!
  (=> (Set_in x a) (= (Set_card (Set_unionone a x)) (Set_card a)))
  :pattern ((Set_card (Set_unionone a x)))
  )))
(assert (forall ((a Set<Bool>) (x Bool)) (!
  (=> (not (Set_in x a)) (= (Set_card (Set_unionone a x)) (+ (Set_card a) 1)))
  :pattern ((Set_card (Set_unionone a x)))
  )))
(assert (forall ((a Set<Bool>) (b Set<Bool>) (o Bool)) (!
  (= (Set_in o (Set_union a b)) (or (Set_in o a) (Set_in o b)))
  :pattern ((Set_in o (Set_union a b)))
  )))
(assert (forall ((a Set<Bool>) (b Set<Bool>) (y Bool)) (!
  (=> (Set_in y a) (Set_in y (Set_union a b)))
  :pattern ((Set_union a b) (Set_in y a))
  )))
(assert (forall ((a Set<Bool>) (b Set<Bool>) (y Bool)) (!
  (=> (Set_in y b) (Set_in y (Set_union a b)))
  :pattern ((Set_union a b) (Set_in y b))
  )))
(assert (forall ((a Set<Bool>) (b Set<Bool>) (o Bool)) (!
  (= (Set_in o (Set_intersection a b)) (and (Set_in o a) (Set_in o b)))
  :pattern ((Set_in o (Set_intersection a b)))
  :pattern ((Set_intersection a b) (Set_in o a))
  :pattern ((Set_intersection a b) (Set_in o b))
  )))
(assert (forall ((a Set<Bool>) (b Set<Bool>)) (!
  (= (Set_union (Set_union a b) b) (Set_union a b))
  :pattern ((Set_union (Set_union a b) b))
  )))
(assert (forall ((a Set<Bool>) (b Set<Bool>)) (!
  (= (Set_union a (Set_union a b)) (Set_union a b))
  :pattern ((Set_union a (Set_union a b)))
  )))
(assert (forall ((a Set<Bool>) (b Set<Bool>)) (!
  (= (Set_intersection (Set_intersection a b) b) (Set_intersection a b))
  :pattern ((Set_intersection (Set_intersection a b) b))
  )))
(assert (forall ((a Set<Bool>) (b Set<Bool>)) (!
  (= (Set_intersection a (Set_intersection a b)) (Set_intersection a b))
  :pattern ((Set_intersection a (Set_intersection a b)))
  )))
(assert (forall ((a Set<Bool>) (b Set<Bool>)) (!
  (=
    (+ (Set_card (Set_union a b)) (Set_card (Set_intersection a b)))
    (+ (Set_card a) (Set_card b)))
  :pattern ((Set_card (Set_union a b)))
  :pattern ((Set_card (Set_intersection a b)))
  )))
(assert (forall ((a Set<Bool>) (b Set<Bool>) (o Bool)) (!
  (= (Set_in o (Set_difference a b)) (and (Set_in o a) (not (Set_in o b))))
  :pattern ((Set_in o (Set_difference a b)))
  :pattern ((Set_difference a b) (Set_in o a))
  )))
(assert (forall ((a Set<Bool>) (b Set<Bool>) (y Bool)) (!
  (=> (Set_in y b) (not (Set_in y (Set_difference a b))))
  :pattern ((Set_difference a b) (Set_in y b))
  )))
(assert (forall ((a Set<Bool>) (b Set<Bool>)) (!
  (and
    (=
      (+
        (+ (Set_card (Set_difference a b)) (Set_card (Set_difference b a)))
        (Set_card (Set_intersection a b)))
      (Set_card (Set_union a b)))
    (=
      (Set_card (Set_difference a b))
      (- (Set_card a) (Set_card (Set_intersection a b)))))
  :pattern ((Set_card (Set_difference a b)))
  )))
(assert (forall ((a Set<Bool>) (b Set<Bool>)) (!
  (=
    (Set_subset a b)
    (forall ((o Bool)) (!
      (=> (Set_in o a) (Set_in o b))
      :pattern ((Set_in o a))
      :pattern ((Set_in o b))
      )))
  :pattern ((Set_subset a b))
  )))
(assert (forall ((a Set<Bool>) (b Set<Bool>)) (!
  (or
    (and (Set_equal a b) (= a b))
    (and
      (not (Set_equal a b))
      (and
        (not (= a b))
        (and
          (= (Set_skolem_diff a b) (Set_skolem_diff b a))
          (not
            (= (Set_in (Set_skolem_diff a b) a) (Set_in (Set_skolem_diff a b) b)))))))
  :pattern ((Set_equal a b))
  )))
(assert (forall ((a Set<Bool>) (b Set<Bool>)) (!
  (=> (Set_equal a b) (= a b))
  :pattern ((Set_equal a b))
  )))
(assert (forall ((s Set<$Snap>)) (!
  (<= 0 (Set_card s))
  :pattern ((Set_card s))
  )))
(assert (forall ((o $Snap)) (!
  (not (Set_in o (as Set_empty  Set<$Snap>)))
  :pattern ((Set_in o (as Set_empty  Set<$Snap>)))
  )))
(assert (forall ((s Set<$Snap>)) (!
  (and
    (=> (= (Set_card s) 0) (= s (as Set_empty  Set<$Snap>)))
    (=> (not (= (Set_card s) 0)) (exists ((x $Snap))  (Set_in x s))))
  :pattern ((Set_card s))
  )))
(assert (forall ((r $Snap)) (!
  (Set_in r (Set_singleton r))
  :pattern ((Set_singleton r))
  )))
(assert (forall ((r $Snap) (o $Snap)) (!
  (= (Set_in o (Set_singleton r)) (= r o))
  :pattern ((Set_in o (Set_singleton r)))
  )))
(assert (forall ((r $Snap)) (!
  (= (Set_card (Set_singleton r)) 1)
  :pattern ((Set_card (Set_singleton r)))
  )))
(assert (forall ((a Set<$Snap>) (x $Snap) (o $Snap)) (!
  (= (Set_in o (Set_unionone a x)) (or (= o x) (Set_in o a)))
  :pattern ((Set_in o (Set_unionone a x)))
  )))
(assert (forall ((a Set<$Snap>) (x $Snap)) (!
  (Set_in x (Set_unionone a x))
  :pattern ((Set_unionone a x))
  )))
(assert (forall ((a Set<$Snap>) (x $Snap) (y $Snap)) (!
  (=> (Set_in y a) (Set_in y (Set_unionone a x)))
  :pattern ((Set_unionone a x) (Set_in y a))
  )))
(assert (forall ((a Set<$Snap>) (x $Snap)) (!
  (=> (Set_in x a) (= (Set_card (Set_unionone a x)) (Set_card a)))
  :pattern ((Set_card (Set_unionone a x)))
  )))
(assert (forall ((a Set<$Snap>) (x $Snap)) (!
  (=> (not (Set_in x a)) (= (Set_card (Set_unionone a x)) (+ (Set_card a) 1)))
  :pattern ((Set_card (Set_unionone a x)))
  )))
(assert (forall ((a Set<$Snap>) (b Set<$Snap>) (o $Snap)) (!
  (= (Set_in o (Set_union a b)) (or (Set_in o a) (Set_in o b)))
  :pattern ((Set_in o (Set_union a b)))
  )))
(assert (forall ((a Set<$Snap>) (b Set<$Snap>) (y $Snap)) (!
  (=> (Set_in y a) (Set_in y (Set_union a b)))
  :pattern ((Set_union a b) (Set_in y a))
  )))
(assert (forall ((a Set<$Snap>) (b Set<$Snap>) (y $Snap)) (!
  (=> (Set_in y b) (Set_in y (Set_union a b)))
  :pattern ((Set_union a b) (Set_in y b))
  )))
(assert (forall ((a Set<$Snap>) (b Set<$Snap>) (o $Snap)) (!
  (= (Set_in o (Set_intersection a b)) (and (Set_in o a) (Set_in o b)))
  :pattern ((Set_in o (Set_intersection a b)))
  :pattern ((Set_intersection a b) (Set_in o a))
  :pattern ((Set_intersection a b) (Set_in o b))
  )))
(assert (forall ((a Set<$Snap>) (b Set<$Snap>)) (!
  (= (Set_union (Set_union a b) b) (Set_union a b))
  :pattern ((Set_union (Set_union a b) b))
  )))
(assert (forall ((a Set<$Snap>) (b Set<$Snap>)) (!
  (= (Set_union a (Set_union a b)) (Set_union a b))
  :pattern ((Set_union a (Set_union a b)))
  )))
(assert (forall ((a Set<$Snap>) (b Set<$Snap>)) (!
  (= (Set_intersection (Set_intersection a b) b) (Set_intersection a b))
  :pattern ((Set_intersection (Set_intersection a b) b))
  )))
(assert (forall ((a Set<$Snap>) (b Set<$Snap>)) (!
  (= (Set_intersection a (Set_intersection a b)) (Set_intersection a b))
  :pattern ((Set_intersection a (Set_intersection a b)))
  )))
(assert (forall ((a Set<$Snap>) (b Set<$Snap>)) (!
  (=
    (+ (Set_card (Set_union a b)) (Set_card (Set_intersection a b)))
    (+ (Set_card a) (Set_card b)))
  :pattern ((Set_card (Set_union a b)))
  :pattern ((Set_card (Set_intersection a b)))
  )))
(assert (forall ((a Set<$Snap>) (b Set<$Snap>) (o $Snap)) (!
  (= (Set_in o (Set_difference a b)) (and (Set_in o a) (not (Set_in o b))))
  :pattern ((Set_in o (Set_difference a b)))
  :pattern ((Set_difference a b) (Set_in o a))
  )))
(assert (forall ((a Set<$Snap>) (b Set<$Snap>) (y $Snap)) (!
  (=> (Set_in y b) (not (Set_in y (Set_difference a b))))
  :pattern ((Set_difference a b) (Set_in y b))
  )))
(assert (forall ((a Set<$Snap>) (b Set<$Snap>)) (!
  (and
    (=
      (+
        (+ (Set_card (Set_difference a b)) (Set_card (Set_difference b a)))
        (Set_card (Set_intersection a b)))
      (Set_card (Set_union a b)))
    (=
      (Set_card (Set_difference a b))
      (- (Set_card a) (Set_card (Set_intersection a b)))))
  :pattern ((Set_card (Set_difference a b)))
  )))
(assert (forall ((a Set<$Snap>) (b Set<$Snap>)) (!
  (=
    (Set_subset a b)
    (forall ((o $Snap)) (!
      (=> (Set_in o a) (Set_in o b))
      :pattern ((Set_in o a))
      :pattern ((Set_in o b))
      )))
  :pattern ((Set_subset a b))
  )))
(assert (forall ((a Set<$Snap>) (b Set<$Snap>)) (!
  (or
    (and (Set_equal a b) (= a b))
    (and
      (not (Set_equal a b))
      (and
        (not (= a b))
        (and
          (= (Set_skolem_diff a b) (Set_skolem_diff b a))
          (not
            (= (Set_in (Set_skolem_diff a b) a) (Set_in (Set_skolem_diff a b) b)))))))
  :pattern ((Set_equal a b))
  )))
(assert (forall ((a Set<$Snap>) (b Set<$Snap>)) (!
  (=> (Set_equal a b) (= a b))
  :pattern ((Set_equal a b))
  )))
; /field_value_functions_axioms.smt2 [head: Ref]
(assert (forall ((vs $FVF<head>) (ws $FVF<head>)) (!
    (=>
      (and
        (Set_equal ($FVF.domain_head vs) ($FVF.domain_head ws))
        (forall ((x $Ref)) (!
          (=>
            (Set_in x ($FVF.domain_head vs))
            (= ($FVF.lookup_head vs x) ($FVF.lookup_head ws x)))
          :pattern (($FVF.lookup_head vs x) ($FVF.lookup_head ws x))
          :qid |qp.$FVF<head>-eq-inner|
          )))
      (= vs ws))
    :pattern (($SortWrappers.$FVF<head>To$Snap vs)
              ($SortWrappers.$FVF<head>To$Snap ws)
              )
    :qid |qp.$FVF<head>-eq-outer|
    )))
(assert (forall ((r $Ref) (pm $FPM)) (!
    ($Perm.isValidVar ($FVF.perm_head pm r))
    :pattern (($FVF.perm_head pm r)))))
(assert (forall ((r $Ref) (f $Ref)) (!
    (= ($FVF.loc_head f r) true)
    :pattern (($FVF.loc_head f r)))))
; /field_value_functions_axioms.smt2 [next: Ref]
(assert (forall ((vs $FVF<next>) (ws $FVF<next>)) (!
    (=>
      (and
        (Set_equal ($FVF.domain_next vs) ($FVF.domain_next ws))
        (forall ((x $Ref)) (!
          (=>
            (Set_in x ($FVF.domain_next vs))
            (= ($FVF.lookup_next vs x) ($FVF.lookup_next ws x)))
          :pattern (($FVF.lookup_next vs x) ($FVF.lookup_next ws x))
          :qid |qp.$FVF<next>-eq-inner|
          )))
      (= vs ws))
    :pattern (($SortWrappers.$FVF<next>To$Snap vs)
              ($SortWrappers.$FVF<next>To$Snap ws)
              )
    :qid |qp.$FVF<next>-eq-outer|
    )))
(assert (forall ((r $Ref) (pm $FPM)) (!
    ($Perm.isValidVar ($FVF.perm_next pm r))
    :pattern (($FVF.perm_next pm r)))))
(assert (forall ((r $Ref) (f $Ref)) (!
    (= ($FVF.loc_next f r) true)
    :pattern (($FVF.loc_next f r)))))
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
          (< 0 (Seq_length result@2@00))
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
; ---------- insert ----------
(declare-const this@0@10 $Ref)
(declare-const elem@1@10 Int)
(declare-const index@2@10 Int)
(declare-const this@3@10 $Ref)
(declare-const elem@4@10 Int)
(declare-const index@5@10 Int)
(set-option :timeout 0)
(push) ; 1
(declare-const $t@6@10 $Snap)
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
(set-option :timeout 0)
(push) ; 2
(declare-const $t@7@10 $Snap)
(assert (= $t@7@10 ($Snap.combine ($Snap.first $t@7@10) ($Snap.second $t@7@10))))
(assert (=
  ($Snap.second $t@7@10)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@7@10))
    ($Snap.second ($Snap.second $t@7@10)))))
(assert (= ($Snap.first ($Snap.second $t@7@10)) $Snap.unit))
; [eval] 0 <= index
(assert (<= 0 index@5@10))
(assert (=
  ($Snap.second ($Snap.second $t@7@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@7@10)))
    ($Snap.second ($Snap.second ($Snap.second $t@7@10))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@7@10))) $Snap.unit))
; [eval] index <= |old(content(this))|
; [eval] |old(content(this))|
; [eval] old(content(this))
; [eval] content(this)
(push) ; 3
(assert (content%precondition $t@6@10 this@3@10))
(pop) ; 3
; Joined path conditions
(assert (content%precondition $t@6@10 this@3@10))
(assert (<= index@5@10 (Seq_length (content $t@6@10 this@3@10))))
(assert (= ($Snap.second ($Snap.second ($Snap.second $t@7@10))) $Snap.unit))
; [eval] content(this) == old(content(this))[0..index] ++ Seq(elem) ++ old(content(this))[index..]
; [eval] content(this)
(push) ; 3
(assert (content%precondition ($Snap.first $t@7@10) this@3@10))
(pop) ; 3
; Joined path conditions
(assert (content%precondition ($Snap.first $t@7@10) this@3@10))
; [eval] old(content(this))[0..index] ++ Seq(elem) ++ old(content(this))[index..]
; [eval] old(content(this))[0..index] ++ Seq(elem)
; [eval] old(content(this))[0..index]
; [eval] old(content(this))[..index]
; [eval] old(content(this))
; [eval] content(this)
(push) ; 3
(pop) ; 3
; Joined path conditions
; [eval] Seq(elem)
(assert (= (Seq_length (Seq_singleton elem@4@10)) 1))
; [eval] old(content(this))[index..]
; [eval] old(content(this))
; [eval] content(this)
(push) ; 3
(pop) ; 3
; Joined path conditions
(assert (Seq_equal
  (content ($Snap.first $t@7@10) this@3@10)
  (Seq_append
    (Seq_append
      (Seq_drop (Seq_take (content $t@6@10 this@3@10) index@5@10) 0)
      (Seq_singleton elem@4@10))
    (Seq_drop (content $t@6@10 this@3@10) index@5@10))))
(pop) ; 2
(push) ; 2
; [exec]
; var tmp: Ref
(declare-const tmp@8@10 $Ref)
; [exec]
; index := 0
; [exec]
; unfold acc(List(this), write)
(assert (= $t@6@10 ($Snap.combine ($Snap.first $t@6@10) ($Snap.second $t@6@10))))
(assert (not (= this@3@10 $Ref.null)))
; State saturation: after unfold
(set-option :timeout 40)
(check-sat)
; unknown
(assert (List%trigger $t@6@10 this@3@10))
; [eval] this.head != null
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 10)
(assert (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null)))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 10)
(assert (not (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; [then-branch: 0 | First:($t@6@10) != Null | live]
; [else-branch: 0 | First:($t@6@10) == Null | live]
(set-option :timeout 0)
(push) ; 3
; [then-branch: 0 | First:($t@6@10) != Null]
(assert (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null)))
; [exec]
; unfold acc(lseg(this.head, null), write)
; [eval] this != end
(push) ; 4
(set-option :timeout 10)
(assert (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null)))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; [then-branch: 1 | First:($t@6@10) != Null | live]
; [else-branch: 1 | First:($t@6@10) == Null | dead]
(set-option :timeout 0)
(push) ; 4
; [then-branch: 1 | First:($t@6@10) != Null]
(assert (=
  ($Snap.second $t@6@10)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@6@10))
    ($Snap.second ($Snap.second $t@6@10)))))
(assert (=
  ($Snap.second ($Snap.second $t@6@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@6@10)))
    ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@6@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
  $Snap.unit))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(push) ; 5
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))
; [eval] this != end
(push) ; 6
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 10)
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
    $Ref.null))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [then-branch: 2 | First:(Second:(Second:($t@6@10))) != Null | live]
; [else-branch: 2 | First:(Second:(Second:($t@6@10))) == Null | live]
(set-option :timeout 0)
(push) ; 6
; [then-branch: 2 | First:(Second:(Second:($t@6@10))) != Null]
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
    $Ref.null)))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
  ($Snap.combine
    ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))
    ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
(push) ; 7
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
    ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
  $Snap.unit))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(set-option :timeout 0)
(push) ; 7
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))) $Ref.null))
; [eval] this != end
(push) ; 8
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 8
(set-option :timeout 10)
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    $Ref.null))))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [then-branch: 3 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) != Null | live]
; [else-branch: 3 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) == Null | live]
(set-option :timeout 0)
(push) ; 8
; [then-branch: 3 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) != Null]
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    $Ref.null)))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
  ($Snap.combine
    ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
    ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))))
(push) ; 9
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 9
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
    ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))))
(set-option :timeout 0)
(push) ; 9
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 9
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
  $Snap.unit))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(declare-const recunf@9@10 Bool)
(assert (as recunf@9@10  Bool))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(set-option :timeout 0)
(push) ; 9
(push) ; 10
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [then-branch: 4 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) != Null | live]
; [else-branch: 4 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) == Null | dead]
(set-option :timeout 0)
(push) ; 10
; [then-branch: 4 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) != Null]
; [eval] this.data <= this.next.data
(pop) ; 10
(pop) ; 9
; Joined path conditions
(pop) ; 8
(push) ; 8
; [else-branch: 3 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) == Null]
(assert (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
  $Ref.null))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
  $Snap.unit))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(push) ; 9
; [then-branch: 5 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) != Null | dead]
; [else-branch: 5 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) == Null | live]
(push) ; 10
; [else-branch: 5 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) == Null]
(pop) ; 10
(pop) ; 9
; Joined path conditions
(pop) ; 8
(pop) ; 7
(declare-const joined_unfolding@10@10 Bool)
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
      $Ref.null))
  (=
    (as joined_unfolding@10@10  Bool)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
          $Ref.null))
      (<=
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))))))
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    $Ref.null)
  (= (as joined_unfolding@10@10  Bool) true)))
; Joined path conditions
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))) $Ref.null))
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
      $Ref.null))
  (and
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
        $Ref.null))
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
      ($Snap.combine
        ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
        ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
    (=
      ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
        ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
        ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
      $Snap.unit)
    (as recunf@9@10  Bool))))
; Joined path conditions
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    $Ref.null)
  (and
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
      $Ref.null)
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
      $Snap.unit))))
(assert (or
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    $Ref.null)
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
      $Ref.null))))
(assert (as joined_unfolding@10@10  Bool))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(push) ; 7
(push) ; 8
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [then-branch: 6 | First:(Second:(Second:($t@6@10))) != Null | live]
; [else-branch: 6 | First:(Second:(Second:($t@6@10))) == Null | dead]
(set-option :timeout 0)
(push) ; 8
; [then-branch: 6 | First:(Second:(Second:($t@6@10))) != Null]
; [eval] this.data <= this.next.data
(pop) ; 8
(pop) ; 7
; Joined path conditions
(pop) ; 6
(push) ; 6
; [else-branch: 2 | First:(Second:(Second:($t@6@10))) == Null]
(assert (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
  $Ref.null))
(assert (= ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) $Snap.unit))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(push) ; 7
; [then-branch: 7 | First:(Second:(Second:($t@6@10))) != Null | dead]
; [else-branch: 7 | First:(Second:(Second:($t@6@10))) == Null | live]
(push) ; 8
; [else-branch: 7 | First:(Second:(Second:($t@6@10))) == Null]
(pop) ; 8
(pop) ; 7
; Joined path conditions
(pop) ; 6
(pop) ; 5
(declare-const joined_unfolding@11@10 Bool)
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
      $Ref.null))
  (=
    (as joined_unfolding@11@10  Bool)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
          $Ref.null))
      (<=
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))))
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
    $Ref.null)
  (= (as joined_unfolding@11@10  Bool) true)))
; Joined path conditions
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
      $Ref.null))
  (and
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
        $Ref.null))
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
      ($Snap.combine
        ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))
        ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    (=
      ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
        ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
        ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
      $Snap.unit)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
          $Ref.null))
      (=
        (as joined_unfolding@10@10  Bool)
        (=>
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
              $Ref.null))
          (<=
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))))))
    (=>
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
        $Ref.null)
      (= (as joined_unfolding@10@10  Bool) true))
    (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))) $Ref.null)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
          $Ref.null))
      (and
        (not
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
            $Ref.null))
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
          ($Snap.combine
            ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
            ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
        (=
          ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
            ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
            ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
          $Snap.unit)
        (as recunf@9@10  Bool)))
    (=>
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
        $Ref.null)
      (and
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
          $Ref.null)
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
          $Snap.unit)))
    (or
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
        $Ref.null)
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
          $Ref.null)))
    (as joined_unfolding@10@10  Bool))))
; Joined path conditions
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
    $Ref.null)
  (and
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
      $Ref.null)
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
      $Snap.unit))))
(assert (or
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
    $Ref.null)
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
      $Ref.null))))
(assert (as joined_unfolding@11@10  Bool))
; State saturation: after unfold
(set-option :timeout 40)
(check-sat)
; unknown
(assert (lseg%trigger ($Snap.second $t@6@10) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null))
; [eval] this.head == null || elem <= this.head.data
; [eval] this.head == null
(set-option :timeout 0)
(push) ; 5
; [then-branch: 8 | First:($t@6@10) == Null | live]
; [else-branch: 8 | First:($t@6@10) != Null | live]
(push) ; 6
; [then-branch: 8 | First:($t@6@10) == Null]
(assert (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null))
(pop) ; 6
(push) ; 6
; [else-branch: 8 | First:($t@6@10) != Null]
; [eval] elem <= this.head.data
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or
  (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null))
  (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null)))
(push) ; 5
(set-option :timeout 10)
(assert (not (not
  (or
    (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null)
    (<=
      elem@4@10
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10))))))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 10)
(assert (not (or
  (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null)
  (<= elem@4@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [then-branch: 9 | First:($t@6@10) == Null || elem@4@10 <= First:(Second:($t@6@10)) | live]
; [else-branch: 9 | !(First:($t@6@10) == Null || elem@4@10 <= First:(Second:($t@6@10))) | live]
(set-option :timeout 0)
(push) ; 5
; [then-branch: 9 | First:($t@6@10) == Null || elem@4@10 <= First:(Second:($t@6@10))]
(assert (or
  (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null)
  (<= elem@4@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10))))))
; [exec]
; tmp := new(data, next, head, held, changed)
(declare-const tmp@12@10 $Ref)
(assert (not (= tmp@12@10 $Ref.null)))
(declare-const data@13@10 Int)
(declare-const next@14@10 $Ref)
(declare-const head@15@10 $Ref)
(declare-const held@16@10 Int)
(declare-const changed@17@10 Bool)
(assert (not (= tmp@12@10 this@3@10)))
(assert (not (= tmp@12@10 tmp@8@10)))
(assert (not
  (=
    tmp@12@10
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))))))
(assert (not (= tmp@12@10 ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)))))
; [exec]
; tmp.data := elem
(push) ; 6
(set-option :timeout 10)
(assert (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) tmp@12@10)))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [exec]
; tmp.next := this.head
(declare-const next@18@10 $Ref)
(assert (= next@18@10 ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10))))
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 10)
(assert (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) tmp@12@10)))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [exec]
; fold acc(lseg(this.head, null), write)
; [eval] this != end
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 10)
(assert (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null)))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [then-branch: 10 | First:($t@6@10) != Null | live]
; [else-branch: 10 | First:($t@6@10) == Null | dead]
(set-option :timeout 0)
(push) ; 6
; [then-branch: 10 | First:($t@6@10) != Null]
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(push) ; 7
; [eval] this != end
(push) ; 8
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 8
(set-option :timeout 10)
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
    $Ref.null))))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [then-branch: 11 | First:(Second:(Second:($t@6@10))) != Null | live]
; [else-branch: 11 | First:(Second:(Second:($t@6@10))) == Null | live]
(set-option :timeout 0)
(push) ; 8
; [then-branch: 11 | First:(Second:(Second:($t@6@10))) != Null]
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
    $Ref.null)))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
  ($Snap.combine
    ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))
    ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
(push) ; 9
(set-option :timeout 10)
(assert (not (=
  tmp@12@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))))))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 9
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))))))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
    ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
(set-option :timeout 0)
(push) ; 9
(set-option :timeout 10)
(assert (not (=
  tmp@12@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))))))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 9
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))))))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
  $Snap.unit))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(set-option :timeout 0)
(push) ; 9
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))) $Ref.null))
; [eval] this != end
(push) ; 10
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 10
(set-option :timeout 10)
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    $Ref.null))))
(check-sat)
; unknown
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [then-branch: 12 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) != Null | live]
; [else-branch: 12 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) == Null | live]
(set-option :timeout 0)
(push) ; 10
; [then-branch: 12 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) != Null]
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    $Ref.null)))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
  ($Snap.combine
    ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
    ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))))
(push) ; 11
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
(check-sat)
; unknown
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 11
(set-option :timeout 10)
(assert (not (=
  tmp@12@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
(check-sat)
; unknown
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 11
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
(check-sat)
; unknown
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
    ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))))
(set-option :timeout 0)
(push) ; 11
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
(check-sat)
; unknown
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 11
(set-option :timeout 10)
(assert (not (=
  tmp@12@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
(check-sat)
; unknown
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 11
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
(check-sat)
; unknown
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
  $Snap.unit))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(declare-const recunf@19@10 Bool)
(assert (as recunf@19@10  Bool))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(set-option :timeout 0)
(push) ; 11
(push) ; 12
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 12
; 0.00s
; (get-info :all-statistics)
; [then-branch: 13 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) != Null | live]
; [else-branch: 13 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) == Null | dead]
(set-option :timeout 0)
(push) ; 12
; [then-branch: 13 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) != Null]
; [eval] this.data <= this.next.data
(pop) ; 12
(pop) ; 11
; Joined path conditions
(pop) ; 10
(push) ; 10
; [else-branch: 12 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) == Null]
(assert (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
  $Ref.null))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
  $Snap.unit))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(push) ; 11
; [then-branch: 14 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) != Null | dead]
; [else-branch: 14 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) == Null | live]
(push) ; 12
; [else-branch: 14 | First:(Second:(First:(Second:(Second:(Second:($t@6@10)))))) == Null]
(pop) ; 12
(pop) ; 11
; Joined path conditions
(pop) ; 10
(pop) ; 9
(declare-const joined_unfolding@20@10 Bool)
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
      $Ref.null))
  (=
    (as joined_unfolding@20@10  Bool)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
          $Ref.null))
      (<=
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))))))
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    $Ref.null)
  (= (as joined_unfolding@20@10  Bool) true)))
; Joined path conditions
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))) $Ref.null))
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
      $Ref.null))
  (and
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
        $Ref.null))
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
      ($Snap.combine
        ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
        ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
    (=
      ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
        ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
        ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
      $Snap.unit)
    (as recunf@19@10  Bool))))
; Joined path conditions
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    $Ref.null)
  (and
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
      $Ref.null)
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
      $Snap.unit))))
(assert (or
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    $Ref.null)
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
      $Ref.null))))
(assert (as joined_unfolding@20@10  Bool))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(push) ; 9
(push) ; 10
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [then-branch: 15 | First:(Second:(Second:($t@6@10))) != Null | live]
; [else-branch: 15 | First:(Second:(Second:($t@6@10))) == Null | dead]
(set-option :timeout 0)
(push) ; 10
; [then-branch: 15 | First:(Second:(Second:($t@6@10))) != Null]
; [eval] this.data <= this.next.data
(pop) ; 10
(pop) ; 9
; Joined path conditions
(pop) ; 8
(push) ; 8
; [else-branch: 11 | First:(Second:(Second:($t@6@10))) == Null]
(assert (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
  $Ref.null))
(assert (= ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) $Snap.unit))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(push) ; 9
; [then-branch: 16 | First:(Second:(Second:($t@6@10))) != Null | dead]
; [else-branch: 16 | First:(Second:(Second:($t@6@10))) == Null | live]
(push) ; 10
; [else-branch: 16 | First:(Second:(Second:($t@6@10))) == Null]
(pop) ; 10
(pop) ; 9
; Joined path conditions
(pop) ; 8
(pop) ; 7
(declare-const joined_unfolding@21@10 Bool)
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
      $Ref.null))
  (=
    (as joined_unfolding@21@10  Bool)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
          $Ref.null))
      (<=
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))))
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
    $Ref.null)
  (= (as joined_unfolding@21@10  Bool) true)))
; Joined path conditions
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
      $Ref.null))
  (and
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
        $Ref.null))
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
      ($Snap.combine
        ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))
        ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    (=
      ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
        ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
        ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
      $Snap.unit)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
          $Ref.null))
      (=
        (as joined_unfolding@20@10  Bool)
        (=>
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
              $Ref.null))
          (<=
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))))))
    (=>
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
        $Ref.null)
      (= (as joined_unfolding@20@10  Bool) true))
    (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))) $Ref.null)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
          $Ref.null))
      (and
        (not
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
            $Ref.null))
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
          ($Snap.combine
            ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
            ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
        (=
          ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
            ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
            ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
          $Snap.unit)
        (as recunf@19@10  Bool)))
    (=>
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
        $Ref.null)
      (and
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
          $Ref.null)
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
          $Snap.unit)))
    (or
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
        $Ref.null)
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
          $Ref.null)))
    (as joined_unfolding@20@10  Bool))))
; Joined path conditions
(push) ; 7
(assert (not (as joined_unfolding@21@10  Bool)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (as joined_unfolding@21@10  Bool))
(assert (lseg%trigger ($Snap.combine
  ($Snap.first ($Snap.second $t@6@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@6@10)))
    ($Snap.combine
      ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
      $Snap.unit))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null))
; [exec]
; fold acc(lseg(tmp, null), write)
; [eval] this != end
(push) ; 7
(set-option :timeout 10)
(assert (not (= tmp@12@10 $Ref.null)))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [then-branch: 17 | tmp@12@10 != Null | live]
; [else-branch: 17 | tmp@12@10 == Null | dead]
(set-option :timeout 0)
(push) ; 7
; [then-branch: 17 | tmp@12@10 != Null]
(push) ; 8
(set-option :timeout 10)
(assert (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) next@18@10)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(set-option :timeout 0)
(push) ; 8
(push) ; 9
(set-option :timeout 10)
(assert (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) next@18@10)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(assert (lseg%trigger ($Snap.combine
  ($Snap.first ($Snap.second $t@6@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@6@10)))
    ($Snap.combine
      ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
      $Snap.unit))) next@18@10 $Ref.null))
; [eval] this != end
(set-option :timeout 0)
(push) ; 9
(set-option :timeout 10)
(assert (not (= next@18@10 $Ref.null)))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 9
(set-option :timeout 10)
(assert (not (not (= next@18@10 $Ref.null))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [then-branch: 18 | next@18@10 != Null | live]
; [else-branch: 18 | next@18@10 == Null | dead]
(set-option :timeout 0)
(push) ; 9
; [then-branch: 18 | next@18@10 != Null]
(assert (not (= next@18@10 $Ref.null)))
(push) ; 10
(set-option :timeout 10)
(assert (not (= tmp@12@10 next@18@10)))
(check-sat)
; unknown
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 10
(set-option :timeout 10)
(assert (not (= tmp@12@10 next@18@10)))
(check-sat)
; unknown
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(set-option :timeout 0)
(push) ; 10
; [eval] this != end
(push) ; 11
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 11
(set-option :timeout 10)
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
    $Ref.null))))
(check-sat)
; unknown
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
; [then-branch: 19 | First:(Second:(Second:($t@6@10))) != Null | live]
; [else-branch: 19 | First:(Second:(Second:($t@6@10))) == Null | live]
(set-option :timeout 0)
(push) ; 11
; [then-branch: 19 | First:(Second:(Second:($t@6@10))) != Null]
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
    $Ref.null)))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
  ($Snap.combine
    ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))
    ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
(push) ; 12
(set-option :timeout 10)
(assert (not (=
  next@18@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))))))
(check-sat)
; unknown
(pop) ; 12
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 12
(set-option :timeout 10)
(assert (not (=
  tmp@12@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))))))
(check-sat)
; unknown
(pop) ; 12
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
    ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
(set-option :timeout 0)
(push) ; 12
(set-option :timeout 10)
(assert (not (=
  next@18@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))))))
(check-sat)
; unknown
(pop) ; 12
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 12
(set-option :timeout 10)
(assert (not (=
  tmp@12@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))))))
(check-sat)
; unknown
(pop) ; 12
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
  $Snap.unit))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(declare-const recunf@22@10 Bool)
(assert (as recunf@22@10  Bool))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(set-option :timeout 0)
(push) ; 12
(push) ; 13
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 13
; 0.00s
; (get-info :all-statistics)
; [then-branch: 20 | First:(Second:(Second:($t@6@10))) != Null | live]
; [else-branch: 20 | First:(Second:(Second:($t@6@10))) == Null | dead]
(set-option :timeout 0)
(push) ; 13
; [then-branch: 20 | First:(Second:(Second:($t@6@10))) != Null]
; [eval] this.data <= this.next.data
(pop) ; 13
(pop) ; 12
; Joined path conditions
(pop) ; 11
(push) ; 11
; [else-branch: 19 | First:(Second:(Second:($t@6@10))) == Null]
(assert (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
  $Ref.null))
(assert (= ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) $Snap.unit))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(push) ; 12
; [then-branch: 21 | First:(Second:(Second:($t@6@10))) != Null | dead]
; [else-branch: 21 | First:(Second:(Second:($t@6@10))) == Null | live]
(push) ; 13
; [else-branch: 21 | First:(Second:(Second:($t@6@10))) == Null]
(pop) ; 13
(pop) ; 12
; Joined path conditions
(pop) ; 11
(pop) ; 10
(declare-const joined_unfolding@23@10 Bool)
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
      $Ref.null))
  (=
    (as joined_unfolding@23@10  Bool)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
          $Ref.null))
      (<=
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))))
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
    $Ref.null)
  (= (as joined_unfolding@23@10  Bool) true)))
; Joined path conditions
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
      $Ref.null))
  (and
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
        $Ref.null))
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
      ($Snap.combine
        ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))
        ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
    (=
      ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
        ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
        ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
      $Snap.unit)
    (as recunf@22@10  Bool))))
; Joined path conditions
(assert (as joined_unfolding@23@10  Bool))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(push) ; 10
(push) ; 11
(set-option :timeout 10)
(assert (not (= next@18@10 $Ref.null)))
(check-sat)
; unknown
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
; [then-branch: 22 | next@18@10 != Null | live]
; [else-branch: 22 | next@18@10 == Null | dead]
(set-option :timeout 0)
(push) ; 11
; [then-branch: 22 | next@18@10 != Null]
; [eval] this.data <= this.next.data
(pop) ; 11
(pop) ; 10
; Joined path conditions
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (lseg%trigger ($Snap.combine
  ($Snap.first ($Snap.second $t@6@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@6@10)))
    ($Snap.combine
      ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
      $Snap.unit))) next@18@10 $Ref.null))
(assert (=>
  (not (= next@18@10 $Ref.null))
  (and
    (not (= next@18@10 $Ref.null))
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
          $Ref.null))
      (=
        (as joined_unfolding@23@10  Bool)
        (=>
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
              $Ref.null))
          (<=
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))))
    (=>
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
        $Ref.null)
      (= (as joined_unfolding@23@10  Bool) true))
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
          $Ref.null))
      (and
        (not
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
            $Ref.null))
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
          ($Snap.combine
            ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))
            ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
        (=
          ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
            ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
            ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))))))
          $Snap.unit)
        (as recunf@22@10  Bool)))
    (as joined_unfolding@23@10  Bool))))
(assert (not (= next@18@10 $Ref.null)))
(push) ; 8
(assert (not (=>
  (not (= next@18@10 $Ref.null))
  (<= elem@4@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (=>
  (not (= next@18@10 $Ref.null))
  (<= elem@4@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10))))))
(assert (lseg%trigger ($Snap.combine
  ($SortWrappers.IntTo$Snap elem@4@10)
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap next@18@10)
    ($Snap.combine
      ($Snap.combine
        ($Snap.first ($Snap.second $t@6@10))
        ($Snap.combine
          ($Snap.first ($Snap.second ($Snap.second $t@6@10)))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
            $Snap.unit)))
      $Snap.unit))) tmp@12@10 $Ref.null))
; [exec]
; this.head := tmp
(push) ; 8
(set-option :timeout 10)
(assert (not (= tmp@12@10 this@3@10)))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [exec]
; fold acc(List(this), write)
(assert (List%trigger ($Snap.combine
  ($SortWrappers.$RefTo$Snap tmp@12@10)
  ($Snap.combine
    ($SortWrappers.IntTo$Snap elem@4@10)
    ($Snap.combine
      ($SortWrappers.$RefTo$Snap next@18@10)
      ($Snap.combine
        ($Snap.combine
          ($Snap.first ($Snap.second $t@6@10))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.second $t@6@10)))
            ($Snap.combine
              ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
              $Snap.unit)))
        $Snap.unit)))) this@3@10))
; [eval] 0 <= index
; [eval] index <= |old(content(this))|
; [eval] |old(content(this))|
; [eval] old(content(this))
; [eval] content(this)
(set-option :timeout 0)
(push) ; 8
(assert (content%precondition $t@6@10 this@3@10))
(pop) ; 8
; Joined path conditions
(assert (content%precondition $t@6@10 this@3@10))
(push) ; 8
(assert (not (<= 0 (Seq_length (content $t@6@10 this@3@10)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 (Seq_length (content $t@6@10 this@3@10))))
; [eval] content(this) == old(content(this))[0..index] ++ Seq(elem) ++ old(content(this))[index..]
; [eval] content(this)
(push) ; 8
(assert (content%precondition ($Snap.combine
  ($SortWrappers.$RefTo$Snap tmp@12@10)
  ($Snap.combine
    ($SortWrappers.IntTo$Snap elem@4@10)
    ($Snap.combine
      ($SortWrappers.$RefTo$Snap next@18@10)
      ($Snap.combine
        ($Snap.combine
          ($Snap.first ($Snap.second $t@6@10))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.second $t@6@10)))
            ($Snap.combine
              ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
              $Snap.unit)))
        $Snap.unit)))) this@3@10))
(pop) ; 8
; Joined path conditions
(assert (content%precondition ($Snap.combine
  ($SortWrappers.$RefTo$Snap tmp@12@10)
  ($Snap.combine
    ($SortWrappers.IntTo$Snap elem@4@10)
    ($Snap.combine
      ($SortWrappers.$RefTo$Snap next@18@10)
      ($Snap.combine
        ($Snap.combine
          ($Snap.first ($Snap.second $t@6@10))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.second $t@6@10)))
            ($Snap.combine
              ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
              $Snap.unit)))
        $Snap.unit)))) this@3@10))
; [eval] old(content(this))[0..index] ++ Seq(elem) ++ old(content(this))[index..]
; [eval] old(content(this))[0..index] ++ Seq(elem)
; [eval] old(content(this))[0..index]
; [eval] old(content(this))[..index]
; [eval] old(content(this))
; [eval] content(this)
(push) ; 8
(pop) ; 8
; Joined path conditions
; [eval] Seq(elem)
(assert (= (Seq_length (Seq_singleton elem@4@10)) 1))
; [eval] old(content(this))[index..]
; [eval] old(content(this))
; [eval] content(this)
(push) ; 8
(pop) ; 8
; Joined path conditions
(push) ; 8
(assert (not (Seq_equal
  (content ($Snap.combine
    ($SortWrappers.$RefTo$Snap tmp@12@10)
    ($Snap.combine
      ($SortWrappers.IntTo$Snap elem@4@10)
      ($Snap.combine
        ($SortWrappers.$RefTo$Snap next@18@10)
        ($Snap.combine
          ($Snap.combine
            ($Snap.first ($Snap.second $t@6@10))
            ($Snap.combine
              ($Snap.first ($Snap.second ($Snap.second $t@6@10)))
              ($Snap.combine
                ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
                $Snap.unit)))
          $Snap.unit)))) this@3@10)
  (Seq_append
    (Seq_append
      (Seq_drop (Seq_take (content $t@6@10 this@3@10) 0) 0)
      (Seq_singleton elem@4@10))
    (Seq_drop (content $t@6@10 this@3@10) 0)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (Seq_equal
  (content ($Snap.combine
    ($SortWrappers.$RefTo$Snap tmp@12@10)
    ($Snap.combine
      ($SortWrappers.IntTo$Snap elem@4@10)
      ($Snap.combine
        ($SortWrappers.$RefTo$Snap next@18@10)
        ($Snap.combine
          ($Snap.combine
            ($Snap.first ($Snap.second $t@6@10))
            ($Snap.combine
              ($Snap.first ($Snap.second ($Snap.second $t@6@10)))
              ($Snap.combine
                ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10))))
                $Snap.unit)))
          $Snap.unit)))) this@3@10)
  (Seq_append
    (Seq_append
      (Seq_drop (Seq_take (content $t@6@10 this@3@10) 0) 0)
      (Seq_singleton elem@4@10))
    (Seq_drop (content $t@6@10 this@3@10) 0))))
(pop) ; 7
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch: 9 | !(First:($t@6@10) == Null || elem@4@10 <= First:(Second:($t@6@10)))]
(assert (not
  (or
    (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null)
    (<=
      elem@4@10
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))))))
(pop) ; 5
; [eval] !(this.head == null || elem <= this.head.data)
; [eval] this.head == null || elem <= this.head.data
; [eval] this.head == null
(push) ; 5
; [then-branch: 23 | First:($t@6@10) == Null | live]
; [else-branch: 23 | First:($t@6@10) != Null | live]
(push) ; 6
; [then-branch: 23 | First:($t@6@10) == Null]
(assert (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null))
(pop) ; 6
(push) ; 6
; [else-branch: 23 | First:($t@6@10) != Null]
; [eval] elem <= this.head.data
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(push) ; 5
(set-option :timeout 10)
(assert (not (or
  (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null)
  (<= elem@4@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 10)
(assert (not (not
  (or
    (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null)
    (<=
      elem@4@10
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10))))))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [then-branch: 24 | !(First:($t@6@10) == Null || elem@4@10 <= First:(Second:($t@6@10))) | live]
; [else-branch: 24 | First:($t@6@10) == Null || elem@4@10 <= First:(Second:($t@6@10)) | live]
(set-option :timeout 0)
(push) ; 5
; [then-branch: 24 | !(First:($t@6@10) == Null || elem@4@10 <= First:(Second:($t@6@10)))]
(assert (not
  (or
    (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) $Ref.null)
    (<=
      elem@4@10
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))))))
; [exec]
; var ptr: Ref
(declare-const ptr@24@10 $Ref)
; [exec]
; ptr := this.head
(declare-const ptr@25@10 $Ref)
(assert (= ptr@25@10 ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10))))
; [exec]
; fold acc(lseg(this.head, ptr), write)
; [eval] this != end
(push) ; 6
(set-option :timeout 10)
(assert (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [then-branch: 25 | First:($t@6@10) != ptr@25@10 | dead]
; [else-branch: 25 | First:($t@6@10) == ptr@25@10 | live]
(set-option :timeout 0)
(push) ; 6
; [else-branch: 25 | First:($t@6@10) == ptr@25@10]
(assert (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))
(assert (lseg%trigger $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))
(push) ; 7
(set-option :timeout 10)
(assert (not (and
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10))))
    ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)))
  (= $Ref.null ptr@25@10))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [exec]
; index := index + 1
; [eval] index + 1
(declare-const index@26@10 Int)
(declare-const ptrn@27@10 $Ref)
(declare-const ptr@28@10 $Ref)
(set-option :timeout 0)
(push) ; 7
; Loop head block: Check well-definedness of invariant
(declare-const $t@29@10 $Snap)
(assert (= $t@29@10 ($Snap.combine ($Snap.first $t@29@10) ($Snap.second $t@29@10))))
(assert (=
  ($Snap.second $t@29@10)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@29@10))
    ($Snap.second ($Snap.second $t@29@10)))))
(assert (not (= ptr@28@10 $Ref.null)))
(assert (=
  ($Snap.second ($Snap.second $t@29@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@29@10)))
    ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@29@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@29@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@29@10))))
  $Snap.unit))
; [eval] ptr.data <= elem
(assert (<=
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.second $t@29@10))))
  elem@4@10))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
(push) ; 8
(set-option :timeout 10)
(assert (not (and
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
    ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)))
  (= $Ref.null ptr@28@10))))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
  $Snap.unit))
; [eval] (forall i: Int :: { contentNodes(this.head, ptr)[i] } 0 <= i && i < |contentNodes(this.head, ptr)| ==> contentNodes(this.head, ptr)[i] <= ptr.data)
(declare-const i@30@10 Int)
(set-option :timeout 0)
(push) ; 8
; [eval] 0 <= i && i < |contentNodes(this.head, ptr)| ==> contentNodes(this.head, ptr)[i] <= ptr.data
; [eval] 0 <= i && i < |contentNodes(this.head, ptr)|
; [eval] 0 <= i
(push) ; 9
; [then-branch: 26 | !(0 <= i@30@10) | live]
; [else-branch: 26 | 0 <= i@30@10 | live]
(push) ; 10
; [then-branch: 26 | !(0 <= i@30@10)]
(assert (not (<= 0 i@30@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 26 | 0 <= i@30@10]
(assert (<= 0 i@30@10))
; [eval] i < |contentNodes(this.head, ptr)|
; [eval] |contentNodes(this.head, ptr)|
; [eval] contentNodes(this.head, ptr)
(push) ; 11
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))
(pop) ; 11
; Joined path conditions
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= 0 i@30@10)
  (and
    (<= 0 i@30@10)
    (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))))
(assert (or (<= 0 i@30@10) (not (<= 0 i@30@10))))
(push) ; 9
; [then-branch: 27 | 0 <= i@30@10 && i@30@10 < |contentNodes(First:(Second:(Second:(Second:(Second:(Second:($t@29@10)))))), First:($t@29@10), ptr@28@10)| | live]
; [else-branch: 27 | !(0 <= i@30@10 && i@30@10 < |contentNodes(First:(Second:(Second:(Second:(Second:(Second:($t@29@10)))))), First:($t@29@10), ptr@28@10)|) | live]
(push) ; 10
; [then-branch: 27 | 0 <= i@30@10 && i@30@10 < |contentNodes(First:(Second:(Second:(Second:(Second:(Second:($t@29@10)))))), First:($t@29@10), ptr@28@10)|]
(assert (and
  (<= 0 i@30@10)
  (<
    i@30@10
    (Seq_length
      (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)))))
; [eval] contentNodes(this.head, ptr)[i] <= ptr.data
; [eval] contentNodes(this.head, ptr)[i]
; [eval] contentNodes(this.head, ptr)
(push) ; 11
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))
(pop) ; 11
; Joined path conditions
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))
(push) ; 11
(assert (not (>= i@30@10 0)))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(pop) ; 10
(push) ; 10
; [else-branch: 27 | !(0 <= i@30@10 && i@30@10 < |contentNodes(First:(Second:(Second:(Second:(Second:(Second:($t@29@10)))))), First:($t@29@10), ptr@28@10)|)]
(assert (not
  (and
    (<= 0 i@30@10)
    (<
      i@30@10
      (Seq_length
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
(assert (=>
  (and
    (<= 0 i@30@10)
    (<
      i@30@10
      (Seq_length
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))))
  (and
    (<= 0 i@30@10)
    (<
      i@30@10
      (Seq_length
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)))
    (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= 0 i@30@10)
      (<
        i@30@10
        (Seq_length
          (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)))))
  (and
    (<= 0 i@30@10)
    (<
      i@30@10
      (Seq_length
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))))))
(pop) ; 8
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@30@10 Int)) (!
  (and
    (=>
      (<= 0 i@30@10)
      (and
        (<= 0 i@30@10)
        (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)))
    (or (<= 0 i@30@10) (not (<= 0 i@30@10)))
    (=>
      (and
        (<= 0 i@30@10)
        (<
          i@30@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))))
      (and
        (<= 0 i@30@10)
        (<
          i@30@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)))
        (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)))
    (or
      (not
        (and
          (<= 0 i@30@10)
          (<
            i@30@10
            (Seq_length
              (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)))))
      (and
        (<= 0 i@30@10)
        (<
          i@30@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))))))
  :pattern ((Seq_index
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)
    i@30@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@137@17@138@62-aux|)))
(assert (forall ((i@30@10 Int)) (!
  (=>
    (and
      (<= 0 i@30@10)
      (<
        i@30@10
        (Seq_length
          (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))))
    (<=
      (Seq_index
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)
        i@30@10)
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.second $t@29@10))))))
  :pattern ((Seq_index
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)
    i@30@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@137@17@138@62|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { contentNodes(ptr.next, null)[i] } 0 <= i && i < |contentNodes(ptr.next, null)| ==> ptr.data <= contentNodes(ptr.next, null)[i])
(declare-const i@31@10 Int)
(push) ; 8
; [eval] 0 <= i && i < |contentNodes(ptr.next, null)| ==> ptr.data <= contentNodes(ptr.next, null)[i]
; [eval] 0 <= i && i < |contentNodes(ptr.next, null)|
; [eval] 0 <= i
(push) ; 9
; [then-branch: 28 | !(0 <= i@31@10) | live]
; [else-branch: 28 | 0 <= i@31@10 | live]
(push) ; 10
; [then-branch: 28 | !(0 <= i@31@10)]
(assert (not (<= 0 i@31@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 28 | 0 <= i@31@10]
(assert (<= 0 i@31@10))
; [eval] i < |contentNodes(ptr.next, null)|
; [eval] |contentNodes(ptr.next, null)|
; [eval] contentNodes(ptr.next, null)
(push) ; 11
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
(pop) ; 11
; Joined path conditions
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= 0 i@31@10)
  (and
    (<= 0 i@31@10)
    (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))))
(assert (or (<= 0 i@31@10) (not (<= 0 i@31@10))))
(push) ; 9
; [then-branch: 29 | 0 <= i@31@10 && i@31@10 < |contentNodes(First:(Second:(Second:(Second:(Second:($t@29@10))))), First:(Second:($t@29@10)), Null)| | live]
; [else-branch: 29 | !(0 <= i@31@10 && i@31@10 < |contentNodes(First:(Second:(Second:(Second:(Second:($t@29@10))))), First:(Second:($t@29@10)), Null)|) | live]
(push) ; 10
; [then-branch: 29 | 0 <= i@31@10 && i@31@10 < |contentNodes(First:(Second:(Second:(Second:(Second:($t@29@10))))), First:(Second:($t@29@10)), Null)|]
(assert (and
  (<= 0 i@31@10)
  (<
    i@31@10
    (Seq_length
      (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))))
; [eval] ptr.data <= contentNodes(ptr.next, null)[i]
; [eval] contentNodes(ptr.next, null)[i]
; [eval] contentNodes(ptr.next, null)
(push) ; 11
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
(pop) ; 11
; Joined path conditions
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
(push) ; 11
(assert (not (>= i@31@10 0)))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(pop) ; 10
(push) ; 10
; [else-branch: 29 | !(0 <= i@31@10 && i@31@10 < |contentNodes(First:(Second:(Second:(Second:(Second:($t@29@10))))), First:(Second:($t@29@10)), Null)|)]
(assert (not
  (and
    (<= 0 i@31@10)
    (<
      i@31@10
      (Seq_length
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
(assert (=>
  (and
    (<= 0 i@31@10)
    (<
      i@31@10
      (Seq_length
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))))
  (and
    (<= 0 i@31@10)
    (<
      i@31@10
      (Seq_length
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
    (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= 0 i@31@10)
      (<
        i@31@10
        (Seq_length
          (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))))
  (and
    (<= 0 i@31@10)
    (<
      i@31@10
      (Seq_length
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))))))
(pop) ; 8
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@31@10 Int)) (!
  (and
    (=>
      (<= 0 i@31@10)
      (and
        (<= 0 i@31@10)
        (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
    (or (<= 0 i@31@10) (not (<= 0 i@31@10)))
    (=>
      (and
        (<= 0 i@31@10)
        (<
          i@31@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))))
      (and
        (<= 0 i@31@10)
        (<
          i@31@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
        (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
    (or
      (not
        (and
          (<= 0 i@31@10)
          (<
            i@31@10
            (Seq_length
              (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))))
      (and
        (<= 0 i@31@10)
        (<
          i@31@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))))))
  :pattern ((Seq_index
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)
    i@31@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@139@17@140@62-aux|)))
(assert (forall ((i@31@10 Int)) (!
  (=>
    (and
      (<= 0 i@31@10)
      (<
        i@31@10
        (Seq_length
          (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))))
    (<=
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.second $t@29@10))))
      (Seq_index
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)
        i@31@10)))
  :pattern ((Seq_index
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)
    i@31@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@139@17@140@62|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
  $Snap.unit))
; [eval] index - 1 == |contentNodes(this.head, ptr)|
; [eval] index - 1
; [eval] |contentNodes(this.head, ptr)|
; [eval] contentNodes(this.head, ptr)
(push) ; 8
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))
(pop) ; 8
; Joined path conditions
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))
(assert (=
  (- index@26@10 1)
  (Seq_length
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
  $Snap.unit))
; [eval] old(content(this)) == contentNodes(this.head, ptr) ++ Seq(ptr.data) ++ contentNodes(ptr.next, null)
; [eval] old(content(this))
; [eval] content(this)
(push) ; 8
(assert (content%precondition $t@6@10 this@3@10))
(pop) ; 8
; Joined path conditions
(assert (content%precondition $t@6@10 this@3@10))
; [eval] contentNodes(this.head, ptr) ++ Seq(ptr.data) ++ contentNodes(ptr.next, null)
; [eval] contentNodes(this.head, ptr) ++ Seq(ptr.data)
; [eval] contentNodes(this.head, ptr)
(push) ; 8
(pop) ; 8
; Joined path conditions
; [eval] Seq(ptr.data)
(assert (=
  (Seq_length
    (Seq_singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.second $t@29@10))))))
  1))
; [eval] contentNodes(ptr.next, null)
(push) ; 8
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
(pop) ; 8
; Joined path conditions
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
(assert (Seq_equal
  (content $t@6@10 this@3@10)
  (Seq_append
    (Seq_append
      (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)
      (Seq_singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.second $t@29@10))))))
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))))
(pop) ; 7
(push) ; 7
; Loop head block: Establish invariant
; [eval] ptr.data <= elem
(push) ; 8
(assert (not (<= ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10))) elem@4@10)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (<= ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10))) elem@4@10))
; [eval] (forall i: Int :: { contentNodes(this.head, ptr)[i] } 0 <= i && i < |contentNodes(this.head, ptr)| ==> contentNodes(this.head, ptr)[i] <= ptr.data)
(declare-const i@32@10 Int)
(push) ; 8
; [eval] 0 <= i && i < |contentNodes(this.head, ptr)| ==> contentNodes(this.head, ptr)[i] <= ptr.data
; [eval] 0 <= i && i < |contentNodes(this.head, ptr)|
; [eval] 0 <= i
(push) ; 9
; [then-branch: 30 | !(0 <= i@32@10) | live]
; [else-branch: 30 | 0 <= i@32@10 | live]
(push) ; 10
; [then-branch: 30 | !(0 <= i@32@10)]
(assert (not (<= 0 i@32@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 30 | 0 <= i@32@10]
(assert (<= 0 i@32@10))
; [eval] i < |contentNodes(this.head, ptr)|
; [eval] |contentNodes(this.head, ptr)|
; [eval] contentNodes(this.head, ptr)
(push) ; 11
(assert (contentNodes%precondition $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))
(pop) ; 11
; Joined path conditions
(assert (contentNodes%precondition $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= 0 i@32@10)
  (and
    (<= 0 i@32@10)
    (contentNodes%precondition $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))))
(assert (or (<= 0 i@32@10) (not (<= 0 i@32@10))))
(push) ; 9
; [then-branch: 31 | 0 <= i@32@10 && i@32@10 < |contentNodes(_, First:($t@6@10), ptr@25@10)| | live]
; [else-branch: 31 | !(0 <= i@32@10 && i@32@10 < |contentNodes(_, First:($t@6@10), ptr@25@10)|) | live]
(push) ; 10
; [then-branch: 31 | 0 <= i@32@10 && i@32@10 < |contentNodes(_, First:($t@6@10), ptr@25@10)|]
(assert (and
  (<= 0 i@32@10)
  (<
    i@32@10
    (Seq_length
      (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)))))
; [eval] contentNodes(this.head, ptr)[i] <= ptr.data
; [eval] contentNodes(this.head, ptr)[i]
; [eval] contentNodes(this.head, ptr)
(push) ; 11
(assert (contentNodes%precondition $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))
(pop) ; 11
; Joined path conditions
(assert (contentNodes%precondition $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))
(push) ; 11
(assert (not (>= i@32@10 0)))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(pop) ; 10
(push) ; 10
; [else-branch: 31 | !(0 <= i@32@10 && i@32@10 < |contentNodes(_, First:($t@6@10), ptr@25@10)|)]
(assert (not
  (and
    (<= 0 i@32@10)
    (<
      i@32@10
      (Seq_length
        (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
(assert (=>
  (and
    (<= 0 i@32@10)
    (<
      i@32@10
      (Seq_length
        (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))))
  (and
    (<= 0 i@32@10)
    (<
      i@32@10
      (Seq_length
        (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)))
    (contentNodes%precondition $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= 0 i@32@10)
      (<
        i@32@10
        (Seq_length
          (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)))))
  (and
    (<= 0 i@32@10)
    (<
      i@32@10
      (Seq_length
        (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))))))
(pop) ; 8
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@32@10 Int)) (!
  (and
    (=>
      (<= 0 i@32@10)
      (and
        (<= 0 i@32@10)
        (contentNodes%precondition $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)))
    (or (<= 0 i@32@10) (not (<= 0 i@32@10)))
    (=>
      (and
        (<= 0 i@32@10)
        (<
          i@32@10
          (Seq_length
            (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))))
      (and
        (<= 0 i@32@10)
        (<
          i@32@10
          (Seq_length
            (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)))
        (contentNodes%precondition $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)))
    (or
      (not
        (and
          (<= 0 i@32@10)
          (<
            i@32@10
            (Seq_length
              (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)))))
      (and
        (<= 0 i@32@10)
        (<
          i@32@10
          (Seq_length
            (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))))))
  :pattern ((Seq_index
    (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)
    i@32@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@137@17@138@62-aux|)))
(assert (forall ((i@32@10 Int)) (!
  (and
    (=>
      (<= 0 i@32@10)
      (contentNodes%precondition $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))
    (=>
      (and
        (<= 0 i@32@10)
        (<
          i@32@10
          (Seq_length
            (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))))
      (contentNodes%precondition $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)))
  :pattern ((Seq_index
    (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)
    i@32@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@137@17@138@62_precondition|)))
(push) ; 8
(assert (not (forall ((i@32@10 Int)) (!
  (=>
    (and
      (and
        (=>
          (<= 0 i@32@10)
          (contentNodes%precondition $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))
        (=>
          (and
            (<= 0 i@32@10)
            (<
              i@32@10
              (Seq_length
                (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))))
          (contentNodes%precondition $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)))
      (and
        (<= 0 i@32@10)
        (<
          i@32@10
          (Seq_length
            (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)))))
    (<=
      (Seq_index
        (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)
        i@32@10)
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))))
  :pattern ((Seq_index
    (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)
    i@32@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@137@17@138@62|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@32@10 Int)) (!
  (=>
    (and
      (<= 0 i@32@10)
      (<
        i@32@10
        (Seq_length
          (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))))
    (<=
      (Seq_index
        (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)
        i@32@10)
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))))
  :pattern ((Seq_index
    (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)
    i@32@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@137@17@138@62|)))
; [eval] (forall i: Int :: { contentNodes(ptr.next, null)[i] } 0 <= i && i < |contentNodes(ptr.next, null)| ==> ptr.data <= contentNodes(ptr.next, null)[i])
(declare-const i@33@10 Int)
(push) ; 8
; [eval] 0 <= i && i < |contentNodes(ptr.next, null)| ==> ptr.data <= contentNodes(ptr.next, null)[i]
; [eval] 0 <= i && i < |contentNodes(ptr.next, null)|
; [eval] 0 <= i
(push) ; 9
; [then-branch: 32 | !(0 <= i@33@10) | live]
; [else-branch: 32 | 0 <= i@33@10 | live]
(push) ; 10
; [then-branch: 32 | !(0 <= i@33@10)]
(assert (not (<= 0 i@33@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 32 | 0 <= i@33@10]
(assert (<= 0 i@33@10))
; [eval] i < |contentNodes(ptr.next, null)|
; [eval] |contentNodes(ptr.next, null)|
; [eval] contentNodes(ptr.next, null)
(push) ; 11
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))
(pop) ; 11
; Joined path conditions
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= 0 i@33@10)
  (and
    (<= 0 i@33@10)
    (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))))
(assert (or (<= 0 i@33@10) (not (<= 0 i@33@10))))
(push) ; 9
; [then-branch: 33 | 0 <= i@33@10 && i@33@10 < |contentNodes(First:(Second:(Second:(Second:($t@6@10)))), First:(Second:(Second:($t@6@10))), Null)| | live]
; [else-branch: 33 | !(0 <= i@33@10 && i@33@10 < |contentNodes(First:(Second:(Second:(Second:($t@6@10)))), First:(Second:(Second:($t@6@10))), Null)|) | live]
(push) ; 10
; [then-branch: 33 | 0 <= i@33@10 && i@33@10 < |contentNodes(First:(Second:(Second:(Second:($t@6@10)))), First:(Second:(Second:($t@6@10))), Null)|]
(assert (and
  (<= 0 i@33@10)
  (<
    i@33@10
    (Seq_length
      (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)))))
; [eval] ptr.data <= contentNodes(ptr.next, null)[i]
; [eval] contentNodes(ptr.next, null)[i]
; [eval] contentNodes(ptr.next, null)
(push) ; 11
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))
(pop) ; 11
; Joined path conditions
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))
(push) ; 11
(assert (not (>= i@33@10 0)))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(pop) ; 10
(push) ; 10
; [else-branch: 33 | !(0 <= i@33@10 && i@33@10 < |contentNodes(First:(Second:(Second:(Second:($t@6@10)))), First:(Second:(Second:($t@6@10))), Null)|)]
(assert (not
  (and
    (<= 0 i@33@10)
    (<
      i@33@10
      (Seq_length
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
(assert (=>
  (and
    (<= 0 i@33@10)
    (<
      i@33@10
      (Seq_length
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))))
  (and
    (<= 0 i@33@10)
    (<
      i@33@10
      (Seq_length
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)))
    (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= 0 i@33@10)
      (<
        i@33@10
        (Seq_length
          (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)))))
  (and
    (<= 0 i@33@10)
    (<
      i@33@10
      (Seq_length
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))))))
(pop) ; 8
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@33@10 Int)) (!
  (and
    (=>
      (<= 0 i@33@10)
      (and
        (<= 0 i@33@10)
        (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)))
    (or (<= 0 i@33@10) (not (<= 0 i@33@10)))
    (=>
      (and
        (<= 0 i@33@10)
        (<
          i@33@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))))
      (and
        (<= 0 i@33@10)
        (<
          i@33@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)))
        (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)))
    (or
      (not
        (and
          (<= 0 i@33@10)
          (<
            i@33@10
            (Seq_length
              (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)))))
      (and
        (<= 0 i@33@10)
        (<
          i@33@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))))))
  :pattern ((Seq_index
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)
    i@33@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@139@17@140@62-aux|)))
(assert (forall ((i@33@10 Int)) (!
  (and
    (=>
      (<= 0 i@33@10)
      (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))
    (=>
      (and
        (<= 0 i@33@10)
        (<
          i@33@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))))
      (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)))
  :pattern ((Seq_index
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)
    i@33@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@139@17@140@62_precondition|)))
(push) ; 8
(assert (not (forall ((i@33@10 Int)) (!
  (=>
    (and
      (and
        (=>
          (<= 0 i@33@10)
          (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))
        (=>
          (and
            (<= 0 i@33@10)
            (<
              i@33@10
              (Seq_length
                (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))))
          (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)))
      (and
        (<= 0 i@33@10)
        (<
          i@33@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)))))
    (<=
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))
      (Seq_index
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)
        i@33@10)))
  :pattern ((Seq_index
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)
    i@33@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@139@17@140@62|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@33@10 Int)) (!
  (=>
    (and
      (<= 0 i@33@10)
      (<
        i@33@10
        (Seq_length
          (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))))
    (<=
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))
      (Seq_index
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)
        i@33@10)))
  :pattern ((Seq_index
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)
    i@33@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@139@17@140@62|)))
; [eval] index - 1 == |contentNodes(this.head, ptr)|
; [eval] index - 1
; [eval] |contentNodes(this.head, ptr)|
; [eval] contentNodes(this.head, ptr)
(push) ; 8
(assert (contentNodes%precondition $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))
(pop) ; 8
; Joined path conditions
(assert (contentNodes%precondition $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))
(push) ; 8
(assert (not (=
  0
  (Seq_length
    (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (=
  0
  (Seq_length
    (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10))))
; [eval] old(content(this)) == contentNodes(this.head, ptr) ++ Seq(ptr.data) ++ contentNodes(ptr.next, null)
; [eval] old(content(this))
; [eval] content(this)
(push) ; 8
(assert (content%precondition $t@6@10 this@3@10))
(pop) ; 8
; Joined path conditions
(assert (content%precondition $t@6@10 this@3@10))
; [eval] contentNodes(this.head, ptr) ++ Seq(ptr.data) ++ contentNodes(ptr.next, null)
; [eval] contentNodes(this.head, ptr) ++ Seq(ptr.data)
; [eval] contentNodes(this.head, ptr)
(push) ; 8
(pop) ; 8
; Joined path conditions
; [eval] Seq(ptr.data)
(assert (=
  (Seq_length
    (Seq_singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))))
  1))
; [eval] contentNodes(ptr.next, null)
(push) ; 8
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))
(pop) ; 8
; Joined path conditions
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))
(push) ; 8
(assert (not (Seq_equal
  (content $t@6@10 this@3@10)
  (Seq_append
    (Seq_append
      (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)
      (Seq_singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))))
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (Seq_equal
  (content $t@6@10 this@3@10)
  (Seq_append
    (Seq_append
      (contentNodes $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first $t@6@10)) ptr@25@10)
      (Seq_singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@6@10)))))
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@6@10)))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.second $t@6@10)))) $Ref.null))))
; Loop head block: Execute statements of loop head block (in invariant state)
(push) ; 8
(assert (= $t@29@10 ($Snap.combine ($Snap.first $t@29@10) ($Snap.second $t@29@10))))
(assert (=
  ($Snap.second $t@29@10)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@29@10))
    ($Snap.second ($Snap.second $t@29@10)))))
(assert (not (= ptr@28@10 $Ref.null)))
(assert (=
  ($Snap.second ($Snap.second $t@29@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@29@10)))
    ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@29@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@29@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@29@10))))
  $Snap.unit))
(assert (<=
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.second $t@29@10))))
  elem@4@10))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
  $Snap.unit))
(assert (forall ((i@30@10 Int)) (!
  (and
    (=>
      (<= 0 i@30@10)
      (and
        (<= 0 i@30@10)
        (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)))
    (or (<= 0 i@30@10) (not (<= 0 i@30@10)))
    (=>
      (and
        (<= 0 i@30@10)
        (<
          i@30@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))))
      (and
        (<= 0 i@30@10)
        (<
          i@30@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)))
        (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)))
    (or
      (not
        (and
          (<= 0 i@30@10)
          (<
            i@30@10
            (Seq_length
              (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)))))
      (and
        (<= 0 i@30@10)
        (<
          i@30@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))))))
  :pattern ((Seq_index
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)
    i@30@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@137@17@138@62-aux|)))
(assert (forall ((i@30@10 Int)) (!
  (=>
    (and
      (<= 0 i@30@10)
      (<
        i@30@10
        (Seq_length
          (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))))
    (<=
      (Seq_index
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)
        i@30@10)
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.second $t@29@10))))))
  :pattern ((Seq_index
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)
    i@30@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@137@17@138@62|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Snap.unit))
(assert (forall ((i@31@10 Int)) (!
  (and
    (=>
      (<= 0 i@31@10)
      (and
        (<= 0 i@31@10)
        (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
    (or (<= 0 i@31@10) (not (<= 0 i@31@10)))
    (=>
      (and
        (<= 0 i@31@10)
        (<
          i@31@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))))
      (and
        (<= 0 i@31@10)
        (<
          i@31@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
        (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
    (or
      (not
        (and
          (<= 0 i@31@10)
          (<
            i@31@10
            (Seq_length
              (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))))
      (and
        (<= 0 i@31@10)
        (<
          i@31@10
          (Seq_length
            (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))))))
  :pattern ((Seq_index
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)
    i@31@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@139@17@140@62-aux|)))
(assert (forall ((i@31@10 Int)) (!
  (=>
    (and
      (<= 0 i@31@10)
      (<
        i@31@10
        (Seq_length
          (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))))
    (<=
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.second $t@29@10))))
      (Seq_index
        (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)
        i@31@10)))
  :pattern ((Seq_index
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)
    i@31@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/linked-list-predicates.vpr@139@17@140@62|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
  $Snap.unit))
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))
(assert (=
  (- index@26@10 1)
  (Seq_length
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
  $Snap.unit))
(assert (=
  (Seq_length
    (Seq_singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.second $t@29@10))))))
  1))
(assert (contentNodes%precondition ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
(assert (Seq_equal
  (content $t@6@10 this@3@10)
  (Seq_append
    (Seq_append
      (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))) ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)
      (Seq_singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.second $t@29@10))))))
    (contentNodes ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
(set-option :timeout 10)
(check-sat)
; unknown
; Loop head block: Check well-definedness of edge conditions
(set-option :timeout 0)
(push) ; 9
; [eval] ptr.next != null && (unfolding acc(lseg(ptr.next, null), write) in ptr.next.data < elem)
; [eval] ptr.next != null
(push) ; 10
; [then-branch: 34 | First:(Second:($t@29@10)) == Null | live]
; [else-branch: 34 | First:(Second:($t@29@10)) != Null | live]
(push) ; 11
; [then-branch: 34 | First:(Second:($t@29@10)) == Null]
(assert (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
(pop) ; 11
(push) ; 11
; [else-branch: 34 | First:(Second:($t@29@10)) != Null]
(assert (not
  (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
; [eval] (unfolding acc(lseg(ptr.next, null), write) in ptr.next.data < elem)
(push) ; 12
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
; [eval] this != end
(push) ; 13
(set-option :timeout 10)
(assert (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
(check-sat)
; unknown
(pop) ; 13
; 0.01s
; (get-info :all-statistics)
; [then-branch: 35 | First:(Second:($t@29@10)) != Null | live]
; [else-branch: 35 | First:(Second:($t@29@10)) == Null | dead]
(set-option :timeout 0)
(push) ; 13
; [then-branch: 35 | First:(Second:($t@29@10)) != Null]
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
    ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
(push) ; 14
(set-option :timeout 10)
(assert (not (= ptr@28@10 ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))))))
(check-sat)
; unknown
(pop) ; 14
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
    ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
(set-option :timeout 0)
(push) ; 14
(set-option :timeout 10)
(assert (not (= ptr@28@10 ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))))))
(check-sat)
; unknown
(pop) ; 14
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(set-option :timeout 0)
(push) ; 14
(set-option :timeout 10)
(assert (not (and
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10))
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
  (= ptr@28@10 $Ref.null))))
(check-sat)
; unknown
(pop) ; 14
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Snap.unit))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(set-option :timeout 0)
(push) ; 14
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) $Ref.null))
; [eval] this != end
(push) ; 15
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 15
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 15
(set-option :timeout 10)
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null))))
(check-sat)
; unknown
(pop) ; 15
; 0.00s
; (get-info :all-statistics)
; [then-branch: 36 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null | live]
; [else-branch: 36 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null | live]
(set-option :timeout 0)
(push) ; 15
; [then-branch: 36 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null]
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  ($Snap.combine
    ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
    ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
(push) ; 16
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 16
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 16
(set-option :timeout 10)
(assert (not (=
  ptr@28@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 16
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
    ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
(set-option :timeout 0)
(push) ; 16
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 16
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 16
(set-option :timeout 10)
(assert (not (=
  ptr@28@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 16
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
(set-option :timeout 0)
(push) ; 16
(set-option :timeout 10)
(assert (not (and
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10))
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
  (= ptr@28@10 $Ref.null))))
(check-sat)
; unknown
(pop) ; 16
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
  $Snap.unit))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(declare-const recunf@34@10 Bool)
(assert (as recunf@34@10  Bool))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(set-option :timeout 0)
(push) ; 16
(push) ; 17
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 17
; 0.01s
; (get-info :all-statistics)
; [then-branch: 37 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null | live]
; [else-branch: 37 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null | dead]
(set-option :timeout 0)
(push) ; 17
; [then-branch: 37 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null]
; [eval] this.data <= this.next.data
(pop) ; 17
(pop) ; 16
; Joined path conditions
(pop) ; 15
(push) ; 15
; [else-branch: 36 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null]
(assert (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Ref.null))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Snap.unit))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(push) ; 16
; [then-branch: 38 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null | dead]
; [else-branch: 38 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null | live]
(push) ; 17
; [else-branch: 38 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null]
(pop) ; 17
(pop) ; 16
; Joined path conditions
(pop) ; 15
(pop) ; 14
(declare-const joined_unfolding@35@10 Bool)
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null))
  (=
    (as joined_unfolding@35@10  Bool)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null))
      (<=
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))))
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)
  (= (as joined_unfolding@35@10  Bool) true)))
; Joined path conditions
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) $Ref.null))
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null))
  (and
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        $Ref.null))
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      ($Snap.combine
        ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
        ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
    (=
      ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
        ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
        ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
      $Snap.unit)
    (as recunf@34@10  Bool))))
; Joined path conditions
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)
  (and
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null)
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Snap.unit))))
(assert (or
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null))))
(assert (as joined_unfolding@35@10  Bool))
; [eval] ptr.next.data < elem
(pop) ; 13
(pop) ; 12
; Joined path conditions
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
      $Ref.null))
  (and
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))
      ($Snap.combine
        ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
        ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    (=
      ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
        ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Snap.unit)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null))
      (=
        (as joined_unfolding@35@10  Bool)
        (=>
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Ref.null))
          (<=
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
    (=>
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        $Ref.null)
      (= (as joined_unfolding@35@10  Bool) true))
    (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) $Ref.null)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null))
      (and
        (not
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
            $Ref.null))
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          ($Snap.combine
            ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
            ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
        (=
          ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
            ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
            ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
          $Snap.unit)
        (as recunf@34@10  Bool)))
    (=>
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        $Ref.null)
      (and
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null)
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Snap.unit)))
    (or
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        $Ref.null)
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null)))
    (as joined_unfolding@35@10  Bool))))
(pop) ; 11
(pop) ; 10
; Joined path conditions
; Joined path conditions
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
      $Ref.null))
  (and
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
        $Ref.null))
    (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
          $Ref.null))
      (and
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))
          ($Snap.combine
            ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
            ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        (=
          ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
            ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
            ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Snap.unit)
        (=>
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Ref.null))
          (=
            (as joined_unfolding@35@10  Bool)
            (=>
              (not
                (=
                  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
                  $Ref.null))
              (<=
                ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
                ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
        (=>
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
            $Ref.null)
          (= (as joined_unfolding@35@10  Bool) true))
        (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) $Ref.null)
        (=>
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Ref.null))
          (and
            (not
              (=
                ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
                $Ref.null))
            (=
              ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              ($Snap.combine
                ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
                ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
            (=
              ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
              ($Snap.combine
                ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
                ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
            (=
              ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
              ($Snap.combine
                ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
                ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
            (=
              ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
              $Snap.unit)
            (as recunf@34@10  Bool)))
        (=>
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
            $Ref.null)
          (and
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Ref.null)
            (=
              ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Snap.unit)))
        (or
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
            $Ref.null)
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Ref.null)))
        (as joined_unfolding@35@10  Bool))))))
(assert (or
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
      $Ref.null))
  (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
(pop) ; 9
(push) ; 9
; [eval] !(ptr.next != null && (unfolding acc(lseg(ptr.next, null), write) in ptr.next.data < elem))
; [eval] ptr.next != null && (unfolding acc(lseg(ptr.next, null), write) in ptr.next.data < elem)
; [eval] ptr.next != null
(push) ; 10
; [then-branch: 39 | First:(Second:($t@29@10)) == Null | live]
; [else-branch: 39 | First:(Second:($t@29@10)) != Null | live]
(push) ; 11
; [then-branch: 39 | First:(Second:($t@29@10)) == Null]
(assert (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
(pop) ; 11
(push) ; 11
; [else-branch: 39 | First:(Second:($t@29@10)) != Null]
(assert (not
  (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
; [eval] (unfolding acc(lseg(ptr.next, null), write) in ptr.next.data < elem)
(push) ; 12
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
; [eval] this != end
(push) ; 13
(set-option :timeout 10)
(assert (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
(check-sat)
; unknown
(pop) ; 13
; 0.01s
; (get-info :all-statistics)
; [then-branch: 40 | First:(Second:($t@29@10)) != Null | live]
; [else-branch: 40 | First:(Second:($t@29@10)) == Null | dead]
(set-option :timeout 0)
(push) ; 13
; [then-branch: 40 | First:(Second:($t@29@10)) != Null]
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
    ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
(push) ; 14
(set-option :timeout 10)
(assert (not (= ptr@28@10 ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))))))
(check-sat)
; unknown
(pop) ; 14
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
    ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
(set-option :timeout 0)
(push) ; 14
(set-option :timeout 10)
(assert (not (= ptr@28@10 ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))))))
(check-sat)
; unknown
(pop) ; 14
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(set-option :timeout 0)
(push) ; 14
(set-option :timeout 10)
(assert (not (and
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10))
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
  (= ptr@28@10 $Ref.null))))
(check-sat)
; unknown
(pop) ; 14
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Snap.unit))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(set-option :timeout 0)
(push) ; 14
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) $Ref.null))
; [eval] this != end
(push) ; 15
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 15
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 15
(set-option :timeout 10)
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null))))
(check-sat)
; unknown
(pop) ; 15
; 0.00s
; (get-info :all-statistics)
; [then-branch: 41 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null | live]
; [else-branch: 41 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null | live]
(set-option :timeout 0)
(push) ; 15
; [then-branch: 41 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null]
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  ($Snap.combine
    ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
    ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
(push) ; 16
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 16
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 16
(set-option :timeout 10)
(assert (not (=
  ptr@28@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 16
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
    ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
(set-option :timeout 0)
(push) ; 16
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 16
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 16
(set-option :timeout 10)
(assert (not (=
  ptr@28@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 16
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
(set-option :timeout 0)
(push) ; 16
(set-option :timeout 10)
(assert (not (and
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10))
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
  (= ptr@28@10 $Ref.null))))
(check-sat)
; unknown
(pop) ; 16
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
  $Snap.unit))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(declare-const recunf@36@10 Bool)
(assert (as recunf@36@10  Bool))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(set-option :timeout 0)
(push) ; 16
(push) ; 17
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 17
; 0.01s
; (get-info :all-statistics)
; [then-branch: 42 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null | live]
; [else-branch: 42 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null | dead]
(set-option :timeout 0)
(push) ; 17
; [then-branch: 42 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null]
; [eval] this.data <= this.next.data
(pop) ; 17
(pop) ; 16
; Joined path conditions
(pop) ; 15
(push) ; 15
; [else-branch: 41 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null]
(assert (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Ref.null))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Snap.unit))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(push) ; 16
; [then-branch: 43 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null | dead]
; [else-branch: 43 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null | live]
(push) ; 17
; [else-branch: 43 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null]
(pop) ; 17
(pop) ; 16
; Joined path conditions
(pop) ; 15
(pop) ; 14
(declare-const joined_unfolding@37@10 Bool)
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null))
  (=
    (as joined_unfolding@37@10  Bool)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null))
      (<=
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))))
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)
  (= (as joined_unfolding@37@10  Bool) true)))
; Joined path conditions
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) $Ref.null))
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null))
  (and
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        $Ref.null))
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      ($Snap.combine
        ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
        ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
    (=
      ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
        ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
        ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
      $Snap.unit)
    (as recunf@36@10  Bool))))
; Joined path conditions
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)
  (and
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null)
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Snap.unit))))
(assert (or
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null))))
(assert (as joined_unfolding@37@10  Bool))
; [eval] ptr.next.data < elem
(pop) ; 13
(pop) ; 12
; Joined path conditions
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
      $Ref.null))
  (and
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))
      ($Snap.combine
        ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
        ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    (=
      ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
        ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Snap.unit)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null))
      (=
        (as joined_unfolding@37@10  Bool)
        (=>
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Ref.null))
          (<=
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
    (=>
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        $Ref.null)
      (= (as joined_unfolding@37@10  Bool) true))
    (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) $Ref.null)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null))
      (and
        (not
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
            $Ref.null))
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          ($Snap.combine
            ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
            ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
        (=
          ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
            ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
            ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
          $Snap.unit)
        (as recunf@36@10  Bool)))
    (=>
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        $Ref.null)
      (and
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null)
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Snap.unit)))
    (or
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        $Ref.null)
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null)))
    (as joined_unfolding@37@10  Bool))))
(pop) ; 11
(pop) ; 10
; Joined path conditions
; Joined path conditions
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
      $Ref.null))
  (and
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
        $Ref.null))
    (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
          $Ref.null))
      (and
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))
          ($Snap.combine
            ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
            ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        (=
          ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
            ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
            ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Snap.unit)
        (=>
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Ref.null))
          (=
            (as joined_unfolding@37@10  Bool)
            (=>
              (not
                (=
                  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
                  $Ref.null))
              (<=
                ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
                ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
        (=>
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
            $Ref.null)
          (= (as joined_unfolding@37@10  Bool) true))
        (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) $Ref.null)
        (=>
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Ref.null))
          (and
            (not
              (=
                ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
                $Ref.null))
            (=
              ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              ($Snap.combine
                ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
                ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
            (=
              ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
              ($Snap.combine
                ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
                ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
            (=
              ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
              ($Snap.combine
                ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
                ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
            (=
              ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
              $Snap.unit)
            (as recunf@36@10  Bool)))
        (=>
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
            $Ref.null)
          (and
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Ref.null)
            (=
              ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Snap.unit)))
        (or
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
            $Ref.null)
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Ref.null)))
        (as joined_unfolding@37@10  Bool))))))
(assert (or
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
      $Ref.null))
  (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
(pop) ; 9
; Loop head block: Follow loop-internal edges
; [eval] ptr.next != null && (unfolding acc(lseg(ptr.next, null), write) in ptr.next.data < elem)
; [eval] ptr.next != null
(push) ; 9
; [then-branch: 44 | First:(Second:($t@29@10)) == Null | live]
; [else-branch: 44 | First:(Second:($t@29@10)) != Null | live]
(push) ; 10
; [then-branch: 44 | First:(Second:($t@29@10)) == Null]
(assert (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
(pop) ; 10
(push) ; 10
; [else-branch: 44 | First:(Second:($t@29@10)) != Null]
(assert (not
  (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
; [eval] (unfolding acc(lseg(ptr.next, null), write) in ptr.next.data < elem)
(push) ; 11
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
; [eval] this != end
(push) ; 12
(set-option :timeout 10)
(assert (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
(check-sat)
; unknown
(pop) ; 12
; 0.01s
; (get-info :all-statistics)
; [then-branch: 45 | First:(Second:($t@29@10)) != Null | live]
; [else-branch: 45 | First:(Second:($t@29@10)) == Null | dead]
(set-option :timeout 0)
(push) ; 12
; [then-branch: 45 | First:(Second:($t@29@10)) != Null]
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
    ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
(push) ; 13
(set-option :timeout 10)
(assert (not (= ptr@28@10 ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))))))
(check-sat)
; unknown
(pop) ; 13
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
    ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
(set-option :timeout 0)
(push) ; 13
(set-option :timeout 10)
(assert (not (= ptr@28@10 ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))))))
(check-sat)
; unknown
(pop) ; 13
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(set-option :timeout 0)
(push) ; 13
(set-option :timeout 10)
(assert (not (and
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10))
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
  (= ptr@28@10 $Ref.null))))
(check-sat)
; unknown
(pop) ; 13
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Snap.unit))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(set-option :timeout 0)
(push) ; 13
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) $Ref.null))
; [eval] this != end
(push) ; 14
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 14
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 14
(set-option :timeout 10)
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null))))
(check-sat)
; unknown
(pop) ; 14
; 0.00s
; (get-info :all-statistics)
; [then-branch: 46 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null | live]
; [else-branch: 46 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null | live]
(set-option :timeout 0)
(push) ; 14
; [then-branch: 46 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null]
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  ($Snap.combine
    ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
    ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
(push) ; 15
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 15
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 15
(set-option :timeout 10)
(assert (not (=
  ptr@28@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 15
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
    ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
(set-option :timeout 0)
(push) ; 15
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 15
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 15
(set-option :timeout 10)
(assert (not (=
  ptr@28@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 15
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
(set-option :timeout 0)
(push) ; 15
(set-option :timeout 10)
(assert (not (and
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10))
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
  (= ptr@28@10 $Ref.null))))
(check-sat)
; unknown
(pop) ; 15
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
  $Snap.unit))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(declare-const recunf@38@10 Bool)
(assert (as recunf@38@10  Bool))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(set-option :timeout 0)
(push) ; 15
(push) ; 16
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 16
; 0.01s
; (get-info :all-statistics)
; [then-branch: 47 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null | live]
; [else-branch: 47 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null | dead]
(set-option :timeout 0)
(push) ; 16
; [then-branch: 47 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null]
; [eval] this.data <= this.next.data
(pop) ; 16
(pop) ; 15
; Joined path conditions
(pop) ; 14
(push) ; 14
; [else-branch: 46 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null]
(assert (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Ref.null))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Snap.unit))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(push) ; 15
; [then-branch: 48 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null | dead]
; [else-branch: 48 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null | live]
(push) ; 16
; [else-branch: 48 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null]
(pop) ; 16
(pop) ; 15
; Joined path conditions
(pop) ; 14
(pop) ; 13
(declare-const joined_unfolding@39@10 Bool)
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null))
  (=
    (as joined_unfolding@39@10  Bool)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null))
      (<=
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))))
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)
  (= (as joined_unfolding@39@10  Bool) true)))
; Joined path conditions
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) $Ref.null))
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null))
  (and
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        $Ref.null))
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      ($Snap.combine
        ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
        ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
    (=
      ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
        ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
        ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
      $Snap.unit)
    (as recunf@38@10  Bool))))
; Joined path conditions
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)
  (and
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null)
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Snap.unit))))
(assert (or
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null))))
(assert (as joined_unfolding@39@10  Bool))
; [eval] ptr.next.data < elem
(pop) ; 12
(pop) ; 11
; Joined path conditions
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
      $Ref.null))
  (and
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))
      ($Snap.combine
        ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
        ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    (=
      ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
        ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Snap.unit)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null))
      (=
        (as joined_unfolding@39@10  Bool)
        (=>
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Ref.null))
          (<=
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
    (=>
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        $Ref.null)
      (= (as joined_unfolding@39@10  Bool) true))
    (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) $Ref.null)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null))
      (and
        (not
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
            $Ref.null))
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          ($Snap.combine
            ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
            ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
        (=
          ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
            ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
            ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
          $Snap.unit)
        (as recunf@38@10  Bool)))
    (=>
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        $Ref.null)
      (and
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null)
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Snap.unit)))
    (or
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        $Ref.null)
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null)))
    (as joined_unfolding@39@10  Bool))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
      $Ref.null))
  (and
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
        $Ref.null))
    (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
          $Ref.null))
      (and
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))
          ($Snap.combine
            ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
            ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        (=
          ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
            ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
            ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Snap.unit)
        (=>
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Ref.null))
          (=
            (as joined_unfolding@39@10  Bool)
            (=>
              (not
                (=
                  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
                  $Ref.null))
              (<=
                ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
                ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
        (=>
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
            $Ref.null)
          (= (as joined_unfolding@39@10  Bool) true))
        (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) $Ref.null)
        (=>
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Ref.null))
          (and
            (not
              (=
                ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
                $Ref.null))
            (=
              ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              ($Snap.combine
                ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
                ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
            (=
              ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
              ($Snap.combine
                ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
                ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
            (=
              ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
              ($Snap.combine
                ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
                ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
            (=
              ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
              $Snap.unit)
            (as recunf@38@10  Bool)))
        (=>
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
            $Ref.null)
          (and
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Ref.null)
            (=
              ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Snap.unit)))
        (or
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
            $Ref.null)
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
              $Ref.null)))
        (as joined_unfolding@39@10  Bool))))))
(assert (or
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
      $Ref.null))
  (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
(push) ; 9
(set-option :timeout 10)
(assert (not (not
  (and
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
        $Ref.null))
    (<
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
      elem@4@10)))))
(check-sat)
; unknown
(pop) ; 9
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 9
(set-option :timeout 10)
(assert (not (and
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
      $Ref.null))
  (<
    ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
    elem@4@10))))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [then-branch: 49 | First:(Second:($t@29@10)) != Null && First:(First:(Second:(Second:(Second:(Second:($t@29@10)))))) < elem@4@10 | live]
; [else-branch: 49 | !(First:(Second:($t@29@10)) != Null && First:(First:(Second:(Second:(Second:(Second:($t@29@10)))))) < elem@4@10) | live]
(set-option :timeout 0)
(push) ; 9
; [then-branch: 49 | First:(Second:($t@29@10)) != Null && First:(First:(Second:(Second:(Second:(Second:($t@29@10)))))) < elem@4@10]
(assert (and
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
      $Ref.null))
  (<
    ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
    elem@4@10)))
; [exec]
; var ptrn: Ref
(declare-const ptrn@40@10 $Ref)
; [exec]
; unfold acc(lseg(ptr.next, null), write)
; [eval] this != end
(push) ; 10
(set-option :timeout 10)
(assert (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null)))
(check-sat)
; unknown
(pop) ; 10
; 0.01s
; (get-info :all-statistics)
; [then-branch: 50 | First:(Second:($t@29@10)) != Null | live]
; [else-branch: 50 | First:(Second:($t@29@10)) == Null | dead]
(set-option :timeout 0)
(push) ; 10
; [then-branch: 50 | First:(Second:($t@29@10)) != Null]
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
    ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
(push) ; 11
(set-option :timeout 10)
(assert (not (= ptr@28@10 ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))))))
(check-sat)
; unknown
(pop) ; 11
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
    ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
(set-option :timeout 0)
(push) ; 11
(set-option :timeout 10)
(assert (not (= ptr@28@10 ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))))))
(check-sat)
; unknown
(pop) ; 11
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(set-option :timeout 0)
(push) ; 11
(set-option :timeout 10)
(assert (not (and
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10))
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
  (= ptr@28@10 $Ref.null))))
(check-sat)
; unknown
(pop) ; 11
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Snap.unit))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(set-option :timeout 0)
(push) ; 11
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) $Ref.null))
; [eval] this != end
(push) ; 12
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 12
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 12
(set-option :timeout 10)
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null))))
(check-sat)
; unknown
(pop) ; 12
; 0.00s
; (get-info :all-statistics)
; [then-branch: 51 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null | live]
; [else-branch: 51 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null | live]
(set-option :timeout 0)
(push) ; 12
; [then-branch: 51 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null]
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  ($Snap.combine
    ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
    ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
(push) ; 13
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 13
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 13
(set-option :timeout 10)
(assert (not (=
  ptr@28@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 13
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
    ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
(set-option :timeout 0)
(push) ; 13
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 13
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 13
(set-option :timeout 10)
(assert (not (=
  ptr@28@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
(check-sat)
; unknown
(pop) ; 13
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
(set-option :timeout 0)
(push) ; 13
(set-option :timeout 10)
(assert (not (and
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10))
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
  (= ptr@28@10 $Ref.null))))
(check-sat)
; unknown
(pop) ; 13
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
  $Snap.unit))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(set-option :timeout 0)
(push) ; 13
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))) $Ref.null))
; [eval] this != end
(push) ; 14
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 14
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 14
(set-option :timeout 10)
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
    $Ref.null))))
(check-sat)
; unknown
(pop) ; 14
; 0.01s
; (get-info :all-statistics)
; [then-branch: 52 | First:(Second:(First:(Second:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10)))))))))) != Null | live]
; [else-branch: 52 | First:(Second:(First:(Second:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10)))))))))) == Null | live]
(set-option :timeout 0)
(push) ; 14
; [then-branch: 52 | First:(Second:(First:(Second:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10)))))))))) != Null]
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
    $Ref.null)))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
    ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))))
(push) ; 15
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
(check-sat)
; unknown
(pop) ; 15
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 15
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
(check-sat)
; unknown
(pop) ; 15
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 15
(set-option :timeout 10)
(assert (not (=
  ptr@28@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
(check-sat)
; unknown
(pop) ; 15
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
    ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))))
(set-option :timeout 0)
(push) ; 15
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
(check-sat)
; unknown
(pop) ; 15
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 15
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
(check-sat)
; unknown
(pop) ; 15
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 15
(set-option :timeout 10)
(assert (not (=
  ptr@28@10
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
(check-sat)
; unknown
(pop) ; 15
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))))))
(set-option :timeout 0)
(push) ; 15
(set-option :timeout 10)
(assert (not (and
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10))
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))))
  (= ptr@28@10 $Ref.null))))
(check-sat)
; unknown
(pop) ; 15
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
  $Snap.unit))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(declare-const recunf@41@10 Bool)
(assert (as recunf@41@10  Bool))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(set-option :timeout 0)
(push) ; 15
(push) ; 16
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 16
; 0.01s
; (get-info :all-statistics)
; [then-branch: 53 | First:(Second:(First:(Second:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10)))))))))) != Null | live]
; [else-branch: 53 | First:(Second:(First:(Second:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10)))))))))) == Null | dead]
(set-option :timeout 0)
(push) ; 16
; [then-branch: 53 | First:(Second:(First:(Second:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10)))))))))) != Null]
; [eval] this.data <= this.next.data
(pop) ; 16
(pop) ; 15
; Joined path conditions
(pop) ; 14
(push) ; 14
; [else-branch: 52 | First:(Second:(First:(Second:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10)))))))))) == Null]
(assert (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
  $Ref.null))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
  $Snap.unit))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(push) ; 15
; [then-branch: 54 | First:(Second:(First:(Second:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10)))))))))) != Null | dead]
; [else-branch: 54 | First:(Second:(First:(Second:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10)))))))))) == Null | live]
(push) ; 16
; [else-branch: 54 | First:(Second:(First:(Second:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10)))))))))) == Null]
(pop) ; 16
(pop) ; 15
; Joined path conditions
(pop) ; 14
(pop) ; 13
(declare-const joined_unfolding@42@10 Bool)
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
      $Ref.null))
  (=
    (as joined_unfolding@42@10  Bool)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
          $Ref.null))
      (<=
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))))))
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
    $Ref.null)
  (= (as joined_unfolding@42@10  Bool) true)))
; Joined path conditions
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))) $Ref.null))
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
      $Ref.null))
  (and
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
        $Ref.null))
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
      ($Snap.combine
        ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
        ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
    (=
      ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
        ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
        ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
      $Snap.unit)
    (as recunf@41@10  Bool))))
; Joined path conditions
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
    $Ref.null)
  (and
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
      $Ref.null)
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
      $Snap.unit))))
(assert (or
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
    $Ref.null)
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
      $Ref.null))))
(assert (as joined_unfolding@42@10  Bool))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(push) ; 13
(push) ; 14
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Ref.null)))
(check-sat)
; unknown
(pop) ; 14
; 0.01s
; (get-info :all-statistics)
; [then-branch: 55 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null | live]
; [else-branch: 55 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null | dead]
(set-option :timeout 0)
(push) ; 14
; [then-branch: 55 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null]
; [eval] this.data <= this.next.data
(pop) ; 14
(pop) ; 13
; Joined path conditions
(pop) ; 12
(push) ; 12
; [else-branch: 51 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null]
(assert (=
  ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Ref.null))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
  $Snap.unit))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(push) ; 13
; [then-branch: 56 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) != Null | dead]
; [else-branch: 56 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null | live]
(push) ; 14
; [else-branch: 56 | First:(Second:(First:(Second:(Second:(Second:(Second:($t@29@10))))))) == Null]
(pop) ; 14
(pop) ; 13
; Joined path conditions
(pop) ; 12
(pop) ; 11
(declare-const joined_unfolding@43@10 Bool)
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null))
  (=
    (as joined_unfolding@43@10  Bool)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
          $Ref.null))
      (<=
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))))
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)
  (= (as joined_unfolding@43@10  Bool) true)))
; Joined path conditions
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))) $Ref.null))
(assert (=>
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null))
  (and
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
        $Ref.null))
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      ($Snap.combine
        ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
        ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
    (=
      ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
        ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
        ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
    (=
      ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
      $Snap.unit)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
          $Ref.null))
      (=
        (as joined_unfolding@42@10  Bool)
        (=>
          (not
            (=
              ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
              $Ref.null))
          (<=
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))))))
    (=>
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
        $Ref.null)
      (= (as joined_unfolding@42@10  Bool) true))
    (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))) $Ref.null)
    (=>
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
          $Ref.null))
      (and
        (not
          (=
            ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
            $Ref.null))
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
          ($Snap.combine
            ($Snap.first ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
            ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
        (=
          ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
            ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
            ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))))
        (=
          ($Snap.second ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))))))))
          $Snap.unit)
        (as recunf@41@10  Bool)))
    (=>
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
        $Ref.null)
      (and
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
          $Ref.null)
        (=
          ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
          $Snap.unit)))
    (or
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
        $Ref.null)
      (not
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10)))))))))))
          $Ref.null)))
    (as joined_unfolding@42@10  Bool))))
; Joined path conditions
(assert (=>
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)
  (and
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null)
    (=
      ($Snap.first ($Snap.second ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Snap.unit))))
(assert (or
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    $Ref.null)
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
      $Ref.null))))
(assert (as joined_unfolding@43@10  Bool))
; State saturation: after unfold
(set-option :timeout 40)
(check-sat)
; unknown
(assert (lseg%trigger ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))) ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) $Ref.null))
; [exec]
; index := index + 1
; [eval] index + 1
(declare-const index@44@10 Int)
(assert (= index@44@10 (+ index@26@10 1)))
; [exec]
; ptrn := ptr.next
(declare-const ptrn@45@10 $Ref)
(assert (= ptrn@45@10 ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10)))))
; [exec]
; fold acc(lseg(ptrn, ptrn), write)
; [eval] this != end
; [then-branch: 57 | False | dead]
; [else-branch: 57 | True | live]
(set-option :timeout 0)
(push) ; 11
; [else-branch: 57 | True]
(assert (lseg%trigger $Snap.unit ptrn@45@10 ptrn@45@10))
(push) ; 12
(set-option :timeout 10)
(assert (not (and
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    ptrn@45@10)
  (= $Ref.null ptrn@45@10))))
(check-sat)
; unknown
(pop) ; 12
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 12
(set-option :timeout 10)
(assert (not (and
  (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptrn@45@10)
  (= ptr@28@10 ptrn@45@10))))
(check-sat)
; unknown
(pop) ; 12
; 0.01s
; (get-info :all-statistics)
; [exec]
; fold acc(lseg(ptr, ptrn), write)
; [eval] this != end
(set-option :timeout 0)
(push) ; 12
(set-option :timeout 10)
(assert (not (= ptr@28@10 ptrn@45@10)))
(check-sat)
; unknown
(pop) ; 12
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 12
(set-option :timeout 10)
(assert (not (not (= ptr@28@10 ptrn@45@10))))
(check-sat)
; unknown
(pop) ; 12
; 0.00s
; (get-info :all-statistics)
; [then-branch: 58 | ptr@28@10 != ptrn@45@10 | live]
; [else-branch: 58 | ptr@28@10 == ptrn@45@10 | live]
(set-option :timeout 0)
(push) ; 12
; [then-branch: 58 | ptr@28@10 != ptrn@45@10]
(assert (not (= ptr@28@10 ptrn@45@10)))
; [eval] (unfolding acc(lseg(this.next, end), write) in this.next != end ==> this.data <= this.next.data)
(push) ; 13
(assert (lseg%trigger $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) ptrn@45@10))
; [eval] this != end
(push) ; 14
(set-option :timeout 10)
(assert (not (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) ptrn@45@10)))
(check-sat)
; unsat
(pop) ; 14
; 0.00s
; (get-info :all-statistics)
; [then-branch: 59 | First:(Second:($t@29@10)) != ptrn@45@10 | dead]
; [else-branch: 59 | First:(Second:($t@29@10)) == ptrn@45@10 | live]
(set-option :timeout 0)
(push) ; 14
; [else-branch: 59 | First:(Second:($t@29@10)) == ptrn@45@10]
(assert (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) ptrn@45@10))
; [eval] this.next != end ==> this.data <= this.next.data
; [eval] this.next != end
(push) ; 15
; [then-branch: 60 | First:(Second:($t@29@10)) != ptrn@45@10 | dead]
; [else-branch: 60 | First:(Second:($t@29@10)) == ptrn@45@10 | live]
(push) ; 16
; [else-branch: 60 | First:(Second:($t@29@10)) == ptrn@45@10]
(pop) ; 16
(pop) ; 15
; Joined path conditions
(pop) ; 14
(pop) ; 13
; Joined path conditions
(assert (lseg%trigger $Snap.unit ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) ptrn@45@10))
(assert (= ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second $t@29@10))) ptrn@45@10))
(assert (lseg%trigger ($Snap.combine
  ($Snap.first ($Snap.second ($Snap.second $t@29@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second $t@29@10))
    ($Snap.combine $Snap.unit $Snap.unit))) ptr@28@10 ptrn@45@10))
(push) ; 13
(set-option :timeout 10)
(assert (not (and
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.first ($Snap.second ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@29@10))))))))
    ptr@28@10)
  (= $Ref.null ptrn@45@10))))
(check-sat)
; unknown
(pop) ; 13
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 13
(set-option :timeout 10)
(assert (not (and
  (= ($SortWrappers.$SnapTo$Ref ($Snap.first $t@29@10)) ptr@28@10)
  (= ptr@28@10 ptrn@45@10))))
(check-sat)
; unknown
(pop) ; 13
; 0.01s
; (get-info :all-statistics)
; [exec]
; concat(this.head, ptr, ptrn)
; [eval] end != null
(set-option :timeout 0)
(push) ; 13
(set-option :timeout 10)
(assert (not (= ptrn@45@10 $Ref.null)))
(check-sat)
; unknown
(pop) ; 13
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 13
(set-option :timeout 10)
(assert (not (not (= ptrn@45@10 $Ref.null))))
(check-sat)
; unsat
(pop) ; 13
; 0.00s
; (get-info :all-statistics)
; [then-branch: 61 | ptrn@45@10 != Null | live]
; [else-branch: 61 | ptrn@45@10 == Null | dead]
(set-option :timeout 0)
(push) ; 13
; [then-branch: 61 | ptrn@45@10 != Null]
(assert (not (= ptrn@45@10 $Ref.null)))
(push) ; 14
(set-option :timeout 10)
(assert (not false))
(check-sat)
; unknown
(pop) ; 14
; 0.01s
; (get-info :all-statistics)
; [eval] 0 < |contentNodes(this, ptr)| && 0 < |contentNodes(ptr, end)| ==> contentNodes(this, ptr)[|contentNodes(this, ptr)| - 1] <= contentNodes(ptr, end)[0]
; [eval] 0 < |contentNodes(this, ptr)| && 0 < |contentNodes(ptr, end)|
; [eval] 0 < |contentNodes(this, ptr)|
