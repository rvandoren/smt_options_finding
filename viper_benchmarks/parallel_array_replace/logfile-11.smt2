(get-info :version)
; (:version "4.13.0")
; Started: 2024-09-24 15:25:26
; Silicon.version: 1.1-SNAPSHOT (b737e366)
; Input file: /Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/parallel-array-replace/parallel-array-replace.vpr
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
(declare-sort Array_ 0)
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
(declare-fun $SortWrappers.Array_To$Snap (Array_) $Snap)
(declare-fun $SortWrappers.$SnapToArray_ ($Snap) Array_)
(assert (forall ((x Array_)) (!
    (= x ($SortWrappers.$SnapToArray_($SortWrappers.Array_To$Snap x)))
    :pattern (($SortWrappers.Array_To$Snap x))
    :qid |$Snap.$SnapToArray_To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.Array_To$Snap($SortWrappers.$SnapToArray_ x)))
    :pattern (($SortWrappers.$SnapToArray_ x))
    :qid |$Snap.Array_To$SnapToArray_|
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
(declare-fun loc<Ref> (Array_ Int) $Ref)
(declare-fun len<Int> (Array_) Int)
(declare-fun first<Array> ($Ref) Array_)
(declare-fun second<Int> ($Ref) Int)
; /field_value_functions_declarations.smt2 [val: Int]
(declare-fun $FVF.domain_val ($FVF<val>) Set<$Ref>)
(declare-fun $FVF.lookup_val ($FVF<val> $Ref) Int)
(declare-fun $FVF.after_val ($FVF<val> $FVF<val>) Bool)
(declare-fun $FVF.loc_val (Int $Ref) Bool)
(declare-fun $FVF.perm_val ($FPM $Ref) $Perm)
(declare-const $fvfTOP_val $FVF<val>)
; Declaring symbols related to program functions (from program analysis)
(declare-fun Contains ($Snap Array_ Int Int) Bool)
(declare-fun Contains%limited ($Snap Array_ Int Int) Bool)
(declare-fun Contains%stateless (Array_ Int Int) Bool)
(declare-fun Contains%precondition ($Snap Array_ Int Int) Bool)
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
(assert (forall ((a Array_) (i Int)) (!
  (and (= (first<Array> (loc<Ref> a i)) a) (= (second<Int> (loc<Ref> a i)) i))
  :pattern ((loc<Ref> a i))
  :qid |prog.all_diff|)))
(assert (forall ((a Array_)) (!
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
(declare-fun inv@5@00 ($Snap Array_ Int Int $Ref) Int)
(declare-fun img@6@00 ($Snap Array_ Int Int $Ref) Bool)
(assert (forall ((s@$ $Snap) (a@0@00 Array_) (v@1@00 Int) (before@2@00 Int)) (!
  (=
    (Contains%limited s@$ a@0@00 v@1@00 before@2@00)
    (Contains s@$ a@0@00 v@1@00 before@2@00))
  :pattern ((Contains s@$ a@0@00 v@1@00 before@2@00))
  :qid |quant-u-0|)))
(assert (forall ((s@$ $Snap) (a@0@00 Array_) (v@1@00 Int) (before@2@00 Int)) (!
  (Contains%stateless a@0@00 v@1@00 before@2@00)
  :pattern ((Contains%limited s@$ a@0@00 v@1@00 before@2@00))
  :qid |quant-u-1|)))
; End function- and predicate-related preamble
; ------------------------------------------------------------
; ---------- Client ----------
(declare-const a@0@11 Array_)
(declare-const a@1@11 Array_)
(set-option :timeout 0)
(push) ; 1
(declare-const $t@2@11 $Snap)
(assert (= $t@2@11 ($Snap.combine ($Snap.first $t@2@11) ($Snap.second $t@2@11))))
(assert (= ($Snap.first $t@2@11) $Snap.unit))
; [eval] 1 < len(a)
; [eval] len(a)
(assert (< 1 (len<Int> a@1@11)))
(assert (=
  ($Snap.second $t@2@11)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@2@11))
    ($Snap.second ($Snap.second $t@2@11)))))
(declare-const i@3@11 Int)
(push) ; 2
; [eval] 0 <= i && i < len(a)
; [eval] 0 <= i
(push) ; 3
; [then-branch: 0 | !(0 <= i@3@11) | live]
; [else-branch: 0 | 0 <= i@3@11 | live]
(push) ; 4
; [then-branch: 0 | !(0 <= i@3@11)]
(assert (not (<= 0 i@3@11)))
(pop) ; 4
(push) ; 4
; [else-branch: 0 | 0 <= i@3@11]
(assert (<= 0 i@3@11))
; [eval] i < len(a)
; [eval] len(a)
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@3@11) (not (<= 0 i@3@11))))
(assert (and (<= 0 i@3@11) (< i@3@11 (len<Int> a@1@11))))
; [eval] loc(a, i)
(pop) ; 2
(declare-fun inv@4@11 ($Ref) Int)
(declare-fun img@5@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@3@11 Int)) (!
  (=>
    (and (<= 0 i@3@11) (< i@3@11 (len<Int> a@1@11)))
    (or (<= 0 i@3@11) (not (<= 0 i@3@11))))
  :pattern ((loc<Ref> a@1@11 i@3@11))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 2
(assert (not (forall ((i1@3@11 Int) (i2@3@11 Int)) (!
  (=>
    (and
      (and (<= 0 i1@3@11) (< i1@3@11 (len<Int> a@1@11)))
      (and (<= 0 i2@3@11) (< i2@3@11 (len<Int> a@1@11)))
      (= (loc<Ref> a@1@11 i1@3@11) (loc<Ref> a@1@11 i2@3@11)))
    (= i1@3@11 i2@3@11))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 2
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@3@11 Int)) (!
  (=>
    (and (<= 0 i@3@11) (< i@3@11 (len<Int> a@1@11)))
    (and
      (= (inv@4@11 (loc<Ref> a@1@11 i@3@11)) i@3@11)
      (img@5@11 (loc<Ref> a@1@11 i@3@11))))
  :pattern ((loc<Ref> a@1@11 i@3@11))
  :qid |quant-u-6|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@5@11 r)
      (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
    (= (loc<Ref> a@1@11 (inv@4@11 r)) r))
  :pattern ((inv@4@11 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@3@11 Int)) (!
  (=>
    (and (<= 0 i@3@11) (< i@3@11 (len<Int> a@1@11)))
    (not (= (loc<Ref> a@1@11 i@3@11) $Ref.null)))
  :pattern ((loc<Ref> a@1@11 i@3@11))
  :qid |val-permImpliesNonNull|)))
(assert (= ($Snap.second ($Snap.second $t@2@11)) $Snap.unit))
; [eval] Contains(a, 5, 1)
(push) ; 2
; [eval] 0 <= before
; [eval] before <= len(a)
; [eval] len(a)
(push) ; 3
(assert (not (<= 1 (len<Int> a@1@11))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (<= 1 (len<Int> a@1@11)))
(declare-const i@6@11 Int)
(push) ; 3
; [eval] 0 <= i && i < before
; [eval] 0 <= i
(push) ; 4
; [then-branch: 1 | !(0 <= i@6@11) | live]
; [else-branch: 1 | 0 <= i@6@11 | live]
(push) ; 5
; [then-branch: 1 | !(0 <= i@6@11)]
(assert (not (<= 0 i@6@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 1 | 0 <= i@6@11]
(assert (<= 0 i@6@11))
; [eval] i < before
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@6@11) (not (<= 0 i@6@11))))
(assert (and (<= 0 i@6@11) (< i@6@11 1)))
; [eval] loc(a, i)
(pop) ; 3
(declare-fun inv@7@11 ($Ref) Int)
(declare-fun img@8@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@6@11 Int)) (!
  (=> (and (<= 0 i@6@11) (< i@6@11 1)) (or (<= 0 i@6@11) (not (<= 0 i@6@11))))
  :pattern ((loc<Ref> a@1@11 i@6@11))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((i1@6@11 Int) (i2@6@11 Int)) (!
  (=>
    (and
      (and (<= 0 i1@6@11) (< i1@6@11 1))
      (and (<= 0 i2@6@11) (< i2@6@11 1))
      (= (loc<Ref> a@1@11 i1@6@11) (loc<Ref> a@1@11 i2@6@11)))
    (= i1@6@11 i2@6@11))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@6@11 Int)) (!
  (=>
    (and (<= 0 i@6@11) (< i@6@11 1))
    (and
      (= (inv@7@11 (loc<Ref> a@1@11 i@6@11)) i@6@11)
      (img@8@11 (loc<Ref> a@1@11 i@6@11))))
  :pattern ((loc<Ref> a@1@11 i@6@11))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@8@11 r) (and (<= 0 (inv@7@11 r)) (< (inv@7@11 r) 1)))
    (= (loc<Ref> a@1@11 (inv@7@11 r)) r))
  :pattern ((inv@7@11 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@9@11 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= 0 (inv@7@11 r)) (< (inv@7@11 r) 1))
      (img@8@11 r)
      (= r (loc<Ref> a@1@11 (inv@7@11 r))))
    ($Perm.min
      (ite
        (and
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
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
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
        $Perm.Write
        $Perm.No)
      (pTaken@9@11 r))
    $Perm.No)
  
  :qid |quant-u-12|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@9@11 r) $Perm.No)
  
  :qid |quant-u-13|))))
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
      (and (<= 0 (inv@7@11 r)) (< (inv@7@11 r) 1))
      (img@8@11 r)
      (= r (loc<Ref> a@1@11 (inv@7@11 r))))
    (= (- $Perm.Write (pTaken@9@11 r)) $Perm.No))
  
  :qid |quant-u-14|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@10@11 $FVF<val>)
; Definitional axioms for snapshot map domain
(assert (forall ((r $Ref)) (!
  (and
    (=>
      (Set_in r ($FVF.domain_val (as sm@10@11  $FVF<val>)))
      (and (and (<= 0 (inv@7@11 r)) (< (inv@7@11 r) 1)) (img@8@11 r)))
    (=>
      (and (and (<= 0 (inv@7@11 r)) (< (inv@7@11 r) 1)) (img@8@11 r))
      (Set_in r ($FVF.domain_val (as sm@10@11  $FVF<val>)))))
  :pattern ((Set_in r ($FVF.domain_val (as sm@10@11  $FVF<val>))))
  :qid |qp.fvfDomDef1|)))
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (and (and (<= 0 (inv@7@11 r)) (< (inv@7@11 r) 1)) (img@8@11 r))
      (and
        (img@5@11 r)
        (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11)))))
    (=
      ($FVF.lookup_val (as sm@10@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r)))
  :pattern (($FVF.lookup_val (as sm@10@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r))
  :qid |qp.fvfValDef0|)))
(assert (Contains%precondition ($Snap.combine
  $Snap.unit
  ($Snap.combine
    $Snap.unit
    ($SortWrappers.$FVF<val>To$Snap (as sm@10@11  $FVF<val>)))) a@1@11 5 1))
(pop) ; 2
; Joined path conditions
(assert (forall ((i@6@11 Int)) (!
  (=>
    (and (<= 0 i@6@11) (< i@6@11 1))
    (and
      (= (inv@7@11 (loc<Ref> a@1@11 i@6@11)) i@6@11)
      (img@8@11 (loc<Ref> a@1@11 i@6@11))))
  :pattern ((loc<Ref> a@1@11 i@6@11))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@8@11 r) (and (<= 0 (inv@7@11 r)) (< (inv@7@11 r) 1)))
    (= (loc<Ref> a@1@11 (inv@7@11 r)) r))
  :pattern ((inv@7@11 r))
  :qid |val-fctOfInv|)))
(assert (forall ((r $Ref)) (!
  (and
    (=>
      (Set_in r ($FVF.domain_val (as sm@10@11  $FVF<val>)))
      (and (and (<= 0 (inv@7@11 r)) (< (inv@7@11 r) 1)) (img@8@11 r)))
    (=>
      (and (and (<= 0 (inv@7@11 r)) (< (inv@7@11 r) 1)) (img@8@11 r))
      (Set_in r ($FVF.domain_val (as sm@10@11  $FVF<val>)))))
  :pattern ((Set_in r ($FVF.domain_val (as sm@10@11  $FVF<val>))))
  :qid |qp.fvfDomDef1|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (and (and (<= 0 (inv@7@11 r)) (< (inv@7@11 r) 1)) (img@8@11 r))
      (and
        (img@5@11 r)
        (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11)))))
    (=
      ($FVF.lookup_val (as sm@10@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r)))
  :pattern (($FVF.lookup_val (as sm@10@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r))
  :qid |qp.fvfValDef0|)))
(assert (and
  (<= 1 (len<Int> a@1@11))
  (forall ((i@6@11 Int)) (!
    (=> (and (<= 0 i@6@11) (< i@6@11 1)) (or (<= 0 i@6@11) (not (<= 0 i@6@11))))
    :pattern ((loc<Ref> a@1@11 i@6@11))
    :qid |val-aux|))
  (Contains%precondition ($Snap.combine
    $Snap.unit
    ($Snap.combine
      $Snap.unit
      ($SortWrappers.$FVF<val>To$Snap (as sm@10@11  $FVF<val>)))) a@1@11 5 1)))
(assert (Contains ($Snap.combine
  $Snap.unit
  ($Snap.combine
    $Snap.unit
    ($SortWrappers.$FVF<val>To$Snap (as sm@10@11  $FVF<val>)))) a@1@11 5 1))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
(set-option :timeout 0)
(push) ; 2
(pop) ; 2
(push) ; 2
; [exec]
; Replace(a, 1, len(a), 5, 7)
; [eval] len(a)
; [eval] 0 <= left
; [eval] left < right
; [eval] right <= len(a)
; [eval] len(a)
(declare-const i@11@11 Int)
(push) ; 3
; [eval] left <= i && i < right
; [eval] left <= i
(push) ; 4
; [then-branch: 2 | !(1 <= i@11@11) | live]
; [else-branch: 2 | 1 <= i@11@11 | live]
(push) ; 5
; [then-branch: 2 | !(1 <= i@11@11)]
(assert (not (<= 1 i@11@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 2 | 1 <= i@11@11]
(assert (<= 1 i@11@11))
; [eval] i < right
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 1 i@11@11) (not (<= 1 i@11@11))))
(assert (and (<= 1 i@11@11) (< i@11@11 (len<Int> a@1@11))))
; [eval] loc(a, i)
(pop) ; 3
(declare-fun inv@12@11 ($Ref) Int)
(declare-fun img@13@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@11@11 Int)) (!
  (=>
    (and (<= 1 i@11@11) (< i@11@11 (len<Int> a@1@11)))
    (or (<= 1 i@11@11) (not (<= 1 i@11@11))))
  :pattern ((loc<Ref> a@1@11 i@11@11))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((i1@11@11 Int) (i2@11@11 Int)) (!
  (=>
    (and
      (and (<= 1 i1@11@11) (< i1@11@11 (len<Int> a@1@11)))
      (and (<= 1 i2@11@11) (< i2@11@11 (len<Int> a@1@11)))
      (= (loc<Ref> a@1@11 i1@11@11) (loc<Ref> a@1@11 i2@11@11)))
    (= i1@11@11 i2@11@11))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@11@11 Int)) (!
  (=>
    (and (<= 1 i@11@11) (< i@11@11 (len<Int> a@1@11)))
    (and
      (= (inv@12@11 (loc<Ref> a@1@11 i@11@11)) i@11@11)
      (img@13@11 (loc<Ref> a@1@11 i@11@11))))
  :pattern ((loc<Ref> a@1@11 i@11@11))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@13@11 r)
      (and (<= 1 (inv@12@11 r)) (< (inv@12@11 r) (len<Int> a@1@11))))
    (= (loc<Ref> a@1@11 (inv@12@11 r)) r))
  :pattern ((inv@12@11 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@14@11 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= 1 (inv@12@11 r)) (< (inv@12@11 r) (len<Int> a@1@11)))
      (img@13@11 r)
      (= r (loc<Ref> a@1@11 (inv@12@11 r))))
    ($Perm.min
      (ite
        (and
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
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
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
        $Perm.Write
        $Perm.No)
      (pTaken@14@11 r))
    $Perm.No)
  
  :qid |quant-u-20|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@14@11 r) $Perm.No)
  
  :qid |quant-u-22|))))
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
      (and (<= 1 (inv@12@11 r)) (< (inv@12@11 r) (len<Int> a@1@11)))
      (img@13@11 r)
      (= r (loc<Ref> a@1@11 (inv@12@11 r))))
    (= (- $Perm.Write (pTaken@14@11 r)) $Perm.No))
  
  :qid |quant-u-23|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@15@11 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@5@11 r)
      (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
    (=
      ($FVF.lookup_val (as sm@15@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r)))
  :pattern (($FVF.lookup_val (as sm@15@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r))
  :qid |qp.fvfValDef2|)))
(declare-const $t@16@11 $Snap)
(assert (= $t@16@11 ($Snap.combine ($Snap.first $t@16@11) ($Snap.second $t@16@11))))
(declare-const i$0@17@11 Int)
(set-option :timeout 0)
(push) ; 3
; [eval] left <= i$0 && i$0 < right
; [eval] left <= i$0
(push) ; 4
; [then-branch: 3 | !(1 <= i$0@17@11) | live]
; [else-branch: 3 | 1 <= i$0@17@11 | live]
(push) ; 5
; [then-branch: 3 | !(1 <= i$0@17@11)]
(assert (not (<= 1 i$0@17@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 3 | 1 <= i$0@17@11]
(assert (<= 1 i$0@17@11))
; [eval] i$0 < right
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 1 i$0@17@11) (not (<= 1 i$0@17@11))))
(assert (and (<= 1 i$0@17@11) (< i$0@17@11 (len<Int> a@1@11))))
; [eval] loc(a, i$0)
(pop) ; 3
(declare-fun inv@18@11 ($Ref) Int)
(declare-fun img@19@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i$0@17@11 Int)) (!
  (=>
    (and (<= 1 i$0@17@11) (< i$0@17@11 (len<Int> a@1@11)))
    (or (<= 1 i$0@17@11) (not (<= 1 i$0@17@11))))
  :pattern ((loc<Ref> a@1@11 i$0@17@11))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((i$01@17@11 Int) (i$02@17@11 Int)) (!
  (=>
    (and
      (and (<= 1 i$01@17@11) (< i$01@17@11 (len<Int> a@1@11)))
      (and (<= 1 i$02@17@11) (< i$02@17@11 (len<Int> a@1@11)))
      (= (loc<Ref> a@1@11 i$01@17@11) (loc<Ref> a@1@11 i$02@17@11)))
    (= i$01@17@11 i$02@17@11))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i$0@17@11 Int)) (!
  (=>
    (and (<= 1 i$0@17@11) (< i$0@17@11 (len<Int> a@1@11)))
    (and
      (= (inv@18@11 (loc<Ref> a@1@11 i$0@17@11)) i$0@17@11)
      (img@19@11 (loc<Ref> a@1@11 i$0@17@11))))
  :pattern ((loc<Ref> a@1@11 i$0@17@11))
  :qid |quant-u-28|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@19@11 r)
      (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
    (= (loc<Ref> a@1@11 (inv@18@11 r)) r))
  :pattern ((inv@18@11 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i$0@17@11 Int)) (!
  (=>
    (and (<= 1 i$0@17@11) (< i$0@17@11 (len<Int> a@1@11)))
    (not (= (loc<Ref> a@1@11 i$0@17@11) $Ref.null)))
  :pattern ((loc<Ref> a@1@11 i$0@17@11))
  :qid |val-permImpliesNonNull|)))
(push) ; 3
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= (loc<Ref> a@1@11 i$0@17@11) (loc<Ref> a@1@11 i@3@11))
    (=
      (and
        (img@19@11 r)
        (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
      (and
        (img@5@11 r)
        (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))))
  
  :qid |quant-u-29|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second $t@16@11)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@16@11))
    ($Snap.second ($Snap.second $t@16@11)))))
(assert (= ($Snap.first ($Snap.second $t@16@11)) $Snap.unit))
(assert (= ($Snap.second ($Snap.second $t@16@11)) $Snap.unit))
; [eval] (forall i$1: Int :: { old(loc(a, i$1)) } left <= i$1 && i$1 < right ==> (old(loc(a, i$1).val == from) ? loc(a, i$1).val == to : loc(a, i$1).val == old(loc(a, i$1).val)))
(declare-const i$1@20@11 Int)
(set-option :timeout 0)
(push) ; 3
; [eval] left <= i$1 && i$1 < right ==> (old(loc(a, i$1).val == from) ? loc(a, i$1).val == to : loc(a, i$1).val == old(loc(a, i$1).val))
; [eval] left <= i$1 && i$1 < right
; [eval] left <= i$1
(push) ; 4
; [then-branch: 4 | !(1 <= i$1@20@11) | live]
; [else-branch: 4 | 1 <= i$1@20@11 | live]
(push) ; 5
; [then-branch: 4 | !(1 <= i$1@20@11)]
(assert (not (<= 1 i$1@20@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 4 | 1 <= i$1@20@11]
(assert (<= 1 i$1@20@11))
; [eval] i$1 < right
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 1 i$1@20@11) (not (<= 1 i$1@20@11))))
(push) ; 4
; [then-branch: 5 | 1 <= i$1@20@11 && i$1@20@11 < len[Int](a@1@11) | live]
; [else-branch: 5 | !(1 <= i$1@20@11 && i$1@20@11 < len[Int](a@1@11)) | live]
(push) ; 5
; [then-branch: 5 | 1 <= i$1@20@11 && i$1@20@11 < len[Int](a@1@11)]
(assert (and (<= 1 i$1@20@11) (< i$1@20@11 (len<Int> a@1@11))))
; [eval] (old(loc(a, i$1).val == from) ? loc(a, i$1).val == to : loc(a, i$1).val == old(loc(a, i$1).val))
; [eval] old(loc(a, i$1).val == from)
; [eval] loc(a, i$1).val == from
; [eval] loc(a, i$1)
(push) ; 6
(assert (not (and
  (img@5@11 (loc<Ref> a@1@11 i$1@20@11))
  (and
    (<= 0 (inv@4@11 (loc<Ref> a@1@11 i$1@20@11)))
    (< (inv@4@11 (loc<Ref> a@1@11 i$1@20@11)) (len<Int> a@1@11))))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
; [then-branch: 6 | Lookup(val, sm@15@11, loc[Ref](a@1@11, i$1@20@11)) == 5 | live]
; [else-branch: 6 | Lookup(val, sm@15@11, loc[Ref](a@1@11, i$1@20@11)) != 5 | live]
(push) ; 7
; [then-branch: 6 | Lookup(val, sm@15@11, loc[Ref](a@1@11, i$1@20@11)) == 5]
(assert (= ($FVF.lookup_val (as sm@15@11  $FVF<val>) (loc<Ref> a@1@11 i$1@20@11)) 5))
; [eval] loc(a, i$1).val == to
; [eval] loc(a, i$1)
(declare-const sm@21@11 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@5@11 r)
        (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
      (< $Perm.No (- $Perm.Write (pTaken@14@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@21@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r)))
  :pattern (($FVF.lookup_val (as sm@21@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@19@11 r)
      (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
    (=
      ($FVF.lookup_val (as sm@21@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r)))
  :pattern (($FVF.lookup_val (as sm@21@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r))
  :qid |qp.fvfValDef4|)))
(declare-const pm@22@11 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@22@11  $FPM) r)
    (+
      (ite
        (and
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
        (- $Perm.Write (pTaken@14@11 r))
        $Perm.No)
      (ite
        (and
          (img@19@11 r)
          (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@22@11  $FPM) r))
  :qid |qp.resPrmSumDef5|)))
(push) ; 8
(assert (not (< $Perm.No ($FVF.perm_val (as pm@22@11  $FPM) (loc<Ref> a@1@11 i$1@20@11)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 6 | Lookup(val, sm@15@11, loc[Ref](a@1@11, i$1@20@11)) != 5]
(assert (not
  (= ($FVF.lookup_val (as sm@15@11  $FVF<val>) (loc<Ref> a@1@11 i$1@20@11)) 5)))
; [eval] loc(a, i$1).val == old(loc(a, i$1).val)
; [eval] loc(a, i$1)
(declare-const sm@23@11 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@5@11 r)
        (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
      (< $Perm.No (- $Perm.Write (pTaken@14@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@23@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r)))
  :pattern (($FVF.lookup_val (as sm@23@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r))
  :qid |qp.fvfValDef6|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@19@11 r)
      (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
    (=
      ($FVF.lookup_val (as sm@23@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r)))
  :pattern (($FVF.lookup_val (as sm@23@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r))
  :qid |qp.fvfValDef7|)))
(declare-const pm@24@11 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@24@11  $FPM) r)
    (+
      (ite
        (and
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
        (- $Perm.Write (pTaken@14@11 r))
        $Perm.No)
      (ite
        (and
          (img@19@11 r)
          (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@24@11  $FPM) r))
  :qid |qp.resPrmSumDef8|)))
(push) ; 8
(assert (not (< $Perm.No ($FVF.perm_val (as pm@24@11  $FPM) (loc<Ref> a@1@11 i$1@20@11)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, i$1).val)
; [eval] loc(a, i$1)
(push) ; 8
(assert (not (and
  (img@5@11 (loc<Ref> a@1@11 i$1@20@11))
  (and
    (<= 0 (inv@4@11 (loc<Ref> a@1@11 i$1@20@11)))
    (< (inv@4@11 (loc<Ref> a@1@11 i$1@20@11)) (len<Int> a@1@11))))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@5@11 r)
        (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
      (< $Perm.No (- $Perm.Write (pTaken@14@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@21@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r)))
  :pattern (($FVF.lookup_val (as sm@21@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@19@11 r)
      (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
    (=
      ($FVF.lookup_val (as sm@21@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r)))
  :pattern (($FVF.lookup_val (as sm@21@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@22@11  $FPM) r)
    (+
      (ite
        (and
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
        (- $Perm.Write (pTaken@14@11 r))
        $Perm.No)
      (ite
        (and
          (img@19@11 r)
          (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@22@11  $FPM) r))
  :qid |qp.resPrmSumDef5|)))
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@5@11 r)
        (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
      (< $Perm.No (- $Perm.Write (pTaken@14@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@23@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r)))
  :pattern (($FVF.lookup_val (as sm@23@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r))
  :qid |qp.fvfValDef6|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@19@11 r)
      (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
    (=
      ($FVF.lookup_val (as sm@23@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r)))
  :pattern (($FVF.lookup_val (as sm@23@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r))
  :qid |qp.fvfValDef7|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@24@11  $FPM) r)
    (+
      (ite
        (and
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
        (- $Perm.Write (pTaken@14@11 r))
        $Perm.No)
      (ite
        (and
          (img@19@11 r)
          (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@24@11  $FPM) r))
  :qid |qp.resPrmSumDef8|)))
(assert (or
  (not
    (= ($FVF.lookup_val (as sm@15@11  $FVF<val>) (loc<Ref> a@1@11 i$1@20@11)) 5))
  (= ($FVF.lookup_val (as sm@15@11  $FVF<val>) (loc<Ref> a@1@11 i$1@20@11)) 5)))
(pop) ; 5
(push) ; 5
; [else-branch: 5 | !(1 <= i$1@20@11 && i$1@20@11 < len[Int](a@1@11))]
(assert (not (and (<= 1 i$1@20@11) (< i$1@20@11 (len<Int> a@1@11)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@5@11 r)
        (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
      (< $Perm.No (- $Perm.Write (pTaken@14@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@21@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r)))
  :pattern (($FVF.lookup_val (as sm@21@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@19@11 r)
      (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
    (=
      ($FVF.lookup_val (as sm@21@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r)))
  :pattern (($FVF.lookup_val (as sm@21@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@22@11  $FPM) r)
    (+
      (ite
        (and
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
        (- $Perm.Write (pTaken@14@11 r))
        $Perm.No)
      (ite
        (and
          (img@19@11 r)
          (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@22@11  $FPM) r))
  :qid |qp.resPrmSumDef5|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@5@11 r)
        (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
      (< $Perm.No (- $Perm.Write (pTaken@14@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@23@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r)))
  :pattern (($FVF.lookup_val (as sm@23@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r))
  :qid |qp.fvfValDef6|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@19@11 r)
      (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
    (=
      ($FVF.lookup_val (as sm@23@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r)))
  :pattern (($FVF.lookup_val (as sm@23@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r))
  :qid |qp.fvfValDef7|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@24@11  $FPM) r)
    (+
      (ite
        (and
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
        (- $Perm.Write (pTaken@14@11 r))
        $Perm.No)
      (ite
        (and
          (img@19@11 r)
          (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@24@11  $FPM) r))
  :qid |qp.resPrmSumDef8|)))
(assert (=>
  (and (<= 1 i$1@20@11) (< i$1@20@11 (len<Int> a@1@11)))
  (and
    (<= 1 i$1@20@11)
    (< i$1@20@11 (len<Int> a@1@11))
    (or
      (not
        (=
          ($FVF.lookup_val (as sm@15@11  $FVF<val>) (loc<Ref> a@1@11 i$1@20@11))
          5))
      (=
        ($FVF.lookup_val (as sm@15@11  $FVF<val>) (loc<Ref> a@1@11 i$1@20@11))
        5)))))
; Joined path conditions
(assert (or
  (not (and (<= 1 i$1@20@11) (< i$1@20@11 (len<Int> a@1@11))))
  (and (<= 1 i$1@20@11) (< i$1@20@11 (len<Int> a@1@11)))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@5@11 r)
        (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
      (< $Perm.No (- $Perm.Write (pTaken@14@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@21@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r)))
  :pattern (($FVF.lookup_val (as sm@21@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@19@11 r)
      (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
    (=
      ($FVF.lookup_val (as sm@21@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r)))
  :pattern (($FVF.lookup_val (as sm@21@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@22@11  $FPM) r)
    (+
      (ite
        (and
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
        (- $Perm.Write (pTaken@14@11 r))
        $Perm.No)
      (ite
        (and
          (img@19@11 r)
          (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@22@11  $FPM) r))
  :qid |qp.resPrmSumDef5|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@5@11 r)
        (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
      (< $Perm.No (- $Perm.Write (pTaken@14@11 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@23@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r)))
  :pattern (($FVF.lookup_val (as sm@23@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r))
  :qid |qp.fvfValDef6|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@19@11 r)
      (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
    (=
      ($FVF.lookup_val (as sm@23@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r)))
  :pattern (($FVF.lookup_val (as sm@23@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r))
  :qid |qp.fvfValDef7|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@24@11  $FPM) r)
    (+
      (ite
        (and
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
        (- $Perm.Write (pTaken@14@11 r))
        $Perm.No)
      (ite
        (and
          (img@19@11 r)
          (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@24@11  $FPM) r))
  :qid |qp.resPrmSumDef8|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i$1@20@11 Int)) (!
  (and
    (or (<= 1 i$1@20@11) (not (<= 1 i$1@20@11)))
    (=>
      (and (<= 1 i$1@20@11) (< i$1@20@11 (len<Int> a@1@11)))
      (and
        (<= 1 i$1@20@11)
        (< i$1@20@11 (len<Int> a@1@11))
        (or
          (not
            (=
              ($FVF.lookup_val (as sm@15@11  $FVF<val>) (loc<Ref> a@1@11 i$1@20@11))
              5))
          (=
            ($FVF.lookup_val (as sm@15@11  $FVF<val>) (loc<Ref> a@1@11 i$1@20@11))
            5))))
    (or
      (not (and (<= 1 i$1@20@11) (< i$1@20@11 (len<Int> a@1@11))))
      (and (<= 1 i$1@20@11) (< i$1@20@11 (len<Int> a@1@11)))))
  :pattern ((loc<Ref> a@1@11 i$1@20@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/parallel-array-replace/parallel-array-replace.vpr@16@12@16@33-aux|)))
(assert (forall ((i$1@20@11 Int)) (!
  (=>
    (and (<= 1 i$1@20@11) (< i$1@20@11 (len<Int> a@1@11)))
    (ite
      (=
        ($FVF.lookup_val (as sm@15@11  $FVF<val>) (loc<Ref> a@1@11 i$1@20@11))
        5)
      (=
        ($FVF.lookup_val (as sm@21@11  $FVF<val>) (loc<Ref> a@1@11 i$1@20@11))
        7)
      (=
        ($FVF.lookup_val (as sm@23@11  $FVF<val>) (loc<Ref> a@1@11 i$1@20@11))
        ($FVF.lookup_val (as sm@15@11  $FVF<val>) (loc<Ref> a@1@11 i$1@20@11)))))
  :pattern ((loc<Ref> a@1@11 i$1@20@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/parallel-array-replace/parallel-array-replace.vpr@16@12@16@33|)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
; [exec]
; assert Contains(a, 5, 1)
; [eval] Contains(a, 5, 1)
(set-option :timeout 0)
(push) ; 3
; [eval] 0 <= before
; [eval] before <= len(a)
; [eval] len(a)
(declare-const i@25@11 Int)
(push) ; 4
; [eval] 0 <= i && i < before
; [eval] 0 <= i
(push) ; 5
; [then-branch: 7 | !(0 <= i@25@11) | live]
; [else-branch: 7 | 0 <= i@25@11 | live]
(push) ; 6
; [then-branch: 7 | !(0 <= i@25@11)]
(assert (not (<= 0 i@25@11)))
(pop) ; 6
(push) ; 6
; [else-branch: 7 | 0 <= i@25@11]
(assert (<= 0 i@25@11))
; [eval] i < before
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@25@11) (not (<= 0 i@25@11))))
(assert (and (<= 0 i@25@11) (< i@25@11 1)))
; [eval] loc(a, i)
(pop) ; 4
(declare-fun inv@26@11 ($Ref) Int)
(declare-fun img@27@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@25@11 Int)) (!
  (=>
    (and (<= 0 i@25@11) (< i@25@11 1))
    (or (<= 0 i@25@11) (not (<= 0 i@25@11))))
  :pattern ((loc<Ref> a@1@11 i@25@11))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 4
(assert (not (forall ((i1@25@11 Int) (i2@25@11 Int)) (!
  (=>
    (and
      (and (<= 0 i1@25@11) (< i1@25@11 1))
      (and (<= 0 i2@25@11) (< i2@25@11 1))
      (= (loc<Ref> a@1@11 i1@25@11) (loc<Ref> a@1@11 i2@25@11)))
    (= i1@25@11 i2@25@11))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@25@11 Int)) (!
  (=>
    (and (<= 0 i@25@11) (< i@25@11 1))
    (and
      (= (inv@26@11 (loc<Ref> a@1@11 i@25@11)) i@25@11)
      (img@27@11 (loc<Ref> a@1@11 i@25@11))))
  :pattern ((loc<Ref> a@1@11 i@25@11))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@27@11 r) (and (<= 0 (inv@26@11 r)) (< (inv@26@11 r) 1)))
    (= (loc<Ref> a@1@11 (inv@26@11 r)) r))
  :pattern ((inv@26@11 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@28@11 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= 0 (inv@26@11 r)) (< (inv@26@11 r) 1))
      (img@27@11 r)
      (= r (loc<Ref> a@1@11 (inv@26@11 r))))
    ($Perm.min
      (ite
        (and
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
        (- $Perm.Write (pTaken@14@11 r))
        $Perm.No)
      $Perm.Write)
    $Perm.No))
(define-fun pTaken@29@11 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= 0 (inv@26@11 r)) (< (inv@26@11 r) 1))
      (img@27@11 r)
      (= r (loc<Ref> a@1@11 (inv@26@11 r))))
    ($Perm.min
      (ite
        (and
          (img@19@11 r)
          (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11))))
        $Perm.Write
        $Perm.No)
      (- $Perm.Write (pTaken@28@11 r)))
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
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
        (- $Perm.Write (pTaken@14@11 r))
        $Perm.No)
      (pTaken@28@11 r))
    $Perm.No)
  
  :qid |quant-u-36|))))
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
      (and (<= 0 (inv@26@11 r)) (< (inv@26@11 r) 1))
      (img@27@11 r)
      (= r (loc<Ref> a@1@11 (inv@26@11 r))))
    (= (- $Perm.Write (pTaken@28@11 r)) $Perm.No))
  
  :qid |quant-u-37|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@30@11 $FVF<val>)
; Definitional axioms for snapshot map domain
(assert (forall ((r $Ref)) (!
  (and
    (=>
      (Set_in r ($FVF.domain_val (as sm@30@11  $FVF<val>)))
      (and (and (<= 0 (inv@26@11 r)) (< (inv@26@11 r) 1)) (img@27@11 r)))
    (=>
      (and (and (<= 0 (inv@26@11 r)) (< (inv@26@11 r) 1)) (img@27@11 r))
      (Set_in r ($FVF.domain_val (as sm@30@11  $FVF<val>)))))
  :pattern ((Set_in r ($FVF.domain_val (as sm@30@11  $FVF<val>))))
  :qid |qp.fvfDomDef11|)))
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (and (and (<= 0 (inv@26@11 r)) (< (inv@26@11 r) 1)) (img@27@11 r))
      (ite
        (and
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
        (< $Perm.No (- $Perm.Write (pTaken@14@11 r)))
        false))
    (=
      ($FVF.lookup_val (as sm@30@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r)))
  :pattern (($FVF.lookup_val (as sm@30@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r))
  :qid |qp.fvfValDef9|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (and (and (<= 0 (inv@26@11 r)) (< (inv@26@11 r) 1)) (img@27@11 r))
      (and
        (img@19@11 r)
        (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11)))))
    (=
      ($FVF.lookup_val (as sm@30@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r)))
  :pattern (($FVF.lookup_val (as sm@30@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r))
  :qid |qp.fvfValDef10|)))
(assert (Contains%precondition ($Snap.combine
  $Snap.unit
  ($Snap.combine
    $Snap.unit
    ($SortWrappers.$FVF<val>To$Snap (as sm@30@11  $FVF<val>)))) a@1@11 5 1))
(pop) ; 3
; Joined path conditions
(assert (forall ((i@25@11 Int)) (!
  (=>
    (and (<= 0 i@25@11) (< i@25@11 1))
    (and
      (= (inv@26@11 (loc<Ref> a@1@11 i@25@11)) i@25@11)
      (img@27@11 (loc<Ref> a@1@11 i@25@11))))
  :pattern ((loc<Ref> a@1@11 i@25@11))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@27@11 r) (and (<= 0 (inv@26@11 r)) (< (inv@26@11 r) 1)))
    (= (loc<Ref> a@1@11 (inv@26@11 r)) r))
  :pattern ((inv@26@11 r))
  :qid |val-fctOfInv|)))
(assert (forall ((r $Ref)) (!
  (and
    (=>
      (Set_in r ($FVF.domain_val (as sm@30@11  $FVF<val>)))
      (and (and (<= 0 (inv@26@11 r)) (< (inv@26@11 r) 1)) (img@27@11 r)))
    (=>
      (and (and (<= 0 (inv@26@11 r)) (< (inv@26@11 r) 1)) (img@27@11 r))
      (Set_in r ($FVF.domain_val (as sm@30@11  $FVF<val>)))))
  :pattern ((Set_in r ($FVF.domain_val (as sm@30@11  $FVF<val>))))
  :qid |qp.fvfDomDef11|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (and (and (<= 0 (inv@26@11 r)) (< (inv@26@11 r) 1)) (img@27@11 r))
      (ite
        (and
          (img@5@11 r)
          (and (<= 0 (inv@4@11 r)) (< (inv@4@11 r) (len<Int> a@1@11))))
        (< $Perm.No (- $Perm.Write (pTaken@14@11 r)))
        false))
    (=
      ($FVF.lookup_val (as sm@30@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r)))
  :pattern (($FVF.lookup_val (as sm@30@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second $t@2@11))) r))
  :qid |qp.fvfValDef9|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (and (and (<= 0 (inv@26@11 r)) (< (inv@26@11 r) 1)) (img@27@11 r))
      (and
        (img@19@11 r)
        (and (<= 1 (inv@18@11 r)) (< (inv@18@11 r) (len<Int> a@1@11)))))
    (=
      ($FVF.lookup_val (as sm@30@11  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r)))
  :pattern (($FVF.lookup_val (as sm@30@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@16@11)) r))
  :qid |qp.fvfValDef10|)))
(assert (and
  (forall ((i@25@11 Int)) (!
    (=>
      (and (<= 0 i@25@11) (< i@25@11 1))
      (or (<= 0 i@25@11) (not (<= 0 i@25@11))))
    :pattern ((loc<Ref> a@1@11 i@25@11))
    :qid |val-aux|))
  (Contains%precondition ($Snap.combine
    $Snap.unit
    ($Snap.combine
      $Snap.unit
      ($SortWrappers.$FVF<val>To$Snap (as sm@30@11  $FVF<val>)))) a@1@11 5 1)))
(set-option :timeout 0)
(push) ; 3
(assert (not (Contains ($Snap.combine
  $Snap.unit
  ($Snap.combine
    $Snap.unit
    ($SortWrappers.$FVF<val>To$Snap (as sm@30@11  $FVF<val>)))) a@1@11 5 1)))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (Contains ($Snap.combine
  $Snap.unit
  ($Snap.combine
    $Snap.unit
    ($SortWrappers.$FVF<val>To$Snap (as sm@30@11  $FVF<val>)))) a@1@11 5 1))
(pop) ; 2
(pop) ; 1
