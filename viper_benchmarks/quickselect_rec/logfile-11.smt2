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
; ---------- partition ----------
(declare-const a@0@11 IArray)
(declare-const left@1@11 Int)
(declare-const right@2@11 Int)
(declare-const pivotIndex@3@11 Int)
(declare-const storeIndex@4@11 Int)
(declare-const pw@5@11 Seq<Int>)
(declare-const a@6@11 IArray)
(declare-const left@7@11 Int)
(declare-const right@8@11 Int)
(declare-const pivotIndex@9@11 Int)
(declare-const storeIndex@10@11 Int)
(declare-const pw@11@11 Seq<Int>)
(set-option :timeout 0)
(push) ; 1
(declare-const $t@12@11 $Snap)
(assert (= $t@12@11 ($Snap.combine ($Snap.first $t@12@11) ($Snap.second $t@12@11))))
(assert (= ($Snap.first $t@12@11) $Snap.unit))
; [eval] 0 <= left
(assert (<= 0 left@7@11))
(assert (=
  ($Snap.second $t@12@11)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@12@11))
    ($Snap.second ($Snap.second $t@12@11)))))
(assert (= ($Snap.first ($Snap.second $t@12@11)) $Snap.unit))
; [eval] left < right
(assert (< left@7@11 right@8@11))
(assert (=
  ($Snap.second ($Snap.second $t@12@11))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@12@11)))
    ($Snap.second ($Snap.second ($Snap.second $t@12@11))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@12@11))) $Snap.unit))
; [eval] right < len(a)
; [eval] len(a)
(assert (< right@8@11 (len<Int> a@6@11)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@12@11)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@12@11))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@12@11))))
  $Snap.unit))
; [eval] left <= pivotIndex
(assert (<= left@7@11 pivotIndex@9@11))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))
  $Snap.unit))
; [eval] pivotIndex <= right
(assert (<= pivotIndex@9@11 right@8@11))
(declare-const i@13@11 Int)
(push) ; 2
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 3
; [then-branch: 0 | !(left@7@11 <= i@13@11) | live]
; [else-branch: 0 | left@7@11 <= i@13@11 | live]
(push) ; 4
; [then-branch: 0 | !(left@7@11 <= i@13@11)]
(assert (not (<= left@7@11 i@13@11)))
(pop) ; 4
(push) ; 4
; [else-branch: 0 | left@7@11 <= i@13@11]
(assert (<= left@7@11 i@13@11))
; [eval] i <= right
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@11 i@13@11) (not (<= left@7@11 i@13@11))))
(assert (and (<= left@7@11 i@13@11) (<= i@13@11 right@8@11)))
; [eval] loc(a, i)
(pop) ; 2
(declare-fun inv@14@11 ($Ref) Int)
(declare-fun img@15@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@13@11 Int)) (!
  (=>
    (and (<= left@7@11 i@13@11) (<= i@13@11 right@8@11))
    (or (<= left@7@11 i@13@11) (not (<= left@7@11 i@13@11))))
  :pattern ((loc<Ref> a@6@11 i@13@11))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 2
(assert (not (forall ((i1@13@11 Int) (i2@13@11 Int)) (!
  (=>
    (and
      (and (<= left@7@11 i1@13@11) (<= i1@13@11 right@8@11))
      (and (<= left@7@11 i2@13@11) (<= i2@13@11 right@8@11))
      (= (loc<Ref> a@6@11 i1@13@11) (loc<Ref> a@6@11 i2@13@11)))
    (= i1@13@11 i2@13@11))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 2
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@13@11 Int)) (!
  (=>
    (and (<= left@7@11 i@13@11) (<= i@13@11 right@8@11))
    (and
      (= (inv@14@11 (loc<Ref> a@6@11 i@13@11)) i@13@11)
      (img@15@11 (loc<Ref> a@6@11 i@13@11))))
  :pattern ((loc<Ref> a@6@11 i@13@11))
  :qid |quant-u-7|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@15@11 r)
      (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
    (= (loc<Ref> a@6@11 (inv@14@11 r)) r))
  :pattern ((inv@14@11 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@13@11 Int)) (!
  (=>
    (and (<= left@7@11 i@13@11) (<= i@13@11 right@8@11))
    (not (= (loc<Ref> a@6@11 i@13@11) $Ref.null)))
  :pattern ((loc<Ref> a@6@11 i@13@11))
  :qid |val-permImpliesNonNull|)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
(set-option :timeout 0)
(push) ; 2
(declare-const $t@16@11 $Snap)
(assert (= $t@16@11 ($Snap.combine ($Snap.first $t@16@11) ($Snap.second $t@16@11))))
(assert (= ($Snap.first $t@16@11) $Snap.unit))
; [eval] left <= storeIndex
(assert (<= left@7@11 storeIndex@10@11))
(assert (=
  ($Snap.second $t@16@11)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@16@11))
    ($Snap.second ($Snap.second $t@16@11)))))
(assert (= ($Snap.first ($Snap.second $t@16@11)) $Snap.unit))
; [eval] storeIndex <= right
(assert (<= storeIndex@10@11 right@8@11))
(assert (=
  ($Snap.second ($Snap.second $t@16@11))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@16@11)))
    ($Snap.second ($Snap.second ($Snap.second $t@16@11))))))
(declare-const i@17@11 Int)
(push) ; 3
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 4
; [then-branch: 1 | !(left@7@11 <= i@17@11) | live]
; [else-branch: 1 | left@7@11 <= i@17@11 | live]
(push) ; 5
; [then-branch: 1 | !(left@7@11 <= i@17@11)]
(assert (not (<= left@7@11 i@17@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 1 | left@7@11 <= i@17@11]
(assert (<= left@7@11 i@17@11))
; [eval] i <= right
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@11 i@17@11) (not (<= left@7@11 i@17@11))))
(assert (and (<= left@7@11 i@17@11) (<= i@17@11 right@8@11)))
; [eval] loc(a, i)
(pop) ; 3
(declare-fun inv@18@11 ($Ref) Int)
(declare-fun img@19@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@17@11 Int)) (!
  (=>
    (and (<= left@7@11 i@17@11) (<= i@17@11 right@8@11))
    (or (<= left@7@11 i@17@11) (not (<= left@7@11 i@17@11))))
  :pattern ((loc<Ref> a@6@11 i@17@11))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((i1@17@11 Int) (i2@17@11 Int)) (!
  (=>
    (and
      (and (<= left@7@11 i1@17@11) (<= i1@17@11 right@8@11))
      (and (<= left@7@11 i2@17@11) (<= i2@17@11 right@8@11))
      (= (loc<Ref> a@6@11 i1@17@11) (loc<Ref> a@6@11 i2@17@11)))
    (= i1@17@11 i2@17@11))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@17@11 Int)) (!
  (=>
    (and (<= left@7@11 i@17@11) (<= i@17@11 right@8@11))
    (and
      (= (inv@18@11 (loc<Ref> a@6@11 i@17@11)) i@17@11)
      (img@19@11 (loc<Ref> a@6@11 i@17@11))))
  :pattern ((loc<Ref> a@6@11 i@17@11))
  :qid |quant-u-13|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@19@11 r)
      (and (<= left@7@11 (inv@18@11 r)) (<= (inv@18@11 r) right@8@11)))
    (= (loc<Ref> a@6@11 (inv@18@11 r)) r))
  :pattern ((inv@18@11 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@17@11 Int)) (!
  (=>
    (and (<= left@7@11 i@17@11) (<= i@17@11 right@8@11))
    (not (= (loc<Ref> a@6@11 i@17@11) $Ref.null)))
  :pattern ((loc<Ref> a@6@11 i@17@11))
  :qid |val-permImpliesNonNull|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@16@11)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@16@11))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@16@11))))
  $Snap.unit))
; [eval] loc(a, storeIndex).val == old(loc(a, pivotIndex).val)
; [eval] loc(a, storeIndex)
(push) ; 3
(assert (not (and
  (img@19@11 (loc<Ref> a@6@11 storeIndex@10@11))
  (and
    (<= left@7@11 (inv@18@11 (loc<Ref> a@6@11 storeIndex@10@11)))
    (<= (inv@18@11 (loc<Ref> a@6@11 storeIndex@10@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, pivotIndex).val)
; [eval] loc(a, pivotIndex)
(push) ; 3
(assert (not (and
  (img@15@11 (loc<Ref> a@6@11 pivotIndex@9@11))
  (and
    (<= left@7@11 (inv@14@11 (loc<Ref> a@6@11 pivotIndex@9@11)))
    (<= (inv@14@11 (loc<Ref> a@6@11 pivotIndex@9@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@16@11)))) (loc<Ref> a@6@11 storeIndex@10@11))
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) (loc<Ref> a@6@11 pivotIndex@9@11))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11)))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } left <= i && i < storeIndex ==> loc(a, i).val < loc(a, storeIndex).val)
(declare-const i@20@11 Int)
(push) ; 3
; [eval] left <= i && i < storeIndex ==> loc(a, i).val < loc(a, storeIndex).val
; [eval] left <= i && i < storeIndex
; [eval] left <= i
(push) ; 4
; [then-branch: 2 | !(left@7@11 <= i@20@11) | live]
; [else-branch: 2 | left@7@11 <= i@20@11 | live]
(push) ; 5
; [then-branch: 2 | !(left@7@11 <= i@20@11)]
(assert (not (<= left@7@11 i@20@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 2 | left@7@11 <= i@20@11]
(assert (<= left@7@11 i@20@11))
; [eval] i < storeIndex
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@11 i@20@11) (not (<= left@7@11 i@20@11))))
(push) ; 4
; [then-branch: 3 | left@7@11 <= i@20@11 && i@20@11 < storeIndex@10@11 | live]
; [else-branch: 3 | !(left@7@11 <= i@20@11 && i@20@11 < storeIndex@10@11) | live]
(push) ; 5
; [then-branch: 3 | left@7@11 <= i@20@11 && i@20@11 < storeIndex@10@11]
(assert (and (<= left@7@11 i@20@11) (< i@20@11 storeIndex@10@11)))
; [eval] loc(a, i).val < loc(a, storeIndex).val
; [eval] loc(a, i)
(push) ; 6
(assert (not (and
  (img@19@11 (loc<Ref> a@6@11 i@20@11))
  (and
    (<= left@7@11 (inv@18@11 (loc<Ref> a@6@11 i@20@11)))
    (<= (inv@18@11 (loc<Ref> a@6@11 i@20@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, storeIndex)
(push) ; 6
(assert (not (and
  (img@19@11 (loc<Ref> a@6@11 storeIndex@10@11))
  (and
    (<= left@7@11 (inv@18@11 (loc<Ref> a@6@11 storeIndex@10@11)))
    (<= (inv@18@11 (loc<Ref> a@6@11 storeIndex@10@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 3 | !(left@7@11 <= i@20@11 && i@20@11 < storeIndex@10@11)]
(assert (not (and (<= left@7@11 i@20@11) (< i@20@11 storeIndex@10@11))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= left@7@11 i@20@11) (< i@20@11 storeIndex@10@11)))
  (and (<= left@7@11 i@20@11) (< i@20@11 storeIndex@10@11))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@20@11 Int)) (!
  (and
    (or (<= left@7@11 i@20@11) (not (<= left@7@11 i@20@11)))
    (or
      (not (and (<= left@7@11 i@20@11) (< i@20@11 storeIndex@10@11)))
      (and (<= left@7@11 i@20@11) (< i@20@11 storeIndex@10@11))))
  :pattern ((loc<Ref> a@6@11 i@20@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@59@11@59@99-aux|)))
(assert (forall ((i@20@11 Int)) (!
  (=>
    (and (<= left@7@11 i@20@11) (< i@20@11 storeIndex@10@11))
    (<
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@16@11)))) (loc<Ref> a@6@11 i@20@11))
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@16@11)))) (loc<Ref> a@6@11 storeIndex@10@11))))
  :pattern ((loc<Ref> a@6@11 i@20@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@59@11@59@99|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11))))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val)
(declare-const i@21@11 Int)
(push) ; 3
; [eval] storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val
; [eval] storeIndex < i && i <= right
; [eval] storeIndex < i
(push) ; 4
; [then-branch: 4 | !(storeIndex@10@11 < i@21@11) | live]
; [else-branch: 4 | storeIndex@10@11 < i@21@11 | live]
(push) ; 5
; [then-branch: 4 | !(storeIndex@10@11 < i@21@11)]
(assert (not (< storeIndex@10@11 i@21@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 4 | storeIndex@10@11 < i@21@11]
(assert (< storeIndex@10@11 i@21@11))
; [eval] i <= right
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (< storeIndex@10@11 i@21@11) (not (< storeIndex@10@11 i@21@11))))
(push) ; 4
; [then-branch: 5 | storeIndex@10@11 < i@21@11 && i@21@11 <= right@8@11 | live]
; [else-branch: 5 | !(storeIndex@10@11 < i@21@11 && i@21@11 <= right@8@11) | live]
(push) ; 5
; [then-branch: 5 | storeIndex@10@11 < i@21@11 && i@21@11 <= right@8@11]
(assert (and (< storeIndex@10@11 i@21@11) (<= i@21@11 right@8@11)))
; [eval] loc(a, storeIndex).val <= loc(a, i).val
; [eval] loc(a, storeIndex)
(push) ; 6
(assert (not (and
  (img@19@11 (loc<Ref> a@6@11 storeIndex@10@11))
  (and
    (<= left@7@11 (inv@18@11 (loc<Ref> a@6@11 storeIndex@10@11)))
    (<= (inv@18@11 (loc<Ref> a@6@11 storeIndex@10@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, i)
(push) ; 6
(assert (not (and
  (img@19@11 (loc<Ref> a@6@11 i@21@11))
  (and
    (<= left@7@11 (inv@18@11 (loc<Ref> a@6@11 i@21@11)))
    (<= (inv@18@11 (loc<Ref> a@6@11 i@21@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 5 | !(storeIndex@10@11 < i@21@11 && i@21@11 <= right@8@11)]
(assert (not (and (< storeIndex@10@11 i@21@11) (<= i@21@11 right@8@11))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (< storeIndex@10@11 i@21@11) (<= i@21@11 right@8@11)))
  (and (< storeIndex@10@11 i@21@11) (<= i@21@11 right@8@11))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@21@11 Int)) (!
  (and
    (or (< storeIndex@10@11 i@21@11) (not (< storeIndex@10@11 i@21@11)))
    (or
      (not (and (< storeIndex@10@11 i@21@11) (<= i@21@11 right@8@11)))
      (and (< storeIndex@10@11 i@21@11) (<= i@21@11 right@8@11))))
  :pattern ((loc<Ref> a@6@11 i@21@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@60@11@60@100-aux|)))
(assert (forall ((i@21@11 Int)) (!
  (=>
    (and (< storeIndex@10@11 i@21@11) (<= i@21@11 right@8@11))
    (<=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@16@11)))) (loc<Ref> a@6@11 storeIndex@10@11))
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@16@11)))) (loc<Ref> a@6@11 i@21@11))))
  :pattern ((loc<Ref> a@6@11 i@21@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@60@11@60@100|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11)))))))
  $Snap.unit))
; [eval] |pw| == right + 1
; [eval] |pw|
; [eval] right + 1
(assert (= (Seq_length pw@11@11) (+ right@8@11 1)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> left <= pw[i] && pw[i] <= right)
(declare-const i@22@11 Int)
(push) ; 3
; [eval] left <= i && i <= right ==> left <= pw[i] && pw[i] <= right
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 4
; [then-branch: 6 | !(left@7@11 <= i@22@11) | live]
; [else-branch: 6 | left@7@11 <= i@22@11 | live]
(push) ; 5
; [then-branch: 6 | !(left@7@11 <= i@22@11)]
(assert (not (<= left@7@11 i@22@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 6 | left@7@11 <= i@22@11]
(assert (<= left@7@11 i@22@11))
; [eval] i <= right
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@11 i@22@11) (not (<= left@7@11 i@22@11))))
(push) ; 4
; [then-branch: 7 | left@7@11 <= i@22@11 && i@22@11 <= right@8@11 | live]
; [else-branch: 7 | !(left@7@11 <= i@22@11 && i@22@11 <= right@8@11) | live]
(push) ; 5
; [then-branch: 7 | left@7@11 <= i@22@11 && i@22@11 <= right@8@11]
(assert (and (<= left@7@11 i@22@11) (<= i@22@11 right@8@11)))
; [eval] left <= pw[i] && pw[i] <= right
; [eval] left <= pw[i]
; [eval] pw[i]
(push) ; 6
(assert (not (>= i@22@11 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (< i@22@11 (Seq_length pw@11@11))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
; [then-branch: 8 | !(left@7@11 <= pw@11@11[i@22@11]) | live]
; [else-branch: 8 | left@7@11 <= pw@11@11[i@22@11] | live]
(push) ; 7
; [then-branch: 8 | !(left@7@11 <= pw@11@11[i@22@11])]
(assert (not (<= left@7@11 (Seq_index pw@11@11 i@22@11))))
(pop) ; 7
(push) ; 7
; [else-branch: 8 | left@7@11 <= pw@11@11[i@22@11]]
(assert (<= left@7@11 (Seq_index pw@11@11 i@22@11)))
; [eval] pw[i] <= right
; [eval] pw[i]
(push) ; 8
(assert (not (>= i@22@11 0)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(push) ; 8
(assert (not (< i@22@11 (Seq_length pw@11@11))))
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
  (<= left@7@11 (Seq_index pw@11@11 i@22@11))
  (not (<= left@7@11 (Seq_index pw@11@11 i@22@11)))))
(pop) ; 5
(push) ; 5
; [else-branch: 7 | !(left@7@11 <= i@22@11 && i@22@11 <= right@8@11)]
(assert (not (and (<= left@7@11 i@22@11) (<= i@22@11 right@8@11))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (=>
  (and (<= left@7@11 i@22@11) (<= i@22@11 right@8@11))
  (and
    (<= left@7@11 i@22@11)
    (<= i@22@11 right@8@11)
    (or
      (<= left@7@11 (Seq_index pw@11@11 i@22@11))
      (not (<= left@7@11 (Seq_index pw@11@11 i@22@11)))))))
; Joined path conditions
(assert (or
  (not (and (<= left@7@11 i@22@11) (<= i@22@11 right@8@11)))
  (and (<= left@7@11 i@22@11) (<= i@22@11 right@8@11))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@22@11 Int)) (!
  (and
    (or (<= left@7@11 i@22@11) (not (<= left@7@11 i@22@11)))
    (=>
      (and (<= left@7@11 i@22@11) (<= i@22@11 right@8@11))
      (and
        (<= left@7@11 i@22@11)
        (<= i@22@11 right@8@11)
        (or
          (<= left@7@11 (Seq_index pw@11@11 i@22@11))
          (not (<= left@7@11 (Seq_index pw@11@11 i@22@11))))))
    (or
      (not (and (<= left@7@11 i@22@11) (<= i@22@11 right@8@11)))
      (and (<= left@7@11 i@22@11) (<= i@22@11 right@8@11))))
  :pattern ((Seq_index pw@11@11 i@22@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@63@11@63@87-aux|)))
(assert (forall ((i@22@11 Int)) (!
  (=>
    (and (<= left@7@11 i@22@11) (<= i@22@11 right@8@11))
    (and
      (<= left@7@11 (Seq_index pw@11@11 i@22@11))
      (<= (Seq_index pw@11@11 i@22@11) right@8@11)))
  :pattern ((Seq_index pw@11@11 i@22@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@63@11@63@87|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11)))))))))
  $Snap.unit))
; [eval] (forall i: Int, k: Int :: { pw[i], pw[k] } left <= i && (i < k && k <= right) ==> pw[i] != pw[k])
(declare-const i@23@11 Int)
(declare-const k@24@11 Int)
(push) ; 3
; [eval] left <= i && (i < k && k <= right) ==> pw[i] != pw[k]
; [eval] left <= i && (i < k && k <= right)
; [eval] left <= i
(push) ; 4
; [then-branch: 9 | !(left@7@11 <= i@23@11) | live]
; [else-branch: 9 | left@7@11 <= i@23@11 | live]
(push) ; 5
; [then-branch: 9 | !(left@7@11 <= i@23@11)]
(assert (not (<= left@7@11 i@23@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 9 | left@7@11 <= i@23@11]
(assert (<= left@7@11 i@23@11))
; [eval] i < k
(push) ; 6
; [then-branch: 10 | !(i@23@11 < k@24@11) | live]
; [else-branch: 10 | i@23@11 < k@24@11 | live]
(push) ; 7
; [then-branch: 10 | !(i@23@11 < k@24@11)]
(assert (not (< i@23@11 k@24@11)))
(pop) ; 7
(push) ; 7
; [else-branch: 10 | i@23@11 < k@24@11]
(assert (< i@23@11 k@24@11))
; [eval] k <= right
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (< i@23@11 k@24@11) (not (< i@23@11 k@24@11))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= left@7@11 i@23@11)
  (and (<= left@7@11 i@23@11) (or (< i@23@11 k@24@11) (not (< i@23@11 k@24@11))))))
(assert (or (<= left@7@11 i@23@11) (not (<= left@7@11 i@23@11))))
(push) ; 4
; [then-branch: 11 | left@7@11 <= i@23@11 && i@23@11 < k@24@11 && k@24@11 <= right@8@11 | live]
; [else-branch: 11 | !(left@7@11 <= i@23@11 && i@23@11 < k@24@11 && k@24@11 <= right@8@11) | live]
(push) ; 5
; [then-branch: 11 | left@7@11 <= i@23@11 && i@23@11 < k@24@11 && k@24@11 <= right@8@11]
(assert (and (<= left@7@11 i@23@11) (and (< i@23@11 k@24@11) (<= k@24@11 right@8@11))))
; [eval] pw[i] != pw[k]
; [eval] pw[i]
(push) ; 6
(assert (not (>= i@23@11 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (< i@23@11 (Seq_length pw@11@11))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] pw[k]
(push) ; 6
(assert (not (>= k@24@11 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (< k@24@11 (Seq_length pw@11@11))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 11 | !(left@7@11 <= i@23@11 && i@23@11 < k@24@11 && k@24@11 <= right@8@11)]
(assert (not
  (and (<= left@7@11 i@23@11) (and (< i@23@11 k@24@11) (<= k@24@11 right@8@11)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (=>
  (and (<= left@7@11 i@23@11) (and (< i@23@11 k@24@11) (<= k@24@11 right@8@11)))
  (and (<= left@7@11 i@23@11) (< i@23@11 k@24@11) (<= k@24@11 right@8@11))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= left@7@11 i@23@11)
      (and (< i@23@11 k@24@11) (<= k@24@11 right@8@11))))
  (and (<= left@7@11 i@23@11) (and (< i@23@11 k@24@11) (<= k@24@11 right@8@11)))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@23@11 Int) (k@24@11 Int)) (!
  (and
    (=>
      (<= left@7@11 i@23@11)
      (and
        (<= left@7@11 i@23@11)
        (or (< i@23@11 k@24@11) (not (< i@23@11 k@24@11)))))
    (or (<= left@7@11 i@23@11) (not (<= left@7@11 i@23@11)))
    (=>
      (and
        (<= left@7@11 i@23@11)
        (and (< i@23@11 k@24@11) (<= k@24@11 right@8@11)))
      (and (<= left@7@11 i@23@11) (< i@23@11 k@24@11) (<= k@24@11 right@8@11)))
    (or
      (not
        (and
          (<= left@7@11 i@23@11)
          (and (< i@23@11 k@24@11) (<= k@24@11 right@8@11))))
      (and
        (<= left@7@11 i@23@11)
        (and (< i@23@11 k@24@11) (<= k@24@11 right@8@11)))))
  :pattern ((Seq_index pw@11@11 i@23@11) (Seq_index pw@11@11 k@24@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@64@11@64@87-aux|)))
(assert (forall ((i@23@11 Int) (k@24@11 Int)) (!
  (=>
    (and
      (<= left@7@11 i@23@11)
      (and (< i@23@11 k@24@11) (<= k@24@11 right@8@11)))
    (not (= (Seq_index pw@11@11 i@23@11) (Seq_index pw@11@11 k@24@11))))
  :pattern ((Seq_index pw@11@11 i@23@11) (Seq_index pw@11@11 k@24@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@64@11@64@87|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@11)))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val))
(declare-const i@25@11 Int)
(push) ; 3
; [eval] left <= i && i <= right ==> loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 4
; [then-branch: 12 | !(left@7@11 <= i@25@11) | live]
; [else-branch: 12 | left@7@11 <= i@25@11 | live]
(push) ; 5
; [then-branch: 12 | !(left@7@11 <= i@25@11)]
(assert (not (<= left@7@11 i@25@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 12 | left@7@11 <= i@25@11]
(assert (<= left@7@11 i@25@11))
; [eval] i <= right
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@11 i@25@11) (not (<= left@7@11 i@25@11))))
(push) ; 4
; [then-branch: 13 | left@7@11 <= i@25@11 && i@25@11 <= right@8@11 | live]
; [else-branch: 13 | !(left@7@11 <= i@25@11 && i@25@11 <= right@8@11) | live]
(push) ; 5
; [then-branch: 13 | left@7@11 <= i@25@11 && i@25@11 <= right@8@11]
(assert (and (<= left@7@11 i@25@11) (<= i@25@11 right@8@11)))
; [eval] loc(a, i).val == old(loc(a, pw[i]).val)
; [eval] loc(a, i)
(push) ; 6
(assert (not (and
  (img@19@11 (loc<Ref> a@6@11 i@25@11))
  (and
    (<= left@7@11 (inv@18@11 (loc<Ref> a@6@11 i@25@11)))
    (<= (inv@18@11 (loc<Ref> a@6@11 i@25@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, pw[i]).val)
; [eval] loc(a, pw[i])
; [eval] pw[i]
(push) ; 6
(assert (not (>= i@25@11 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (< i@25@11 (Seq_length pw@11@11))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (and
  (img@15@11 (loc<Ref> a@6@11 (Seq_index pw@11@11 i@25@11)))
  (and
    (<= left@7@11 (inv@14@11 (loc<Ref> a@6@11 (Seq_index pw@11@11 i@25@11))))
    (<= (inv@14@11 (loc<Ref> a@6@11 (Seq_index pw@11@11 i@25@11))) right@8@11)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 13 | !(left@7@11 <= i@25@11 && i@25@11 <= right@8@11)]
(assert (not (and (<= left@7@11 i@25@11) (<= i@25@11 right@8@11))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= left@7@11 i@25@11) (<= i@25@11 right@8@11)))
  (and (<= left@7@11 i@25@11) (<= i@25@11 right@8@11))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@25@11 Int)) (!
  (and
    (or (<= left@7@11 i@25@11) (not (<= left@7@11 i@25@11)))
    (or
      (not (and (<= left@7@11 i@25@11) (<= i@25@11 right@8@11)))
      (and (<= left@7@11 i@25@11) (<= i@25@11 right@8@11))))
  :pattern ((Seq_index pw@11@11 i@25@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@66@11@66@39-aux|)))
(assert (forall ((i@25@11 Int)) (!
  (=>
    (and (<= left@7@11 i@25@11) (<= i@25@11 right@8@11))
    (=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@16@11)))) (loc<Ref> a@6@11 i@25@11))
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) (loc<Ref> a@6@11 (Seq_index
        pw@11@11
        i@25@11)))))
  :pattern ((Seq_index pw@11@11 i@25@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@66@11@66@39|)))
(pop) ; 2
(push) ; 2
; [exec]
; var pivotValue: Int
(declare-const pivotValue@26@11 Int)
; [exec]
; var j: Int
(declare-const j@27@11 Int)
; [exec]
; pivotValue := loc(a, pivotIndex).val
; [eval] loc(a, pivotIndex)
(push) ; 3
(assert (not (and
  (img@15@11 (loc<Ref> a@6@11 pivotIndex@9@11))
  (and
    (<= left@7@11 (inv@14@11 (loc<Ref> a@6@11 pivotIndex@9@11)))
    (<= (inv@14@11 (loc<Ref> a@6@11 pivotIndex@9@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(declare-const pivotValue@28@11 Int)
(assert (=
  pivotValue@28@11
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) (loc<Ref> a@6@11 pivotIndex@9@11))))
; [exec]
; pw := [0..right + 1)
; [eval] [0..right + 1)
; [eval] right + 1
(declare-const pw@29@11 Seq<Int>)
(assert (= pw@29@11 (Seq_range 0 (+ right@8@11 1))))
; [exec]
; swap(a, pivotIndex, right)
; [eval] 0 <= i
(push) ; 3
(assert (not (<= 0 pivotIndex@9@11)))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 pivotIndex@9@11))
; [eval] i < len(a)
; [eval] len(a)
(push) ; 3
(assert (not (< pivotIndex@9@11 (len<Int> a@6@11))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (< pivotIndex@9@11 (len<Int> a@6@11)))
; [eval] 0 <= j
(push) ; 3
(assert (not (<= 0 right@8@11)))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 right@8@11))
; [eval] j < len(a)
; [eval] len(a)
; [eval] loc(a, i)
; Precomputing data for removing quantified permissions
(define-fun pTaken@30@11 ((r $Ref)) $Perm
  (ite
    (= r (loc<Ref> a@6@11 pivotIndex@9@11))
    ($Perm.min
      (ite
        (and
          (img@15@11 r)
          (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
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
(push) ; 3
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@15@11 r)
          (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
        $Perm.Write
        $Perm.No)
      (pTaken@30@11 r))
    $Perm.No)
  
  :qid |quant-u-26|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@30@11 r) $Perm.No)
  
  :qid |quant-u-27|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 pivotIndex@9@11))
    (= (- $Perm.Write (pTaken@30@11 r)) $Perm.No))
  
  :qid |quant-u-28|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@31@11 $FVF<val>)
; Definitional axioms for snapshot map values (instantiated)
(assert (=>
  (and
    (img@15@11 (loc<Ref> a@6@11 pivotIndex@9@11))
    (and
      (<= left@7@11 (inv@14@11 (loc<Ref> a@6@11 pivotIndex@9@11)))
      (<= (inv@14@11 (loc<Ref> a@6@11 pivotIndex@9@11)) right@8@11)))
  (=
    ($FVF.lookup_val (as sm@31@11  $FVF<val>) (loc<Ref> a@6@11 pivotIndex@9@11))
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) (loc<Ref> a@6@11 pivotIndex@9@11)))))
; [eval] i != j
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 10)
(assert (not (= pivotIndex@9@11 right@8@11)))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 10)
(assert (not (not (= pivotIndex@9@11 right@8@11))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; [then-branch: 14 | pivotIndex@9@11 != right@8@11 | live]
; [else-branch: 14 | pivotIndex@9@11 == right@8@11 | live]
(set-option :timeout 0)
(push) ; 3
; [then-branch: 14 | pivotIndex@9@11 != right@8@11]
(assert (not (= pivotIndex@9@11 right@8@11)))
; [eval] loc(a, j)
; Precomputing data for removing quantified permissions
(define-fun pTaken@32@11 ((r $Ref)) $Perm
  (ite
    (= r (loc<Ref> a@6@11 right@8@11))
    ($Perm.min
      (ite
        (and
          (img@15@11 r)
          (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
        (- $Perm.Write (pTaken@30@11 r))
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
          (img@15@11 r)
          (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
        (- $Perm.Write (pTaken@30@11 r))
        $Perm.No)
      (pTaken@32@11 r))
    $Perm.No)
  
  :qid |quant-u-33|))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@32@11 r) $Perm.No)
  
  :qid |quant-u-34|))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 right@8@11))
    (= (- $Perm.Write (pTaken@32@11 r)) $Perm.No))
  
  :qid |quant-u-35|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@33@11 $FVF<val>)
; Definitional axioms for snapshot map values (instantiated)
(assert (=>
  (ite
    (and
      (img@15@11 (loc<Ref> a@6@11 right@8@11))
      (and
        (<= left@7@11 (inv@14@11 (loc<Ref> a@6@11 right@8@11)))
        (<= (inv@14@11 (loc<Ref> a@6@11 right@8@11)) right@8@11)))
    (< $Perm.No (- $Perm.Write (pTaken@30@11 (loc<Ref> a@6@11 right@8@11))))
    false)
  (=
    ($FVF.lookup_val (as sm@33@11  $FVF<val>) (loc<Ref> a@6@11 right@8@11))
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) (loc<Ref> a@6@11 right@8@11)))))
(declare-const $t@34@11 $Snap)
(assert (= $t@34@11 ($Snap.combine ($Snap.first $t@34@11) ($Snap.second $t@34@11))))
; [eval] loc(a, i)
(declare-const sm@35@11 $FVF<val>)
; Definitional axioms for singleton-SM's value
(assert (=
  ($FVF.lookup_val (as sm@35@11  $FVF<val>) (loc<Ref> a@6@11 pivotIndex@9@11))
  ($SortWrappers.$SnapToInt ($Snap.first $t@34@11))))
(assert (<=
  $Perm.No
  (ite
    (= (loc<Ref> a@6@11 pivotIndex@9@11) (loc<Ref> a@6@11 pivotIndex@9@11))
    $Perm.Write
    $Perm.No)))
(assert (<=
  (ite
    (= (loc<Ref> a@6@11 pivotIndex@9@11) (loc<Ref> a@6@11 pivotIndex@9@11))
    $Perm.Write
    $Perm.No)
  $Perm.Write))
(assert (=>
  (= (loc<Ref> a@6@11 pivotIndex@9@11) (loc<Ref> a@6@11 pivotIndex@9@11))
  (not (= (loc<Ref> a@6@11 pivotIndex@9@11) $Ref.null))))
(assert (=
  ($Snap.second $t@34@11)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@34@11))
    ($Snap.second ($Snap.second $t@34@11)))))
; [eval] i != j
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 10)
(assert (not (= pivotIndex@9@11 right@8@11)))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; [then-branch: 15 | pivotIndex@9@11 != right@8@11 | live]
; [else-branch: 15 | pivotIndex@9@11 == right@8@11 | dead]
(set-option :timeout 0)
(push) ; 4
; [then-branch: 15 | pivotIndex@9@11 != right@8@11]
; [eval] loc(a, j)
(declare-const sm@36@11 $FVF<val>)
; Definitional axioms for singleton-SM's value
(assert (=
  ($FVF.lookup_val (as sm@36@11  $FVF<val>) (loc<Ref> a@6@11 right@8@11))
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@34@11)))))
(push) ; 5
(set-option :timeout 10)
(assert (not (= (loc<Ref> a@6@11 right@8@11) (loc<Ref> a@6@11 pivotIndex@9@11))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (<=
  $Perm.No
  (ite
    (= (loc<Ref> a@6@11 right@8@11) (loc<Ref> a@6@11 right@8@11))
    $Perm.Write
    $Perm.No)))
(assert (<=
  (ite
    (= (loc<Ref> a@6@11 right@8@11) (loc<Ref> a@6@11 right@8@11))
    $Perm.Write
    $Perm.No)
  $Perm.Write))
(assert (=>
  (= (loc<Ref> a@6@11 right@8@11) (loc<Ref> a@6@11 right@8@11))
  (not (= (loc<Ref> a@6@11 right@8@11) $Ref.null))))
(assert (=
  ($Snap.second ($Snap.second $t@34@11))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@34@11)))
    ($Snap.second ($Snap.second ($Snap.second $t@34@11))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@34@11))) $Snap.unit))
; [eval] loc(a, i).val == old(loc(a, j).val)
; [eval] loc(a, i)
(declare-const sm@37@11 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@15@11 r)
        (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
      (< $Perm.No (- (- $Perm.Write (pTaken@30@11 r)) (pTaken@32@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r))
  :qid |qp.fvfValDef2|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 pivotIndex@9@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@35@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@35@11  $FVF<val>) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 right@8@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@36@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@36@11  $FVF<val>) r))
  :qid |qp.fvfValDef4|)))
(declare-const pm@38@11 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@38@11  $FPM) r)
    (+
      (+
        (ite
          (and
            (img@15@11 r)
            (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
          (- (- $Perm.Write (pTaken@30@11 r)) (pTaken@32@11 r))
          $Perm.No)
        (ite (= r (loc<Ref> a@6@11 pivotIndex@9@11)) $Perm.Write $Perm.No))
      (ite (= r (loc<Ref> a@6@11 right@8@11)) $Perm.Write $Perm.No)))
  :pattern (($FVF.perm_val (as pm@38@11  $FPM) r))
  :qid |qp.resPrmSumDef5|)))
(set-option :timeout 0)
(push) ; 5
(assert (not (<
  $Perm.No
  ($FVF.perm_val (as pm@38@11  $FPM) (loc<Ref> a@6@11 pivotIndex@9@11)))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, j).val)
; [eval] loc(a, j)
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@15@11 r)
      (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
    (=
      ($FVF.lookup_val (as sm@31@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r)))
  :pattern (($FVF.lookup_val (as sm@31@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r))
  :qid |qp.fvfValDef0|)))
(push) ; 5
(assert (not (and
  (img@15@11 (loc<Ref> a@6@11 right@8@11))
  (and
    (<= left@7@11 (inv@14@11 (loc<Ref> a@6@11 right@8@11)))
    (<= (inv@14@11 (loc<Ref> a@6@11 right@8@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($FVF.lookup_val (as sm@37@11  $FVF<val>) (loc<Ref> a@6@11 pivotIndex@9@11))
  ($FVF.lookup_val (as sm@31@11  $FVF<val>) (loc<Ref> a@6@11 right@8@11))))
(assert (= ($Snap.second ($Snap.second ($Snap.second $t@34@11))) $Snap.unit))
; [eval] loc(a, j).val == old(loc(a, i).val)
; [eval] loc(a, j)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@15@11 r)
          (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
        (< $Perm.No (- (- $Perm.Write (pTaken@30@11 r)) (pTaken@32@11 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r)))
    :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r))
    :qid |qp.fvfValDef2|))
  (forall ((r $Ref)) (!
    (=>
      (= r (loc<Ref> a@6@11 pivotIndex@9@11))
      (=
        ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
        ($FVF.lookup_val (as sm@35@11  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@35@11  $FVF<val>) r))
    :qid |qp.fvfValDef3|))
  (forall ((r $Ref)) (!
    (=>
      (= r (loc<Ref> a@6@11 right@8@11))
      (=
        ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
        ($FVF.lookup_val (as sm@36@11  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@36@11  $FVF<val>) r))
    :qid |qp.fvfValDef4|))))
(push) ; 5
(assert (not (<
  $Perm.No
  (+
    (+
      (ite
        (and
          (img@15@11 (loc<Ref> a@6@11 right@8@11))
          (and
            (<= left@7@11 (inv@14@11 (loc<Ref> a@6@11 right@8@11)))
            (<= (inv@14@11 (loc<Ref> a@6@11 right@8@11)) right@8@11)))
        (-
          (- $Perm.Write (pTaken@30@11 (loc<Ref> a@6@11 right@8@11)))
          (pTaken@32@11 (loc<Ref> a@6@11 right@8@11)))
        $Perm.No)
      (ite
        (= (loc<Ref> a@6@11 right@8@11) (loc<Ref> a@6@11 pivotIndex@9@11))
        $Perm.Write
        $Perm.No))
    (ite
      (= (loc<Ref> a@6@11 right@8@11) (loc<Ref> a@6@11 right@8@11))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, i).val)
; [eval] loc(a, i)
(push) ; 5
(assert (not (and
  (img@15@11 (loc<Ref> a@6@11 pivotIndex@9@11))
  (and
    (<= left@7@11 (inv@14@11 (loc<Ref> a@6@11 pivotIndex@9@11)))
    (<= (inv@14@11 (loc<Ref> a@6@11 pivotIndex@9@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($FVF.lookup_val (as sm@37@11  $FVF<val>) (loc<Ref> a@6@11 right@8@11))
  ($FVF.lookup_val (as sm@31@11  $FVF<val>) (loc<Ref> a@6@11 pivotIndex@9@11))))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
; [exec]
; pw := pw[pivotIndex := pw[right]][right := pw[pivotIndex]]
; [eval] pw[pivotIndex := pw[right]][right := pw[pivotIndex]]
; [eval] pw[pivotIndex := pw[right]]
; [eval] pw[right]
(set-option :timeout 0)
(push) ; 5
(assert (not (>= right@8@11 0)))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(push) ; 5
(assert (not (< right@8@11 (Seq_length pw@29@11))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(push) ; 5
(assert (not (>= pivotIndex@9@11 0)))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(push) ; 5
(assert (not (< pivotIndex@9@11 (Seq_length pw@29@11))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [eval] pw[pivotIndex]
(push) ; 5
(assert (not (>= pivotIndex@9@11 0)))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(push) ; 5
(assert (not (< pivotIndex@9@11 (Seq_length pw@29@11))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(push) ; 5
(assert (not (>= right@8@11 0)))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(push) ; 5
(assert (not (<
  right@8@11
  (Seq_length
    (Seq_append
      (Seq_take pw@29@11 pivotIndex@9@11)
      (Seq_append
        (Seq_singleton (Seq_index pw@29@11 right@8@11))
        (Seq_drop pw@29@11 (+ pivotIndex@9@11 1))))))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(declare-const pw@39@11 Seq<Int>)
(assert (=
  pw@39@11
  (Seq_append
    (Seq_take
      (Seq_append
        (Seq_take pw@29@11 pivotIndex@9@11)
        (Seq_append
          (Seq_singleton (Seq_index pw@29@11 right@8@11))
          (Seq_drop pw@29@11 (+ pivotIndex@9@11 1))))
      right@8@11)
    (Seq_append
      (Seq_singleton (Seq_index pw@29@11 pivotIndex@9@11))
      (Seq_drop
        (Seq_append
          (Seq_take pw@29@11 pivotIndex@9@11)
          (Seq_append
            (Seq_singleton (Seq_index pw@29@11 right@8@11))
            (Seq_drop pw@29@11 (+ pivotIndex@9@11 1))))
        (+ right@8@11 1))))))
; [exec]
; storeIndex := left
; [exec]
; j := left
(declare-const pw@40@11 Seq<Int>)
(declare-const storeIndex@41@11 Int)
(declare-const j@42@11 Int)
(push) ; 5
; Loop head block: Check well-definedness of invariant
(declare-const $t@43@11 $Snap)
(assert (= $t@43@11 ($Snap.combine ($Snap.first $t@43@11) ($Snap.second $t@43@11))))
(assert (= ($Snap.first $t@43@11) $Snap.unit))
; [eval] left <= j
(assert (<= left@7@11 j@42@11))
(assert (=
  ($Snap.second $t@43@11)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@43@11))
    ($Snap.second ($Snap.second $t@43@11)))))
(assert (= ($Snap.first ($Snap.second $t@43@11)) $Snap.unit))
; [eval] j <= right
(assert (<= j@42@11 right@8@11))
(assert (=
  ($Snap.second ($Snap.second $t@43@11))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@43@11)))
    ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@43@11))) $Snap.unit))
; [eval] left <= storeIndex
(assert (<= left@7@11 storeIndex@41@11))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@43@11)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@43@11))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@43@11))))
  $Snap.unit))
; [eval] storeIndex <= j
(assert (<= storeIndex@41@11 j@42@11))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))
(declare-const i@44@11 Int)
(push) ; 6
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 16 | !(left@7@11 <= i@44@11) | live]
; [else-branch: 16 | left@7@11 <= i@44@11 | live]
(push) ; 8
; [then-branch: 16 | !(left@7@11 <= i@44@11)]
(assert (not (<= left@7@11 i@44@11)))
(pop) ; 8
(push) ; 8
; [else-branch: 16 | left@7@11 <= i@44@11]
(assert (<= left@7@11 i@44@11))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@11 i@44@11) (not (<= left@7@11 i@44@11))))
(assert (and (<= left@7@11 i@44@11) (<= i@44@11 right@8@11)))
; [eval] loc(a, i)
(pop) ; 6
(declare-fun inv@45@11 ($Ref) Int)
(declare-fun img@46@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@44@11 Int)) (!
  (=>
    (and (<= left@7@11 i@44@11) (<= i@44@11 right@8@11))
    (or (<= left@7@11 i@44@11) (not (<= left@7@11 i@44@11))))
  :pattern ((loc<Ref> a@6@11 i@44@11))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 6
(assert (not (forall ((i1@44@11 Int) (i2@44@11 Int)) (!
  (=>
    (and
      (and (<= left@7@11 i1@44@11) (<= i1@44@11 right@8@11))
      (and (<= left@7@11 i2@44@11) (<= i2@44@11 right@8@11))
      (= (loc<Ref> a@6@11 i1@44@11) (loc<Ref> a@6@11 i2@44@11)))
    (= i1@44@11 i2@44@11))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@44@11 Int)) (!
  (=>
    (and (<= left@7@11 i@44@11) (<= i@44@11 right@8@11))
    (and
      (= (inv@45@11 (loc<Ref> a@6@11 i@44@11)) i@44@11)
      (img@46@11 (loc<Ref> a@6@11 i@44@11))))
  :pattern ((loc<Ref> a@6@11 i@44@11))
  :qid |quant-u-38|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@46@11 r)
      (and (<= left@7@11 (inv@45@11 r)) (<= (inv@45@11 r) right@8@11)))
    (= (loc<Ref> a@6@11 (inv@45@11 r)) r))
  :pattern ((inv@45@11 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@44@11 Int)) (!
  (=>
    (and (<= left@7@11 i@44@11) (<= i@44@11 right@8@11))
    (not (= (loc<Ref> a@6@11 i@44@11) $Ref.null)))
  :pattern ((loc<Ref> a@6@11 i@44@11))
  :qid |val-permImpliesNonNull|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))
  $Snap.unit))
; [eval] loc(a, right).val == pivotValue
; [eval] loc(a, right)
(push) ; 6
(assert (not (and
  (img@46@11 (loc<Ref> a@6@11 right@8@11))
  (and
    (<= left@7@11 (inv@45@11 (loc<Ref> a@6@11 right@8@11)))
    (<= (inv@45@11 (loc<Ref> a@6@11 right@8@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) (loc<Ref> a@6@11 right@8@11))
  pivotValue@28@11))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } left <= i && i < storeIndex ==> loc(a, i).val < pivotValue)
(declare-const i@47@11 Int)
(push) ; 6
; [eval] left <= i && i < storeIndex ==> loc(a, i).val < pivotValue
; [eval] left <= i && i < storeIndex
; [eval] left <= i
(push) ; 7
; [then-branch: 17 | !(left@7@11 <= i@47@11) | live]
; [else-branch: 17 | left@7@11 <= i@47@11 | live]
(push) ; 8
; [then-branch: 17 | !(left@7@11 <= i@47@11)]
(assert (not (<= left@7@11 i@47@11)))
(pop) ; 8
(push) ; 8
; [else-branch: 17 | left@7@11 <= i@47@11]
(assert (<= left@7@11 i@47@11))
; [eval] i < storeIndex
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@11 i@47@11) (not (<= left@7@11 i@47@11))))
(push) ; 7
; [then-branch: 18 | left@7@11 <= i@47@11 && i@47@11 < storeIndex@41@11 | live]
; [else-branch: 18 | !(left@7@11 <= i@47@11 && i@47@11 < storeIndex@41@11) | live]
(push) ; 8
; [then-branch: 18 | left@7@11 <= i@47@11 && i@47@11 < storeIndex@41@11]
(assert (and (<= left@7@11 i@47@11) (< i@47@11 storeIndex@41@11)))
; [eval] loc(a, i).val < pivotValue
; [eval] loc(a, i)
(push) ; 9
(assert (not (and
  (img@46@11 (loc<Ref> a@6@11 i@47@11))
  (and
    (<= left@7@11 (inv@45@11 (loc<Ref> a@6@11 i@47@11)))
    (<= (inv@45@11 (loc<Ref> a@6@11 i@47@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 18 | !(left@7@11 <= i@47@11 && i@47@11 < storeIndex@41@11)]
(assert (not (and (<= left@7@11 i@47@11) (< i@47@11 storeIndex@41@11))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= left@7@11 i@47@11) (< i@47@11 storeIndex@41@11)))
  (and (<= left@7@11 i@47@11) (< i@47@11 storeIndex@41@11))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@47@11 Int)) (!
  (and
    (or (<= left@7@11 i@47@11) (not (<= left@7@11 i@47@11)))
    (or
      (not (and (<= left@7@11 i@47@11) (< i@47@11 storeIndex@41@11)))
      (and (<= left@7@11 i@47@11) (< i@47@11 storeIndex@41@11))))
  :pattern ((loc<Ref> a@6@11 i@47@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@101@15@101@90-aux|)))
(assert (forall ((i@47@11 Int)) (!
  (=>
    (and (<= left@7@11 i@47@11) (< i@47@11 storeIndex@41@11))
    (<
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) (loc<Ref> a@6@11 i@47@11))
      pivotValue@28@11))
  :pattern ((loc<Ref> a@6@11 i@47@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@101@15@101@90|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } storeIndex <= i && i < j ==> pivotValue <= loc(a, i).val)
(declare-const i@48@11 Int)
(push) ; 6
; [eval] storeIndex <= i && i < j ==> pivotValue <= loc(a, i).val
; [eval] storeIndex <= i && i < j
; [eval] storeIndex <= i
(push) ; 7
; [then-branch: 19 | !(storeIndex@41@11 <= i@48@11) | live]
; [else-branch: 19 | storeIndex@41@11 <= i@48@11 | live]
(push) ; 8
; [then-branch: 19 | !(storeIndex@41@11 <= i@48@11)]
(assert (not (<= storeIndex@41@11 i@48@11)))
(pop) ; 8
(push) ; 8
; [else-branch: 19 | storeIndex@41@11 <= i@48@11]
(assert (<= storeIndex@41@11 i@48@11))
; [eval] i < j
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= storeIndex@41@11 i@48@11) (not (<= storeIndex@41@11 i@48@11))))
(push) ; 7
; [then-branch: 20 | storeIndex@41@11 <= i@48@11 && i@48@11 < j@42@11 | live]
; [else-branch: 20 | !(storeIndex@41@11 <= i@48@11 && i@48@11 < j@42@11) | live]
(push) ; 8
; [then-branch: 20 | storeIndex@41@11 <= i@48@11 && i@48@11 < j@42@11]
(assert (and (<= storeIndex@41@11 i@48@11) (< i@48@11 j@42@11)))
; [eval] pivotValue <= loc(a, i).val
; [eval] loc(a, i)
(push) ; 9
(assert (not (and
  (img@46@11 (loc<Ref> a@6@11 i@48@11))
  (and
    (<= left@7@11 (inv@45@11 (loc<Ref> a@6@11 i@48@11)))
    (<= (inv@45@11 (loc<Ref> a@6@11 i@48@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 20 | !(storeIndex@41@11 <= i@48@11 && i@48@11 < j@42@11)]
(assert (not (and (<= storeIndex@41@11 i@48@11) (< i@48@11 j@42@11))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= storeIndex@41@11 i@48@11) (< i@48@11 j@42@11)))
  (and (<= storeIndex@41@11 i@48@11) (< i@48@11 j@42@11))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@48@11 Int)) (!
  (and
    (or (<= storeIndex@41@11 i@48@11) (not (<= storeIndex@41@11 i@48@11)))
    (or
      (not (and (<= storeIndex@41@11 i@48@11) (< i@48@11 j@42@11)))
      (and (<= storeIndex@41@11 i@48@11) (< i@48@11 j@42@11))))
  :pattern ((loc<Ref> a@6@11 i@48@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@102@15@102@88-aux|)))
(assert (forall ((i@48@11 Int)) (!
  (=>
    (and (<= storeIndex@41@11 i@48@11) (< i@48@11 j@42@11))
    (<=
      pivotValue@28@11
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) (loc<Ref> a@6@11 i@48@11))))
  :pattern ((loc<Ref> a@6@11 i@48@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@102@15@102@88|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))
  $Snap.unit))
; [eval] |pw| == right + 1
; [eval] |pw|
; [eval] right + 1
(assert (= (Seq_length pw@40@11) (+ right@8@11 1)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> left <= pw[i] && pw[i] <= right)
(declare-const i@49@11 Int)
(push) ; 6
; [eval] left <= i && i <= right ==> left <= pw[i] && pw[i] <= right
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 21 | !(left@7@11 <= i@49@11) | live]
; [else-branch: 21 | left@7@11 <= i@49@11 | live]
(push) ; 8
; [then-branch: 21 | !(left@7@11 <= i@49@11)]
(assert (not (<= left@7@11 i@49@11)))
(pop) ; 8
(push) ; 8
; [else-branch: 21 | left@7@11 <= i@49@11]
(assert (<= left@7@11 i@49@11))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@11 i@49@11) (not (<= left@7@11 i@49@11))))
(push) ; 7
; [then-branch: 22 | left@7@11 <= i@49@11 && i@49@11 <= right@8@11 | live]
; [else-branch: 22 | !(left@7@11 <= i@49@11 && i@49@11 <= right@8@11) | live]
(push) ; 8
; [then-branch: 22 | left@7@11 <= i@49@11 && i@49@11 <= right@8@11]
(assert (and (<= left@7@11 i@49@11) (<= i@49@11 right@8@11)))
; [eval] left <= pw[i] && pw[i] <= right
; [eval] left <= pw[i]
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@49@11 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@49@11 (Seq_length pw@40@11))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
; [then-branch: 23 | !(left@7@11 <= pw@40@11[i@49@11]) | live]
; [else-branch: 23 | left@7@11 <= pw@40@11[i@49@11] | live]
(push) ; 10
; [then-branch: 23 | !(left@7@11 <= pw@40@11[i@49@11])]
(assert (not (<= left@7@11 (Seq_index pw@40@11 i@49@11))))
(pop) ; 10
(push) ; 10
; [else-branch: 23 | left@7@11 <= pw@40@11[i@49@11]]
(assert (<= left@7@11 (Seq_index pw@40@11 i@49@11)))
; [eval] pw[i] <= right
; [eval] pw[i]
(push) ; 11
(assert (not (>= i@49@11 0)))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(push) ; 11
(assert (not (< i@49@11 (Seq_length pw@40@11))))
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
  (<= left@7@11 (Seq_index pw@40@11 i@49@11))
  (not (<= left@7@11 (Seq_index pw@40@11 i@49@11)))))
(pop) ; 8
(push) ; 8
; [else-branch: 22 | !(left@7@11 <= i@49@11 && i@49@11 <= right@8@11)]
(assert (not (and (<= left@7@11 i@49@11) (<= i@49@11 right@8@11))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (=>
  (and (<= left@7@11 i@49@11) (<= i@49@11 right@8@11))
  (and
    (<= left@7@11 i@49@11)
    (<= i@49@11 right@8@11)
    (or
      (<= left@7@11 (Seq_index pw@40@11 i@49@11))
      (not (<= left@7@11 (Seq_index pw@40@11 i@49@11)))))))
; Joined path conditions
(assert (or
  (not (and (<= left@7@11 i@49@11) (<= i@49@11 right@8@11)))
  (and (<= left@7@11 i@49@11) (<= i@49@11 right@8@11))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@49@11 Int)) (!
  (and
    (or (<= left@7@11 i@49@11) (not (<= left@7@11 i@49@11)))
    (=>
      (and (<= left@7@11 i@49@11) (<= i@49@11 right@8@11))
      (and
        (<= left@7@11 i@49@11)
        (<= i@49@11 right@8@11)
        (or
          (<= left@7@11 (Seq_index pw@40@11 i@49@11))
          (not (<= left@7@11 (Seq_index pw@40@11 i@49@11))))))
    (or
      (not (and (<= left@7@11 i@49@11) (<= i@49@11 right@8@11)))
      (and (<= left@7@11 i@49@11) (<= i@49@11 right@8@11))))
  :pattern ((Seq_index pw@40@11 i@49@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@105@15@105@91-aux|)))
(assert (forall ((i@49@11 Int)) (!
  (=>
    (and (<= left@7@11 i@49@11) (<= i@49@11 right@8@11))
    (and
      (<= left@7@11 (Seq_index pw@40@11 i@49@11))
      (<= (Seq_index pw@40@11 i@49@11) right@8@11)))
  :pattern ((Seq_index pw@40@11 i@49@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@105@15@105@91|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))))
  $Snap.unit))
; [eval] (forall i: Int, k: Int :: { pw[i], pw[k] } left <= i && (i < k && k <= right) ==> pw[i] != pw[k])
(declare-const i@50@11 Int)
(declare-const k@51@11 Int)
(push) ; 6
; [eval] left <= i && (i < k && k <= right) ==> pw[i] != pw[k]
; [eval] left <= i && (i < k && k <= right)
; [eval] left <= i
(push) ; 7
; [then-branch: 24 | !(left@7@11 <= i@50@11) | live]
; [else-branch: 24 | left@7@11 <= i@50@11 | live]
(push) ; 8
; [then-branch: 24 | !(left@7@11 <= i@50@11)]
(assert (not (<= left@7@11 i@50@11)))
(pop) ; 8
(push) ; 8
; [else-branch: 24 | left@7@11 <= i@50@11]
(assert (<= left@7@11 i@50@11))
; [eval] i < k
(push) ; 9
; [then-branch: 25 | !(i@50@11 < k@51@11) | live]
; [else-branch: 25 | i@50@11 < k@51@11 | live]
(push) ; 10
; [then-branch: 25 | !(i@50@11 < k@51@11)]
(assert (not (< i@50@11 k@51@11)))
(pop) ; 10
(push) ; 10
; [else-branch: 25 | i@50@11 < k@51@11]
(assert (< i@50@11 k@51@11))
; [eval] k <= right
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (< i@50@11 k@51@11) (not (< i@50@11 k@51@11))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= left@7@11 i@50@11)
  (and (<= left@7@11 i@50@11) (or (< i@50@11 k@51@11) (not (< i@50@11 k@51@11))))))
(assert (or (<= left@7@11 i@50@11) (not (<= left@7@11 i@50@11))))
(push) ; 7
; [then-branch: 26 | left@7@11 <= i@50@11 && i@50@11 < k@51@11 && k@51@11 <= right@8@11 | live]
; [else-branch: 26 | !(left@7@11 <= i@50@11 && i@50@11 < k@51@11 && k@51@11 <= right@8@11) | live]
(push) ; 8
; [then-branch: 26 | left@7@11 <= i@50@11 && i@50@11 < k@51@11 && k@51@11 <= right@8@11]
(assert (and (<= left@7@11 i@50@11) (and (< i@50@11 k@51@11) (<= k@51@11 right@8@11))))
; [eval] pw[i] != pw[k]
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@50@11 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@50@11 (Seq_length pw@40@11))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] pw[k]
(push) ; 9
(assert (not (>= k@51@11 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< k@51@11 (Seq_length pw@40@11))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 26 | !(left@7@11 <= i@50@11 && i@50@11 < k@51@11 && k@51@11 <= right@8@11)]
(assert (not
  (and (<= left@7@11 i@50@11) (and (< i@50@11 k@51@11) (<= k@51@11 right@8@11)))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (=>
  (and (<= left@7@11 i@50@11) (and (< i@50@11 k@51@11) (<= k@51@11 right@8@11)))
  (and (<= left@7@11 i@50@11) (< i@50@11 k@51@11) (<= k@51@11 right@8@11))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= left@7@11 i@50@11)
      (and (< i@50@11 k@51@11) (<= k@51@11 right@8@11))))
  (and (<= left@7@11 i@50@11) (and (< i@50@11 k@51@11) (<= k@51@11 right@8@11)))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@50@11 Int) (k@51@11 Int)) (!
  (and
    (=>
      (<= left@7@11 i@50@11)
      (and
        (<= left@7@11 i@50@11)
        (or (< i@50@11 k@51@11) (not (< i@50@11 k@51@11)))))
    (or (<= left@7@11 i@50@11) (not (<= left@7@11 i@50@11)))
    (=>
      (and
        (<= left@7@11 i@50@11)
        (and (< i@50@11 k@51@11) (<= k@51@11 right@8@11)))
      (and (<= left@7@11 i@50@11) (< i@50@11 k@51@11) (<= k@51@11 right@8@11)))
    (or
      (not
        (and
          (<= left@7@11 i@50@11)
          (and (< i@50@11 k@51@11) (<= k@51@11 right@8@11))))
      (and
        (<= left@7@11 i@50@11)
        (and (< i@50@11 k@51@11) (<= k@51@11 right@8@11)))))
  :pattern ((Seq_index pw@40@11 i@50@11) (Seq_index pw@40@11 k@51@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@106@15@106@91-aux|)))
(assert (forall ((i@50@11 Int) (k@51@11 Int)) (!
  (=>
    (and
      (<= left@7@11 i@50@11)
      (and (< i@50@11 k@51@11) (<= k@51@11 right@8@11)))
    (not (= (Seq_index pw@40@11 i@50@11) (Seq_index pw@40@11 k@51@11))))
  :pattern ((Seq_index pw@40@11 i@50@11) (Seq_index pw@40@11 k@51@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@106@15@106@91|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))))
  $Snap.unit))
; [eval] (forall i$0: Int :: { pw[i$0] } left <= i$0 && i$0 <= right ==> loc(a, i$0).val == old(loc(a, pw[i$0]).val))
(declare-const i$0@52@11 Int)
(push) ; 6
; [eval] left <= i$0 && i$0 <= right ==> loc(a, i$0).val == old(loc(a, pw[i$0]).val)
; [eval] left <= i$0 && i$0 <= right
; [eval] left <= i$0
(push) ; 7
; [then-branch: 27 | !(left@7@11 <= i$0@52@11) | live]
; [else-branch: 27 | left@7@11 <= i$0@52@11 | live]
(push) ; 8
; [then-branch: 27 | !(left@7@11 <= i$0@52@11)]
(assert (not (<= left@7@11 i$0@52@11)))
(pop) ; 8
(push) ; 8
; [else-branch: 27 | left@7@11 <= i$0@52@11]
(assert (<= left@7@11 i$0@52@11))
; [eval] i$0 <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@11 i$0@52@11) (not (<= left@7@11 i$0@52@11))))
(push) ; 7
; [then-branch: 28 | left@7@11 <= i$0@52@11 && i$0@52@11 <= right@8@11 | live]
; [else-branch: 28 | !(left@7@11 <= i$0@52@11 && i$0@52@11 <= right@8@11) | live]
(push) ; 8
; [then-branch: 28 | left@7@11 <= i$0@52@11 && i$0@52@11 <= right@8@11]
(assert (and (<= left@7@11 i$0@52@11) (<= i$0@52@11 right@8@11)))
; [eval] loc(a, i$0).val == old(loc(a, pw[i$0]).val)
; [eval] loc(a, i$0)
(push) ; 9
(assert (not (and
  (img@46@11 (loc<Ref> a@6@11 i$0@52@11))
  (and
    (<= left@7@11 (inv@45@11 (loc<Ref> a@6@11 i$0@52@11)))
    (<= (inv@45@11 (loc<Ref> a@6@11 i$0@52@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, pw[i$0]).val)
; [eval] loc(a, pw[i$0])
; [eval] pw[i$0]
(push) ; 9
(assert (not (>= i$0@52@11 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i$0@52@11 (Seq_length pw@40@11))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (and
  (img@15@11 (loc<Ref> a@6@11 (Seq_index pw@40@11 i$0@52@11)))
  (and
    (<= left@7@11 (inv@14@11 (loc<Ref> a@6@11 (Seq_index pw@40@11 i$0@52@11))))
    (<= (inv@14@11 (loc<Ref> a@6@11 (Seq_index pw@40@11 i$0@52@11))) right@8@11)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 28 | !(left@7@11 <= i$0@52@11 && i$0@52@11 <= right@8@11)]
(assert (not (and (<= left@7@11 i$0@52@11) (<= i$0@52@11 right@8@11))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= left@7@11 i$0@52@11) (<= i$0@52@11 right@8@11)))
  (and (<= left@7@11 i$0@52@11) (<= i$0@52@11 right@8@11))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i$0@52@11 Int)) (!
  (and
    (or (<= left@7@11 i$0@52@11) (not (<= left@7@11 i$0@52@11)))
    (or
      (not (and (<= left@7@11 i$0@52@11) (<= i$0@52@11 right@8@11)))
      (and (<= left@7@11 i$0@52@11) (<= i$0@52@11 right@8@11))))
  :pattern ((Seq_index pw@40@11 i$0@52@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@108@15@108@43-aux|)))
(assert (forall ((i$0@52@11 Int)) (!
  (=>
    (and (<= left@7@11 i$0@52@11) (<= i$0@52@11 right@8@11))
    (=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) (loc<Ref> a@6@11 i$0@52@11))
      ($FVF.lookup_val (as sm@31@11  $FVF<val>) (loc<Ref> a@6@11 (Seq_index
        pw@40@11
        i$0@52@11)))))
  :pattern ((Seq_index pw@40@11 i$0@52@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@108@15@108@43|)))
(pop) ; 5
(push) ; 5
; Loop head block: Establish invariant
; [eval] left <= j
; [eval] j <= right
(push) ; 6
(assert (not (<= left@7@11 right@8@11)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (<= left@7@11 right@8@11))
; [eval] left <= storeIndex
; [eval] storeIndex <= j
(declare-const i@53@11 Int)
(push) ; 6
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 29 | !(left@7@11 <= i@53@11) | live]
; [else-branch: 29 | left@7@11 <= i@53@11 | live]
(push) ; 8
; [then-branch: 29 | !(left@7@11 <= i@53@11)]
(assert (not (<= left@7@11 i@53@11)))
(pop) ; 8
(push) ; 8
; [else-branch: 29 | left@7@11 <= i@53@11]
(assert (<= left@7@11 i@53@11))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@11 i@53@11) (not (<= left@7@11 i@53@11))))
(assert (and (<= left@7@11 i@53@11) (<= i@53@11 right@8@11)))
; [eval] loc(a, i)
(pop) ; 6
(declare-fun inv@54@11 ($Ref) Int)
(declare-fun img@55@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@53@11 Int)) (!
  (=>
    (and (<= left@7@11 i@53@11) (<= i@53@11 right@8@11))
    (or (<= left@7@11 i@53@11) (not (<= left@7@11 i@53@11))))
  :pattern ((loc<Ref> a@6@11 i@53@11))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 6
(assert (not (forall ((i1@53@11 Int) (i2@53@11 Int)) (!
  (=>
    (and
      (and (<= left@7@11 i1@53@11) (<= i1@53@11 right@8@11))
      (and (<= left@7@11 i2@53@11) (<= i2@53@11 right@8@11))
      (= (loc<Ref> a@6@11 i1@53@11) (loc<Ref> a@6@11 i2@53@11)))
    (= i1@53@11 i2@53@11))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@53@11 Int)) (!
  (=>
    (and (<= left@7@11 i@53@11) (<= i@53@11 right@8@11))
    (and
      (= (inv@54@11 (loc<Ref> a@6@11 i@53@11)) i@53@11)
      (img@55@11 (loc<Ref> a@6@11 i@53@11))))
  :pattern ((loc<Ref> a@6@11 i@53@11))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@55@11 r)
      (and (<= left@7@11 (inv@54@11 r)) (<= (inv@54@11 r) right@8@11)))
    (= (loc<Ref> a@6@11 (inv@54@11 r)) r))
  :pattern ((inv@54@11 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@56@11 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= left@7@11 (inv@54@11 r)) (<= (inv@54@11 r) right@8@11))
      (img@55@11 r)
      (= r (loc<Ref> a@6@11 (inv@54@11 r))))
    ($Perm.min
      (ite
        (and
          (img@15@11 r)
          (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
        (- (- $Perm.Write (pTaken@30@11 r)) (pTaken@32@11 r))
        $Perm.No)
      $Perm.Write)
    $Perm.No))
(define-fun pTaken@57@11 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= left@7@11 (inv@54@11 r)) (<= (inv@54@11 r) right@8@11))
      (img@55@11 r)
      (= r (loc<Ref> a@6@11 (inv@54@11 r))))
    ($Perm.min
      (ite (= r (loc<Ref> a@6@11 pivotIndex@9@11)) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@56@11 r)))
    $Perm.No))
(define-fun pTaken@58@11 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= left@7@11 (inv@54@11 r)) (<= (inv@54@11 r) right@8@11))
      (img@55@11 r)
      (= r (loc<Ref> a@6@11 (inv@54@11 r))))
    ($Perm.min
      (ite (= r (loc<Ref> a@6@11 right@8@11)) $Perm.Write $Perm.No)
      (- (- $Perm.Write (pTaken@56@11 r)) (pTaken@57@11 r)))
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
          (img@15@11 r)
          (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
        (- (- $Perm.Write (pTaken@30@11 r)) (pTaken@32@11 r))
        $Perm.No)
      (pTaken@56@11 r))
    $Perm.No)
  
  :qid |quant-u-56|))))
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
      (and (<= left@7@11 (inv@54@11 r)) (<= (inv@54@11 r) right@8@11))
      (img@55@11 r)
      (= r (loc<Ref> a@6@11 (inv@54@11 r))))
    (= (- $Perm.Write (pTaken@56@11 r)) $Perm.No))
  
  :qid |quant-u-57|))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 500)
(assert (not (=
  (-
    (ite
      (= (loc<Ref> a@6@11 pivotIndex@9@11) (loc<Ref> a@6@11 pivotIndex@9@11))
      $Perm.Write
      $Perm.No)
    (pTaken@57@11 (loc<Ref> a@6@11 pivotIndex@9@11)))
  $Perm.No)))
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
      (and (<= left@7@11 (inv@54@11 r)) (<= (inv@54@11 r) right@8@11))
      (img@55@11 r)
      (= r (loc<Ref> a@6@11 (inv@54@11 r))))
    (= (- (- $Perm.Write (pTaken@56@11 r)) (pTaken@57@11 r)) $Perm.No))
  
  :qid |quant-u-59|))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 500)
(assert (not (=
  (-
    (ite
      (= (loc<Ref> a@6@11 right@8@11) (loc<Ref> a@6@11 right@8@11))
      $Perm.Write
      $Perm.No)
    (pTaken@58@11 (loc<Ref> a@6@11 right@8@11)))
  $Perm.No)))
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
      (and (<= left@7@11 (inv@54@11 r)) (<= (inv@54@11 r) right@8@11))
      (img@55@11 r)
      (= r (loc<Ref> a@6@11 (inv@54@11 r))))
    (=
      (- (- (- $Perm.Write (pTaken@56@11 r)) (pTaken@57@11 r)) (pTaken@58@11 r))
      $Perm.No))
  
  :qid |quant-u-61|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
; Definitional axioms for snapshot map values
; [eval] loc(a, right).val == pivotValue
; [eval] loc(a, right)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@15@11 r)
          (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
        (< $Perm.No (- (- $Perm.Write (pTaken@30@11 r)) (pTaken@32@11 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r)))
    :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r))
    :qid |qp.fvfValDef2|))
  (forall ((r $Ref)) (!
    (=>
      (= r (loc<Ref> a@6@11 pivotIndex@9@11))
      (=
        ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
        ($FVF.lookup_val (as sm@35@11  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@35@11  $FVF<val>) r))
    :qid |qp.fvfValDef3|))
  (forall ((r $Ref)) (!
    (=>
      (= r (loc<Ref> a@6@11 right@8@11))
      (=
        ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
        ($FVF.lookup_val (as sm@36@11  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@36@11  $FVF<val>) r))
    :qid |qp.fvfValDef4|))))
(set-option :timeout 0)
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (+
      (ite
        (and
          (img@15@11 (loc<Ref> a@6@11 right@8@11))
          (and
            (<= left@7@11 (inv@14@11 (loc<Ref> a@6@11 right@8@11)))
            (<= (inv@14@11 (loc<Ref> a@6@11 right@8@11)) right@8@11)))
        (-
          (- $Perm.Write (pTaken@30@11 (loc<Ref> a@6@11 right@8@11)))
          (pTaken@32@11 (loc<Ref> a@6@11 right@8@11)))
        $Perm.No)
      (ite
        (= (loc<Ref> a@6@11 right@8@11) (loc<Ref> a@6@11 pivotIndex@9@11))
        $Perm.Write
        $Perm.No))
    (ite
      (= (loc<Ref> a@6@11 right@8@11) (loc<Ref> a@6@11 right@8@11))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (=
  ($FVF.lookup_val (as sm@37@11  $FVF<val>) (loc<Ref> a@6@11 right@8@11))
  pivotValue@28@11)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($FVF.lookup_val (as sm@37@11  $FVF<val>) (loc<Ref> a@6@11 right@8@11))
  pivotValue@28@11))
; [eval] (forall i: Int :: { loc(a, i) } left <= i && i < storeIndex ==> loc(a, i).val < pivotValue)
(declare-const i@59@11 Int)
(push) ; 6
; [eval] left <= i && i < storeIndex ==> loc(a, i).val < pivotValue
; [eval] left <= i && i < storeIndex
; [eval] left <= i
(push) ; 7
; [then-branch: 30 | !(left@7@11 <= i@59@11) | live]
; [else-branch: 30 | left@7@11 <= i@59@11 | live]
(push) ; 8
; [then-branch: 30 | !(left@7@11 <= i@59@11)]
(assert (not (<= left@7@11 i@59@11)))
(pop) ; 8
(push) ; 8
; [else-branch: 30 | left@7@11 <= i@59@11]
(assert (<= left@7@11 i@59@11))
; [eval] i < storeIndex
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@11 i@59@11) (not (<= left@7@11 i@59@11))))
(push) ; 7
; [then-branch: 31 | left@7@11 <= i@59@11 && i@59@11 < left@7@11 | live]
; [else-branch: 31 | !(left@7@11 <= i@59@11 && i@59@11 < left@7@11) | live]
(push) ; 8
; [then-branch: 31 | left@7@11 <= i@59@11 && i@59@11 < left@7@11]
(assert (and (<= left@7@11 i@59@11) (< i@59@11 left@7@11)))
; [eval] loc(a, i).val < pivotValue
; [eval] loc(a, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@15@11 r)
          (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
        (< $Perm.No (- (- $Perm.Write (pTaken@30@11 r)) (pTaken@32@11 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r)))
    :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r))
    :qid |qp.fvfValDef2|))
  (forall ((r $Ref)) (!
    (=>
      (= r (loc<Ref> a@6@11 pivotIndex@9@11))
      (=
        ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
        ($FVF.lookup_val (as sm@35@11  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@35@11  $FVF<val>) r))
    :qid |qp.fvfValDef3|))
  (forall ((r $Ref)) (!
    (=>
      (= r (loc<Ref> a@6@11 right@8@11))
      (=
        ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
        ($FVF.lookup_val (as sm@36@11  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@36@11  $FVF<val>) r))
    :qid |qp.fvfValDef4|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (+
      (ite
        (and
          (img@15@11 (loc<Ref> a@6@11 i@59@11))
          (and
            (<= left@7@11 (inv@14@11 (loc<Ref> a@6@11 i@59@11)))
            (<= (inv@14@11 (loc<Ref> a@6@11 i@59@11)) right@8@11)))
        (-
          (- $Perm.Write (pTaken@30@11 (loc<Ref> a@6@11 i@59@11)))
          (pTaken@32@11 (loc<Ref> a@6@11 i@59@11)))
        $Perm.No)
      (ite
        (= (loc<Ref> a@6@11 i@59@11) (loc<Ref> a@6@11 pivotIndex@9@11))
        $Perm.Write
        $Perm.No))
    (ite
      (= (loc<Ref> a@6@11 i@59@11) (loc<Ref> a@6@11 right@8@11))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 31 | !(left@7@11 <= i@59@11 && i@59@11 < left@7@11)]
(assert (not (and (<= left@7@11 i@59@11) (< i@59@11 left@7@11))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@15@11 r)
        (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
      (< $Perm.No (- (- $Perm.Write (pTaken@30@11 r)) (pTaken@32@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r))
  :qid |qp.fvfValDef2|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 pivotIndex@9@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@35@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@35@11  $FVF<val>) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 right@8@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@36@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@36@11  $FVF<val>) r))
  :qid |qp.fvfValDef4|)))
; Joined path conditions
(assert (or
  (not (and (<= left@7@11 i@59@11) (< i@59@11 left@7@11)))
  (and (<= left@7@11 i@59@11) (< i@59@11 left@7@11))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@15@11 r)
        (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
      (< $Perm.No (- (- $Perm.Write (pTaken@30@11 r)) (pTaken@32@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r))
  :qid |qp.fvfValDef2|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 pivotIndex@9@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@35@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@35@11  $FVF<val>) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 right@8@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@36@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@36@11  $FVF<val>) r))
  :qid |qp.fvfValDef4|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@59@11 Int)) (!
  (and
    (or (<= left@7@11 i@59@11) (not (<= left@7@11 i@59@11)))
    (or
      (not (and (<= left@7@11 i@59@11) (< i@59@11 left@7@11)))
      (and (<= left@7@11 i@59@11) (< i@59@11 left@7@11))))
  :pattern ((loc<Ref> a@6@11 i@59@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@101@15@101@90-aux|)))
(push) ; 6
(assert (not (forall ((i@59@11 Int)) (!
  (=>
    (and (<= left@7@11 i@59@11) (< i@59@11 left@7@11))
    (<
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) (loc<Ref> a@6@11 i@59@11))
      pivotValue@28@11))
  :pattern ((loc<Ref> a@6@11 i@59@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@101@15@101@90|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@59@11 Int)) (!
  (=>
    (and (<= left@7@11 i@59@11) (< i@59@11 left@7@11))
    (<
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) (loc<Ref> a@6@11 i@59@11))
      pivotValue@28@11))
  :pattern ((loc<Ref> a@6@11 i@59@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@101@15@101@90|)))
; [eval] (forall i: Int :: { loc(a, i) } storeIndex <= i && i < j ==> pivotValue <= loc(a, i).val)
(declare-const i@60@11 Int)
(push) ; 6
; [eval] storeIndex <= i && i < j ==> pivotValue <= loc(a, i).val
; [eval] storeIndex <= i && i < j
; [eval] storeIndex <= i
(push) ; 7
; [then-branch: 32 | !(left@7@11 <= i@60@11) | live]
; [else-branch: 32 | left@7@11 <= i@60@11 | live]
(push) ; 8
; [then-branch: 32 | !(left@7@11 <= i@60@11)]
(assert (not (<= left@7@11 i@60@11)))
(pop) ; 8
(push) ; 8
; [else-branch: 32 | left@7@11 <= i@60@11]
(assert (<= left@7@11 i@60@11))
; [eval] i < j
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@11 i@60@11) (not (<= left@7@11 i@60@11))))
(push) ; 7
; [then-branch: 33 | left@7@11 <= i@60@11 && i@60@11 < left@7@11 | live]
; [else-branch: 33 | !(left@7@11 <= i@60@11 && i@60@11 < left@7@11) | live]
(push) ; 8
; [then-branch: 33 | left@7@11 <= i@60@11 && i@60@11 < left@7@11]
(assert (and (<= left@7@11 i@60@11) (< i@60@11 left@7@11)))
; [eval] pivotValue <= loc(a, i).val
; [eval] loc(a, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@15@11 r)
          (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
        (< $Perm.No (- (- $Perm.Write (pTaken@30@11 r)) (pTaken@32@11 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r)))
    :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r))
    :qid |qp.fvfValDef2|))
  (forall ((r $Ref)) (!
    (=>
      (= r (loc<Ref> a@6@11 pivotIndex@9@11))
      (=
        ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
        ($FVF.lookup_val (as sm@35@11  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@35@11  $FVF<val>) r))
    :qid |qp.fvfValDef3|))
  (forall ((r $Ref)) (!
    (=>
      (= r (loc<Ref> a@6@11 right@8@11))
      (=
        ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
        ($FVF.lookup_val (as sm@36@11  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@36@11  $FVF<val>) r))
    :qid |qp.fvfValDef4|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (+
      (ite
        (and
          (img@15@11 (loc<Ref> a@6@11 i@60@11))
          (and
            (<= left@7@11 (inv@14@11 (loc<Ref> a@6@11 i@60@11)))
            (<= (inv@14@11 (loc<Ref> a@6@11 i@60@11)) right@8@11)))
        (-
          (- $Perm.Write (pTaken@30@11 (loc<Ref> a@6@11 i@60@11)))
          (pTaken@32@11 (loc<Ref> a@6@11 i@60@11)))
        $Perm.No)
      (ite
        (= (loc<Ref> a@6@11 i@60@11) (loc<Ref> a@6@11 pivotIndex@9@11))
        $Perm.Write
        $Perm.No))
    (ite
      (= (loc<Ref> a@6@11 i@60@11) (loc<Ref> a@6@11 right@8@11))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 33 | !(left@7@11 <= i@60@11 && i@60@11 < left@7@11)]
(assert (not (and (<= left@7@11 i@60@11) (< i@60@11 left@7@11))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@15@11 r)
        (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
      (< $Perm.No (- (- $Perm.Write (pTaken@30@11 r)) (pTaken@32@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r))
  :qid |qp.fvfValDef2|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 pivotIndex@9@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@35@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@35@11  $FVF<val>) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 right@8@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@36@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@36@11  $FVF<val>) r))
  :qid |qp.fvfValDef4|)))
; Joined path conditions
(assert (or
  (not (and (<= left@7@11 i@60@11) (< i@60@11 left@7@11)))
  (and (<= left@7@11 i@60@11) (< i@60@11 left@7@11))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@15@11 r)
        (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
      (< $Perm.No (- (- $Perm.Write (pTaken@30@11 r)) (pTaken@32@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r))
  :qid |qp.fvfValDef2|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 pivotIndex@9@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@35@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@35@11  $FVF<val>) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 right@8@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@36@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@36@11  $FVF<val>) r))
  :qid |qp.fvfValDef4|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@60@11 Int)) (!
  (and
    (or (<= left@7@11 i@60@11) (not (<= left@7@11 i@60@11)))
    (or
      (not (and (<= left@7@11 i@60@11) (< i@60@11 left@7@11)))
      (and (<= left@7@11 i@60@11) (< i@60@11 left@7@11))))
  :pattern ((loc<Ref> a@6@11 i@60@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@102@15@102@88-aux|)))
(push) ; 6
(assert (not (forall ((i@60@11 Int)) (!
  (=>
    (and (<= left@7@11 i@60@11) (< i@60@11 left@7@11))
    (<=
      pivotValue@28@11
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) (loc<Ref> a@6@11 i@60@11))))
  :pattern ((loc<Ref> a@6@11 i@60@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@102@15@102@88|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@60@11 Int)) (!
  (=>
    (and (<= left@7@11 i@60@11) (< i@60@11 left@7@11))
    (<=
      pivotValue@28@11
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) (loc<Ref> a@6@11 i@60@11))))
  :pattern ((loc<Ref> a@6@11 i@60@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@102@15@102@88|)))
; [eval] |pw| == right + 1
; [eval] |pw|
; [eval] right + 1
(push) ; 6
(assert (not (= (Seq_length pw@39@11) (+ right@8@11 1))))
(check-sat)
; unsat
(pop) ; 6
; 0.02s
; (get-info :all-statistics)
(assert (= (Seq_length pw@39@11) (+ right@8@11 1)))
; [eval] (forall i: Int :: { pw[i] } left <= i && i <= right ==> left <= pw[i] && pw[i] <= right)
(declare-const i@61@11 Int)
(push) ; 6
; [eval] left <= i && i <= right ==> left <= pw[i] && pw[i] <= right
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 7
; [then-branch: 34 | !(left@7@11 <= i@61@11) | live]
; [else-branch: 34 | left@7@11 <= i@61@11 | live]
(push) ; 8
; [then-branch: 34 | !(left@7@11 <= i@61@11)]
(assert (not (<= left@7@11 i@61@11)))
(pop) ; 8
(push) ; 8
; [else-branch: 34 | left@7@11 <= i@61@11]
(assert (<= left@7@11 i@61@11))
; [eval] i <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@11 i@61@11) (not (<= left@7@11 i@61@11))))
(push) ; 7
; [then-branch: 35 | left@7@11 <= i@61@11 && i@61@11 <= right@8@11 | live]
; [else-branch: 35 | !(left@7@11 <= i@61@11 && i@61@11 <= right@8@11) | live]
(push) ; 8
; [then-branch: 35 | left@7@11 <= i@61@11 && i@61@11 <= right@8@11]
(assert (and (<= left@7@11 i@61@11) (<= i@61@11 right@8@11)))
; [eval] left <= pw[i] && pw[i] <= right
; [eval] left <= pw[i]
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@61@11 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@61@11 (Seq_length pw@39@11))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
; [then-branch: 36 | !(left@7@11 <= pw@39@11[i@61@11]) | live]
; [else-branch: 36 | left@7@11 <= pw@39@11[i@61@11] | live]
(push) ; 10
; [then-branch: 36 | !(left@7@11 <= pw@39@11[i@61@11])]
(assert (not (<= left@7@11 (Seq_index pw@39@11 i@61@11))))
(pop) ; 10
(push) ; 10
; [else-branch: 36 | left@7@11 <= pw@39@11[i@61@11]]
(assert (<= left@7@11 (Seq_index pw@39@11 i@61@11)))
; [eval] pw[i] <= right
; [eval] pw[i]
(push) ; 11
(assert (not (>= i@61@11 0)))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(push) ; 11
(assert (not (< i@61@11 (Seq_length pw@39@11))))
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
  (<= left@7@11 (Seq_index pw@39@11 i@61@11))
  (not (<= left@7@11 (Seq_index pw@39@11 i@61@11)))))
(pop) ; 8
(push) ; 8
; [else-branch: 35 | !(left@7@11 <= i@61@11 && i@61@11 <= right@8@11)]
(assert (not (and (<= left@7@11 i@61@11) (<= i@61@11 right@8@11))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (=>
  (and (<= left@7@11 i@61@11) (<= i@61@11 right@8@11))
  (and
    (<= left@7@11 i@61@11)
    (<= i@61@11 right@8@11)
    (or
      (<= left@7@11 (Seq_index pw@39@11 i@61@11))
      (not (<= left@7@11 (Seq_index pw@39@11 i@61@11)))))))
; Joined path conditions
(assert (or
  (not (and (<= left@7@11 i@61@11) (<= i@61@11 right@8@11)))
  (and (<= left@7@11 i@61@11) (<= i@61@11 right@8@11))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@61@11 Int)) (!
  (and
    (or (<= left@7@11 i@61@11) (not (<= left@7@11 i@61@11)))
    (=>
      (and (<= left@7@11 i@61@11) (<= i@61@11 right@8@11))
      (and
        (<= left@7@11 i@61@11)
        (<= i@61@11 right@8@11)
        (or
          (<= left@7@11 (Seq_index pw@39@11 i@61@11))
          (not (<= left@7@11 (Seq_index pw@39@11 i@61@11))))))
    (or
      (not (and (<= left@7@11 i@61@11) (<= i@61@11 right@8@11)))
      (and (<= left@7@11 i@61@11) (<= i@61@11 right@8@11))))
  :pattern ((Seq_index pw@39@11 i@61@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@105@15@105@91-aux|)))
(push) ; 6
(assert (not (forall ((i@61@11 Int)) (!
  (=>
    (and (<= left@7@11 i@61@11) (<= i@61@11 right@8@11))
    (and
      (<= left@7@11 (Seq_index pw@39@11 i@61@11))
      (<= (Seq_index pw@39@11 i@61@11) right@8@11)))
  :pattern ((Seq_index pw@39@11 i@61@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@105@15@105@91|))))
(check-sat)
; unsat
(pop) ; 6
; 0.03s
; (get-info :all-statistics)
(assert (forall ((i@61@11 Int)) (!
  (=>
    (and (<= left@7@11 i@61@11) (<= i@61@11 right@8@11))
    (and
      (<= left@7@11 (Seq_index pw@39@11 i@61@11))
      (<= (Seq_index pw@39@11 i@61@11) right@8@11)))
  :pattern ((Seq_index pw@39@11 i@61@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@105@15@105@91|)))
; [eval] (forall i: Int, k: Int :: { pw[i], pw[k] } left <= i && (i < k && k <= right) ==> pw[i] != pw[k])
(declare-const i@62@11 Int)
(declare-const k@63@11 Int)
(push) ; 6
; [eval] left <= i && (i < k && k <= right) ==> pw[i] != pw[k]
; [eval] left <= i && (i < k && k <= right)
; [eval] left <= i
(push) ; 7
; [then-branch: 37 | !(left@7@11 <= i@62@11) | live]
; [else-branch: 37 | left@7@11 <= i@62@11 | live]
(push) ; 8
; [then-branch: 37 | !(left@7@11 <= i@62@11)]
(assert (not (<= left@7@11 i@62@11)))
(pop) ; 8
(push) ; 8
; [else-branch: 37 | left@7@11 <= i@62@11]
(assert (<= left@7@11 i@62@11))
; [eval] i < k
(push) ; 9
; [then-branch: 38 | !(i@62@11 < k@63@11) | live]
; [else-branch: 38 | i@62@11 < k@63@11 | live]
(push) ; 10
; [then-branch: 38 | !(i@62@11 < k@63@11)]
(assert (not (< i@62@11 k@63@11)))
(pop) ; 10
(push) ; 10
; [else-branch: 38 | i@62@11 < k@63@11]
(assert (< i@62@11 k@63@11))
; [eval] k <= right
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (< i@62@11 k@63@11) (not (< i@62@11 k@63@11))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= left@7@11 i@62@11)
  (and (<= left@7@11 i@62@11) (or (< i@62@11 k@63@11) (not (< i@62@11 k@63@11))))))
(assert (or (<= left@7@11 i@62@11) (not (<= left@7@11 i@62@11))))
(push) ; 7
; [then-branch: 39 | left@7@11 <= i@62@11 && i@62@11 < k@63@11 && k@63@11 <= right@8@11 | live]
; [else-branch: 39 | !(left@7@11 <= i@62@11 && i@62@11 < k@63@11 && k@63@11 <= right@8@11) | live]
(push) ; 8
; [then-branch: 39 | left@7@11 <= i@62@11 && i@62@11 < k@63@11 && k@63@11 <= right@8@11]
(assert (and (<= left@7@11 i@62@11) (and (< i@62@11 k@63@11) (<= k@63@11 right@8@11))))
; [eval] pw[i] != pw[k]
; [eval] pw[i]
(push) ; 9
(assert (not (>= i@62@11 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i@62@11 (Seq_length pw@39@11))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] pw[k]
(push) ; 9
(assert (not (>= k@63@11 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< k@63@11 (Seq_length pw@39@11))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 39 | !(left@7@11 <= i@62@11 && i@62@11 < k@63@11 && k@63@11 <= right@8@11)]
(assert (not
  (and (<= left@7@11 i@62@11) (and (< i@62@11 k@63@11) (<= k@63@11 right@8@11)))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (=>
  (and (<= left@7@11 i@62@11) (and (< i@62@11 k@63@11) (<= k@63@11 right@8@11)))
  (and (<= left@7@11 i@62@11) (< i@62@11 k@63@11) (<= k@63@11 right@8@11))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= left@7@11 i@62@11)
      (and (< i@62@11 k@63@11) (<= k@63@11 right@8@11))))
  (and (<= left@7@11 i@62@11) (and (< i@62@11 k@63@11) (<= k@63@11 right@8@11)))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@62@11 Int) (k@63@11 Int)) (!
  (and
    (=>
      (<= left@7@11 i@62@11)
      (and
        (<= left@7@11 i@62@11)
        (or (< i@62@11 k@63@11) (not (< i@62@11 k@63@11)))))
    (or (<= left@7@11 i@62@11) (not (<= left@7@11 i@62@11)))
    (=>
      (and
        (<= left@7@11 i@62@11)
        (and (< i@62@11 k@63@11) (<= k@63@11 right@8@11)))
      (and (<= left@7@11 i@62@11) (< i@62@11 k@63@11) (<= k@63@11 right@8@11)))
    (or
      (not
        (and
          (<= left@7@11 i@62@11)
          (and (< i@62@11 k@63@11) (<= k@63@11 right@8@11))))
      (and
        (<= left@7@11 i@62@11)
        (and (< i@62@11 k@63@11) (<= k@63@11 right@8@11)))))
  :pattern ((Seq_index pw@39@11 i@62@11) (Seq_index pw@39@11 k@63@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@106@15@106@91-aux|)))
(push) ; 6
(assert (not (forall ((i@62@11 Int) (k@63@11 Int)) (!
  (=>
    (and
      (<= left@7@11 i@62@11)
      (and (< i@62@11 k@63@11) (<= k@63@11 right@8@11)))
    (not (= (Seq_index pw@39@11 i@62@11) (Seq_index pw@39@11 k@63@11))))
  :pattern ((Seq_index pw@39@11 i@62@11) (Seq_index pw@39@11 k@63@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@106@15@106@91|))))
(check-sat)
; unsat
(pop) ; 6
; 0.02s
; (get-info :all-statistics)
(assert (forall ((i@62@11 Int) (k@63@11 Int)) (!
  (=>
    (and
      (<= left@7@11 i@62@11)
      (and (< i@62@11 k@63@11) (<= k@63@11 right@8@11)))
    (not (= (Seq_index pw@39@11 i@62@11) (Seq_index pw@39@11 k@63@11))))
  :pattern ((Seq_index pw@39@11 i@62@11) (Seq_index pw@39@11 k@63@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@106@15@106@91|)))
; [eval] (forall i$0: Int :: { pw[i$0] } left <= i$0 && i$0 <= right ==> loc(a, i$0).val == old(loc(a, pw[i$0]).val))
(declare-const i$0@64@11 Int)
(push) ; 6
; [eval] left <= i$0 && i$0 <= right ==> loc(a, i$0).val == old(loc(a, pw[i$0]).val)
; [eval] left <= i$0 && i$0 <= right
; [eval] left <= i$0
(push) ; 7
; [then-branch: 40 | !(left@7@11 <= i$0@64@11) | live]
; [else-branch: 40 | left@7@11 <= i$0@64@11 | live]
(push) ; 8
; [then-branch: 40 | !(left@7@11 <= i$0@64@11)]
(assert (not (<= left@7@11 i$0@64@11)))
(pop) ; 8
(push) ; 8
; [else-branch: 40 | left@7@11 <= i$0@64@11]
(assert (<= left@7@11 i$0@64@11))
; [eval] i$0 <= right
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= left@7@11 i$0@64@11) (not (<= left@7@11 i$0@64@11))))
(push) ; 7
; [then-branch: 41 | left@7@11 <= i$0@64@11 && i$0@64@11 <= right@8@11 | live]
; [else-branch: 41 | !(left@7@11 <= i$0@64@11 && i$0@64@11 <= right@8@11) | live]
(push) ; 8
; [then-branch: 41 | left@7@11 <= i$0@64@11 && i$0@64@11 <= right@8@11]
(assert (and (<= left@7@11 i$0@64@11) (<= i$0@64@11 right@8@11)))
; [eval] loc(a, i$0).val == old(loc(a, pw[i$0]).val)
; [eval] loc(a, i$0)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@15@11 r)
          (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
        (< $Perm.No (- (- $Perm.Write (pTaken@30@11 r)) (pTaken@32@11 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r)))
    :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r))
    :qid |qp.fvfValDef2|))
  (forall ((r $Ref)) (!
    (=>
      (= r (loc<Ref> a@6@11 pivotIndex@9@11))
      (=
        ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
        ($FVF.lookup_val (as sm@35@11  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@35@11  $FVF<val>) r))
    :qid |qp.fvfValDef3|))
  (forall ((r $Ref)) (!
    (=>
      (= r (loc<Ref> a@6@11 right@8@11))
      (=
        ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
        ($FVF.lookup_val (as sm@36@11  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@36@11  $FVF<val>) r))
    :qid |qp.fvfValDef4|))))
(push) ; 9
(assert (not (<
  $Perm.No
  (+
    (+
      (ite
        (and
          (img@15@11 (loc<Ref> a@6@11 i$0@64@11))
          (and
            (<= left@7@11 (inv@14@11 (loc<Ref> a@6@11 i$0@64@11)))
            (<= (inv@14@11 (loc<Ref> a@6@11 i$0@64@11)) right@8@11)))
        (-
          (- $Perm.Write (pTaken@30@11 (loc<Ref> a@6@11 i$0@64@11)))
          (pTaken@32@11 (loc<Ref> a@6@11 i$0@64@11)))
        $Perm.No)
      (ite
        (= (loc<Ref> a@6@11 i$0@64@11) (loc<Ref> a@6@11 pivotIndex@9@11))
        $Perm.Write
        $Perm.No))
    (ite
      (= (loc<Ref> a@6@11 i$0@64@11) (loc<Ref> a@6@11 right@8@11))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, pw[i$0]).val)
; [eval] loc(a, pw[i$0])
; [eval] pw[i$0]
(push) ; 9
(assert (not (>= i$0@64@11 0)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (< i$0@64@11 (Seq_length pw@39@11))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(push) ; 9
(assert (not (and
  (img@15@11 (loc<Ref> a@6@11 (Seq_index pw@39@11 i$0@64@11)))
  (and
    (<= left@7@11 (inv@14@11 (loc<Ref> a@6@11 (Seq_index pw@39@11 i$0@64@11))))
    (<= (inv@14@11 (loc<Ref> a@6@11 (Seq_index pw@39@11 i$0@64@11))) right@8@11)))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(pop) ; 8
(push) ; 8
; [else-branch: 41 | !(left@7@11 <= i$0@64@11 && i$0@64@11 <= right@8@11)]
(assert (not (and (<= left@7@11 i$0@64@11) (<= i$0@64@11 right@8@11))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@15@11 r)
        (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
      (< $Perm.No (- (- $Perm.Write (pTaken@30@11 r)) (pTaken@32@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r))
  :qid |qp.fvfValDef2|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 pivotIndex@9@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@35@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@35@11  $FVF<val>) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 right@8@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@36@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@36@11  $FVF<val>) r))
  :qid |qp.fvfValDef4|)))
; Joined path conditions
(assert (or
  (not (and (<= left@7@11 i$0@64@11) (<= i$0@64@11 right@8@11)))
  (and (<= left@7@11 i$0@64@11) (<= i$0@64@11 right@8@11))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@15@11 r)
        (and (<= left@7@11 (inv@14@11 r)) (<= (inv@14@11 r) right@8@11)))
      (< $Perm.No (- (- $Perm.Write (pTaken@30@11 r)) (pTaken@32@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@11)))))) r))
  :qid |qp.fvfValDef2|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 pivotIndex@9@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@35@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@35@11  $FVF<val>) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 right@8@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@36@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@37@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@36@11  $FVF<val>) r))
  :qid |qp.fvfValDef4|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i$0@64@11 Int)) (!
  (and
    (or (<= left@7@11 i$0@64@11) (not (<= left@7@11 i$0@64@11)))
    (or
      (not (and (<= left@7@11 i$0@64@11) (<= i$0@64@11 right@8@11)))
      (and (<= left@7@11 i$0@64@11) (<= i$0@64@11 right@8@11))))
  :pattern ((Seq_index pw@39@11 i$0@64@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@108@15@108@43-aux|)))
(push) ; 6
(assert (not (forall ((i$0@64@11 Int)) (!
  (=>
    (and (<= left@7@11 i$0@64@11) (<= i$0@64@11 right@8@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) (loc<Ref> a@6@11 i$0@64@11))
      ($FVF.lookup_val (as sm@31@11  $FVF<val>) (loc<Ref> a@6@11 (Seq_index
        pw@39@11
        i$0@64@11)))))
  :pattern ((Seq_index pw@39@11 i$0@64@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@108@15@108@43|))))
(check-sat)
; unsat
(pop) ; 6
; 0.03s
; (get-info :all-statistics)
(assert (forall ((i$0@64@11 Int)) (!
  (=>
    (and (<= left@7@11 i$0@64@11) (<= i$0@64@11 right@8@11))
    (=
      ($FVF.lookup_val (as sm@37@11  $FVF<val>) (loc<Ref> a@6@11 i$0@64@11))
      ($FVF.lookup_val (as sm@31@11  $FVF<val>) (loc<Ref> a@6@11 (Seq_index
        pw@39@11
        i$0@64@11)))))
  :pattern ((Seq_index pw@39@11 i$0@64@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@108@15@108@43|)))
; Loop head block: Execute statements of loop head block (in invariant state)
(push) ; 6
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@46@11 r)
      (and (<= left@7@11 (inv@45@11 r)) (<= (inv@45@11 r) right@8@11)))
    (= (loc<Ref> a@6@11 (inv@45@11 r)) r))
  :pattern ((inv@45@11 r))
  :qid |val-fctOfInv|)))
(assert (forall ((i@44@11 Int)) (!
  (=>
    (and (<= left@7@11 i@44@11) (<= i@44@11 right@8@11))
    (and
      (= (inv@45@11 (loc<Ref> a@6@11 i@44@11)) i@44@11)
      (img@46@11 (loc<Ref> a@6@11 i@44@11))))
  :pattern ((loc<Ref> a@6@11 i@44@11))
  :qid |quant-u-38|)))
(assert (forall ((i@44@11 Int)) (!
  (=>
    (and (<= left@7@11 i@44@11) (<= i@44@11 right@8@11))
    (not (= (loc<Ref> a@6@11 i@44@11) $Ref.null)))
  :pattern ((loc<Ref> a@6@11 i@44@11))
  :qid |val-permImpliesNonNull|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))
  $Snap.unit))
(assert (=
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) (loc<Ref> a@6@11 right@8@11))
  pivotValue@28@11))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))
  $Snap.unit))
(assert (forall ((i@47@11 Int)) (!
  (and
    (or (<= left@7@11 i@47@11) (not (<= left@7@11 i@47@11)))
    (or
      (not (and (<= left@7@11 i@47@11) (< i@47@11 storeIndex@41@11)))
      (and (<= left@7@11 i@47@11) (< i@47@11 storeIndex@41@11))))
  :pattern ((loc<Ref> a@6@11 i@47@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@101@15@101@90-aux|)))
(assert (forall ((i@47@11 Int)) (!
  (=>
    (and (<= left@7@11 i@47@11) (< i@47@11 storeIndex@41@11))
    (<
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) (loc<Ref> a@6@11 i@47@11))
      pivotValue@28@11))
  :pattern ((loc<Ref> a@6@11 i@47@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@101@15@101@90|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))
  $Snap.unit))
(assert (forall ((i@48@11 Int)) (!
  (and
    (or (<= storeIndex@41@11 i@48@11) (not (<= storeIndex@41@11 i@48@11)))
    (or
      (not (and (<= storeIndex@41@11 i@48@11) (< i@48@11 j@42@11)))
      (and (<= storeIndex@41@11 i@48@11) (< i@48@11 j@42@11))))
  :pattern ((loc<Ref> a@6@11 i@48@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@102@15@102@88-aux|)))
(assert (forall ((i@48@11 Int)) (!
  (=>
    (and (<= storeIndex@41@11 i@48@11) (< i@48@11 j@42@11))
    (<=
      pivotValue@28@11
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) (loc<Ref> a@6@11 i@48@11))))
  :pattern ((loc<Ref> a@6@11 i@48@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@102@15@102@88|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))
  $Snap.unit))
(assert (= (Seq_length pw@40@11) (+ right@8@11 1)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))))
  $Snap.unit))
(assert (forall ((i@49@11 Int)) (!
  (and
    (or (<= left@7@11 i@49@11) (not (<= left@7@11 i@49@11)))
    (=>
      (and (<= left@7@11 i@49@11) (<= i@49@11 right@8@11))
      (and
        (<= left@7@11 i@49@11)
        (<= i@49@11 right@8@11)
        (or
          (<= left@7@11 (Seq_index pw@40@11 i@49@11))
          (not (<= left@7@11 (Seq_index pw@40@11 i@49@11))))))
    (or
      (not (and (<= left@7@11 i@49@11) (<= i@49@11 right@8@11)))
      (and (<= left@7@11 i@49@11) (<= i@49@11 right@8@11))))
  :pattern ((Seq_index pw@40@11 i@49@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@105@15@105@91-aux|)))
(assert (forall ((i@49@11 Int)) (!
  (=>
    (and (<= left@7@11 i@49@11) (<= i@49@11 right@8@11))
    (and
      (<= left@7@11 (Seq_index pw@40@11 i@49@11))
      (<= (Seq_index pw@40@11 i@49@11) right@8@11)))
  :pattern ((Seq_index pw@40@11 i@49@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@105@15@105@91|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))))
  $Snap.unit))
(assert (forall ((i@50@11 Int) (k@51@11 Int)) (!
  (and
    (=>
      (<= left@7@11 i@50@11)
      (and
        (<= left@7@11 i@50@11)
        (or (< i@50@11 k@51@11) (not (< i@50@11 k@51@11)))))
    (or (<= left@7@11 i@50@11) (not (<= left@7@11 i@50@11)))
    (=>
      (and
        (<= left@7@11 i@50@11)
        (and (< i@50@11 k@51@11) (<= k@51@11 right@8@11)))
      (and (<= left@7@11 i@50@11) (< i@50@11 k@51@11) (<= k@51@11 right@8@11)))
    (or
      (not
        (and
          (<= left@7@11 i@50@11)
          (and (< i@50@11 k@51@11) (<= k@51@11 right@8@11))))
      (and
        (<= left@7@11 i@50@11)
        (and (< i@50@11 k@51@11) (<= k@51@11 right@8@11)))))
  :pattern ((Seq_index pw@40@11 i@50@11) (Seq_index pw@40@11 k@51@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@106@15@106@91-aux|)))
(assert (forall ((i@50@11 Int) (k@51@11 Int)) (!
  (=>
    (and
      (<= left@7@11 i@50@11)
      (and (< i@50@11 k@51@11) (<= k@51@11 right@8@11)))
    (not (= (Seq_index pw@40@11 i@50@11) (Seq_index pw@40@11 k@51@11))))
  :pattern ((Seq_index pw@40@11 i@50@11) (Seq_index pw@40@11 k@51@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@106@15@106@91|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))))))
  $Snap.unit))
(assert (forall ((i$0@52@11 Int)) (!
  (and
    (or (<= left@7@11 i$0@52@11) (not (<= left@7@11 i$0@52@11)))
    (or
      (not (and (<= left@7@11 i$0@52@11) (<= i$0@52@11 right@8@11)))
      (and (<= left@7@11 i$0@52@11) (<= i$0@52@11 right@8@11))))
  :pattern ((Seq_index pw@40@11 i$0@52@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@108@15@108@43-aux|)))
(assert (forall ((i$0@52@11 Int)) (!
  (=>
    (and (<= left@7@11 i$0@52@11) (<= i$0@52@11 right@8@11))
    (=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) (loc<Ref> a@6@11 i$0@52@11))
      ($FVF.lookup_val (as sm@31@11  $FVF<val>) (loc<Ref> a@6@11 (Seq_index
        pw@40@11
        i$0@52@11)))))
  :pattern ((Seq_index pw@40@11 i$0@52@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec.vpr@108@15@108@43|)))
(assert (= $t@43@11 ($Snap.combine ($Snap.first $t@43@11) ($Snap.second $t@43@11))))
(assert (= ($Snap.first $t@43@11) $Snap.unit))
(assert (<= left@7@11 j@42@11))
(assert (=
  ($Snap.second $t@43@11)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@43@11))
    ($Snap.second ($Snap.second $t@43@11)))))
(assert (= ($Snap.first ($Snap.second $t@43@11)) $Snap.unit))
(assert (<= j@42@11 right@8@11))
(assert (=
  ($Snap.second ($Snap.second $t@43@11))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@43@11)))
    ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@43@11))) $Snap.unit))
(assert (<= left@7@11 storeIndex@41@11))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@43@11)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@43@11))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@43@11))))
  $Snap.unit))
(assert (<= storeIndex@41@11 j@42@11))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11))))))))
(assert (forall ((i@44@11 Int)) (!
  (=>
    (and (<= left@7@11 i@44@11) (<= i@44@11 right@8@11))
    (or (<= left@7@11 i@44@11) (not (<= left@7@11 i@44@11))))
  :pattern ((loc<Ref> a@6@11 i@44@11))
  :qid |val-aux|)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
(set-option :timeout 10)
(check-sat)
; unknown
; Loop head block: Check well-definedness of edge conditions
(set-option :timeout 0)
(push) ; 7
; [eval] j < right
(pop) ; 7
(push) ; 7
; [eval] !(j < right)
; [eval] j < right
(pop) ; 7
; Loop head block: Follow loop-internal edges
; [eval] j < right
(push) ; 7
(set-option :timeout 10)
(assert (not (not (< j@42@11 right@8@11))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (< j@42@11 right@8@11)))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [then-branch: 42 | j@42@11 < right@8@11 | live]
; [else-branch: 42 | !(j@42@11 < right@8@11) | live]
(set-option :timeout 0)
(push) ; 7
; [then-branch: 42 | j@42@11 < right@8@11]
(assert (< j@42@11 right@8@11))
; [eval] loc(a, j).val < pivotValue
; [eval] loc(a, j)
(push) ; 8
(assert (not (and
  (img@46@11 (loc<Ref> a@6@11 j@42@11))
  (and
    (<= left@7@11 (inv@45@11 (loc<Ref> a@6@11 j@42@11)))
    (<= (inv@45@11 (loc<Ref> a@6@11 j@42@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(push) ; 8
(set-option :timeout 10)
(assert (not (not
  (<
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) (loc<Ref> a@6@11 j@42@11))
    pivotValue@28@11))))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 8
(set-option :timeout 10)
(assert (not (<
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) (loc<Ref> a@6@11 j@42@11))
  pivotValue@28@11)))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [then-branch: 43 | Lookup(val, First:(Second:(Second:(Second:(Second:($t@43@11))))), loc[Ref](a@6@11, j@42@11)) < pivotValue@28@11 | live]
; [else-branch: 43 | !(Lookup(val, First:(Second:(Second:(Second:(Second:($t@43@11))))), loc[Ref](a@6@11, j@42@11)) < pivotValue@28@11) | live]
(set-option :timeout 0)
(push) ; 8
; [then-branch: 43 | Lookup(val, First:(Second:(Second:(Second:(Second:($t@43@11))))), loc[Ref](a@6@11, j@42@11)) < pivotValue@28@11]
(assert (<
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) (loc<Ref> a@6@11 j@42@11))
  pivotValue@28@11))
; [exec]
; swap(a, j, storeIndex)
; [eval] 0 <= i
(push) ; 9
(assert (not (<= 0 j@42@11)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 j@42@11))
; [eval] i < len(a)
; [eval] len(a)
(push) ; 9
(assert (not (< j@42@11 (len<Int> a@6@11))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(assert (< j@42@11 (len<Int> a@6@11)))
; [eval] 0 <= j
(push) ; 9
(assert (not (<= 0 storeIndex@41@11)))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 storeIndex@41@11))
; [eval] j < len(a)
; [eval] len(a)
(push) ; 9
(assert (not (< storeIndex@41@11 (len<Int> a@6@11))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(assert (< storeIndex@41@11 (len<Int> a@6@11)))
; [eval] loc(a, i)
; Precomputing data for removing quantified permissions
(define-fun pTaken@65@11 ((r $Ref)) $Perm
  (ite
    (= r (loc<Ref> a@6@11 j@42@11))
    ($Perm.min
      (ite
        (and
          (img@46@11 r)
          (and (<= left@7@11 (inv@45@11 r)) (<= (inv@45@11 r) right@8@11)))
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
(push) ; 9
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@46@11 r)
          (and (<= left@7@11 (inv@45@11 r)) (<= (inv@45@11 r) right@8@11)))
        $Perm.Write
        $Perm.No)
      (pTaken@65@11 r))
    $Perm.No)
  
  :qid |quant-u-85|))))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 9
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@65@11 r) $Perm.No)
  
  :qid |quant-u-86|))))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 9
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 j@42@11))
    (= (- $Perm.Write (pTaken@65@11 r)) $Perm.No))
  
  :qid |quant-u-87|))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@66@11 $FVF<val>)
; Definitional axioms for snapshot map values (instantiated)
(assert (=>
  (and
    (img@46@11 (loc<Ref> a@6@11 j@42@11))
    (and
      (<= left@7@11 (inv@45@11 (loc<Ref> a@6@11 j@42@11)))
      (<= (inv@45@11 (loc<Ref> a@6@11 j@42@11)) right@8@11)))
  (=
    ($FVF.lookup_val (as sm@66@11  $FVF<val>) (loc<Ref> a@6@11 j@42@11))
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) (loc<Ref> a@6@11 j@42@11)))))
; [eval] i != j
(set-option :timeout 0)
(push) ; 9
(set-option :timeout 10)
(assert (not (= j@42@11 storeIndex@41@11)))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 9
(set-option :timeout 10)
(assert (not (not (= j@42@11 storeIndex@41@11))))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [then-branch: 44 | j@42@11 != storeIndex@41@11 | live]
; [else-branch: 44 | j@42@11 == storeIndex@41@11 | live]
(set-option :timeout 0)
(push) ; 9
; [then-branch: 44 | j@42@11 != storeIndex@41@11]
(assert (not (= j@42@11 storeIndex@41@11)))
; [eval] loc(a, j)
; Precomputing data for removing quantified permissions
(define-fun pTaken@67@11 ((r $Ref)) $Perm
  (ite
    (= r (loc<Ref> a@6@11 storeIndex@41@11))
    ($Perm.min
      (ite
        (and
          (img@46@11 r)
          (and (<= left@7@11 (inv@45@11 r)) (<= (inv@45@11 r) right@8@11)))
        (- $Perm.Write (pTaken@65@11 r))
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
(push) ; 10
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@46@11 r)
          (and (<= left@7@11 (inv@45@11 r)) (<= (inv@45@11 r) right@8@11)))
        (- $Perm.Write (pTaken@65@11 r))
        $Perm.No)
      (pTaken@67@11 r))
    $Perm.No)
  
  :qid |quant-u-89|))))
(check-sat)
; unknown
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 10
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@67@11 r) $Perm.No)
  
  :qid |quant-u-90|))))
(check-sat)
; unknown
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 10
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 storeIndex@41@11))
    (= (- $Perm.Write (pTaken@67@11 r)) $Perm.No))
  
  :qid |quant-u-91|))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@68@11 $FVF<val>)
; Definitional axioms for snapshot map values (instantiated)
(assert (=>
  (ite
    (and
      (img@46@11 (loc<Ref> a@6@11 storeIndex@41@11))
      (and
        (<= left@7@11 (inv@45@11 (loc<Ref> a@6@11 storeIndex@41@11)))
        (<= (inv@45@11 (loc<Ref> a@6@11 storeIndex@41@11)) right@8@11)))
    (<
      $Perm.No
      (- $Perm.Write (pTaken@65@11 (loc<Ref> a@6@11 storeIndex@41@11))))
    false)
  (=
    ($FVF.lookup_val (as sm@68@11  $FVF<val>) (loc<Ref> a@6@11 storeIndex@41@11))
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) (loc<Ref> a@6@11 storeIndex@41@11)))))
(declare-const $t@69@11 $Snap)
(assert (= $t@69@11 ($Snap.combine ($Snap.first $t@69@11) ($Snap.second $t@69@11))))
; [eval] loc(a, i)
(declare-const sm@70@11 $FVF<val>)
; Definitional axioms for singleton-SM's value
(assert (=
  ($FVF.lookup_val (as sm@70@11  $FVF<val>) (loc<Ref> a@6@11 j@42@11))
  ($SortWrappers.$SnapToInt ($Snap.first $t@69@11))))
(assert (<=
  $Perm.No
  (ite
    (= (loc<Ref> a@6@11 j@42@11) (loc<Ref> a@6@11 j@42@11))
    $Perm.Write
    $Perm.No)))
(assert (<=
  (ite
    (= (loc<Ref> a@6@11 j@42@11) (loc<Ref> a@6@11 j@42@11))
    $Perm.Write
    $Perm.No)
  $Perm.Write))
(assert (=>
  (= (loc<Ref> a@6@11 j@42@11) (loc<Ref> a@6@11 j@42@11))
  (not (= (loc<Ref> a@6@11 j@42@11) $Ref.null))))
(assert (=
  ($Snap.second $t@69@11)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@69@11))
    ($Snap.second ($Snap.second $t@69@11)))))
; [eval] i != j
(set-option :timeout 0)
(push) ; 10
(set-option :timeout 10)
(assert (not (= j@42@11 storeIndex@41@11)))
(check-sat)
; unknown
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [then-branch: 45 | j@42@11 != storeIndex@41@11 | live]
; [else-branch: 45 | j@42@11 == storeIndex@41@11 | dead]
(set-option :timeout 0)
(push) ; 10
; [then-branch: 45 | j@42@11 != storeIndex@41@11]
; [eval] loc(a, j)
(declare-const sm@71@11 $FVF<val>)
; Definitional axioms for singleton-SM's value
(assert (=
  ($FVF.lookup_val (as sm@71@11  $FVF<val>) (loc<Ref> a@6@11 storeIndex@41@11))
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@69@11)))))
(push) ; 11
(set-option :timeout 10)
(assert (not (= (loc<Ref> a@6@11 storeIndex@41@11) (loc<Ref> a@6@11 j@42@11))))
(check-sat)
; unknown
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(assert (<=
  $Perm.No
  (ite
    (= (loc<Ref> a@6@11 storeIndex@41@11) (loc<Ref> a@6@11 storeIndex@41@11))
    $Perm.Write
    $Perm.No)))
(assert (<=
  (ite
    (= (loc<Ref> a@6@11 storeIndex@41@11) (loc<Ref> a@6@11 storeIndex@41@11))
    $Perm.Write
    $Perm.No)
  $Perm.Write))
(assert (=>
  (= (loc<Ref> a@6@11 storeIndex@41@11) (loc<Ref> a@6@11 storeIndex@41@11))
  (not (= (loc<Ref> a@6@11 storeIndex@41@11) $Ref.null))))
(assert (=
  ($Snap.second ($Snap.second $t@69@11))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@69@11)))
    ($Snap.second ($Snap.second ($Snap.second $t@69@11))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@69@11))) $Snap.unit))
; [eval] loc(a, i).val == old(loc(a, j).val)
; [eval] loc(a, i)
(declare-const sm@72@11 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@46@11 r)
        (and (<= left@7@11 (inv@45@11 r)) (<= (inv@45@11 r) right@8@11)))
      (< $Perm.No (- (- $Perm.Write (pTaken@65@11 r)) (pTaken@67@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@72@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) r)))
  :pattern (($FVF.lookup_val (as sm@72@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 j@42@11))
    (=
      ($FVF.lookup_val (as sm@72@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@70@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@72@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@70@11  $FVF<val>) r))
  :qid |qp.fvfValDef9|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@6@11 storeIndex@41@11))
    (=
      ($FVF.lookup_val (as sm@72@11  $FVF<val>) r)
      ($FVF.lookup_val (as sm@71@11  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@72@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@71@11  $FVF<val>) r))
  :qid |qp.fvfValDef10|)))
(declare-const pm@73@11 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@73@11  $FPM) r)
    (+
      (+
        (ite
          (and
            (img@46@11 r)
            (and (<= left@7@11 (inv@45@11 r)) (<= (inv@45@11 r) right@8@11)))
          (- (- $Perm.Write (pTaken@65@11 r)) (pTaken@67@11 r))
          $Perm.No)
        (ite (= r (loc<Ref> a@6@11 j@42@11)) $Perm.Write $Perm.No))
      (ite (= r (loc<Ref> a@6@11 storeIndex@41@11)) $Perm.Write $Perm.No)))
  :pattern (($FVF.perm_val (as pm@73@11  $FPM) r))
  :qid |qp.resPrmSumDef11|)))
(set-option :timeout 0)
(push) ; 11
(assert (not (< $Perm.No ($FVF.perm_val (as pm@73@11  $FPM) (loc<Ref> a@6@11 j@42@11)))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, j).val)
; [eval] loc(a, j)
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@46@11 r)
      (and (<= left@7@11 (inv@45@11 r)) (<= (inv@45@11 r) right@8@11)))
    (=
      ($FVF.lookup_val (as sm@66@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) r)))
  :pattern (($FVF.lookup_val (as sm@66@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) r))
  :qid |qp.fvfValDef6|)))
(push) ; 11
(assert (not (and
  (img@46@11 (loc<Ref> a@6@11 storeIndex@41@11))
  (and
    (<= left@7@11 (inv@45@11 (loc<Ref> a@6@11 storeIndex@41@11)))
    (<= (inv@45@11 (loc<Ref> a@6@11 storeIndex@41@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($FVF.lookup_val (as sm@72@11  $FVF<val>) (loc<Ref> a@6@11 j@42@11))
  ($FVF.lookup_val (as sm@66@11  $FVF<val>) (loc<Ref> a@6@11 storeIndex@41@11))))
(assert (= ($Snap.second ($Snap.second ($Snap.second $t@69@11))) $Snap.unit))
; [eval] loc(a, j).val == old(loc(a, i).val)
; [eval] loc(a, j)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@46@11 r)
          (and (<= left@7@11 (inv@45@11 r)) (<= (inv@45@11 r) right@8@11)))
        (< $Perm.No (- (- $Perm.Write (pTaken@65@11 r)) (pTaken@67@11 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@72@11  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) r)))
    :pattern (($FVF.lookup_val (as sm@72@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@43@11)))))) r))
    :qid |qp.fvfValDef8|))
  (forall ((r $Ref)) (!
    (=>
      (= r (loc<Ref> a@6@11 j@42@11))
      (=
        ($FVF.lookup_val (as sm@72@11  $FVF<val>) r)
        ($FVF.lookup_val (as sm@70@11  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@72@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@70@11  $FVF<val>) r))
    :qid |qp.fvfValDef9|))
  (forall ((r $Ref)) (!
    (=>
      (= r (loc<Ref> a@6@11 storeIndex@41@11))
      (=
        ($FVF.lookup_val (as sm@72@11  $FVF<val>) r)
        ($FVF.lookup_val (as sm@71@11  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@72@11  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@71@11  $FVF<val>) r))
    :qid |qp.fvfValDef10|))))
(push) ; 11
(assert (not (<
  $Perm.No
  (+
    (+
      (ite
        (and
          (img@46@11 (loc<Ref> a@6@11 storeIndex@41@11))
          (and
            (<= left@7@11 (inv@45@11 (loc<Ref> a@6@11 storeIndex@41@11)))
            (<= (inv@45@11 (loc<Ref> a@6@11 storeIndex@41@11)) right@8@11)))
        (-
          (- $Perm.Write (pTaken@65@11 (loc<Ref> a@6@11 storeIndex@41@11)))
          (pTaken@67@11 (loc<Ref> a@6@11 storeIndex@41@11)))
        $Perm.No)
      (ite
        (= (loc<Ref> a@6@11 storeIndex@41@11) (loc<Ref> a@6@11 j@42@11))
        $Perm.Write
        $Perm.No))
    (ite
      (= (loc<Ref> a@6@11 storeIndex@41@11) (loc<Ref> a@6@11 storeIndex@41@11))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, i).val)
; [eval] loc(a, i)
(push) ; 11
(assert (not (and
  (img@46@11 (loc<Ref> a@6@11 j@42@11))
  (and
    (<= left@7@11 (inv@45@11 (loc<Ref> a@6@11 j@42@11)))
    (<= (inv@45@11 (loc<Ref> a@6@11 j@42@11)) right@8@11)))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($FVF.lookup_val (as sm@72@11  $FVF<val>) (loc<Ref> a@6@11 storeIndex@41@11))
  ($FVF.lookup_val (as sm@66@11  $FVF<val>) (loc<Ref> a@6@11 j@42@11))))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
; [exec]
; pw := pw[storeIndex := pw[j]][j := pw[storeIndex]]
; [eval] pw[storeIndex := pw[j]][j := pw[storeIndex]]
; [eval] pw[storeIndex := pw[j]]
; [eval] pw[j]
(set-option :timeout 0)
(push) ; 11
(assert (not (>= j@42@11 0)))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(push) ; 11
(assert (not (< j@42@11 (Seq_length pw@40@11))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(push) ; 11
(assert (not (>= storeIndex@41@11 0)))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(push) ; 11
(assert (not (< storeIndex@41@11 (Seq_length pw@40@11))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
; [eval] pw[storeIndex]
