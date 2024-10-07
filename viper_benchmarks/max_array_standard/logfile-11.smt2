(get-info :version)
; (:version "4.13.0")
; Started: 2024-09-24 15:24:21
; Silicon.version: 1.1-SNAPSHOT (b737e366)
; Input file: /Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-standard.vpr
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
; End function- and predicate-related preamble
; ------------------------------------------------------------
; ---------- client ----------
(set-option :timeout 0)
(push) ; 1
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
(set-option :timeout 0)
(push) ; 2
(pop) ; 2
(push) ; 2
; [exec]
; var a: IArray
(declare-const a@0@11 IArray)
; [exec]
; var x: Int
(declare-const x@1@11 Int)
; [exec]
; inhale len(a) == 3
(declare-const $t@2@11 $Snap)
(assert (= $t@2@11 $Snap.unit))
; [eval] len(a) == 3
; [eval] len(a)
(assert (= (len<Int> a@0@11) 3))
; State saturation: after inhale
(set-option :timeout 20)
(check-sat)
; unknown
; [exec]
; inhale (forall j: Int ::0 <= j && j < len(a) ==> acc(loc(a, j).val, write))
(declare-const j@3@11 Int)
(set-option :timeout 0)
(push) ; 3
; [eval] 0 <= j && j < len(a)
; [eval] 0 <= j
(push) ; 4
; [then-branch: 0 | !(0 <= j@3@11) | live]
; [else-branch: 0 | 0 <= j@3@11 | live]
(push) ; 5
; [then-branch: 0 | !(0 <= j@3@11)]
(assert (not (<= 0 j@3@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 0 | 0 <= j@3@11]
(assert (<= 0 j@3@11))
; [eval] j < len(a)
; [eval] len(a)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j@3@11) (not (<= 0 j@3@11))))
(assert (and (<= 0 j@3@11) (< j@3@11 (len<Int> a@0@11))))
; [eval] loc(a, j)
(pop) ; 3
(declare-const $t@4@11 $FVF<val>)
(declare-fun inv@5@11 ($Ref) Int)
(declare-fun img@6@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((j@3@11 Int)) (!
  (=>
    (and (<= 0 j@3@11) (< j@3@11 (len<Int> a@0@11)))
    (or (<= 0 j@3@11) (not (<= 0 j@3@11))))
  :pattern ((loc<Ref> a@0@11 j@3@11))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((j1@3@11 Int) (j2@3@11 Int)) (!
  (=>
    (and
      (and (<= 0 j1@3@11) (< j1@3@11 (len<Int> a@0@11)))
      (and (<= 0 j2@3@11) (< j2@3@11 (len<Int> a@0@11)))
      (= (loc<Ref> a@0@11 j1@3@11) (loc<Ref> a@0@11 j2@3@11)))
    (= j1@3@11 j2@3@11))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((j@3@11 Int)) (!
  (=>
    (and (<= 0 j@3@11) (< j@3@11 (len<Int> a@0@11)))
    (and
      (= (inv@5@11 (loc<Ref> a@0@11 j@3@11)) j@3@11)
      (img@6@11 (loc<Ref> a@0@11 j@3@11))))
  :pattern ((loc<Ref> a@0@11 j@3@11))
  :qid |quant-u-2|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@6@11 r)
      (and (<= 0 (inv@5@11 r)) (< (inv@5@11 r) (len<Int> a@0@11))))
    (= (loc<Ref> a@0@11 (inv@5@11 r)) r))
  :pattern ((inv@5@11 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((j@3@11 Int)) (!
  (=>
    (and (<= 0 j@3@11) (< j@3@11 (len<Int> a@0@11)))
    (not (= (loc<Ref> a@0@11 j@3@11) $Ref.null)))
  :pattern ((loc<Ref> a@0@11 j@3@11))
  :qid |val-permImpliesNonNull|)))
; State saturation: after inhale
(set-option :timeout 20)
(check-sat)
; unknown
; [exec]
; inhale (forall i: Int ::
;     { loc(a, i) }
;     0 <= i && i < len(a) ==> loc(a, i).val == i)
(declare-const $t@7@11 $Snap)
(assert (= $t@7@11 $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i) } 0 <= i && i < len(a) ==> loc(a, i).val == i)
(declare-const i@8@11 Int)
(set-option :timeout 0)
(push) ; 3
; [eval] 0 <= i && i < len(a) ==> loc(a, i).val == i
; [eval] 0 <= i && i < len(a)
; [eval] 0 <= i
(push) ; 4
; [then-branch: 1 | !(0 <= i@8@11) | live]
; [else-branch: 1 | 0 <= i@8@11 | live]
(push) ; 5
; [then-branch: 1 | !(0 <= i@8@11)]
(assert (not (<= 0 i@8@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 1 | 0 <= i@8@11]
(assert (<= 0 i@8@11))
; [eval] i < len(a)
; [eval] len(a)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@8@11) (not (<= 0 i@8@11))))
(push) ; 4
; [then-branch: 2 | 0 <= i@8@11 && i@8@11 < len[Int](a@0@11) | live]
; [else-branch: 2 | !(0 <= i@8@11 && i@8@11 < len[Int](a@0@11)) | live]
(push) ; 5
; [then-branch: 2 | 0 <= i@8@11 && i@8@11 < len[Int](a@0@11)]
(assert (and (<= 0 i@8@11) (< i@8@11 (len<Int> a@0@11))))
; [eval] loc(a, i).val == i
; [eval] loc(a, i)
(push) ; 6
(assert (not (and
  (img@6@11 (loc<Ref> a@0@11 i@8@11))
  (and
    (<= 0 (inv@5@11 (loc<Ref> a@0@11 i@8@11)))
    (< (inv@5@11 (loc<Ref> a@0@11 i@8@11)) (len<Int> a@0@11))))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 2 | !(0 <= i@8@11 && i@8@11 < len[Int](a@0@11))]
(assert (not (and (<= 0 i@8@11) (< i@8@11 (len<Int> a@0@11)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= 0 i@8@11) (< i@8@11 (len<Int> a@0@11))))
  (and (<= 0 i@8@11) (< i@8@11 (len<Int> a@0@11)))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@8@11 Int)) (!
  (and
    (or (<= 0 i@8@11) (not (<= 0 i@8@11)))
    (or
      (not (and (<= 0 i@8@11) (< i@8@11 (len<Int> a@0@11))))
      (and (<= 0 i@8@11) (< i@8@11 (len<Int> a@0@11)))))
  :pattern ((loc<Ref> a@0@11 i@8@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-standard.vpr@47@10@47@70-aux|)))
(assert (forall ((i@8@11 Int)) (!
  (=>
    (and (<= 0 i@8@11) (< i@8@11 (len<Int> a@0@11)))
    (= ($FVF.lookup_val $t@4@11 (loc<Ref> a@0@11 i@8@11)) i@8@11))
  :pattern ((loc<Ref> a@0@11 i@8@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-standard.vpr@47@10@47@70|)))
; State saturation: after inhale
(set-option :timeout 20)
(check-sat)
; unknown
; [exec]
; x := max(a)
(declare-const j@9@11 Int)
(set-option :timeout 0)
(push) ; 3
; [eval] 0 <= j && j < len(a)
; [eval] 0 <= j
(push) ; 4
; [then-branch: 3 | !(0 <= j@9@11) | live]
; [else-branch: 3 | 0 <= j@9@11 | live]
(push) ; 5
; [then-branch: 3 | !(0 <= j@9@11)]
(assert (not (<= 0 j@9@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 3 | 0 <= j@9@11]
(assert (<= 0 j@9@11))
; [eval] j < len(a)
; [eval] len(a)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j@9@11) (not (<= 0 j@9@11))))
(assert (and (<= 0 j@9@11) (< j@9@11 (len<Int> a@0@11))))
; [eval] loc(a, j)
(pop) ; 3
(declare-fun inv@10@11 ($Ref) Int)
(declare-fun img@11@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((j@9@11 Int)) (!
  (=>
    (and (<= 0 j@9@11) (< j@9@11 (len<Int> a@0@11)))
    (or (<= 0 j@9@11) (not (<= 0 j@9@11))))
  :pattern ((loc<Ref> a@0@11 j@9@11))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((j1@9@11 Int) (j2@9@11 Int)) (!
  (=>
    (and
      (and (<= 0 j1@9@11) (< j1@9@11 (len<Int> a@0@11)))
      (and (<= 0 j2@9@11) (< j2@9@11 (len<Int> a@0@11)))
      (= (loc<Ref> a@0@11 j1@9@11) (loc<Ref> a@0@11 j2@9@11)))
    (= j1@9@11 j2@9@11))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((j@9@11 Int)) (!
  (=>
    (and (<= 0 j@9@11) (< j@9@11 (len<Int> a@0@11)))
    (and
      (= (inv@10@11 (loc<Ref> a@0@11 j@9@11)) j@9@11)
      (img@11@11 (loc<Ref> a@0@11 j@9@11))))
  :pattern ((loc<Ref> a@0@11 j@9@11))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@11@11 r)
      (and (<= 0 (inv@10@11 r)) (< (inv@10@11 r) (len<Int> a@0@11))))
    (= (loc<Ref> a@0@11 (inv@10@11 r)) r))
  :pattern ((inv@10@11 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@12@11 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= 0 (inv@10@11 r)) (< (inv@10@11 r) (len<Int> a@0@11)))
      (img@11@11 r)
      (= r (loc<Ref> a@0@11 (inv@10@11 r))))
    ($Perm.min
      (ite
        (and
          (img@6@11 r)
          (and (<= 0 (inv@5@11 r)) (< (inv@5@11 r) (len<Int> a@0@11))))
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
          (img@6@11 r)
          (and (<= 0 (inv@5@11 r)) (< (inv@5@11 r) (len<Int> a@0@11))))
        $Perm.Write
        $Perm.No)
      (pTaken@12@11 r))
    $Perm.No)
  
  :qid |quant-u-8|))))
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
      (and (<= 0 (inv@10@11 r)) (< (inv@10@11 r) (len<Int> a@0@11)))
      (img@11@11 r)
      (= r (loc<Ref> a@0@11 (inv@10@11 r))))
    (= (- $Perm.Write (pTaken@12@11 r)) $Perm.No))
  
  :qid |quant-u-9|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@13@11 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@6@11 r)
      (and (<= 0 (inv@5@11 r)) (< (inv@5@11 r) (len<Int> a@0@11))))
    (= ($FVF.lookup_val (as sm@13@11  $FVF<val>) r) ($FVF.lookup_val $t@4@11 r)))
  :pattern (($FVF.lookup_val (as sm@13@11  $FVF<val>) r))
  :pattern (($FVF.lookup_val $t@4@11 r))
  :qid |qp.fvfValDef0|)))
(declare-const at@14@11 Int)
(declare-const $t@15@11 $Snap)
(assert (= $t@15@11 ($Snap.combine ($Snap.first $t@15@11) ($Snap.second $t@15@11))))
(declare-const j$0@16@11 Int)
(set-option :timeout 0)
(push) ; 3
; [eval] 0 <= j$0 && j$0 < len(a)
; [eval] 0 <= j$0
(push) ; 4
; [then-branch: 4 | !(0 <= j$0@16@11) | live]
; [else-branch: 4 | 0 <= j$0@16@11 | live]
(push) ; 5
; [then-branch: 4 | !(0 <= j$0@16@11)]
(assert (not (<= 0 j$0@16@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 4 | 0 <= j$0@16@11]
(assert (<= 0 j$0@16@11))
; [eval] j$0 < len(a)
; [eval] len(a)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$0@16@11) (not (<= 0 j$0@16@11))))
(assert (and (<= 0 j$0@16@11) (< j$0@16@11 (len<Int> a@0@11))))
; [eval] loc(a, j$0)
(pop) ; 3
(declare-fun inv@17@11 ($Ref) Int)
(declare-fun img@18@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((j$0@16@11 Int)) (!
  (=>
    (and (<= 0 j$0@16@11) (< j$0@16@11 (len<Int> a@0@11)))
    (or (<= 0 j$0@16@11) (not (<= 0 j$0@16@11))))
  :pattern ((loc<Ref> a@0@11 j$0@16@11))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((j$01@16@11 Int) (j$02@16@11 Int)) (!
  (=>
    (and
      (and (<= 0 j$01@16@11) (< j$01@16@11 (len<Int> a@0@11)))
      (and (<= 0 j$02@16@11) (< j$02@16@11 (len<Int> a@0@11)))
      (= (loc<Ref> a@0@11 j$01@16@11) (loc<Ref> a@0@11 j$02@16@11)))
    (= j$01@16@11 j$02@16@11))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((j$0@16@11 Int)) (!
  (=>
    (and (<= 0 j$0@16@11) (< j$0@16@11 (len<Int> a@0@11)))
    (and
      (= (inv@17@11 (loc<Ref> a@0@11 j$0@16@11)) j$0@16@11)
      (img@18@11 (loc<Ref> a@0@11 j$0@16@11))))
  :pattern ((loc<Ref> a@0@11 j$0@16@11))
  :qid |quant-u-12|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@18@11 r)
      (and (<= 0 (inv@17@11 r)) (< (inv@17@11 r) (len<Int> a@0@11))))
    (= (loc<Ref> a@0@11 (inv@17@11 r)) r))
  :pattern ((inv@17@11 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((j$0@16@11 Int)) (!
  (=>
    (and (<= 0 j$0@16@11) (< j$0@16@11 (len<Int> a@0@11)))
    (not (= (loc<Ref> a@0@11 j$0@16@11) $Ref.null)))
  :pattern ((loc<Ref> a@0@11 j$0@16@11))
  :qid |val-permImpliesNonNull|)))
(assert (=
  ($Snap.second $t@15@11)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@15@11))
    ($Snap.second ($Snap.second $t@15@11)))))
(assert (= ($Snap.first ($Snap.second $t@15@11)) $Snap.unit))
; [eval] (forall j$1: Int :: { old(loc(a, j$1)) } 0 <= j$1 && j$1 < len(a) ==> loc(a, j$1).val == old(loc(a, j$1).val))
(declare-const j$1@19@11 Int)
(push) ; 3
; [eval] 0 <= j$1 && j$1 < len(a) ==> loc(a, j$1).val == old(loc(a, j$1).val)
; [eval] 0 <= j$1 && j$1 < len(a)
; [eval] 0 <= j$1
(push) ; 4
; [then-branch: 5 | !(0 <= j$1@19@11) | live]
; [else-branch: 5 | 0 <= j$1@19@11 | live]
(push) ; 5
; [then-branch: 5 | !(0 <= j$1@19@11)]
(assert (not (<= 0 j$1@19@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 5 | 0 <= j$1@19@11]
(assert (<= 0 j$1@19@11))
; [eval] j$1 < len(a)
; [eval] len(a)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$1@19@11) (not (<= 0 j$1@19@11))))
(push) ; 4
; [then-branch: 6 | 0 <= j$1@19@11 && j$1@19@11 < len[Int](a@0@11) | live]
; [else-branch: 6 | !(0 <= j$1@19@11 && j$1@19@11 < len[Int](a@0@11)) | live]
(push) ; 5
; [then-branch: 6 | 0 <= j$1@19@11 && j$1@19@11 < len[Int](a@0@11)]
(assert (and (<= 0 j$1@19@11) (< j$1@19@11 (len<Int> a@0@11))))
; [eval] loc(a, j$1).val == old(loc(a, j$1).val)
; [eval] loc(a, j$1)
(push) ; 6
(assert (not (and
  (img@18@11 (loc<Ref> a@0@11 j$1@19@11))
  (and
    (<= 0 (inv@17@11 (loc<Ref> a@0@11 j$1@19@11)))
    (< (inv@17@11 (loc<Ref> a@0@11 j$1@19@11)) (len<Int> a@0@11))))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] old(loc(a, j$1).val)
; [eval] loc(a, j$1)
(push) ; 6
(assert (not (and
  (img@6@11 (loc<Ref> a@0@11 j$1@19@11))
  (and
    (<= 0 (inv@5@11 (loc<Ref> a@0@11 j$1@19@11)))
    (< (inv@5@11 (loc<Ref> a@0@11 j$1@19@11)) (len<Int> a@0@11))))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 6 | !(0 <= j$1@19@11 && j$1@19@11 < len[Int](a@0@11))]
(assert (not (and (<= 0 j$1@19@11) (< j$1@19@11 (len<Int> a@0@11)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= 0 j$1@19@11) (< j$1@19@11 (len<Int> a@0@11))))
  (and (<= 0 j$1@19@11) (< j$1@19@11 (len<Int> a@0@11)))))
; [eval] old(loc(a, j$1))
; [eval] loc(a, j$1)
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((j$1@19@11 Int)) (!
  (and
    (or (<= 0 j$1@19@11) (not (<= 0 j$1@19@11)))
    (or
      (not (and (<= 0 j$1@19@11) (< j$1@19@11 (len<Int> a@0@11))))
      (and (<= 0 j$1@19@11) (< j$1@19@11 (len<Int> a@0@11)))))
  :pattern ((loc<Ref> a@0@11 j$1@19@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-standard.vpr@19@25@19@37-aux|)))
(assert (forall ((j$1@19@11 Int)) (!
  (=>
    (and (<= 0 j$1@19@11) (< j$1@19@11 (len<Int> a@0@11)))
    (=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@15@11)) (loc<Ref> a@0@11 j$1@19@11))
      ($FVF.lookup_val (as sm@13@11  $FVF<val>) (loc<Ref> a@0@11 j$1@19@11))))
  :pattern ((loc<Ref> a@0@11 j$1@19@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-standard.vpr@19@25@19@37|)))
(assert (=
  ($Snap.second ($Snap.second $t@15@11))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@15@11)))
    ($Snap.second ($Snap.second ($Snap.second $t@15@11))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@15@11))) $Snap.unit))
; [eval] (len(a) == 0 ? at == -1 : 0 <= at && at < len(a))
; [eval] len(a) == 0
; [eval] len(a)
(push) ; 3
(push) ; 4
(set-option :timeout 10)
(assert (not (not (= (len<Int> a@0@11) 0))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; [then-branch: 7 | len[Int](a@0@11) == 0 | dead]
; [else-branch: 7 | len[Int](a@0@11) != 0 | live]
(set-option :timeout 0)
(push) ; 4
; [else-branch: 7 | len[Int](a@0@11) != 0]
(assert (not (= (len<Int> a@0@11) 0)))
; [eval] 0 <= at && at < len(a)
; [eval] 0 <= at
(push) ; 5
; [then-branch: 8 | !(0 <= at@14@11) | live]
; [else-branch: 8 | 0 <= at@14@11 | live]
(push) ; 6
; [then-branch: 8 | !(0 <= at@14@11)]
(assert (not (<= 0 at@14@11)))
(pop) ; 6
(push) ; 6
; [else-branch: 8 | 0 <= at@14@11]
(assert (<= 0 at@14@11))
; [eval] at < len(a)
; [eval] len(a)
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 at@14@11) (not (<= 0 at@14@11))))
(pop) ; 4
(pop) ; 3
; Joined path conditions
(assert (=>
  (not (= (len<Int> a@0@11) 0))
  (and (not (= (len<Int> a@0@11) 0)) (or (<= 0 at@14@11) (not (<= 0 at@14@11))))))
(assert (not (= (len<Int> a@0@11) 0)))
(assert (and (<= 0 at@14@11) (< at@14@11 (len<Int> a@0@11))))
(assert (= ($Snap.second ($Snap.second ($Snap.second $t@15@11))) $Snap.unit))
; [eval] (forall j$2: Int :: { loc(a, j$2) } 0 <= j$2 && j$2 < len(a) ==> loc(a, j$2).val <= loc(a, at).val)
(declare-const j$2@20@11 Int)
(push) ; 3
; [eval] 0 <= j$2 && j$2 < len(a) ==> loc(a, j$2).val <= loc(a, at).val
; [eval] 0 <= j$2 && j$2 < len(a)
; [eval] 0 <= j$2
(push) ; 4
; [then-branch: 9 | !(0 <= j$2@20@11) | live]
; [else-branch: 9 | 0 <= j$2@20@11 | live]
(push) ; 5
; [then-branch: 9 | !(0 <= j$2@20@11)]
(assert (not (<= 0 j$2@20@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 9 | 0 <= j$2@20@11]
(assert (<= 0 j$2@20@11))
; [eval] j$2 < len(a)
; [eval] len(a)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 j$2@20@11) (not (<= 0 j$2@20@11))))
(push) ; 4
; [then-branch: 10 | 0 <= j$2@20@11 && j$2@20@11 < len[Int](a@0@11) | live]
; [else-branch: 10 | !(0 <= j$2@20@11 && j$2@20@11 < len[Int](a@0@11)) | live]
(push) ; 5
; [then-branch: 10 | 0 <= j$2@20@11 && j$2@20@11 < len[Int](a@0@11)]
(assert (and (<= 0 j$2@20@11) (< j$2@20@11 (len<Int> a@0@11))))
; [eval] loc(a, j$2).val <= loc(a, at).val
; [eval] loc(a, j$2)
(push) ; 6
(assert (not (and
  (img@18@11 (loc<Ref> a@0@11 j$2@20@11))
  (and
    (<= 0 (inv@17@11 (loc<Ref> a@0@11 j$2@20@11)))
    (< (inv@17@11 (loc<Ref> a@0@11 j$2@20@11)) (len<Int> a@0@11))))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] loc(a, at)
(push) ; 6
(assert (not (and
  (img@18@11 (loc<Ref> a@0@11 at@14@11))
  (and
    (<= 0 (inv@17@11 (loc<Ref> a@0@11 at@14@11)))
    (< (inv@17@11 (loc<Ref> a@0@11 at@14@11)) (len<Int> a@0@11))))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 10 | !(0 <= j$2@20@11 && j$2@20@11 < len[Int](a@0@11))]
(assert (not (and (<= 0 j$2@20@11) (< j$2@20@11 (len<Int> a@0@11)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or
  (not (and (<= 0 j$2@20@11) (< j$2@20@11 (len<Int> a@0@11))))
  (and (<= 0 j$2@20@11) (< j$2@20@11 (len<Int> a@0@11)))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((j$2@20@11 Int)) (!
  (and
    (or (<= 0 j$2@20@11) (not (<= 0 j$2@20@11)))
    (or
      (not (and (<= 0 j$2@20@11) (< j$2@20@11 (len<Int> a@0@11))))
      (and (<= 0 j$2@20@11) (< j$2@20@11 (len<Int> a@0@11)))))
  :pattern ((loc<Ref> a@0@11 j$2@20@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-standard.vpr@21@12@21@33-aux|)))
(assert (forall ((j$2@20@11 Int)) (!
  (=>
    (and (<= 0 j$2@20@11) (< j$2@20@11 (len<Int> a@0@11)))
    (<=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@15@11)) (loc<Ref> a@0@11 j$2@20@11))
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@15@11)) (loc<Ref> a@0@11 at@14@11))))
  :pattern ((loc<Ref> a@0@11 j$2@20@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/max_array/max-array-standard.vpr@21@12@21@33|)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
; [exec]
; assert loc(a, 0).val <= x
; [eval] loc(a, 0).val <= x
; [eval] loc(a, 0)
(set-option :timeout 0)
(push) ; 3
(assert (not (and
  (img@18@11 (loc<Ref> a@0@11 0))
  (and
    (<= 0 (inv@17@11 (loc<Ref> a@0@11 0)))
    (< (inv@17@11 (loc<Ref> a@0@11 0)) (len<Int> a@0@11))))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(push) ; 3
(assert (not (<=
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@15@11)) (loc<Ref> a@0@11 0))
  at@14@11)))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (<=
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@15@11)) (loc<Ref> a@0@11 0))
  at@14@11))
; [exec]
; assert x == loc(a, len(a) - 1).val
; [eval] x == loc(a, len(a) - 1).val
; [eval] loc(a, len(a) - 1)
; [eval] len(a) - 1
; [eval] len(a)
(push) ; 3
(assert (not (and
  (img@18@11 (loc<Ref> a@0@11 (- (len<Int> a@0@11) 1)))
  (and
    (<= 0 (inv@17@11 (loc<Ref> a@0@11 (- (len<Int> a@0@11) 1))))
    (< (inv@17@11 (loc<Ref> a@0@11 (- (len<Int> a@0@11) 1))) (len<Int> a@0@11))))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(push) ; 3
(assert (not (=
  at@14@11
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@15@11)) (loc<Ref> a@0@11 (-
    (len<Int> a@0@11)
    1))))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (=
  at@14@11
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@15@11)) (loc<Ref> a@0@11 (-
    (len<Int> a@0@11)
    1)))))
; [exec]
; assert x == 2
; [eval] x == 2
(push) ; 3
(assert (not (= at@14@11 2)))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (= at@14@11 2))
; [exec]
; assert loc(a, 1).val < x
; [eval] loc(a, 1).val < x
; [eval] loc(a, 1)
(push) ; 3
(assert (not (and
  (img@18@11 (loc<Ref> a@0@11 1))
  (and
    (<= 0 (inv@17@11 (loc<Ref> a@0@11 1)))
    (< (inv@17@11 (loc<Ref> a@0@11 1)) (len<Int> a@0@11))))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(push) ; 3
(assert (not (<
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@15@11)) (loc<Ref> a@0@11 1))
  at@14@11)))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (<
  ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first $t@15@11)) (loc<Ref> a@0@11 1))
  at@14@11))
(pop) ; 2
(pop) ; 1
