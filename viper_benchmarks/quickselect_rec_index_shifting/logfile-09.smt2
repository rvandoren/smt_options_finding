(get-info :version)
; (:version "4.13.0")
; Started: 2024-09-24 15:28:03
; Silicon.version: 1.1-SNAPSHOT (b737e366)
; Input file: /Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec_index-shifting.vpr
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
; ---------- client ----------
(declare-const a@0@09 IArray)
(declare-const a@1@09 IArray)
(set-option :timeout 0)
(push) ; 1
(declare-const $t@2@09 $Snap)
(assert (= $t@2@09 ($Snap.combine ($Snap.first $t@2@09) ($Snap.second $t@2@09))))
(assert (= ($Snap.first $t@2@09) $Snap.unit))
; [eval] 10 < len(a)
; [eval] len(a)
(assert (< 10 (len<Int> a@1@09)))
(assert (=
  ($Snap.second $t@2@09)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@2@09))
    ($Snap.second ($Snap.second $t@2@09)))))
(declare-const i@3@09 Int)
(push) ; 2
; [eval] 0 <= i && i < len(a)
; [eval] 0 <= i
(push) ; 3
; [then-branch: 0 | !(0 <= i@3@09) | live]
; [else-branch: 0 | 0 <= i@3@09 | live]
(push) ; 4
; [then-branch: 0 | !(0 <= i@3@09)]
(assert (not (<= 0 i@3@09)))
(pop) ; 4
(push) ; 4
; [else-branch: 0 | 0 <= i@3@09]
(assert (<= 0 i@3@09))
; [eval] i < len(a)
; [eval] len(a)
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@3@09) (not (<= 0 i@3@09))))
(assert (and (<= 0 i@3@09) (< i@3@09 (len<Int> a@1@09))))
; [eval] loc(a, i)
(pop) ; 2
(declare-fun inv@4@09 ($Ref) Int)
(declare-fun img@5@09 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@3@09 Int)) (!
  (=>
    (and (<= 0 i@3@09) (< i@3@09 (len<Int> a@1@09)))
    (or (<= 0 i@3@09) (not (<= 0 i@3@09))))
  :pattern ((loc<Ref> a@1@09 i@3@09))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 2
(assert (not (forall ((i1@3@09 Int) (i2@3@09 Int)) (!
  (=>
    (and
      (and (<= 0 i1@3@09) (< i1@3@09 (len<Int> a@1@09)))
      (and (<= 0 i2@3@09) (< i2@3@09 (len<Int> a@1@09)))
      (= (loc<Ref> a@1@09 i1@3@09) (loc<Ref> a@1@09 i2@3@09)))
    (= i1@3@09 i2@3@09))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 2
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@3@09 Int)) (!
  (=>
    (and (<= 0 i@3@09) (< i@3@09 (len<Int> a@1@09)))
    (and
      (= (inv@4@09 (loc<Ref> a@1@09 i@3@09)) i@3@09)
      (img@5@09 (loc<Ref> a@1@09 i@3@09))))
  :pattern ((loc<Ref> a@1@09 i@3@09))
  :qid |quant-u-9|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@5@09 r)
      (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
    (= (loc<Ref> a@1@09 (inv@4@09 r)) r))
  :pattern ((inv@4@09 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@3@09 Int)) (!
  (=>
    (and (<= 0 i@3@09) (< i@3@09 (len<Int> a@1@09)))
    (not (= (loc<Ref> a@1@09 i@3@09) $Ref.null)))
  :pattern ((loc<Ref> a@1@09 i@3@09))
  :qid |val-permImpliesNonNull|)))
(assert (= ($Snap.second ($Snap.second $t@2@09)) $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } 0 <= i && i <= 10 ==> loc(a, i).val == i)
(declare-const i@6@09 Int)
(push) ; 2
; [eval] 0 <= i && i <= 10 ==> loc(a, i).val == i
; [eval] 0 <= i && i <= 10
; [eval] 0 <= i
(push) ; 3
; [then-branch: 1 | !(0 <= i@6@09) | live]
; [else-branch: 1 | 0 <= i@6@09 | live]
(push) ; 4
; [then-branch: 1 | !(0 <= i@6@09)]
(assert (not (<= 0 i@6@09)))
(pop) ; 4
(push) ; 4
; [else-branch: 1 | 0 <= i@6@09]
(assert (<= 0 i@6@09))
; [eval] i <= 10
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@6@09) (not (<= 0 i@6@09))))
(push) ; 3
; [then-branch: 2 | 0 <= i@6@09 && i@6@09 <= 10 | live]
; [else-branch: 2 | !(0 <= i@6@09 && i@6@09 <= 10) | live]
(push) ; 4
; [then-branch: 2 | 0 <= i@6@09 && i@6@09 <= 10]
(assert (and (<= 0 i@6@09) (<= i@6@09 10)))
; [eval] loc(a, i).val == i
; [eval] loc(a, i)
(push) ; 5
(assert (not (and
  (img@5@09 (loc<Ref> a@1@09 i@6@09))
  (and
    (<= 0 (inv@4@09 (loc<Ref> a@1@09 i@6@09)))
    (< (inv@4@09 (loc<Ref> a@1@09 i@6@09)) (len<Int> a@1@09))))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(pop) ; 4
(push) ; 4
; [else-branch: 2 | !(0 <= i@6@09 && i@6@09 <= 10)]
(assert (not (and (<= 0 i@6@09) (<= i@6@09 10))))
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (or (not (and (<= 0 i@6@09) (<= i@6@09 10))) (and (<= 0 i@6@09) (<= i@6@09 10))))
(pop) ; 2
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@6@09 Int)) (!
  (and
    (or (<= 0 i@6@09) (not (<= 0 i@6@09)))
    (or
      (not (and (<= 0 i@6@09) (<= i@6@09 10)))
      (and (<= 0 i@6@09) (<= i@6@09 10))))
  :pattern ((loc<Ref> a@1@09 i@6@09))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec_index-shifting.vpr@215@12@215@69-aux|)))
(assert (forall ((i@6@09 Int)) (!
  (=>
    (and (<= 0 i@6@09) (<= i@6@09 10))
    (=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) (loc<Ref> a@1@09 i@6@09))
      i@6@09))
  :pattern ((loc<Ref> a@1@09 i@6@09))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec_index-shifting.vpr@215@12@215@69|)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
(set-option :timeout 0)
(push) ; 2
(declare-const i@7@09 Int)
(push) ; 3
; [eval] 0 <= i && i < len(a)
; [eval] 0 <= i
(push) ; 4
; [then-branch: 3 | !(0 <= i@7@09) | live]
; [else-branch: 3 | 0 <= i@7@09 | live]
(push) ; 5
; [then-branch: 3 | !(0 <= i@7@09)]
(assert (not (<= 0 i@7@09)))
(pop) ; 5
(push) ; 5
; [else-branch: 3 | 0 <= i@7@09]
(assert (<= 0 i@7@09))
; [eval] i < len(a)
; [eval] len(a)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@7@09) (not (<= 0 i@7@09))))
(assert (and (<= 0 i@7@09) (< i@7@09 (len<Int> a@1@09))))
; [eval] loc(a, i)
(pop) ; 3
(declare-const $t@8@09 $FVF<val>)
(declare-fun inv@9@09 ($Ref) Int)
(declare-fun img@10@09 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@7@09 Int)) (!
  (=>
    (and (<= 0 i@7@09) (< i@7@09 (len<Int> a@1@09)))
    (or (<= 0 i@7@09) (not (<= 0 i@7@09))))
  :pattern ((loc<Ref> a@1@09 i@7@09))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((i1@7@09 Int) (i2@7@09 Int)) (!
  (=>
    (and
      (and (<= 0 i1@7@09) (< i1@7@09 (len<Int> a@1@09)))
      (and (<= 0 i2@7@09) (< i2@7@09 (len<Int> a@1@09)))
      (= (loc<Ref> a@1@09 i1@7@09) (loc<Ref> a@1@09 i2@7@09)))
    (= i1@7@09 i2@7@09))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@7@09 Int)) (!
  (=>
    (and (<= 0 i@7@09) (< i@7@09 (len<Int> a@1@09)))
    (and
      (= (inv@9@09 (loc<Ref> a@1@09 i@7@09)) i@7@09)
      (img@10@09 (loc<Ref> a@1@09 i@7@09))))
  :pattern ((loc<Ref> a@1@09 i@7@09))
  :qid |quant-u-15|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@10@09 r)
      (and (<= 0 (inv@9@09 r)) (< (inv@9@09 r) (len<Int> a@1@09))))
    (= (loc<Ref> a@1@09 (inv@9@09 r)) r))
  :pattern ((inv@9@09 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@7@09 Int)) (!
  (=>
    (and (<= 0 i@7@09) (< i@7@09 (len<Int> a@1@09)))
    (not (= (loc<Ref> a@1@09 i@7@09) $Ref.null)))
  :pattern ((loc<Ref> a@1@09 i@7@09))
  :qid |val-permImpliesNonNull|)))
(pop) ; 2
(push) ; 2
; [exec]
; var storeIndex: Int
(declare-const storeIndex@11@09 Int)
; [exec]
; var pw: Seq[Int]
(declare-const pw@12@09 Seq<Int>)
; [exec]
; storeIndex, pw := select_rec(a, 0, 10, 3)
; [eval] 0 <= left
; [eval] left <= right
; [eval] right < len(a)
; [eval] len(a)
; [eval] left <= n
; [eval] n <= right
(declare-const i@13@09 Int)
(push) ; 3
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 4
; [then-branch: 4 | !(0 <= i@13@09) | live]
; [else-branch: 4 | 0 <= i@13@09 | live]
(push) ; 5
; [then-branch: 4 | !(0 <= i@13@09)]
(assert (not (<= 0 i@13@09)))
(pop) ; 5
(push) ; 5
; [else-branch: 4 | 0 <= i@13@09]
(assert (<= 0 i@13@09))
; [eval] i <= right
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@13@09) (not (<= 0 i@13@09))))
(assert (and (<= 0 i@13@09) (<= i@13@09 10)))
; [eval] loc(a, i)
(pop) ; 3
(declare-fun inv@14@09 ($Ref) Int)
(declare-fun img@15@09 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@13@09 Int)) (!
  (=>
    (and (<= 0 i@13@09) (<= i@13@09 10))
    (or (<= 0 i@13@09) (not (<= 0 i@13@09))))
  :pattern ((loc<Ref> a@1@09 i@13@09))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((i1@13@09 Int) (i2@13@09 Int)) (!
  (=>
    (and
      (and (<= 0 i1@13@09) (<= i1@13@09 10))
      (and (<= 0 i2@13@09) (<= i2@13@09 10))
      (= (loc<Ref> a@1@09 i1@13@09) (loc<Ref> a@1@09 i2@13@09)))
    (= i1@13@09 i2@13@09))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@13@09 Int)) (!
  (=>
    (and (<= 0 i@13@09) (<= i@13@09 10))
    (and
      (= (inv@14@09 (loc<Ref> a@1@09 i@13@09)) i@13@09)
      (img@15@09 (loc<Ref> a@1@09 i@13@09))))
  :pattern ((loc<Ref> a@1@09 i@13@09))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@15@09 r) (and (<= 0 (inv@14@09 r)) (<= (inv@14@09 r) 10)))
    (= (loc<Ref> a@1@09 (inv@14@09 r)) r))
  :pattern ((inv@14@09 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@16@09 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= 0 (inv@14@09 r)) (<= (inv@14@09 r) 10))
      (img@15@09 r)
      (= r (loc<Ref> a@1@09 (inv@14@09 r))))
    ($Perm.min
      (ite
        (and
          (img@5@09 r)
          (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
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
          (img@5@09 r)
          (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
        $Perm.Write
        $Perm.No)
      (pTaken@16@09 r))
    $Perm.No)
  
  :qid |quant-u-18|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@16@09 r) $Perm.No)
  
  :qid |quant-u-19|))))
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
    (and
      (and (<= 0 (inv@14@09 r)) (<= (inv@14@09 r) 10))
      (img@15@09 r)
      (= r (loc<Ref> a@1@09 (inv@14@09 r))))
    (= (- $Perm.Write (pTaken@16@09 r)) $Perm.No))
  
  :qid |quant-u-20|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@17@09 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@5@09 r)
      (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
    (=
      ($FVF.lookup_val (as sm@17@09  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r)))
  :pattern (($FVF.lookup_val (as sm@17@09  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r))
  :qid |qp.fvfValDef0|)))
(declare-const storeIndex@18@09 Int)
(declare-const pw@19@09 Seq<Int>)
(declare-const $t@20@09 $Snap)
(assert (= $t@20@09 ($Snap.combine ($Snap.first $t@20@09) ($Snap.second $t@20@09))))
(assert (= ($Snap.first $t@20@09) $Snap.unit))
; [eval] left <= storeIndex
(assert (<= 0 storeIndex@18@09))
(assert (=
  ($Snap.second $t@20@09)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@20@09))
    ($Snap.second ($Snap.second $t@20@09)))))
(assert (= ($Snap.first ($Snap.second $t@20@09)) $Snap.unit))
; [eval] storeIndex <= right
(assert (<= storeIndex@18@09 10))
(assert (=
  ($Snap.second ($Snap.second $t@20@09))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@20@09)))
    ($Snap.second ($Snap.second ($Snap.second $t@20@09))))))
(declare-const i@21@09 Int)
(set-option :timeout 0)
(push) ; 3
; [eval] left <= i && i <= right
; [eval] left <= i
(push) ; 4
; [then-branch: 5 | !(0 <= i@21@09) | live]
; [else-branch: 5 | 0 <= i@21@09 | live]
(push) ; 5
; [then-branch: 5 | !(0 <= i@21@09)]
(assert (not (<= 0 i@21@09)))
(pop) ; 5
(push) ; 5
; [else-branch: 5 | 0 <= i@21@09]
(assert (<= 0 i@21@09))
; [eval] i <= right
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@21@09) (not (<= 0 i@21@09))))
(assert (and (<= 0 i@21@09) (<= i@21@09 10)))
; [eval] loc(a, i)
(pop) ; 3
(declare-fun inv@22@09 ($Ref) Int)
(declare-fun img@23@09 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@21@09 Int)) (!
  (=>
    (and (<= 0 i@21@09) (<= i@21@09 10))
    (or (<= 0 i@21@09) (not (<= 0 i@21@09))))
  :pattern ((loc<Ref> a@1@09 i@21@09))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((i1@21@09 Int) (i2@21@09 Int)) (!
  (=>
    (and
      (and (<= 0 i1@21@09) (<= i1@21@09 10))
      (and (<= 0 i2@21@09) (<= i2@21@09 10))
      (= (loc<Ref> a@1@09 i1@21@09) (loc<Ref> a@1@09 i2@21@09)))
    (= i1@21@09 i2@21@09))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@21@09 Int)) (!
  (=>
    (and (<= 0 i@21@09) (<= i@21@09 10))
    (and
      (= (inv@22@09 (loc<Ref> a@1@09 i@21@09)) i@21@09)
      (img@23@09 (loc<Ref> a@1@09 i@21@09))))
  :pattern ((loc<Ref> a@1@09 i@21@09))
  :qid |quant-u-22|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
    (= (loc<Ref> a@1@09 (inv@22@09 r)) r))
  :pattern ((inv@22@09 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@21@09 Int)) (!
  (=>
    (and (<= 0 i@21@09) (<= i@21@09 10))
    (not (= (loc<Ref> a@1@09 i@21@09) $Ref.null)))
  :pattern ((loc<Ref> a@1@09 i@21@09))
  :qid |val-permImpliesNonNull|)))
(push) ; 3
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= (loc<Ref> a@1@09 i@21@09) (loc<Ref> a@1@09 i@3@09))
    (=
      (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
      (and
        (img@5@09 r)
        (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))))
  
  :qid |quant-u-23|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@20@09)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@20@09))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@20@09))))
  $Snap.unit))
; [eval] storeIndex == n
(assert (= storeIndex@18@09 3))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09)))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val)
(declare-const i@24@09 Int)
(set-option :timeout 0)
(push) ; 3
; [eval] left <= i && i < storeIndex ==> loc(a, i).val <= loc(a, storeIndex).val
; [eval] left <= i && i < storeIndex
; [eval] left <= i
(push) ; 4
; [then-branch: 6 | !(0 <= i@24@09) | live]
; [else-branch: 6 | 0 <= i@24@09 | live]
(push) ; 5
; [then-branch: 6 | !(0 <= i@24@09)]
(assert (not (<= 0 i@24@09)))
(pop) ; 5
(push) ; 5
; [else-branch: 6 | 0 <= i@24@09]
(assert (<= 0 i@24@09))
; [eval] i < storeIndex
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@24@09) (not (<= 0 i@24@09))))
(push) ; 4
; [then-branch: 7 | 0 <= i@24@09 && i@24@09 < storeIndex@18@09 | live]
; [else-branch: 7 | !(0 <= i@24@09 && i@24@09 < storeIndex@18@09) | live]
(push) ; 5
; [then-branch: 7 | 0 <= i@24@09 && i@24@09 < storeIndex@18@09]
(assert (and (<= 0 i@24@09) (< i@24@09 storeIndex@18@09)))
; [eval] loc(a, i).val <= loc(a, storeIndex).val
; [eval] loc(a, i)
(declare-const sm@25@09 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@5@09 r)
        (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
      (< $Perm.No (- $Perm.Write (pTaken@16@09 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r)))
  :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r))
  :qid |qp.fvfValDef1|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
    (=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r)))
  :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r))
  :qid |qp.fvfValDef2|)))
(declare-const pm@26@09 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@26@09  $FPM) r)
    (+
      (ite
        (and
          (img@5@09 r)
          (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
        (- $Perm.Write (pTaken@16@09 r))
        $Perm.No)
      (ite
        (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@26@09  $FPM) r))
  :qid |qp.resPrmSumDef3|)))
(push) ; 6
(assert (not (< $Perm.No ($FVF.perm_val (as pm@26@09  $FPM) (loc<Ref> a@1@09 i@24@09)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, storeIndex)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@5@09 r)
          (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
        (< $Perm.No (- $Perm.Write (pTaken@16@09 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r)))
    :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r))
    :qid |qp.fvfValDef1|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
      (=
        ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r)))
    :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r))
    :qid |qp.fvfValDef2|))))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@5@09 (loc<Ref> a@1@09 storeIndex@18@09))
        (and
          (<= 0 (inv@4@09 (loc<Ref> a@1@09 storeIndex@18@09)))
          (< (inv@4@09 (loc<Ref> a@1@09 storeIndex@18@09)) (len<Int> a@1@09))))
      (- $Perm.Write (pTaken@16@09 (loc<Ref> a@1@09 storeIndex@18@09)))
      $Perm.No)
    (ite
      (and
        (img@23@09 (loc<Ref> a@1@09 storeIndex@18@09))
        (and
          (<= 0 (inv@22@09 (loc<Ref> a@1@09 storeIndex@18@09)))
          (<= (inv@22@09 (loc<Ref> a@1@09 storeIndex@18@09)) 10)))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 7 | !(0 <= i@24@09 && i@24@09 < storeIndex@18@09)]
(assert (not (and (<= 0 i@24@09) (< i@24@09 storeIndex@18@09))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@5@09 r)
        (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
      (< $Perm.No (- $Perm.Write (pTaken@16@09 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r)))
  :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r))
  :qid |qp.fvfValDef1|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
    (=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r)))
  :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r))
  :qid |qp.fvfValDef2|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@26@09  $FPM) r)
    (+
      (ite
        (and
          (img@5@09 r)
          (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
        (- $Perm.Write (pTaken@16@09 r))
        $Perm.No)
      (ite
        (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@26@09  $FPM) r))
  :qid |qp.resPrmSumDef3|)))
; Joined path conditions
(assert (or
  (not (and (<= 0 i@24@09) (< i@24@09 storeIndex@18@09)))
  (and (<= 0 i@24@09) (< i@24@09 storeIndex@18@09))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@5@09 r)
        (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
      (< $Perm.No (- $Perm.Write (pTaken@16@09 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r)))
  :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r))
  :qid |qp.fvfValDef1|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
    (=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r)))
  :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r))
  :qid |qp.fvfValDef2|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@26@09  $FPM) r)
    (+
      (ite
        (and
          (img@5@09 r)
          (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
        (- $Perm.Write (pTaken@16@09 r))
        $Perm.No)
      (ite
        (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@26@09  $FPM) r))
  :qid |qp.resPrmSumDef3|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@24@09 Int)) (!
  (and
    (or (<= 0 i@24@09) (not (<= 0 i@24@09)))
    (or
      (not (and (<= 0 i@24@09) (< i@24@09 storeIndex@18@09)))
      (and (<= 0 i@24@09) (< i@24@09 storeIndex@18@09))))
  :pattern ((loc<Ref> a@1@09 i@24@09))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec_index-shifting.vpr@144@11@144@100-aux|)))
(assert (forall ((i@24@09 Int)) (!
  (=>
    (and (<= 0 i@24@09) (< i@24@09 storeIndex@18@09))
    (<=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) (loc<Ref> a@1@09 i@24@09))
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) (loc<Ref> a@1@09 storeIndex@18@09))))
  :pattern ((loc<Ref> a@1@09 i@24@09))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec_index-shifting.vpr@144@11@144@100|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09))))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val)
(declare-const i@27@09 Int)
(push) ; 3
; [eval] storeIndex < i && i <= right ==> loc(a, storeIndex).val <= loc(a, i).val
; [eval] storeIndex < i && i <= right
; [eval] storeIndex < i
(push) ; 4
; [then-branch: 8 | !(storeIndex@18@09 < i@27@09) | live]
; [else-branch: 8 | storeIndex@18@09 < i@27@09 | live]
(push) ; 5
; [then-branch: 8 | !(storeIndex@18@09 < i@27@09)]
(assert (not (< storeIndex@18@09 i@27@09)))
(pop) ; 5
(push) ; 5
; [else-branch: 8 | storeIndex@18@09 < i@27@09]
(assert (< storeIndex@18@09 i@27@09))
; [eval] i <= right
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (< storeIndex@18@09 i@27@09) (not (< storeIndex@18@09 i@27@09))))
(push) ; 4
; [then-branch: 9 | storeIndex@18@09 < i@27@09 && i@27@09 <= 10 | live]
; [else-branch: 9 | !(storeIndex@18@09 < i@27@09 && i@27@09 <= 10) | live]
(push) ; 5
; [then-branch: 9 | storeIndex@18@09 < i@27@09 && i@27@09 <= 10]
(assert (and (< storeIndex@18@09 i@27@09) (<= i@27@09 10)))
; [eval] loc(a, storeIndex).val <= loc(a, i).val
; [eval] loc(a, storeIndex)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@5@09 r)
          (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
        (< $Perm.No (- $Perm.Write (pTaken@16@09 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r)))
    :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r))
    :qid |qp.fvfValDef1|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
      (=
        ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r)))
    :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r))
    :qid |qp.fvfValDef2|))))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@5@09 (loc<Ref> a@1@09 storeIndex@18@09))
        (and
          (<= 0 (inv@4@09 (loc<Ref> a@1@09 storeIndex@18@09)))
          (< (inv@4@09 (loc<Ref> a@1@09 storeIndex@18@09)) (len<Int> a@1@09))))
      (- $Perm.Write (pTaken@16@09 (loc<Ref> a@1@09 storeIndex@18@09)))
      $Perm.No)
    (ite
      (and
        (img@23@09 (loc<Ref> a@1@09 storeIndex@18@09))
        (and
          (<= 0 (inv@22@09 (loc<Ref> a@1@09 storeIndex@18@09)))
          (<= (inv@22@09 (loc<Ref> a@1@09 storeIndex@18@09)) 10)))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@5@09 r)
          (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
        (< $Perm.No (- $Perm.Write (pTaken@16@09 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r)))
    :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r))
    :qid |qp.fvfValDef1|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
      (=
        ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r)))
    :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r))
    :qid |qp.fvfValDef2|))))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@5@09 (loc<Ref> a@1@09 i@27@09))
        (and
          (<= 0 (inv@4@09 (loc<Ref> a@1@09 i@27@09)))
          (< (inv@4@09 (loc<Ref> a@1@09 i@27@09)) (len<Int> a@1@09))))
      (- $Perm.Write (pTaken@16@09 (loc<Ref> a@1@09 i@27@09)))
      $Perm.No)
    (ite
      (and
        (img@23@09 (loc<Ref> a@1@09 i@27@09))
        (and
          (<= 0 (inv@22@09 (loc<Ref> a@1@09 i@27@09)))
          (<= (inv@22@09 (loc<Ref> a@1@09 i@27@09)) 10)))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 9 | !(storeIndex@18@09 < i@27@09 && i@27@09 <= 10)]
(assert (not (and (< storeIndex@18@09 i@27@09) (<= i@27@09 10))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@5@09 r)
        (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
      (< $Perm.No (- $Perm.Write (pTaken@16@09 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r)))
  :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r))
  :qid |qp.fvfValDef1|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
    (=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r)))
  :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r))
  :qid |qp.fvfValDef2|)))
; Joined path conditions
(assert (or
  (not (and (< storeIndex@18@09 i@27@09) (<= i@27@09 10)))
  (and (< storeIndex@18@09 i@27@09) (<= i@27@09 10))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@5@09 r)
        (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
      (< $Perm.No (- $Perm.Write (pTaken@16@09 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r)))
  :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r))
  :qid |qp.fvfValDef1|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
    (=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r)))
  :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r))
  :qid |qp.fvfValDef2|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@27@09 Int)) (!
  (and
    (or (< storeIndex@18@09 i@27@09) (not (< storeIndex@18@09 i@27@09)))
    (or
      (not (and (< storeIndex@18@09 i@27@09) (<= i@27@09 10)))
      (and (< storeIndex@18@09 i@27@09) (<= i@27@09 10))))
  :pattern ((loc<Ref> a@1@09 i@27@09))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec_index-shifting.vpr@145@11@145@100-aux|)))
(assert (forall ((i@27@09 Int)) (!
  (=>
    (and (< storeIndex@18@09 i@27@09) (<= i@27@09 10))
    (<=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) (loc<Ref> a@1@09 storeIndex@18@09))
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) (loc<Ref> a@1@09 i@27@09))))
  :pattern ((loc<Ref> a@1@09 i@27@09))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec_index-shifting.vpr@145@11@145@100|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09)))))))
  $Snap.unit))
; [eval] |pw| == right + 1 - left
; [eval] |pw|
; [eval] right + 1 - left
; [eval] right + 1
(assert (= (Seq_length pw@19@09) 11))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { pw[i] } 0 <= i && i < |pw| ==> left <= pw[i] && pw[i] <= right)
(declare-const i@28@09 Int)
(push) ; 3
; [eval] 0 <= i && i < |pw| ==> left <= pw[i] && pw[i] <= right
; [eval] 0 <= i && i < |pw|
; [eval] 0 <= i
(push) ; 4
; [then-branch: 10 | !(0 <= i@28@09) | live]
; [else-branch: 10 | 0 <= i@28@09 | live]
(push) ; 5
; [then-branch: 10 | !(0 <= i@28@09)]
(assert (not (<= 0 i@28@09)))
(pop) ; 5
(push) ; 5
; [else-branch: 10 | 0 <= i@28@09]
(assert (<= 0 i@28@09))
; [eval] i < |pw|
; [eval] |pw|
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@28@09) (not (<= 0 i@28@09))))
(push) ; 4
; [then-branch: 11 | 0 <= i@28@09 && i@28@09 < |pw@19@09| | live]
; [else-branch: 11 | !(0 <= i@28@09 && i@28@09 < |pw@19@09|) | live]
(push) ; 5
; [then-branch: 11 | 0 <= i@28@09 && i@28@09 < |pw@19@09|]
(assert (and (<= 0 i@28@09) (< i@28@09 (Seq_length pw@19@09))))
; [eval] left <= pw[i] && pw[i] <= right
; [eval] left <= pw[i]
; [eval] pw[i]
(push) ; 6
(assert (not (>= i@28@09 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
; [then-branch: 12 | !(0 <= pw@19@09[i@28@09]) | live]
; [else-branch: 12 | 0 <= pw@19@09[i@28@09] | live]
(push) ; 7
; [then-branch: 12 | !(0 <= pw@19@09[i@28@09])]
(assert (not (<= 0 (Seq_index pw@19@09 i@28@09))))
(pop) ; 7
(push) ; 7
; [else-branch: 12 | 0 <= pw@19@09[i@28@09]]
(assert (<= 0 (Seq_index pw@19@09 i@28@09)))
; [eval] pw[i] <= right
; [eval] pw[i]
(push) ; 8
(assert (not (>= i@28@09 0)))
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
  (<= 0 (Seq_index pw@19@09 i@28@09))
  (not (<= 0 (Seq_index pw@19@09 i@28@09)))))
(pop) ; 5
(push) ; 5
; [else-branch: 11 | !(0 <= i@28@09 && i@28@09 < |pw@19@09|)]
(assert (not (and (<= 0 i@28@09) (< i@28@09 (Seq_length pw@19@09)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (=>
  (and (<= 0 i@28@09) (< i@28@09 (Seq_length pw@19@09)))
  (and
    (<= 0 i@28@09)
    (< i@28@09 (Seq_length pw@19@09))
    (or
      (<= 0 (Seq_index pw@19@09 i@28@09))
      (not (<= 0 (Seq_index pw@19@09 i@28@09)))))))
; Joined path conditions
(assert (or
  (not (and (<= 0 i@28@09) (< i@28@09 (Seq_length pw@19@09))))
  (and (<= 0 i@28@09) (< i@28@09 (Seq_length pw@19@09)))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@28@09 Int)) (!
  (and
    (or (<= 0 i@28@09) (not (<= 0 i@28@09)))
    (=>
      (and (<= 0 i@28@09) (< i@28@09 (Seq_length pw@19@09)))
      (and
        (<= 0 i@28@09)
        (< i@28@09 (Seq_length pw@19@09))
        (or
          (<= 0 (Seq_index pw@19@09 i@28@09))
          (not (<= 0 (Seq_index pw@19@09 i@28@09))))))
    (or
      (not (and (<= 0 i@28@09) (< i@28@09 (Seq_length pw@19@09))))
      (and (<= 0 i@28@09) (< i@28@09 (Seq_length pw@19@09)))))
  :pattern ((Seq_index pw@19@09 i@28@09))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec_index-shifting.vpr@148@11@148@82-aux|)))
(assert (forall ((i@28@09 Int)) (!
  (=>
    (and (<= 0 i@28@09) (< i@28@09 (Seq_length pw@19@09)))
    (and
      (<= 0 (Seq_index pw@19@09 i@28@09))
      (<= (Seq_index pw@19@09 i@28@09) 10)))
  :pattern ((Seq_index pw@19@09 i@28@09))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec_index-shifting.vpr@148@11@148@82|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09)))))))))
  $Snap.unit))
; [eval] (forall i: Int, j: Int :: { pw[i], pw[j] } 0 <= i && (i < j && j < |pw|) ==> pw[i] != pw[j])
(declare-const i@29@09 Int)
(declare-const j@30@09 Int)
(push) ; 3
; [eval] 0 <= i && (i < j && j < |pw|) ==> pw[i] != pw[j]
; [eval] 0 <= i && (i < j && j < |pw|)
; [eval] 0 <= i
(push) ; 4
; [then-branch: 13 | !(0 <= i@29@09) | live]
; [else-branch: 13 | 0 <= i@29@09 | live]
(push) ; 5
; [then-branch: 13 | !(0 <= i@29@09)]
(assert (not (<= 0 i@29@09)))
(pop) ; 5
(push) ; 5
; [else-branch: 13 | 0 <= i@29@09]
(assert (<= 0 i@29@09))
; [eval] i < j
(push) ; 6
; [then-branch: 14 | !(i@29@09 < j@30@09) | live]
; [else-branch: 14 | i@29@09 < j@30@09 | live]
(push) ; 7
; [then-branch: 14 | !(i@29@09 < j@30@09)]
(assert (not (< i@29@09 j@30@09)))
(pop) ; 7
(push) ; 7
; [else-branch: 14 | i@29@09 < j@30@09]
(assert (< i@29@09 j@30@09))
; [eval] j < |pw|
; [eval] |pw|
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (< i@29@09 j@30@09) (not (< i@29@09 j@30@09))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (=>
  (<= 0 i@29@09)
  (and (<= 0 i@29@09) (or (< i@29@09 j@30@09) (not (< i@29@09 j@30@09))))))
(assert (or (<= 0 i@29@09) (not (<= 0 i@29@09))))
(push) ; 4
; [then-branch: 15 | 0 <= i@29@09 && i@29@09 < j@30@09 && j@30@09 < |pw@19@09| | live]
; [else-branch: 15 | !(0 <= i@29@09 && i@29@09 < j@30@09 && j@30@09 < |pw@19@09|) | live]
(push) ; 5
; [then-branch: 15 | 0 <= i@29@09 && i@29@09 < j@30@09 && j@30@09 < |pw@19@09|]
(assert (and (<= 0 i@29@09) (and (< i@29@09 j@30@09) (< j@30@09 (Seq_length pw@19@09)))))
; [eval] pw[i] != pw[j]
; [eval] pw[i]
(push) ; 6
(assert (not (>= i@29@09 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (< i@29@09 (Seq_length pw@19@09))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] pw[j]
(push) ; 6
(assert (not (>= j@30@09 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 15 | !(0 <= i@29@09 && i@29@09 < j@30@09 && j@30@09 < |pw@19@09|)]
(assert (not
  (and
    (<= 0 i@29@09)
    (and (< i@29@09 j@30@09) (< j@30@09 (Seq_length pw@19@09))))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (=>
  (and
    (<= 0 i@29@09)
    (and (< i@29@09 j@30@09) (< j@30@09 (Seq_length pw@19@09))))
  (and (<= 0 i@29@09) (< i@29@09 j@30@09) (< j@30@09 (Seq_length pw@19@09)))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= 0 i@29@09)
      (and (< i@29@09 j@30@09) (< j@30@09 (Seq_length pw@19@09)))))
  (and
    (<= 0 i@29@09)
    (and (< i@29@09 j@30@09) (< j@30@09 (Seq_length pw@19@09))))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@29@09 Int) (j@30@09 Int)) (!
  (and
    (=>
      (<= 0 i@29@09)
      (and (<= 0 i@29@09) (or (< i@29@09 j@30@09) (not (< i@29@09 j@30@09)))))
    (or (<= 0 i@29@09) (not (<= 0 i@29@09)))
    (=>
      (and
        (<= 0 i@29@09)
        (and (< i@29@09 j@30@09) (< j@30@09 (Seq_length pw@19@09))))
      (and (<= 0 i@29@09) (< i@29@09 j@30@09) (< j@30@09 (Seq_length pw@19@09))))
    (or
      (not
        (and
          (<= 0 i@29@09)
          (and (< i@29@09 j@30@09) (< j@30@09 (Seq_length pw@19@09)))))
      (and
        (<= 0 i@29@09)
        (and (< i@29@09 j@30@09) (< j@30@09 (Seq_length pw@19@09))))))
  :pattern ((Seq_index pw@19@09 i@29@09) (Seq_index pw@19@09 j@30@09))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec_index-shifting.vpr@149@11@149@82-aux|)))
(assert (forall ((i@29@09 Int) (j@30@09 Int)) (!
  (=>
    (and
      (<= 0 i@29@09)
      (and (< i@29@09 j@30@09) (< j@30@09 (Seq_length pw@19@09))))
    (not (= (Seq_index pw@19@09 i@29@09) (Seq_index pw@19@09 j@30@09))))
  :pattern ((Seq_index pw@19@09 i@29@09) (Seq_index pw@19@09 j@30@09))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec_index-shifting.vpr@149@11@149@82|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@20@09)))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { old(pw[i]) } 0 <= i && i < |pw| ==> loc(a, left + i).val == old(loc(a, pw[i]).val))
(declare-const i@31@09 Int)
(push) ; 3
; [eval] 0 <= i && i < |pw| ==> loc(a, left + i).val == old(loc(a, pw[i]).val)
; [eval] 0 <= i && i < |pw|
; [eval] 0 <= i
(push) ; 4
; [then-branch: 16 | !(0 <= i@31@09) | live]
; [else-branch: 16 | 0 <= i@31@09 | live]
(push) ; 5
; [then-branch: 16 | !(0 <= i@31@09)]
(assert (not (<= 0 i@31@09)))
(pop) ; 5
(push) ; 5
; [else-branch: 16 | 0 <= i@31@09]
(assert (<= 0 i@31@09))
; [eval] i < |pw|
; [eval] |pw|
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@31@09) (not (<= 0 i@31@09))))
(push) ; 4
; [then-branch: 17 | 0 <= i@31@09 && i@31@09 < |pw@19@09| | live]
; [else-branch: 17 | !(0 <= i@31@09 && i@31@09 < |pw@19@09|) | live]
(push) ; 5
; [then-branch: 17 | 0 <= i@31@09 && i@31@09 < |pw@19@09|]
(assert (and (<= 0 i@31@09) (< i@31@09 (Seq_length pw@19@09))))
; [eval] loc(a, left + i).val == old(loc(a, pw[i]).val)
; [eval] loc(a, left + i)
; [eval] left + i
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@5@09 r)
          (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
        (< $Perm.No (- $Perm.Write (pTaken@16@09 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r)))
    :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r))
    :qid |qp.fvfValDef1|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
      (=
        ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r)))
    :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r))
    :qid |qp.fvfValDef2|))))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@5@09 (loc<Ref> a@1@09 i@31@09))
        (and
          (<= 0 (inv@4@09 (loc<Ref> a@1@09 i@31@09)))
          (< (inv@4@09 (loc<Ref> a@1@09 i@31@09)) (len<Int> a@1@09))))
      (- $Perm.Write (pTaken@16@09 (loc<Ref> a@1@09 i@31@09)))
      $Perm.No)
    (ite
      (and
        (img@23@09 (loc<Ref> a@1@09 i@31@09))
        (and
          (<= 0 (inv@22@09 (loc<Ref> a@1@09 i@31@09)))
          (<= (inv@22@09 (loc<Ref> a@1@09 i@31@09)) 10)))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, pw[i]).val)
; [eval] loc(a, pw[i])
; [eval] pw[i]
(push) ; 6
(assert (not (>= i@31@09 0)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
(assert (not (and
  (img@5@09 (loc<Ref> a@1@09 (Seq_index pw@19@09 i@31@09)))
  (and
    (<= 0 (inv@4@09 (loc<Ref> a@1@09 (Seq_index pw@19@09 i@31@09))))
    (<
      (inv@4@09 (loc<Ref> a@1@09 (Seq_index pw@19@09 i@31@09)))
      (len<Int> a@1@09))))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 17 | !(0 <= i@31@09 && i@31@09 < |pw@19@09|)]
(assert (not (and (<= 0 i@31@09) (< i@31@09 (Seq_length pw@19@09)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@5@09 r)
        (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
      (< $Perm.No (- $Perm.Write (pTaken@16@09 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r)))
  :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r))
  :qid |qp.fvfValDef1|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
    (=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r)))
  :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r))
  :qid |qp.fvfValDef2|)))
; Joined path conditions
(assert (or
  (not (and (<= 0 i@31@09) (< i@31@09 (Seq_length pw@19@09))))
  (and (<= 0 i@31@09) (< i@31@09 (Seq_length pw@19@09)))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@5@09 r)
        (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
      (< $Perm.No (- $Perm.Write (pTaken@16@09 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r)))
  :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r))
  :qid |qp.fvfValDef1|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
    (=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r)))
  :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r))
  :qid |qp.fvfValDef2|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@31@09 Int)) (!
  (and
    (or (<= 0 i@31@09) (not (<= 0 i@31@09)))
    (or
      (not (and (<= 0 i@31@09) (< i@31@09 (Seq_length pw@19@09))))
      (and (<= 0 i@31@09) (< i@31@09 (Seq_length pw@19@09)))))
  :pattern ((Seq_index pw@19@09 i@31@09))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec_index-shifting.vpr@151@11@151@32-aux|)))
(assert (forall ((i@31@09 Int)) (!
  (=>
    (and (<= 0 i@31@09) (< i@31@09 (Seq_length pw@19@09)))
    (=
      ($FVF.lookup_val (as sm@25@09  $FVF<val>) (loc<Ref> a@1@09 i@31@09))
      ($FVF.lookup_val (as sm@17@09  $FVF<val>) (loc<Ref> a@1@09 (Seq_index
        pw@19@09
        i@31@09)))))
  :pattern ((Seq_index pw@19@09 i@31@09))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/quickselect/arrays_quickselect_rec_index-shifting.vpr@151@11@151@32|)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
; [exec]
; assert storeIndex == 3
; [eval] storeIndex == 3
; [exec]
; assert loc(a, storeIndex).val == old(loc(a, pw[storeIndex]).val)
; [eval] loc(a, storeIndex).val == old(loc(a, pw[storeIndex]).val)
; [eval] loc(a, storeIndex)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and
          (img@5@09 r)
          (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
        (< $Perm.No (- $Perm.Write (pTaken@16@09 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r)))
    :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@09))) r))
    :qid |qp.fvfValDef1|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
      (=
        ($FVF.lookup_val (as sm@25@09  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r)))
    :pattern (($FVF.lookup_val (as sm@25@09  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@20@09)))) r))
    :qid |qp.fvfValDef2|))))
(set-option :timeout 0)
(push) ; 3
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@5@09 (loc<Ref> a@1@09 storeIndex@18@09))
        (and
          (<= 0 (inv@4@09 (loc<Ref> a@1@09 storeIndex@18@09)))
          (< (inv@4@09 (loc<Ref> a@1@09 storeIndex@18@09)) (len<Int> a@1@09))))
      (- $Perm.Write (pTaken@16@09 (loc<Ref> a@1@09 storeIndex@18@09)))
      $Perm.No)
    (ite
      (and
        (img@23@09 (loc<Ref> a@1@09 storeIndex@18@09))
        (and
          (<= 0 (inv@22@09 (loc<Ref> a@1@09 storeIndex@18@09)))
          (<= (inv@22@09 (loc<Ref> a@1@09 storeIndex@18@09)) 10)))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, pw[storeIndex]).val)
; [eval] loc(a, pw[storeIndex])
; [eval] pw[storeIndex]
(push) ; 3
(assert (not (>= storeIndex@18@09 0)))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(push) ; 3
(assert (not (< storeIndex@18@09 (Seq_length pw@19@09))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(push) ; 3
(assert (not (and
  (img@5@09 (loc<Ref> a@1@09 (Seq_index pw@19@09 storeIndex@18@09)))
  (and
    (<= 0 (inv@4@09 (loc<Ref> a@1@09 (Seq_index pw@19@09 storeIndex@18@09))))
    (<
      (inv@4@09 (loc<Ref> a@1@09 (Seq_index pw@19@09 storeIndex@18@09)))
      (len<Int> a@1@09))))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(push) ; 3
(assert (not (=
  ($FVF.lookup_val (as sm@25@09  $FVF<val>) (loc<Ref> a@1@09 storeIndex@18@09))
  ($FVF.lookup_val (as sm@17@09  $FVF<val>) (loc<Ref> a@1@09 (Seq_index
    pw@19@09
    storeIndex@18@09))))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($FVF.lookup_val (as sm@25@09  $FVF<val>) (loc<Ref> a@1@09 storeIndex@18@09))
  ($FVF.lookup_val (as sm@17@09  $FVF<val>) (loc<Ref> a@1@09 (Seq_index
    pw@19@09
    storeIndex@18@09)))))
; [exec]
; assert old(loc(a, 0).val) == 0
; [eval] old(loc(a, 0).val) == 0
; [eval] old(loc(a, 0).val)
; [eval] loc(a, 0)
(push) ; 3
(assert (not (and
  (img@5@09 (loc<Ref> a@1@09 0))
  (and
    (<= 0 (inv@4@09 (loc<Ref> a@1@09 0)))
    (< (inv@4@09 (loc<Ref> a@1@09 0)) (len<Int> a@1@09))))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(push) ; 3
(assert (not (= ($FVF.lookup_val (as sm@17@09  $FVF<val>) (loc<Ref> a@1@09 0)) 0)))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (= ($FVF.lookup_val (as sm@17@09  $FVF<val>) (loc<Ref> a@1@09 0)) 0))
; [exec]
; assert old(loc(a, 3).val) == 3
; [eval] old(loc(a, 3).val) == 3
; [eval] old(loc(a, 3).val)
; [eval] loc(a, 3)
(push) ; 3
(assert (not (and
  (img@5@09 (loc<Ref> a@1@09 3))
  (and
    (<= 0 (inv@4@09 (loc<Ref> a@1@09 3)))
    (< (inv@4@09 (loc<Ref> a@1@09 3)) (len<Int> a@1@09))))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(push) ; 3
(assert (not (= ($FVF.lookup_val (as sm@17@09  $FVF<val>) (loc<Ref> a@1@09 3)) 3)))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (= ($FVF.lookup_val (as sm@17@09  $FVF<val>) (loc<Ref> a@1@09 3)) 3))
; [exec]
; assert old(loc(a, 2).val) != old(loc(a, 3).val)
; [eval] old(loc(a, 2).val) != old(loc(a, 3).val)
; [eval] old(loc(a, 2).val)
; [eval] loc(a, 2)
(push) ; 3
(assert (not (and
  (img@5@09 (loc<Ref> a@1@09 2))
  (and
    (<= 0 (inv@4@09 (loc<Ref> a@1@09 2)))
    (< (inv@4@09 (loc<Ref> a@1@09 2)) (len<Int> a@1@09))))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, 3).val)
; [eval] loc(a, 3)
(push) ; 3
(assert (not (and
  (img@5@09 (loc<Ref> a@1@09 3))
  (and
    (<= 0 (inv@4@09 (loc<Ref> a@1@09 3)))
    (< (inv@4@09 (loc<Ref> a@1@09 3)) (len<Int> a@1@09))))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(push) ; 3
(assert (not (not
  (=
    ($FVF.lookup_val (as sm@17@09  $FVF<val>) (loc<Ref> a@1@09 2))
    ($FVF.lookup_val (as sm@17@09  $FVF<val>) (loc<Ref> a@1@09 3))))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (not
  (=
    ($FVF.lookup_val (as sm@17@09  $FVF<val>) (loc<Ref> a@1@09 2))
    ($FVF.lookup_val (as sm@17@09  $FVF<val>) (loc<Ref> a@1@09 3)))))
(declare-const i@32@09 Int)
(push) ; 3
; [eval] 0 <= i && i < len(a)
; [eval] 0 <= i
(push) ; 4
; [then-branch: 18 | !(0 <= i@32@09) | live]
; [else-branch: 18 | 0 <= i@32@09 | live]
(push) ; 5
; [then-branch: 18 | !(0 <= i@32@09)]
(assert (not (<= 0 i@32@09)))
(pop) ; 5
(push) ; 5
; [else-branch: 18 | 0 <= i@32@09]
(assert (<= 0 i@32@09))
; [eval] i < len(a)
; [eval] len(a)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@32@09) (not (<= 0 i@32@09))))
(assert (and (<= 0 i@32@09) (< i@32@09 (len<Int> a@1@09))))
; [eval] loc(a, i)
(pop) ; 3
(declare-fun inv@33@09 ($Ref) Int)
(declare-fun img@34@09 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@32@09 Int)) (!
  (=>
    (and (<= 0 i@32@09) (< i@32@09 (len<Int> a@1@09)))
    (or (<= 0 i@32@09) (not (<= 0 i@32@09))))
  :pattern ((loc<Ref> a@1@09 i@32@09))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((i1@32@09 Int) (i2@32@09 Int)) (!
  (=>
    (and
      (and (<= 0 i1@32@09) (< i1@32@09 (len<Int> a@1@09)))
      (and (<= 0 i2@32@09) (< i2@32@09 (len<Int> a@1@09)))
      (= (loc<Ref> a@1@09 i1@32@09) (loc<Ref> a@1@09 i2@32@09)))
    (= i1@32@09 i2@32@09))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@32@09 Int)) (!
  (=>
    (and (<= 0 i@32@09) (< i@32@09 (len<Int> a@1@09)))
    (and
      (= (inv@33@09 (loc<Ref> a@1@09 i@32@09)) i@32@09)
      (img@34@09 (loc<Ref> a@1@09 i@32@09))))
  :pattern ((loc<Ref> a@1@09 i@32@09))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@34@09 r)
      (and (<= 0 (inv@33@09 r)) (< (inv@33@09 r) (len<Int> a@1@09))))
    (= (loc<Ref> a@1@09 (inv@33@09 r)) r))
  :pattern ((inv@33@09 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@35@09 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= 0 (inv@33@09 r)) (< (inv@33@09 r) (len<Int> a@1@09)))
      (img@34@09 r)
      (= r (loc<Ref> a@1@09 (inv@33@09 r))))
    ($Perm.min
      (ite
        (and
          (img@5@09 r)
          (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
        (- $Perm.Write (pTaken@16@09 r))
        $Perm.No)
      $Perm.Write)
    $Perm.No))
(define-fun pTaken@36@09 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= 0 (inv@33@09 r)) (< (inv@33@09 r) (len<Int> a@1@09)))
      (img@34@09 r)
      (= r (loc<Ref> a@1@09 (inv@33@09 r))))
    ($Perm.min
      (ite
        (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
        $Perm.Write
        $Perm.No)
      (- $Perm.Write (pTaken@35@09 r)))
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
          (img@5@09 r)
          (and (<= 0 (inv@4@09 r)) (< (inv@4@09 r) (len<Int> a@1@09))))
        (- $Perm.Write (pTaken@16@09 r))
        $Perm.No)
      (pTaken@35@09 r))
    $Perm.No)
  
  :qid |quant-u-46|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and (<= 0 (inv@33@09 r)) (< (inv@33@09 r) (len<Int> a@1@09)))
      (img@34@09 r)
      (= r (loc<Ref> a@1@09 (inv@33@09 r))))
    (= (- $Perm.Write (pTaken@35@09 r)) $Perm.No))
  
  :qid |quant-u-47|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and (img@23@09 r) (and (<= 0 (inv@22@09 r)) (<= (inv@22@09 r) 10)))
        $Perm.Write
        $Perm.No)
      (pTaken@36@09 r))
    $Perm.No)
  
  :qid |quant-u-48|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and (<= 0 (inv@33@09 r)) (< (inv@33@09 r) (len<Int> a@1@09)))
      (img@34@09 r)
      (= r (loc<Ref> a@1@09 (inv@33@09 r))))
    (= (- (- $Perm.Write (pTaken@35@09 r)) (pTaken@36@09 r)) $Perm.No))
  
  :qid |quant-u-49|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
; Definitional axioms for snapshot map values
(pop) ; 2
(pop) ; 1
