(get-info :version)
; (:version "4.13.0")
; Started: 2024-09-24 15:23:34
; Silicon.version: 1.1-SNAPSHOT (b737e366)
; Input file: /Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr
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
; Snapshot variable to be used during function verification
(declare-fun s@$ () $Snap)
; Declaring predicate trigger functions
; ////////// Uniqueness assumptions from domains
; ////////// Axioms
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
  :qid |prog.len_nonneg|)))
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
; End function- and predicate-related preamble
; ------------------------------------------------------------
; ---------- max ----------
(declare-const a@0@12 IArray)
(declare-const x@1@12 Int)
(declare-const a@2@12 IArray)
(declare-const x@3@12 Int)
(set-option :timeout 0)
(push) ; 1
(declare-const j@4@12 Int)
(push) ; 2
; [eval] 0 <= j && j < len(a)
; [eval] 0 <= j
(push) ; 3
; [then-branch: 0 | !(0 <= j@4@12) | live]
; [else-branch: 0 | 0 <= j@4@12 | live]
(push) ; 4
; [then-branch: 0 | !(0 <= j@4@12)]
(assert (not (<= 0 j@4@12)))
(pop) ; 4
(push) ; 4
; [else-branch: 0 | 0 <= j@4@12]
(assert (<= 0 j@4@12))
; [eval] j < len(a)
; [eval] len(a)
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j@4@12) (not (<= 0 j@4@12))))
(assert (and (<= 0 j@4@12) (< j@4@12 (len<Int> a@2@12))))
; [eval] loc(a, j)
(pop) ; 2
(declare-const $t@5@12 $FVF<val>)
(declare-fun inv@6@12 ($Ref) Int)
(declare-fun img@7@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((j@4@12 Int)) (!
  (=>
    (and (<= 0 j@4@12) (< j@4@12 (len<Int> a@2@12)))
    (or (<= 0 j@4@12) (not (<= 0 j@4@12))))
  :pattern ((loc<Ref> a@2@12 j@4@12))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 2
(assert (not (forall ((j1@4@12 Int) (j2@4@12 Int)) (!
  (=>
    (and
      (and (<= 0 j1@4@12) (< j1@4@12 (len<Int> a@2@12)))
      (and (<= 0 j2@4@12) (< j2@4@12 (len<Int> a@2@12)))
      (= (loc<Ref> a@2@12 j1@4@12) (loc<Ref> a@2@12 j2@4@12)))
    (= j1@4@12 j2@4@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 2
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((j@4@12 Int)) (!
  (=>
    (and (<= 0 j@4@12) (< j@4@12 (len<Int> a@2@12)))
    (and
      (= (inv@6@12 (loc<Ref> a@2@12 j@4@12)) j@4@12)
      (img@7@12 (loc<Ref> a@2@12 j@4@12))))
  :pattern ((loc<Ref> a@2@12 j@4@12))
  :qid |quant-u-2|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@7@12 r)
      (and (<= 0 (inv@6@12 r)) (< (inv@6@12 r) (len<Int> a@2@12))))
    (= (loc<Ref> a@2@12 (inv@6@12 r)) r))
  :pattern ((inv@6@12 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((j@4@12 Int)) (!
  (=>
    (and (<= 0 j@4@12) (< j@4@12 (len<Int> a@2@12)))
    (not (= (loc<Ref> a@2@12 j@4@12) $Ref.null)))
  :pattern ((loc<Ref> a@2@12 j@4@12))
  :qid |val-permImpliesNonNull|)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
(set-option :timeout 0)
(push) ; 2
(declare-const $t@8@12 $Snap)
(assert (= $t@8@12 ($Snap.combine ($Snap.first $t@8@12) ($Snap.second $t@8@12))))
(declare-const j$0@9@12 Int)
(push) ; 3
; [eval] 0 <= j$0 && j$0 < len(a)
; [eval] 0 <= j$0
(push) ; 4
; [then-branch: 1 | !(0 <= j$0@9@12) | live]
; [else-branch: 1 | 0 <= j$0@9@12 | live]
(push) ; 5
; [then-branch: 1 | !(0 <= j$0@9@12)]
(assert (not (<= 0 j$0@9@12)))
(pop) ; 5
(push) ; 5
; [else-branch: 1 | 0 <= j$0@9@12]
(assert (<= 0 j$0@9@12))
; [eval] j$0 < len(a)
; [eval] len(a)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$0@9@12) (not (<= 0 j$0@9@12))))
(assert (and (<= 0 j$0@9@12) (< j$0@9@12 (len<Int> a@2@12))))
; [eval] loc(a, j$0)
(pop) ; 3
(declare-fun inv@10@12 ($Ref) Int)
(declare-fun img@11@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((j$0@9@12 Int)) (!
  (=>
    (and (<= 0 j$0@9@12) (< j$0@9@12 (len<Int> a@2@12)))
    (or (<= 0 j$0@9@12) (not (<= 0 j$0@9@12))))
  :pattern ((loc<Ref> a@2@12 j$0@9@12))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((j$01@9@12 Int) (j$02@9@12 Int)) (!
  (=>
    (and
      (and (<= 0 j$01@9@12) (< j$01@9@12 (len<Int> a@2@12)))
      (and (<= 0 j$02@9@12) (< j$02@9@12 (len<Int> a@2@12)))
      (= (loc<Ref> a@2@12 j$01@9@12) (loc<Ref> a@2@12 j$02@9@12)))
    (= j$01@9@12 j$02@9@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((j$0@9@12 Int)) (!
  (=>
    (and (<= 0 j$0@9@12) (< j$0@9@12 (len<Int> a@2@12)))
    (and
      (= (inv@10@12 (loc<Ref> a@2@12 j$0@9@12)) j$0@9@12)
      (img@11@12 (loc<Ref> a@2@12 j$0@9@12))))
  :pattern ((loc<Ref> a@2@12 j$0@9@12))
  :qid |quant-u-5|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@11@12 r)
      (and (<= 0 (inv@10@12 r)) (< (inv@10@12 r) (len<Int> a@2@12))))
    (= (loc<Ref> a@2@12 (inv@10@12 r)) r))
  :pattern ((inv@10@12 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((j$0@9@12 Int)) (!
  (=>
    (and (<= 0 j$0@9@12) (< j$0@9@12 (len<Int> a@2@12)))
    (not (= (loc<Ref> a@2@12 j$0@9@12) $Ref.null)))
  :pattern ((loc<Ref> a@2@12 j$0@9@12))
  :qid |val-permImpliesNonNull|)))
(assert (=
  ($Snap.second $t@8@12)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@8@12))
    ($Snap.second ($Snap.second $t@8@12)))))
(assert (= ($Snap.first ($Snap.second $t@8@12)) $Snap.unit))
; [eval] (forall j$1: Int :: { old(loc(a, j$1)) } 0 <= j$1 && j$1 < len(a) ==> loc(a, j$1).val == old(loc(a, j$1).val))
(declare-const j$1@12@12 Int)
(push) ; 3
; [eval] 0 <= j$1 && j$1 < len(a) ==> loc(a, j$1).val == old(loc(a, j$1).val)
; [eval] 0 <= j$1 && j$1 < len(a)
; [eval] 0 <= j$1
(push) ; 4
; [then-branch: 2 | !(0 <= j$1@12@12) | live]
; [else-branch: 2 | 0 <= j$1@12@12 | live]
(push) ; 5
; [then-branch: 2 | !(0 <= j$1@12@12)]
(assert (not (<= 0 j$1@12@12)))
(pop) ; 5
(push) ; 5
; [else-branch: 2 | 0 <= j$1@12@12]
(assert (<= 0 j$1@12@12))
; [eval] j$1 < len(a)
; [eval] len(a)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$1@12@12) (not (<= 0 j$1@12@12))))
(push) ; 4
; [then-branch: 3 | 0 <= j$1@12@12 && j$1@12@12 < len[Int](a@2@12) | live]
; [else-branch: 3 | !(0 <= j$1@12@12 && j$1@12@12 < len[Int](a@2@12)) | live]
(push) ; 5
; [then-branch: 3 | 0 <= j$1@12@12 && j$1@12@12 < len[Int](a@2@12)]
(assert (and (<= 0 j$1@12@12) (< j$1@12@12 (len<Int> a@2@12))))
; [eval] loc(a, j$1).val == old(loc(a, j$1).val)
; [eval] loc(a, j$1)
(push) ; 6
(assert (not (and
  (img@11@12 (loc<Ref> a@2@12 j$1@12@12))
  (and
    (<= 0 (inv@10@12 (loc<Ref> a@2@12 j$1@12@12)))
    (< (inv@10@12 (loc<Ref> a@2@12 j$1@12@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, j$1).val)
; [eval] loc(a, j$1)
(push) ; 6
(assert (not (and
  (img@7@12 (loc<Ref> a@2@12 j$1@12@12))
  (and
    (<= 0 (inv@6@12 (loc<Ref> a@2@12 j$1@12@12)))
    (< (inv@6@12 (loc<Ref> a@2@12 j$1@12@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 3 | !(0 <= j$1@12@12 && j$1@12@12 < len[Int](a@2@12))]
(assert (not (and (<= 0 j$1@12@12) (< j$1@12@12 (len<Int> a@2@12)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= 0 j$1@12@12) (< j$1@12@12 (len<Int> a@2@12))))
  (and (<= 0 j$1@12@12) (< j$1@12@12 (len<Int> a@2@12)))))
; [eval] old(loc(a, j$1))
; [eval] loc(a, j$1)
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((j$1@12@12 Int)) (!
  (and
    (or (<= 0 j$1@12@12) (not (<= 0 j$1@12@12)))
    (or
      (not (and (<= 0 j$1@12@12) (< j$1@12@12 (len<Int> a@2@12))))
      (and (<= 0 j$1@12@12) (< j$1@12@12 (len<Int> a@2@12)))))
  :pattern ((loc<Ref> a@2@12 j$1@12@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@14@25@14@37-aux|)))
(assert (forall ((j$1@12@12 Int)) (!
  (=>
    (and (<= 0 j$1@12@12) (< j$1@12@12 (len<Int> a@2@12)))
    (=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@8@12)) (loc<Ref> a@2@12 j$1@12@12))
      ($FVF.lookup_val $t@5@12 (loc<Ref> a@2@12 j$1@12@12))))
  :pattern ((loc<Ref> a@2@12 j$1@12@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@14@25@14@37|)))
(assert (=
  ($Snap.second ($Snap.second $t@8@12))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@8@12)))
    ($Snap.second ($Snap.second ($Snap.second $t@8@12))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@8@12))) $Snap.unit))
; [eval] (len(a) == 0 ? x == -1 : 0 <= x && x < len(a))
; [eval] len(a) == 0
; [eval] len(a)
(push) ; 3
(push) ; 4
(set-option :timeout 10)
(assert (not (not (= (len<Int> a@2@12) 0))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 10)
(assert (not (= (len<Int> a@2@12) 0)))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; [then-branch: 4 | len[Int](a@2@12) == 0 | live]
; [else-branch: 4 | len[Int](a@2@12) != 0 | live]
(set-option :timeout 0)
(push) ; 4
; [then-branch: 4 | len[Int](a@2@12) == 0]
(assert (= (len<Int> a@2@12) 0))
; [eval] x == -1
; [eval] -1
(pop) ; 4
(push) ; 4
; [else-branch: 4 | len[Int](a@2@12) != 0]
(assert (not (= (len<Int> a@2@12) 0)))
; [eval] 0 <= x && x < len(a)
; [eval] 0 <= x
(push) ; 5
; [then-branch: 5 | !(0 <= x@3@12) | live]
; [else-branch: 5 | 0 <= x@3@12 | live]
(push) ; 6
; [then-branch: 5 | !(0 <= x@3@12)]
(assert (not (<= 0 x@3@12)))
(pop) ; 6
(push) ; 6
; [else-branch: 5 | 0 <= x@3@12]
(assert (<= 0 x@3@12))
; [eval] x < len(a)
; [eval] len(a)
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 x@3@12) (not (<= 0 x@3@12))))
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (= (len<Int> a@2@12) 0))
  (and (not (= (len<Int> a@2@12) 0)) (or (<= 0 x@3@12) (not (<= 0 x@3@12))))))
(assert (or (not (= (len<Int> a@2@12) 0)) (= (len<Int> a@2@12) 0)))
(assert (ite
  (= (len<Int> a@2@12) 0)
  (= x@3@12 (- 0 1))
  (and (<= 0 x@3@12) (< x@3@12 (len<Int> a@2@12)))))
(assert (= ($Snap.second ($Snap.second ($Snap.second $t@8@12))) $Snap.unit))
; [eval] (forall j$2: Int :: { loc(a, j$2) } 0 <= j$2 && j$2 < len(a) ==> loc(a, j$2).val <= loc(a, x).val)
(declare-const j$2@13@12 Int)
(push) ; 3
; [eval] 0 <= j$2 && j$2 < len(a) ==> loc(a, j$2).val <= loc(a, x).val
; [eval] 0 <= j$2 && j$2 < len(a)
; [eval] 0 <= j$2
(push) ; 4
; [then-branch: 6 | !(0 <= j$2@13@12) | live]
; [else-branch: 6 | 0 <= j$2@13@12 | live]
(push) ; 5
; [then-branch: 6 | !(0 <= j$2@13@12)]
(assert (not (<= 0 j$2@13@12)))
(pop) ; 5
(push) ; 5
; [else-branch: 6 | 0 <= j$2@13@12]
(assert (<= 0 j$2@13@12))
; [eval] j$2 < len(a)
; [eval] len(a)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$2@13@12) (not (<= 0 j$2@13@12))))
(push) ; 4
; [then-branch: 7 | 0 <= j$2@13@12 && j$2@13@12 < len[Int](a@2@12) | live]
; [else-branch: 7 | !(0 <= j$2@13@12 && j$2@13@12 < len[Int](a@2@12)) | live]
(push) ; 5
; [then-branch: 7 | 0 <= j$2@13@12 && j$2@13@12 < len[Int](a@2@12)]
(assert (and (<= 0 j$2@13@12) (< j$2@13@12 (len<Int> a@2@12))))
; [eval] loc(a, j$2).val <= loc(a, x).val
; [eval] loc(a, j$2)
(push) ; 6
(assert (not (and
  (img@11@12 (loc<Ref> a@2@12 j$2@13@12))
  (and
    (<= 0 (inv@10@12 (loc<Ref> a@2@12 j$2@13@12)))
    (< (inv@10@12 (loc<Ref> a@2@12 j$2@13@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, x)
(push) ; 6
(assert (not (and
  (img@11@12 (loc<Ref> a@2@12 x@3@12))
  (and
    (<= 0 (inv@10@12 (loc<Ref> a@2@12 x@3@12)))
    (< (inv@10@12 (loc<Ref> a@2@12 x@3@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 7 | !(0 <= j$2@13@12 && j$2@13@12 < len[Int](a@2@12))]
(assert (not (and (<= 0 j$2@13@12) (< j$2@13@12 (len<Int> a@2@12)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= 0 j$2@13@12) (< j$2@13@12 (len<Int> a@2@12))))
  (and (<= 0 j$2@13@12) (< j$2@13@12 (len<Int> a@2@12)))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((j$2@13@12 Int)) (!
  (and
    (or (<= 0 j$2@13@12) (not (<= 0 j$2@13@12)))
    (or
      (not (and (<= 0 j$2@13@12) (< j$2@13@12 (len<Int> a@2@12))))
      (and (<= 0 j$2@13@12) (< j$2@13@12 (len<Int> a@2@12)))))
  :pattern ((loc<Ref> a@2@12 j$2@13@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@16@12@16@32-aux|)))
(assert (forall ((j$2@13@12 Int)) (!
  (=>
    (and (<= 0 j$2@13@12) (< j$2@13@12 (len<Int> a@2@12)))
    (<=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@8@12)) (loc<Ref> a@2@12 j$2@13@12))
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@8@12)) (loc<Ref> a@2@12 x@3@12))))
  :pattern ((loc<Ref> a@2@12 j$2@13@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@16@12@16@32|)))
(pop) ; 2
(push) ; 2
; [eval] len(a) == 0
; [eval] len(a)
(push) ; 3
(set-option :timeout 10)
(assert (not (not (= (len<Int> a@2@12) 0))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 10)
(assert (not (= (len<Int> a@2@12) 0)))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; [then-branch: 8 | len[Int](a@2@12) == 0 | live]
; [else-branch: 8 | len[Int](a@2@12) != 0 | live]
(set-option :timeout 0)
(push) ; 3
; [then-branch: 8 | len[Int](a@2@12) == 0]
(assert (= (len<Int> a@2@12) 0))
; [exec]
; x := -1
; [eval] -1
(declare-const j$0@14@12 Int)
(push) ; 4
; [eval] 0 <= j$0 && j$0 < len(a)
; [eval] 0 <= j$0
(push) ; 5
; [then-branch: 9 | !(0 <= j$0@14@12) | live]
; [else-branch: 9 | 0 <= j$0@14@12 | live]
(push) ; 6
; [then-branch: 9 | !(0 <= j$0@14@12)]
(assert (not (<= 0 j$0@14@12)))
(pop) ; 6
(push) ; 6
; [else-branch: 9 | 0 <= j$0@14@12]
(assert (<= 0 j$0@14@12))
; [eval] j$0 < len(a)
; [eval] len(a)
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$0@14@12) (not (<= 0 j$0@14@12))))
(assert (and (<= 0 j$0@14@12) (< j$0@14@12 (len<Int> a@2@12))))
; [eval] loc(a, j$0)
(pop) ; 4
(declare-fun inv@15@12 ($Ref) Int)
(declare-fun img@16@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((j$0@14@12 Int)) (!
  (=>
    (and (<= 0 j$0@14@12) (< j$0@14@12 (len<Int> a@2@12)))
    (or (<= 0 j$0@14@12) (not (<= 0 j$0@14@12))))
  :pattern ((loc<Ref> a@2@12 j$0@14@12))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 4
(assert (not (forall ((j$01@14@12 Int) (j$02@14@12 Int)) (!
  (=>
    (and
      (and (<= 0 j$01@14@12) (< j$01@14@12 (len<Int> a@2@12)))
      (and (<= 0 j$02@14@12) (< j$02@14@12 (len<Int> a@2@12)))
      (= (loc<Ref> a@2@12 j$01@14@12) (loc<Ref> a@2@12 j$02@14@12)))
    (= j$01@14@12 j$02@14@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((j$0@14@12 Int)) (!
  (=>
    (and (<= 0 j$0@14@12) (< j$0@14@12 (len<Int> a@2@12)))
    (and
      (= (inv@15@12 (loc<Ref> a@2@12 j$0@14@12)) j$0@14@12)
      (img@16@12 (loc<Ref> a@2@12 j$0@14@12))))
  :pattern ((loc<Ref> a@2@12 j$0@14@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@16@12 r)
      (and (<= 0 (inv@15@12 r)) (< (inv@15@12 r) (len<Int> a@2@12))))
    (= (loc<Ref> a@2@12 (inv@15@12 r)) r))
  :pattern ((inv@15@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@17@12 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= 0 (inv@15@12 r)) (< (inv@15@12 r) (len<Int> a@2@12)))
      (img@16@12 r)
      (= r (loc<Ref> a@2@12 (inv@15@12 r))))
    ($Perm.min
      (ite
        (and
          (img@7@12 r)
          (and (<= 0 (inv@6@12 r)) (< (inv@6@12 r) (len<Int> a@2@12))))
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
          (img@7@12 r)
          (and (<= 0 (inv@6@12 r)) (< (inv@6@12 r) (len<Int> a@2@12))))
        $Perm.Write
        $Perm.No)
      (pTaken@17@12 r))
    $Perm.No)
  
  :qid |quant-u-14|))))
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
      (and (<= 0 (inv@15@12 r)) (< (inv@15@12 r) (len<Int> a@2@12)))
      (img@16@12 r)
      (= r (loc<Ref> a@2@12 (inv@15@12 r))))
    (= (- $Perm.Write (pTaken@17@12 r)) $Perm.No))
  
  :qid |quant-u-15|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@18@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@7@12 r)
      (and (<= 0 (inv@6@12 r)) (< (inv@6@12 r) (len<Int> a@2@12))))
    (= ($FVF.lookup_val (as sm@18@12  $FVF<val>) r) ($FVF.lookup_val $t@5@12 r)))
  :pattern (($FVF.lookup_val (as sm@18@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val $t@5@12 r))
  :qid |qp.fvfValDef0|)))
; [eval] (forall j$1: Int :: { old(loc(a, j$1)) } 0 <= j$1 && j$1 < len(a) ==> loc(a, j$1).val == old(loc(a, j$1).val))
(declare-const j$1@19@12 Int)
(set-option :timeout 0)
(push) ; 4
; [eval] 0 <= j$1 && j$1 < len(a) ==> loc(a, j$1).val == old(loc(a, j$1).val)
; [eval] 0 <= j$1 && j$1 < len(a)
; [eval] 0 <= j$1
(push) ; 5
; [then-branch: 10 | !(0 <= j$1@19@12) | live]
; [else-branch: 10 | 0 <= j$1@19@12 | live]
(push) ; 6
; [then-branch: 10 | !(0 <= j$1@19@12)]
(assert (not (<= 0 j$1@19@12)))
(pop) ; 6
(push) ; 6
; [else-branch: 10 | 0 <= j$1@19@12]
(assert (<= 0 j$1@19@12))
; [eval] j$1 < len(a)
; [eval] len(a)
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$1@19@12) (not (<= 0 j$1@19@12))))
(push) ; 5
; [then-branch: 11 | 0 <= j$1@19@12 && j$1@19@12 < len[Int](a@2@12) | live]
; [else-branch: 11 | !(0 <= j$1@19@12 && j$1@19@12 < len[Int](a@2@12)) | live]
(push) ; 6
; [then-branch: 11 | 0 <= j$1@19@12 && j$1@19@12 < len[Int](a@2@12)]
(assert (and (<= 0 j$1@19@12) (< j$1@19@12 (len<Int> a@2@12))))
; [eval] loc(a, j$1).val == old(loc(a, j$1).val)
; [eval] loc(a, j$1)
(push) ; 7
(assert (not (and
  (img@7@12 (loc<Ref> a@2@12 j$1@19@12))
  (and
    (<= 0 (inv@6@12 (loc<Ref> a@2@12 j$1@19@12)))
    (< (inv@6@12 (loc<Ref> a@2@12 j$1@19@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, j$1).val)
; [eval] loc(a, j$1)
(push) ; 7
(assert (not (and
  (img@7@12 (loc<Ref> a@2@12 j$1@19@12))
  (and
    (<= 0 (inv@6@12 (loc<Ref> a@2@12 j$1@19@12)))
    (< (inv@6@12 (loc<Ref> a@2@12 j$1@19@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(pop) ; 6
(push) ; 6
; [else-branch: 11 | !(0 <= j$1@19@12 && j$1@19@12 < len[Int](a@2@12))]
(assert (not (and (<= 0 j$1@19@12) (< j$1@19@12 (len<Int> a@2@12)))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= 0 j$1@19@12) (< j$1@19@12 (len<Int> a@2@12))))
  (and (<= 0 j$1@19@12) (< j$1@19@12 (len<Int> a@2@12)))))
; [eval] old(loc(a, j$1))
; [eval] loc(a, j$1)
(pop) ; 4
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((j$1@19@12 Int)) (!
  (and
    (or (<= 0 j$1@19@12) (not (<= 0 j$1@19@12)))
    (or
      (not (and (<= 0 j$1@19@12) (< j$1@19@12 (len<Int> a@2@12))))
      (and (<= 0 j$1@19@12) (< j$1@19@12 (len<Int> a@2@12)))))
  :pattern ((loc<Ref> a@2@12 j$1@19@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@14@25@14@37-aux|)))
; [eval] (len(a) == 0 ? x == -1 : 0 <= x && x < len(a))
; [eval] len(a) == 0
; [eval] len(a)
(push) ; 4
(push) ; 5
(set-option :timeout 10)
(assert (not (not (= (len<Int> a@2@12) 0))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [then-branch: 12 | len[Int](a@2@12) == 0 | live]
; [else-branch: 12 | len[Int](a@2@12) != 0 | dead]
(set-option :timeout 0)
(push) ; 5
; [then-branch: 12 | len[Int](a@2@12) == 0]
; [eval] x == -1
; [eval] -1
(pop) ; 5
(pop) ; 4
; Joined path conditions
; [eval] (forall j$2: Int :: { loc(a, j$2) } 0 <= j$2 && j$2 < len(a) ==> loc(a, j$2).val <= loc(a, x).val)
(declare-const j$2@20@12 Int)
(push) ; 4
; [eval] 0 <= j$2 && j$2 < len(a) ==> loc(a, j$2).val <= loc(a, x).val
; [eval] 0 <= j$2 && j$2 < len(a)
; [eval] 0 <= j$2
(push) ; 5
; [then-branch: 13 | !(0 <= j$2@20@12) | live]
; [else-branch: 13 | 0 <= j$2@20@12 | live]
(push) ; 6
; [then-branch: 13 | !(0 <= j$2@20@12)]
(assert (not (<= 0 j$2@20@12)))
(pop) ; 6
(push) ; 6
; [else-branch: 13 | 0 <= j$2@20@12]
(assert (<= 0 j$2@20@12))
; [eval] j$2 < len(a)
; [eval] len(a)
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$2@20@12) (not (<= 0 j$2@20@12))))
(push) ; 5
; [then-branch: 14 | 0 <= j$2@20@12 && j$2@20@12 < len[Int](a@2@12) | live]
; [else-branch: 14 | !(0 <= j$2@20@12 && j$2@20@12 < len[Int](a@2@12)) | live]
(push) ; 6
; [then-branch: 14 | 0 <= j$2@20@12 && j$2@20@12 < len[Int](a@2@12)]
(assert (and (<= 0 j$2@20@12) (< j$2@20@12 (len<Int> a@2@12))))
; [eval] loc(a, j$2).val <= loc(a, x).val
; [eval] loc(a, j$2)
(push) ; 7
(assert (not (and
  (img@7@12 (loc<Ref> a@2@12 j$2@20@12))
  (and
    (<= 0 (inv@6@12 (loc<Ref> a@2@12 j$2@20@12)))
    (< (inv@6@12 (loc<Ref> a@2@12 j$2@20@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, x)
(push) ; 7
(assert (not (and
  (img@7@12 (loc<Ref> a@2@12 (- 0 1)))
  (and
    (<= 0 (inv@6@12 (loc<Ref> a@2@12 (- 0 1))))
    (< (inv@6@12 (loc<Ref> a@2@12 (- 0 1))) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(pop) ; 6
(push) ; 6
; [else-branch: 14 | !(0 <= j$2@20@12 && j$2@20@12 < len[Int](a@2@12))]
(assert (not (and (<= 0 j$2@20@12) (< j$2@20@12 (len<Int> a@2@12)))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= 0 j$2@20@12) (< j$2@20@12 (len<Int> a@2@12))))
  (and (<= 0 j$2@20@12) (< j$2@20@12 (len<Int> a@2@12)))))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((j$2@20@12 Int)) (!
  (and
    (or (<= 0 j$2@20@12) (not (<= 0 j$2@20@12)))
    (or
      (not (and (<= 0 j$2@20@12) (< j$2@20@12 (len<Int> a@2@12))))
      (and (<= 0 j$2@20@12) (< j$2@20@12 (len<Int> a@2@12)))))
  :pattern ((loc<Ref> a@2@12 j$2@20@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@16@12@16@32-aux|)))
(push) ; 4
(assert (not (forall ((j$2@20@12 Int)) (!
  (=>
    (and (<= 0 j$2@20@12) (< j$2@20@12 (len<Int> a@2@12)))
    (<=
      ($FVF.lookup_val (as sm@18@12  $FVF<val>) (loc<Ref> a@2@12 j$2@20@12))
      ($FVF.lookup_val (as sm@18@12  $FVF<val>) (loc<Ref> a@2@12 (- 0 1)))))
  :pattern ((loc<Ref> a@2@12 j$2@20@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@16@12@16@32|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (forall ((j$2@20@12 Int)) (!
  (=>
    (and (<= 0 j$2@20@12) (< j$2@20@12 (len<Int> a@2@12)))
    (<=
      ($FVF.lookup_val (as sm@18@12  $FVF<val>) (loc<Ref> a@2@12 j$2@20@12))
      ($FVF.lookup_val (as sm@18@12  $FVF<val>) (loc<Ref> a@2@12 (- 0 1)))))
  :pattern ((loc<Ref> a@2@12 j$2@20@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@16@12@16@32|)))
(pop) ; 3
(push) ; 3
; [else-branch: 8 | len[Int](a@2@12) != 0]
(assert (not (= (len<Int> a@2@12) 0)))
(pop) ; 3
; [eval] !(len(a) == 0)
; [eval] len(a) == 0
; [eval] len(a)
(push) ; 3
(set-option :timeout 10)
(assert (not (= (len<Int> a@2@12) 0)))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 10)
(assert (not (not (= (len<Int> a@2@12) 0))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; [then-branch: 15 | len[Int](a@2@12) != 0 | live]
; [else-branch: 15 | len[Int](a@2@12) == 0 | live]
(set-option :timeout 0)
(push) ; 3
; [then-branch: 15 | len[Int](a@2@12) != 0]
(assert (not (= (len<Int> a@2@12) 0)))
; [exec]
; var y: Int
(declare-const y@21@12 Int)
; [exec]
; x := 0
; [exec]
; y := len(a) - 1
; [eval] len(a) - 1
; [eval] len(a)
(declare-const y@22@12 Int)
(assert (= y@22@12 (- (len<Int> a@2@12) 1)))
(declare-const x@23@12 Int)
(declare-const y@24@12 Int)
(push) ; 4
; Loop head block: Check well-definedness of invariant
(declare-const $t@25@12 $Snap)
(assert (= $t@25@12 ($Snap.combine ($Snap.first $t@25@12) ($Snap.second $t@25@12))))
(declare-const j$3@26@12 Int)
(push) ; 5
; [eval] 0 <= j$3 && j$3 < len(a)
; [eval] 0 <= j$3
(push) ; 6
; [then-branch: 16 | !(0 <= j$3@26@12) | live]
; [else-branch: 16 | 0 <= j$3@26@12 | live]
(push) ; 7
; [then-branch: 16 | !(0 <= j$3@26@12)]
(assert (not (<= 0 j$3@26@12)))
(pop) ; 7
(push) ; 7
; [else-branch: 16 | 0 <= j$3@26@12]
(assert (<= 0 j$3@26@12))
; [eval] j$3 < len(a)
; [eval] len(a)
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$3@26@12) (not (<= 0 j$3@26@12))))
(assert (and (<= 0 j$3@26@12) (< j$3@26@12 (len<Int> a@2@12))))
; [eval] loc(a, j$3)
(pop) ; 5
(declare-fun inv@27@12 ($Ref) Int)
(declare-fun img@28@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((j$3@26@12 Int)) (!
  (=>
    (and (<= 0 j$3@26@12) (< j$3@26@12 (len<Int> a@2@12)))
    (or (<= 0 j$3@26@12) (not (<= 0 j$3@26@12))))
  :pattern ((loc<Ref> a@2@12 j$3@26@12))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 5
(assert (not (forall ((j$31@26@12 Int) (j$32@26@12 Int)) (!
  (=>
    (and
      (and (<= 0 j$31@26@12) (< j$31@26@12 (len<Int> a@2@12)))
      (and (<= 0 j$32@26@12) (< j$32@26@12 (len<Int> a@2@12)))
      (= (loc<Ref> a@2@12 j$31@26@12) (loc<Ref> a@2@12 j$32@26@12)))
    (= j$31@26@12 j$32@26@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((j$3@26@12 Int)) (!
  (=>
    (and (<= 0 j$3@26@12) (< j$3@26@12 (len<Int> a@2@12)))
    (and
      (= (inv@27@12 (loc<Ref> a@2@12 j$3@26@12)) j$3@26@12)
      (img@28@12 (loc<Ref> a@2@12 j$3@26@12))))
  :pattern ((loc<Ref> a@2@12 j$3@26@12))
  :qid |quant-u-17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@12 r)
      (and (<= 0 (inv@27@12 r)) (< (inv@27@12 r) (len<Int> a@2@12))))
    (= (loc<Ref> a@2@12 (inv@27@12 r)) r))
  :pattern ((inv@27@12 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((j$3@26@12 Int)) (!
  (=>
    (and (<= 0 j$3@26@12) (< j$3@26@12 (len<Int> a@2@12)))
    (not (= (loc<Ref> a@2@12 j$3@26@12) $Ref.null)))
  :pattern ((loc<Ref> a@2@12 j$3@26@12))
  :qid |val-permImpliesNonNull|)))
(assert (=
  ($Snap.second $t@25@12)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@25@12))
    ($Snap.second ($Snap.second $t@25@12)))))
(assert (= ($Snap.first ($Snap.second $t@25@12)) $Snap.unit))
; [eval] (forall j$4: Int :: { old(loc(a, j$4)) } 0 <= j$4 && j$4 < len(a) ==> loc(a, j$4).val == old(loc(a, j$4).val))
(declare-const j$4@29@12 Int)
(push) ; 5
; [eval] 0 <= j$4 && j$4 < len(a) ==> loc(a, j$4).val == old(loc(a, j$4).val)
; [eval] 0 <= j$4 && j$4 < len(a)
; [eval] 0 <= j$4
(push) ; 6
; [then-branch: 17 | !(0 <= j$4@29@12) | live]
; [else-branch: 17 | 0 <= j$4@29@12 | live]
(push) ; 7
; [then-branch: 17 | !(0 <= j$4@29@12)]
(assert (not (<= 0 j$4@29@12)))
(pop) ; 7
(push) ; 7
; [else-branch: 17 | 0 <= j$4@29@12]
(assert (<= 0 j$4@29@12))
; [eval] j$4 < len(a)
; [eval] len(a)
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$4@29@12) (not (<= 0 j$4@29@12))))
(push) ; 6
; [then-branch: 18 | 0 <= j$4@29@12 && j$4@29@12 < len[Int](a@2@12) | live]
; [else-branch: 18 | !(0 <= j$4@29@12 && j$4@29@12 < len[Int](a@2@12)) | live]
(push) ; 7
; [then-branch: 18 | 0 <= j$4@29@12 && j$4@29@12 < len[Int](a@2@12)]
(assert (and (<= 0 j$4@29@12) (< j$4@29@12 (len<Int> a@2@12))))
; [eval] loc(a, j$4).val == old(loc(a, j$4).val)
; [eval] loc(a, j$4)
(push) ; 8
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 j$4@29@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 j$4@29@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 j$4@29@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, j$4).val)
; [eval] loc(a, j$4)
(push) ; 8
(assert (not (and
  (img@7@12 (loc<Ref> a@2@12 j$4@29@12))
  (and
    (<= 0 (inv@6@12 (loc<Ref> a@2@12 j$4@29@12)))
    (< (inv@6@12 (loc<Ref> a@2@12 j$4@29@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 18 | !(0 <= j$4@29@12 && j$4@29@12 < len[Int](a@2@12))]
(assert (not (and (<= 0 j$4@29@12) (< j$4@29@12 (len<Int> a@2@12)))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= 0 j$4@29@12) (< j$4@29@12 (len<Int> a@2@12))))
  (and (<= 0 j$4@29@12) (< j$4@29@12 (len<Int> a@2@12)))))
; [eval] old(loc(a, j$4))
; [eval] loc(a, j$4)
(pop) ; 5
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((j$4@29@12 Int)) (!
  (and
    (or (<= 0 j$4@29@12) (not (<= 0 j$4@29@12)))
    (or
      (not (and (<= 0 j$4@29@12) (< j$4@29@12 (len<Int> a@2@12))))
      (and (<= 0 j$4@29@12) (< j$4@29@12 (len<Int> a@2@12)))))
  :pattern ((loc<Ref> a@2@12 j$4@29@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@26@30@26@42-aux|)))
(assert (forall ((j$4@29@12 Int)) (!
  (=>
    (and (<= 0 j$4@29@12) (< j$4@29@12 (len<Int> a@2@12)))
    (=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 j$4@29@12))
      ($FVF.lookup_val $t@5@12 (loc<Ref> a@2@12 j$4@29@12))))
  :pattern ((loc<Ref> a@2@12 j$4@29@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@26@30@26@42|)))
(assert (=
  ($Snap.second ($Snap.second $t@25@12))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@25@12)))
    ($Snap.second ($Snap.second ($Snap.second $t@25@12))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@25@12))) $Snap.unit))
; [eval] 0 <= x
(assert (<= 0 x@23@12))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@25@12)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@25@12))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@25@12)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@25@12))))
  $Snap.unit))
; [eval] x <= y
(assert (<= x@23@12 y@24@12))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@25@12))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@25@12)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@25@12))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@25@12)))))
  $Snap.unit))
; [eval] y < len(a)
; [eval] len(a)
(assert (< y@24@12 (len<Int> a@2@12)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@25@12)))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val < loc(a, x).val) || (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val <= loc(a, y).val)
; [eval] (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val < loc(a, x).val)
(declare-const i@30@12 Int)
(push) ; 5
; [eval] 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val < loc(a, x).val
; [eval] 0 <= i && i < x || y < i && i < len(a)
; [eval] 0 <= i && i < x
; [eval] 0 <= i
(push) ; 6
; [then-branch: 19 | !(0 <= i@30@12) | live]
; [else-branch: 19 | 0 <= i@30@12 | live]
(push) ; 7
; [then-branch: 19 | !(0 <= i@30@12)]
(assert (not (<= 0 i@30@12)))
(pop) ; 7
(push) ; 7
; [else-branch: 19 | 0 <= i@30@12]
(assert (<= 0 i@30@12))
; [eval] i < x
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@30@12) (not (<= 0 i@30@12))))
(push) ; 6
; [then-branch: 20 | 0 <= i@30@12 && i@30@12 < x@23@12 | live]
; [else-branch: 20 | !(0 <= i@30@12 && i@30@12 < x@23@12) | live]
(push) ; 7
; [then-branch: 20 | 0 <= i@30@12 && i@30@12 < x@23@12]
(assert (and (<= 0 i@30@12) (< i@30@12 x@23@12)))
(pop) ; 7
(push) ; 7
; [else-branch: 20 | !(0 <= i@30@12 && i@30@12 < x@23@12)]
(assert (not (and (<= 0 i@30@12) (< i@30@12 x@23@12))))
; [eval] y < i && i < len(a)
; [eval] y < i
(push) ; 8
; [then-branch: 21 | !(y@24@12 < i@30@12) | live]
; [else-branch: 21 | y@24@12 < i@30@12 | live]
(push) ; 9
; [then-branch: 21 | !(y@24@12 < i@30@12)]
(assert (not (< y@24@12 i@30@12)))
(pop) ; 9
(push) ; 9
; [else-branch: 21 | y@24@12 < i@30@12]
(assert (< y@24@12 i@30@12))
; [eval] i < len(a)
; [eval] len(a)
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or (< y@24@12 i@30@12) (not (< y@24@12 i@30@12))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (and (<= 0 i@30@12) (< i@30@12 x@23@12)))
  (and
    (not (and (<= 0 i@30@12) (< i@30@12 x@23@12)))
    (or (< y@24@12 i@30@12) (not (< y@24@12 i@30@12))))))
(assert (or
  (not (and (<= 0 i@30@12) (< i@30@12 x@23@12)))
  (and (<= 0 i@30@12) (< i@30@12 x@23@12))))
(push) ; 6
; [then-branch: 22 | 0 <= i@30@12 && i@30@12 < x@23@12 || y@24@12 < i@30@12 && i@30@12 < len[Int](a@2@12) | live]
; [else-branch: 22 | !(0 <= i@30@12 && i@30@12 < x@23@12 || y@24@12 < i@30@12 && i@30@12 < len[Int](a@2@12)) | live]
(push) ; 7
; [then-branch: 22 | 0 <= i@30@12 && i@30@12 < x@23@12 || y@24@12 < i@30@12 && i@30@12 < len[Int](a@2@12)]
(assert (or
  (and (<= 0 i@30@12) (< i@30@12 x@23@12))
  (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12)))))
; [eval] loc(a, i).val < loc(a, x).val
; [eval] loc(a, i)
(push) ; 8
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 i@30@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 i@30@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 i@30@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, x)
(push) ; 8
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 x@23@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 x@23@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 x@23@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 22 | !(0 <= i@30@12 && i@30@12 < x@23@12 || y@24@12 < i@30@12 && i@30@12 < len[Int](a@2@12))]
(assert (not
  (or
    (and (<= 0 i@30@12) (< i@30@12 x@23@12))
    (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or
  (not
    (or
      (and (<= 0 i@30@12) (< i@30@12 x@23@12))
      (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12)))))
  (or
    (and (<= 0 i@30@12) (< i@30@12 x@23@12))
    (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@30@12 Int)) (!
  (and
    (or (<= 0 i@30@12) (not (<= 0 i@30@12)))
    (=>
      (not (and (<= 0 i@30@12) (< i@30@12 x@23@12)))
      (and
        (not (and (<= 0 i@30@12) (< i@30@12 x@23@12)))
        (or (< y@24@12 i@30@12) (not (< y@24@12 i@30@12)))))
    (or
      (not (and (<= 0 i@30@12) (< i@30@12 x@23@12)))
      (and (<= 0 i@30@12) (< i@30@12 x@23@12)))
    (or
      (not
        (or
          (and (<= 0 i@30@12) (< i@30@12 x@23@12))
          (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12)))))
      (or
        (and (<= 0 i@30@12) (< i@30@12 x@23@12))
        (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))))
  :pattern ((loc<Ref> a@2@12 i@30@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56-aux|)))
(push) ; 5
; [then-branch: 23 | QA i@30@12 :: 0 <= i@30@12 && i@30@12 < x@23@12 || y@24@12 < i@30@12 && i@30@12 < len[Int](a@2@12) ==> Lookup(val, First:($t@25@12), loc[Ref](a@2@12, i@30@12)) < Lookup(val, First:($t@25@12), loc[Ref](a@2@12, x@23@12)) | live]
; [else-branch: 23 | !(QA i@30@12 :: 0 <= i@30@12 && i@30@12 < x@23@12 || y@24@12 < i@30@12 && i@30@12 < len[Int](a@2@12) ==> Lookup(val, First:($t@25@12), loc[Ref](a@2@12, i@30@12)) < Lookup(val, First:($t@25@12), loc[Ref](a@2@12, x@23@12))) | live]
(push) ; 6
; [then-branch: 23 | QA i@30@12 :: 0 <= i@30@12 && i@30@12 < x@23@12 || y@24@12 < i@30@12 && i@30@12 < len[Int](a@2@12) ==> Lookup(val, First:($t@25@12), loc[Ref](a@2@12, i@30@12)) < Lookup(val, First:($t@25@12), loc[Ref](a@2@12, x@23@12))]
(assert (forall ((i@30@12 Int)) (!
  (=>
    (or
      (and (<= 0 i@30@12) (< i@30@12 x@23@12))
      (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))
    (<
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 i@30@12))
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))))
  :pattern ((loc<Ref> a@2@12 i@30@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
(pop) ; 6
(push) ; 6
; [else-branch: 23 | !(QA i@30@12 :: 0 <= i@30@12 && i@30@12 < x@23@12 || y@24@12 < i@30@12 && i@30@12 < len[Int](a@2@12) ==> Lookup(val, First:($t@25@12), loc[Ref](a@2@12, i@30@12)) < Lookup(val, First:($t@25@12), loc[Ref](a@2@12, x@23@12)))]
(assert (not
  (forall ((i@30@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@30@12) (< i@30@12 x@23@12))
        (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 i@30@12))
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))))
    :pattern ((loc<Ref> a@2@12 i@30@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))))
; [eval] (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val <= loc(a, y).val)
(declare-const i@31@12 Int)
(push) ; 7
; [eval] 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val <= loc(a, y).val
; [eval] 0 <= i && i < x || y < i && i < len(a)
; [eval] 0 <= i && i < x
; [eval] 0 <= i
(push) ; 8
; [then-branch: 24 | !(0 <= i@31@12) | live]
; [else-branch: 24 | 0 <= i@31@12 | live]
(push) ; 9
; [then-branch: 24 | !(0 <= i@31@12)]
(assert (not (<= 0 i@31@12)))
(pop) ; 9
(push) ; 9
; [else-branch: 24 | 0 <= i@31@12]
(assert (<= 0 i@31@12))
; [eval] i < x
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@31@12) (not (<= 0 i@31@12))))
(push) ; 8
; [then-branch: 25 | 0 <= i@31@12 && i@31@12 < x@23@12 | live]
; [else-branch: 25 | !(0 <= i@31@12 && i@31@12 < x@23@12) | live]
(push) ; 9
; [then-branch: 25 | 0 <= i@31@12 && i@31@12 < x@23@12]
(assert (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
(pop) ; 9
(push) ; 9
; [else-branch: 25 | !(0 <= i@31@12 && i@31@12 < x@23@12)]
(assert (not (and (<= 0 i@31@12) (< i@31@12 x@23@12))))
; [eval] y < i && i < len(a)
; [eval] y < i
(push) ; 10
; [then-branch: 26 | !(y@24@12 < i@31@12) | live]
; [else-branch: 26 | y@24@12 < i@31@12 | live]
(push) ; 11
; [then-branch: 26 | !(y@24@12 < i@31@12)]
(assert (not (< y@24@12 i@31@12)))
(pop) ; 11
(push) ; 11
; [else-branch: 26 | y@24@12 < i@31@12]
(assert (< y@24@12 i@31@12))
; [eval] i < len(a)
; [eval] len(a)
(pop) ; 11
(pop) ; 10
; Joined path conditions
; Joined path conditions
(assert (or (< y@24@12 i@31@12) (not (< y@24@12 i@31@12))))
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
  (and
    (not (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
    (or (< y@24@12 i@31@12) (not (< y@24@12 i@31@12))))))
(assert (or
  (not (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
  (and (<= 0 i@31@12) (< i@31@12 x@23@12))))
(push) ; 8
; [then-branch: 27 | 0 <= i@31@12 && i@31@12 < x@23@12 || y@24@12 < i@31@12 && i@31@12 < len[Int](a@2@12) | live]
; [else-branch: 27 | !(0 <= i@31@12 && i@31@12 < x@23@12 || y@24@12 < i@31@12 && i@31@12 < len[Int](a@2@12)) | live]
(push) ; 9
; [then-branch: 27 | 0 <= i@31@12 && i@31@12 < x@23@12 || y@24@12 < i@31@12 && i@31@12 < len[Int](a@2@12)]
(assert (or
  (and (<= 0 i@31@12) (< i@31@12 x@23@12))
  (and (< y@24@12 i@31@12) (< i@31@12 (len<Int> a@2@12)))))
; [eval] loc(a, i).val <= loc(a, y).val
; [eval] loc(a, i)
(push) ; 10
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 i@31@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 i@31@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 i@31@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, y)
(push) ; 10
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 y@24@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 y@24@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 y@24@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 27 | !(0 <= i@31@12 && i@31@12 < x@23@12 || y@24@12 < i@31@12 && i@31@12 < len[Int](a@2@12))]
(assert (not
  (or
    (and (<= 0 i@31@12) (< i@31@12 x@23@12))
    (and (< y@24@12 i@31@12) (< i@31@12 (len<Int> a@2@12))))))
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or
  (not
    (or
      (and (<= 0 i@31@12) (< i@31@12 x@23@12))
      (and (< y@24@12 i@31@12) (< i@31@12 (len<Int> a@2@12)))))
  (or
    (and (<= 0 i@31@12) (< i@31@12 x@23@12))
    (and (< y@24@12 i@31@12) (< i@31@12 (len<Int> a@2@12))))))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@31@12 Int)) (!
  (and
    (or (<= 0 i@31@12) (not (<= 0 i@31@12)))
    (=>
      (not (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
      (and
        (not (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
        (or (< y@24@12 i@31@12) (not (< y@24@12 i@31@12)))))
    (or
      (not (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
      (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
    (or
      (not
        (or
          (and (<= 0 i@31@12) (< i@31@12 x@23@12))
          (and (< y@24@12 i@31@12) (< i@31@12 (len<Int> a@2@12)))))
      (or
        (and (<= 0 i@31@12) (< i@31@12 x@23@12))
        (and (< y@24@12 i@31@12) (< i@31@12 (len<Int> a@2@12))))))
  :pattern ((loc<Ref> a@2@12 i@31@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57-aux|)))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (=>
  (not
    (forall ((i@30@12 Int)) (!
      (=>
        (or
          (and (<= 0 i@30@12) (< i@30@12 x@23@12))
          (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))
        (<
          ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 i@30@12))
          ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))))
      :pattern ((loc<Ref> a@2@12 i@30@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
  (and
    (not
      (forall ((i@30@12 Int)) (!
        (=>
          (or
            (and (<= 0 i@30@12) (< i@30@12 x@23@12))
            (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))
          (<
            ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 i@30@12))
            ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))))
        :pattern ((loc<Ref> a@2@12 i@30@12))
        :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
    (forall ((i@31@12 Int)) (!
      (and
        (or (<= 0 i@31@12) (not (<= 0 i@31@12)))
        (=>
          (not (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
          (and
            (not (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
            (or (< y@24@12 i@31@12) (not (< y@24@12 i@31@12)))))
        (or
          (not (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
          (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
        (or
          (not
            (or
              (and (<= 0 i@31@12) (< i@31@12 x@23@12))
              (and (< y@24@12 i@31@12) (< i@31@12 (len<Int> a@2@12)))))
          (or
            (and (<= 0 i@31@12) (< i@31@12 x@23@12))
            (and (< y@24@12 i@31@12) (< i@31@12 (len<Int> a@2@12))))))
      :pattern ((loc<Ref> a@2@12 i@31@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57-aux|)))))
(assert (or
  (not
    (forall ((i@30@12 Int)) (!
      (=>
        (or
          (and (<= 0 i@30@12) (< i@30@12 x@23@12))
          (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))
        (<
          ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 i@30@12))
          ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))))
      :pattern ((loc<Ref> a@2@12 i@30@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
  (forall ((i@30@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@30@12) (< i@30@12 x@23@12))
        (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 i@30@12))
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))))
    :pattern ((loc<Ref> a@2@12 i@30@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))))
(assert (or
  (forall ((i@30@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@30@12) (< i@30@12 x@23@12))
        (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 i@30@12))
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))))
    :pattern ((loc<Ref> a@2@12 i@30@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))
  (forall ((i@31@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@31@12) (< i@31@12 x@23@12))
        (and (< y@24@12 i@31@12) (< i@31@12 (len<Int> a@2@12))))
      (<=
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 i@31@12))
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 y@24@12))))
    :pattern ((loc<Ref> a@2@12 i@31@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57|))))
(pop) ; 4
(push) ; 4
; Loop head block: Establish invariant
(declare-const j$3@32@12 Int)
(push) ; 5
; [eval] 0 <= j$3 && j$3 < len(a)
; [eval] 0 <= j$3
(push) ; 6
; [then-branch: 28 | !(0 <= j$3@32@12) | live]
; [else-branch: 28 | 0 <= j$3@32@12 | live]
(push) ; 7
; [then-branch: 28 | !(0 <= j$3@32@12)]
(assert (not (<= 0 j$3@32@12)))
(pop) ; 7
(push) ; 7
; [else-branch: 28 | 0 <= j$3@32@12]
(assert (<= 0 j$3@32@12))
; [eval] j$3 < len(a)
; [eval] len(a)
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$3@32@12) (not (<= 0 j$3@32@12))))
(assert (and (<= 0 j$3@32@12) (< j$3@32@12 (len<Int> a@2@12))))
; [eval] loc(a, j$3)
(pop) ; 5
(declare-fun inv@33@12 ($Ref) Int)
(declare-fun img@34@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((j$3@32@12 Int)) (!
  (=>
    (and (<= 0 j$3@32@12) (< j$3@32@12 (len<Int> a@2@12)))
    (or (<= 0 j$3@32@12) (not (<= 0 j$3@32@12))))
  :pattern ((loc<Ref> a@2@12 j$3@32@12))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 5
(assert (not (forall ((j$31@32@12 Int) (j$32@32@12 Int)) (!
  (=>
    (and
      (and (<= 0 j$31@32@12) (< j$31@32@12 (len<Int> a@2@12)))
      (and (<= 0 j$32@32@12) (< j$32@32@12 (len<Int> a@2@12)))
      (= (loc<Ref> a@2@12 j$31@32@12) (loc<Ref> a@2@12 j$32@32@12)))
    (= j$31@32@12 j$32@32@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((j$3@32@12 Int)) (!
  (=>
    (and (<= 0 j$3@32@12) (< j$3@32@12 (len<Int> a@2@12)))
    (and
      (= (inv@33@12 (loc<Ref> a@2@12 j$3@32@12)) j$3@32@12)
      (img@34@12 (loc<Ref> a@2@12 j$3@32@12))))
  :pattern ((loc<Ref> a@2@12 j$3@32@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@34@12 r)
      (and (<= 0 (inv@33@12 r)) (< (inv@33@12 r) (len<Int> a@2@12))))
    (= (loc<Ref> a@2@12 (inv@33@12 r)) r))
  :pattern ((inv@33@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@35@12 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= 0 (inv@33@12 r)) (< (inv@33@12 r) (len<Int> a@2@12)))
      (img@34@12 r)
      (= r (loc<Ref> a@2@12 (inv@33@12 r))))
    ($Perm.min
      (ite
        (and
          (img@7@12 r)
          (and (<= 0 (inv@6@12 r)) (< (inv@6@12 r) (len<Int> a@2@12))))
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
          (img@7@12 r)
          (and (<= 0 (inv@6@12 r)) (< (inv@6@12 r) (len<Int> a@2@12))))
        $Perm.Write
        $Perm.No)
      (pTaken@35@12 r))
    $Perm.No)
  
  :qid |quant-u-20|))))
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
      (and (<= 0 (inv@33@12 r)) (< (inv@33@12 r) (len<Int> a@2@12)))
      (img@34@12 r)
      (= r (loc<Ref> a@2@12 (inv@33@12 r))))
    (= (- $Perm.Write (pTaken@35@12 r)) $Perm.No))
  
  :qid |quant-u-21|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@36@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@7@12 r)
      (and (<= 0 (inv@6@12 r)) (< (inv@6@12 r) (len<Int> a@2@12))))
    (= ($FVF.lookup_val (as sm@36@12  $FVF<val>) r) ($FVF.lookup_val $t@5@12 r)))
  :pattern (($FVF.lookup_val (as sm@36@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val $t@5@12 r))
  :qid |qp.fvfValDef1|)))
; [eval] (forall j$4: Int :: { old(loc(a, j$4)) } 0 <= j$4 && j$4 < len(a) ==> loc(a, j$4).val == old(loc(a, j$4).val))
(declare-const j$4@37@12 Int)
(set-option :timeout 0)
(push) ; 5
; [eval] 0 <= j$4 && j$4 < len(a) ==> loc(a, j$4).val == old(loc(a, j$4).val)
; [eval] 0 <= j$4 && j$4 < len(a)
; [eval] 0 <= j$4
(push) ; 6
; [then-branch: 29 | !(0 <= j$4@37@12) | live]
; [else-branch: 29 | 0 <= j$4@37@12 | live]
(push) ; 7
; [then-branch: 29 | !(0 <= j$4@37@12)]
(assert (not (<= 0 j$4@37@12)))
(pop) ; 7
(push) ; 7
; [else-branch: 29 | 0 <= j$4@37@12]
(assert (<= 0 j$4@37@12))
; [eval] j$4 < len(a)
; [eval] len(a)
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$4@37@12) (not (<= 0 j$4@37@12))))
(push) ; 6
; [then-branch: 30 | 0 <= j$4@37@12 && j$4@37@12 < len[Int](a@2@12) | live]
; [else-branch: 30 | !(0 <= j$4@37@12 && j$4@37@12 < len[Int](a@2@12)) | live]
(push) ; 7
; [then-branch: 30 | 0 <= j$4@37@12 && j$4@37@12 < len[Int](a@2@12)]
(assert (and (<= 0 j$4@37@12) (< j$4@37@12 (len<Int> a@2@12))))
; [eval] loc(a, j$4).val == old(loc(a, j$4).val)
; [eval] loc(a, j$4)
(push) ; 8
(assert (not (and
  (img@7@12 (loc<Ref> a@2@12 j$4@37@12))
  (and
    (<= 0 (inv@6@12 (loc<Ref> a@2@12 j$4@37@12)))
    (< (inv@6@12 (loc<Ref> a@2@12 j$4@37@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, j$4).val)
; [eval] loc(a, j$4)
(push) ; 8
(assert (not (and
  (img@7@12 (loc<Ref> a@2@12 j$4@37@12))
  (and
    (<= 0 (inv@6@12 (loc<Ref> a@2@12 j$4@37@12)))
    (< (inv@6@12 (loc<Ref> a@2@12 j$4@37@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 30 | !(0 <= j$4@37@12 && j$4@37@12 < len[Int](a@2@12))]
(assert (not (and (<= 0 j$4@37@12) (< j$4@37@12 (len<Int> a@2@12)))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= 0 j$4@37@12) (< j$4@37@12 (len<Int> a@2@12))))
  (and (<= 0 j$4@37@12) (< j$4@37@12 (len<Int> a@2@12)))))
; [eval] old(loc(a, j$4))
; [eval] loc(a, j$4)
(pop) ; 5
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((j$4@37@12 Int)) (!
  (and
    (or (<= 0 j$4@37@12) (not (<= 0 j$4@37@12)))
    (or
      (not (and (<= 0 j$4@37@12) (< j$4@37@12 (len<Int> a@2@12))))
      (and (<= 0 j$4@37@12) (< j$4@37@12 (len<Int> a@2@12)))))
  :pattern ((loc<Ref> a@2@12 j$4@37@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@26@30@26@42-aux|)))
; [eval] 0 <= x
; [eval] x <= y
(push) ; 5
(assert (not (<= 0 y@22@12)))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 y@22@12))
; [eval] y < len(a)
; [eval] len(a)
(push) ; 5
(assert (not (< y@22@12 (len<Int> a@2@12))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (< y@22@12 (len<Int> a@2@12)))
; [eval] (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val < loc(a, x).val) || (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val <= loc(a, y).val)
; [eval] (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val < loc(a, x).val)
(declare-const i@38@12 Int)
(push) ; 5
; [eval] 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val < loc(a, x).val
; [eval] 0 <= i && i < x || y < i && i < len(a)
; [eval] 0 <= i && i < x
; [eval] 0 <= i
(push) ; 6
; [then-branch: 31 | !(0 <= i@38@12) | live]
; [else-branch: 31 | 0 <= i@38@12 | live]
(push) ; 7
; [then-branch: 31 | !(0 <= i@38@12)]
(assert (not (<= 0 i@38@12)))
(pop) ; 7
(push) ; 7
; [else-branch: 31 | 0 <= i@38@12]
(assert (<= 0 i@38@12))
; [eval] i < x
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@38@12) (not (<= 0 i@38@12))))
(push) ; 6
; [then-branch: 32 | 0 <= i@38@12 && i@38@12 < 0 | live]
; [else-branch: 32 | !(0 <= i@38@12 && i@38@12 < 0) | live]
(push) ; 7
; [then-branch: 32 | 0 <= i@38@12 && i@38@12 < 0]
(assert (and (<= 0 i@38@12) (< i@38@12 0)))
(pop) ; 7
(push) ; 7
; [else-branch: 32 | !(0 <= i@38@12 && i@38@12 < 0)]
(assert (not (and (<= 0 i@38@12) (< i@38@12 0))))
; [eval] y < i && i < len(a)
; [eval] y < i
(push) ; 8
; [then-branch: 33 | !(y@22@12 < i@38@12) | live]
; [else-branch: 33 | y@22@12 < i@38@12 | live]
(push) ; 9
; [then-branch: 33 | !(y@22@12 < i@38@12)]
(assert (not (< y@22@12 i@38@12)))
(pop) ; 9
(push) ; 9
; [else-branch: 33 | y@22@12 < i@38@12]
(assert (< y@22@12 i@38@12))
; [eval] i < len(a)
; [eval] len(a)
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or (< y@22@12 i@38@12) (not (< y@22@12 i@38@12))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (and (<= 0 i@38@12) (< i@38@12 0)))
  (and
    (not (and (<= 0 i@38@12) (< i@38@12 0)))
    (or (< y@22@12 i@38@12) (not (< y@22@12 i@38@12))))))
(assert (or (not (and (<= 0 i@38@12) (< i@38@12 0))) (and (<= 0 i@38@12) (< i@38@12 0))))
(push) ; 6
; [then-branch: 34 | 0 <= i@38@12 && i@38@12 < 0 || y@22@12 < i@38@12 && i@38@12 < len[Int](a@2@12) | live]
; [else-branch: 34 | !(0 <= i@38@12 && i@38@12 < 0 || y@22@12 < i@38@12 && i@38@12 < len[Int](a@2@12)) | live]
(push) ; 7
; [then-branch: 34 | 0 <= i@38@12 && i@38@12 < 0 || y@22@12 < i@38@12 && i@38@12 < len[Int](a@2@12)]
(assert (or
  (and (<= 0 i@38@12) (< i@38@12 0))
  (and (< y@22@12 i@38@12) (< i@38@12 (len<Int> a@2@12)))))
; [eval] loc(a, i).val < loc(a, x).val
; [eval] loc(a, i)
(push) ; 8
(assert (not (and
  (img@7@12 (loc<Ref> a@2@12 i@38@12))
  (and
    (<= 0 (inv@6@12 (loc<Ref> a@2@12 i@38@12)))
    (< (inv@6@12 (loc<Ref> a@2@12 i@38@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, x)
(push) ; 8
(assert (not (and
  (img@7@12 (loc<Ref> a@2@12 0))
  (and
    (<= 0 (inv@6@12 (loc<Ref> a@2@12 0)))
    (< (inv@6@12 (loc<Ref> a@2@12 0)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 34 | !(0 <= i@38@12 && i@38@12 < 0 || y@22@12 < i@38@12 && i@38@12 < len[Int](a@2@12))]
(assert (not
  (or
    (and (<= 0 i@38@12) (< i@38@12 0))
    (and (< y@22@12 i@38@12) (< i@38@12 (len<Int> a@2@12))))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or
  (not
    (or
      (and (<= 0 i@38@12) (< i@38@12 0))
      (and (< y@22@12 i@38@12) (< i@38@12 (len<Int> a@2@12)))))
  (or
    (and (<= 0 i@38@12) (< i@38@12 0))
    (and (< y@22@12 i@38@12) (< i@38@12 (len<Int> a@2@12))))))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@38@12 Int)) (!
  (and
    (or (<= 0 i@38@12) (not (<= 0 i@38@12)))
    (=>
      (not (and (<= 0 i@38@12) (< i@38@12 0)))
      (and
        (not (and (<= 0 i@38@12) (< i@38@12 0)))
        (or (< y@22@12 i@38@12) (not (< y@22@12 i@38@12)))))
    (or
      (not (and (<= 0 i@38@12) (< i@38@12 0)))
      (and (<= 0 i@38@12) (< i@38@12 0)))
    (or
      (not
        (or
          (and (<= 0 i@38@12) (< i@38@12 0))
          (and (< y@22@12 i@38@12) (< i@38@12 (len<Int> a@2@12)))))
      (or
        (and (<= 0 i@38@12) (< i@38@12 0))
        (and (< y@22@12 i@38@12) (< i@38@12 (len<Int> a@2@12))))))
  :pattern ((loc<Ref> a@2@12 i@38@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56-aux|)))
(push) ; 5
; [then-branch: 35 | QA i@38@12 :: 0 <= i@38@12 && i@38@12 < 0 || y@22@12 < i@38@12 && i@38@12 < len[Int](a@2@12) ==> Lookup(val, sm@36@12, loc[Ref](a@2@12, i@38@12)) < Lookup(val, sm@36@12, loc[Ref](a@2@12, 0)) | live]
; [else-branch: 35 | !(QA i@38@12 :: 0 <= i@38@12 && i@38@12 < 0 || y@22@12 < i@38@12 && i@38@12 < len[Int](a@2@12) ==> Lookup(val, sm@36@12, loc[Ref](a@2@12, i@38@12)) < Lookup(val, sm@36@12, loc[Ref](a@2@12, 0))) | live]
(push) ; 6
; [then-branch: 35 | QA i@38@12 :: 0 <= i@38@12 && i@38@12 < 0 || y@22@12 < i@38@12 && i@38@12 < len[Int](a@2@12) ==> Lookup(val, sm@36@12, loc[Ref](a@2@12, i@38@12)) < Lookup(val, sm@36@12, loc[Ref](a@2@12, 0))]
(assert (forall ((i@38@12 Int)) (!
  (=>
    (or
      (and (<= 0 i@38@12) (< i@38@12 0))
      (and (< y@22@12 i@38@12) (< i@38@12 (len<Int> a@2@12))))
    (<
      ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 i@38@12))
      ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 0))))
  :pattern ((loc<Ref> a@2@12 i@38@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
(pop) ; 6
(push) ; 6
; [else-branch: 35 | !(QA i@38@12 :: 0 <= i@38@12 && i@38@12 < 0 || y@22@12 < i@38@12 && i@38@12 < len[Int](a@2@12) ==> Lookup(val, sm@36@12, loc[Ref](a@2@12, i@38@12)) < Lookup(val, sm@36@12, loc[Ref](a@2@12, 0)))]
(assert (not
  (forall ((i@38@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@38@12) (< i@38@12 0))
        (and (< y@22@12 i@38@12) (< i@38@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 i@38@12))
        ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 0))))
    :pattern ((loc<Ref> a@2@12 i@38@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))))
; [eval] (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val <= loc(a, y).val)
(declare-const i@39@12 Int)
(push) ; 7
; [eval] 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val <= loc(a, y).val
; [eval] 0 <= i && i < x || y < i && i < len(a)
; [eval] 0 <= i && i < x
; [eval] 0 <= i
(push) ; 8
; [then-branch: 36 | !(0 <= i@39@12) | live]
; [else-branch: 36 | 0 <= i@39@12 | live]
(push) ; 9
; [then-branch: 36 | !(0 <= i@39@12)]
(assert (not (<= 0 i@39@12)))
(pop) ; 9
(push) ; 9
; [else-branch: 36 | 0 <= i@39@12]
(assert (<= 0 i@39@12))
; [eval] i < x
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@39@12) (not (<= 0 i@39@12))))
(push) ; 8
; [then-branch: 37 | 0 <= i@39@12 && i@39@12 < 0 | live]
; [else-branch: 37 | !(0 <= i@39@12 && i@39@12 < 0) | live]
(push) ; 9
; [then-branch: 37 | 0 <= i@39@12 && i@39@12 < 0]
(assert (and (<= 0 i@39@12) (< i@39@12 0)))
(pop) ; 9
(push) ; 9
; [else-branch: 37 | !(0 <= i@39@12 && i@39@12 < 0)]
(assert (not (and (<= 0 i@39@12) (< i@39@12 0))))
; [eval] y < i && i < len(a)
; [eval] y < i
(push) ; 10
; [then-branch: 38 | !(y@22@12 < i@39@12) | live]
; [else-branch: 38 | y@22@12 < i@39@12 | live]
(push) ; 11
; [then-branch: 38 | !(y@22@12 < i@39@12)]
(assert (not (< y@22@12 i@39@12)))
(pop) ; 11
(push) ; 11
; [else-branch: 38 | y@22@12 < i@39@12]
(assert (< y@22@12 i@39@12))
; [eval] i < len(a)
; [eval] len(a)
(pop) ; 11
(pop) ; 10
; Joined path conditions
; Joined path conditions
(assert (or (< y@22@12 i@39@12) (not (< y@22@12 i@39@12))))
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (and (<= 0 i@39@12) (< i@39@12 0)))
  (and
    (not (and (<= 0 i@39@12) (< i@39@12 0)))
    (or (< y@22@12 i@39@12) (not (< y@22@12 i@39@12))))))
(assert (or (not (and (<= 0 i@39@12) (< i@39@12 0))) (and (<= 0 i@39@12) (< i@39@12 0))))
(push) ; 8
; [then-branch: 39 | 0 <= i@39@12 && i@39@12 < 0 || y@22@12 < i@39@12 && i@39@12 < len[Int](a@2@12) | live]
; [else-branch: 39 | !(0 <= i@39@12 && i@39@12 < 0 || y@22@12 < i@39@12 && i@39@12 < len[Int](a@2@12)) | live]
(push) ; 9
; [then-branch: 39 | 0 <= i@39@12 && i@39@12 < 0 || y@22@12 < i@39@12 && i@39@12 < len[Int](a@2@12)]
(assert (or
  (and (<= 0 i@39@12) (< i@39@12 0))
  (and (< y@22@12 i@39@12) (< i@39@12 (len<Int> a@2@12)))))
; [eval] loc(a, i).val <= loc(a, y).val
; [eval] loc(a, i)
(push) ; 10
(assert (not (and
  (img@7@12 (loc<Ref> a@2@12 i@39@12))
  (and
    (<= 0 (inv@6@12 (loc<Ref> a@2@12 i@39@12)))
    (< (inv@6@12 (loc<Ref> a@2@12 i@39@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, y)
(push) ; 10
(assert (not (and
  (img@7@12 (loc<Ref> a@2@12 y@22@12))
  (and
    (<= 0 (inv@6@12 (loc<Ref> a@2@12 y@22@12)))
    (< (inv@6@12 (loc<Ref> a@2@12 y@22@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 39 | !(0 <= i@39@12 && i@39@12 < 0 || y@22@12 < i@39@12 && i@39@12 < len[Int](a@2@12))]
(assert (not
  (or
    (and (<= 0 i@39@12) (< i@39@12 0))
    (and (< y@22@12 i@39@12) (< i@39@12 (len<Int> a@2@12))))))
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or
  (not
    (or
      (and (<= 0 i@39@12) (< i@39@12 0))
      (and (< y@22@12 i@39@12) (< i@39@12 (len<Int> a@2@12)))))
  (or
    (and (<= 0 i@39@12) (< i@39@12 0))
    (and (< y@22@12 i@39@12) (< i@39@12 (len<Int> a@2@12))))))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@39@12 Int)) (!
  (and
    (or (<= 0 i@39@12) (not (<= 0 i@39@12)))
    (=>
      (not (and (<= 0 i@39@12) (< i@39@12 0)))
      (and
        (not (and (<= 0 i@39@12) (< i@39@12 0)))
        (or (< y@22@12 i@39@12) (not (< y@22@12 i@39@12)))))
    (or
      (not (and (<= 0 i@39@12) (< i@39@12 0)))
      (and (<= 0 i@39@12) (< i@39@12 0)))
    (or
      (not
        (or
          (and (<= 0 i@39@12) (< i@39@12 0))
          (and (< y@22@12 i@39@12) (< i@39@12 (len<Int> a@2@12)))))
      (or
        (and (<= 0 i@39@12) (< i@39@12 0))
        (and (< y@22@12 i@39@12) (< i@39@12 (len<Int> a@2@12))))))
  :pattern ((loc<Ref> a@2@12 i@39@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57-aux|)))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (=>
  (not
    (forall ((i@38@12 Int)) (!
      (=>
        (or
          (and (<= 0 i@38@12) (< i@38@12 0))
          (and (< y@22@12 i@38@12) (< i@38@12 (len<Int> a@2@12))))
        (<
          ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 i@38@12))
          ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 0))))
      :pattern ((loc<Ref> a@2@12 i@38@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
  (and
    (not
      (forall ((i@38@12 Int)) (!
        (=>
          (or
            (and (<= 0 i@38@12) (< i@38@12 0))
            (and (< y@22@12 i@38@12) (< i@38@12 (len<Int> a@2@12))))
          (<
            ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 i@38@12))
            ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 0))))
        :pattern ((loc<Ref> a@2@12 i@38@12))
        :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
    (forall ((i@39@12 Int)) (!
      (and
        (or (<= 0 i@39@12) (not (<= 0 i@39@12)))
        (=>
          (not (and (<= 0 i@39@12) (< i@39@12 0)))
          (and
            (not (and (<= 0 i@39@12) (< i@39@12 0)))
            (or (< y@22@12 i@39@12) (not (< y@22@12 i@39@12)))))
        (or
          (not (and (<= 0 i@39@12) (< i@39@12 0)))
          (and (<= 0 i@39@12) (< i@39@12 0)))
        (or
          (not
            (or
              (and (<= 0 i@39@12) (< i@39@12 0))
              (and (< y@22@12 i@39@12) (< i@39@12 (len<Int> a@2@12)))))
          (or
            (and (<= 0 i@39@12) (< i@39@12 0))
            (and (< y@22@12 i@39@12) (< i@39@12 (len<Int> a@2@12))))))
      :pattern ((loc<Ref> a@2@12 i@39@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57-aux|)))))
(assert (or
  (not
    (forall ((i@38@12 Int)) (!
      (=>
        (or
          (and (<= 0 i@38@12) (< i@38@12 0))
          (and (< y@22@12 i@38@12) (< i@38@12 (len<Int> a@2@12))))
        (<
          ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 i@38@12))
          ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 0))))
      :pattern ((loc<Ref> a@2@12 i@38@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
  (forall ((i@38@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@38@12) (< i@38@12 0))
        (and (< y@22@12 i@38@12) (< i@38@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 i@38@12))
        ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 0))))
    :pattern ((loc<Ref> a@2@12 i@38@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))))
(push) ; 5
(assert (not (or
  (forall ((i@38@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@38@12) (< i@38@12 0))
        (and (< y@22@12 i@38@12) (< i@38@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 i@38@12))
        ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 0))))
    :pattern ((loc<Ref> a@2@12 i@38@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))
  (forall ((i@39@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@39@12) (< i@39@12 0))
        (and (< y@22@12 i@39@12) (< i@39@12 (len<Int> a@2@12))))
      (<=
        ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 i@39@12))
        ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 y@22@12))))
    :pattern ((loc<Ref> a@2@12 i@39@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57|)))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (or
  (forall ((i@38@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@38@12) (< i@38@12 0))
        (and (< y@22@12 i@38@12) (< i@38@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 i@38@12))
        ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 0))))
    :pattern ((loc<Ref> a@2@12 i@38@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))
  (forall ((i@39@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@39@12) (< i@39@12 0))
        (and (< y@22@12 i@39@12) (< i@39@12 (len<Int> a@2@12))))
      (<=
        ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 i@39@12))
        ($FVF.lookup_val (as sm@36@12  $FVF<val>) (loc<Ref> a@2@12 y@22@12))))
    :pattern ((loc<Ref> a@2@12 i@39@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57|))))
; Loop head block: Execute statements of loop head block (in invariant state)
(push) ; 5
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@12 r)
      (and (<= 0 (inv@27@12 r)) (< (inv@27@12 r) (len<Int> a@2@12))))
    (= (loc<Ref> a@2@12 (inv@27@12 r)) r))
  :pattern ((inv@27@12 r))
  :qid |val-fctOfInv|)))
(assert (forall ((j$3@26@12 Int)) (!
  (=>
    (and (<= 0 j$3@26@12) (< j$3@26@12 (len<Int> a@2@12)))
    (and
      (= (inv@27@12 (loc<Ref> a@2@12 j$3@26@12)) j$3@26@12)
      (img@28@12 (loc<Ref> a@2@12 j$3@26@12))))
  :pattern ((loc<Ref> a@2@12 j$3@26@12))
  :qid |quant-u-17|)))
(assert (forall ((j$3@26@12 Int)) (!
  (=>
    (and (<= 0 j$3@26@12) (< j$3@26@12 (len<Int> a@2@12)))
    (not (= (loc<Ref> a@2@12 j$3@26@12) $Ref.null)))
  :pattern ((loc<Ref> a@2@12 j$3@26@12))
  :qid |val-permImpliesNonNull|)))
(assert (=
  ($Snap.second $t@25@12)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@25@12))
    ($Snap.second ($Snap.second $t@25@12)))))
(assert (= ($Snap.first ($Snap.second $t@25@12)) $Snap.unit))
(assert (forall ((j$4@29@12 Int)) (!
  (and
    (or (<= 0 j$4@29@12) (not (<= 0 j$4@29@12)))
    (or
      (not (and (<= 0 j$4@29@12) (< j$4@29@12 (len<Int> a@2@12))))
      (and (<= 0 j$4@29@12) (< j$4@29@12 (len<Int> a@2@12)))))
  :pattern ((loc<Ref> a@2@12 j$4@29@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@26@30@26@42-aux|)))
(assert (forall ((j$4@29@12 Int)) (!
  (=>
    (and (<= 0 j$4@29@12) (< j$4@29@12 (len<Int> a@2@12)))
    (=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 j$4@29@12))
      ($FVF.lookup_val $t@5@12 (loc<Ref> a@2@12 j$4@29@12))))
  :pattern ((loc<Ref> a@2@12 j$4@29@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@26@30@26@42|)))
(assert (=
  ($Snap.second ($Snap.second $t@25@12))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@25@12)))
    ($Snap.second ($Snap.second ($Snap.second $t@25@12))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@25@12))) $Snap.unit))
(assert (<= 0 x@23@12))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@25@12)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@25@12))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@25@12)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@25@12))))
  $Snap.unit))
(assert (<= x@23@12 y@24@12))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@25@12))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@25@12)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@25@12))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@25@12)))))
  $Snap.unit))
(assert (< y@24@12 (len<Int> a@2@12)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@25@12)))))
  $Snap.unit))
(assert (forall ((i@30@12 Int)) (!
  (and
    (or (<= 0 i@30@12) (not (<= 0 i@30@12)))
    (=>
      (not (and (<= 0 i@30@12) (< i@30@12 x@23@12)))
      (and
        (not (and (<= 0 i@30@12) (< i@30@12 x@23@12)))
        (or (< y@24@12 i@30@12) (not (< y@24@12 i@30@12)))))
    (or
      (not (and (<= 0 i@30@12) (< i@30@12 x@23@12)))
      (and (<= 0 i@30@12) (< i@30@12 x@23@12)))
    (or
      (not
        (or
          (and (<= 0 i@30@12) (< i@30@12 x@23@12))
          (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12)))))
      (or
        (and (<= 0 i@30@12) (< i@30@12 x@23@12))
        (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))))
  :pattern ((loc<Ref> a@2@12 i@30@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56-aux|)))
(assert (=>
  (not
    (forall ((i@30@12 Int)) (!
      (=>
        (or
          (and (<= 0 i@30@12) (< i@30@12 x@23@12))
          (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))
        (<
          ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 i@30@12))
          ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))))
      :pattern ((loc<Ref> a@2@12 i@30@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
  (and
    (not
      (forall ((i@30@12 Int)) (!
        (=>
          (or
            (and (<= 0 i@30@12) (< i@30@12 x@23@12))
            (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))
          (<
            ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 i@30@12))
            ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))))
        :pattern ((loc<Ref> a@2@12 i@30@12))
        :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
    (forall ((i@31@12 Int)) (!
      (and
        (or (<= 0 i@31@12) (not (<= 0 i@31@12)))
        (=>
          (not (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
          (and
            (not (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
            (or (< y@24@12 i@31@12) (not (< y@24@12 i@31@12)))))
        (or
          (not (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
          (and (<= 0 i@31@12) (< i@31@12 x@23@12)))
        (or
          (not
            (or
              (and (<= 0 i@31@12) (< i@31@12 x@23@12))
              (and (< y@24@12 i@31@12) (< i@31@12 (len<Int> a@2@12)))))
          (or
            (and (<= 0 i@31@12) (< i@31@12 x@23@12))
            (and (< y@24@12 i@31@12) (< i@31@12 (len<Int> a@2@12))))))
      :pattern ((loc<Ref> a@2@12 i@31@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57-aux|)))))
(assert (or
  (not
    (forall ((i@30@12 Int)) (!
      (=>
        (or
          (and (<= 0 i@30@12) (< i@30@12 x@23@12))
          (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))
        (<
          ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 i@30@12))
          ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))))
      :pattern ((loc<Ref> a@2@12 i@30@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
  (forall ((i@30@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@30@12) (< i@30@12 x@23@12))
        (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 i@30@12))
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))))
    :pattern ((loc<Ref> a@2@12 i@30@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))))
(assert (or
  (forall ((i@30@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@30@12) (< i@30@12 x@23@12))
        (and (< y@24@12 i@30@12) (< i@30@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 i@30@12))
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))))
    :pattern ((loc<Ref> a@2@12 i@30@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))
  (forall ((i@31@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@31@12) (< i@31@12 x@23@12))
        (and (< y@24@12 i@31@12) (< i@31@12 (len<Int> a@2@12))))
      (<=
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 i@31@12))
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 y@24@12))))
    :pattern ((loc<Ref> a@2@12 i@31@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57|))))
(assert (= $t@25@12 ($Snap.combine ($Snap.first $t@25@12) ($Snap.second $t@25@12))))
(assert (forall ((j$3@26@12 Int)) (!
  (=>
    (and (<= 0 j$3@26@12) (< j$3@26@12 (len<Int> a@2@12)))
    (or (<= 0 j$3@26@12) (not (<= 0 j$3@26@12))))
  :pattern ((loc<Ref> a@2@12 j$3@26@12))
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
(push) ; 6
; [eval] x != y
(pop) ; 6
(push) ; 6
; [eval] !(x != y)
; [eval] x != y
(pop) ; 6
; Loop head block: Follow loop-internal edges
; [eval] x != y
(push) ; 6
(set-option :timeout 10)
(assert (not (= x@23@12 y@24@12)))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 10)
(assert (not (not (= x@23@12 y@24@12))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [then-branch: 40 | x@23@12 != y@24@12 | live]
; [else-branch: 40 | x@23@12 == y@24@12 | live]
(set-option :timeout 0)
(push) ; 6
; [then-branch: 40 | x@23@12 != y@24@12]
(assert (not (= x@23@12 y@24@12)))
; [eval] loc(a, x).val <= loc(a, y).val
; [eval] loc(a, x)
(push) ; 7
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 x@23@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 x@23@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 x@23@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, y)
(push) ; 7
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 y@24@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 y@24@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 y@24@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(set-option :timeout 10)
(assert (not (not
  (<=
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 y@24@12))))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (<=
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 y@24@12)))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [then-branch: 41 | Lookup(val, First:($t@25@12), loc[Ref](a@2@12, x@23@12)) <= Lookup(val, First:($t@25@12), loc[Ref](a@2@12, y@24@12)) | live]
; [else-branch: 41 | !(Lookup(val, First:($t@25@12), loc[Ref](a@2@12, x@23@12)) <= Lookup(val, First:($t@25@12), loc[Ref](a@2@12, y@24@12))) | live]
(set-option :timeout 0)
(push) ; 7
; [then-branch: 41 | Lookup(val, First:($t@25@12), loc[Ref](a@2@12, x@23@12)) <= Lookup(val, First:($t@25@12), loc[Ref](a@2@12, y@24@12))]
(assert (<=
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 y@24@12))))
; [exec]
; x := x + 1
; [eval] x + 1
(declare-const x@40@12 Int)
(assert (= x@40@12 (+ x@23@12 1)))
; Loop head block: Re-establish invariant
(declare-const j$3@41@12 Int)
(push) ; 8
; [eval] 0 <= j$3 && j$3 < len(a)
; [eval] 0 <= j$3
(push) ; 9
; [then-branch: 42 | !(0 <= j$3@41@12) | live]
; [else-branch: 42 | 0 <= j$3@41@12 | live]
(push) ; 10
; [then-branch: 42 | !(0 <= j$3@41@12)]
(assert (not (<= 0 j$3@41@12)))
(pop) ; 10
(push) ; 10
; [else-branch: 42 | 0 <= j$3@41@12]
(assert (<= 0 j$3@41@12))
; [eval] j$3 < len(a)
; [eval] len(a)
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$3@41@12) (not (<= 0 j$3@41@12))))
(assert (and (<= 0 j$3@41@12) (< j$3@41@12 (len<Int> a@2@12))))
; [eval] loc(a, j$3)
(pop) ; 8
(declare-fun inv@42@12 ($Ref) Int)
(declare-fun img@43@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((j$3@41@12 Int)) (!
  (=>
    (and (<= 0 j$3@41@12) (< j$3@41@12 (len<Int> a@2@12)))
    (or (<= 0 j$3@41@12) (not (<= 0 j$3@41@12))))
  :pattern ((loc<Ref> a@2@12 j$3@41@12))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 8
(assert (not (forall ((j$31@41@12 Int) (j$32@41@12 Int)) (!
  (=>
    (and
      (and (<= 0 j$31@41@12) (< j$31@41@12 (len<Int> a@2@12)))
      (and (<= 0 j$32@41@12) (< j$32@41@12 (len<Int> a@2@12)))
      (= (loc<Ref> a@2@12 j$31@41@12) (loc<Ref> a@2@12 j$32@41@12)))
    (= j$31@41@12 j$32@41@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((j$3@41@12 Int)) (!
  (=>
    (and (<= 0 j$3@41@12) (< j$3@41@12 (len<Int> a@2@12)))
    (and
      (= (inv@42@12 (loc<Ref> a@2@12 j$3@41@12)) j$3@41@12)
      (img@43@12 (loc<Ref> a@2@12 j$3@41@12))))
  :pattern ((loc<Ref> a@2@12 j$3@41@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@43@12 r)
      (and (<= 0 (inv@42@12 r)) (< (inv@42@12 r) (len<Int> a@2@12))))
    (= (loc<Ref> a@2@12 (inv@42@12 r)) r))
  :pattern ((inv@42@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@44@12 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= 0 (inv@42@12 r)) (< (inv@42@12 r) (len<Int> a@2@12)))
      (img@43@12 r)
      (= r (loc<Ref> a@2@12 (inv@42@12 r))))
    ($Perm.min
      (ite
        (and
          (img@28@12 r)
          (and (<= 0 (inv@27@12 r)) (< (inv@27@12 r) (len<Int> a@2@12))))
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
(push) ; 8
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@28@12 r)
          (and (<= 0 (inv@27@12 r)) (< (inv@27@12 r) (len<Int> a@2@12))))
        $Perm.Write
        $Perm.No)
      (pTaken@44@12 r))
    $Perm.No)
  
  :qid |quant-u-24|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 8
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and (<= 0 (inv@42@12 r)) (< (inv@42@12 r) (len<Int> a@2@12)))
      (img@43@12 r)
      (= r (loc<Ref> a@2@12 (inv@42@12 r))))
    (= (- $Perm.Write (pTaken@44@12 r)) $Perm.No))
  
  :qid |quant-u-25|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@45@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@12 r)
      (and (<= 0 (inv@27@12 r)) (< (inv@27@12 r) (len<Int> a@2@12))))
    (=
      ($FVF.lookup_val (as sm@45@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) r)))
  :pattern (($FVF.lookup_val (as sm@45@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) r))
  :qid |qp.fvfValDef2|)))
; [eval] (forall j$4: Int :: { old(loc(a, j$4)) } 0 <= j$4 && j$4 < len(a) ==> loc(a, j$4).val == old(loc(a, j$4).val))
(declare-const j$4@46@12 Int)
(set-option :timeout 0)
(push) ; 8
; [eval] 0 <= j$4 && j$4 < len(a) ==> loc(a, j$4).val == old(loc(a, j$4).val)
; [eval] 0 <= j$4 && j$4 < len(a)
; [eval] 0 <= j$4
(push) ; 9
; [then-branch: 43 | !(0 <= j$4@46@12) | live]
; [else-branch: 43 | 0 <= j$4@46@12 | live]
(push) ; 10
; [then-branch: 43 | !(0 <= j$4@46@12)]
(assert (not (<= 0 j$4@46@12)))
(pop) ; 10
(push) ; 10
; [else-branch: 43 | 0 <= j$4@46@12]
(assert (<= 0 j$4@46@12))
; [eval] j$4 < len(a)
; [eval] len(a)
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$4@46@12) (not (<= 0 j$4@46@12))))
(push) ; 9
; [then-branch: 44 | 0 <= j$4@46@12 && j$4@46@12 < len[Int](a@2@12) | live]
; [else-branch: 44 | !(0 <= j$4@46@12 && j$4@46@12 < len[Int](a@2@12)) | live]
(push) ; 10
; [then-branch: 44 | 0 <= j$4@46@12 && j$4@46@12 < len[Int](a@2@12)]
(assert (and (<= 0 j$4@46@12) (< j$4@46@12 (len<Int> a@2@12))))
; [eval] loc(a, j$4).val == old(loc(a, j$4).val)
; [eval] loc(a, j$4)
(push) ; 11
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 j$4@46@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 j$4@46@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 j$4@46@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, j$4).val)
; [eval] loc(a, j$4)
(push) ; 11
(assert (not (and
  (img@7@12 (loc<Ref> a@2@12 j$4@46@12))
  (and
    (<= 0 (inv@6@12 (loc<Ref> a@2@12 j$4@46@12)))
    (< (inv@6@12 (loc<Ref> a@2@12 j$4@46@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(pop) ; 10
(push) ; 10
; [else-branch: 44 | !(0 <= j$4@46@12 && j$4@46@12 < len[Int](a@2@12))]
(assert (not (and (<= 0 j$4@46@12) (< j$4@46@12 (len<Int> a@2@12)))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= 0 j$4@46@12) (< j$4@46@12 (len<Int> a@2@12))))
  (and (<= 0 j$4@46@12) (< j$4@46@12 (len<Int> a@2@12)))))
; [eval] old(loc(a, j$4))
; [eval] loc(a, j$4)
(pop) ; 8
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((j$4@46@12 Int)) (!
  (and
    (or (<= 0 j$4@46@12) (not (<= 0 j$4@46@12)))
    (or
      (not (and (<= 0 j$4@46@12) (< j$4@46@12 (len<Int> a@2@12))))
      (and (<= 0 j$4@46@12) (< j$4@46@12 (len<Int> a@2@12)))))
  :pattern ((loc<Ref> a@2@12 j$4@46@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@26@30@26@42-aux|)))
(push) ; 8
(assert (not (forall ((j$4@46@12 Int)) (!
  (=>
    (and (<= 0 j$4@46@12) (< j$4@46@12 (len<Int> a@2@12)))
    (=
      ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 j$4@46@12))
      ($FVF.lookup_val $t@5@12 (loc<Ref> a@2@12 j$4@46@12))))
  :pattern ((loc<Ref> a@2@12 j$4@46@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@26@30@26@42|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (forall ((j$4@46@12 Int)) (!
  (=>
    (and (<= 0 j$4@46@12) (< j$4@46@12 (len<Int> a@2@12)))
    (=
      ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 j$4@46@12))
      ($FVF.lookup_val $t@5@12 (loc<Ref> a@2@12 j$4@46@12))))
  :pattern ((loc<Ref> a@2@12 j$4@46@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@26@30@26@42|)))
; [eval] 0 <= x
(push) ; 8
(assert (not (<= 0 x@40@12)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 x@40@12))
; [eval] x <= y
(push) ; 8
(assert (not (<= x@40@12 y@24@12)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (<= x@40@12 y@24@12))
; [eval] y < len(a)
; [eval] len(a)
; [eval] (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val < loc(a, x).val) || (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val <= loc(a, y).val)
; [eval] (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val < loc(a, x).val)
(declare-const i@47@12 Int)
(push) ; 8
; [eval] 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val < loc(a, x).val
; [eval] 0 <= i && i < x || y < i && i < len(a)
; [eval] 0 <= i && i < x
; [eval] 0 <= i
(push) ; 9
; [then-branch: 45 | !(0 <= i@47@12) | live]
; [else-branch: 45 | 0 <= i@47@12 | live]
(push) ; 10
; [then-branch: 45 | !(0 <= i@47@12)]
(assert (not (<= 0 i@47@12)))
(pop) ; 10
(push) ; 10
; [else-branch: 45 | 0 <= i@47@12]
(assert (<= 0 i@47@12))
; [eval] i < x
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@47@12) (not (<= 0 i@47@12))))
(push) ; 9
; [then-branch: 46 | 0 <= i@47@12 && i@47@12 < x@40@12 | live]
; [else-branch: 46 | !(0 <= i@47@12 && i@47@12 < x@40@12) | live]
(push) ; 10
; [then-branch: 46 | 0 <= i@47@12 && i@47@12 < x@40@12]
(assert (and (<= 0 i@47@12) (< i@47@12 x@40@12)))
(pop) ; 10
(push) ; 10
; [else-branch: 46 | !(0 <= i@47@12 && i@47@12 < x@40@12)]
(assert (not (and (<= 0 i@47@12) (< i@47@12 x@40@12))))
; [eval] y < i && i < len(a)
; [eval] y < i
(push) ; 11
; [then-branch: 47 | !(y@24@12 < i@47@12) | live]
; [else-branch: 47 | y@24@12 < i@47@12 | live]
(push) ; 12
; [then-branch: 47 | !(y@24@12 < i@47@12)]
(assert (not (< y@24@12 i@47@12)))
(pop) ; 12
(push) ; 12
; [else-branch: 47 | y@24@12 < i@47@12]
(assert (< y@24@12 i@47@12))
; [eval] i < len(a)
; [eval] len(a)
(pop) ; 12
(pop) ; 11
; Joined path conditions
; Joined path conditions
(assert (or (< y@24@12 i@47@12) (not (< y@24@12 i@47@12))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (and (<= 0 i@47@12) (< i@47@12 x@40@12)))
  (and
    (not (and (<= 0 i@47@12) (< i@47@12 x@40@12)))
    (or (< y@24@12 i@47@12) (not (< y@24@12 i@47@12))))))
(assert (or
  (not (and (<= 0 i@47@12) (< i@47@12 x@40@12)))
  (and (<= 0 i@47@12) (< i@47@12 x@40@12))))
(push) ; 9
; [then-branch: 48 | 0 <= i@47@12 && i@47@12 < x@40@12 || y@24@12 < i@47@12 && i@47@12 < len[Int](a@2@12) | live]
; [else-branch: 48 | !(0 <= i@47@12 && i@47@12 < x@40@12 || y@24@12 < i@47@12 && i@47@12 < len[Int](a@2@12)) | live]
(push) ; 10
; [then-branch: 48 | 0 <= i@47@12 && i@47@12 < x@40@12 || y@24@12 < i@47@12 && i@47@12 < len[Int](a@2@12)]
(assert (or
  (and (<= 0 i@47@12) (< i@47@12 x@40@12))
  (and (< y@24@12 i@47@12) (< i@47@12 (len<Int> a@2@12)))))
; [eval] loc(a, i).val < loc(a, x).val
; [eval] loc(a, i)
(push) ; 11
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 i@47@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 i@47@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 i@47@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, x)
(push) ; 11
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 x@40@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 x@40@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 x@40@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(pop) ; 10
(push) ; 10
; [else-branch: 48 | !(0 <= i@47@12 && i@47@12 < x@40@12 || y@24@12 < i@47@12 && i@47@12 < len[Int](a@2@12))]
(assert (not
  (or
    (and (<= 0 i@47@12) (< i@47@12 x@40@12))
    (and (< y@24@12 i@47@12) (< i@47@12 (len<Int> a@2@12))))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or
  (not
    (or
      (and (<= 0 i@47@12) (< i@47@12 x@40@12))
      (and (< y@24@12 i@47@12) (< i@47@12 (len<Int> a@2@12)))))
  (or
    (and (<= 0 i@47@12) (< i@47@12 x@40@12))
    (and (< y@24@12 i@47@12) (< i@47@12 (len<Int> a@2@12))))))
(pop) ; 8
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@47@12 Int)) (!
  (and
    (or (<= 0 i@47@12) (not (<= 0 i@47@12)))
    (=>
      (not (and (<= 0 i@47@12) (< i@47@12 x@40@12)))
      (and
        (not (and (<= 0 i@47@12) (< i@47@12 x@40@12)))
        (or (< y@24@12 i@47@12) (not (< y@24@12 i@47@12)))))
    (or
      (not (and (<= 0 i@47@12) (< i@47@12 x@40@12)))
      (and (<= 0 i@47@12) (< i@47@12 x@40@12)))
    (or
      (not
        (or
          (and (<= 0 i@47@12) (< i@47@12 x@40@12))
          (and (< y@24@12 i@47@12) (< i@47@12 (len<Int> a@2@12)))))
      (or
        (and (<= 0 i@47@12) (< i@47@12 x@40@12))
        (and (< y@24@12 i@47@12) (< i@47@12 (len<Int> a@2@12))))))
  :pattern ((loc<Ref> a@2@12 i@47@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56-aux|)))
(push) ; 8
; [then-branch: 49 | QA i@47@12 :: 0 <= i@47@12 && i@47@12 < x@40@12 || y@24@12 < i@47@12 && i@47@12 < len[Int](a@2@12) ==> Lookup(val, sm@45@12, loc[Ref](a@2@12, i@47@12)) < Lookup(val, sm@45@12, loc[Ref](a@2@12, x@40@12)) | live]
; [else-branch: 49 | !(QA i@47@12 :: 0 <= i@47@12 && i@47@12 < x@40@12 || y@24@12 < i@47@12 && i@47@12 < len[Int](a@2@12) ==> Lookup(val, sm@45@12, loc[Ref](a@2@12, i@47@12)) < Lookup(val, sm@45@12, loc[Ref](a@2@12, x@40@12))) | live]
(push) ; 9
; [then-branch: 49 | QA i@47@12 :: 0 <= i@47@12 && i@47@12 < x@40@12 || y@24@12 < i@47@12 && i@47@12 < len[Int](a@2@12) ==> Lookup(val, sm@45@12, loc[Ref](a@2@12, i@47@12)) < Lookup(val, sm@45@12, loc[Ref](a@2@12, x@40@12))]
(assert (forall ((i@47@12 Int)) (!
  (=>
    (or
      (and (<= 0 i@47@12) (< i@47@12 x@40@12))
      (and (< y@24@12 i@47@12) (< i@47@12 (len<Int> a@2@12))))
    (<
      ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 i@47@12))
      ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 x@40@12))))
  :pattern ((loc<Ref> a@2@12 i@47@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
(pop) ; 9
(push) ; 9
; [else-branch: 49 | !(QA i@47@12 :: 0 <= i@47@12 && i@47@12 < x@40@12 || y@24@12 < i@47@12 && i@47@12 < len[Int](a@2@12) ==> Lookup(val, sm@45@12, loc[Ref](a@2@12, i@47@12)) < Lookup(val, sm@45@12, loc[Ref](a@2@12, x@40@12)))]
(assert (not
  (forall ((i@47@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@47@12) (< i@47@12 x@40@12))
        (and (< y@24@12 i@47@12) (< i@47@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 i@47@12))
        ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 x@40@12))))
    :pattern ((loc<Ref> a@2@12 i@47@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))))
; [eval] (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val <= loc(a, y).val)
(declare-const i@48@12 Int)
(push) ; 10
; [eval] 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val <= loc(a, y).val
; [eval] 0 <= i && i < x || y < i && i < len(a)
; [eval] 0 <= i && i < x
; [eval] 0 <= i
(push) ; 11
; [then-branch: 50 | !(0 <= i@48@12) | live]
; [else-branch: 50 | 0 <= i@48@12 | live]
(push) ; 12
; [then-branch: 50 | !(0 <= i@48@12)]
(assert (not (<= 0 i@48@12)))
(pop) ; 12
(push) ; 12
; [else-branch: 50 | 0 <= i@48@12]
(assert (<= 0 i@48@12))
; [eval] i < x
(pop) ; 12
(pop) ; 11
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@48@12) (not (<= 0 i@48@12))))
(push) ; 11
; [then-branch: 51 | 0 <= i@48@12 && i@48@12 < x@40@12 | live]
; [else-branch: 51 | !(0 <= i@48@12 && i@48@12 < x@40@12) | live]
(push) ; 12
; [then-branch: 51 | 0 <= i@48@12 && i@48@12 < x@40@12]
(assert (and (<= 0 i@48@12) (< i@48@12 x@40@12)))
(pop) ; 12
(push) ; 12
; [else-branch: 51 | !(0 <= i@48@12 && i@48@12 < x@40@12)]
(assert (not (and (<= 0 i@48@12) (< i@48@12 x@40@12))))
; [eval] y < i && i < len(a)
; [eval] y < i
(push) ; 13
; [then-branch: 52 | !(y@24@12 < i@48@12) | live]
; [else-branch: 52 | y@24@12 < i@48@12 | live]
(push) ; 14
; [then-branch: 52 | !(y@24@12 < i@48@12)]
(assert (not (< y@24@12 i@48@12)))
(pop) ; 14
(push) ; 14
; [else-branch: 52 | y@24@12 < i@48@12]
(assert (< y@24@12 i@48@12))
; [eval] i < len(a)
; [eval] len(a)
(pop) ; 14
(pop) ; 13
; Joined path conditions
; Joined path conditions
(assert (or (< y@24@12 i@48@12) (not (< y@24@12 i@48@12))))
(pop) ; 12
(pop) ; 11
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (and (<= 0 i@48@12) (< i@48@12 x@40@12)))
  (and
    (not (and (<= 0 i@48@12) (< i@48@12 x@40@12)))
    (or (< y@24@12 i@48@12) (not (< y@24@12 i@48@12))))))
(assert (or
  (not (and (<= 0 i@48@12) (< i@48@12 x@40@12)))
  (and (<= 0 i@48@12) (< i@48@12 x@40@12))))
(push) ; 11
; [then-branch: 53 | 0 <= i@48@12 && i@48@12 < x@40@12 || y@24@12 < i@48@12 && i@48@12 < len[Int](a@2@12) | live]
; [else-branch: 53 | !(0 <= i@48@12 && i@48@12 < x@40@12 || y@24@12 < i@48@12 && i@48@12 < len[Int](a@2@12)) | live]
(push) ; 12
; [then-branch: 53 | 0 <= i@48@12 && i@48@12 < x@40@12 || y@24@12 < i@48@12 && i@48@12 < len[Int](a@2@12)]
(assert (or
  (and (<= 0 i@48@12) (< i@48@12 x@40@12))
  (and (< y@24@12 i@48@12) (< i@48@12 (len<Int> a@2@12)))))
; [eval] loc(a, i).val <= loc(a, y).val
; [eval] loc(a, i)
(push) ; 13
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 i@48@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 i@48@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 i@48@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 13
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, y)
(push) ; 13
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 y@24@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 y@24@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 y@24@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 13
; 0.00s
; (get-info :all-statistics)
(pop) ; 12
(push) ; 12
; [else-branch: 53 | !(0 <= i@48@12 && i@48@12 < x@40@12 || y@24@12 < i@48@12 && i@48@12 < len[Int](a@2@12))]
(assert (not
  (or
    (and (<= 0 i@48@12) (< i@48@12 x@40@12))
    (and (< y@24@12 i@48@12) (< i@48@12 (len<Int> a@2@12))))))
(pop) ; 12
(pop) ; 11
; Joined path conditions
; Joined path conditions
(assert (or
  (not
    (or
      (and (<= 0 i@48@12) (< i@48@12 x@40@12))
      (and (< y@24@12 i@48@12) (< i@48@12 (len<Int> a@2@12)))))
  (or
    (and (<= 0 i@48@12) (< i@48@12 x@40@12))
    (and (< y@24@12 i@48@12) (< i@48@12 (len<Int> a@2@12))))))
(pop) ; 10
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@48@12 Int)) (!
  (and
    (or (<= 0 i@48@12) (not (<= 0 i@48@12)))
    (=>
      (not (and (<= 0 i@48@12) (< i@48@12 x@40@12)))
      (and
        (not (and (<= 0 i@48@12) (< i@48@12 x@40@12)))
        (or (< y@24@12 i@48@12) (not (< y@24@12 i@48@12)))))
    (or
      (not (and (<= 0 i@48@12) (< i@48@12 x@40@12)))
      (and (<= 0 i@48@12) (< i@48@12 x@40@12)))
    (or
      (not
        (or
          (and (<= 0 i@48@12) (< i@48@12 x@40@12))
          (and (< y@24@12 i@48@12) (< i@48@12 (len<Int> a@2@12)))))
      (or
        (and (<= 0 i@48@12) (< i@48@12 x@40@12))
        (and (< y@24@12 i@48@12) (< i@48@12 (len<Int> a@2@12))))))
  :pattern ((loc<Ref> a@2@12 i@48@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57-aux|)))
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (=>
  (not
    (forall ((i@47@12 Int)) (!
      (=>
        (or
          (and (<= 0 i@47@12) (< i@47@12 x@40@12))
          (and (< y@24@12 i@47@12) (< i@47@12 (len<Int> a@2@12))))
        (<
          ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 i@47@12))
          ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 x@40@12))))
      :pattern ((loc<Ref> a@2@12 i@47@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
  (and
    (not
      (forall ((i@47@12 Int)) (!
        (=>
          (or
            (and (<= 0 i@47@12) (< i@47@12 x@40@12))
            (and (< y@24@12 i@47@12) (< i@47@12 (len<Int> a@2@12))))
          (<
            ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 i@47@12))
            ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 x@40@12))))
        :pattern ((loc<Ref> a@2@12 i@47@12))
        :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
    (forall ((i@48@12 Int)) (!
      (and
        (or (<= 0 i@48@12) (not (<= 0 i@48@12)))
        (=>
          (not (and (<= 0 i@48@12) (< i@48@12 x@40@12)))
          (and
            (not (and (<= 0 i@48@12) (< i@48@12 x@40@12)))
            (or (< y@24@12 i@48@12) (not (< y@24@12 i@48@12)))))
        (or
          (not (and (<= 0 i@48@12) (< i@48@12 x@40@12)))
          (and (<= 0 i@48@12) (< i@48@12 x@40@12)))
        (or
          (not
            (or
              (and (<= 0 i@48@12) (< i@48@12 x@40@12))
              (and (< y@24@12 i@48@12) (< i@48@12 (len<Int> a@2@12)))))
          (or
            (and (<= 0 i@48@12) (< i@48@12 x@40@12))
            (and (< y@24@12 i@48@12) (< i@48@12 (len<Int> a@2@12))))))
      :pattern ((loc<Ref> a@2@12 i@48@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57-aux|)))))
(assert (or
  (not
    (forall ((i@47@12 Int)) (!
      (=>
        (or
          (and (<= 0 i@47@12) (< i@47@12 x@40@12))
          (and (< y@24@12 i@47@12) (< i@47@12 (len<Int> a@2@12))))
        (<
          ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 i@47@12))
          ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 x@40@12))))
      :pattern ((loc<Ref> a@2@12 i@47@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
  (forall ((i@47@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@47@12) (< i@47@12 x@40@12))
        (and (< y@24@12 i@47@12) (< i@47@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 i@47@12))
        ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 x@40@12))))
    :pattern ((loc<Ref> a@2@12 i@47@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))))
(push) ; 8
(assert (not (or
  (forall ((i@47@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@47@12) (< i@47@12 x@40@12))
        (and (< y@24@12 i@47@12) (< i@47@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 i@47@12))
        ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 x@40@12))))
    :pattern ((loc<Ref> a@2@12 i@47@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))
  (forall ((i@48@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@48@12) (< i@48@12 x@40@12))
        (and (< y@24@12 i@48@12) (< i@48@12 (len<Int> a@2@12))))
      (<=
        ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 i@48@12))
        ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 y@24@12))))
    :pattern ((loc<Ref> a@2@12 i@48@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57|)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (or
  (forall ((i@47@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@47@12) (< i@47@12 x@40@12))
        (and (< y@24@12 i@47@12) (< i@47@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 i@47@12))
        ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 x@40@12))))
    :pattern ((loc<Ref> a@2@12 i@47@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))
  (forall ((i@48@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@48@12) (< i@48@12 x@40@12))
        (and (< y@24@12 i@48@12) (< i@48@12 (len<Int> a@2@12))))
      (<=
        ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 i@48@12))
        ($FVF.lookup_val (as sm@45@12  $FVF<val>) (loc<Ref> a@2@12 y@24@12))))
    :pattern ((loc<Ref> a@2@12 i@48@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57|))))
(pop) ; 7
(push) ; 7
; [else-branch: 41 | !(Lookup(val, First:($t@25@12), loc[Ref](a@2@12, x@23@12)) <= Lookup(val, First:($t@25@12), loc[Ref](a@2@12, y@24@12)))]
(assert (not
  (<=
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 y@24@12)))))
(pop) ; 7
; [eval] !(loc(a, x).val <= loc(a, y).val)
; [eval] loc(a, x).val <= loc(a, y).val
; [eval] loc(a, x)
(push) ; 7
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 x@23@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 x@23@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 x@23@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, y)
(push) ; 7
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 y@24@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 y@24@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 y@24@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(push) ; 7
(set-option :timeout 10)
(assert (not (<=
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 y@24@12)))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (not
  (<=
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 y@24@12))))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [then-branch: 54 | !(Lookup(val, First:($t@25@12), loc[Ref](a@2@12, x@23@12)) <= Lookup(val, First:($t@25@12), loc[Ref](a@2@12, y@24@12))) | live]
; [else-branch: 54 | Lookup(val, First:($t@25@12), loc[Ref](a@2@12, x@23@12)) <= Lookup(val, First:($t@25@12), loc[Ref](a@2@12, y@24@12)) | live]
(set-option :timeout 0)
(push) ; 7
; [then-branch: 54 | !(Lookup(val, First:($t@25@12), loc[Ref](a@2@12, x@23@12)) <= Lookup(val, First:($t@25@12), loc[Ref](a@2@12, y@24@12)))]
(assert (not
  (<=
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 y@24@12)))))
; [exec]
; y := y - 1
; [eval] y - 1
(declare-const y@49@12 Int)
(assert (= y@49@12 (- y@24@12 1)))
; Loop head block: Re-establish invariant
(declare-const j$3@50@12 Int)
(push) ; 8
; [eval] 0 <= j$3 && j$3 < len(a)
; [eval] 0 <= j$3
(push) ; 9
; [then-branch: 55 | !(0 <= j$3@50@12) | live]
; [else-branch: 55 | 0 <= j$3@50@12 | live]
(push) ; 10
; [then-branch: 55 | !(0 <= j$3@50@12)]
(assert (not (<= 0 j$3@50@12)))
(pop) ; 10
(push) ; 10
; [else-branch: 55 | 0 <= j$3@50@12]
(assert (<= 0 j$3@50@12))
; [eval] j$3 < len(a)
; [eval] len(a)
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$3@50@12) (not (<= 0 j$3@50@12))))
(assert (and (<= 0 j$3@50@12) (< j$3@50@12 (len<Int> a@2@12))))
; [eval] loc(a, j$3)
(pop) ; 8
(declare-fun inv@51@12 ($Ref) Int)
(declare-fun img@52@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((j$3@50@12 Int)) (!
  (=>
    (and (<= 0 j$3@50@12) (< j$3@50@12 (len<Int> a@2@12)))
    (or (<= 0 j$3@50@12) (not (<= 0 j$3@50@12))))
  :pattern ((loc<Ref> a@2@12 j$3@50@12))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 8
(assert (not (forall ((j$31@50@12 Int) (j$32@50@12 Int)) (!
  (=>
    (and
      (and (<= 0 j$31@50@12) (< j$31@50@12 (len<Int> a@2@12)))
      (and (<= 0 j$32@50@12) (< j$32@50@12 (len<Int> a@2@12)))
      (= (loc<Ref> a@2@12 j$31@50@12) (loc<Ref> a@2@12 j$32@50@12)))
    (= j$31@50@12 j$32@50@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((j$3@50@12 Int)) (!
  (=>
    (and (<= 0 j$3@50@12) (< j$3@50@12 (len<Int> a@2@12)))
    (and
      (= (inv@51@12 (loc<Ref> a@2@12 j$3@50@12)) j$3@50@12)
      (img@52@12 (loc<Ref> a@2@12 j$3@50@12))))
  :pattern ((loc<Ref> a@2@12 j$3@50@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@52@12 r)
      (and (<= 0 (inv@51@12 r)) (< (inv@51@12 r) (len<Int> a@2@12))))
    (= (loc<Ref> a@2@12 (inv@51@12 r)) r))
  :pattern ((inv@51@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@53@12 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= 0 (inv@51@12 r)) (< (inv@51@12 r) (len<Int> a@2@12)))
      (img@52@12 r)
      (= r (loc<Ref> a@2@12 (inv@51@12 r))))
    ($Perm.min
      (ite
        (and
          (img@28@12 r)
          (and (<= 0 (inv@27@12 r)) (< (inv@27@12 r) (len<Int> a@2@12))))
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
(push) ; 8
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@28@12 r)
          (and (<= 0 (inv@27@12 r)) (< (inv@27@12 r) (len<Int> a@2@12))))
        $Perm.Write
        $Perm.No)
      (pTaken@53@12 r))
    $Perm.No)
  
  :qid |quant-u-28|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 8
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and (<= 0 (inv@51@12 r)) (< (inv@51@12 r) (len<Int> a@2@12)))
      (img@52@12 r)
      (= r (loc<Ref> a@2@12 (inv@51@12 r))))
    (= (- $Perm.Write (pTaken@53@12 r)) $Perm.No))
  
  :qid |quant-u-29|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@54@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@12 r)
      (and (<= 0 (inv@27@12 r)) (< (inv@27@12 r) (len<Int> a@2@12))))
    (=
      ($FVF.lookup_val (as sm@54@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) r)))
  :pattern (($FVF.lookup_val (as sm@54@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) r))
  :qid |qp.fvfValDef3|)))
; [eval] (forall j$4: Int :: { old(loc(a, j$4)) } 0 <= j$4 && j$4 < len(a) ==> loc(a, j$4).val == old(loc(a, j$4).val))
(declare-const j$4@55@12 Int)
(set-option :timeout 0)
(push) ; 8
; [eval] 0 <= j$4 && j$4 < len(a) ==> loc(a, j$4).val == old(loc(a, j$4).val)
; [eval] 0 <= j$4 && j$4 < len(a)
; [eval] 0 <= j$4
(push) ; 9
; [then-branch: 56 | !(0 <= j$4@55@12) | live]
; [else-branch: 56 | 0 <= j$4@55@12 | live]
(push) ; 10
; [then-branch: 56 | !(0 <= j$4@55@12)]
(assert (not (<= 0 j$4@55@12)))
(pop) ; 10
(push) ; 10
; [else-branch: 56 | 0 <= j$4@55@12]
(assert (<= 0 j$4@55@12))
; [eval] j$4 < len(a)
; [eval] len(a)
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$4@55@12) (not (<= 0 j$4@55@12))))
(push) ; 9
; [then-branch: 57 | 0 <= j$4@55@12 && j$4@55@12 < len[Int](a@2@12) | live]
; [else-branch: 57 | !(0 <= j$4@55@12 && j$4@55@12 < len[Int](a@2@12)) | live]
(push) ; 10
; [then-branch: 57 | 0 <= j$4@55@12 && j$4@55@12 < len[Int](a@2@12)]
(assert (and (<= 0 j$4@55@12) (< j$4@55@12 (len<Int> a@2@12))))
; [eval] loc(a, j$4).val == old(loc(a, j$4).val)
; [eval] loc(a, j$4)
(push) ; 11
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 j$4@55@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 j$4@55@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 j$4@55@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, j$4).val)
; [eval] loc(a, j$4)
(push) ; 11
(assert (not (and
  (img@7@12 (loc<Ref> a@2@12 j$4@55@12))
  (and
    (<= 0 (inv@6@12 (loc<Ref> a@2@12 j$4@55@12)))
    (< (inv@6@12 (loc<Ref> a@2@12 j$4@55@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(pop) ; 10
(push) ; 10
; [else-branch: 57 | !(0 <= j$4@55@12 && j$4@55@12 < len[Int](a@2@12))]
(assert (not (and (<= 0 j$4@55@12) (< j$4@55@12 (len<Int> a@2@12)))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= 0 j$4@55@12) (< j$4@55@12 (len<Int> a@2@12))))
  (and (<= 0 j$4@55@12) (< j$4@55@12 (len<Int> a@2@12)))))
; [eval] old(loc(a, j$4))
; [eval] loc(a, j$4)
(pop) ; 8
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((j$4@55@12 Int)) (!
  (and
    (or (<= 0 j$4@55@12) (not (<= 0 j$4@55@12)))
    (or
      (not (and (<= 0 j$4@55@12) (< j$4@55@12 (len<Int> a@2@12))))
      (and (<= 0 j$4@55@12) (< j$4@55@12 (len<Int> a@2@12)))))
  :pattern ((loc<Ref> a@2@12 j$4@55@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@26@30@26@42-aux|)))
(push) ; 8
(assert (not (forall ((j$4@55@12 Int)) (!
  (=>
    (and (<= 0 j$4@55@12) (< j$4@55@12 (len<Int> a@2@12)))
    (=
      ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 j$4@55@12))
      ($FVF.lookup_val $t@5@12 (loc<Ref> a@2@12 j$4@55@12))))
  :pattern ((loc<Ref> a@2@12 j$4@55@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@26@30@26@42|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (forall ((j$4@55@12 Int)) (!
  (=>
    (and (<= 0 j$4@55@12) (< j$4@55@12 (len<Int> a@2@12)))
    (=
      ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 j$4@55@12))
      ($FVF.lookup_val $t@5@12 (loc<Ref> a@2@12 j$4@55@12))))
  :pattern ((loc<Ref> a@2@12 j$4@55@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@26@30@26@42|)))
; [eval] 0 <= x
; [eval] x <= y
(push) ; 8
(assert (not (<= x@23@12 y@49@12)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (<= x@23@12 y@49@12))
; [eval] y < len(a)
; [eval] len(a)
(push) ; 8
(assert (not (< y@49@12 (len<Int> a@2@12))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (< y@49@12 (len<Int> a@2@12)))
; [eval] (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val < loc(a, x).val) || (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val <= loc(a, y).val)
; [eval] (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val < loc(a, x).val)
(declare-const i@56@12 Int)
(push) ; 8
; [eval] 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val < loc(a, x).val
; [eval] 0 <= i && i < x || y < i && i < len(a)
; [eval] 0 <= i && i < x
; [eval] 0 <= i
(push) ; 9
; [then-branch: 58 | !(0 <= i@56@12) | live]
; [else-branch: 58 | 0 <= i@56@12 | live]
(push) ; 10
; [then-branch: 58 | !(0 <= i@56@12)]
(assert (not (<= 0 i@56@12)))
(pop) ; 10
(push) ; 10
; [else-branch: 58 | 0 <= i@56@12]
(assert (<= 0 i@56@12))
; [eval] i < x
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@56@12) (not (<= 0 i@56@12))))
(push) ; 9
; [then-branch: 59 | 0 <= i@56@12 && i@56@12 < x@23@12 | live]
; [else-branch: 59 | !(0 <= i@56@12 && i@56@12 < x@23@12) | live]
(push) ; 10
; [then-branch: 59 | 0 <= i@56@12 && i@56@12 < x@23@12]
(assert (and (<= 0 i@56@12) (< i@56@12 x@23@12)))
(pop) ; 10
(push) ; 10
; [else-branch: 59 | !(0 <= i@56@12 && i@56@12 < x@23@12)]
(assert (not (and (<= 0 i@56@12) (< i@56@12 x@23@12))))
; [eval] y < i && i < len(a)
; [eval] y < i
(push) ; 11
; [then-branch: 60 | !(y@49@12 < i@56@12) | live]
; [else-branch: 60 | y@49@12 < i@56@12 | live]
(push) ; 12
; [then-branch: 60 | !(y@49@12 < i@56@12)]
(assert (not (< y@49@12 i@56@12)))
(pop) ; 12
(push) ; 12
; [else-branch: 60 | y@49@12 < i@56@12]
(assert (< y@49@12 i@56@12))
; [eval] i < len(a)
; [eval] len(a)
(pop) ; 12
(pop) ; 11
; Joined path conditions
; Joined path conditions
(assert (or (< y@49@12 i@56@12) (not (< y@49@12 i@56@12))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (and (<= 0 i@56@12) (< i@56@12 x@23@12)))
  (and
    (not (and (<= 0 i@56@12) (< i@56@12 x@23@12)))
    (or (< y@49@12 i@56@12) (not (< y@49@12 i@56@12))))))
(assert (or
  (not (and (<= 0 i@56@12) (< i@56@12 x@23@12)))
  (and (<= 0 i@56@12) (< i@56@12 x@23@12))))
(push) ; 9
; [then-branch: 61 | 0 <= i@56@12 && i@56@12 < x@23@12 || y@49@12 < i@56@12 && i@56@12 < len[Int](a@2@12) | live]
; [else-branch: 61 | !(0 <= i@56@12 && i@56@12 < x@23@12 || y@49@12 < i@56@12 && i@56@12 < len[Int](a@2@12)) | live]
(push) ; 10
; [then-branch: 61 | 0 <= i@56@12 && i@56@12 < x@23@12 || y@49@12 < i@56@12 && i@56@12 < len[Int](a@2@12)]
(assert (or
  (and (<= 0 i@56@12) (< i@56@12 x@23@12))
  (and (< y@49@12 i@56@12) (< i@56@12 (len<Int> a@2@12)))))
; [eval] loc(a, i).val < loc(a, x).val
; [eval] loc(a, i)
(push) ; 11
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 i@56@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 i@56@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 i@56@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, x)
(push) ; 11
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 x@23@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 x@23@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 x@23@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 11
; 0.00s
; (get-info :all-statistics)
(pop) ; 10
(push) ; 10
; [else-branch: 61 | !(0 <= i@56@12 && i@56@12 < x@23@12 || y@49@12 < i@56@12 && i@56@12 < len[Int](a@2@12))]
(assert (not
  (or
    (and (<= 0 i@56@12) (< i@56@12 x@23@12))
    (and (< y@49@12 i@56@12) (< i@56@12 (len<Int> a@2@12))))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or
  (not
    (or
      (and (<= 0 i@56@12) (< i@56@12 x@23@12))
      (and (< y@49@12 i@56@12) (< i@56@12 (len<Int> a@2@12)))))
  (or
    (and (<= 0 i@56@12) (< i@56@12 x@23@12))
    (and (< y@49@12 i@56@12) (< i@56@12 (len<Int> a@2@12))))))
(pop) ; 8
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@56@12 Int)) (!
  (and
    (or (<= 0 i@56@12) (not (<= 0 i@56@12)))
    (=>
      (not (and (<= 0 i@56@12) (< i@56@12 x@23@12)))
      (and
        (not (and (<= 0 i@56@12) (< i@56@12 x@23@12)))
        (or (< y@49@12 i@56@12) (not (< y@49@12 i@56@12)))))
    (or
      (not (and (<= 0 i@56@12) (< i@56@12 x@23@12)))
      (and (<= 0 i@56@12) (< i@56@12 x@23@12)))
    (or
      (not
        (or
          (and (<= 0 i@56@12) (< i@56@12 x@23@12))
          (and (< y@49@12 i@56@12) (< i@56@12 (len<Int> a@2@12)))))
      (or
        (and (<= 0 i@56@12) (< i@56@12 x@23@12))
        (and (< y@49@12 i@56@12) (< i@56@12 (len<Int> a@2@12))))))
  :pattern ((loc<Ref> a@2@12 i@56@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56-aux|)))
(push) ; 8
; [then-branch: 62 | QA i@56@12 :: 0 <= i@56@12 && i@56@12 < x@23@12 || y@49@12 < i@56@12 && i@56@12 < len[Int](a@2@12) ==> Lookup(val, sm@54@12, loc[Ref](a@2@12, i@56@12)) < Lookup(val, sm@54@12, loc[Ref](a@2@12, x@23@12)) | live]
; [else-branch: 62 | !(QA i@56@12 :: 0 <= i@56@12 && i@56@12 < x@23@12 || y@49@12 < i@56@12 && i@56@12 < len[Int](a@2@12) ==> Lookup(val, sm@54@12, loc[Ref](a@2@12, i@56@12)) < Lookup(val, sm@54@12, loc[Ref](a@2@12, x@23@12))) | live]
(push) ; 9
; [then-branch: 62 | QA i@56@12 :: 0 <= i@56@12 && i@56@12 < x@23@12 || y@49@12 < i@56@12 && i@56@12 < len[Int](a@2@12) ==> Lookup(val, sm@54@12, loc[Ref](a@2@12, i@56@12)) < Lookup(val, sm@54@12, loc[Ref](a@2@12, x@23@12))]
(assert (forall ((i@56@12 Int)) (!
  (=>
    (or
      (and (<= 0 i@56@12) (< i@56@12 x@23@12))
      (and (< y@49@12 i@56@12) (< i@56@12 (len<Int> a@2@12))))
    (<
      ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 i@56@12))
      ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 x@23@12))))
  :pattern ((loc<Ref> a@2@12 i@56@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
(pop) ; 9
(push) ; 9
; [else-branch: 62 | !(QA i@56@12 :: 0 <= i@56@12 && i@56@12 < x@23@12 || y@49@12 < i@56@12 && i@56@12 < len[Int](a@2@12) ==> Lookup(val, sm@54@12, loc[Ref](a@2@12, i@56@12)) < Lookup(val, sm@54@12, loc[Ref](a@2@12, x@23@12)))]
(assert (not
  (forall ((i@56@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@56@12) (< i@56@12 x@23@12))
        (and (< y@49@12 i@56@12) (< i@56@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 i@56@12))
        ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 x@23@12))))
    :pattern ((loc<Ref> a@2@12 i@56@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))))
; [eval] (forall i: Int :: { loc(a, i) } 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val <= loc(a, y).val)
(declare-const i@57@12 Int)
(push) ; 10
; [eval] 0 <= i && i < x || y < i && i < len(a) ==> loc(a, i).val <= loc(a, y).val
; [eval] 0 <= i && i < x || y < i && i < len(a)
; [eval] 0 <= i && i < x
; [eval] 0 <= i
(push) ; 11
; [then-branch: 63 | !(0 <= i@57@12) | live]
; [else-branch: 63 | 0 <= i@57@12 | live]
(push) ; 12
; [then-branch: 63 | !(0 <= i@57@12)]
(assert (not (<= 0 i@57@12)))
(pop) ; 12
(push) ; 12
; [else-branch: 63 | 0 <= i@57@12]
(assert (<= 0 i@57@12))
; [eval] i < x
(pop) ; 12
(pop) ; 11
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@57@12) (not (<= 0 i@57@12))))
(push) ; 11
; [then-branch: 64 | 0 <= i@57@12 && i@57@12 < x@23@12 | live]
; [else-branch: 64 | !(0 <= i@57@12 && i@57@12 < x@23@12) | live]
(push) ; 12
; [then-branch: 64 | 0 <= i@57@12 && i@57@12 < x@23@12]
(assert (and (<= 0 i@57@12) (< i@57@12 x@23@12)))
(pop) ; 12
(push) ; 12
; [else-branch: 64 | !(0 <= i@57@12 && i@57@12 < x@23@12)]
(assert (not (and (<= 0 i@57@12) (< i@57@12 x@23@12))))
; [eval] y < i && i < len(a)
; [eval] y < i
(push) ; 13
; [then-branch: 65 | !(y@49@12 < i@57@12) | live]
; [else-branch: 65 | y@49@12 < i@57@12 | live]
(push) ; 14
; [then-branch: 65 | !(y@49@12 < i@57@12)]
(assert (not (< y@49@12 i@57@12)))
(pop) ; 14
(push) ; 14
; [else-branch: 65 | y@49@12 < i@57@12]
(assert (< y@49@12 i@57@12))
; [eval] i < len(a)
; [eval] len(a)
(pop) ; 14
(pop) ; 13
; Joined path conditions
; Joined path conditions
(assert (or (< y@49@12 i@57@12) (not (< y@49@12 i@57@12))))
(pop) ; 12
(pop) ; 11
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (and (<= 0 i@57@12) (< i@57@12 x@23@12)))
  (and
    (not (and (<= 0 i@57@12) (< i@57@12 x@23@12)))
    (or (< y@49@12 i@57@12) (not (< y@49@12 i@57@12))))))
(assert (or
  (not (and (<= 0 i@57@12) (< i@57@12 x@23@12)))
  (and (<= 0 i@57@12) (< i@57@12 x@23@12))))
(push) ; 11
; [then-branch: 66 | 0 <= i@57@12 && i@57@12 < x@23@12 || y@49@12 < i@57@12 && i@57@12 < len[Int](a@2@12) | live]
; [else-branch: 66 | !(0 <= i@57@12 && i@57@12 < x@23@12 || y@49@12 < i@57@12 && i@57@12 < len[Int](a@2@12)) | live]
(push) ; 12
; [then-branch: 66 | 0 <= i@57@12 && i@57@12 < x@23@12 || y@49@12 < i@57@12 && i@57@12 < len[Int](a@2@12)]
(assert (or
  (and (<= 0 i@57@12) (< i@57@12 x@23@12))
  (and (< y@49@12 i@57@12) (< i@57@12 (len<Int> a@2@12)))))
; [eval] loc(a, i).val <= loc(a, y).val
; [eval] loc(a, i)
(push) ; 13
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 i@57@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 i@57@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 i@57@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 13
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, y)
(push) ; 13
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 y@49@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 y@49@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 y@49@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 13
; 0.00s
; (get-info :all-statistics)
(pop) ; 12
(push) ; 12
; [else-branch: 66 | !(0 <= i@57@12 && i@57@12 < x@23@12 || y@49@12 < i@57@12 && i@57@12 < len[Int](a@2@12))]
(assert (not
  (or
    (and (<= 0 i@57@12) (< i@57@12 x@23@12))
    (and (< y@49@12 i@57@12) (< i@57@12 (len<Int> a@2@12))))))
(pop) ; 12
(pop) ; 11
; Joined path conditions
; Joined path conditions
(assert (or
  (not
    (or
      (and (<= 0 i@57@12) (< i@57@12 x@23@12))
      (and (< y@49@12 i@57@12) (< i@57@12 (len<Int> a@2@12)))))
  (or
    (and (<= 0 i@57@12) (< i@57@12 x@23@12))
    (and (< y@49@12 i@57@12) (< i@57@12 (len<Int> a@2@12))))))
(pop) ; 10
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@57@12 Int)) (!
  (and
    (or (<= 0 i@57@12) (not (<= 0 i@57@12)))
    (=>
      (not (and (<= 0 i@57@12) (< i@57@12 x@23@12)))
      (and
        (not (and (<= 0 i@57@12) (< i@57@12 x@23@12)))
        (or (< y@49@12 i@57@12) (not (< y@49@12 i@57@12)))))
    (or
      (not (and (<= 0 i@57@12) (< i@57@12 x@23@12)))
      (and (<= 0 i@57@12) (< i@57@12 x@23@12)))
    (or
      (not
        (or
          (and (<= 0 i@57@12) (< i@57@12 x@23@12))
          (and (< y@49@12 i@57@12) (< i@57@12 (len<Int> a@2@12)))))
      (or
        (and (<= 0 i@57@12) (< i@57@12 x@23@12))
        (and (< y@49@12 i@57@12) (< i@57@12 (len<Int> a@2@12))))))
  :pattern ((loc<Ref> a@2@12 i@57@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57-aux|)))
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (=>
  (not
    (forall ((i@56@12 Int)) (!
      (=>
        (or
          (and (<= 0 i@56@12) (< i@56@12 x@23@12))
          (and (< y@49@12 i@56@12) (< i@56@12 (len<Int> a@2@12))))
        (<
          ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 i@56@12))
          ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 x@23@12))))
      :pattern ((loc<Ref> a@2@12 i@56@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
  (and
    (not
      (forall ((i@56@12 Int)) (!
        (=>
          (or
            (and (<= 0 i@56@12) (< i@56@12 x@23@12))
            (and (< y@49@12 i@56@12) (< i@56@12 (len<Int> a@2@12))))
          (<
            ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 i@56@12))
            ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 x@23@12))))
        :pattern ((loc<Ref> a@2@12 i@56@12))
        :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
    (forall ((i@57@12 Int)) (!
      (and
        (or (<= 0 i@57@12) (not (<= 0 i@57@12)))
        (=>
          (not (and (<= 0 i@57@12) (< i@57@12 x@23@12)))
          (and
            (not (and (<= 0 i@57@12) (< i@57@12 x@23@12)))
            (or (< y@49@12 i@57@12) (not (< y@49@12 i@57@12)))))
        (or
          (not (and (<= 0 i@57@12) (< i@57@12 x@23@12)))
          (and (<= 0 i@57@12) (< i@57@12 x@23@12)))
        (or
          (not
            (or
              (and (<= 0 i@57@12) (< i@57@12 x@23@12))
              (and (< y@49@12 i@57@12) (< i@57@12 (len<Int> a@2@12)))))
          (or
            (and (<= 0 i@57@12) (< i@57@12 x@23@12))
            (and (< y@49@12 i@57@12) (< i@57@12 (len<Int> a@2@12))))))
      :pattern ((loc<Ref> a@2@12 i@57@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57-aux|)))))
(assert (or
  (not
    (forall ((i@56@12 Int)) (!
      (=>
        (or
          (and (<= 0 i@56@12) (< i@56@12 x@23@12))
          (and (< y@49@12 i@56@12) (< i@56@12 (len<Int> a@2@12))))
        (<
          ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 i@56@12))
          ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 x@23@12))))
      :pattern ((loc<Ref> a@2@12 i@56@12))
      :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|)))
  (forall ((i@56@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@56@12) (< i@56@12 x@23@12))
        (and (< y@49@12 i@56@12) (< i@56@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 i@56@12))
        ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 x@23@12))))
    :pattern ((loc<Ref> a@2@12 i@56@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))))
(push) ; 8
(assert (not (or
  (forall ((i@56@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@56@12) (< i@56@12 x@23@12))
        (and (< y@49@12 i@56@12) (< i@56@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 i@56@12))
        ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 x@23@12))))
    :pattern ((loc<Ref> a@2@12 i@56@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))
  (forall ((i@57@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@57@12) (< i@57@12 x@23@12))
        (and (< y@49@12 i@57@12) (< i@57@12 (len<Int> a@2@12))))
      (<=
        ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 i@57@12))
        ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 y@49@12))))
    :pattern ((loc<Ref> a@2@12 i@57@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57|)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (or
  (forall ((i@56@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@56@12) (< i@56@12 x@23@12))
        (and (< y@49@12 i@56@12) (< i@56@12 (len<Int> a@2@12))))
      (<
        ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 i@56@12))
        ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 x@23@12))))
    :pattern ((loc<Ref> a@2@12 i@56@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@28@21@30@56|))
  (forall ((i@57@12 Int)) (!
    (=>
      (or
        (and (<= 0 i@57@12) (< i@57@12 x@23@12))
        (and (< y@49@12 i@57@12) (< i@57@12 (len<Int> a@2@12))))
      (<=
        ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 i@57@12))
        ($FVF.lookup_val (as sm@54@12  $FVF<val>) (loc<Ref> a@2@12 y@49@12))))
    :pattern ((loc<Ref> a@2@12 i@57@12))
    :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@31@21@33@57|))))
(pop) ; 7
(push) ; 7
; [else-branch: 54 | Lookup(val, First:($t@25@12), loc[Ref](a@2@12, x@23@12)) <= Lookup(val, First:($t@25@12), loc[Ref](a@2@12, y@24@12))]
(assert (<=
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 x@23@12))
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) (loc<Ref> a@2@12 y@24@12))))
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch: 40 | x@23@12 == y@24@12]
(assert (= x@23@12 y@24@12))
(pop) ; 6
; [eval] !(x != y)
; [eval] x != y
(push) ; 6
(set-option :timeout 10)
(assert (not (not (= x@23@12 y@24@12))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 10)
(assert (not (= x@23@12 y@24@12)))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [then-branch: 67 | x@23@12 == y@24@12 | live]
; [else-branch: 67 | x@23@12 != y@24@12 | live]
(set-option :timeout 0)
(push) ; 6
; [then-branch: 67 | x@23@12 == y@24@12]
(assert (= x@23@12 y@24@12))
(declare-const j$0@58@12 Int)
(push) ; 7
; [eval] 0 <= j$0 && j$0 < len(a)
; [eval] 0 <= j$0
(push) ; 8
; [then-branch: 68 | !(0 <= j$0@58@12) | live]
; [else-branch: 68 | 0 <= j$0@58@12 | live]
(push) ; 9
; [then-branch: 68 | !(0 <= j$0@58@12)]
(assert (not (<= 0 j$0@58@12)))
(pop) ; 9
(push) ; 9
; [else-branch: 68 | 0 <= j$0@58@12]
(assert (<= 0 j$0@58@12))
; [eval] j$0 < len(a)
; [eval] len(a)
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$0@58@12) (not (<= 0 j$0@58@12))))
(assert (and (<= 0 j$0@58@12) (< j$0@58@12 (len<Int> a@2@12))))
; [eval] loc(a, j$0)
(pop) ; 7
(declare-fun inv@59@12 ($Ref) Int)
(declare-fun img@60@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((j$0@58@12 Int)) (!
  (=>
    (and (<= 0 j$0@58@12) (< j$0@58@12 (len<Int> a@2@12)))
    (or (<= 0 j$0@58@12) (not (<= 0 j$0@58@12))))
  :pattern ((loc<Ref> a@2@12 j$0@58@12))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((j$01@58@12 Int) (j$02@58@12 Int)) (!
  (=>
    (and
      (and (<= 0 j$01@58@12) (< j$01@58@12 (len<Int> a@2@12)))
      (and (<= 0 j$02@58@12) (< j$02@58@12 (len<Int> a@2@12)))
      (= (loc<Ref> a@2@12 j$01@58@12) (loc<Ref> a@2@12 j$02@58@12)))
    (= j$01@58@12 j$02@58@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((j$0@58@12 Int)) (!
  (=>
    (and (<= 0 j$0@58@12) (< j$0@58@12 (len<Int> a@2@12)))
    (and
      (= (inv@59@12 (loc<Ref> a@2@12 j$0@58@12)) j$0@58@12)
      (img@60@12 (loc<Ref> a@2@12 j$0@58@12))))
  :pattern ((loc<Ref> a@2@12 j$0@58@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@60@12 r)
      (and (<= 0 (inv@59@12 r)) (< (inv@59@12 r) (len<Int> a@2@12))))
    (= (loc<Ref> a@2@12 (inv@59@12 r)) r))
  :pattern ((inv@59@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@61@12 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= 0 (inv@59@12 r)) (< (inv@59@12 r) (len<Int> a@2@12)))
      (img@60@12 r)
      (= r (loc<Ref> a@2@12 (inv@59@12 r))))
    ($Perm.min
      (ite
        (and
          (img@28@12 r)
          (and (<= 0 (inv@27@12 r)) (< (inv@27@12 r) (len<Int> a@2@12))))
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
(push) ; 7
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@28@12 r)
          (and (<= 0 (inv@27@12 r)) (< (inv@27@12 r) (len<Int> a@2@12))))
        $Perm.Write
        $Perm.No)
      (pTaken@61@12 r))
    $Perm.No)
  
  :qid |quant-u-32|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and (<= 0 (inv@59@12 r)) (< (inv@59@12 r) (len<Int> a@2@12)))
      (img@60@12 r)
      (= r (loc<Ref> a@2@12 (inv@59@12 r))))
    (= (- $Perm.Write (pTaken@61@12 r)) $Perm.No))
  
  :qid |quant-u-33|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@62@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@12 r)
      (and (<= 0 (inv@27@12 r)) (< (inv@27@12 r) (len<Int> a@2@12))))
    (=
      ($FVF.lookup_val (as sm@62@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) r)))
  :pattern (($FVF.lookup_val (as sm@62@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@25@12)) r))
  :qid |qp.fvfValDef4|)))
; [eval] (forall j$1: Int :: { old(loc(a, j$1)) } 0 <= j$1 && j$1 < len(a) ==> loc(a, j$1).val == old(loc(a, j$1).val))
(declare-const j$1@63@12 Int)
(set-option :timeout 0)
(push) ; 7
; [eval] 0 <= j$1 && j$1 < len(a) ==> loc(a, j$1).val == old(loc(a, j$1).val)
; [eval] 0 <= j$1 && j$1 < len(a)
; [eval] 0 <= j$1
(push) ; 8
; [then-branch: 69 | !(0 <= j$1@63@12) | live]
; [else-branch: 69 | 0 <= j$1@63@12 | live]
(push) ; 9
; [then-branch: 69 | !(0 <= j$1@63@12)]
(assert (not (<= 0 j$1@63@12)))
(pop) ; 9
(push) ; 9
; [else-branch: 69 | 0 <= j$1@63@12]
(assert (<= 0 j$1@63@12))
; [eval] j$1 < len(a)
; [eval] len(a)
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$1@63@12) (not (<= 0 j$1@63@12))))
(push) ; 8
; [then-branch: 70 | 0 <= j$1@63@12 && j$1@63@12 < len[Int](a@2@12) | live]
; [else-branch: 70 | !(0 <= j$1@63@12 && j$1@63@12 < len[Int](a@2@12)) | live]
(push) ; 9
; [then-branch: 70 | 0 <= j$1@63@12 && j$1@63@12 < len[Int](a@2@12)]
(assert (and (<= 0 j$1@63@12) (< j$1@63@12 (len<Int> a@2@12))))
; [eval] loc(a, j$1).val == old(loc(a, j$1).val)
; [eval] loc(a, j$1)
(push) ; 10
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 j$1@63@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 j$1@63@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 j$1@63@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, j$1).val)
; [eval] loc(a, j$1)
(push) ; 10
(assert (not (and
  (img@7@12 (loc<Ref> a@2@12 j$1@63@12))
  (and
    (<= 0 (inv@6@12 (loc<Ref> a@2@12 j$1@63@12)))
    (< (inv@6@12 (loc<Ref> a@2@12 j$1@63@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 70 | !(0 <= j$1@63@12 && j$1@63@12 < len[Int](a@2@12))]
(assert (not (and (<= 0 j$1@63@12) (< j$1@63@12 (len<Int> a@2@12)))))
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= 0 j$1@63@12) (< j$1@63@12 (len<Int> a@2@12))))
  (and (<= 0 j$1@63@12) (< j$1@63@12 (len<Int> a@2@12)))))
; [eval] old(loc(a, j$1))
; [eval] loc(a, j$1)
(pop) ; 7
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((j$1@63@12 Int)) (!
  (and
    (or (<= 0 j$1@63@12) (not (<= 0 j$1@63@12)))
    (or
      (not (and (<= 0 j$1@63@12) (< j$1@63@12 (len<Int> a@2@12))))
      (and (<= 0 j$1@63@12) (< j$1@63@12 (len<Int> a@2@12)))))
  :pattern ((loc<Ref> a@2@12 j$1@63@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@14@25@14@37-aux|)))
(push) ; 7
(assert (not (forall ((j$1@63@12 Int)) (!
  (=>
    (and (<= 0 j$1@63@12) (< j$1@63@12 (len<Int> a@2@12)))
    (=
      ($FVF.lookup_val (as sm@62@12  $FVF<val>) (loc<Ref> a@2@12 j$1@63@12))
      ($FVF.lookup_val $t@5@12 (loc<Ref> a@2@12 j$1@63@12))))
  :pattern ((loc<Ref> a@2@12 j$1@63@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@14@25@14@37|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (forall ((j$1@63@12 Int)) (!
  (=>
    (and (<= 0 j$1@63@12) (< j$1@63@12 (len<Int> a@2@12)))
    (=
      ($FVF.lookup_val (as sm@62@12  $FVF<val>) (loc<Ref> a@2@12 j$1@63@12))
      ($FVF.lookup_val $t@5@12 (loc<Ref> a@2@12 j$1@63@12))))
  :pattern ((loc<Ref> a@2@12 j$1@63@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@14@25@14@37|)))
; [eval] (len(a) == 0 ? x == -1 : 0 <= x && x < len(a))
; [eval] len(a) == 0
; [eval] len(a)
(push) ; 7
; [then-branch: 71 | len[Int](a@2@12) == 0 | dead]
; [else-branch: 71 | len[Int](a@2@12) != 0 | live]
(push) ; 8
; [else-branch: 71 | len[Int](a@2@12) != 0]
; [eval] 0 <= x && x < len(a)
; [eval] 0 <= x
(push) ; 9
; [then-branch: 72 | !(0 <= x@23@12) | live]
; [else-branch: 72 | 0 <= x@23@12 | live]
(push) ; 10
; [then-branch: 72 | !(0 <= x@23@12)]
(assert (not (<= 0 x@23@12)))
(pop) ; 10
(push) ; 10
; [else-branch: 72 | 0 <= x@23@12]
; [eval] x < len(a)
; [eval] len(a)
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 x@23@12) (not (<= 0 x@23@12))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (=> (not (= (len<Int> a@2@12) 0)) (or (<= 0 x@23@12) (not (<= 0 x@23@12)))))
(push) ; 7
(assert (not (and (<= 0 x@23@12) (< x@23@12 (len<Int> a@2@12)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (and (<= 0 x@23@12) (< x@23@12 (len<Int> a@2@12))))
; [eval] (forall j$2: Int :: { loc(a, j$2) } 0 <= j$2 && j$2 < len(a) ==> loc(a, j$2).val <= loc(a, x).val)
(declare-const j$2@64@12 Int)
(push) ; 7
; [eval] 0 <= j$2 && j$2 < len(a) ==> loc(a, j$2).val <= loc(a, x).val
; [eval] 0 <= j$2 && j$2 < len(a)
; [eval] 0 <= j$2
(push) ; 8
; [then-branch: 73 | !(0 <= j$2@64@12) | live]
; [else-branch: 73 | 0 <= j$2@64@12 | live]
(push) ; 9
; [then-branch: 73 | !(0 <= j$2@64@12)]
(assert (not (<= 0 j$2@64@12)))
(pop) ; 9
(push) ; 9
; [else-branch: 73 | 0 <= j$2@64@12]
(assert (<= 0 j$2@64@12))
; [eval] j$2 < len(a)
; [eval] len(a)
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$2@64@12) (not (<= 0 j$2@64@12))))
(push) ; 8
; [then-branch: 74 | 0 <= j$2@64@12 && j$2@64@12 < len[Int](a@2@12) | live]
; [else-branch: 74 | !(0 <= j$2@64@12 && j$2@64@12 < len[Int](a@2@12)) | live]
(push) ; 9
; [then-branch: 74 | 0 <= j$2@64@12 && j$2@64@12 < len[Int](a@2@12)]
(assert (and (<= 0 j$2@64@12) (< j$2@64@12 (len<Int> a@2@12))))
; [eval] loc(a, j$2).val <= loc(a, x).val
; [eval] loc(a, j$2)
(push) ; 10
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 j$2@64@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 j$2@64@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 j$2@64@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, x)
(push) ; 10
(assert (not (and
  (img@28@12 (loc<Ref> a@2@12 x@23@12))
  (and
    (<= 0 (inv@27@12 (loc<Ref> a@2@12 x@23@12)))
    (< (inv@27@12 (loc<Ref> a@2@12 x@23@12)) (len<Int> a@2@12))))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 74 | !(0 <= j$2@64@12 && j$2@64@12 < len[Int](a@2@12))]
(assert (not (and (<= 0 j$2@64@12) (< j$2@64@12 (len<Int> a@2@12)))))
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= 0 j$2@64@12) (< j$2@64@12 (len<Int> a@2@12))))
  (and (<= 0 j$2@64@12) (< j$2@64@12 (len<Int> a@2@12)))))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((j$2@64@12 Int)) (!
  (and
    (or (<= 0 j$2@64@12) (not (<= 0 j$2@64@12)))
    (or
      (not (and (<= 0 j$2@64@12) (< j$2@64@12 (len<Int> a@2@12))))
      (and (<= 0 j$2@64@12) (< j$2@64@12 (len<Int> a@2@12)))))
  :pattern ((loc<Ref> a@2@12 j$2@64@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@16@12@16@32-aux|)))
(push) ; 7
(assert (not (forall ((j$2@64@12 Int)) (!
  (=>
    (and (<= 0 j$2@64@12) (< j$2@64@12 (len<Int> a@2@12)))
    (<=
      ($FVF.lookup_val (as sm@62@12  $FVF<val>) (loc<Ref> a@2@12 j$2@64@12))
      ($FVF.lookup_val (as sm@62@12  $FVF<val>) (loc<Ref> a@2@12 x@23@12))))
  :pattern ((loc<Ref> a@2@12 j$2@64@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@16@12@16@32|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (forall ((j$2@64@12 Int)) (!
  (=>
    (and (<= 0 j$2@64@12) (< j$2@64@12 (len<Int> a@2@12)))
    (<=
      ($FVF.lookup_val (as sm@62@12  $FVF<val>) (loc<Ref> a@2@12 j$2@64@12))
      ($FVF.lookup_val (as sm@62@12  $FVF<val>) (loc<Ref> a@2@12 x@23@12))))
  :pattern ((loc<Ref> a@2@12 j$2@64@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-elimination.vpr@16@12@16@32|)))
(pop) ; 6
(push) ; 6
; [else-branch: 67 | x@23@12 != y@24@12]
(assert (not (= x@23@12 y@24@12)))
(pop) ; 6
(pop) ; 5
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch: 15 | len[Int](a@2@12) == 0]
(assert (= (len<Int> a@2@12) 0))
(pop) ; 3
(pop) ; 2
(pop) ; 1
