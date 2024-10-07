(get-info :version)
; (:version "4.13.0")
; Started: 2024-09-24 15:27:15
; Silicon.version: 1.1-SNAPSHOT (b737e366)
; Input file: /Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr
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
(declare-sort Set<$Snap> 0)
(declare-sort IArray 0)
(declare-sort $FVF<val> 0)
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
(declare-fun $SortWrappers.IArrayTo$Snap (IArray) $Snap)
(declare-fun $SortWrappers.$SnapToIArray ($Snap) IArray)
(assert (forall ((x IArray)) (!
    (= x ($SortWrappers.$SnapToIArray($SortWrappers.IArrayTo$Snap x)))
    :pattern (($SortWrappers.IArrayTo$Snap x))
    :qid |$Snap.$SnapToIArrayTo$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.IArrayTo$Snap($SortWrappers.$SnapToIArray x)))
    :pattern (($SortWrappers.$SnapToIArray x))
    :qid |$Snap.IArrayTo$SnapToIArray|
    )))
; Declaring additional sort wrappers
(declare-fun $SortWrappers.$FVF<val>To$Snap ($FVF<val>) $Snap)
(declare-fun $SortWrappers.$SnapTo$FVF<val> ($Snap) $FVF<val>)
(assert (forall ((x $FVF<val>)) (!
    (= x ($SortWrappers.$SnapTo$FVF<val>($SortWrappers.$FVF<val>To$Snap x)))
    :pattern (($SortWrappers.$FVF<val>To$Snap x))
    :qid |$Snap.$SnapTo$FVF<val>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.$FVF<val>To$Snap($SortWrappers.$SnapTo$FVF<val> x)))
    :pattern (($SortWrappers.$SnapTo$FVF<val> x))
    :qid |$Snap.$FVF<val>To$SnapTo$FVF<val>|
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
(declare-fun loc<Ref> (IArray Int) $Ref)
(declare-fun len<Int> (IArray) Int)
(declare-fun first<IArray> ($Ref) IArray)
(declare-fun second<Int> ($Ref) Int)
; /field_value_functions_declarations.smt2 [val: Int]
(declare-fun $FVF.domain_val ($FVF<val>) Set<$Ref>)
(declare-fun $FVF.lookup_val ($FVF<val> $Ref) Int)
(declare-fun $FVF.after_val ($FVF<val> $FVF<val>) Bool)
(declare-fun $FVF.loc_val (Int $Ref) Bool)
(declare-fun $FVF.perm_val ($FPM $Ref) $Perm)
(declare-const $fvfTOP_val $FVF<val>)
; Declaring symbols related to program functions (from program analysis)
(declare-fun dummy ($Snap Int) Bool)
(declare-fun dummy%limited ($Snap Int) Bool)
(declare-fun dummy%stateless (Int) Bool)
(declare-fun dummy%precondition ($Snap Int) Bool)
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
(assert (forall ((a IArray) (i Int)) (!
  (and (= (first<IArray> (loc<Ref> a i)) a) (= (second<Int> (loc<Ref> a i)) i))
  :pattern ((loc<Ref> a i))
  :qid |prog.all_diff|)))
(assert (forall ((a IArray)) (!
  (>= (len<Int> a) 0)
  :pattern ((len<Int> a))
  :qid |prog.length_nonneg|)))
; /field_value_functions_axioms.smt2 [val: Int]
(assert (forall ((vs $FVF<val>) (ws $FVF<val>)) (!
    (=>
      (and
        (Set_equal ($FVF.domain_val vs) ($FVF.domain_val ws))
        (forall ((x $Ref)) (!
          (=>
            (Set_in x ($FVF.domain_val vs))
            (= ($FVF.lookup_val vs x) ($FVF.lookup_val ws x)))
          :pattern (($FVF.lookup_val vs x) ($FVF.lookup_val ws x))
          :qid |qp.$FVF<val>-eq-inner|
          )))
      (= vs ws))
    :pattern (($SortWrappers.$FVF<val>To$Snap vs)
              ($SortWrappers.$FVF<val>To$Snap ws)
              )
    :qid |qp.$FVF<val>-eq-outer|
    )))
(assert (forall ((r $Ref) (pm $FPM)) (!
    ($Perm.isValidVar ($FVF.perm_val pm r))
    :pattern (($FVF.perm_val pm r)))))
(assert (forall ((r $Ref) (f Int)) (!
    (= ($FVF.loc_val f r) true)
    :pattern (($FVF.loc_val f r)))))
; End preamble
; ------------------------------------------------------------
; State saturation: after preamble
(set-option :timeout 100)
(check-sat)
; unknown
; ------------------------------------------------------------
; Begin function- and predicate-related preamble
; Declaring symbols related to program functions (from verification)
(assert (forall ((s@$ $Snap) (i@0@00 Int)) (!
  (= (dummy%limited s@$ i@0@00) (dummy s@$ i@0@00))
  :pattern ((dummy s@$ i@0@00))
  :qid |quant-u-0|)))
(assert (forall ((s@$ $Snap) (i@0@00 Int)) (!
  (dummy%stateless i@0@00)
  :pattern ((dummy%limited s@$ i@0@00))
  :qid |quant-u-1|)))
(assert (forall ((s@$ $Snap) (i@0@00 Int)) (!
  (=> (dummy%precondition s@$ i@0@00) (= (dummy s@$ i@0@00) true))
  :pattern ((dummy s@$ i@0@00))
  :qid |quant-u-2|)))
(assert (forall ((s@$ $Snap) (i@0@00 Int)) (!
  true
  :pattern ((dummy s@$ i@0@00))
  :qid |quant-u-3|)))
; End function- and predicate-related preamble
; ------------------------------------------------------------
; ---------- select_rec ----------
(declare-const a@0@10 IArray)
(declare-const left@1@10 Int)
(declare-const right@2@10 Int)
(declare-const n@3@10 Int)
(declare-const storeIndex@4@10 Int)
(declare-const pw@5@10 Seq<Int>)
(declare-const a@6@10 IArray)
(declare-const left@7@10 Int)
(declare-const right@8@10 Int)
(declare-const n@9@10 Int)
(declare-const storeIndex@10@10 Int)
(declare-const pw@11@10 Seq<Int>)
(set-option :timeout 0)
(push) ; 1
(declare-const $t@12@10 $Snap)
(assert (= $t@12@10 ($Snap.combine ($Snap.first $t@12@10) ($Snap.second $t@12@10))))
(assert (= ($Snap.first $t@12@10) $Snap.unit))
; [eval] 0 <= left
(assert (<= 0 left@7@10))
(assert (=
  ($Snap.second $t@12@10)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@12@10))
    ($Snap.second ($Snap.second $t@12@10)))))
(assert (= ($Snap.first ($Snap.second $t@12@10)) $Snap.unit))
; [eval] left <= right
(assert (<= left@7@10 right@8@10))
(assert (=
  ($Snap.second ($Snap.second $t@12@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@12@10)))
    ($Snap.second ($Snap.second ($Snap.second $t@12@10))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@12@10))) $Snap.unit))
; [eval] right < len(a)
; [eval] len(a)
(assert (< right@8@10 (len<Int> a@6@10)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@12@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@12@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@12@10))))
  $Snap.unit))
; [eval] left <= n
(assert (<= left@7@10 n@9@10))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))
  $Snap.unit))
; [eval] n <= right
(assert (<= n@9@10 right@8@10))
(declare-const i@13@10 Int)
(push) ; 2
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 3
; [then-branch: 0 | !(left@7@10 <= i@13@10) | live]
; [else-branch: 0 | left@7@10 <= i@13@10 | live]
(push) ; 4
; [then-branch: 0 | !(left@7@10 <= i@13@10)]
(assert (not (<= left@7@10 i@13@10)))
(pop) ; 4
(push) ; 4
; [else-branch: 0 | left@7@10 <= i@13@10]
(assert (<= left@7@10 i@13@10))
; [eval] i <= right
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@13@10) (not (<= left@7@10 i@13@10))))
(assert (and (<= left@7@10 i@13@10) (<= i@13@10 right@8@10)))
; [eval] loc(a, i)
(pop) ; 2
(declare-fun inv@14@10 ($Ref) Int)
(declare-fun img@15@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@13@10 Int)) (!
  (=>
    (and (<= left@7@10 i@13@10) (<= i@13@10 right@8@10))
    (or (<= left@7@10 i@13@10) (not (<= left@7@10 i@13@10))))
  :pattern ((loc<Ref> a@6@10 i@13@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 2
(assert (not (forall ((i1@13@10 Int) (i2@13@10 Int)) (!
  (=>
    (and
      (and (<= left@7@10 i1@13@10) (<= i1@13@10 right@8@10))
      (and (<= left@7@10 i2@13@10) (<= i2@13@10 right@8@10))
      (= (loc<Ref> a@6@10 i1@13@10) (loc<Ref> a@6@10 i2@13@10)))
    (= i1@13@10 i2@13@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 2
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@13@10 Int)) (!
  (=>
    (and (<= left@7@10 i@13@10) (<= i@13@10 right@8@10))
    (and
      (= (inv@14@10 (loc<Ref> a@6@10 i@13@10)) i@13@10)
      (img@15@10 (loc<Ref> a@6@10 i@13@10))))
  :pattern ((loc<Ref> a@6@10 i@13@10))
  :qid |quant-u-9|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@15@10 r)
      (and (<= left@7@10 (inv@14@10 r)) (<= (inv@14@10 r) right@8@10)))
    (= (loc<Ref> a@6@10 (inv@14@10 r)) r))
  :pattern ((inv@14@10 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@13@10 Int)) (!
  (=>
    (and (<= left@7@10 i@13@10) (<= i@13@10 right@8@10))
    (not (= (loc<Ref> a@6@10 i@13@10) $Ref.null)))
  :pattern ((loc<Ref> a@6@10 i@13@10))
  :qid |val-permImpliesNonNull|)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
(set-option :timeout 0)
(push) ; 2
(declare-const $t@16@10 $Snap)
(assert (= $t@16@10 ($Snap.combine ($Snap.first $t@16@10) ($Snap.second $t@16@10))))
(assert (= ($Snap.first $t@16@10) $Snap.unit))
; [eval] left <= storeIndex
(assert (<= left@7@10 storeIndex@10@10))
(assert (=
  ($Snap.second $t@16@10)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@16@10))
    ($Snap.second ($Snap.second $t@16@10)))))
(assert (= ($Snap.first ($Snap.second $t@16@10)) $Snap.unit))
; [eval] storeIndex <= right
(assert (<= storeIndex@10@10 right@8@10))
(assert (=
  ($Snap.second ($Snap.second $t@16@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@16@10)))
    ($Snap.second ($Snap.second ($Snap.second $t@16@10))))))
(declare-const i@17@10 Int)
(push) ; 3
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 4
; [then-branch: 1 | !(left@7@10 <= i@17@10) | live]
; [else-branch: 1 | left@7@10 <= i@17@10 | live]
(push) ; 5
; [then-branch: 1 | !(left@7@10 <= i@17@10)]
(assert (not (<= left@7@10 i@17@10)))
(pop) ; 5
(push) ; 5
; [else-branch: 1 | left@7@10 <= i@17@10]
(assert (<= left@7@10 i@17@10))
; [eval] i <= right
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@17@10) (not (<= left@7@10 i@17@10))))
(assert (and (<= left@7@10 i@17@10) (<= i@17@10 right@8@10)))
; [eval] loc(a, i)
(pop) ; 3
(declare-fun inv@18@10 ($Ref) Int)
(declare-fun img@19@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@17@10 Int)) (!
  (=>
    (and (<= left@7@10 i@17@10) (<= i@17@10 right@8@10))
    (or (<= left@7@10 i@17@10) (not (<= left@7@10 i@17@10))))
  :pattern ((loc<Ref> a@6@10 i@17@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((i1@17@10 Int) (i2@17@10 Int)) (!
  (=>
    (and
      (and (<= left@7@10 i1@17@10) (<= i1@17@10 right@8@10))
      (and (<= left@7@10 i2@17@10) (<= i2@17@10 right@8@10))
      (= (loc<Ref> a@6@10 i1@17@10) (loc<Ref> a@6@10 i2@17@10)))
    (= i1@17@10 i2@17@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@17@10 Int)) (!
  (=>
    (and (<= left@7@10 i@17@10) (<= i@17@10 right@8@10))
    (and
      (= (inv@18@10 (loc<Ref> a@6@10 i@17@10)) i@17@10)
      (img@19@10 (loc<Ref> a@6@10 i@17@10))))
  :pattern ((loc<Ref> a@6@10 i@17@10))
  :qid |quant-u-12|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@19@10 r)
      (and (<= left@7@10 (inv@18@10 r)) (<= (inv@18@10 r) right@8@10)))
    (= (loc<Ref> a@6@10 (inv@18@10 r)) r))
  :pattern ((inv@18@10 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@17@10 Int)) (!
  (=>
    (and (<= left@7@10 i@17@10) (<= i@17@10 right@8@10))
    (not (= (loc<Ref> a@6@10 i@17@10) $Ref.null)))
  :pattern ((loc<Ref> a@6@10 i@17@10))
  :qid |val-permImpliesNonNull|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@16@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@16@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@16@10))))
  $Snap.unit))
; [eval] storeIndex == n
(assert (= storeIndex@10@10 n@9@10))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10)))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val)
(declare-const i@20@10 Int)
(push) ; 3
; [eval] left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val
; [eval] left <= i && i < storeIndex
; [eval] left <= i
(push) ; 4
; [then-branch: 2 | !(left@7@10 <= i@20@10) | live]
; [else-branch: 2 | left@7@10 <= i@20@10 | live]
(push) ; 5
; [then-branch: 2 | !(left@7@10 <= i@20@10)]
(assert (not (<= left@7@10 i@20@10)))
(pop) ; 5
(push) ; 5
; [else-branch: 2 | left@7@10 <= i@20@10]
(assert (<= left@7@10 i@20@10))
; [eval] i < storeIndex
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@20@10) (not (<= left@7@10 i@20@10))))
(push) ; 4
; [then-branch: 3 | left@7@10 <= i@20@10 && i@20@10 < storeIndex@10@10 | live]
; [else-branch: 3 | !(left@7@10 <= i@20@10 && i@20@10 < storeIndex@10@10) | live]
(push) ; 5
; [then-branch: 3 | left@7@10 <= i@20@10 && i@20@10 < storeIndex@10@10]
(assert (and (<= left@7@10 i@20@10) (< i@20@10 storeIndex@10@10)))
; [eval] loc(a, i).val <= loc(a, storeIndex).val
; [eval] loc(a, i)
(push) ; 6
(assert (not (and
  (img@19@10 (loc<Ref> a@6@10 i@20@10))
  (and
    (<= left@7@10 (inv@18@10 (loc<Ref> a@6@10 i@20@10)))
    (<= (inv@18@10 (loc<Ref> a@6@10 i@20@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, storeIndex)
(push) ; 6
(assert (not (and
  (img@19@10 (loc<Ref> a@6@10 storeIndex@10@10))
  (and
    (<= left@7@10 (inv@18@10 (loc<Ref> a@6@10 storeIndex@10@10)))
    (<= (inv@18@10 (loc<Ref> a@6@10 storeIndex@10@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 3 | !(left@7@10 <= i@20@10 && i@20@10 < storeIndex@10@10)]
(assert (not (and (<= left@7@10 i@20@10) (< i@20@10 storeIndex@10@10))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@20@10) (< i@20@10 storeIndex@10@10)))
  (and (<= left@7@10 i@20@10) (< i@20@10 storeIndex@10@10))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@20@10 Int)) (!
  (and
    (or (<= left@7@10 i@20@10) (not (<= left@7@10 i@20@10)))
    (or
      (not (and (<= left@7@10 i@20@10) (< i@20@10 storeIndex@10@10)))
      (and (<= left@7@10 i@20@10) (< i@20@10 storeIndex@10@10))))
  :pattern ((loc<Ref> a@6@10 i@20@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100-aux|)))
(assert (forall ((i@20@10 Int)) (!
  (=>
    (and (<= left@7@10 i@20@10) (< i@20@10 storeIndex@10@10))
    (<=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@16@10)))) (loc<Ref> a@6@10 i@20@10))
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@16@10)))) (loc<Ref> a@6@10 storeIndex@10@10))))
  :pattern ((loc<Ref> a@6@10 i@20@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10))))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val)
(declare-const i@21@10 Int)
(push) ; 3
; [eval] storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val
; [eval] storeIndex < i && i <= right
; [eval] storeIndex < i
(push) ; 4
; [then-branch: 4 | !(storeIndex@10@10 < i@21@10) | live]
; [else-branch: 4 | storeIndex@10@10 < i@21@10 | live]
(push) ; 5
; [then-branch: 4 | !(storeIndex@10@10 < i@21@10)]
(assert (not (< storeIndex@10@10 i@21@10)))
(pop) ; 5
(push) ; 5
; [else-branch: 4 | storeIndex@10@10 < i@21@10]
(assert (< storeIndex@10@10 i@21@10))
; [eval] i <= right
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (< storeIndex@10@10 i@21@10) (not (< storeIndex@10@10 i@21@10))))
(push) ; 4
; [then-branch: 5 | storeIndex@10@10 < i@21@10 && i@21@10 <= right@8@10 | live]
; [else-branch: 5 | !(storeIndex@10@10 < i@21@10 && i@21@10 <= right@8@10) | live]
(push) ; 5
; [then-branch: 5 | storeIndex@10@10 < i@21@10 && i@21@10 <= right@8@10]
(assert (and (< storeIndex@10@10 i@21@10) (<= i@21@10 right@8@10)))
; [eval] loc(a, storeIndex).val <= loc(a, i).val
; [eval] loc(a, storeIndex)
(push) ; 6
(assert (not (and
  (img@19@10 (loc<Ref> a@6@10 storeIndex@10@10))
  (and
    (<= left@7@10 (inv@18@10 (loc<Ref> a@6@10 storeIndex@10@10)))
    (<= (inv@18@10 (loc<Ref> a@6@10 storeIndex@10@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, i)
(push) ; 6
(assert (not (and
  (img@19@10 (loc<Ref> a@6@10 i@21@10))
  (and
    (<= left@7@10 (inv@18@10 (loc<Ref> a@6@10 i@21@10)))
    (<= (inv@18@10 (loc<Ref> a@6@10 i@21@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 5 | !(storeIndex@10@10 < i@21@10 && i@21@10 <= right@8@10)]
(assert (not (and (< storeIndex@10@10 i@21@10) (<= i@21@10 right@8@10))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (< storeIndex@10@10 i@21@10) (<= i@21@10 right@8@10)))
  (and (< storeIndex@10@10 i@21@10) (<= i@21@10 right@8@10))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@21@10 Int)) (!
  (and
    (or (< storeIndex@10@10 i@21@10) (not (< storeIndex@10@10 i@21@10)))
    (or
      (not (and (< storeIndex@10@10 i@21@10) (<= i@21@10 right@8@10)))
      (and (< storeIndex@10@10 i@21@10) (<= i@21@10 right@8@10))))
  :pattern ((loc<Ref> a@6@10 i@21@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@146@11@146@100-aux|)))
(assert (forall ((i@21@10 Int)) (!
  (=>
    (and (< storeIndex@10@10 i@21@10) (<= i@21@10 right@8@10))
    (<=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@16@10)))) (loc<Ref> a@6@10 storeIndex@10@10))
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@16@10)))) (loc<Ref> a@6@10 i@21@10))))
  :pattern ((loc<Ref> a@6@10 i@21@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@146@11@146@100|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10)))))))
  $Snap.unit))
; [eval] |pw| == right + 1
; [eval] |pw|
; [eval] right + 1
(assert (= (Seq_length pw@11@10) (+ right@8@10 1)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> left <= pw[i] && pw[i] <= right)
(declare-const i@22@10 Int)
(push) ; 3
; [eval] left <= i && i <= right ==> left <= pw[i] && pw[i] <= right
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 4
; [then-branch: 6 | !(left@7@10 <= i@22@10) | live]
; [else-branch: 6 | left@7@10 <= i@22@10 | live]
(push) ; 5
; [then-branch: 6 | !(left@7@10 <= i@22@10)]
(assert (not (<= left@7@10 i@22@10)))
(pop) ; 5
(push) ; 5
; [else-branch: 6 | left@7@10 <= i@22@10]
(assert (<= left@7@10 i@22@10))
; [eval] i <= right
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@22@10) (not (<= left@7@10 i@22@10))))
(push) ; 4
; [then-branch: 7 | left@7@10 <= i@22@10 && i@22@10 <= right@8@10 | live]
; [else-branch: 7 | !(left@7@10 <= i@22@10 && i@22@10 <= right@8@10) | live]
(push) ; 5
; [then-branch: 7 | left@7@10 <= i@22@10 && i@22@10 <= right@8@10]
(assert (and (<= left@7@10 i@22@10) (<= i@22@10 right@8@10)))
; [eval] left <= pw[i] && pw[i] <= right
; [eval] left <= pw[i]
; [eval] pw[i]
(push) ; 6
(assert (not (>= i@22@10 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (< i@22@10 (Seq_length pw@11@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
; [then-branch: 8 | !(left@7@10 <= pw@11@10[i@22@10]) | live]
; [else-branch: 8 | left@7@10 <= pw@11@10[i@22@10] | live]
(push) ; 7
; [then-branch: 8 | !(left@7@10 <= pw@11@10[i@22@10])]
(assert (not (<= left@7@10 (Seq_index pw@11@10 i@22@10))))
(pop) ; 7
(push) ; 7
; [else-branch: 8 | left@7@10 <= pw@11@10[i@22@10]]
(assert (<= left@7@10 (Seq_index pw@11@10 i@22@10)))
; [eval] pw[i] <= right
; [eval] pw[i]
(push) ; 8
(assert (not (>= i@22@10 0)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(push) ; 8
(assert (not (< i@22@10 (Seq_length pw@11@10))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or
  (<= left@7@10 (Seq_index pw@11@10 i@22@10))
  (not (<= left@7@10 (Seq_index pw@11@10 i@22@10)))))
(pop) ; 5
(push) ; 5
; [else-branch: 7 | !(left@7@10 <= i@22@10 && i@22@10 <= right@8@10)]
(assert (not (and (<= left@7@10 i@22@10) (<= i@22@10 right@8@10))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (=>
  (and (<= left@7@10 i@22@10) (<= i@22@10 right@8@10))
  (and
    (<= left@7@10 i@22@10)
    (<= i@22@10 right@8@10)
    (or
      (<= left@7@10 (Seq_index pw@11@10 i@22@10))
      (not (<= left@7@10 (Seq_index pw@11@10 i@22@10)))))))
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@22@10) (<= i@22@10 right@8@10)))
  (and (<= left@7@10 i@22@10) (<= i@22@10 right@8@10))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@22@10 Int)) (!
  (and
    (or (<= left@7@10 i@22@10) (not (<= left@7@10 i@22@10)))
    (=>
      (and (<= left@7@10 i@22@10) (<= i@22@10 right@8@10))
      (and
        (<= left@7@10 i@22@10)
        (<= i@22@10 right@8@10)
        (or
          (<= left@7@10 (Seq_index pw@11@10 i@22@10))
          (not (<= left@7@10 (Seq_index pw@11@10 i@22@10))))))
    (or
      (not (and (<= left@7@10 i@22@10) (<= i@22@10 right@8@10)))
      (and (<= left@7@10 i@22@10) (<= i@22@10 right@8@10))))
  :pattern ((Seq_index pw@11@10 i@22@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@149@11@149@87-aux|)))
(assert (forall ((i@22@10 Int)) (!
  (=>
    (and (<= left@7@10 i@22@10) (<= i@22@10 right@8@10))
    (and
      (<= left@7@10 (Seq_index pw@11@10 i@22@10))
      (<= (Seq_index pw@11@10 i@22@10) right@8@10)))
  :pattern ((Seq_index pw@11@10 i@22@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@149@11@149@87|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10)))))))))
  $Snap.unit))
; [eval] (forall i: Int, j: Int :: { pw[i], pw[j] } left <= i && (i < j && j <= right) ==> pw[i] != pw[j])
(declare-const i@23@10 Int)
(declare-const j@24@10 Int)
(push) ; 3
; [eval] left <= i && (i < j && j <= right) ==> pw[i] != pw[j]
; [eval] left <= i && (i < j && j <= right)
; [eval] left <= i
(push) ; 4
; [then-branch: 9 | !(left@7@10 <= i@23@10) | live]
; [else-branch: 9 | left@7@10 <= i@23@10 | live]
(push) ; 5
; [then-branch: 9 | !(left@7@10 <= i@23@10)]
(assert (not (<= left@7@10 i@23@10)))
(pop) ; 5
(push) ; 5
; [else-branch: 9 | left@7@10 <= i@23@10]
(assert (<= left@7@10 i@23@10))
; [eval] i < j
(push) ; 6
; [then-branch: 10 | !(i@23@10 < j@24@10) | live]
; [else-branch: 10 | i@23@10 < j@24@10 | live]
(push) ; 7
; [then-branch: 10 | !(i@23@10 < j@24@10)]
(assert (not (< i@23@10 j@24@10)))
(pop) ; 7
(push) ; 7
; [else-branch: 10 | i@23@10 < j@24@10]
(assert (< i@23@10 j@24@10))
; [eval] j <= right
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (< i@23@10 j@24@10) (not (< i@23@10 j@24@10))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= left@7@10 i@23@10)
  (and (<= left@7@10 i@23@10) (or (< i@23@10 j@24@10) (not (< i@23@10 j@24@10))))))
(assert (or (<= left@7@10 i@23@10) (not (<= left@7@10 i@23@10))))
(push) ; 4
; [then-branch: 11 | left@7@10 <= i@23@10 && i@23@10 < j@24@10 && j@24@10 <= right@8@10 | live]
; [else-branch: 11 | !(left@7@10 <= i@23@10 && i@23@10 < j@24@10 && j@24@10 <= right@8@10) | live]
(push) ; 5
; [then-branch: 11 | left@7@10 <= i@23@10 && i@23@10 < j@24@10 && j@24@10 <= right@8@10]
(assert (and (<= left@7@10 i@23@10) (and (< i@23@10 j@24@10) (<= j@24@10 right@8@10))))
; [eval] pw[i] != pw[j]
; [eval] pw[i]
(push) ; 6
(assert (not (>= i@23@10 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (< i@23@10 (Seq_length pw@11@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] pw[j]
(push) ; 6
(assert (not (>= j@24@10 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (< j@24@10 (Seq_length pw@11@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 11 | !(left@7@10 <= i@23@10 && i@23@10 < j@24@10 && j@24@10 <= right@8@10)]
(assert (not
  (and (<= left@7@10 i@23@10) (and (< i@23@10 j@24@10) (<= j@24@10 right@8@10)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (=>
  (and (<= left@7@10 i@23@10) (and (< i@23@10 j@24@10) (<= j@24@10 right@8@10)))
  (and (<= left@7@10 i@23@10) (< i@23@10 j@24@10) (<= j@24@10 right@8@10))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= left@7@10 i@23@10)
      (and (< i@23@10 j@24@10) (<= j@24@10 right@8@10))))
  (and (<= left@7@10 i@23@10) (and (< i@23@10 j@24@10) (<= j@24@10 right@8@10)))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@23@10 Int) (j@24@10 Int)) (!
  (and
    (=>
      (<= left@7@10 i@23@10)
      (and
        (<= left@7@10 i@23@10)
        (or (< i@23@10 j@24@10) (not (< i@23@10 j@24@10)))))
    (or (<= left@7@10 i@23@10) (not (<= left@7@10 i@23@10)))
    (=>
      (and
        (<= left@7@10 i@23@10)
        (and (< i@23@10 j@24@10) (<= j@24@10 right@8@10)))
      (and (<= left@7@10 i@23@10) (< i@23@10 j@24@10) (<= j@24@10 right@8@10)))
    (or
      (not
        (and
          (<= left@7@10 i@23@10)
          (and (< i@23@10 j@24@10) (<= j@24@10 right@8@10))))
      (and
        (<= left@7@10 i@23@10)
        (and (< i@23@10 j@24@10) (<= j@24@10 right@8@10)))))
  :pattern ((Seq_index pw@11@10 i@23@10) (Seq_index pw@11@10 j@24@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@150@11@150@87-aux|)))
(assert (forall ((i@23@10 Int) (j@24@10 Int)) (!
  (=>
    (and
      (<= left@7@10 i@23@10)
      (and (< i@23@10 j@24@10) (<= j@24@10 right@8@10)))
    (not (= (Seq_index pw@11@10 i@23@10) (Seq_index pw@11@10 j@24@10))))
  :pattern ((Seq_index pw@11@10 i@23@10) (Seq_index pw@11@10 j@24@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@150@11@150@87|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@10)))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val))
(declare-const i@25@10 Int)
(push) ; 3
; [eval] left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 4
; [then-branch: 12 | !(left@7@10 <= i@25@10) | live]
; [else-branch: 12 | left@7@10 <= i@25@10 | live]
(push) ; 5
; [then-branch: 12 | !(left@7@10 <= i@25@10)]
(assert (not (<= left@7@10 i@25@10)))
(pop) ; 5
(push) ; 5
; [else-branch: 12 | left@7@10 <= i@25@10]
(assert (<= left@7@10 i@25@10))
; [eval] i <= right
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@25@10) (not (<= left@7@10 i@25@10))))
(push) ; 4
; [then-branch: 13 | left@7@10 <= i@25@10 && i@25@10 <= right@8@10 | live]
; [else-branch: 13 | !(left@7@10 <= i@25@10 && i@25@10 <= right@8@10) | live]
(push) ; 5
; [then-branch: 13 | left@7@10 <= i@25@10 && i@25@10 <= right@8@10]
(assert (and (<= left@7@10 i@25@10) (<= i@25@10 right@8@10)))
; [eval] loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] loc(a, i)
(push) ; 6
(assert (not (and
  (img@19@10 (loc<Ref> a@6@10 i@25@10))
  (and
    (<= left@7@10 (inv@18@10 (loc<Ref> a@6@10 i@25@10)))
    (<= (inv@18@10 (loc<Ref> a@6@10 i@25@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, pw[i]).val)
; [eval] loc(a, pw[i])
; [eval] pw[i]
(push) ; 6
(assert (not (>= i@25@10 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (< i@25@10 (Seq_length pw@11@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (and
  (img@15@10 (loc<Ref> a@6@10 (Seq_index pw@11@10 i@25@10)))
  (and
    (<= left@7@10 (inv@14@10 (loc<Ref> a@6@10 (Seq_index pw@11@10 i@25@10))))
    (<= (inv@14@10 (loc<Ref> a@6@10 (Seq_index pw@11@10 i@25@10))) right@8@10)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 13 | !(left@7@10 <= i@25@10 && i@25@10 <= right@8@10)]
(assert (not (and (<= left@7@10 i@25@10) (<= i@25@10 right@8@10))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@25@10) (<= i@25@10 right@8@10)))
  (and (<= left@7@10 i@25@10) (<= i@25@10 right@8@10))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@25@10 Int)) (!
  (and
    (or (<= left@7@10 i@25@10) (not (<= left@7@10 i@25@10)))
    (or
      (not (and (<= left@7@10 i@25@10) (<= i@25@10 right@8@10)))
      (and (<= left@7@10 i@25@10) (<= i@25@10 right@8@10))))
  :pattern ((Seq_index pw@11@10 i@25@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@152@11@152@39-aux|)))
(assert (forall ((i@25@10 Int)) (!
  (=>
    (and (<= left@7@10 i@25@10) (<= i@25@10 right@8@10))
    (=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@16@10)))) (loc<Ref> a@6@10 i@25@10))
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))) (loc<Ref> a@6@10 (Seq_index
        pw@11@10
        i@25@10)))))
  :pattern ((Seq_index pw@11@10 i@25@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@152@11@152@39|)))
(pop) ; 2
(push) ; 2
; [exec]
; var pwPar: Seq[Int]
(declare-const pwPar@26@10 Seq<Int>)
; [exec]
; var pwRec: Seq[Int]
(declare-const pwRec@27@10 Seq<Int>)
; [eval] left == right
(push) ; 3
(set-option :timeout 10)
(assert (not (not (= left@7@10 right@8@10))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 10)
(assert (not (= left@7@10 right@8@10)))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; [then-branch: 14 | left@7@10 == right@8@10 | live]
; [else-branch: 14 | left@7@10 != right@8@10 | live]
(set-option :timeout 0)
(push) ; 3
; [then-branch: 14 | left@7@10 == right@8@10]
(assert (= left@7@10 right@8@10))
; [exec]
; storeIndex := left
; [exec]
; pw := [0..left + 1)
; [eval] [0..left + 1)
; [eval] left + 1
(declare-const pw@28@10 Seq<Int>)
(assert (= pw@28@10 (Seq_range 0 (+ left@7@10 1))))
; [eval] left <= storeIndex
; [eval] storeIndex <= right
(declare-const i@29@10 Int)
(push) ; 4
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 5
; [then-branch: 15 | !(left@7@10 <= i@29@10) | live]
; [else-branch: 15 | left@7@10 <= i@29@10 | live]
(push) ; 6
; [then-branch: 15 | !(left@7@10 <= i@29@10)]
(assert (not (<= left@7@10 i@29@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 15 | left@7@10 <= i@29@10]
(assert (<= left@7@10 i@29@10))
; [eval] i <= right
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@29@10) (not (<= left@7@10 i@29@10))))
(assert (and (<= left@7@10 i@29@10) (<= i@29@10 right@8@10)))
; [eval] loc(a, i)
(pop) ; 4
(declare-fun inv@30@10 ($Ref) Int)
(declare-fun img@31@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@29@10 Int)) (!
  (=>
    (and (<= left@7@10 i@29@10) (<= i@29@10 right@8@10))
    (or (<= left@7@10 i@29@10) (not (<= left@7@10 i@29@10))))
  :pattern ((loc<Ref> a@6@10 i@29@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 4
(assert (not (forall ((i1@29@10 Int) (i2@29@10 Int)) (!
  (=>
    (and
      (and (<= left@7@10 i1@29@10) (<= i1@29@10 right@8@10))
      (and (<= left@7@10 i2@29@10) (<= i2@29@10 right@8@10))
      (= (loc<Ref> a@6@10 i1@29@10) (loc<Ref> a@6@10 i2@29@10)))
    (= i1@29@10 i2@29@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@29@10 Int)) (!
  (=>
    (and (<= left@7@10 i@29@10) (<= i@29@10 right@8@10))
    (and
      (= (inv@30@10 (loc<Ref> a@6@10 i@29@10)) i@29@10)
      (img@31@10 (loc<Ref> a@6@10 i@29@10))))
  :pattern ((loc<Ref> a@6@10 i@29@10))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@31@10 r)
      (and (<= left@7@10 (inv@30@10 r)) (<= (inv@30@10 r) right@8@10)))
    (= (loc<Ref> a@6@10 (inv@30@10 r)) r))
  :pattern ((inv@30@10 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@32@10 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= left@7@10 (inv@30@10 r)) (<= (inv@30@10 r) right@8@10))
      (img@31@10 r)
      (= r (loc<Ref> a@6@10 (inv@30@10 r))))
    ($Perm.min
      (ite
        (and
          (img@15@10 r)
          (and (<= left@7@10 (inv@14@10 r)) (<= (inv@14@10 r) right@8@10)))
        $Perm.Write
        $Perm.No)
      $Perm.Write)
    $Perm.No))
; Done precomputing, updating quantified chunks
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Chunk depleted?
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@15@10 r)
          (and (<= left@7@10 (inv@14@10 r)) (<= (inv@14@10 r) right@8@10)))
        $Perm.Write
        $Perm.No)
      (pTaken@32@10 r))
    $Perm.No)
  
  :qid |quant-u-30|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and (<= left@7@10 (inv@30@10 r)) (<= (inv@30@10 r) right@8@10))
      (img@31@10 r)
      (= r (loc<Ref> a@6@10 (inv@30@10 r))))
    (= (- $Perm.Write (pTaken@32@10 r)) $Perm.No))
  
  :qid |quant-u-31|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@33@10 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@15@10 r)
      (and (<= left@7@10 (inv@14@10 r)) (<= (inv@14@10 r) right@8@10)))
    (=
      ($FVF.lookup_val (as sm@33@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))) r)))
  :pattern (($FVF.lookup_val (as sm@33@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))) r))
  :qid |qp.fvfValDef0|)))
; [eval] storeIndex == n
(set-option :timeout 0)
(push) ; 4
(assert (not (= left@7@10 n@9@10)))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (= left@7@10 n@9@10))
; [eval] (forall i: Int :: { loc(a, i) } left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val)
(declare-const i@34@10 Int)
(push) ; 4
; [eval] left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val
; [eval] left <= i && i < storeIndex
; [eval] left <= i
(push) ; 5
; [then-branch: 16 | !(left@7@10 <= i@34@10) | live]
; [else-branch: 16 | left@7@10 <= i@34@10 | live]
(push) ; 6
; [then-branch: 16 | !(left@7@10 <= i@34@10)]
(assert (not (<= left@7@10 i@34@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 16 | left@7@10 <= i@34@10]
(assert (<= left@7@10 i@34@10))
; [eval] i < storeIndex
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@34@10) (not (<= left@7@10 i@34@10))))
(push) ; 5
; [then-branch: 17 | left@7@10 <= i@34@10 && i@34@10 < left@7@10 | live]
; [else-branch: 17 | !(left@7@10 <= i@34@10 && i@34@10 < left@7@10) | live]
(push) ; 6
; [then-branch: 17 | left@7@10 <= i@34@10 && i@34@10 < left@7@10]
(assert (and (<= left@7@10 i@34@10) (< i@34@10 left@7@10)))
; [eval] loc(a, i).val <= loc(a, storeIndex).val
; [eval] loc(a, i)
(push) ; 7
(assert (not (and
  (img@15@10 (loc<Ref> a@6@10 i@34@10))
  (and
    (<= left@7@10 (inv@14@10 (loc<Ref> a@6@10 i@34@10)))
    (<= (inv@14@10 (loc<Ref> a@6@10 i@34@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, storeIndex)
(push) ; 7
(assert (not (and
  (img@15@10 (loc<Ref> a@6@10 left@7@10))
  (and
    (<= left@7@10 (inv@14@10 (loc<Ref> a@6@10 left@7@10)))
    (<= (inv@14@10 (loc<Ref> a@6@10 left@7@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(pop) ; 6
(push) ; 6
; [else-branch: 17 | !(left@7@10 <= i@34@10 && i@34@10 < left@7@10)]
(assert (not (and (<= left@7@10 i@34@10) (< i@34@10 left@7@10))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@34@10) (< i@34@10 left@7@10)))
  (and (<= left@7@10 i@34@10) (< i@34@10 left@7@10))))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@34@10 Int)) (!
  (and
    (or (<= left@7@10 i@34@10) (not (<= left@7@10 i@34@10)))
    (or
      (not (and (<= left@7@10 i@34@10) (< i@34@10 left@7@10)))
      (and (<= left@7@10 i@34@10) (< i@34@10 left@7@10))))
  :pattern ((loc<Ref> a@6@10 i@34@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100-aux|)))
(push) ; 4
(assert (not (forall ((i@34@10 Int)) (!
  (=>
    (and (<= left@7@10 i@34@10) (< i@34@10 left@7@10))
    (<=
      ($FVF.lookup_val (as sm@33@10  $FVF<val>) (loc<Ref> a@6@10 i@34@10))
      ($FVF.lookup_val (as sm@33@10  $FVF<val>) (loc<Ref> a@6@10 left@7@10))))
  :pattern ((loc<Ref> a@6@10 i@34@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@34@10 Int)) (!
  (=>
    (and (<= left@7@10 i@34@10) (< i@34@10 left@7@10))
    (<=
      ($FVF.lookup_val (as sm@33@10  $FVF<val>) (loc<Ref> a@6@10 i@34@10))
      ($FVF.lookup_val (as sm@33@10  $FVF<val>) (loc<Ref> a@6@10 left@7@10))))
  :pattern ((loc<Ref> a@6@10 i@34@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100|)))
; [eval] (forall i: Int :: { loc(a, i) } storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val)
(declare-const i@35@10 Int)
(push) ; 4
; [eval] storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val
; [eval] storeIndex < i && i <= right
; [eval] storeIndex < i
(push) ; 5
; [then-branch: 18 | !(left@7@10 < i@35@10) | live]
; [else-branch: 18 | left@7@10 < i@35@10 | live]
(push) ; 6
; [then-branch: 18 | !(left@7@10 < i@35@10)]
(assert (not (< left@7@10 i@35@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 18 | left@7@10 < i@35@10]
(assert (< left@7@10 i@35@10))
; [eval] i <= right
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (< left@7@10 i@35@10) (not (< left@7@10 i@35@10))))
(push) ; 5
; [then-branch: 19 | left@7@10 < i@35@10 && i@35@10 <= right@8@10 | live]
; [else-branch: 19 | !(left@7@10 < i@35@10 && i@35@10 <= right@8@10) | live]
(push) ; 6
; [then-branch: 19 | left@7@10 < i@35@10 && i@35@10 <= right@8@10]
(assert (and (< left@7@10 i@35@10) (<= i@35@10 right@8@10)))
; [eval] loc(a, storeIndex).val <= loc(a, i).val
; [eval] loc(a, storeIndex)
(push) ; 7
(assert (not (and
  (img@15@10 (loc<Ref> a@6@10 left@7@10))
  (and
    (<= left@7@10 (inv@14@10 (loc<Ref> a@6@10 left@7@10)))
    (<= (inv@14@10 (loc<Ref> a@6@10 left@7@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, i)
(push) ; 7
(assert (not (and
  (img@15@10 (loc<Ref> a@6@10 i@35@10))
  (and
    (<= left@7@10 (inv@14@10 (loc<Ref> a@6@10 i@35@10)))
    (<= (inv@14@10 (loc<Ref> a@6@10 i@35@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(pop) ; 6
(push) ; 6
; [else-branch: 19 | !(left@7@10 < i@35@10 && i@35@10 <= right@8@10)]
(assert (not (and (< left@7@10 i@35@10) (<= i@35@10 right@8@10))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (< left@7@10 i@35@10) (<= i@35@10 right@8@10)))
  (and (< left@7@10 i@35@10) (<= i@35@10 right@8@10))))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@35@10 Int)) (!
  (and
    (or (< left@7@10 i@35@10) (not (< left@7@10 i@35@10)))
    (or
      (not (and (< left@7@10 i@35@10) (<= i@35@10 right@8@10)))
      (and (< left@7@10 i@35@10) (<= i@35@10 right@8@10))))
  :pattern ((loc<Ref> a@6@10 i@35@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@146@11@146@100-aux|)))
(push) ; 4
(assert (not (forall ((i@35@10 Int)) (!
  (=>
    (and (< left@7@10 i@35@10) (<= i@35@10 right@8@10))
    (<=
      ($FVF.lookup_val (as sm@33@10  $FVF<val>) (loc<Ref> a@6@10 left@7@10))
      ($FVF.lookup_val (as sm@33@10  $FVF<val>) (loc<Ref> a@6@10 i@35@10))))
  :pattern ((loc<Ref> a@6@10 i@35@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@146@11@146@100|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@35@10 Int)) (!
  (=>
    (and (< left@7@10 i@35@10) (<= i@35@10 right@8@10))
    (<=
      ($FVF.lookup_val (as sm@33@10  $FVF<val>) (loc<Ref> a@6@10 left@7@10))
      ($FVF.lookup_val (as sm@33@10  $FVF<val>) (loc<Ref> a@6@10 i@35@10))))
  :pattern ((loc<Ref> a@6@10 i@35@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@146@11@146@100|)))
; [eval] |pw| == right + 1
; [eval] |pw|
; [eval] right + 1
(push) ; 4
(assert (not (= (Seq_length pw@28@10) (+ right@8@10 1))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (= (Seq_length pw@28@10) (+ right@8@10 1)))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> left <= pw[i] && pw[i] <= right)
(declare-const i@36@10 Int)
(push) ; 4
; [eval] left <= i && i <= right ==> left <= pw[i] && pw[i] <= right
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 5
; [then-branch: 20 | !(left@7@10 <= i@36@10) | live]
; [else-branch: 20 | left@7@10 <= i@36@10 | live]
(push) ; 6
; [then-branch: 20 | !(left@7@10 <= i@36@10)]
(assert (not (<= left@7@10 i@36@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 20 | left@7@10 <= i@36@10]
(assert (<= left@7@10 i@36@10))
; [eval] i <= right
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@36@10) (not (<= left@7@10 i@36@10))))
(push) ; 5
; [then-branch: 21 | left@7@10 <= i@36@10 && i@36@10 <= right@8@10 | live]
; [else-branch: 21 | !(left@7@10 <= i@36@10 && i@36@10 <= right@8@10) | live]
(push) ; 6
; [then-branch: 21 | left@7@10 <= i@36@10 && i@36@10 <= right@8@10]
(assert (and (<= left@7@10 i@36@10) (<= i@36@10 right@8@10)))
; [eval] left <= pw[i] && pw[i] <= right
; [eval] left <= pw[i]
; [eval] pw[i]
(push) ; 7
(assert (not (>= i@36@10 0)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(assert (not (< i@36@10 (Seq_length pw@28@10))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
; [then-branch: 22 | !(left@7@10 <= pw@28@10[i@36@10]) | live]
; [else-branch: 22 | left@7@10 <= pw@28@10[i@36@10] | live]
(push) ; 8
; [then-branch: 22 | !(left@7@10 <= pw@28@10[i@36@10])]
(assert (not (<= left@7@10 (Seq_index pw@28@10 i@36@10))))
(pop) ; 8
(push) ; 8
; [else-branch: 22 | left@7@10 <= pw@28@10[i@36@10]]
(assert (<= left@7@10 (Seq_index pw@28@10 i@36@10)))
; [eval] pw[i] <= right
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@36@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@36@10 (Seq_length pw@28@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or
  (<= left@7@10 (Seq_index pw@28@10 i@36@10))
  (not (<= left@7@10 (Seq_index pw@28@10 i@36@10)))))
(pop) ; 6
(push) ; 6
; [else-branch: 21 | !(left@7@10 <= i@36@10 && i@36@10 <= right@8@10)]
(assert (not (and (<= left@7@10 i@36@10) (<= i@36@10 right@8@10))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
(assert (=>
  (and (<= left@7@10 i@36@10) (<= i@36@10 right@8@10))
  (and
    (<= left@7@10 i@36@10)
    (<= i@36@10 right@8@10)
    (or
      (<= left@7@10 (Seq_index pw@28@10 i@36@10))
      (not (<= left@7@10 (Seq_index pw@28@10 i@36@10)))))))
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@36@10) (<= i@36@10 right@8@10)))
  (and (<= left@7@10 i@36@10) (<= i@36@10 right@8@10))))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@36@10 Int)) (!
  (and
    (or (<= left@7@10 i@36@10) (not (<= left@7@10 i@36@10)))
    (=>
      (and (<= left@7@10 i@36@10) (<= i@36@10 right@8@10))
      (and
        (<= left@7@10 i@36@10)
        (<= i@36@10 right@8@10)
        (or
          (<= left@7@10 (Seq_index pw@28@10 i@36@10))
          (not (<= left@7@10 (Seq_index pw@28@10 i@36@10))))))
    (or
      (not (and (<= left@7@10 i@36@10) (<= i@36@10 right@8@10)))
      (and (<= left@7@10 i@36@10) (<= i@36@10 right@8@10))))
  :pattern ((Seq_index pw@28@10 i@36@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@149@11@149@87-aux|)))
(push) ; 4
(assert (not (forall ((i@36@10 Int)) (!
  (=>
    (and (<= left@7@10 i@36@10) (<= i@36@10 right@8@10))
    (and
      (<= left@7@10 (Seq_index pw@28@10 i@36@10))
      (<= (Seq_index pw@28@10 i@36@10) right@8@10)))
  :pattern ((Seq_index pw@28@10 i@36@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@149@11@149@87|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@36@10 Int)) (!
  (=>
    (and (<= left@7@10 i@36@10) (<= i@36@10 right@8@10))
    (and
      (<= left@7@10 (Seq_index pw@28@10 i@36@10))
      (<= (Seq_index pw@28@10 i@36@10) right@8@10)))
  :pattern ((Seq_index pw@28@10 i@36@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@149@11@149@87|)))
; [eval] (forall i: Int, j: Int :: { pw[i], pw[j] } left <= i && (i < j && j <= right) ==> pw[i] != pw[j])
(declare-const i@37@10 Int)
(declare-const j@38@10 Int)
(push) ; 4
; [eval] left <= i && (i < j && j <= right) ==> pw[i] != pw[j]
; [eval] left <= i && (i < j && j <= right)
; [eval] left <= i
(push) ; 5
; [then-branch: 23 | !(left@7@10 <= i@37@10) | live]
; [else-branch: 23 | left@7@10 <= i@37@10 | live]
(push) ; 6
; [then-branch: 23 | !(left@7@10 <= i@37@10)]
(assert (not (<= left@7@10 i@37@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 23 | left@7@10 <= i@37@10]
(assert (<= left@7@10 i@37@10))
; [eval] i < j
(push) ; 7
; [then-branch: 24 | !(i@37@10 < j@38@10) | live]
; [else-branch: 24 | i@37@10 < j@38@10 | live]
(push) ; 8
; [then-branch: 24 | !(i@37@10 < j@38@10)]
(assert (not (< i@37@10 j@38@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 24 | i@37@10 < j@38@10]
(assert (< i@37@10 j@38@10))
; [eval] j <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (< i@37@10 j@38@10) (not (< i@37@10 j@38@10))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= left@7@10 i@37@10)
  (and (<= left@7@10 i@37@10) (or (< i@37@10 j@38@10) (not (< i@37@10 j@38@10))))))
(assert (or (<= left@7@10 i@37@10) (not (<= left@7@10 i@37@10))))
(push) ; 5
; [then-branch: 25 | left@7@10 <= i@37@10 && i@37@10 < j@38@10 && j@38@10 <= right@8@10 | live]
; [else-branch: 25 | !(left@7@10 <= i@37@10 && i@37@10 < j@38@10 && j@38@10 <= right@8@10) | live]
(push) ; 6
; [then-branch: 25 | left@7@10 <= i@37@10 && i@37@10 < j@38@10 && j@38@10 <= right@8@10]
(assert (and (<= left@7@10 i@37@10) (and (< i@37@10 j@38@10) (<= j@38@10 right@8@10))))
; [eval] pw[i] != pw[j]
; [eval] pw[i]
(push) ; 7
(assert (not (>= i@37@10 0)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(assert (not (< i@37@10 (Seq_length pw@28@10))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [eval] pw[j]
(push) ; 7
(assert (not (>= j@38@10 0)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(assert (not (< j@38@10 (Seq_length pw@28@10))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(pop) ; 6
(push) ; 6
; [else-branch: 25 | !(left@7@10 <= i@37@10 && i@37@10 < j@38@10 && j@38@10 <= right@8@10)]
(assert (not
  (and (<= left@7@10 i@37@10) (and (< i@37@10 j@38@10) (<= j@38@10 right@8@10)))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
(assert (=>
  (and (<= left@7@10 i@37@10) (and (< i@37@10 j@38@10) (<= j@38@10 right@8@10)))
  (and (<= left@7@10 i@37@10) (< i@37@10 j@38@10) (<= j@38@10 right@8@10))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= left@7@10 i@37@10)
      (and (< i@37@10 j@38@10) (<= j@38@10 right@8@10))))
  (and (<= left@7@10 i@37@10) (and (< i@37@10 j@38@10) (<= j@38@10 right@8@10)))))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@37@10 Int) (j@38@10 Int)) (!
  (and
    (=>
      (<= left@7@10 i@37@10)
      (and
        (<= left@7@10 i@37@10)
        (or (< i@37@10 j@38@10) (not (< i@37@10 j@38@10)))))
    (or (<= left@7@10 i@37@10) (not (<= left@7@10 i@37@10)))
    (=>
      (and
        (<= left@7@10 i@37@10)
        (and (< i@37@10 j@38@10) (<= j@38@10 right@8@10)))
      (and (<= left@7@10 i@37@10) (< i@37@10 j@38@10) (<= j@38@10 right@8@10)))
    (or
      (not
        (and
          (<= left@7@10 i@37@10)
          (and (< i@37@10 j@38@10) (<= j@38@10 right@8@10))))
      (and
        (<= left@7@10 i@37@10)
        (and (< i@37@10 j@38@10) (<= j@38@10 right@8@10)))))
  :pattern ((Seq_index pw@28@10 i@37@10) (Seq_index pw@28@10 j@38@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@150@11@150@87-aux|)))
(push) ; 4
(assert (not (forall ((i@37@10 Int) (j@38@10 Int)) (!
  (=>
    (and
      (<= left@7@10 i@37@10)
      (and (< i@37@10 j@38@10) (<= j@38@10 right@8@10)))
    (not (= (Seq_index pw@28@10 i@37@10) (Seq_index pw@28@10 j@38@10))))
  :pattern ((Seq_index pw@28@10 i@37@10) (Seq_index pw@28@10 j@38@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@150@11@150@87|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@37@10 Int) (j@38@10 Int)) (!
  (=>
    (and
      (<= left@7@10 i@37@10)
      (and (< i@37@10 j@38@10) (<= j@38@10 right@8@10)))
    (not (= (Seq_index pw@28@10 i@37@10) (Seq_index pw@28@10 j@38@10))))
  :pattern ((Seq_index pw@28@10 i@37@10) (Seq_index pw@28@10 j@38@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@150@11@150@87|)))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val))
(declare-const i@39@10 Int)
(push) ; 4
; [eval] left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 5
; [then-branch: 26 | !(left@7@10 <= i@39@10) | live]
; [else-branch: 26 | left@7@10 <= i@39@10 | live]
(push) ; 6
; [then-branch: 26 | !(left@7@10 <= i@39@10)]
(assert (not (<= left@7@10 i@39@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 26 | left@7@10 <= i@39@10]
(assert (<= left@7@10 i@39@10))
; [eval] i <= right
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@39@10) (not (<= left@7@10 i@39@10))))
(push) ; 5
; [then-branch: 27 | left@7@10 <= i@39@10 && i@39@10 <= right@8@10 | live]
; [else-branch: 27 | !(left@7@10 <= i@39@10 && i@39@10 <= right@8@10) | live]
(push) ; 6
; [then-branch: 27 | left@7@10 <= i@39@10 && i@39@10 <= right@8@10]
(assert (and (<= left@7@10 i@39@10) (<= i@39@10 right@8@10)))
; [eval] loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] loc(a, i)
(push) ; 7
(assert (not (and
  (img@15@10 (loc<Ref> a@6@10 i@39@10))
  (and
    (<= left@7@10 (inv@14@10 (loc<Ref> a@6@10 i@39@10)))
    (<= (inv@14@10 (loc<Ref> a@6@10 i@39@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, pw[i]).val)
; [eval] loc(a, pw[i])
; [eval] pw[i]
(push) ; 7
(assert (not (>= i@39@10 0)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(assert (not (< i@39@10 (Seq_length pw@28@10))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(assert (not (and
  (img@15@10 (loc<Ref> a@6@10 (Seq_index pw@28@10 i@39@10)))
  (and
    (<= left@7@10 (inv@14@10 (loc<Ref> a@6@10 (Seq_index pw@28@10 i@39@10))))
    (<= (inv@14@10 (loc<Ref> a@6@10 (Seq_index pw@28@10 i@39@10))) right@8@10)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(pop) ; 6
(push) ; 6
; [else-branch: 27 | !(left@7@10 <= i@39@10 && i@39@10 <= right@8@10)]
(assert (not (and (<= left@7@10 i@39@10) (<= i@39@10 right@8@10))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@39@10) (<= i@39@10 right@8@10)))
  (and (<= left@7@10 i@39@10) (<= i@39@10 right@8@10))))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@39@10 Int)) (!
  (and
    (or (<= left@7@10 i@39@10) (not (<= left@7@10 i@39@10)))
    (or
      (not (and (<= left@7@10 i@39@10) (<= i@39@10 right@8@10)))
      (and (<= left@7@10 i@39@10) (<= i@39@10 right@8@10))))
  :pattern ((Seq_index pw@28@10 i@39@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@152@11@152@39-aux|)))
(push) ; 4
(assert (not (forall ((i@39@10 Int)) (!
  (=>
    (and (<= left@7@10 i@39@10) (<= i@39@10 right@8@10))
    (=
      ($FVF.lookup_val (as sm@33@10  $FVF<val>) (loc<Ref> a@6@10 i@39@10))
      ($FVF.lookup_val (as sm@33@10  $FVF<val>) (loc<Ref> a@6@10 (Seq_index
        pw@28@10
        i@39@10)))))
  :pattern ((Seq_index pw@28@10 i@39@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@152@11@152@39|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@39@10 Int)) (!
  (=>
    (and (<= left@7@10 i@39@10) (<= i@39@10 right@8@10))
    (=
      ($FVF.lookup_val (as sm@33@10  $FVF<val>) (loc<Ref> a@6@10 i@39@10))
      ($FVF.lookup_val (as sm@33@10  $FVF<val>) (loc<Ref> a@6@10 (Seq_index
        pw@28@10
        i@39@10)))))
  :pattern ((Seq_index pw@28@10 i@39@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@152@11@152@39|)))
(pop) ; 3
(push) ; 3
; [else-branch: 14 | left@7@10 != right@8@10]
(assert (not (= left@7@10 right@8@10)))
(pop) ; 3
; [eval] !(left == right)
; [eval] left == right
(push) ; 3
(set-option :timeout 10)
(assert (not (= left@7@10 right@8@10)))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 10)
(assert (not (not (= left@7@10 right@8@10))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; [then-branch: 28 | left@7@10 != right@8@10 | live]
; [else-branch: 28 | left@7@10 == right@8@10 | live]
(set-option :timeout 0)
(push) ; 3
; [then-branch: 28 | left@7@10 != right@8@10]
(assert (not (= left@7@10 right@8@10)))
; [exec]
; var pivotIndex: Int
(declare-const pivotIndex@40@10 Int)
; [exec]
; inhale left <= pivotIndex && pivotIndex <= right
(declare-const $t@41@10 $Snap)
(assert (= $t@41@10 ($Snap.combine ($Snap.first $t@41@10) ($Snap.second $t@41@10))))
(assert (= ($Snap.first $t@41@10) $Snap.unit))
; [eval] left <= pivotIndex
(assert (<= left@7@10 pivotIndex@40@10))
(assert (= ($Snap.second $t@41@10) $Snap.unit))
; [eval] pivotIndex <= right
(assert (<= pivotIndex@40@10 right@8@10))
; State saturation: after inhale
(set-option :timeout 20)
(check-sat)
; unknown
; [exec]
; pivotIndex, pwPar := partition(a, left, right, pivotIndex)
; [eval] 0 <= left
; [eval] left < right
(set-option :timeout 0)
(push) ; 4
(assert (not (< left@7@10 right@8@10)))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (< left@7@10 right@8@10))
; [eval] right < len(a)
; [eval] len(a)
; [eval] left <= pivotIndex
; [eval] pivotIndex <= right
(declare-const i@42@10 Int)
(push) ; 4
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 5
; [then-branch: 29 | !(left@7@10 <= i@42@10) | live]
; [else-branch: 29 | left@7@10 <= i@42@10 | live]
(push) ; 6
; [then-branch: 29 | !(left@7@10 <= i@42@10)]
(assert (not (<= left@7@10 i@42@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 29 | left@7@10 <= i@42@10]
(assert (<= left@7@10 i@42@10))
; [eval] i <= right
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@42@10) (not (<= left@7@10 i@42@10))))
(assert (and (<= left@7@10 i@42@10) (<= i@42@10 right@8@10)))
; [eval] loc(a, i)
(pop) ; 4
(declare-fun inv@43@10 ($Ref) Int)
(declare-fun img@44@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@42@10 Int)) (!
  (=>
    (and (<= left@7@10 i@42@10) (<= i@42@10 right@8@10))
    (or (<= left@7@10 i@42@10) (not (<= left@7@10 i@42@10))))
  :pattern ((loc<Ref> a@6@10 i@42@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 4
(assert (not (forall ((i1@42@10 Int) (i2@42@10 Int)) (!
  (=>
    (and
      (and (<= left@7@10 i1@42@10) (<= i1@42@10 right@8@10))
      (and (<= left@7@10 i2@42@10) (<= i2@42@10 right@8@10))
      (= (loc<Ref> a@6@10 i1@42@10) (loc<Ref> a@6@10 i2@42@10)))
    (= i1@42@10 i2@42@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@42@10 Int)) (!
  (=>
    (and (<= left@7@10 i@42@10) (<= i@42@10 right@8@10))
    (and
      (= (inv@43@10 (loc<Ref> a@6@10 i@42@10)) i@42@10)
      (img@44@10 (loc<Ref> a@6@10 i@42@10))))
  :pattern ((loc<Ref> a@6@10 i@42@10))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@44@10 r)
      (and (<= left@7@10 (inv@43@10 r)) (<= (inv@43@10 r) right@8@10)))
    (= (loc<Ref> a@6@10 (inv@43@10 r)) r))
  :pattern ((inv@43@10 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@45@10 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= left@7@10 (inv@43@10 r)) (<= (inv@43@10 r) right@8@10))
      (img@44@10 r)
      (= r (loc<Ref> a@6@10 (inv@43@10 r))))
    ($Perm.min
      (ite
        (and
          (img@15@10 r)
          (and (<= left@7@10 (inv@14@10 r)) (<= (inv@14@10 r) right@8@10)))
        $Perm.Write
        $Perm.No)
      $Perm.Write)
    $Perm.No))
; Done precomputing, updating quantified chunks
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Chunk depleted?
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@15@10 r)
          (and (<= left@7@10 (inv@14@10 r)) (<= (inv@14@10 r) right@8@10)))
        $Perm.Write
        $Perm.No)
      (pTaken@45@10 r))
    $Perm.No)
  
  :qid |quant-u-40|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and (<= left@7@10 (inv@43@10 r)) (<= (inv@43@10 r) right@8@10))
      (img@44@10 r)
      (= r (loc<Ref> a@6@10 (inv@43@10 r))))
    (= (- $Perm.Write (pTaken@45@10 r)) $Perm.No))
  
  :qid |quant-u-41|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@46@10 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@15@10 r)
      (and (<= left@7@10 (inv@14@10 r)) (<= (inv@14@10 r) right@8@10)))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))) r))
  :qid |qp.fvfValDef1|)))
(declare-const storeIndex@47@10 Int)
(declare-const pw@48@10 Seq<Int>)
(declare-const $t@49@10 $Snap)
(assert (= $t@49@10 ($Snap.combine ($Snap.first $t@49@10) ($Snap.second $t@49@10))))
(assert (= ($Snap.first $t@49@10) $Snap.unit))
; [eval] left <= storeIndex
(assert (<= left@7@10 storeIndex@47@10))
(assert (=
  ($Snap.second $t@49@10)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@49@10))
    ($Snap.second ($Snap.second $t@49@10)))))
(assert (= ($Snap.first ($Snap.second $t@49@10)) $Snap.unit))
; [eval] storeIndex <= right
(assert (<= storeIndex@47@10 right@8@10))
(assert (=
  ($Snap.second ($Snap.second $t@49@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@49@10)))
    ($Snap.second ($Snap.second ($Snap.second $t@49@10))))))
(declare-const i@50@10 Int)
(set-option :timeout 0)
(push) ; 4
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 5
; [then-branch: 30 | !(left@7@10 <= i@50@10) | live]
; [else-branch: 30 | left@7@10 <= i@50@10 | live]
(push) ; 6
; [then-branch: 30 | !(left@7@10 <= i@50@10)]
(assert (not (<= left@7@10 i@50@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 30 | left@7@10 <= i@50@10]
(assert (<= left@7@10 i@50@10))
; [eval] i <= right
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@50@10) (not (<= left@7@10 i@50@10))))
(assert (and (<= left@7@10 i@50@10) (<= i@50@10 right@8@10)))
; [eval] loc(a, i)
(pop) ; 4
(declare-fun inv@51@10 ($Ref) Int)
(declare-fun img@52@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@50@10 Int)) (!
  (=>
    (and (<= left@7@10 i@50@10) (<= i@50@10 right@8@10))
    (or (<= left@7@10 i@50@10) (not (<= left@7@10 i@50@10))))
  :pattern ((loc<Ref> a@6@10 i@50@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 4
(assert (not (forall ((i1@50@10 Int) (i2@50@10 Int)) (!
  (=>
    (and
      (and (<= left@7@10 i1@50@10) (<= i1@50@10 right@8@10))
      (and (<= left@7@10 i2@50@10) (<= i2@50@10 right@8@10))
      (= (loc<Ref> a@6@10 i1@50@10) (loc<Ref> a@6@10 i2@50@10)))
    (= i1@50@10 i2@50@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@50@10 Int)) (!
  (=>
    (and (<= left@7@10 i@50@10) (<= i@50@10 right@8@10))
    (and
      (= (inv@51@10 (loc<Ref> a@6@10 i@50@10)) i@50@10)
      (img@52@10 (loc<Ref> a@6@10 i@50@10))))
  :pattern ((loc<Ref> a@6@10 i@50@10))
  :qid |quant-u-43|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@52@10 r)
      (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
    (= (loc<Ref> a@6@10 (inv@51@10 r)) r))
  :pattern ((inv@51@10 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@50@10 Int)) (!
  (=>
    (and (<= left@7@10 i@50@10) (<= i@50@10 right@8@10))
    (not (= (loc<Ref> a@6@10 i@50@10) $Ref.null)))
  :pattern ((loc<Ref> a@6@10 i@50@10))
  :qid |val-permImpliesNonNull|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@49@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@49@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@49@10))))
  $Snap.unit))
; [eval] loc(a, storeIndex).val == old(loc(a, pivotIndex).val)
; [eval] loc(a, storeIndex)
(push) ; 4
(assert (not (and
  (img@52@10 (loc<Ref> a@6@10 storeIndex@47@10))
  (and
    (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 storeIndex@47@10)))
    (<= (inv@51@10 (loc<Ref> a@6@10 storeIndex@47@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, pivotIndex).val)
; [eval] loc(a, pivotIndex)
(push) ; 4
(assert (not (and
  (img@15@10 (loc<Ref> a@6@10 pivotIndex@40@10))
  (and
    (<= left@7@10 (inv@14@10 (loc<Ref> a@6@10 pivotIndex@40@10)))
    (<= (inv@14@10 (loc<Ref> a@6@10 pivotIndex@40@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) (loc<Ref> a@6@10 storeIndex@47@10))
  ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> a@6@10 pivotIndex@40@10))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10)))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } left <= i && i < storeIndex ==> loc(a, i).val < loc(a, storeIndex).val)
(declare-const i@53@10 Int)
(push) ; 4
; [eval] left <= i && i < storeIndex ==> loc(a, i).val < loc(a, storeIndex).val
; [eval] left <= i && i < storeIndex
; [eval] left <= i
(push) ; 5
; [then-branch: 31 | !(left@7@10 <= i@53@10) | live]
; [else-branch: 31 | left@7@10 <= i@53@10 | live]
(push) ; 6
; [then-branch: 31 | !(left@7@10 <= i@53@10)]
(assert (not (<= left@7@10 i@53@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 31 | left@7@10 <= i@53@10]
(assert (<= left@7@10 i@53@10))
; [eval] i < storeIndex
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@53@10) (not (<= left@7@10 i@53@10))))
(push) ; 5
; [then-branch: 32 | left@7@10 <= i@53@10 && i@53@10 < storeIndex@47@10 | live]
; [else-branch: 32 | !(left@7@10 <= i@53@10 && i@53@10 < storeIndex@47@10) | live]
(push) ; 6
; [then-branch: 32 | left@7@10 <= i@53@10 && i@53@10 < storeIndex@47@10]
(assert (and (<= left@7@10 i@53@10) (< i@53@10 storeIndex@47@10)))
; [eval] loc(a, i).val < loc(a, storeIndex).val
; [eval] loc(a, i)
(push) ; 7
(assert (not (and
  (img@52@10 (loc<Ref> a@6@10 i@53@10))
  (and
    (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 i@53@10)))
    (<= (inv@51@10 (loc<Ref> a@6@10 i@53@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, storeIndex)
(push) ; 7
(assert (not (and
  (img@52@10 (loc<Ref> a@6@10 storeIndex@47@10))
  (and
    (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 storeIndex@47@10)))
    (<= (inv@51@10 (loc<Ref> a@6@10 storeIndex@47@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(pop) ; 6
(push) ; 6
; [else-branch: 32 | !(left@7@10 <= i@53@10 && i@53@10 < storeIndex@47@10)]
(assert (not (and (<= left@7@10 i@53@10) (< i@53@10 storeIndex@47@10))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@53@10) (< i@53@10 storeIndex@47@10)))
  (and (<= left@7@10 i@53@10) (< i@53@10 storeIndex@47@10))))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@53@10 Int)) (!
  (and
    (or (<= left@7@10 i@53@10) (not (<= left@7@10 i@53@10)))
    (or
      (not (and (<= left@7@10 i@53@10) (< i@53@10 storeIndex@47@10)))
      (and (<= left@7@10 i@53@10) (< i@53@10 storeIndex@47@10))))
  :pattern ((loc<Ref> a@6@10 i@53@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@59@11@59@99-aux|)))
(assert (forall ((i@53@10 Int)) (!
  (=>
    (and (<= left@7@10 i@53@10) (< i@53@10 storeIndex@47@10))
    (<
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) (loc<Ref> a@6@10 i@53@10))
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) (loc<Ref> a@6@10 storeIndex@47@10))))
  :pattern ((loc<Ref> a@6@10 i@53@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@59@11@59@99|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10))))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val)
(declare-const i@54@10 Int)
(push) ; 4
; [eval] storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val
; [eval] storeIndex < i && i <= right
; [eval] storeIndex < i
(push) ; 5
; [then-branch: 33 | !(storeIndex@47@10 < i@54@10) | live]
; [else-branch: 33 | storeIndex@47@10 < i@54@10 | live]
(push) ; 6
; [then-branch: 33 | !(storeIndex@47@10 < i@54@10)]
(assert (not (< storeIndex@47@10 i@54@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 33 | storeIndex@47@10 < i@54@10]
(assert (< storeIndex@47@10 i@54@10))
; [eval] i <= right
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (< storeIndex@47@10 i@54@10) (not (< storeIndex@47@10 i@54@10))))
(push) ; 5
; [then-branch: 34 | storeIndex@47@10 < i@54@10 && i@54@10 <= right@8@10 | live]
; [else-branch: 34 | !(storeIndex@47@10 < i@54@10 && i@54@10 <= right@8@10) | live]
(push) ; 6
; [then-branch: 34 | storeIndex@47@10 < i@54@10 && i@54@10 <= right@8@10]
(assert (and (< storeIndex@47@10 i@54@10) (<= i@54@10 right@8@10)))
; [eval] loc(a, storeIndex).val <= loc(a, i).val
; [eval] loc(a, storeIndex)
(push) ; 7
(assert (not (and
  (img@52@10 (loc<Ref> a@6@10 storeIndex@47@10))
  (and
    (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 storeIndex@47@10)))
    (<= (inv@51@10 (loc<Ref> a@6@10 storeIndex@47@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, i)
(push) ; 7
(assert (not (and
  (img@52@10 (loc<Ref> a@6@10 i@54@10))
  (and
    (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 i@54@10)))
    (<= (inv@51@10 (loc<Ref> a@6@10 i@54@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(pop) ; 6
(push) ; 6
; [else-branch: 34 | !(storeIndex@47@10 < i@54@10 && i@54@10 <= right@8@10)]
(assert (not (and (< storeIndex@47@10 i@54@10) (<= i@54@10 right@8@10))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (< storeIndex@47@10 i@54@10) (<= i@54@10 right@8@10)))
  (and (< storeIndex@47@10 i@54@10) (<= i@54@10 right@8@10))))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@54@10 Int)) (!
  (and
    (or (< storeIndex@47@10 i@54@10) (not (< storeIndex@47@10 i@54@10)))
    (or
      (not (and (< storeIndex@47@10 i@54@10) (<= i@54@10 right@8@10)))
      (and (< storeIndex@47@10 i@54@10) (<= i@54@10 right@8@10))))
  :pattern ((loc<Ref> a@6@10 i@54@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@60@11@60@100-aux|)))
(assert (forall ((i@54@10 Int)) (!
  (=>
    (and (< storeIndex@47@10 i@54@10) (<= i@54@10 right@8@10))
    (<=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) (loc<Ref> a@6@10 storeIndex@47@10))
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) (loc<Ref> a@6@10 i@54@10))))
  :pattern ((loc<Ref> a@6@10 i@54@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@60@11@60@100|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10)))))))
  $Snap.unit))
; [eval] |pw| == right + 1
; [eval] |pw|
; [eval] right + 1
(assert (= (Seq_length pw@48@10) (+ right@8@10 1)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> left <= pw[i] && pw[i] <= right)
(declare-const i@55@10 Int)
(push) ; 4
; [eval] left <= i && i <= right ==> left <= pw[i] && pw[i] <= right
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 5
; [then-branch: 35 | !(left@7@10 <= i@55@10) | live]
; [else-branch: 35 | left@7@10 <= i@55@10 | live]
(push) ; 6
; [then-branch: 35 | !(left@7@10 <= i@55@10)]
(assert (not (<= left@7@10 i@55@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 35 | left@7@10 <= i@55@10]
(assert (<= left@7@10 i@55@10))
; [eval] i <= right
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@55@10) (not (<= left@7@10 i@55@10))))
(push) ; 5
; [then-branch: 36 | left@7@10 <= i@55@10 && i@55@10 <= right@8@10 | live]
; [else-branch: 36 | !(left@7@10 <= i@55@10 && i@55@10 <= right@8@10) | live]
(push) ; 6
; [then-branch: 36 | left@7@10 <= i@55@10 && i@55@10 <= right@8@10]
(assert (and (<= left@7@10 i@55@10) (<= i@55@10 right@8@10)))
; [eval] left <= pw[i] && pw[i] <= right
; [eval] left <= pw[i]
; [eval] pw[i]
(push) ; 7
(assert (not (>= i@55@10 0)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(assert (not (< i@55@10 (Seq_length pw@48@10))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
; [then-branch: 37 | !(left@7@10 <= pw@48@10[i@55@10]) | live]
; [else-branch: 37 | left@7@10 <= pw@48@10[i@55@10] | live]
(push) ; 8
; [then-branch: 37 | !(left@7@10 <= pw@48@10[i@55@10])]
(assert (not (<= left@7@10 (Seq_index pw@48@10 i@55@10))))
(pop) ; 8
(push) ; 8
; [else-branch: 37 | left@7@10 <= pw@48@10[i@55@10]]
(assert (<= left@7@10 (Seq_index pw@48@10 i@55@10)))
; [eval] pw[i] <= right
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@55@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@55@10 (Seq_length pw@48@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or
  (<= left@7@10 (Seq_index pw@48@10 i@55@10))
  (not (<= left@7@10 (Seq_index pw@48@10 i@55@10)))))
(pop) ; 6
(push) ; 6
; [else-branch: 36 | !(left@7@10 <= i@55@10 && i@55@10 <= right@8@10)]
(assert (not (and (<= left@7@10 i@55@10) (<= i@55@10 right@8@10))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
(assert (=>
  (and (<= left@7@10 i@55@10) (<= i@55@10 right@8@10))
  (and
    (<= left@7@10 i@55@10)
    (<= i@55@10 right@8@10)
    (or
      (<= left@7@10 (Seq_index pw@48@10 i@55@10))
      (not (<= left@7@10 (Seq_index pw@48@10 i@55@10)))))))
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@55@10) (<= i@55@10 right@8@10)))
  (and (<= left@7@10 i@55@10) (<= i@55@10 right@8@10))))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@55@10 Int)) (!
  (and
    (or (<= left@7@10 i@55@10) (not (<= left@7@10 i@55@10)))
    (=>
      (and (<= left@7@10 i@55@10) (<= i@55@10 right@8@10))
      (and
        (<= left@7@10 i@55@10)
        (<= i@55@10 right@8@10)
        (or
          (<= left@7@10 (Seq_index pw@48@10 i@55@10))
          (not (<= left@7@10 (Seq_index pw@48@10 i@55@10))))))
    (or
      (not (and (<= left@7@10 i@55@10) (<= i@55@10 right@8@10)))
      (and (<= left@7@10 i@55@10) (<= i@55@10 right@8@10))))
  :pattern ((Seq_index pw@48@10 i@55@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@63@11@63@87-aux|)))
(assert (forall ((i@55@10 Int)) (!
  (=>
    (and (<= left@7@10 i@55@10) (<= i@55@10 right@8@10))
    (and
      (<= left@7@10 (Seq_index pw@48@10 i@55@10))
      (<= (Seq_index pw@48@10 i@55@10) right@8@10)))
  :pattern ((Seq_index pw@48@10 i@55@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@63@11@63@87|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10)))))))))
  $Snap.unit))
; [eval] (forall i: Int, k: Int :: { pw[i], pw[k] } left <= i && (i < k && k <= right) ==> pw[i] != pw[k])
(declare-const i@56@10 Int)
(declare-const k@57@10 Int)
(push) ; 4
; [eval] left <= i && (i < k && k <= right) ==> pw[i] != pw[k]
; [eval] left <= i && (i < k && k <= right)
; [eval] left <= i
(push) ; 5
; [then-branch: 38 | !(left@7@10 <= i@56@10) | live]
; [else-branch: 38 | left@7@10 <= i@56@10 | live]
(push) ; 6
; [then-branch: 38 | !(left@7@10 <= i@56@10)]
(assert (not (<= left@7@10 i@56@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 38 | left@7@10 <= i@56@10]
(assert (<= left@7@10 i@56@10))
; [eval] i < k
(push) ; 7
; [then-branch: 39 | !(i@56@10 < k@57@10) | live]
; [else-branch: 39 | i@56@10 < k@57@10 | live]
(push) ; 8
; [then-branch: 39 | !(i@56@10 < k@57@10)]
(assert (not (< i@56@10 k@57@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 39 | i@56@10 < k@57@10]
(assert (< i@56@10 k@57@10))
; [eval] k <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (< i@56@10 k@57@10) (not (< i@56@10 k@57@10))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= left@7@10 i@56@10)
  (and (<= left@7@10 i@56@10) (or (< i@56@10 k@57@10) (not (< i@56@10 k@57@10))))))
(assert (or (<= left@7@10 i@56@10) (not (<= left@7@10 i@56@10))))
(push) ; 5
; [then-branch: 40 | left@7@10 <= i@56@10 && i@56@10 < k@57@10 && k@57@10 <= right@8@10 | live]
; [else-branch: 40 | !(left@7@10 <= i@56@10 && i@56@10 < k@57@10 && k@57@10 <= right@8@10) | live]
(push) ; 6
; [then-branch: 40 | left@7@10 <= i@56@10 && i@56@10 < k@57@10 && k@57@10 <= right@8@10]
(assert (and (<= left@7@10 i@56@10) (and (< i@56@10 k@57@10) (<= k@57@10 right@8@10))))
; [eval] pw[i] != pw[k]
; [eval] pw[i]
(push) ; 7
(assert (not (>= i@56@10 0)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(assert (not (< i@56@10 (Seq_length pw@48@10))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [eval] pw[k]
(push) ; 7
(assert (not (>= k@57@10 0)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(assert (not (< k@57@10 (Seq_length pw@48@10))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(pop) ; 6
(push) ; 6
; [else-branch: 40 | !(left@7@10 <= i@56@10 && i@56@10 < k@57@10 && k@57@10 <= right@8@10)]
(assert (not
  (and (<= left@7@10 i@56@10) (and (< i@56@10 k@57@10) (<= k@57@10 right@8@10)))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
(assert (=>
  (and (<= left@7@10 i@56@10) (and (< i@56@10 k@57@10) (<= k@57@10 right@8@10)))
  (and (<= left@7@10 i@56@10) (< i@56@10 k@57@10) (<= k@57@10 right@8@10))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= left@7@10 i@56@10)
      (and (< i@56@10 k@57@10) (<= k@57@10 right@8@10))))
  (and (<= left@7@10 i@56@10) (and (< i@56@10 k@57@10) (<= k@57@10 right@8@10)))))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@56@10 Int) (k@57@10 Int)) (!
  (and
    (=>
      (<= left@7@10 i@56@10)
      (and
        (<= left@7@10 i@56@10)
        (or (< i@56@10 k@57@10) (not (< i@56@10 k@57@10)))))
    (or (<= left@7@10 i@56@10) (not (<= left@7@10 i@56@10)))
    (=>
      (and
        (<= left@7@10 i@56@10)
        (and (< i@56@10 k@57@10) (<= k@57@10 right@8@10)))
      (and (<= left@7@10 i@56@10) (< i@56@10 k@57@10) (<= k@57@10 right@8@10)))
    (or
      (not
        (and
          (<= left@7@10 i@56@10)
          (and (< i@56@10 k@57@10) (<= k@57@10 right@8@10))))
      (and
        (<= left@7@10 i@56@10)
        (and (< i@56@10 k@57@10) (<= k@57@10 right@8@10)))))
  :pattern ((Seq_index pw@48@10 i@56@10) (Seq_index pw@48@10 k@57@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@64@11@64@87-aux|)))
(assert (forall ((i@56@10 Int) (k@57@10 Int)) (!
  (=>
    (and
      (<= left@7@10 i@56@10)
      (and (< i@56@10 k@57@10) (<= k@57@10 right@8@10)))
    (not (= (Seq_index pw@48@10 i@56@10) (Seq_index pw@48@10 k@57@10))))
  :pattern ((Seq_index pw@48@10 i@56@10) (Seq_index pw@48@10 k@57@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@64@11@64@87|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@49@10)))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val))
(declare-const i@58@10 Int)
(push) ; 4
; [eval] left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 5
; [then-branch: 41 | !(left@7@10 <= i@58@10) | live]
; [else-branch: 41 | left@7@10 <= i@58@10 | live]
(push) ; 6
; [then-branch: 41 | !(left@7@10 <= i@58@10)]
(assert (not (<= left@7@10 i@58@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 41 | left@7@10 <= i@58@10]
(assert (<= left@7@10 i@58@10))
; [eval] i <= right
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@58@10) (not (<= left@7@10 i@58@10))))
(push) ; 5
; [then-branch: 42 | left@7@10 <= i@58@10 && i@58@10 <= right@8@10 | live]
; [else-branch: 42 | !(left@7@10 <= i@58@10 && i@58@10 <= right@8@10) | live]
(push) ; 6
; [then-branch: 42 | left@7@10 <= i@58@10 && i@58@10 <= right@8@10]
(assert (and (<= left@7@10 i@58@10) (<= i@58@10 right@8@10)))
; [eval] loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] loc(a, i)
(push) ; 7
(assert (not (and
  (img@52@10 (loc<Ref> a@6@10 i@58@10))
  (and
    (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 i@58@10)))
    (<= (inv@51@10 (loc<Ref> a@6@10 i@58@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, pw[i]).val)
; [eval] loc(a, pw[i])
; [eval] pw[i]
(push) ; 7
(assert (not (>= i@58@10 0)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(assert (not (< i@58@10 (Seq_length pw@48@10))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(assert (not (and
  (img@15@10 (loc<Ref> a@6@10 (Seq_index pw@48@10 i@58@10)))
  (and
    (<= left@7@10 (inv@14@10 (loc<Ref> a@6@10 (Seq_index pw@48@10 i@58@10))))
    (<= (inv@14@10 (loc<Ref> a@6@10 (Seq_index pw@48@10 i@58@10))) right@8@10)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(pop) ; 6
(push) ; 6
; [else-branch: 42 | !(left@7@10 <= i@58@10 && i@58@10 <= right@8@10)]
(assert (not (and (<= left@7@10 i@58@10) (<= i@58@10 right@8@10))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@58@10) (<= i@58@10 right@8@10)))
  (and (<= left@7@10 i@58@10) (<= i@58@10 right@8@10))))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@58@10 Int)) (!
  (and
    (or (<= left@7@10 i@58@10) (not (<= left@7@10 i@58@10)))
    (or
      (not (and (<= left@7@10 i@58@10) (<= i@58@10 right@8@10)))
      (and (<= left@7@10 i@58@10) (<= i@58@10 right@8@10))))
  :pattern ((Seq_index pw@48@10 i@58@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@66@11@66@39-aux|)))
(assert (forall ((i@58@10 Int)) (!
  (=>
    (and (<= left@7@10 i@58@10) (<= i@58@10 right@8@10))
    (=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) (loc<Ref> a@6@10 i@58@10))
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> a@6@10 (Seq_index
        pw@48@10
        i@58@10)))))
  :pattern ((Seq_index pw@48@10 i@58@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@66@11@66@39|)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
; [eval] n == pivotIndex
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 10)
(assert (not (not (= n@9@10 storeIndex@47@10))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 10)
(assert (not (= n@9@10 storeIndex@47@10)))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; [then-branch: 43 | n@9@10 == storeIndex@47@10 | live]
; [else-branch: 43 | n@9@10 != storeIndex@47@10 | live]
(set-option :timeout 0)
(push) ; 4
; [then-branch: 43 | n@9@10 == storeIndex@47@10]
(assert (= n@9@10 storeIndex@47@10))
; [exec]
; storeIndex := pivotIndex
; [exec]
; pw := pwPar
; [eval] left <= storeIndex
; [eval] storeIndex <= right
(declare-const i@59@10 Int)
(push) ; 5
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 6
; [then-branch: 44 | !(left@7@10 <= i@59@10) | live]
; [else-branch: 44 | left@7@10 <= i@59@10 | live]
(push) ; 7
; [then-branch: 44 | !(left@7@10 <= i@59@10)]
(assert (not (<= left@7@10 i@59@10)))
(pop) ; 7
(push) ; 7
; [else-branch: 44 | left@7@10 <= i@59@10]
(assert (<= left@7@10 i@59@10))
; [eval] i <= right
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@59@10) (not (<= left@7@10 i@59@10))))
(assert (and (<= left@7@10 i@59@10) (<= i@59@10 right@8@10)))
; [eval] loc(a, i)
(pop) ; 5
(declare-fun inv@60@10 ($Ref) Int)
(declare-fun img@61@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@59@10 Int)) (!
  (=>
    (and (<= left@7@10 i@59@10) (<= i@59@10 right@8@10))
    (or (<= left@7@10 i@59@10) (not (<= left@7@10 i@59@10))))
  :pattern ((loc<Ref> a@6@10 i@59@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 5
(assert (not (forall ((i1@59@10 Int) (i2@59@10 Int)) (!
  (=>
    (and
      (and (<= left@7@10 i1@59@10) (<= i1@59@10 right@8@10))
      (and (<= left@7@10 i2@59@10) (<= i2@59@10 right@8@10))
      (= (loc<Ref> a@6@10 i1@59@10) (loc<Ref> a@6@10 i2@59@10)))
    (= i1@59@10 i2@59@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@59@10 Int)) (!
  (=>
    (and (<= left@7@10 i@59@10) (<= i@59@10 right@8@10))
    (and
      (= (inv@60@10 (loc<Ref> a@6@10 i@59@10)) i@59@10)
      (img@61@10 (loc<Ref> a@6@10 i@59@10))))
  :pattern ((loc<Ref> a@6@10 i@59@10))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@61@10 r)
      (and (<= left@7@10 (inv@60@10 r)) (<= (inv@60@10 r) right@8@10)))
    (= (loc<Ref> a@6@10 (inv@60@10 r)) r))
  :pattern ((inv@60@10 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@62@10 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= left@7@10 (inv@60@10 r)) (<= (inv@60@10 r) right@8@10))
      (img@61@10 r)
      (= r (loc<Ref> a@6@10 (inv@60@10 r))))
    ($Perm.min
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        $Perm.Write
        $Perm.No)
      $Perm.Write)
    $Perm.No))
; Done precomputing, updating quantified chunks
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Chunk depleted?
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        $Perm.Write
        $Perm.No)
      (pTaken@62@10 r))
    $Perm.No)
  
  :qid |quant-u-52|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and (<= left@7@10 (inv@60@10 r)) (<= (inv@60@10 r) right@8@10))
      (img@61@10 r)
      (= r (loc<Ref> a@6@10 (inv@60@10 r))))
    (= (- $Perm.Write (pTaken@62@10 r)) $Perm.No))
  
  :qid |quant-u-53|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@63@10 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@52@10 r)
      (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
    (=
      ($FVF.lookup_val (as sm@63@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@63@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef2|)))
; [eval] storeIndex == n
(set-option :timeout 0)
(push) ; 5
(assert (not (= storeIndex@47@10 n@9@10)))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (= storeIndex@47@10 n@9@10))
; [eval] (forall i: Int :: { loc(a, i) } left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val)
(declare-const i@64@10 Int)
(push) ; 5
; [eval] left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val
; [eval] left <= i && i < storeIndex
; [eval] left <= i
(push) ; 6
; [then-branch: 45 | !(left@7@10 <= i@64@10) | live]
; [else-branch: 45 | left@7@10 <= i@64@10 | live]
(push) ; 7
; [then-branch: 45 | !(left@7@10 <= i@64@10)]
(assert (not (<= left@7@10 i@64@10)))
(pop) ; 7
(push) ; 7
; [else-branch: 45 | left@7@10 <= i@64@10]
(assert (<= left@7@10 i@64@10))
; [eval] i < storeIndex
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@64@10) (not (<= left@7@10 i@64@10))))
(push) ; 6
; [then-branch: 46 | left@7@10 <= i@64@10 && i@64@10 < storeIndex@47@10 | live]
; [else-branch: 46 | !(left@7@10 <= i@64@10 && i@64@10 < storeIndex@47@10) | live]
(push) ; 7
; [then-branch: 46 | left@7@10 <= i@64@10 && i@64@10 < storeIndex@47@10]
(assert (and (<= left@7@10 i@64@10) (< i@64@10 storeIndex@47@10)))
; [eval] loc(a, i).val <= loc(a, storeIndex).val
; [eval] loc(a, i)
(push) ; 8
(assert (not (and
  (img@52@10 (loc<Ref> a@6@10 i@64@10))
  (and
    (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 i@64@10)))
    (<= (inv@51@10 (loc<Ref> a@6@10 i@64@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, storeIndex)
(push) ; 8
(assert (not (and
  (img@52@10 (loc<Ref> a@6@10 storeIndex@47@10))
  (and
    (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 storeIndex@47@10)))
    (<= (inv@51@10 (loc<Ref> a@6@10 storeIndex@47@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 46 | !(left@7@10 <= i@64@10 && i@64@10 < storeIndex@47@10)]
(assert (not (and (<= left@7@10 i@64@10) (< i@64@10 storeIndex@47@10))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@64@10) (< i@64@10 storeIndex@47@10)))
  (and (<= left@7@10 i@64@10) (< i@64@10 storeIndex@47@10))))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@64@10 Int)) (!
  (and
    (or (<= left@7@10 i@64@10) (not (<= left@7@10 i@64@10)))
    (or
      (not (and (<= left@7@10 i@64@10) (< i@64@10 storeIndex@47@10)))
      (and (<= left@7@10 i@64@10) (< i@64@10 storeIndex@47@10))))
  :pattern ((loc<Ref> a@6@10 i@64@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100-aux|)))
(push) ; 5
(assert (not (forall ((i@64@10 Int)) (!
  (=>
    (and (<= left@7@10 i@64@10) (< i@64@10 storeIndex@47@10))
    (<=
      ($FVF.lookup_val (as sm@63@10  $FVF<val>) (loc<Ref> a@6@10 i@64@10))
      ($FVF.lookup_val (as sm@63@10  $FVF<val>) (loc<Ref> a@6@10 storeIndex@47@10))))
  :pattern ((loc<Ref> a@6@10 i@64@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@64@10 Int)) (!
  (=>
    (and (<= left@7@10 i@64@10) (< i@64@10 storeIndex@47@10))
    (<=
      ($FVF.lookup_val (as sm@63@10  $FVF<val>) (loc<Ref> a@6@10 i@64@10))
      ($FVF.lookup_val (as sm@63@10  $FVF<val>) (loc<Ref> a@6@10 storeIndex@47@10))))
  :pattern ((loc<Ref> a@6@10 i@64@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100|)))
; [eval] (forall i: Int :: { loc(a, i) } storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val)
(declare-const i@65@10 Int)
(push) ; 5
; [eval] storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val
; [eval] storeIndex < i && i <= right
; [eval] storeIndex < i
(push) ; 6
; [then-branch: 47 | !(storeIndex@47@10 < i@65@10) | live]
; [else-branch: 47 | storeIndex@47@10 < i@65@10 | live]
(push) ; 7
; [then-branch: 47 | !(storeIndex@47@10 < i@65@10)]
(assert (not (< storeIndex@47@10 i@65@10)))
(pop) ; 7
(push) ; 7
; [else-branch: 47 | storeIndex@47@10 < i@65@10]
(assert (< storeIndex@47@10 i@65@10))
; [eval] i <= right
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (< storeIndex@47@10 i@65@10) (not (< storeIndex@47@10 i@65@10))))
(push) ; 6
; [then-branch: 48 | storeIndex@47@10 < i@65@10 && i@65@10 <= right@8@10 | live]
; [else-branch: 48 | !(storeIndex@47@10 < i@65@10 && i@65@10 <= right@8@10) | live]
(push) ; 7
; [then-branch: 48 | storeIndex@47@10 < i@65@10 && i@65@10 <= right@8@10]
(assert (and (< storeIndex@47@10 i@65@10) (<= i@65@10 right@8@10)))
; [eval] loc(a, storeIndex).val <= loc(a, i).val
; [eval] loc(a, storeIndex)
(push) ; 8
(assert (not (and
  (img@52@10 (loc<Ref> a@6@10 storeIndex@47@10))
  (and
    (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 storeIndex@47@10)))
    (<= (inv@51@10 (loc<Ref> a@6@10 storeIndex@47@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, i)
(push) ; 8
(assert (not (and
  (img@52@10 (loc<Ref> a@6@10 i@65@10))
  (and
    (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 i@65@10)))
    (<= (inv@51@10 (loc<Ref> a@6@10 i@65@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 48 | !(storeIndex@47@10 < i@65@10 && i@65@10 <= right@8@10)]
(assert (not (and (< storeIndex@47@10 i@65@10) (<= i@65@10 right@8@10))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (< storeIndex@47@10 i@65@10) (<= i@65@10 right@8@10)))
  (and (< storeIndex@47@10 i@65@10) (<= i@65@10 right@8@10))))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@65@10 Int)) (!
  (and
    (or (< storeIndex@47@10 i@65@10) (not (< storeIndex@47@10 i@65@10)))
    (or
      (not (and (< storeIndex@47@10 i@65@10) (<= i@65@10 right@8@10)))
      (and (< storeIndex@47@10 i@65@10) (<= i@65@10 right@8@10))))
  :pattern ((loc<Ref> a@6@10 i@65@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@146@11@146@100-aux|)))
(push) ; 5
(assert (not (forall ((i@65@10 Int)) (!
  (=>
    (and (< storeIndex@47@10 i@65@10) (<= i@65@10 right@8@10))
    (<=
      ($FVF.lookup_val (as sm@63@10  $FVF<val>) (loc<Ref> a@6@10 storeIndex@47@10))
      ($FVF.lookup_val (as sm@63@10  $FVF<val>) (loc<Ref> a@6@10 i@65@10))))
  :pattern ((loc<Ref> a@6@10 i@65@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@146@11@146@100|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@65@10 Int)) (!
  (=>
    (and (< storeIndex@47@10 i@65@10) (<= i@65@10 right@8@10))
    (<=
      ($FVF.lookup_val (as sm@63@10  $FVF<val>) (loc<Ref> a@6@10 storeIndex@47@10))
      ($FVF.lookup_val (as sm@63@10  $FVF<val>) (loc<Ref> a@6@10 i@65@10))))
  :pattern ((loc<Ref> a@6@10 i@65@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@146@11@146@100|)))
; [eval] |pw| == right + 1
; [eval] |pw|
; [eval] right + 1
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> left <= pw[i] && pw[i] <= right)
(declare-const i@66@10 Int)
(push) ; 5
; [eval] left <= i && i <= right ==> left <= pw[i] && pw[i] <= right
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 6
; [then-branch: 49 | !(left@7@10 <= i@66@10) | live]
; [else-branch: 49 | left@7@10 <= i@66@10 | live]
(push) ; 7
; [then-branch: 49 | !(left@7@10 <= i@66@10)]
(assert (not (<= left@7@10 i@66@10)))
(pop) ; 7
(push) ; 7
; [else-branch: 49 | left@7@10 <= i@66@10]
(assert (<= left@7@10 i@66@10))
; [eval] i <= right
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@66@10) (not (<= left@7@10 i@66@10))))
(push) ; 6
; [then-branch: 50 | left@7@10 <= i@66@10 && i@66@10 <= right@8@10 | live]
; [else-branch: 50 | !(left@7@10 <= i@66@10 && i@66@10 <= right@8@10) | live]
(push) ; 7
; [then-branch: 50 | left@7@10 <= i@66@10 && i@66@10 <= right@8@10]
(assert (and (<= left@7@10 i@66@10) (<= i@66@10 right@8@10)))
; [eval] left <= pw[i] && pw[i] <= right
; [eval] left <= pw[i]
; [eval] pw[i]
(push) ; 8
(assert (not (>= i@66@10 0)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(push) ; 8
(assert (not (< i@66@10 (Seq_length pw@48@10))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(push) ; 8
; [then-branch: 51 | !(left@7@10 <= pw@48@10[i@66@10]) | live]
; [else-branch: 51 | left@7@10 <= pw@48@10[i@66@10] | live]
(push) ; 9
; [then-branch: 51 | !(left@7@10 <= pw@48@10[i@66@10])]
(assert (not (<= left@7@10 (Seq_index pw@48@10 i@66@10))))
(pop) ; 9
(push) ; 9
; [else-branch: 51 | left@7@10 <= pw@48@10[i@66@10]]
(assert (<= left@7@10 (Seq_index pw@48@10 i@66@10)))
; [eval] pw[i] <= right
; [eval] pw[i]
(push) ; 10
(assert (not (>= i@66@10 0)))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(push) ; 10
(assert (not (< i@66@10 (Seq_length pw@48@10))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or
  (<= left@7@10 (Seq_index pw@48@10 i@66@10))
  (not (<= left@7@10 (Seq_index pw@48@10 i@66@10)))))
(pop) ; 7
(push) ; 7
; [else-branch: 50 | !(left@7@10 <= i@66@10 && i@66@10 <= right@8@10)]
(assert (not (and (<= left@7@10 i@66@10) (<= i@66@10 right@8@10))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (=>
  (and (<= left@7@10 i@66@10) (<= i@66@10 right@8@10))
  (and
    (<= left@7@10 i@66@10)
    (<= i@66@10 right@8@10)
    (or
      (<= left@7@10 (Seq_index pw@48@10 i@66@10))
      (not (<= left@7@10 (Seq_index pw@48@10 i@66@10)))))))
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@66@10) (<= i@66@10 right@8@10)))
  (and (<= left@7@10 i@66@10) (<= i@66@10 right@8@10))))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@66@10 Int)) (!
  (and
    (or (<= left@7@10 i@66@10) (not (<= left@7@10 i@66@10)))
    (=>
      (and (<= left@7@10 i@66@10) (<= i@66@10 right@8@10))
      (and
        (<= left@7@10 i@66@10)
        (<= i@66@10 right@8@10)
        (or
          (<= left@7@10 (Seq_index pw@48@10 i@66@10))
          (not (<= left@7@10 (Seq_index pw@48@10 i@66@10))))))
    (or
      (not (and (<= left@7@10 i@66@10) (<= i@66@10 right@8@10)))
      (and (<= left@7@10 i@66@10) (<= i@66@10 right@8@10))))
  :pattern ((Seq_index pw@48@10 i@66@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@149@11@149@87-aux|)))
(push) ; 5
(assert (not (forall ((i@66@10 Int)) (!
  (=>
    (and (<= left@7@10 i@66@10) (<= i@66@10 right@8@10))
    (and
      (<= left@7@10 (Seq_index pw@48@10 i@66@10))
      (<= (Seq_index pw@48@10 i@66@10) right@8@10)))
  :pattern ((Seq_index pw@48@10 i@66@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@149@11@149@87|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@66@10 Int)) (!
  (=>
    (and (<= left@7@10 i@66@10) (<= i@66@10 right@8@10))
    (and
      (<= left@7@10 (Seq_index pw@48@10 i@66@10))
      (<= (Seq_index pw@48@10 i@66@10) right@8@10)))
  :pattern ((Seq_index pw@48@10 i@66@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@149@11@149@87|)))
; [eval] (forall i: Int, j: Int :: { pw[i], pw[j] } left <= i && (i < j && j <= right) ==> pw[i] != pw[j])
(declare-const i@67@10 Int)
(declare-const j@68@10 Int)
(push) ; 5
; [eval] left <= i && (i < j && j <= right) ==> pw[i] != pw[j]
; [eval] left <= i && (i < j && j <= right)
; [eval] left <= i
(push) ; 6
; [then-branch: 52 | !(left@7@10 <= i@67@10) | live]
; [else-branch: 52 | left@7@10 <= i@67@10 | live]
(push) ; 7
; [then-branch: 52 | !(left@7@10 <= i@67@10)]
(assert (not (<= left@7@10 i@67@10)))
(pop) ; 7
(push) ; 7
; [else-branch: 52 | left@7@10 <= i@67@10]
(assert (<= left@7@10 i@67@10))
; [eval] i < j
(push) ; 8
; [then-branch: 53 | !(i@67@10 < j@68@10) | live]
; [else-branch: 53 | i@67@10 < j@68@10 | live]
(push) ; 9
; [then-branch: 53 | !(i@67@10 < j@68@10)]
(assert (not (< i@67@10 j@68@10)))
(pop) ; 9
(push) ; 9
; [else-branch: 53 | i@67@10 < j@68@10]
(assert (< i@67@10 j@68@10))
; [eval] j <= right
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or (< i@67@10 j@68@10) (not (< i@67@10 j@68@10))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= left@7@10 i@67@10)
  (and (<= left@7@10 i@67@10) (or (< i@67@10 j@68@10) (not (< i@67@10 j@68@10))))))
(assert (or (<= left@7@10 i@67@10) (not (<= left@7@10 i@67@10))))
(push) ; 6
; [then-branch: 54 | left@7@10 <= i@67@10 && i@67@10 < j@68@10 && j@68@10 <= right@8@10 | live]
; [else-branch: 54 | !(left@7@10 <= i@67@10 && i@67@10 < j@68@10 && j@68@10 <= right@8@10) | live]
(push) ; 7
; [then-branch: 54 | left@7@10 <= i@67@10 && i@67@10 < j@68@10 && j@68@10 <= right@8@10]
(assert (and (<= left@7@10 i@67@10) (and (< i@67@10 j@68@10) (<= j@68@10 right@8@10))))
; [eval] pw[i] != pw[j]
; [eval] pw[i]
(push) ; 8
(assert (not (>= i@67@10 0)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(push) ; 8
(assert (not (< i@67@10 (Seq_length pw@48@10))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [eval] pw[j]
(push) ; 8
(assert (not (>= j@68@10 0)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(push) ; 8
(assert (not (< j@68@10 (Seq_length pw@48@10))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 54 | !(left@7@10 <= i@67@10 && i@67@10 < j@68@10 && j@68@10 <= right@8@10)]
(assert (not
  (and (<= left@7@10 i@67@10) (and (< i@67@10 j@68@10) (<= j@68@10 right@8@10)))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (=>
  (and (<= left@7@10 i@67@10) (and (< i@67@10 j@68@10) (<= j@68@10 right@8@10)))
  (and (<= left@7@10 i@67@10) (< i@67@10 j@68@10) (<= j@68@10 right@8@10))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= left@7@10 i@67@10)
      (and (< i@67@10 j@68@10) (<= j@68@10 right@8@10))))
  (and (<= left@7@10 i@67@10) (and (< i@67@10 j@68@10) (<= j@68@10 right@8@10)))))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@67@10 Int) (j@68@10 Int)) (!
  (and
    (=>
      (<= left@7@10 i@67@10)
      (and
        (<= left@7@10 i@67@10)
        (or (< i@67@10 j@68@10) (not (< i@67@10 j@68@10)))))
    (or (<= left@7@10 i@67@10) (not (<= left@7@10 i@67@10)))
    (=>
      (and
        (<= left@7@10 i@67@10)
        (and (< i@67@10 j@68@10) (<= j@68@10 right@8@10)))
      (and (<= left@7@10 i@67@10) (< i@67@10 j@68@10) (<= j@68@10 right@8@10)))
    (or
      (not
        (and
          (<= left@7@10 i@67@10)
          (and (< i@67@10 j@68@10) (<= j@68@10 right@8@10))))
      (and
        (<= left@7@10 i@67@10)
        (and (< i@67@10 j@68@10) (<= j@68@10 right@8@10)))))
  :pattern ((Seq_index pw@48@10 i@67@10) (Seq_index pw@48@10 j@68@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@150@11@150@87-aux|)))
(push) ; 5
(assert (not (forall ((i@67@10 Int) (j@68@10 Int)) (!
  (=>
    (and
      (<= left@7@10 i@67@10)
      (and (< i@67@10 j@68@10) (<= j@68@10 right@8@10)))
    (not (= (Seq_index pw@48@10 i@67@10) (Seq_index pw@48@10 j@68@10))))
  :pattern ((Seq_index pw@48@10 i@67@10) (Seq_index pw@48@10 j@68@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@150@11@150@87|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@67@10 Int) (j@68@10 Int)) (!
  (=>
    (and
      (<= left@7@10 i@67@10)
      (and (< i@67@10 j@68@10) (<= j@68@10 right@8@10)))
    (not (= (Seq_index pw@48@10 i@67@10) (Seq_index pw@48@10 j@68@10))))
  :pattern ((Seq_index pw@48@10 i@67@10) (Seq_index pw@48@10 j@68@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@150@11@150@87|)))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val))
(declare-const i@69@10 Int)
(push) ; 5
; [eval] left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 6
; [then-branch: 55 | !(left@7@10 <= i@69@10) | live]
; [else-branch: 55 | left@7@10 <= i@69@10 | live]
(push) ; 7
; [then-branch: 55 | !(left@7@10 <= i@69@10)]
(assert (not (<= left@7@10 i@69@10)))
(pop) ; 7
(push) ; 7
; [else-branch: 55 | left@7@10 <= i@69@10]
(assert (<= left@7@10 i@69@10))
; [eval] i <= right
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@69@10) (not (<= left@7@10 i@69@10))))
(push) ; 6
; [then-branch: 56 | left@7@10 <= i@69@10 && i@69@10 <= right@8@10 | live]
; [else-branch: 56 | !(left@7@10 <= i@69@10 && i@69@10 <= right@8@10) | live]
(push) ; 7
; [then-branch: 56 | left@7@10 <= i@69@10 && i@69@10 <= right@8@10]
(assert (and (<= left@7@10 i@69@10) (<= i@69@10 right@8@10)))
; [eval] loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] loc(a, i)
(push) ; 8
(assert (not (and
  (img@52@10 (loc<Ref> a@6@10 i@69@10))
  (and
    (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 i@69@10)))
    (<= (inv@51@10 (loc<Ref> a@6@10 i@69@10)) right@8@10)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, pw[i]).val)
; [eval] loc(a, pw[i])
; [eval] pw[i]
(push) ; 8
(assert (not (>= i@69@10 0)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(push) ; 8
(assert (not (< i@69@10 (Seq_length pw@48@10))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(push) ; 8
(assert (not (and
  (img@15@10 (loc<Ref> a@6@10 (Seq_index pw@48@10 i@69@10)))
  (and
    (<= left@7@10 (inv@14@10 (loc<Ref> a@6@10 (Seq_index pw@48@10 i@69@10))))
    (<= (inv@14@10 (loc<Ref> a@6@10 (Seq_index pw@48@10 i@69@10))) right@8@10)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 56 | !(left@7@10 <= i@69@10 && i@69@10 <= right@8@10)]
(assert (not (and (<= left@7@10 i@69@10) (<= i@69@10 right@8@10))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@69@10) (<= i@69@10 right@8@10)))
  (and (<= left@7@10 i@69@10) (<= i@69@10 right@8@10))))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@69@10 Int)) (!
  (and
    (or (<= left@7@10 i@69@10) (not (<= left@7@10 i@69@10)))
    (or
      (not (and (<= left@7@10 i@69@10) (<= i@69@10 right@8@10)))
      (and (<= left@7@10 i@69@10) (<= i@69@10 right@8@10))))
  :pattern ((Seq_index pw@48@10 i@69@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@152@11@152@39-aux|)))
(push) ; 5
(assert (not (forall ((i@69@10 Int)) (!
  (=>
    (and (<= left@7@10 i@69@10) (<= i@69@10 right@8@10))
    (=
      ($FVF.lookup_val (as sm@63@10  $FVF<val>) (loc<Ref> a@6@10 i@69@10))
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> a@6@10 (Seq_index
        pw@48@10
        i@69@10)))))
  :pattern ((Seq_index pw@48@10 i@69@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@152@11@152@39|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@69@10 Int)) (!
  (=>
    (and (<= left@7@10 i@69@10) (<= i@69@10 right@8@10))
    (=
      ($FVF.lookup_val (as sm@63@10  $FVF<val>) (loc<Ref> a@6@10 i@69@10))
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> a@6@10 (Seq_index
        pw@48@10
        i@69@10)))))
  :pattern ((Seq_index pw@48@10 i@69@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@152@11@152@39|)))
(pop) ; 4
(push) ; 4
; [else-branch: 43 | n@9@10 != storeIndex@47@10]
(assert (not (= n@9@10 storeIndex@47@10)))
(pop) ; 4
; [eval] !(n == pivotIndex)
; [eval] n == pivotIndex
(push) ; 4
(set-option :timeout 10)
(assert (not (= n@9@10 storeIndex@47@10)))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 10)
(assert (not (not (= n@9@10 storeIndex@47@10))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; [then-branch: 57 | n@9@10 != storeIndex@47@10 | live]
; [else-branch: 57 | n@9@10 == storeIndex@47@10 | live]
(set-option :timeout 0)
(push) ; 4
; [then-branch: 57 | n@9@10 != storeIndex@47@10]
(assert (not (= n@9@10 storeIndex@47@10)))
; [eval] n < pivotIndex
(push) ; 5
(set-option :timeout 10)
(assert (not (not (< n@9@10 storeIndex@47@10))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 10)
(assert (not (< n@9@10 storeIndex@47@10)))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [then-branch: 58 | n@9@10 < storeIndex@47@10 | live]
; [else-branch: 58 | !(n@9@10 < storeIndex@47@10) | live]
(set-option :timeout 0)
(push) ; 5
; [then-branch: 58 | n@9@10 < storeIndex@47@10]
(assert (< n@9@10 storeIndex@47@10))
; [exec]
; storeIndex, pwRec := select_rec(a, left, pivotIndex - 1, n)
; [eval] pivotIndex - 1
; [eval] 0 <= left
; [eval] left <= right
(push) ; 6
(assert (not (<= left@7@10 (- storeIndex@47@10 1))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (<= left@7@10 (- storeIndex@47@10 1)))
; [eval] right < len(a)
; [eval] len(a)
(push) ; 6
(assert (not (< (- storeIndex@47@10 1) (len<Int> a@6@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (< (- storeIndex@47@10 1) (len<Int> a@6@10)))
; [eval] left <= n
; [eval] n <= right
(push) ; 6
(assert (not (<= n@9@10 (- storeIndex@47@10 1))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (<= n@9@10 (- storeIndex@47@10 1)))
(declare-const i@70@10 Int)
(push) ; 6
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 59 | !(left@7@10 <= i@70@10) | live]
; [else-branch: 59 | left@7@10 <= i@70@10 | live]
(push) ; 8
; [then-branch: 59 | !(left@7@10 <= i@70@10)]
(assert (not (<= left@7@10 i@70@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 59 | left@7@10 <= i@70@10]
(assert (<= left@7@10 i@70@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@70@10) (not (<= left@7@10 i@70@10))))
(assert (and (<= left@7@10 i@70@10) (<= i@70@10 (- storeIndex@47@10 1))))
; [eval] loc(a, i)
(pop) ; 6
(declare-fun inv@71@10 ($Ref) Int)
(declare-fun img@72@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@70@10 Int)) (!
  (=>
    (and (<= left@7@10 i@70@10) (<= i@70@10 (- storeIndex@47@10 1)))
    (or (<= left@7@10 i@70@10) (not (<= left@7@10 i@70@10))))
  :pattern ((loc<Ref> a@6@10 i@70@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 6
(assert (not (forall ((i1@70@10 Int) (i2@70@10 Int)) (!
  (=>
    (and
      (and (<= left@7@10 i1@70@10) (<= i1@70@10 (- storeIndex@47@10 1)))
      (and (<= left@7@10 i2@70@10) (<= i2@70@10 (- storeIndex@47@10 1)))
      (= (loc<Ref> a@6@10 i1@70@10) (loc<Ref> a@6@10 i2@70@10)))
    (= i1@70@10 i2@70@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@70@10 Int)) (!
  (=>
    (and (<= left@7@10 i@70@10) (<= i@70@10 (- storeIndex@47@10 1)))
    (and
      (= (inv@71@10 (loc<Ref> a@6@10 i@70@10)) i@70@10)
      (img@72@10 (loc<Ref> a@6@10 i@70@10))))
  :pattern ((loc<Ref> a@6@10 i@70@10))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@72@10 r)
      (and
        (<= left@7@10 (inv@71@10 r))
        (<= (inv@71@10 r) (- storeIndex@47@10 1))))
    (= (loc<Ref> a@6@10 (inv@71@10 r)) r))
  :pattern ((inv@71@10 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@73@10 ((r $Ref)) $Perm
  (ite
    (and
      (and
        (<= left@7@10 (inv@71@10 r))
        (<= (inv@71@10 r) (- storeIndex@47@10 1)))
      (img@72@10 r)
      (= r (loc<Ref> a@6@10 (inv@71@10 r))))
    ($Perm.min
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        $Perm.Write
        $Perm.No)
      $Perm.Write)
    $Perm.No))
; Done precomputing, updating quantified chunks
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Chunk depleted?
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        $Perm.Write
        $Perm.No)
      (pTaken@73@10 r))
    $Perm.No)
  
  :qid |quant-u-64|))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@73@10 r) $Perm.No)
  
  :qid |quant-u-65|))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and
        (<= left@7@10 (inv@71@10 r))
        (<= (inv@71@10 r) (- storeIndex@47@10 1)))
      (img@72@10 r)
      (= r (loc<Ref> a@6@10 (inv@71@10 r))))
    (= (- $Perm.Write (pTaken@73@10 r)) $Perm.No))
  
  :qid |quant-u-66|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@74@10 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@52@10 r)
      (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
    (=
      ($FVF.lookup_val (as sm@74@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@74@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef3|)))
(declare-const storeIndex@75@10 Int)
(declare-const pw@76@10 Seq<Int>)
(declare-const $t@77@10 $Snap)
(assert (= $t@77@10 ($Snap.combine ($Snap.first $t@77@10) ($Snap.second $t@77@10))))
(assert (= ($Snap.first $t@77@10) $Snap.unit))
; [eval] left <= storeIndex
(assert (<= left@7@10 storeIndex@75@10))
(assert (=
  ($Snap.second $t@77@10)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@77@10))
    ($Snap.second ($Snap.second $t@77@10)))))
(assert (= ($Snap.first ($Snap.second $t@77@10)) $Snap.unit))
; [eval] storeIndex <= right
(assert (<= storeIndex@75@10 (- storeIndex@47@10 1)))
(assert (=
  ($Snap.second ($Snap.second $t@77@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@77@10)))
    ($Snap.second ($Snap.second ($Snap.second $t@77@10))))))
(declare-const i@78@10 Int)
(set-option :timeout 0)
(push) ; 6
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 60 | !(left@7@10 <= i@78@10) | live]
; [else-branch: 60 | left@7@10 <= i@78@10 | live]
(push) ; 8
; [then-branch: 60 | !(left@7@10 <= i@78@10)]
(assert (not (<= left@7@10 i@78@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 60 | left@7@10 <= i@78@10]
(assert (<= left@7@10 i@78@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@78@10) (not (<= left@7@10 i@78@10))))
(assert (and (<= left@7@10 i@78@10) (<= i@78@10 (- storeIndex@47@10 1))))
; [eval] loc(a, i)
(pop) ; 6
(declare-fun inv@79@10 ($Ref) Int)
(declare-fun img@80@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@78@10 Int)) (!
  (=>
    (and (<= left@7@10 i@78@10) (<= i@78@10 (- storeIndex@47@10 1)))
    (or (<= left@7@10 i@78@10) (not (<= left@7@10 i@78@10))))
  :pattern ((loc<Ref> a@6@10 i@78@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 6
(assert (not (forall ((i1@78@10 Int) (i2@78@10 Int)) (!
  (=>
    (and
      (and (<= left@7@10 i1@78@10) (<= i1@78@10 (- storeIndex@47@10 1)))
      (and (<= left@7@10 i2@78@10) (<= i2@78@10 (- storeIndex@47@10 1)))
      (= (loc<Ref> a@6@10 i1@78@10) (loc<Ref> a@6@10 i2@78@10)))
    (= i1@78@10 i2@78@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@78@10 Int)) (!
  (=>
    (and (<= left@7@10 i@78@10) (<= i@78@10 (- storeIndex@47@10 1)))
    (and
      (= (inv@79@10 (loc<Ref> a@6@10 i@78@10)) i@78@10)
      (img@80@10 (loc<Ref> a@6@10 i@78@10))))
  :pattern ((loc<Ref> a@6@10 i@78@10))
  :qid |quant-u-68|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@80@10 r)
      (and
        (<= left@7@10 (inv@79@10 r))
        (<= (inv@79@10 r) (- storeIndex@47@10 1))))
    (= (loc<Ref> a@6@10 (inv@79@10 r)) r))
  :pattern ((inv@79@10 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@78@10 Int)) (!
  (=>
    (and (<= left@7@10 i@78@10) (<= i@78@10 (- storeIndex@47@10 1)))
    (not (= (loc<Ref> a@6@10 i@78@10) $Ref.null)))
  :pattern ((loc<Ref> a@6@10 i@78@10))
  :qid |val-permImpliesNonNull|)))
(push) ; 6
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= (loc<Ref> a@6@10 i@78@10) (loc<Ref> a@6@10 i@50@10))
    (=
      (and
        (img@80@10 r)
        (and
          (<= left@7@10 (inv@79@10 r))
          (<= (inv@79@10 r) (- storeIndex@47@10 1))))
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))))
  
  :qid |quant-u-69|))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@77@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@77@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@77@10))))
  $Snap.unit))
; [eval] storeIndex == n
(assert (= storeIndex@75@10 n@9@10))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10)))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val)
(declare-const i@81@10 Int)
(set-option :timeout 0)
(push) ; 6
; [eval] left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val
; [eval] left <= i && i < storeIndex
; [eval] left <= i
(push) ; 7
; [then-branch: 61 | !(left@7@10 <= i@81@10) | live]
; [else-branch: 61 | left@7@10 <= i@81@10 | live]
(push) ; 8
; [then-branch: 61 | !(left@7@10 <= i@81@10)]
(assert (not (<= left@7@10 i@81@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 61 | left@7@10 <= i@81@10]
(assert (<= left@7@10 i@81@10))
; [eval] i < storeIndex
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@81@10) (not (<= left@7@10 i@81@10))))
(push) ; 7
; [then-branch: 62 | left@7@10 <= i@81@10 && i@81@10 < storeIndex@75@10 | live]
; [else-branch: 62 | !(left@7@10 <= i@81@10 && i@81@10 < storeIndex@75@10) | live]
(push) ; 8
; [then-branch: 62 | left@7@10 <= i@81@10 && i@81@10 < storeIndex@75@10]
(assert (and (<= left@7@10 i@81@10) (< i@81@10 storeIndex@75@10)))
; [eval] loc(a, i).val <= loc(a, storeIndex).val
; [eval] loc(a, i)
(declare-const sm@82@10 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@80@10 r)
      (and
        (<= left@7@10 (inv@79@10 r))
        (<= (inv@79@10 r) (- storeIndex@47@10 1))))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
  :qid |qp.fvfValDef5|)))
(declare-const pm@83@10 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@83@10  $FPM) r)
    (+
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (- $Perm.Write (pTaken@73@10 r))
        $Perm.No)
      (ite
        (and
          (img@80@10 r)
          (and
            (<= left@7@10 (inv@79@10 r))
            (<= (inv@79@10 r) (- storeIndex@47@10 1))))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@83@10  $FPM) r))
  :qid |qp.resPrmSumDef6|)))
(push) ; 9
(assert (not (< $Perm.No ($FVF.perm_val (as pm@83@10  $FPM) (loc<Ref> a@6@10 i@81@10)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, storeIndex)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
    :qid |qp.fvfValDef4|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@80@10 r)
        (and
          (<= left@7@10 (inv@79@10 r))
          (<= (inv@79@10 r) (- storeIndex@47@10 1))))
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
    :qid |qp.fvfValDef5|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@52@10 (loc<Ref> a@6@10 storeIndex@75@10))
        (and
          (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 storeIndex@75@10)))
          (<= (inv@51@10 (loc<Ref> a@6@10 storeIndex@75@10)) right@8@10)))
      (- $Perm.Write (pTaken@73@10 (loc<Ref> a@6@10 storeIndex@75@10)))
      $Perm.No)
    (ite
      (and
        (img@80@10 (loc<Ref> a@6@10 storeIndex@75@10))
        (and
          (<= left@7@10 (inv@79@10 (loc<Ref> a@6@10 storeIndex@75@10)))
          (<=
            (inv@79@10 (loc<Ref> a@6@10 storeIndex@75@10))
            (- storeIndex@47@10 1))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 62 | !(left@7@10 <= i@81@10 && i@81@10 < storeIndex@75@10)]
(assert (not (and (<= left@7@10 i@81@10) (< i@81@10 storeIndex@75@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@80@10 r)
      (and
        (<= left@7@10 (inv@79@10 r))
        (<= (inv@79@10 r) (- storeIndex@47@10 1))))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
  :qid |qp.fvfValDef5|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@83@10  $FPM) r)
    (+
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (- $Perm.Write (pTaken@73@10 r))
        $Perm.No)
      (ite
        (and
          (img@80@10 r)
          (and
            (<= left@7@10 (inv@79@10 r))
            (<= (inv@79@10 r) (- storeIndex@47@10 1))))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@83@10  $FPM) r))
  :qid |qp.resPrmSumDef6|)))
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@81@10) (< i@81@10 storeIndex@75@10)))
  (and (<= left@7@10 i@81@10) (< i@81@10 storeIndex@75@10))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@80@10 r)
      (and
        (<= left@7@10 (inv@79@10 r))
        (<= (inv@79@10 r) (- storeIndex@47@10 1))))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
  :qid |qp.fvfValDef5|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@83@10  $FPM) r)
    (+
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (- $Perm.Write (pTaken@73@10 r))
        $Perm.No)
      (ite
        (and
          (img@80@10 r)
          (and
            (<= left@7@10 (inv@79@10 r))
            (<= (inv@79@10 r) (- storeIndex@47@10 1))))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@83@10  $FPM) r))
  :qid |qp.resPrmSumDef6|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@81@10 Int)) (!
  (and
    (or (<= left@7@10 i@81@10) (not (<= left@7@10 i@81@10)))
    (or
      (not (and (<= left@7@10 i@81@10) (< i@81@10 storeIndex@75@10)))
      (and (<= left@7@10 i@81@10) (< i@81@10 storeIndex@75@10))))
  :pattern ((loc<Ref> a@6@10 i@81@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100-aux|)))
(assert (forall ((i@81@10 Int)) (!
  (=>
    (and (<= left@7@10 i@81@10) (< i@81@10 storeIndex@75@10))
    (<=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) (loc<Ref> a@6@10 i@81@10))
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) (loc<Ref> a@6@10 storeIndex@75@10))))
  :pattern ((loc<Ref> a@6@10 i@81@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10))))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val)
(declare-const i@84@10 Int)
(push) ; 6
; [eval] storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val
; [eval] storeIndex < i && i <= right
; [eval] storeIndex < i
(push) ; 7
; [then-branch: 63 | !(storeIndex@75@10 < i@84@10) | live]
; [else-branch: 63 | storeIndex@75@10 < i@84@10 | live]
(push) ; 8
; [then-branch: 63 | !(storeIndex@75@10 < i@84@10)]
(assert (not (< storeIndex@75@10 i@84@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 63 | storeIndex@75@10 < i@84@10]
(assert (< storeIndex@75@10 i@84@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (< storeIndex@75@10 i@84@10) (not (< storeIndex@75@10 i@84@10))))
(push) ; 7
; [then-branch: 64 | storeIndex@75@10 < i@84@10 && i@84@10 <= storeIndex@47@10 - 1 | live]
; [else-branch: 64 | !(storeIndex@75@10 < i@84@10 && i@84@10 <= storeIndex@47@10 - 1) | live]
(push) ; 8
; [then-branch: 64 | storeIndex@75@10 < i@84@10 && i@84@10 <= storeIndex@47@10 - 1]
(assert (and (< storeIndex@75@10 i@84@10) (<= i@84@10 (- storeIndex@47@10 1))))
; [eval] loc(a, storeIndex).val <= loc(a, i).val
; [eval] loc(a, storeIndex)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
    :qid |qp.fvfValDef4|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@80@10 r)
        (and
          (<= left@7@10 (inv@79@10 r))
          (<= (inv@79@10 r) (- storeIndex@47@10 1))))
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
    :qid |qp.fvfValDef5|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@52@10 (loc<Ref> a@6@10 storeIndex@75@10))
        (and
          (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 storeIndex@75@10)))
          (<= (inv@51@10 (loc<Ref> a@6@10 storeIndex@75@10)) right@8@10)))
      (- $Perm.Write (pTaken@73@10 (loc<Ref> a@6@10 storeIndex@75@10)))
      $Perm.No)
    (ite
      (and
        (img@80@10 (loc<Ref> a@6@10 storeIndex@75@10))
        (and
          (<= left@7@10 (inv@79@10 (loc<Ref> a@6@10 storeIndex@75@10)))
          (<=
            (inv@79@10 (loc<Ref> a@6@10 storeIndex@75@10))
            (- storeIndex@47@10 1))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
    :qid |qp.fvfValDef4|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@80@10 r)
        (and
          (<= left@7@10 (inv@79@10 r))
          (<= (inv@79@10 r) (- storeIndex@47@10 1))))
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
    :qid |qp.fvfValDef5|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@52@10 (loc<Ref> a@6@10 i@84@10))
        (and
          (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 i@84@10)))
          (<= (inv@51@10 (loc<Ref> a@6@10 i@84@10)) right@8@10)))
      (- $Perm.Write (pTaken@73@10 (loc<Ref> a@6@10 i@84@10)))
      $Perm.No)
    (ite
      (and
        (img@80@10 (loc<Ref> a@6@10 i@84@10))
        (and
          (<= left@7@10 (inv@79@10 (loc<Ref> a@6@10 i@84@10)))
          (<= (inv@79@10 (loc<Ref> a@6@10 i@84@10)) (- storeIndex@47@10 1))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 64 | !(storeIndex@75@10 < i@84@10 && i@84@10 <= storeIndex@47@10 - 1)]
(assert (not (and (< storeIndex@75@10 i@84@10) (<= i@84@10 (- storeIndex@47@10 1)))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@80@10 r)
      (and
        (<= left@7@10 (inv@79@10 r))
        (<= (inv@79@10 r) (- storeIndex@47@10 1))))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
  :qid |qp.fvfValDef5|)))
; Joined path conditions
(assert (or
  (not (and (< storeIndex@75@10 i@84@10) (<= i@84@10 (- storeIndex@47@10 1))))
  (and (< storeIndex@75@10 i@84@10) (<= i@84@10 (- storeIndex@47@10 1)))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@80@10 r)
      (and
        (<= left@7@10 (inv@79@10 r))
        (<= (inv@79@10 r) (- storeIndex@47@10 1))))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
  :qid |qp.fvfValDef5|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@84@10 Int)) (!
  (and
    (or (< storeIndex@75@10 i@84@10) (not (< storeIndex@75@10 i@84@10)))
    (or
      (not
        (and (< storeIndex@75@10 i@84@10) (<= i@84@10 (- storeIndex@47@10 1))))
      (and (< storeIndex@75@10 i@84@10) (<= i@84@10 (- storeIndex@47@10 1)))))
  :pattern ((loc<Ref> a@6@10 i@84@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@146@11@146@100-aux|)))
(assert (forall ((i@84@10 Int)) (!
  (=>
    (and (< storeIndex@75@10 i@84@10) (<= i@84@10 (- storeIndex@47@10 1)))
    (<=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) (loc<Ref> a@6@10 storeIndex@75@10))
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) (loc<Ref> a@6@10 i@84@10))))
  :pattern ((loc<Ref> a@6@10 i@84@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@146@11@146@100|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10)))))))
  $Snap.unit))
; [eval] |pw| == right + 1
; [eval] |pw|
; [eval] right + 1
(assert (= (Seq_length pw@76@10) (+ (- storeIndex@47@10 1) 1)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> left <= pw[i] && pw[i] <= right)
(declare-const i@85@10 Int)
(push) ; 6
; [eval] left <= i && i <= right ==> left <= pw[i] && pw[i] <= right
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 65 | !(left@7@10 <= i@85@10) | live]
; [else-branch: 65 | left@7@10 <= i@85@10 | live]
(push) ; 8
; [then-branch: 65 | !(left@7@10 <= i@85@10)]
(assert (not (<= left@7@10 i@85@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 65 | left@7@10 <= i@85@10]
(assert (<= left@7@10 i@85@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@85@10) (not (<= left@7@10 i@85@10))))
(push) ; 7
; [then-branch: 66 | left@7@10 <= i@85@10 && i@85@10 <= storeIndex@47@10 - 1 | live]
; [else-branch: 66 | !(left@7@10 <= i@85@10 && i@85@10 <= storeIndex@47@10 - 1) | live]
(push) ; 8
; [then-branch: 66 | left@7@10 <= i@85@10 && i@85@10 <= storeIndex@47@10 - 1]
(assert (and (<= left@7@10 i@85@10) (<= i@85@10 (- storeIndex@47@10 1))))
; [eval] left <= pw[i] && pw[i] <= right
; [eval] left <= pw[i]
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@85@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@85@10 (Seq_length pw@76@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
; [then-branch: 67 | !(left@7@10 <= pw@76@10[i@85@10]) | live]
; [else-branch: 67 | left@7@10 <= pw@76@10[i@85@10] | live]
(push) ; 10
; [then-branch: 67 | !(left@7@10 <= pw@76@10[i@85@10])]
(assert (not (<= left@7@10 (Seq_index pw@76@10 i@85@10))))
(pop) ; 10
(push) ; 10
; [else-branch: 67 | left@7@10 <= pw@76@10[i@85@10]]
(assert (<= left@7@10 (Seq_index pw@76@10 i@85@10)))
; [eval] pw[i] <= right
; [eval] pw[i]
(push) ; 11
(assert (not (>= i@85@10 0)))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(push) ; 11
(assert (not (< i@85@10 (Seq_length pw@76@10))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or
  (<= left@7@10 (Seq_index pw@76@10 i@85@10))
  (not (<= left@7@10 (Seq_index pw@76@10 i@85@10)))))
(pop) ; 8
(push) ; 8
; [else-branch: 66 | !(left@7@10 <= i@85@10 && i@85@10 <= storeIndex@47@10 - 1)]
(assert (not (and (<= left@7@10 i@85@10) (<= i@85@10 (- storeIndex@47@10 1)))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (=>
  (and (<= left@7@10 i@85@10) (<= i@85@10 (- storeIndex@47@10 1)))
  (and
    (<= left@7@10 i@85@10)
    (<= i@85@10 (- storeIndex@47@10 1))
    (or
      (<= left@7@10 (Seq_index pw@76@10 i@85@10))
      (not (<= left@7@10 (Seq_index pw@76@10 i@85@10)))))))
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@85@10) (<= i@85@10 (- storeIndex@47@10 1))))
  (and (<= left@7@10 i@85@10) (<= i@85@10 (- storeIndex@47@10 1)))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@85@10 Int)) (!
  (and
    (or (<= left@7@10 i@85@10) (not (<= left@7@10 i@85@10)))
    (=>
      (and (<= left@7@10 i@85@10) (<= i@85@10 (- storeIndex@47@10 1)))
      (and
        (<= left@7@10 i@85@10)
        (<= i@85@10 (- storeIndex@47@10 1))
        (or
          (<= left@7@10 (Seq_index pw@76@10 i@85@10))
          (not (<= left@7@10 (Seq_index pw@76@10 i@85@10))))))
    (or
      (not (and (<= left@7@10 i@85@10) (<= i@85@10 (- storeIndex@47@10 1))))
      (and (<= left@7@10 i@85@10) (<= i@85@10 (- storeIndex@47@10 1)))))
  :pattern ((Seq_index pw@76@10 i@85@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@149@11@149@87-aux|)))
(assert (forall ((i@85@10 Int)) (!
  (=>
    (and (<= left@7@10 i@85@10) (<= i@85@10 (- storeIndex@47@10 1)))
    (and
      (<= left@7@10 (Seq_index pw@76@10 i@85@10))
      (<= (Seq_index pw@76@10 i@85@10) (- storeIndex@47@10 1))))
  :pattern ((Seq_index pw@76@10 i@85@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@149@11@149@87|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10)))))))))
  $Snap.unit))
; [eval] (forall i: Int, j: Int :: { pw[i], pw[j] } left <= i && (i < j && j <= right) ==> pw[i] != pw[j])
(declare-const i@86@10 Int)
(declare-const j@87@10 Int)
(push) ; 6
; [eval] left <= i && (i < j && j <= right) ==> pw[i] != pw[j]
; [eval] left <= i && (i < j && j <= right)
; [eval] left <= i
(push) ; 7
; [then-branch: 68 | !(left@7@10 <= i@86@10) | live]
; [else-branch: 68 | left@7@10 <= i@86@10 | live]
(push) ; 8
; [then-branch: 68 | !(left@7@10 <= i@86@10)]
(assert (not (<= left@7@10 i@86@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 68 | left@7@10 <= i@86@10]
(assert (<= left@7@10 i@86@10))
; [eval] i < j
(push) ; 9
; [then-branch: 69 | !(i@86@10 < j@87@10) | live]
; [else-branch: 69 | i@86@10 < j@87@10 | live]
(push) ; 10
; [then-branch: 69 | !(i@86@10 < j@87@10)]
(assert (not (< i@86@10 j@87@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 69 | i@86@10 < j@87@10]
(assert (< i@86@10 j@87@10))
; [eval] j <= right
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (< i@86@10 j@87@10) (not (< i@86@10 j@87@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= left@7@10 i@86@10)
  (and (<= left@7@10 i@86@10) (or (< i@86@10 j@87@10) (not (< i@86@10 j@87@10))))))
(assert (or (<= left@7@10 i@86@10) (not (<= left@7@10 i@86@10))))
(push) ; 7
; [then-branch: 70 | left@7@10 <= i@86@10 && i@86@10 < j@87@10 && j@87@10 <= storeIndex@47@10 - 1 | live]
; [else-branch: 70 | !(left@7@10 <= i@86@10 && i@86@10 < j@87@10 && j@87@10 <= storeIndex@47@10 - 1) | live]
(push) ; 8
; [then-branch: 70 | left@7@10 <= i@86@10 && i@86@10 < j@87@10 && j@87@10 <= storeIndex@47@10 - 1]
(assert (and
  (<= left@7@10 i@86@10)
  (and (< i@86@10 j@87@10) (<= j@87@10 (- storeIndex@47@10 1)))))
; [eval] pw[i] != pw[j]
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@86@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@86@10 (Seq_length pw@76@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] pw[j]
(push) ; 9
(assert (not (>= j@87@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< j@87@10 (Seq_length pw@76@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 70 | !(left@7@10 <= i@86@10 && i@86@10 < j@87@10 && j@87@10 <= storeIndex@47@10 - 1)]
(assert (not
  (and
    (<= left@7@10 i@86@10)
    (and (< i@86@10 j@87@10) (<= j@87@10 (- storeIndex@47@10 1))))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (=>
  (and
    (<= left@7@10 i@86@10)
    (and (< i@86@10 j@87@10) (<= j@87@10 (- storeIndex@47@10 1))))
  (and
    (<= left@7@10 i@86@10)
    (< i@86@10 j@87@10)
    (<= j@87@10 (- storeIndex@47@10 1)))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= left@7@10 i@86@10)
      (and (< i@86@10 j@87@10) (<= j@87@10 (- storeIndex@47@10 1)))))
  (and
    (<= left@7@10 i@86@10)
    (and (< i@86@10 j@87@10) (<= j@87@10 (- storeIndex@47@10 1))))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@86@10 Int) (j@87@10 Int)) (!
  (and
    (=>
      (<= left@7@10 i@86@10)
      (and
        (<= left@7@10 i@86@10)
        (or (< i@86@10 j@87@10) (not (< i@86@10 j@87@10)))))
    (or (<= left@7@10 i@86@10) (not (<= left@7@10 i@86@10)))
    (=>
      (and
        (<= left@7@10 i@86@10)
        (and (< i@86@10 j@87@10) (<= j@87@10 (- storeIndex@47@10 1))))
      (and
        (<= left@7@10 i@86@10)
        (< i@86@10 j@87@10)
        (<= j@87@10 (- storeIndex@47@10 1))))
    (or
      (not
        (and
          (<= left@7@10 i@86@10)
          (and (< i@86@10 j@87@10) (<= j@87@10 (- storeIndex@47@10 1)))))
      (and
        (<= left@7@10 i@86@10)
        (and (< i@86@10 j@87@10) (<= j@87@10 (- storeIndex@47@10 1))))))
  :pattern ((Seq_index pw@76@10 i@86@10) (Seq_index pw@76@10 j@87@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@150@11@150@87-aux|)))
(assert (forall ((i@86@10 Int) (j@87@10 Int)) (!
  (=>
    (and
      (<= left@7@10 i@86@10)
      (and (< i@86@10 j@87@10) (<= j@87@10 (- storeIndex@47@10 1))))
    (not (= (Seq_index pw@76@10 i@86@10) (Seq_index pw@76@10 j@87@10))))
  :pattern ((Seq_index pw@76@10 i@86@10) (Seq_index pw@76@10 j@87@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@150@11@150@87|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@77@10)))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val))
(declare-const i@88@10 Int)
(push) ; 6
; [eval] left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 71 | !(left@7@10 <= i@88@10) | live]
; [else-branch: 71 | left@7@10 <= i@88@10 | live]
(push) ; 8
; [then-branch: 71 | !(left@7@10 <= i@88@10)]
(assert (not (<= left@7@10 i@88@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 71 | left@7@10 <= i@88@10]
(assert (<= left@7@10 i@88@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@88@10) (not (<= left@7@10 i@88@10))))
(push) ; 7
; [then-branch: 72 | left@7@10 <= i@88@10 && i@88@10 <= storeIndex@47@10 - 1 | live]
; [else-branch: 72 | !(left@7@10 <= i@88@10 && i@88@10 <= storeIndex@47@10 - 1) | live]
(push) ; 8
; [then-branch: 72 | left@7@10 <= i@88@10 && i@88@10 <= storeIndex@47@10 - 1]
(assert (and (<= left@7@10 i@88@10) (<= i@88@10 (- storeIndex@47@10 1))))
; [eval] loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] loc(a, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
    :qid |qp.fvfValDef4|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@80@10 r)
        (and
          (<= left@7@10 (inv@79@10 r))
          (<= (inv@79@10 r) (- storeIndex@47@10 1))))
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
    :qid |qp.fvfValDef5|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@52@10 (loc<Ref> a@6@10 i@88@10))
        (and
          (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 i@88@10)))
          (<= (inv@51@10 (loc<Ref> a@6@10 i@88@10)) right@8@10)))
      (- $Perm.Write (pTaken@73@10 (loc<Ref> a@6@10 i@88@10)))
      $Perm.No)
    (ite
      (and
        (img@80@10 (loc<Ref> a@6@10 i@88@10))
        (and
          (<= left@7@10 (inv@79@10 (loc<Ref> a@6@10 i@88@10)))
          (<= (inv@79@10 (loc<Ref> a@6@10 i@88@10)) (- storeIndex@47@10 1))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, pw[i]).val)
; [eval] loc(a, pw[i])
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@88@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@88@10 (Seq_length pw@76@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (and
  (img@52@10 (loc<Ref> a@6@10 (Seq_index pw@76@10 i@88@10)))
  (and
    (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 (Seq_index pw@76@10 i@88@10))))
    (<= (inv@51@10 (loc<Ref> a@6@10 (Seq_index pw@76@10 i@88@10))) right@8@10)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 72 | !(left@7@10 <= i@88@10 && i@88@10 <= storeIndex@47@10 - 1)]
(assert (not (and (<= left@7@10 i@88@10) (<= i@88@10 (- storeIndex@47@10 1)))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@80@10 r)
      (and
        (<= left@7@10 (inv@79@10 r))
        (<= (inv@79@10 r) (- storeIndex@47@10 1))))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
  :qid |qp.fvfValDef5|)))
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@88@10) (<= i@88@10 (- storeIndex@47@10 1))))
  (and (<= left@7@10 i@88@10) (<= i@88@10 (- storeIndex@47@10 1)))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@80@10 r)
      (and
        (<= left@7@10 (inv@79@10 r))
        (<= (inv@79@10 r) (- storeIndex@47@10 1))))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
  :qid |qp.fvfValDef5|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@88@10 Int)) (!
  (and
    (or (<= left@7@10 i@88@10) (not (<= left@7@10 i@88@10)))
    (or
      (not (and (<= left@7@10 i@88@10) (<= i@88@10 (- storeIndex@47@10 1))))
      (and (<= left@7@10 i@88@10) (<= i@88@10 (- storeIndex@47@10 1)))))
  :pattern ((Seq_index pw@76@10 i@88@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@152@11@152@39-aux|)))
(assert (forall ((i@88@10 Int)) (!
  (=>
    (and (<= left@7@10 i@88@10) (<= i@88@10 (- storeIndex@47@10 1)))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) (loc<Ref> a@6@10 i@88@10))
      ($FVF.lookup_val (as sm@74@10  $FVF<val>) (loc<Ref> a@6@10 (Seq_index
        pw@76@10
        i@88@10)))))
  :pattern ((Seq_index pw@76@10 i@88@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@152@11@152@39|)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
; [exec]
; assert dummy(pwRec[storeIndex])
; [eval] dummy(pwRec[storeIndex])
; [eval] pwRec[storeIndex]
(set-option :timeout 0)
(push) ; 6
(assert (not (>= storeIndex@75@10 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (< storeIndex@75@10 (Seq_length pw@76@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (dummy%precondition $Snap.unit (Seq_index pw@76@10 storeIndex@75@10)))
(pop) ; 6
; Joined path conditions
(assert (dummy%precondition $Snap.unit (Seq_index pw@76@10 storeIndex@75@10)))
(push) ; 6
(assert (not (dummy $Snap.unit (Seq_index pw@76@10 storeIndex@75@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (dummy $Snap.unit (Seq_index pw@76@10 storeIndex@75@10)))
; [exec]
; inhale |pw| == right + 1
(declare-const $t@89@10 $Snap)
(assert (= $t@89@10 $Snap.unit))
; [eval] |pw| == right + 1
; [eval] |pw|
; [eval] right + 1
(assert (= (Seq_length pw@11@10) (+ right@8@10 1)))
; State saturation: after inhale
(set-option :timeout 20)
(check-sat)
; unknown
; [exec]
; inhale (forall i: Int ::
;     { pw[i] }
;     { pwPar[pwRec[i]] }
;     left <= i && i <= pivotIndex - 1 ==> pw[i] == pwPar[pwRec[i]])
(declare-const $t@90@10 $Snap)
(assert (= $t@90@10 $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } { pwPar[pwRec[i]] } left <= i && i <= pivotIndex - 1 ==> pw[i] == pwPar[pwRec[i]])
(declare-const i@91@10 Int)
(set-option :timeout 0)
(push) ; 6
; [eval] left <= i && i <= pivotIndex - 1 ==> pw[i] == pwPar[pwRec[i]]
; [eval] left <= i && i <= pivotIndex - 1
; [eval] left <= i
(push) ; 7
; [then-branch: 73 | !(left@7@10 <= i@91@10) | live]
; [else-branch: 73 | left@7@10 <= i@91@10 | live]
(push) ; 8
; [then-branch: 73 | !(left@7@10 <= i@91@10)]
(assert (not (<= left@7@10 i@91@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 73 | left@7@10 <= i@91@10]
(assert (<= left@7@10 i@91@10))
; [eval] i <= pivotIndex - 1
; [eval] pivotIndex - 1
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@91@10) (not (<= left@7@10 i@91@10))))
(push) ; 7
; [then-branch: 74 | left@7@10 <= i@91@10 && i@91@10 <= storeIndex@47@10 - 1 | live]
; [else-branch: 74 | !(left@7@10 <= i@91@10 && i@91@10 <= storeIndex@47@10 - 1) | live]
(push) ; 8
; [then-branch: 74 | left@7@10 <= i@91@10 && i@91@10 <= storeIndex@47@10 - 1]
(assert (and (<= left@7@10 i@91@10) (<= i@91@10 (- storeIndex@47@10 1))))
; [eval] pw[i] == pwPar[pwRec[i]]
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@91@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@91@10 (Seq_length pw@11@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] pwPar[pwRec[i]]
; [eval] pwRec[i]
(push) ; 9
(assert (not (>= i@91@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@91@10 (Seq_length pw@76@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (>= (Seq_index pw@76@10 i@91@10) 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< (Seq_index pw@76@10 i@91@10) (Seq_length pw@48@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 74 | !(left@7@10 <= i@91@10 && i@91@10 <= storeIndex@47@10 - 1)]
(assert (not (and (<= left@7@10 i@91@10) (<= i@91@10 (- storeIndex@47@10 1)))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@91@10) (<= i@91@10 (- storeIndex@47@10 1))))
  (and (<= left@7@10 i@91@10) (<= i@91@10 (- storeIndex@47@10 1)))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@91@10 Int)) (!
  (and
    (or (<= left@7@10 i@91@10) (not (<= left@7@10 i@91@10)))
    (or
      (not (and (<= left@7@10 i@91@10) (<= i@91@10 (- storeIndex@47@10 1))))
      (and (<= left@7@10 i@91@10) (<= i@91@10 (- storeIndex@47@10 1)))))
  :pattern ((Seq_index pw@11@10 i@91@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@197@14@197@92-aux|)))
(assert (forall ((i@91@10 Int)) (!
  (and
    (or (<= left@7@10 i@91@10) (not (<= left@7@10 i@91@10)))
    (or
      (not (and (<= left@7@10 i@91@10) (<= i@91@10 (- storeIndex@47@10 1))))
      (and (<= left@7@10 i@91@10) (<= i@91@10 (- storeIndex@47@10 1)))))
  :pattern ((Seq_index pw@48@10 (Seq_index pw@76@10 i@91@10)))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@197@14@197@92-aux|)))
(assert (forall ((i@91@10 Int)) (!
  (=>
    (and (<= left@7@10 i@91@10) (<= i@91@10 (- storeIndex@47@10 1)))
    (=
      (Seq_index pw@11@10 i@91@10)
      (Seq_index pw@48@10 (Seq_index pw@76@10 i@91@10))))
  :pattern ((Seq_index pw@11@10 i@91@10))
  :pattern ((Seq_index pw@48@10 (Seq_index pw@76@10 i@91@10)))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@197@14@197@92|)))
; State saturation: after inhale
(set-option :timeout 20)
(check-sat)
; unknown
; [exec]
; inhale (forall i: Int ::
;     { pw[i] }
;     { pwPar[i] }
;     pivotIndex <= i && i <= right ==> pw[i] == pwPar[i])
(declare-const $t@92@10 $Snap)
(assert (= $t@92@10 $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } { pwPar[i] } pivotIndex <= i && i <= right ==> pw[i] == pwPar[i])
(declare-const i@93@10 Int)
(set-option :timeout 0)
(push) ; 6
; [eval] pivotIndex <= i && i <= right ==> pw[i] == pwPar[i]
; [eval] pivotIndex <= i && i <= right
; [eval] pivotIndex <= i
(push) ; 7
; [then-branch: 75 | !(storeIndex@47@10 <= i@93@10) | live]
; [else-branch: 75 | storeIndex@47@10 <= i@93@10 | live]
(push) ; 8
; [then-branch: 75 | !(storeIndex@47@10 <= i@93@10)]
(assert (not (<= storeIndex@47@10 i@93@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 75 | storeIndex@47@10 <= i@93@10]
(assert (<= storeIndex@47@10 i@93@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= storeIndex@47@10 i@93@10) (not (<= storeIndex@47@10 i@93@10))))
(push) ; 7
; [then-branch: 76 | storeIndex@47@10 <= i@93@10 && i@93@10 <= right@8@10 | live]
; [else-branch: 76 | !(storeIndex@47@10 <= i@93@10 && i@93@10 <= right@8@10) | live]
(push) ; 8
; [then-branch: 76 | storeIndex@47@10 <= i@93@10 && i@93@10 <= right@8@10]
(assert (and (<= storeIndex@47@10 i@93@10) (<= i@93@10 right@8@10)))
; [eval] pw[i] == pwPar[i]
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@93@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@93@10 (Seq_length pw@11@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] pwPar[i]
(push) ; 9
(assert (not (>= i@93@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@93@10 (Seq_length pw@48@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 76 | !(storeIndex@47@10 <= i@93@10 && i@93@10 <= right@8@10)]
(assert (not (and (<= storeIndex@47@10 i@93@10) (<= i@93@10 right@8@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= storeIndex@47@10 i@93@10) (<= i@93@10 right@8@10)))
  (and (<= storeIndex@47@10 i@93@10) (<= i@93@10 right@8@10))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@93@10 Int)) (!
  (and
    (or (<= storeIndex@47@10 i@93@10) (not (<= storeIndex@47@10 i@93@10)))
    (or
      (not (and (<= storeIndex@47@10 i@93@10) (<= i@93@10 right@8@10)))
      (and (<= storeIndex@47@10 i@93@10) (<= i@93@10 right@8@10))))
  :pattern ((Seq_index pw@11@10 i@93@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@198@14@198@82-aux|)))
(assert (forall ((i@93@10 Int)) (!
  (and
    (or (<= storeIndex@47@10 i@93@10) (not (<= storeIndex@47@10 i@93@10)))
    (or
      (not (and (<= storeIndex@47@10 i@93@10) (<= i@93@10 right@8@10)))
      (and (<= storeIndex@47@10 i@93@10) (<= i@93@10 right@8@10))))
  :pattern ((Seq_index pw@48@10 i@93@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@198@14@198@82-aux|)))
(assert (forall ((i@93@10 Int)) (!
  (=>
    (and (<= storeIndex@47@10 i@93@10) (<= i@93@10 right@8@10))
    (= (Seq_index pw@11@10 i@93@10) (Seq_index pw@48@10 i@93@10)))
  :pattern ((Seq_index pw@11@10 i@93@10))
  :pattern ((Seq_index pw@48@10 i@93@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@198@14@198@82|)))
; State saturation: after inhale
(set-option :timeout 20)
(check-sat)
; unknown
; [eval] left <= storeIndex
; [eval] storeIndex <= right
(set-option :timeout 0)
(push) ; 6
(assert (not (<= storeIndex@75@10 right@8@10)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (<= storeIndex@75@10 right@8@10))
(declare-const i@94@10 Int)
(push) ; 6
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 77 | !(left@7@10 <= i@94@10) | live]
; [else-branch: 77 | left@7@10 <= i@94@10 | live]
(push) ; 8
; [then-branch: 77 | !(left@7@10 <= i@94@10)]
(assert (not (<= left@7@10 i@94@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 77 | left@7@10 <= i@94@10]
(assert (<= left@7@10 i@94@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@94@10) (not (<= left@7@10 i@94@10))))
(assert (and (<= left@7@10 i@94@10) (<= i@94@10 right@8@10)))
; [eval] loc(a, i)
(pop) ; 6
(declare-fun inv@95@10 ($Ref) Int)
(declare-fun img@96@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@94@10 Int)) (!
  (=>
    (and (<= left@7@10 i@94@10) (<= i@94@10 right@8@10))
    (or (<= left@7@10 i@94@10) (not (<= left@7@10 i@94@10))))
  :pattern ((loc<Ref> a@6@10 i@94@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 6
(assert (not (forall ((i1@94@10 Int) (i2@94@10 Int)) (!
  (=>
    (and
      (and (<= left@7@10 i1@94@10) (<= i1@94@10 right@8@10))
      (and (<= left@7@10 i2@94@10) (<= i2@94@10 right@8@10))
      (= (loc<Ref> a@6@10 i1@94@10) (loc<Ref> a@6@10 i2@94@10)))
    (= i1@94@10 i2@94@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@94@10 Int)) (!
  (=>
    (and (<= left@7@10 i@94@10) (<= i@94@10 right@8@10))
    (and
      (= (inv@95@10 (loc<Ref> a@6@10 i@94@10)) i@94@10)
      (img@96@10 (loc<Ref> a@6@10 i@94@10))))
  :pattern ((loc<Ref> a@6@10 i@94@10))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@96@10 r)
      (and (<= left@7@10 (inv@95@10 r)) (<= (inv@95@10 r) right@8@10)))
    (= (loc<Ref> a@6@10 (inv@95@10 r)) r))
  :pattern ((inv@95@10 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@97@10 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= left@7@10 (inv@95@10 r)) (<= (inv@95@10 r) right@8@10))
      (img@96@10 r)
      (= r (loc<Ref> a@6@10 (inv@95@10 r))))
    ($Perm.min
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (- $Perm.Write (pTaken@73@10 r))
        $Perm.No)
      $Perm.Write)
    $Perm.No))
(define-fun pTaken@98@10 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= left@7@10 (inv@95@10 r)) (<= (inv@95@10 r) right@8@10))
      (img@96@10 r)
      (= r (loc<Ref> a@6@10 (inv@95@10 r))))
    ($Perm.min
      (ite
        (and
          (img@80@10 r)
          (and
            (<= left@7@10 (inv@79@10 r))
            (<= (inv@79@10 r) (- storeIndex@47@10 1))))
        $Perm.Write
        $Perm.No)
      (- $Perm.Write (pTaken@97@10 r)))
    $Perm.No))
; Done precomputing, updating quantified chunks
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Chunk depleted?
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (- $Perm.Write (pTaken@73@10 r))
        $Perm.No)
      (pTaken@97@10 r))
    $Perm.No)
  
  :qid |quant-u-72|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and (<= left@7@10 (inv@95@10 r)) (<= (inv@95@10 r) right@8@10))
      (img@96@10 r)
      (= r (loc<Ref> a@6@10 (inv@95@10 r))))
    (= (- $Perm.Write (pTaken@97@10 r)) $Perm.No))
  
  :qid |quant-u-73|))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@80@10 r)
          (and
            (<= left@7@10 (inv@79@10 r))
            (<= (inv@79@10 r) (- storeIndex@47@10 1))))
        $Perm.Write
        $Perm.No)
      (pTaken@98@10 r))
    $Perm.No)
  
  :qid |quant-u-74|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and (<= left@7@10 (inv@95@10 r)) (<= (inv@95@10 r) right@8@10))
      (img@96@10 r)
      (= r (loc<Ref> a@6@10 (inv@95@10 r))))
    (= (- (- $Perm.Write (pTaken@97@10 r)) (pTaken@98@10 r)) $Perm.No))
  
  :qid |quant-u-75|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
; Definitional axioms for snapshot map values
; [eval] storeIndex == n
; [eval] (forall i: Int :: { loc(a, i) } left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val)
(declare-const i@99@10 Int)
(set-option :timeout 0)
(push) ; 6
; [eval] left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val
; [eval] left <= i && i < storeIndex
; [eval] left <= i
(push) ; 7
; [then-branch: 78 | !(left@7@10 <= i@99@10) | live]
; [else-branch: 78 | left@7@10 <= i@99@10 | live]
(push) ; 8
; [then-branch: 78 | !(left@7@10 <= i@99@10)]
(assert (not (<= left@7@10 i@99@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 78 | left@7@10 <= i@99@10]
(assert (<= left@7@10 i@99@10))
; [eval] i < storeIndex
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@99@10) (not (<= left@7@10 i@99@10))))
(push) ; 7
; [then-branch: 79 | left@7@10 <= i@99@10 && i@99@10 < storeIndex@75@10 | live]
; [else-branch: 79 | !(left@7@10 <= i@99@10 && i@99@10 < storeIndex@75@10) | live]
(push) ; 8
; [then-branch: 79 | left@7@10 <= i@99@10 && i@99@10 < storeIndex@75@10]
(assert (and (<= left@7@10 i@99@10) (< i@99@10 storeIndex@75@10)))
; [eval] loc(a, i).val <= loc(a, storeIndex).val
; [eval] loc(a, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
    :qid |qp.fvfValDef4|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@80@10 r)
        (and
          (<= left@7@10 (inv@79@10 r))
          (<= (inv@79@10 r) (- storeIndex@47@10 1))))
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
    :qid |qp.fvfValDef5|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@52@10 (loc<Ref> a@6@10 i@99@10))
        (and
          (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 i@99@10)))
          (<= (inv@51@10 (loc<Ref> a@6@10 i@99@10)) right@8@10)))
      (- $Perm.Write (pTaken@73@10 (loc<Ref> a@6@10 i@99@10)))
      $Perm.No)
    (ite
      (and
        (img@80@10 (loc<Ref> a@6@10 i@99@10))
        (and
          (<= left@7@10 (inv@79@10 (loc<Ref> a@6@10 i@99@10)))
          (<= (inv@79@10 (loc<Ref> a@6@10 i@99@10)) (- storeIndex@47@10 1))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, storeIndex)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
    :qid |qp.fvfValDef4|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@80@10 r)
        (and
          (<= left@7@10 (inv@79@10 r))
          (<= (inv@79@10 r) (- storeIndex@47@10 1))))
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
    :qid |qp.fvfValDef5|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@52@10 (loc<Ref> a@6@10 storeIndex@75@10))
        (and
          (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 storeIndex@75@10)))
          (<= (inv@51@10 (loc<Ref> a@6@10 storeIndex@75@10)) right@8@10)))
      (- $Perm.Write (pTaken@73@10 (loc<Ref> a@6@10 storeIndex@75@10)))
      $Perm.No)
    (ite
      (and
        (img@80@10 (loc<Ref> a@6@10 storeIndex@75@10))
        (and
          (<= left@7@10 (inv@79@10 (loc<Ref> a@6@10 storeIndex@75@10)))
          (<=
            (inv@79@10 (loc<Ref> a@6@10 storeIndex@75@10))
            (- storeIndex@47@10 1))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 79 | !(left@7@10 <= i@99@10 && i@99@10 < storeIndex@75@10)]
(assert (not (and (<= left@7@10 i@99@10) (< i@99@10 storeIndex@75@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@80@10 r)
      (and
        (<= left@7@10 (inv@79@10 r))
        (<= (inv@79@10 r) (- storeIndex@47@10 1))))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
  :qid |qp.fvfValDef5|)))
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@99@10) (< i@99@10 storeIndex@75@10)))
  (and (<= left@7@10 i@99@10) (< i@99@10 storeIndex@75@10))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@80@10 r)
      (and
        (<= left@7@10 (inv@79@10 r))
        (<= (inv@79@10 r) (- storeIndex@47@10 1))))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
  :qid |qp.fvfValDef5|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@99@10 Int)) (!
  (and
    (or (<= left@7@10 i@99@10) (not (<= left@7@10 i@99@10)))
    (or
      (not (and (<= left@7@10 i@99@10) (< i@99@10 storeIndex@75@10)))
      (and (<= left@7@10 i@99@10) (< i@99@10 storeIndex@75@10))))
  :pattern ((loc<Ref> a@6@10 i@99@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100-aux|)))
(push) ; 6
(assert (not (forall ((i@99@10 Int)) (!
  (=>
    (and (<= left@7@10 i@99@10) (< i@99@10 storeIndex@75@10))
    (<=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) (loc<Ref> a@6@10 i@99@10))
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) (loc<Ref> a@6@10 storeIndex@75@10))))
  :pattern ((loc<Ref> a@6@10 i@99@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@99@10 Int)) (!
  (=>
    (and (<= left@7@10 i@99@10) (< i@99@10 storeIndex@75@10))
    (<=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) (loc<Ref> a@6@10 i@99@10))
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) (loc<Ref> a@6@10 storeIndex@75@10))))
  :pattern ((loc<Ref> a@6@10 i@99@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100|)))
; [eval] (forall i: Int :: { loc(a, i) } storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val)
(declare-const i@100@10 Int)
(push) ; 6
; [eval] storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val
; [eval] storeIndex < i && i <= right
; [eval] storeIndex < i
(push) ; 7
; [then-branch: 80 | !(storeIndex@75@10 < i@100@10) | live]
; [else-branch: 80 | storeIndex@75@10 < i@100@10 | live]
(push) ; 8
; [then-branch: 80 | !(storeIndex@75@10 < i@100@10)]
(assert (not (< storeIndex@75@10 i@100@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 80 | storeIndex@75@10 < i@100@10]
(assert (< storeIndex@75@10 i@100@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (< storeIndex@75@10 i@100@10) (not (< storeIndex@75@10 i@100@10))))
(push) ; 7
; [then-branch: 81 | storeIndex@75@10 < i@100@10 && i@100@10 <= right@8@10 | live]
; [else-branch: 81 | !(storeIndex@75@10 < i@100@10 && i@100@10 <= right@8@10) | live]
(push) ; 8
; [then-branch: 81 | storeIndex@75@10 < i@100@10 && i@100@10 <= right@8@10]
(assert (and (< storeIndex@75@10 i@100@10) (<= i@100@10 right@8@10)))
; [eval] loc(a, storeIndex).val <= loc(a, i).val
; [eval] loc(a, storeIndex)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
    :qid |qp.fvfValDef4|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@80@10 r)
        (and
          (<= left@7@10 (inv@79@10 r))
          (<= (inv@79@10 r) (- storeIndex@47@10 1))))
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
    :qid |qp.fvfValDef5|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@52@10 (loc<Ref> a@6@10 storeIndex@75@10))
        (and
          (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 storeIndex@75@10)))
          (<= (inv@51@10 (loc<Ref> a@6@10 storeIndex@75@10)) right@8@10)))
      (- $Perm.Write (pTaken@73@10 (loc<Ref> a@6@10 storeIndex@75@10)))
      $Perm.No)
    (ite
      (and
        (img@80@10 (loc<Ref> a@6@10 storeIndex@75@10))
        (and
          (<= left@7@10 (inv@79@10 (loc<Ref> a@6@10 storeIndex@75@10)))
          (<=
            (inv@79@10 (loc<Ref> a@6@10 storeIndex@75@10))
            (- storeIndex@47@10 1))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
    :qid |qp.fvfValDef4|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@80@10 r)
        (and
          (<= left@7@10 (inv@79@10 r))
          (<= (inv@79@10 r) (- storeIndex@47@10 1))))
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
    :qid |qp.fvfValDef5|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@52@10 (loc<Ref> a@6@10 i@100@10))
        (and
          (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 i@100@10)))
          (<= (inv@51@10 (loc<Ref> a@6@10 i@100@10)) right@8@10)))
      (- $Perm.Write (pTaken@73@10 (loc<Ref> a@6@10 i@100@10)))
      $Perm.No)
    (ite
      (and
        (img@80@10 (loc<Ref> a@6@10 i@100@10))
        (and
          (<= left@7@10 (inv@79@10 (loc<Ref> a@6@10 i@100@10)))
          (<= (inv@79@10 (loc<Ref> a@6@10 i@100@10)) (- storeIndex@47@10 1))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 81 | !(storeIndex@75@10 < i@100@10 && i@100@10 <= right@8@10)]
(assert (not (and (< storeIndex@75@10 i@100@10) (<= i@100@10 right@8@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@80@10 r)
      (and
        (<= left@7@10 (inv@79@10 r))
        (<= (inv@79@10 r) (- storeIndex@47@10 1))))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
  :qid |qp.fvfValDef5|)))
; Joined path conditions
(assert (or
  (not (and (< storeIndex@75@10 i@100@10) (<= i@100@10 right@8@10)))
  (and (< storeIndex@75@10 i@100@10) (<= i@100@10 right@8@10))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@80@10 r)
      (and
        (<= left@7@10 (inv@79@10 r))
        (<= (inv@79@10 r) (- storeIndex@47@10 1))))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
  :qid |qp.fvfValDef5|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@100@10 Int)) (!
  (and
    (or (< storeIndex@75@10 i@100@10) (not (< storeIndex@75@10 i@100@10)))
    (or
      (not (and (< storeIndex@75@10 i@100@10) (<= i@100@10 right@8@10)))
      (and (< storeIndex@75@10 i@100@10) (<= i@100@10 right@8@10))))
  :pattern ((loc<Ref> a@6@10 i@100@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@146@11@146@100-aux|)))
(push) ; 6
(assert (not (forall ((i@100@10 Int)) (!
  (=>
    (and (< storeIndex@75@10 i@100@10) (<= i@100@10 right@8@10))
    (<=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) (loc<Ref> a@6@10 storeIndex@75@10))
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) (loc<Ref> a@6@10 i@100@10))))
  :pattern ((loc<Ref> a@6@10 i@100@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@146@11@146@100|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@100@10 Int)) (!
  (=>
    (and (< storeIndex@75@10 i@100@10) (<= i@100@10 right@8@10))
    (<=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) (loc<Ref> a@6@10 storeIndex@75@10))
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) (loc<Ref> a@6@10 i@100@10))))
  :pattern ((loc<Ref> a@6@10 i@100@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@146@11@146@100|)))
; [eval] |pw| == right + 1
; [eval] |pw|
; [eval] right + 1
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> left <= pw[i] && pw[i] <= right)
(declare-const i@101@10 Int)
(push) ; 6
; [eval] left <= i && i <= right ==> left <= pw[i] && pw[i] <= right
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 82 | !(left@7@10 <= i@101@10) | live]
; [else-branch: 82 | left@7@10 <= i@101@10 | live]
(push) ; 8
; [then-branch: 82 | !(left@7@10 <= i@101@10)]
(assert (not (<= left@7@10 i@101@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 82 | left@7@10 <= i@101@10]
(assert (<= left@7@10 i@101@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@101@10) (not (<= left@7@10 i@101@10))))
(push) ; 7
; [then-branch: 83 | left@7@10 <= i@101@10 && i@101@10 <= right@8@10 | live]
; [else-branch: 83 | !(left@7@10 <= i@101@10 && i@101@10 <= right@8@10) | live]
(push) ; 8
; [then-branch: 83 | left@7@10 <= i@101@10 && i@101@10 <= right@8@10]
(assert (and (<= left@7@10 i@101@10) (<= i@101@10 right@8@10)))
; [eval] left <= pw[i] && pw[i] <= right
; [eval] left <= pw[i]
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@101@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@101@10 (Seq_length pw@11@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
; [then-branch: 84 | !(left@7@10 <= pw@11@10[i@101@10]) | live]
; [else-branch: 84 | left@7@10 <= pw@11@10[i@101@10] | live]
(push) ; 10
; [then-branch: 84 | !(left@7@10 <= pw@11@10[i@101@10])]
(assert (not (<= left@7@10 (Seq_index pw@11@10 i@101@10))))
(pop) ; 10
(push) ; 10
; [else-branch: 84 | left@7@10 <= pw@11@10[i@101@10]]
(assert (<= left@7@10 (Seq_index pw@11@10 i@101@10)))
; [eval] pw[i] <= right
; [eval] pw[i]
(push) ; 11
(assert (not (>= i@101@10 0)))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(push) ; 11
(assert (not (< i@101@10 (Seq_length pw@11@10))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or
  (<= left@7@10 (Seq_index pw@11@10 i@101@10))
  (not (<= left@7@10 (Seq_index pw@11@10 i@101@10)))))
(pop) ; 8
(push) ; 8
; [else-branch: 83 | !(left@7@10 <= i@101@10 && i@101@10 <= right@8@10)]
(assert (not (and (<= left@7@10 i@101@10) (<= i@101@10 right@8@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (=>
  (and (<= left@7@10 i@101@10) (<= i@101@10 right@8@10))
  (and
    (<= left@7@10 i@101@10)
    (<= i@101@10 right@8@10)
    (or
      (<= left@7@10 (Seq_index pw@11@10 i@101@10))
      (not (<= left@7@10 (Seq_index pw@11@10 i@101@10)))))))
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@101@10) (<= i@101@10 right@8@10)))
  (and (<= left@7@10 i@101@10) (<= i@101@10 right@8@10))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@101@10 Int)) (!
  (and
    (or (<= left@7@10 i@101@10) (not (<= left@7@10 i@101@10)))
    (=>
      (and (<= left@7@10 i@101@10) (<= i@101@10 right@8@10))
      (and
        (<= left@7@10 i@101@10)
        (<= i@101@10 right@8@10)
        (or
          (<= left@7@10 (Seq_index pw@11@10 i@101@10))
          (not (<= left@7@10 (Seq_index pw@11@10 i@101@10))))))
    (or
      (not (and (<= left@7@10 i@101@10) (<= i@101@10 right@8@10)))
      (and (<= left@7@10 i@101@10) (<= i@101@10 right@8@10))))
  :pattern ((Seq_index pw@11@10 i@101@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@149@11@149@87-aux|)))
(push) ; 6
(assert (not (forall ((i@101@10 Int)) (!
  (=>
    (and (<= left@7@10 i@101@10) (<= i@101@10 right@8@10))
    (and
      (<= left@7@10 (Seq_index pw@11@10 i@101@10))
      (<= (Seq_index pw@11@10 i@101@10) right@8@10)))
  :pattern ((Seq_index pw@11@10 i@101@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@149@11@149@87|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@101@10 Int)) (!
  (=>
    (and (<= left@7@10 i@101@10) (<= i@101@10 right@8@10))
    (and
      (<= left@7@10 (Seq_index pw@11@10 i@101@10))
      (<= (Seq_index pw@11@10 i@101@10) right@8@10)))
  :pattern ((Seq_index pw@11@10 i@101@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@149@11@149@87|)))
; [eval] (forall i: Int, j: Int :: { pw[i], pw[j] } left <= i && (i < j && j <= right) ==> pw[i] != pw[j])
(declare-const i@102@10 Int)
(declare-const j@103@10 Int)
(push) ; 6
; [eval] left <= i && (i < j && j <= right) ==> pw[i] != pw[j]
; [eval] left <= i && (i < j && j <= right)
; [eval] left <= i
(push) ; 7
; [then-branch: 85 | !(left@7@10 <= i@102@10) | live]
; [else-branch: 85 | left@7@10 <= i@102@10 | live]
(push) ; 8
; [then-branch: 85 | !(left@7@10 <= i@102@10)]
(assert (not (<= left@7@10 i@102@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 85 | left@7@10 <= i@102@10]
(assert (<= left@7@10 i@102@10))
; [eval] i < j
(push) ; 9
; [then-branch: 86 | !(i@102@10 < j@103@10) | live]
; [else-branch: 86 | i@102@10 < j@103@10 | live]
(push) ; 10
; [then-branch: 86 | !(i@102@10 < j@103@10)]
(assert (not (< i@102@10 j@103@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 86 | i@102@10 < j@103@10]
(assert (< i@102@10 j@103@10))
; [eval] j <= right
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (< i@102@10 j@103@10) (not (< i@102@10 j@103@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= left@7@10 i@102@10)
  (and
    (<= left@7@10 i@102@10)
    (or (< i@102@10 j@103@10) (not (< i@102@10 j@103@10))))))
(assert (or (<= left@7@10 i@102@10) (not (<= left@7@10 i@102@10))))
(push) ; 7
; [then-branch: 87 | left@7@10 <= i@102@10 && i@102@10 < j@103@10 && j@103@10 <= right@8@10 | live]
; [else-branch: 87 | !(left@7@10 <= i@102@10 && i@102@10 < j@103@10 && j@103@10 <= right@8@10) | live]
(push) ; 8
; [then-branch: 87 | left@7@10 <= i@102@10 && i@102@10 < j@103@10 && j@103@10 <= right@8@10]
(assert (and
  (<= left@7@10 i@102@10)
  (and (< i@102@10 j@103@10) (<= j@103@10 right@8@10))))
; [eval] pw[i] != pw[j]
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@102@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@102@10 (Seq_length pw@11@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] pw[j]
(push) ; 9
(assert (not (>= j@103@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< j@103@10 (Seq_length pw@11@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 87 | !(left@7@10 <= i@102@10 && i@102@10 < j@103@10 && j@103@10 <= right@8@10)]
(assert (not
  (and
    (<= left@7@10 i@102@10)
    (and (< i@102@10 j@103@10) (<= j@103@10 right@8@10)))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (=>
  (and
    (<= left@7@10 i@102@10)
    (and (< i@102@10 j@103@10) (<= j@103@10 right@8@10)))
  (and (<= left@7@10 i@102@10) (< i@102@10 j@103@10) (<= j@103@10 right@8@10))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= left@7@10 i@102@10)
      (and (< i@102@10 j@103@10) (<= j@103@10 right@8@10))))
  (and
    (<= left@7@10 i@102@10)
    (and (< i@102@10 j@103@10) (<= j@103@10 right@8@10)))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@102@10 Int) (j@103@10 Int)) (!
  (and
    (=>
      (<= left@7@10 i@102@10)
      (and
        (<= left@7@10 i@102@10)
        (or (< i@102@10 j@103@10) (not (< i@102@10 j@103@10)))))
    (or (<= left@7@10 i@102@10) (not (<= left@7@10 i@102@10)))
    (=>
      (and
        (<= left@7@10 i@102@10)
        (and (< i@102@10 j@103@10) (<= j@103@10 right@8@10)))
      (and
        (<= left@7@10 i@102@10)
        (< i@102@10 j@103@10)
        (<= j@103@10 right@8@10)))
    (or
      (not
        (and
          (<= left@7@10 i@102@10)
          (and (< i@102@10 j@103@10) (<= j@103@10 right@8@10))))
      (and
        (<= left@7@10 i@102@10)
        (and (< i@102@10 j@103@10) (<= j@103@10 right@8@10)))))
  :pattern ((Seq_index pw@11@10 i@102@10) (Seq_index pw@11@10 j@103@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@150@11@150@87-aux|)))
(push) ; 6
(assert (not (forall ((i@102@10 Int) (j@103@10 Int)) (!
  (=>
    (and
      (<= left@7@10 i@102@10)
      (and (< i@102@10 j@103@10) (<= j@103@10 right@8@10)))
    (not (= (Seq_index pw@11@10 i@102@10) (Seq_index pw@11@10 j@103@10))))
  :pattern ((Seq_index pw@11@10 i@102@10) (Seq_index pw@11@10 j@103@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@150@11@150@87|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@102@10 Int) (j@103@10 Int)) (!
  (=>
    (and
      (<= left@7@10 i@102@10)
      (and (< i@102@10 j@103@10) (<= j@103@10 right@8@10)))
    (not (= (Seq_index pw@11@10 i@102@10) (Seq_index pw@11@10 j@103@10))))
  :pattern ((Seq_index pw@11@10 i@102@10) (Seq_index pw@11@10 j@103@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@150@11@150@87|)))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val))
(declare-const i@104@10 Int)
(push) ; 6
; [eval] left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 88 | !(left@7@10 <= i@104@10) | live]
; [else-branch: 88 | left@7@10 <= i@104@10 | live]
(push) ; 8
; [then-branch: 88 | !(left@7@10 <= i@104@10)]
(assert (not (<= left@7@10 i@104@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 88 | left@7@10 <= i@104@10]
(assert (<= left@7@10 i@104@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@104@10) (not (<= left@7@10 i@104@10))))
(push) ; 7
; [then-branch: 89 | left@7@10 <= i@104@10 && i@104@10 <= right@8@10 | live]
; [else-branch: 89 | !(left@7@10 <= i@104@10 && i@104@10 <= right@8@10) | live]
(push) ; 8
; [then-branch: 89 | left@7@10 <= i@104@10 && i@104@10 <= right@8@10]
(assert (and (<= left@7@10 i@104@10) (<= i@104@10 right@8@10)))
; [eval] loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] loc(a, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
    :qid |qp.fvfValDef4|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@80@10 r)
        (and
          (<= left@7@10 (inv@79@10 r))
          (<= (inv@79@10 r) (- storeIndex@47@10 1))))
      (=
        ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
    :qid |qp.fvfValDef5|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@52@10 (loc<Ref> a@6@10 i@104@10))
        (and
          (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 i@104@10)))
          (<= (inv@51@10 (loc<Ref> a@6@10 i@104@10)) right@8@10)))
      (- $Perm.Write (pTaken@73@10 (loc<Ref> a@6@10 i@104@10)))
      $Perm.No)
    (ite
      (and
        (img@80@10 (loc<Ref> a@6@10 i@104@10))
        (and
          (<= left@7@10 (inv@79@10 (loc<Ref> a@6@10 i@104@10)))
          (<= (inv@79@10 (loc<Ref> a@6@10 i@104@10)) (- storeIndex@47@10 1))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, pw[i]).val)
; [eval] loc(a, pw[i])
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@104@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@104@10 (Seq_length pw@11@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (and
  (img@15@10 (loc<Ref> a@6@10 (Seq_index pw@11@10 i@104@10)))
  (and
    (<= left@7@10 (inv@14@10 (loc<Ref> a@6@10 (Seq_index pw@11@10 i@104@10))))
    (<= (inv@14@10 (loc<Ref> a@6@10 (Seq_index pw@11@10 i@104@10))) right@8@10)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 89 | !(left@7@10 <= i@104@10 && i@104@10 <= right@8@10)]
(assert (not (and (<= left@7@10 i@104@10) (<= i@104@10 right@8@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@80@10 r)
      (and
        (<= left@7@10 (inv@79@10 r))
        (<= (inv@79@10 r) (- storeIndex@47@10 1))))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
  :qid |qp.fvfValDef5|)))
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@104@10) (<= i@104@10 right@8@10)))
  (and (<= left@7@10 i@104@10) (<= i@104@10 right@8@10))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@73@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@80@10 r)
      (and
        (<= left@7@10 (inv@79@10 r))
        (<= (inv@79@10 r) (- storeIndex@47@10 1))))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@82@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@77@10)))) r))
  :qid |qp.fvfValDef5|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@104@10 Int)) (!
  (and
    (or (<= left@7@10 i@104@10) (not (<= left@7@10 i@104@10)))
    (or
      (not (and (<= left@7@10 i@104@10) (<= i@104@10 right@8@10)))
      (and (<= left@7@10 i@104@10) (<= i@104@10 right@8@10))))
  :pattern ((Seq_index pw@11@10 i@104@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@152@11@152@39-aux|)))
(push) ; 6
(assert (not (forall ((i@104@10 Int)) (!
  (=>
    (and (<= left@7@10 i@104@10) (<= i@104@10 right@8@10))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) (loc<Ref> a@6@10 i@104@10))
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> a@6@10 (Seq_index
        pw@11@10
        i@104@10)))))
  :pattern ((Seq_index pw@11@10 i@104@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@152@11@152@39|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@104@10 Int)) (!
  (=>
    (and (<= left@7@10 i@104@10) (<= i@104@10 right@8@10))
    (=
      ($FVF.lookup_val (as sm@82@10  $FVF<val>) (loc<Ref> a@6@10 i@104@10))
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> a@6@10 (Seq_index
        pw@11@10
        i@104@10)))))
  :pattern ((Seq_index pw@11@10 i@104@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@152@11@152@39|)))
(pop) ; 5
(push) ; 5
; [else-branch: 58 | !(n@9@10 < storeIndex@47@10)]
(assert (not (< n@9@10 storeIndex@47@10)))
(pop) ; 5
; [eval] !(n < pivotIndex)
; [eval] n < pivotIndex
(push) ; 5
(set-option :timeout 10)
(assert (not (< n@9@10 storeIndex@47@10)))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 10)
(assert (not (not (< n@9@10 storeIndex@47@10))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [then-branch: 90 | !(n@9@10 < storeIndex@47@10) | live]
; [else-branch: 90 | n@9@10 < storeIndex@47@10 | live]
(set-option :timeout 0)
(push) ; 5
; [then-branch: 90 | !(n@9@10 < storeIndex@47@10)]
(assert (not (< n@9@10 storeIndex@47@10)))
; [exec]
; storeIndex, pwRec := select_rec(a, pivotIndex + 1, right, n)
; [eval] pivotIndex + 1
; [eval] 0 <= left
(push) ; 6
(assert (not (<= 0 (+ storeIndex@47@10 1))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 (+ storeIndex@47@10 1)))
; [eval] left <= right
(push) ; 6
(assert (not (<= (+ storeIndex@47@10 1) right@8@10)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (<= (+ storeIndex@47@10 1) right@8@10))
; [eval] right < len(a)
; [eval] len(a)
; [eval] left <= n
(push) ; 6
(assert (not (<= (+ storeIndex@47@10 1) n@9@10)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (<= (+ storeIndex@47@10 1) n@9@10))
; [eval] n <= right
(declare-const i@105@10 Int)
(push) ; 6
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 91 | !(storeIndex@47@10 + 1 <= i@105@10) | live]
; [else-branch: 91 | storeIndex@47@10 + 1 <= i@105@10 | live]
(push) ; 8
; [then-branch: 91 | !(storeIndex@47@10 + 1 <= i@105@10)]
(assert (not (<= (+ storeIndex@47@10 1) i@105@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 91 | storeIndex@47@10 + 1 <= i@105@10]
(assert (<= (+ storeIndex@47@10 1) i@105@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or
  (<= (+ storeIndex@47@10 1) i@105@10)
  (not (<= (+ storeIndex@47@10 1) i@105@10))))
(assert (and (<= (+ storeIndex@47@10 1) i@105@10) (<= i@105@10 right@8@10)))
; [eval] loc(a, i)
(pop) ; 6
(declare-fun inv@106@10 ($Ref) Int)
(declare-fun img@107@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@105@10 Int)) (!
  (=>
    (and (<= (+ storeIndex@47@10 1) i@105@10) (<= i@105@10 right@8@10))
    (or
      (<= (+ storeIndex@47@10 1) i@105@10)
      (not (<= (+ storeIndex@47@10 1) i@105@10))))
  :pattern ((loc<Ref> a@6@10 i@105@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 6
(assert (not (forall ((i1@105@10 Int) (i2@105@10 Int)) (!
  (=>
    (and
      (and (<= (+ storeIndex@47@10 1) i1@105@10) (<= i1@105@10 right@8@10))
      (and (<= (+ storeIndex@47@10 1) i2@105@10) (<= i2@105@10 right@8@10))
      (= (loc<Ref> a@6@10 i1@105@10) (loc<Ref> a@6@10 i2@105@10)))
    (= i1@105@10 i2@105@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@105@10 Int)) (!
  (=>
    (and (<= (+ storeIndex@47@10 1) i@105@10) (<= i@105@10 right@8@10))
    (and
      (= (inv@106@10 (loc<Ref> a@6@10 i@105@10)) i@105@10)
      (img@107@10 (loc<Ref> a@6@10 i@105@10))))
  :pattern ((loc<Ref> a@6@10 i@105@10))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@107@10 r)
      (and
        (<= (+ storeIndex@47@10 1) (inv@106@10 r))
        (<= (inv@106@10 r) right@8@10)))
    (= (loc<Ref> a@6@10 (inv@106@10 r)) r))
  :pattern ((inv@106@10 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@108@10 ((r $Ref)) $Perm
  (ite
    (and
      (and
        (<= (+ storeIndex@47@10 1) (inv@106@10 r))
        (<= (inv@106@10 r) right@8@10))
      (img@107@10 r)
      (= r (loc<Ref> a@6@10 (inv@106@10 r))))
    ($Perm.min
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        $Perm.Write
        $Perm.No)
      $Perm.Write)
    $Perm.No))
; Done precomputing, updating quantified chunks
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Chunk depleted?
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        $Perm.Write
        $Perm.No)
      (pTaken@108@10 r))
    $Perm.No)
  
  :qid |quant-u-78|))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@108@10 r) $Perm.No)
  
  :qid |quant-u-79|))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and
        (<= (+ storeIndex@47@10 1) (inv@106@10 r))
        (<= (inv@106@10 r) right@8@10))
      (img@107@10 r)
      (= r (loc<Ref> a@6@10 (inv@106@10 r))))
    (= (- $Perm.Write (pTaken@108@10 r)) $Perm.No))
  
  :qid |quant-u-80|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@109@10 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@52@10 r)
      (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
    (=
      ($FVF.lookup_val (as sm@109@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@109@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef7|)))
(declare-const storeIndex@110@10 Int)
(declare-const pw@111@10 Seq<Int>)
(declare-const $t@112@10 $Snap)
(assert (= $t@112@10 ($Snap.combine ($Snap.first $t@112@10) ($Snap.second $t@112@10))))
(assert (= ($Snap.first $t@112@10) $Snap.unit))
; [eval] left <= storeIndex
(assert (<= (+ storeIndex@47@10 1) storeIndex@110@10))
(assert (=
  ($Snap.second $t@112@10)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@112@10))
    ($Snap.second ($Snap.second $t@112@10)))))
(assert (= ($Snap.first ($Snap.second $t@112@10)) $Snap.unit))
; [eval] storeIndex <= right
(assert (<= storeIndex@110@10 right@8@10))
(assert (=
  ($Snap.second ($Snap.second $t@112@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@112@10)))
    ($Snap.second ($Snap.second ($Snap.second $t@112@10))))))
(declare-const i@113@10 Int)
(set-option :timeout 0)
(push) ; 6
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 92 | !(storeIndex@47@10 + 1 <= i@113@10) | live]
; [else-branch: 92 | storeIndex@47@10 + 1 <= i@113@10 | live]
(push) ; 8
; [then-branch: 92 | !(storeIndex@47@10 + 1 <= i@113@10)]
(assert (not (<= (+ storeIndex@47@10 1) i@113@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 92 | storeIndex@47@10 + 1 <= i@113@10]
(assert (<= (+ storeIndex@47@10 1) i@113@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or
  (<= (+ storeIndex@47@10 1) i@113@10)
  (not (<= (+ storeIndex@47@10 1) i@113@10))))
(assert (and (<= (+ storeIndex@47@10 1) i@113@10) (<= i@113@10 right@8@10)))
; [eval] loc(a, i)
(pop) ; 6
(declare-fun inv@114@10 ($Ref) Int)
(declare-fun img@115@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@113@10 Int)) (!
  (=>
    (and (<= (+ storeIndex@47@10 1) i@113@10) (<= i@113@10 right@8@10))
    (or
      (<= (+ storeIndex@47@10 1) i@113@10)
      (not (<= (+ storeIndex@47@10 1) i@113@10))))
  :pattern ((loc<Ref> a@6@10 i@113@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 6
(assert (not (forall ((i1@113@10 Int) (i2@113@10 Int)) (!
  (=>
    (and
      (and (<= (+ storeIndex@47@10 1) i1@113@10) (<= i1@113@10 right@8@10))
      (and (<= (+ storeIndex@47@10 1) i2@113@10) (<= i2@113@10 right@8@10))
      (= (loc<Ref> a@6@10 i1@113@10) (loc<Ref> a@6@10 i2@113@10)))
    (= i1@113@10 i2@113@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@113@10 Int)) (!
  (=>
    (and (<= (+ storeIndex@47@10 1) i@113@10) (<= i@113@10 right@8@10))
    (and
      (= (inv@114@10 (loc<Ref> a@6@10 i@113@10)) i@113@10)
      (img@115@10 (loc<Ref> a@6@10 i@113@10))))
  :pattern ((loc<Ref> a@6@10 i@113@10))
  :qid |quant-u-82|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@115@10 r)
      (and
        (<= (+ storeIndex@47@10 1) (inv@114@10 r))
        (<= (inv@114@10 r) right@8@10)))
    (= (loc<Ref> a@6@10 (inv@114@10 r)) r))
  :pattern ((inv@114@10 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@113@10 Int)) (!
  (=>
    (and (<= (+ storeIndex@47@10 1) i@113@10) (<= i@113@10 right@8@10))
    (not (= (loc<Ref> a@6@10 i@113@10) $Ref.null)))
  :pattern ((loc<Ref> a@6@10 i@113@10))
  :qid |val-permImpliesNonNull|)))
(push) ; 6
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= (loc<Ref> a@6@10 i@113@10) (loc<Ref> a@6@10 i@50@10))
    (=
      (and
        (img@115@10 r)
        (and
          (<= (+ storeIndex@47@10 1) (inv@114@10 r))
          (<= (inv@114@10 r) right@8@10)))
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))))
  
  :qid |quant-u-83|))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@112@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@112@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@112@10))))
  $Snap.unit))
; [eval] storeIndex == n
(assert (= storeIndex@110@10 n@9@10))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10)))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val)
(declare-const i@116@10 Int)
(set-option :timeout 0)
(push) ; 6
; [eval] left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val
; [eval] left <= i && i < storeIndex
; [eval] left <= i
(push) ; 7
; [then-branch: 93 | !(storeIndex@47@10 + 1 <= i@116@10) | live]
; [else-branch: 93 | storeIndex@47@10 + 1 <= i@116@10 | live]
(push) ; 8
; [then-branch: 93 | !(storeIndex@47@10 + 1 <= i@116@10)]
(assert (not (<= (+ storeIndex@47@10 1) i@116@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 93 | storeIndex@47@10 + 1 <= i@116@10]
(assert (<= (+ storeIndex@47@10 1) i@116@10))
; [eval] i < storeIndex
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or
  (<= (+ storeIndex@47@10 1) i@116@10)
  (not (<= (+ storeIndex@47@10 1) i@116@10))))
(push) ; 7
; [then-branch: 94 | storeIndex@47@10 + 1 <= i@116@10 && i@116@10 < storeIndex@110@10 | live]
; [else-branch: 94 | !(storeIndex@47@10 + 1 <= i@116@10 && i@116@10 < storeIndex@110@10) | live]
(push) ; 8
; [then-branch: 94 | storeIndex@47@10 + 1 <= i@116@10 && i@116@10 < storeIndex@110@10]
(assert (and (<= (+ storeIndex@47@10 1) i@116@10) (< i@116@10 storeIndex@110@10)))
; [eval] loc(a, i).val <= loc(a, storeIndex).val
; [eval] loc(a, i)
(declare-const sm@117@10 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@108@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@115@10 r)
      (and
        (<= (+ storeIndex@47@10 1) (inv@114@10 r))
        (<= (inv@114@10 r) right@8@10)))
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r))
  :qid |qp.fvfValDef9|)))
(declare-const pm@118@10 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@118@10  $FPM) r)
    (+
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (- $Perm.Write (pTaken@108@10 r))
        $Perm.No)
      (ite
        (and
          (img@115@10 r)
          (and
            (<= (+ storeIndex@47@10 1) (inv@114@10 r))
            (<= (inv@114@10 r) right@8@10)))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@118@10  $FPM) r))
  :qid |qp.resPrmSumDef10|)))
(push) ; 9
(assert (not (< $Perm.No ($FVF.perm_val (as pm@118@10  $FPM) (loc<Ref> a@6@10 i@116@10)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, storeIndex)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (< $Perm.No (- $Perm.Write (pTaken@108@10 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
    :qid |qp.fvfValDef8|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@115@10 r)
        (and
          (<= (+ storeIndex@47@10 1) (inv@114@10 r))
          (<= (inv@114@10 r) right@8@10)))
      (=
        ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r))
    :qid |qp.fvfValDef9|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@52@10 (loc<Ref> a@6@10 storeIndex@110@10))
        (and
          (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 storeIndex@110@10)))
          (<= (inv@51@10 (loc<Ref> a@6@10 storeIndex@110@10)) right@8@10)))
      (- $Perm.Write (pTaken@108@10 (loc<Ref> a@6@10 storeIndex@110@10)))
      $Perm.No)
    (ite
      (and
        (img@115@10 (loc<Ref> a@6@10 storeIndex@110@10))
        (and
          (<=
            (+ storeIndex@47@10 1)
            (inv@114@10 (loc<Ref> a@6@10 storeIndex@110@10)))
          (<= (inv@114@10 (loc<Ref> a@6@10 storeIndex@110@10)) right@8@10)))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 94 | !(storeIndex@47@10 + 1 <= i@116@10 && i@116@10 < storeIndex@110@10)]
(assert (not (and (<= (+ storeIndex@47@10 1) i@116@10) (< i@116@10 storeIndex@110@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@108@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@115@10 r)
      (and
        (<= (+ storeIndex@47@10 1) (inv@114@10 r))
        (<= (inv@114@10 r) right@8@10)))
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r))
  :qid |qp.fvfValDef9|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@118@10  $FPM) r)
    (+
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (- $Perm.Write (pTaken@108@10 r))
        $Perm.No)
      (ite
        (and
          (img@115@10 r)
          (and
            (<= (+ storeIndex@47@10 1) (inv@114@10 r))
            (<= (inv@114@10 r) right@8@10)))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@118@10  $FPM) r))
  :qid |qp.resPrmSumDef10|)))
; Joined path conditions
(assert (or
  (not (and (<= (+ storeIndex@47@10 1) i@116@10) (< i@116@10 storeIndex@110@10)))
  (and (<= (+ storeIndex@47@10 1) i@116@10) (< i@116@10 storeIndex@110@10))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@108@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@115@10 r)
      (and
        (<= (+ storeIndex@47@10 1) (inv@114@10 r))
        (<= (inv@114@10 r) right@8@10)))
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r))
  :qid |qp.fvfValDef9|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@118@10  $FPM) r)
    (+
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (- $Perm.Write (pTaken@108@10 r))
        $Perm.No)
      (ite
        (and
          (img@115@10 r)
          (and
            (<= (+ storeIndex@47@10 1) (inv@114@10 r))
            (<= (inv@114@10 r) right@8@10)))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@118@10  $FPM) r))
  :qid |qp.resPrmSumDef10|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@116@10 Int)) (!
  (and
    (or
      (<= (+ storeIndex@47@10 1) i@116@10)
      (not (<= (+ storeIndex@47@10 1) i@116@10)))
    (or
      (not
        (and (<= (+ storeIndex@47@10 1) i@116@10) (< i@116@10 storeIndex@110@10)))
      (and (<= (+ storeIndex@47@10 1) i@116@10) (< i@116@10 storeIndex@110@10))))
  :pattern ((loc<Ref> a@6@10 i@116@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100-aux|)))
(assert (forall ((i@116@10 Int)) (!
  (=>
    (and (<= (+ storeIndex@47@10 1) i@116@10) (< i@116@10 storeIndex@110@10))
    (<=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) (loc<Ref> a@6@10 i@116@10))
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) (loc<Ref> a@6@10 storeIndex@110@10))))
  :pattern ((loc<Ref> a@6@10 i@116@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10))))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val)
(declare-const i@119@10 Int)
(push) ; 6
; [eval] storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val
; [eval] storeIndex < i && i <= right
; [eval] storeIndex < i
(push) ; 7
; [then-branch: 95 | !(storeIndex@110@10 < i@119@10) | live]
; [else-branch: 95 | storeIndex@110@10 < i@119@10 | live]
(push) ; 8
; [then-branch: 95 | !(storeIndex@110@10 < i@119@10)]
(assert (not (< storeIndex@110@10 i@119@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 95 | storeIndex@110@10 < i@119@10]
(assert (< storeIndex@110@10 i@119@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (< storeIndex@110@10 i@119@10) (not (< storeIndex@110@10 i@119@10))))
(push) ; 7
; [then-branch: 96 | storeIndex@110@10 < i@119@10 && i@119@10 <= right@8@10 | live]
; [else-branch: 96 | !(storeIndex@110@10 < i@119@10 && i@119@10 <= right@8@10) | live]
(push) ; 8
; [then-branch: 96 | storeIndex@110@10 < i@119@10 && i@119@10 <= right@8@10]
(assert (and (< storeIndex@110@10 i@119@10) (<= i@119@10 right@8@10)))
; [eval] loc(a, storeIndex).val <= loc(a, i).val
; [eval] loc(a, storeIndex)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (< $Perm.No (- $Perm.Write (pTaken@108@10 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
    :qid |qp.fvfValDef8|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@115@10 r)
        (and
          (<= (+ storeIndex@47@10 1) (inv@114@10 r))
          (<= (inv@114@10 r) right@8@10)))
      (=
        ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r))
    :qid |qp.fvfValDef9|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@52@10 (loc<Ref> a@6@10 storeIndex@110@10))
        (and
          (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 storeIndex@110@10)))
          (<= (inv@51@10 (loc<Ref> a@6@10 storeIndex@110@10)) right@8@10)))
      (- $Perm.Write (pTaken@108@10 (loc<Ref> a@6@10 storeIndex@110@10)))
      $Perm.No)
    (ite
      (and
        (img@115@10 (loc<Ref> a@6@10 storeIndex@110@10))
        (and
          (<=
            (+ storeIndex@47@10 1)
            (inv@114@10 (loc<Ref> a@6@10 storeIndex@110@10)))
          (<= (inv@114@10 (loc<Ref> a@6@10 storeIndex@110@10)) right@8@10)))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (< $Perm.No (- $Perm.Write (pTaken@108@10 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
    :qid |qp.fvfValDef8|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@115@10 r)
        (and
          (<= (+ storeIndex@47@10 1) (inv@114@10 r))
          (<= (inv@114@10 r) right@8@10)))
      (=
        ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r))
    :qid |qp.fvfValDef9|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@52@10 (loc<Ref> a@6@10 i@119@10))
        (and
          (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 i@119@10)))
          (<= (inv@51@10 (loc<Ref> a@6@10 i@119@10)) right@8@10)))
      (- $Perm.Write (pTaken@108@10 (loc<Ref> a@6@10 i@119@10)))
      $Perm.No)
    (ite
      (and
        (img@115@10 (loc<Ref> a@6@10 i@119@10))
        (and
          (<= (+ storeIndex@47@10 1) (inv@114@10 (loc<Ref> a@6@10 i@119@10)))
          (<= (inv@114@10 (loc<Ref> a@6@10 i@119@10)) right@8@10)))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 96 | !(storeIndex@110@10 < i@119@10 && i@119@10 <= right@8@10)]
(assert (not (and (< storeIndex@110@10 i@119@10) (<= i@119@10 right@8@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@108@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@115@10 r)
      (and
        (<= (+ storeIndex@47@10 1) (inv@114@10 r))
        (<= (inv@114@10 r) right@8@10)))
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r))
  :qid |qp.fvfValDef9|)))
; Joined path conditions
(assert (or
  (not (and (< storeIndex@110@10 i@119@10) (<= i@119@10 right@8@10)))
  (and (< storeIndex@110@10 i@119@10) (<= i@119@10 right@8@10))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@108@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@115@10 r)
      (and
        (<= (+ storeIndex@47@10 1) (inv@114@10 r))
        (<= (inv@114@10 r) right@8@10)))
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r))
  :qid |qp.fvfValDef9|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@119@10 Int)) (!
  (and
    (or (< storeIndex@110@10 i@119@10) (not (< storeIndex@110@10 i@119@10)))
    (or
      (not (and (< storeIndex@110@10 i@119@10) (<= i@119@10 right@8@10)))
      (and (< storeIndex@110@10 i@119@10) (<= i@119@10 right@8@10))))
  :pattern ((loc<Ref> a@6@10 i@119@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@146@11@146@100-aux|)))
(assert (forall ((i@119@10 Int)) (!
  (=>
    (and (< storeIndex@110@10 i@119@10) (<= i@119@10 right@8@10))
    (<=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) (loc<Ref> a@6@10 storeIndex@110@10))
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) (loc<Ref> a@6@10 i@119@10))))
  :pattern ((loc<Ref> a@6@10 i@119@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@146@11@146@100|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10)))))))
  $Snap.unit))
; [eval] |pw| == right + 1
; [eval] |pw|
; [eval] right + 1
(assert (= (Seq_length pw@111@10) (+ right@8@10 1)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> left <= pw[i] && pw[i] <= right)
(declare-const i@120@10 Int)
(push) ; 6
; [eval] left <= i && i <= right ==> left <= pw[i] && pw[i] <= right
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 97 | !(storeIndex@47@10 + 1 <= i@120@10) | live]
; [else-branch: 97 | storeIndex@47@10 + 1 <= i@120@10 | live]
(push) ; 8
; [then-branch: 97 | !(storeIndex@47@10 + 1 <= i@120@10)]
(assert (not (<= (+ storeIndex@47@10 1) i@120@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 97 | storeIndex@47@10 + 1 <= i@120@10]
(assert (<= (+ storeIndex@47@10 1) i@120@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or
  (<= (+ storeIndex@47@10 1) i@120@10)
  (not (<= (+ storeIndex@47@10 1) i@120@10))))
(push) ; 7
; [then-branch: 98 | storeIndex@47@10 + 1 <= i@120@10 && i@120@10 <= right@8@10 | live]
; [else-branch: 98 | !(storeIndex@47@10 + 1 <= i@120@10 && i@120@10 <= right@8@10) | live]
(push) ; 8
; [then-branch: 98 | storeIndex@47@10 + 1 <= i@120@10 && i@120@10 <= right@8@10]
(assert (and (<= (+ storeIndex@47@10 1) i@120@10) (<= i@120@10 right@8@10)))
; [eval] left <= pw[i] && pw[i] <= right
; [eval] left <= pw[i]
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@120@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@120@10 (Seq_length pw@111@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
; [then-branch: 99 | !(storeIndex@47@10 + 1 <= pw@111@10[i@120@10]) | live]
; [else-branch: 99 | storeIndex@47@10 + 1 <= pw@111@10[i@120@10] | live]
(push) ; 10
; [then-branch: 99 | !(storeIndex@47@10 + 1 <= pw@111@10[i@120@10])]
(assert (not (<= (+ storeIndex@47@10 1) (Seq_index pw@111@10 i@120@10))))
(pop) ; 10
(push) ; 10
; [else-branch: 99 | storeIndex@47@10 + 1 <= pw@111@10[i@120@10]]
(assert (<= (+ storeIndex@47@10 1) (Seq_index pw@111@10 i@120@10)))
; [eval] pw[i] <= right
; [eval] pw[i]
(push) ; 11
(assert (not (>= i@120@10 0)))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(push) ; 11
(assert (not (< i@120@10 (Seq_length pw@111@10))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or
  (<= (+ storeIndex@47@10 1) (Seq_index pw@111@10 i@120@10))
  (not (<= (+ storeIndex@47@10 1) (Seq_index pw@111@10 i@120@10)))))
(pop) ; 8
(push) ; 8
; [else-branch: 98 | !(storeIndex@47@10 + 1 <= i@120@10 && i@120@10 <= right@8@10)]
(assert (not (and (<= (+ storeIndex@47@10 1) i@120@10) (<= i@120@10 right@8@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (=>
  (and (<= (+ storeIndex@47@10 1) i@120@10) (<= i@120@10 right@8@10))
  (and
    (<= (+ storeIndex@47@10 1) i@120@10)
    (<= i@120@10 right@8@10)
    (or
      (<= (+ storeIndex@47@10 1) (Seq_index pw@111@10 i@120@10))
      (not (<= (+ storeIndex@47@10 1) (Seq_index pw@111@10 i@120@10)))))))
; Joined path conditions
(assert (or
  (not (and (<= (+ storeIndex@47@10 1) i@120@10) (<= i@120@10 right@8@10)))
  (and (<= (+ storeIndex@47@10 1) i@120@10) (<= i@120@10 right@8@10))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@120@10 Int)) (!
  (and
    (or
      (<= (+ storeIndex@47@10 1) i@120@10)
      (not (<= (+ storeIndex@47@10 1) i@120@10)))
    (=>
      (and (<= (+ storeIndex@47@10 1) i@120@10) (<= i@120@10 right@8@10))
      (and
        (<= (+ storeIndex@47@10 1) i@120@10)
        (<= i@120@10 right@8@10)
        (or
          (<= (+ storeIndex@47@10 1) (Seq_index pw@111@10 i@120@10))
          (not (<= (+ storeIndex@47@10 1) (Seq_index pw@111@10 i@120@10))))))
    (or
      (not (and (<= (+ storeIndex@47@10 1) i@120@10) (<= i@120@10 right@8@10)))
      (and (<= (+ storeIndex@47@10 1) i@120@10) (<= i@120@10 right@8@10))))
  :pattern ((Seq_index pw@111@10 i@120@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@149@11@149@87-aux|)))
(assert (forall ((i@120@10 Int)) (!
  (=>
    (and (<= (+ storeIndex@47@10 1) i@120@10) (<= i@120@10 right@8@10))
    (and
      (<= (+ storeIndex@47@10 1) (Seq_index pw@111@10 i@120@10))
      (<= (Seq_index pw@111@10 i@120@10) right@8@10)))
  :pattern ((Seq_index pw@111@10 i@120@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@149@11@149@87|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10)))))))))
  $Snap.unit))
; [eval] (forall i: Int, j: Int :: { pw[i], pw[j] } left <= i && (i < j && j <= right) ==> pw[i] != pw[j])
(declare-const i@121@10 Int)
(declare-const j@122@10 Int)
(push) ; 6
; [eval] left <= i && (i < j && j <= right) ==> pw[i] != pw[j]
; [eval] left <= i && (i < j && j <= right)
; [eval] left <= i
(push) ; 7
; [then-branch: 100 | !(storeIndex@47@10 + 1 <= i@121@10) | live]
; [else-branch: 100 | storeIndex@47@10 + 1 <= i@121@10 | live]
(push) ; 8
; [then-branch: 100 | !(storeIndex@47@10 + 1 <= i@121@10)]
(assert (not (<= (+ storeIndex@47@10 1) i@121@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 100 | storeIndex@47@10 + 1 <= i@121@10]
(assert (<= (+ storeIndex@47@10 1) i@121@10))
; [eval] i < j
(push) ; 9
; [then-branch: 101 | !(i@121@10 < j@122@10) | live]
; [else-branch: 101 | i@121@10 < j@122@10 | live]
(push) ; 10
; [then-branch: 101 | !(i@121@10 < j@122@10)]
(assert (not (< i@121@10 j@122@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 101 | i@121@10 < j@122@10]
(assert (< i@121@10 j@122@10))
; [eval] j <= right
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (< i@121@10 j@122@10) (not (< i@121@10 j@122@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= (+ storeIndex@47@10 1) i@121@10)
  (and
    (<= (+ storeIndex@47@10 1) i@121@10)
    (or (< i@121@10 j@122@10) (not (< i@121@10 j@122@10))))))
(assert (or
  (<= (+ storeIndex@47@10 1) i@121@10)
  (not (<= (+ storeIndex@47@10 1) i@121@10))))
(push) ; 7
; [then-branch: 102 | storeIndex@47@10 + 1 <= i@121@10 && i@121@10 < j@122@10 && j@122@10 <= right@8@10 | live]
; [else-branch: 102 | !(storeIndex@47@10 + 1 <= i@121@10 && i@121@10 < j@122@10 && j@122@10 <= right@8@10) | live]
(push) ; 8
; [then-branch: 102 | storeIndex@47@10 + 1 <= i@121@10 && i@121@10 < j@122@10 && j@122@10 <= right@8@10]
(assert (and
  (<= (+ storeIndex@47@10 1) i@121@10)
  (and (< i@121@10 j@122@10) (<= j@122@10 right@8@10))))
; [eval] pw[i] != pw[j]
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@121@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@121@10 (Seq_length pw@111@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] pw[j]
(push) ; 9
(assert (not (>= j@122@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< j@122@10 (Seq_length pw@111@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 102 | !(storeIndex@47@10 + 1 <= i@121@10 && i@121@10 < j@122@10 && j@122@10 <= right@8@10)]
(assert (not
  (and
    (<= (+ storeIndex@47@10 1) i@121@10)
    (and (< i@121@10 j@122@10) (<= j@122@10 right@8@10)))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (=>
  (and
    (<= (+ storeIndex@47@10 1) i@121@10)
    (and (< i@121@10 j@122@10) (<= j@122@10 right@8@10)))
  (and
    (<= (+ storeIndex@47@10 1) i@121@10)
    (< i@121@10 j@122@10)
    (<= j@122@10 right@8@10))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= (+ storeIndex@47@10 1) i@121@10)
      (and (< i@121@10 j@122@10) (<= j@122@10 right@8@10))))
  (and
    (<= (+ storeIndex@47@10 1) i@121@10)
    (and (< i@121@10 j@122@10) (<= j@122@10 right@8@10)))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@121@10 Int) (j@122@10 Int)) (!
  (and
    (=>
      (<= (+ storeIndex@47@10 1) i@121@10)
      (and
        (<= (+ storeIndex@47@10 1) i@121@10)
        (or (< i@121@10 j@122@10) (not (< i@121@10 j@122@10)))))
    (or
      (<= (+ storeIndex@47@10 1) i@121@10)
      (not (<= (+ storeIndex@47@10 1) i@121@10)))
    (=>
      (and
        (<= (+ storeIndex@47@10 1) i@121@10)
        (and (< i@121@10 j@122@10) (<= j@122@10 right@8@10)))
      (and
        (<= (+ storeIndex@47@10 1) i@121@10)
        (< i@121@10 j@122@10)
        (<= j@122@10 right@8@10)))
    (or
      (not
        (and
          (<= (+ storeIndex@47@10 1) i@121@10)
          (and (< i@121@10 j@122@10) (<= j@122@10 right@8@10))))
      (and
        (<= (+ storeIndex@47@10 1) i@121@10)
        (and (< i@121@10 j@122@10) (<= j@122@10 right@8@10)))))
  :pattern ((Seq_index pw@111@10 i@121@10) (Seq_index pw@111@10 j@122@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@150@11@150@87-aux|)))
(assert (forall ((i@121@10 Int) (j@122@10 Int)) (!
  (=>
    (and
      (<= (+ storeIndex@47@10 1) i@121@10)
      (and (< i@121@10 j@122@10) (<= j@122@10 right@8@10)))
    (not (= (Seq_index pw@111@10 i@121@10) (Seq_index pw@111@10 j@122@10))))
  :pattern ((Seq_index pw@111@10 i@121@10) (Seq_index pw@111@10 j@122@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@150@11@150@87|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@112@10)))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val))
(declare-const i@123@10 Int)
(push) ; 6
; [eval] left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 103 | !(storeIndex@47@10 + 1 <= i@123@10) | live]
; [else-branch: 103 | storeIndex@47@10 + 1 <= i@123@10 | live]
(push) ; 8
; [then-branch: 103 | !(storeIndex@47@10 + 1 <= i@123@10)]
(assert (not (<= (+ storeIndex@47@10 1) i@123@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 103 | storeIndex@47@10 + 1 <= i@123@10]
(assert (<= (+ storeIndex@47@10 1) i@123@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or
  (<= (+ storeIndex@47@10 1) i@123@10)
  (not (<= (+ storeIndex@47@10 1) i@123@10))))
(push) ; 7
; [then-branch: 104 | storeIndex@47@10 + 1 <= i@123@10 && i@123@10 <= right@8@10 | live]
; [else-branch: 104 | !(storeIndex@47@10 + 1 <= i@123@10 && i@123@10 <= right@8@10) | live]
(push) ; 8
; [then-branch: 104 | storeIndex@47@10 + 1 <= i@123@10 && i@123@10 <= right@8@10]
(assert (and (<= (+ storeIndex@47@10 1) i@123@10) (<= i@123@10 right@8@10)))
; [eval] loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] loc(a, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (< $Perm.No (- $Perm.Write (pTaken@108@10 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
    :qid |qp.fvfValDef8|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@115@10 r)
        (and
          (<= (+ storeIndex@47@10 1) (inv@114@10 r))
          (<= (inv@114@10 r) right@8@10)))
      (=
        ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r))
    :qid |qp.fvfValDef9|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@52@10 (loc<Ref> a@6@10 i@123@10))
        (and
          (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 i@123@10)))
          (<= (inv@51@10 (loc<Ref> a@6@10 i@123@10)) right@8@10)))
      (- $Perm.Write (pTaken@108@10 (loc<Ref> a@6@10 i@123@10)))
      $Perm.No)
    (ite
      (and
        (img@115@10 (loc<Ref> a@6@10 i@123@10))
        (and
          (<= (+ storeIndex@47@10 1) (inv@114@10 (loc<Ref> a@6@10 i@123@10)))
          (<= (inv@114@10 (loc<Ref> a@6@10 i@123@10)) right@8@10)))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, pw[i]).val)
; [eval] loc(a, pw[i])
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@123@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@123@10 (Seq_length pw@111@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (and
  (img@52@10 (loc<Ref> a@6@10 (Seq_index pw@111@10 i@123@10)))
  (and
    (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 (Seq_index pw@111@10 i@123@10))))
    (<= (inv@51@10 (loc<Ref> a@6@10 (Seq_index pw@111@10 i@123@10))) right@8@10)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 104 | !(storeIndex@47@10 + 1 <= i@123@10 && i@123@10 <= right@8@10)]
(assert (not (and (<= (+ storeIndex@47@10 1) i@123@10) (<= i@123@10 right@8@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@108@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@115@10 r)
      (and
        (<= (+ storeIndex@47@10 1) (inv@114@10 r))
        (<= (inv@114@10 r) right@8@10)))
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r))
  :qid |qp.fvfValDef9|)))
; Joined path conditions
(assert (or
  (not (and (<= (+ storeIndex@47@10 1) i@123@10) (<= i@123@10 right@8@10)))
  (and (<= (+ storeIndex@47@10 1) i@123@10) (<= i@123@10 right@8@10))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@108@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@115@10 r)
      (and
        (<= (+ storeIndex@47@10 1) (inv@114@10 r))
        (<= (inv@114@10 r) right@8@10)))
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r))
  :qid |qp.fvfValDef9|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@123@10 Int)) (!
  (and
    (or
      (<= (+ storeIndex@47@10 1) i@123@10)
      (not (<= (+ storeIndex@47@10 1) i@123@10)))
    (or
      (not (and (<= (+ storeIndex@47@10 1) i@123@10) (<= i@123@10 right@8@10)))
      (and (<= (+ storeIndex@47@10 1) i@123@10) (<= i@123@10 right@8@10))))
  :pattern ((Seq_index pw@111@10 i@123@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@152@11@152@39-aux|)))
(assert (forall ((i@123@10 Int)) (!
  (=>
    (and (<= (+ storeIndex@47@10 1) i@123@10) (<= i@123@10 right@8@10))
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) (loc<Ref> a@6@10 i@123@10))
      ($FVF.lookup_val (as sm@109@10  $FVF<val>) (loc<Ref> a@6@10 (Seq_index
        pw@111@10
        i@123@10)))))
  :pattern ((Seq_index pw@111@10 i@123@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@152@11@152@39|)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
; [exec]
; assert dummy(pwRec[storeIndex])
; [eval] dummy(pwRec[storeIndex])
; [eval] pwRec[storeIndex]
(set-option :timeout 0)
(push) ; 6
(assert (not (>= storeIndex@110@10 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (< storeIndex@110@10 (Seq_length pw@111@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (dummy%precondition $Snap.unit (Seq_index pw@111@10 storeIndex@110@10)))
(pop) ; 6
; Joined path conditions
(assert (dummy%precondition $Snap.unit (Seq_index pw@111@10 storeIndex@110@10)))
(push) ; 6
(assert (not (dummy $Snap.unit (Seq_index pw@111@10 storeIndex@110@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (dummy $Snap.unit (Seq_index pw@111@10 storeIndex@110@10)))
; [exec]
; inhale |pw| == right + 1
(declare-const $t@124@10 $Snap)
(assert (= $t@124@10 $Snap.unit))
; [eval] |pw| == right + 1
; [eval] |pw|
; [eval] right + 1
(assert (= (Seq_length pw@11@10) (+ right@8@10 1)))
; State saturation: after inhale
(set-option :timeout 20)
(check-sat)
; unknown
; [exec]
; inhale (forall i: Int ::
;     { pw[i] }
;     { pwPar[i] }
;     left <= i && i <= pivotIndex ==> pw[i] == pwPar[i])
(declare-const $t@125@10 $Snap)
(assert (= $t@125@10 $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } { pwPar[i] } left <= i && i <= pivotIndex ==> pw[i] == pwPar[i])
(declare-const i@126@10 Int)
(set-option :timeout 0)
(push) ; 6
; [eval] left <= i && i <= pivotIndex ==> pw[i] == pwPar[i]
; [eval] left <= i && i <= pivotIndex
; [eval] left <= i
(push) ; 7
; [then-branch: 105 | !(left@7@10 <= i@126@10) | live]
; [else-branch: 105 | left@7@10 <= i@126@10 | live]
(push) ; 8
; [then-branch: 105 | !(left@7@10 <= i@126@10)]
(assert (not (<= left@7@10 i@126@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 105 | left@7@10 <= i@126@10]
(assert (<= left@7@10 i@126@10))
; [eval] i <= pivotIndex
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@126@10) (not (<= left@7@10 i@126@10))))
(push) ; 7
; [then-branch: 106 | left@7@10 <= i@126@10 && i@126@10 <= storeIndex@47@10 | live]
; [else-branch: 106 | !(left@7@10 <= i@126@10 && i@126@10 <= storeIndex@47@10) | live]
(push) ; 8
; [then-branch: 106 | left@7@10 <= i@126@10 && i@126@10 <= storeIndex@47@10]
(assert (and (<= left@7@10 i@126@10) (<= i@126@10 storeIndex@47@10)))
; [eval] pw[i] == pwPar[i]
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@126@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@126@10 (Seq_length pw@11@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] pwPar[i]
(push) ; 9
(assert (not (>= i@126@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@126@10 (Seq_length pw@48@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 106 | !(left@7@10 <= i@126@10 && i@126@10 <= storeIndex@47@10)]
(assert (not (and (<= left@7@10 i@126@10) (<= i@126@10 storeIndex@47@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@126@10) (<= i@126@10 storeIndex@47@10)))
  (and (<= left@7@10 i@126@10) (<= i@126@10 storeIndex@47@10))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@126@10 Int)) (!
  (and
    (or (<= left@7@10 i@126@10) (not (<= left@7@10 i@126@10)))
    (or
      (not (and (<= left@7@10 i@126@10) (<= i@126@10 storeIndex@47@10)))
      (and (<= left@7@10 i@126@10) (<= i@126@10 storeIndex@47@10))))
  :pattern ((Seq_index pw@11@10 i@126@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@206@14@206@81-aux|)))
(assert (forall ((i@126@10 Int)) (!
  (and
    (or (<= left@7@10 i@126@10) (not (<= left@7@10 i@126@10)))
    (or
      (not (and (<= left@7@10 i@126@10) (<= i@126@10 storeIndex@47@10)))
      (and (<= left@7@10 i@126@10) (<= i@126@10 storeIndex@47@10))))
  :pattern ((Seq_index pw@48@10 i@126@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@206@14@206@81-aux|)))
(assert (forall ((i@126@10 Int)) (!
  (=>
    (and (<= left@7@10 i@126@10) (<= i@126@10 storeIndex@47@10))
    (= (Seq_index pw@11@10 i@126@10) (Seq_index pw@48@10 i@126@10)))
  :pattern ((Seq_index pw@11@10 i@126@10))
  :pattern ((Seq_index pw@48@10 i@126@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@206@14@206@81|)))
; State saturation: after inhale
(set-option :timeout 20)
(check-sat)
; unknown
; [exec]
; inhale (forall i: Int ::
;     { pw[i] }
;     { pwPar[pwRec[i]] }
;     pivotIndex + 1 <= i && i <= right ==> pw[i] == pwPar[pwRec[i]])
(declare-const $t@127@10 $Snap)
(assert (= $t@127@10 $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } { pwPar[pwRec[i]] } pivotIndex + 1 <= i && i <= right ==> pw[i] == pwPar[pwRec[i]])
(declare-const i@128@10 Int)
(set-option :timeout 0)
(push) ; 6
; [eval] pivotIndex + 1 <= i && i <= right ==> pw[i] == pwPar[pwRec[i]]
; [eval] pivotIndex + 1 <= i && i <= right
; [eval] pivotIndex + 1 <= i
; [eval] pivotIndex + 1
(push) ; 7
; [then-branch: 107 | !(storeIndex@47@10 + 1 <= i@128@10) | live]
; [else-branch: 107 | storeIndex@47@10 + 1 <= i@128@10 | live]
(push) ; 8
; [then-branch: 107 | !(storeIndex@47@10 + 1 <= i@128@10)]
(assert (not (<= (+ storeIndex@47@10 1) i@128@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 107 | storeIndex@47@10 + 1 <= i@128@10]
(assert (<= (+ storeIndex@47@10 1) i@128@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or
  (<= (+ storeIndex@47@10 1) i@128@10)
  (not (<= (+ storeIndex@47@10 1) i@128@10))))
(push) ; 7
; [then-branch: 108 | storeIndex@47@10 + 1 <= i@128@10 && i@128@10 <= right@8@10 | live]
; [else-branch: 108 | !(storeIndex@47@10 + 1 <= i@128@10 && i@128@10 <= right@8@10) | live]
(push) ; 8
; [then-branch: 108 | storeIndex@47@10 + 1 <= i@128@10 && i@128@10 <= right@8@10]
(assert (and (<= (+ storeIndex@47@10 1) i@128@10) (<= i@128@10 right@8@10)))
; [eval] pw[i] == pwPar[pwRec[i]]
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@128@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@128@10 (Seq_length pw@11@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] pwPar[pwRec[i]]
; [eval] pwRec[i]
(push) ; 9
(assert (not (>= i@128@10 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@128@10 (Seq_length pw@111@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (>= (Seq_index pw@111@10 i@128@10) 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< (Seq_index pw@111@10 i@128@10) (Seq_length pw@48@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 108 | !(storeIndex@47@10 + 1 <= i@128@10 && i@128@10 <= right@8@10)]
(assert (not (and (<= (+ storeIndex@47@10 1) i@128@10) (<= i@128@10 right@8@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= (+ storeIndex@47@10 1) i@128@10) (<= i@128@10 right@8@10)))
  (and (<= (+ storeIndex@47@10 1) i@128@10) (<= i@128@10 right@8@10))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@128@10 Int)) (!
  (and
    (or
      (<= (+ storeIndex@47@10 1) i@128@10)
      (not (<= (+ storeIndex@47@10 1) i@128@10)))
    (or
      (not (and (<= (+ storeIndex@47@10 1) i@128@10) (<= i@128@10 right@8@10)))
      (and (<= (+ storeIndex@47@10 1) i@128@10) (<= i@128@10 right@8@10))))
  :pattern ((Seq_index pw@11@10 i@128@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@207@14@207@93-aux|)))
(assert (forall ((i@128@10 Int)) (!
  (and
    (or
      (<= (+ storeIndex@47@10 1) i@128@10)
      (not (<= (+ storeIndex@47@10 1) i@128@10)))
    (or
      (not (and (<= (+ storeIndex@47@10 1) i@128@10) (<= i@128@10 right@8@10)))
      (and (<= (+ storeIndex@47@10 1) i@128@10) (<= i@128@10 right@8@10))))
  :pattern ((Seq_index pw@48@10 (Seq_index pw@111@10 i@128@10)))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@207@14@207@93-aux|)))
(assert (forall ((i@128@10 Int)) (!
  (=>
    (and (<= (+ storeIndex@47@10 1) i@128@10) (<= i@128@10 right@8@10))
    (=
      (Seq_index pw@11@10 i@128@10)
      (Seq_index pw@48@10 (Seq_index pw@111@10 i@128@10))))
  :pattern ((Seq_index pw@11@10 i@128@10))
  :pattern ((Seq_index pw@48@10 (Seq_index pw@111@10 i@128@10)))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@207@14@207@93|)))
; State saturation: after inhale
(set-option :timeout 20)
(check-sat)
; unknown
; [eval] left <= storeIndex
(set-option :timeout 0)
(push) ; 6
(assert (not (<= left@7@10 storeIndex@110@10)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (<= left@7@10 storeIndex@110@10))
; [eval] storeIndex <= right
(declare-const i@129@10 Int)
(push) ; 6
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 109 | !(left@7@10 <= i@129@10) | live]
; [else-branch: 109 | left@7@10 <= i@129@10 | live]
(push) ; 8
; [then-branch: 109 | !(left@7@10 <= i@129@10)]
(assert (not (<= left@7@10 i@129@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 109 | left@7@10 <= i@129@10]
(assert (<= left@7@10 i@129@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@129@10) (not (<= left@7@10 i@129@10))))
(assert (and (<= left@7@10 i@129@10) (<= i@129@10 right@8@10)))
; [eval] loc(a, i)
(pop) ; 6
(declare-fun inv@130@10 ($Ref) Int)
(declare-fun img@131@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@129@10 Int)) (!
  (=>
    (and (<= left@7@10 i@129@10) (<= i@129@10 right@8@10))
    (or (<= left@7@10 i@129@10) (not (<= left@7@10 i@129@10))))
  :pattern ((loc<Ref> a@6@10 i@129@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 6
(assert (not (forall ((i1@129@10 Int) (i2@129@10 Int)) (!
  (=>
    (and
      (and (<= left@7@10 i1@129@10) (<= i1@129@10 right@8@10))
      (and (<= left@7@10 i2@129@10) (<= i2@129@10 right@8@10))
      (= (loc<Ref> a@6@10 i1@129@10) (loc<Ref> a@6@10 i2@129@10)))
    (= i1@129@10 i2@129@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@129@10 Int)) (!
  (=>
    (and (<= left@7@10 i@129@10) (<= i@129@10 right@8@10))
    (and
      (= (inv@130@10 (loc<Ref> a@6@10 i@129@10)) i@129@10)
      (img@131@10 (loc<Ref> a@6@10 i@129@10))))
  :pattern ((loc<Ref> a@6@10 i@129@10))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@131@10 r)
      (and (<= left@7@10 (inv@130@10 r)) (<= (inv@130@10 r) right@8@10)))
    (= (loc<Ref> a@6@10 (inv@130@10 r)) r))
  :pattern ((inv@130@10 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@132@10 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= left@7@10 (inv@130@10 r)) (<= (inv@130@10 r) right@8@10))
      (img@131@10 r)
      (= r (loc<Ref> a@6@10 (inv@130@10 r))))
    ($Perm.min
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (- $Perm.Write (pTaken@108@10 r))
        $Perm.No)
      $Perm.Write)
    $Perm.No))
(define-fun pTaken@133@10 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= left@7@10 (inv@130@10 r)) (<= (inv@130@10 r) right@8@10))
      (img@131@10 r)
      (= r (loc<Ref> a@6@10 (inv@130@10 r))))
    ($Perm.min
      (ite
        (and
          (img@115@10 r)
          (and
            (<= (+ storeIndex@47@10 1) (inv@114@10 r))
            (<= (inv@114@10 r) right@8@10)))
        $Perm.Write
        $Perm.No)
      (- $Perm.Write (pTaken@132@10 r)))
    $Perm.No))
; Done precomputing, updating quantified chunks
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Chunk depleted?
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (- $Perm.Write (pTaken@108@10 r))
        $Perm.No)
      (pTaken@132@10 r))
    $Perm.No)
  
  :qid |quant-u-94|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and (<= left@7@10 (inv@130@10 r)) (<= (inv@130@10 r) right@8@10))
      (img@131@10 r)
      (= r (loc<Ref> a@6@10 (inv@130@10 r))))
    (= (- $Perm.Write (pTaken@132@10 r)) $Perm.No))
  
  :qid |quant-u-95|))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@115@10 r)
          (and
            (<= (+ storeIndex@47@10 1) (inv@114@10 r))
            (<= (inv@114@10 r) right@8@10)))
        $Perm.Write
        $Perm.No)
      (pTaken@133@10 r))
    $Perm.No)
  
  :qid |quant-u-96|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and (<= left@7@10 (inv@130@10 r)) (<= (inv@130@10 r) right@8@10))
      (img@131@10 r)
      (= r (loc<Ref> a@6@10 (inv@130@10 r))))
    (= (- (- $Perm.Write (pTaken@132@10 r)) (pTaken@133@10 r)) $Perm.No))
  
  :qid |quant-u-97|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
; Definitional axioms for snapshot map values
; [eval] storeIndex == n
; [eval] (forall i: Int :: { loc(a, i) } left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val)
(declare-const i@134@10 Int)
(set-option :timeout 0)
(push) ; 6
; [eval] left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val
; [eval] left <= i && i < storeIndex
; [eval] left <= i
(push) ; 7
; [then-branch: 110 | !(left@7@10 <= i@134@10) | live]
; [else-branch: 110 | left@7@10 <= i@134@10 | live]
(push) ; 8
; [then-branch: 110 | !(left@7@10 <= i@134@10)]
(assert (not (<= left@7@10 i@134@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 110 | left@7@10 <= i@134@10]
(assert (<= left@7@10 i@134@10))
; [eval] i < storeIndex
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@10 i@134@10) (not (<= left@7@10 i@134@10))))
(push) ; 7
; [then-branch: 111 | left@7@10 <= i@134@10 && i@134@10 < storeIndex@110@10 | live]
; [else-branch: 111 | !(left@7@10 <= i@134@10 && i@134@10 < storeIndex@110@10) | live]
(push) ; 8
; [then-branch: 111 | left@7@10 <= i@134@10 && i@134@10 < storeIndex@110@10]
(assert (and (<= left@7@10 i@134@10) (< i@134@10 storeIndex@110@10)))
; [eval] loc(a, i).val <= loc(a, storeIndex).val
; [eval] loc(a, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (< $Perm.No (- $Perm.Write (pTaken@108@10 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
    :qid |qp.fvfValDef8|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@115@10 r)
        (and
          (<= (+ storeIndex@47@10 1) (inv@114@10 r))
          (<= (inv@114@10 r) right@8@10)))
      (=
        ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r))
    :qid |qp.fvfValDef9|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@52@10 (loc<Ref> a@6@10 i@134@10))
        (and
          (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 i@134@10)))
          (<= (inv@51@10 (loc<Ref> a@6@10 i@134@10)) right@8@10)))
      (- $Perm.Write (pTaken@108@10 (loc<Ref> a@6@10 i@134@10)))
      $Perm.No)
    (ite
      (and
        (img@115@10 (loc<Ref> a@6@10 i@134@10))
        (and
          (<= (+ storeIndex@47@10 1) (inv@114@10 (loc<Ref> a@6@10 i@134@10)))
          (<= (inv@114@10 (loc<Ref> a@6@10 i@134@10)) right@8@10)))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, storeIndex)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@52@10 r)
          (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
        (< $Perm.No (- $Perm.Write (pTaken@108@10 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
    :qid |qp.fvfValDef8|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@115@10 r)
        (and
          (<= (+ storeIndex@47@10 1) (inv@114@10 r))
          (<= (inv@114@10 r) right@8@10)))
      (=
        ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r)))
    :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r))
    :qid |qp.fvfValDef9|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@52@10 (loc<Ref> a@6@10 storeIndex@110@10))
        (and
          (<= left@7@10 (inv@51@10 (loc<Ref> a@6@10 storeIndex@110@10)))
          (<= (inv@51@10 (loc<Ref> a@6@10 storeIndex@110@10)) right@8@10)))
      (- $Perm.Write (pTaken@108@10 (loc<Ref> a@6@10 storeIndex@110@10)))
      $Perm.No)
    (ite
      (and
        (img@115@10 (loc<Ref> a@6@10 storeIndex@110@10))
        (and
          (<=
            (+ storeIndex@47@10 1)
            (inv@114@10 (loc<Ref> a@6@10 storeIndex@110@10)))
          (<= (inv@114@10 (loc<Ref> a@6@10 storeIndex@110@10)) right@8@10)))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 111 | !(left@7@10 <= i@134@10 && i@134@10 < storeIndex@110@10)]
(assert (not (and (<= left@7@10 i@134@10) (< i@134@10 storeIndex@110@10))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@108@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@115@10 r)
      (and
        (<= (+ storeIndex@47@10 1) (inv@114@10 r))
        (<= (inv@114@10 r) right@8@10)))
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r))
  :qid |qp.fvfValDef9|)))
; Joined path conditions
(assert (or
  (not (and (<= left@7@10 i@134@10) (< i@134@10 storeIndex@110@10)))
  (and (<= left@7@10 i@134@10) (< i@134@10 storeIndex@110@10))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@52@10 r)
        (and (<= left@7@10 (inv@51@10 r)) (<= (inv@51@10 r) right@8@10)))
      (< $Perm.No (- $Perm.Write (pTaken@108@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@49@10)))) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@115@10 r)
      (and
        (<= (+ storeIndex@47@10 1) (inv@114@10 r))
        (<= (inv@114@10 r) right@8@10)))
    (=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r)))
  :pattern (($FVF.lookup_val (as sm@117@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@112@10)))) r))
  :qid |qp.fvfValDef9|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@134@10 Int)) (!
  (and
    (or (<= left@7@10 i@134@10) (not (<= left@7@10 i@134@10)))
    (or
      (not (and (<= left@7@10 i@134@10) (< i@134@10 storeIndex@110@10)))
      (and (<= left@7@10 i@134@10) (< i@134@10 storeIndex@110@10))))
  :pattern ((loc<Ref> a@6@10 i@134@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100-aux|)))
(push) ; 6
(assert (not (forall ((i@134@10 Int)) (!
  (=>
    (and (<= left@7@10 i@134@10) (< i@134@10 storeIndex@110@10))
    (<=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) (loc<Ref> a@6@10 i@134@10))
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) (loc<Ref> a@6@10 storeIndex@110@10))))
  :pattern ((loc<Ref> a@6@10 i@134@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@134@10 Int)) (!
  (=>
    (and (<= left@7@10 i@134@10) (< i@134@10 storeIndex@110@10))
    (<=
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) (loc<Ref> a@6@10 i@134@10))
      ($FVF.lookup_val (as sm@117@10  $FVF<val>) (loc<Ref> a@6@10 storeIndex@110@10))))
  :pattern ((loc<Ref> a@6@10 i@134@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@145@11@145@100|)))
; [eval] (forall i: Int :: { loc(a, i) } storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val)
(declare-const i@135@10 Int)
(push) ; 6
; [eval] storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val
; [eval] storeIndex < i && i <= right
; [eval] storeIndex < i
(push) ; 7
; [then-branch: 112 | !(storeIndex@110@10 < i@135@10) | live]
; [else-branch: 112 | storeIndex@110@10 < i@135@10 | live]
(push) ; 8
; [then-branch: 112 | !(storeIndex@110@10 < i@135@10)]
(assert (not (< storeIndex@110@10 i@135@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 112 | storeIndex@110@10 < i@135@10]
(assert (< storeIndex@110@10 i@135@10))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (< storeIndex@110@10 i@135@10) (not (< storeIndex@110@10 i@135@10))))
(push) ; 7
