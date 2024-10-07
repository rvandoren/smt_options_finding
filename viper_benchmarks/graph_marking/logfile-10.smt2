(get-info :version)
; (:version "4.13.0")
; Started: 2024-09-24 15:21:04
; Silicon.version: 1.1-SNAPSHOT (b737e366)
; Input file: /Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr
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
(declare-sort Set<$Ref> 0)
(declare-sort Set<Bool> 0)
(declare-sort Set<$Snap> 0)
(declare-sort $FVF<left> 0)
(declare-sort $FVF<right> 0)
(declare-sort $FVF<is_marked> 0)
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
(declare-fun $SortWrappers.$FVF<left>To$Snap ($FVF<left>) $Snap)
(declare-fun $SortWrappers.$SnapTo$FVF<left> ($Snap) $FVF<left>)
(assert (forall ((x $FVF<left>)) (!
    (= x ($SortWrappers.$SnapTo$FVF<left>($SortWrappers.$FVF<left>To$Snap x)))
    :pattern (($SortWrappers.$FVF<left>To$Snap x))
    :qid |$Snap.$SnapTo$FVF<left>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.$FVF<left>To$Snap($SortWrappers.$SnapTo$FVF<left> x)))
    :pattern (($SortWrappers.$SnapTo$FVF<left> x))
    :qid |$Snap.$FVF<left>To$SnapTo$FVF<left>|
    )))
(declare-fun $SortWrappers.$FVF<right>To$Snap ($FVF<right>) $Snap)
(declare-fun $SortWrappers.$SnapTo$FVF<right> ($Snap) $FVF<right>)
(assert (forall ((x $FVF<right>)) (!
    (= x ($SortWrappers.$SnapTo$FVF<right>($SortWrappers.$FVF<right>To$Snap x)))
    :pattern (($SortWrappers.$FVF<right>To$Snap x))
    :qid |$Snap.$SnapTo$FVF<right>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.$FVF<right>To$Snap($SortWrappers.$SnapTo$FVF<right> x)))
    :pattern (($SortWrappers.$SnapTo$FVF<right> x))
    :qid |$Snap.$FVF<right>To$SnapTo$FVF<right>|
    )))
(declare-fun $SortWrappers.$FVF<is_marked>To$Snap ($FVF<is_marked>) $Snap)
(declare-fun $SortWrappers.$SnapTo$FVF<is_marked> ($Snap) $FVF<is_marked>)
(assert (forall ((x $FVF<is_marked>)) (!
    (= x ($SortWrappers.$SnapTo$FVF<is_marked>($SortWrappers.$FVF<is_marked>To$Snap x)))
    :pattern (($SortWrappers.$FVF<is_marked>To$Snap x))
    :qid |$Snap.$SnapTo$FVF<is_marked>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.$FVF<is_marked>To$Snap($SortWrappers.$SnapTo$FVF<is_marked> x)))
    :pattern (($SortWrappers.$SnapTo$FVF<is_marked> x))
    :qid |$Snap.$FVF<is_marked>To$SnapTo$FVF<is_marked>|
    )))
; ////////// Symbols
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
; /field_value_functions_declarations.smt2 [left: Ref]
(declare-fun $FVF.domain_left ($FVF<left>) Set<$Ref>)
(declare-fun $FVF.lookup_left ($FVF<left> $Ref) $Ref)
(declare-fun $FVF.after_left ($FVF<left> $FVF<left>) Bool)
(declare-fun $FVF.loc_left ($Ref $Ref) Bool)
(declare-fun $FVF.perm_left ($FPM $Ref) $Perm)
(declare-const $fvfTOP_left $FVF<left>)
; /field_value_functions_declarations.smt2 [right: Ref]
(declare-fun $FVF.domain_right ($FVF<right>) Set<$Ref>)
(declare-fun $FVF.lookup_right ($FVF<right> $Ref) $Ref)
(declare-fun $FVF.after_right ($FVF<right> $FVF<right>) Bool)
(declare-fun $FVF.loc_right ($Ref $Ref) Bool)
(declare-fun $FVF.perm_right ($FPM $Ref) $Perm)
(declare-const $fvfTOP_right $FVF<right>)
; /field_value_functions_declarations.smt2 [is_marked: Bool]
(declare-fun $FVF.domain_is_marked ($FVF<is_marked>) Set<$Ref>)
(declare-fun $FVF.lookup_is_marked ($FVF<is_marked> $Ref) Bool)
(declare-fun $FVF.after_is_marked ($FVF<is_marked> $FVF<is_marked>) Bool)
(declare-fun $FVF.loc_is_marked (Bool $Ref) Bool)
(declare-fun $FVF.perm_is_marked ($FPM $Ref) $Perm)
(declare-const $fvfTOP_is_marked $FVF<is_marked>)
; Declaring symbols related to program functions (from program analysis)
; Snapshot variable to be used during function verification
(declare-fun s@$ () $Snap)
; Declaring predicate trigger functions
; ////////// Uniqueness assumptions from domains
; ////////// Axioms
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
; /field_value_functions_axioms.smt2 [left: Ref]
(assert (forall ((vs $FVF<left>) (ws $FVF<left>)) (!
    (=>
      (and
        (Set_equal ($FVF.domain_left vs) ($FVF.domain_left ws))
        (forall ((x $Ref)) (!
          (=>
            (Set_in x ($FVF.domain_left vs))
            (= ($FVF.lookup_left vs x) ($FVF.lookup_left ws x)))
          :pattern (($FVF.lookup_left vs x) ($FVF.lookup_left ws x))
          :qid |qp.$FVF<left>-eq-inner|
          )))
      (= vs ws))
    :pattern (($SortWrappers.$FVF<left>To$Snap vs)
              ($SortWrappers.$FVF<left>To$Snap ws)
              )
    :qid |qp.$FVF<left>-eq-outer|
    )))
(assert (forall ((r $Ref) (pm $FPM)) (!
    ($Perm.isValidVar ($FVF.perm_left pm r))
    :pattern (($FVF.perm_left pm r)))))
(assert (forall ((r $Ref) (f $Ref)) (!
    (= ($FVF.loc_left f r) true)
    :pattern (($FVF.loc_left f r)))))
; /field_value_functions_axioms.smt2 [right: Ref]
(assert (forall ((vs $FVF<right>) (ws $FVF<right>)) (!
    (=>
      (and
        (Set_equal ($FVF.domain_right vs) ($FVF.domain_right ws))
        (forall ((x $Ref)) (!
          (=>
            (Set_in x ($FVF.domain_right vs))
            (= ($FVF.lookup_right vs x) ($FVF.lookup_right ws x)))
          :pattern (($FVF.lookup_right vs x) ($FVF.lookup_right ws x))
          :qid |qp.$FVF<right>-eq-inner|
          )))
      (= vs ws))
    :pattern (($SortWrappers.$FVF<right>To$Snap vs)
              ($SortWrappers.$FVF<right>To$Snap ws)
              )
    :qid |qp.$FVF<right>-eq-outer|
    )))
(assert (forall ((r $Ref) (pm $FPM)) (!
    ($Perm.isValidVar ($FVF.perm_right pm r))
    :pattern (($FVF.perm_right pm r)))))
(assert (forall ((r $Ref) (f $Ref)) (!
    (= ($FVF.loc_right f r) true)
    :pattern (($FVF.loc_right f r)))))
; /field_value_functions_axioms.smt2 [is_marked: Bool]
(assert (forall ((vs $FVF<is_marked>) (ws $FVF<is_marked>)) (!
    (=>
      (and
        (Set_equal ($FVF.domain_is_marked vs) ($FVF.domain_is_marked ws))
        (forall ((x $Ref)) (!
          (=>
            (Set_in x ($FVF.domain_is_marked vs))
            (= ($FVF.lookup_is_marked vs x) ($FVF.lookup_is_marked ws x)))
          :pattern (($FVF.lookup_is_marked vs x) ($FVF.lookup_is_marked ws x))
          :qid |qp.$FVF<is_marked>-eq-inner|
          )))
      (= vs ws))
    :pattern (($SortWrappers.$FVF<is_marked>To$Snap vs)
              ($SortWrappers.$FVF<is_marked>To$Snap ws)
              )
    :qid |qp.$FVF<is_marked>-eq-outer|
    )))
(assert (forall ((r $Ref) (pm $FPM)) (!
    ($Perm.isValidVar ($FVF.perm_is_marked pm r))
    :pattern (($FVF.perm_is_marked pm r)))))
(assert (forall ((r $Ref) (f Bool)) (!
    (= ($FVF.loc_is_marked f r) true)
    :pattern (($FVF.loc_is_marked f r)))))
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
; ---------- client_failure ----------
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
; var a: Ref
(declare-const a@0@10 $Ref)
; [exec]
; var b: Ref
(declare-const b@1@10 $Ref)
; [exec]
; var nodes: Set[Ref]
(declare-const nodes@2@10 Set<$Ref>)
; [exec]
; a := new(left, right, is_marked)
(declare-const a@3@10 $Ref)
(assert (not (= a@3@10 $Ref.null)))
(declare-const left@4@10 $Ref)
(declare-const sm@5@10 $FVF<left>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_left (as sm@5@10  $FVF<left>) a@3@10) left@4@10))
(declare-const right@6@10 $Ref)
(declare-const sm@7@10 $FVF<right>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_right (as sm@7@10  $FVF<right>) a@3@10) right@6@10))
(declare-const is_marked@8@10 Bool)
(declare-const sm@9@10 $FVF<is_marked>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_is_marked (as sm@9@10  $FVF<is_marked>) a@3@10) is_marked@8@10))
(assert (not (= a@3@10 b@1@10)))
(assert (not (= a@3@10 a@0@10)))
(assert (not (Set_in a@3@10 nodes@2@10)))
; [exec]
; a.is_marked := false
(declare-const sm@10@10 $FVF<is_marked>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_is_marked (as sm@10@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@9@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@10@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@9@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef0|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@9@10  $FVF<is_marked>) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@10@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef1|)))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@10@10  $FVF<is_marked>) a@3@10) a@3@10))
; Precomputing data for removing quantified permissions
(define-fun pTaken@11@10 ((r $Ref)) $Perm
  (ite
    (= r a@3@10)
    ($Perm.min (ite (= r a@3@10) $Perm.Write $Perm.No) $Perm.Write)
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
(assert (not (= (- $Perm.Write (pTaken@11@10 a@3@10)) $Perm.No)))
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
  (=> (= r a@3@10) (= (- $Perm.Write (pTaken@11@10 r)) $Perm.No))
  
  :qid |quant-u-4|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@12@10 $FVF<is_marked>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) a@3@10) false))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) a@3@10) a@3@10))
; [exec]
; b := new(left, right, is_marked)
(declare-const b@13@10 $Ref)
(assert (not (= b@13@10 $Ref.null)))
(declare-const left@14@10 $Ref)
(declare-const sm@15@10 $FVF<left>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_left (as sm@15@10  $FVF<left>) b@13@10) left@14@10))
(declare-const right@16@10 $Ref)
(declare-const sm@17@10 $FVF<right>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_right (as sm@17@10  $FVF<right>) b@13@10) right@16@10))
(declare-const is_marked@18@10 Bool)
(declare-const sm@19@10 $FVF<is_marked>)
; Definitional axioms for singleton-FVF's value
(assert (=
  ($FVF.lookup_is_marked (as sm@19@10  $FVF<is_marked>) b@13@10)
  is_marked@18@10))
(assert (not (= b@13@10 a@3@10)))
(assert (not (= b@13@10 ($FVF.lookup_right (as sm@7@10  $FVF<right>) a@3@10))))
(assert (not (= b@13@10 b@1@10)))
(assert (not (= b@13@10 ($FVF.lookup_left (as sm@5@10  $FVF<left>) a@3@10))))
(assert (not (Set_in b@13@10 nodes@2@10)))
; [exec]
; b.is_marked := false
(declare-const sm@20@10 $FVF<is_marked>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_is_marked (as sm@20@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@19@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@20@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@19@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef2|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_is_marked (as sm@20@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@20@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@19@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@20@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef4|)))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@20@10  $FVF<is_marked>) b@13@10) b@13@10))
; Precomputing data for removing quantified permissions
(define-fun pTaken@21@10 ((r $Ref)) $Perm
  (ite
    (= r b@13@10)
    ($Perm.min (ite (= r b@13@10) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@22@10 ((r $Ref)) $Perm
  (ite
    (= r b@13@10)
    ($Perm.min
      (ite (= r a@3@10) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@21@10 r)))
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
(assert (not (= (- $Perm.Write (pTaken@21@10 b@13@10)) $Perm.No)))
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
  (=> (= r b@13@10) (= (- $Perm.Write (pTaken@21@10 r)) $Perm.No))
  
  :qid |quant-u-10|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@23@10 $FVF<is_marked>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) b@13@10) false))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) b@13@10) b@13@10))
; [exec]
; a.left := a
(declare-const sm@24@10 $FVF<left>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_left (as sm@24@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@5@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@24@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@5@10  $FVF<left>) r))
  :qid |qp.fvfValDef5|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_left (as sm@24@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@15@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@24@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@15@10  $FVF<left>) r))
  :qid |qp.fvfValDef6|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@5@10  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@15@10  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@24@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef7|)))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@24@10  $FVF<left>) a@3@10) a@3@10))
; Precomputing data for removing quantified permissions
(define-fun pTaken@25@10 ((r $Ref)) $Perm
  (ite
    (= r a@3@10)
    ($Perm.min (ite (= r a@3@10) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@26@10 ((r $Ref)) $Perm
  (ite
    (= r a@3@10)
    ($Perm.min
      (ite (= r b@13@10) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@25@10 r)))
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
(assert (not (= (- $Perm.Write (pTaken@25@10 a@3@10)) $Perm.No)))
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
  (=> (= r a@3@10) (= (- $Perm.Write (pTaken@25@10 r)) $Perm.No))
  
  :qid |quant-u-16|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@27@10 $FVF<left>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_left (as sm@27@10  $FVF<left>) a@3@10) a@3@10))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@27@10  $FVF<left>) a@3@10) a@3@10))
; [exec]
; a.right := a
(declare-const sm@28@10 $FVF<right>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_right (as sm@28@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@17@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@28@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@17@10  $FVF<right>) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_right (as sm@28@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@7@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@28@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@7@10  $FVF<right>) r))
  :qid |qp.fvfValDef9|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@17@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@7@10  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@28@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef10|)))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@28@10  $FVF<right>) a@3@10) a@3@10))
; Precomputing data for removing quantified permissions
(define-fun pTaken@29@10 ((r $Ref)) $Perm
  (ite
    (= r a@3@10)
    ($Perm.min (ite (= r a@3@10) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@30@10 ((r $Ref)) $Perm
  (ite
    (= r a@3@10)
    ($Perm.min
      (ite (= r b@13@10) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@29@10 r)))
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
(assert (not (= (- $Perm.Write (pTaken@29@10 a@3@10)) $Perm.No)))
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
  (=> (= r a@3@10) (= (- $Perm.Write (pTaken@29@10 r)) $Perm.No))
  
  :qid |quant-u-24|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@31@10 $FVF<right>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_right (as sm@31@10  $FVF<right>) a@3@10) a@3@10))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@31@10  $FVF<right>) a@3@10) a@3@10))
; [exec]
; b.left := a
(declare-const sm@32@10 $FVF<left>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_left (as sm@32@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@15@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@32@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@15@10  $FVF<left>) r))
  :qid |qp.fvfValDef11|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_left (as sm@32@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@27@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@32@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@27@10  $FVF<left>) r))
  :qid |qp.fvfValDef12|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@15@10  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@27@10  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@32@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef13|)))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@32@10  $FVF<left>) b@13@10) b@13@10))
; Precomputing data for removing quantified permissions
(define-fun pTaken@33@10 ((r $Ref)) $Perm
  (ite
    (= r b@13@10)
    ($Perm.min (ite (= r b@13@10) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@34@10 ((r $Ref)) $Perm
  (ite
    (= r b@13@10)
    ($Perm.min
      (ite (= r a@3@10) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@33@10 r)))
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
(assert (not (= (- $Perm.Write (pTaken@33@10 b@13@10)) $Perm.No)))
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
  (=> (= r b@13@10) (= (- $Perm.Write (pTaken@33@10 r)) $Perm.No))
  
  :qid |quant-u-30|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@35@10 $FVF<left>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_left (as sm@35@10  $FVF<left>) b@13@10) a@3@10))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@35@10  $FVF<left>) b@13@10) b@13@10))
; [exec]
; b.right := a
(declare-const sm@36@10 $FVF<right>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_right (as sm@36@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@17@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@36@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@17@10  $FVF<right>) r))
  :qid |qp.fvfValDef14|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_right (as sm@36@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@36@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@10  $FVF<right>) r))
  :qid |qp.fvfValDef15|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@17@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@10  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@36@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef16|)))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@36@10  $FVF<right>) b@13@10) b@13@10))
; Precomputing data for removing quantified permissions
(define-fun pTaken@37@10 ((r $Ref)) $Perm
  (ite
    (= r b@13@10)
    ($Perm.min (ite (= r b@13@10) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@38@10 ((r $Ref)) $Perm
  (ite
    (= r b@13@10)
    ($Perm.min
      (ite (= r a@3@10) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@37@10 r)))
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
(assert (not (= (- $Perm.Write (pTaken@37@10 b@13@10)) $Perm.No)))
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
  (=> (= r b@13@10) (= (- $Perm.Write (pTaken@37@10 r)) $Perm.No))
  
  :qid |quant-u-37|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@39@10 $FVF<right>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_right (as sm@39@10  $FVF<right>) b@13@10) a@3@10))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@39@10  $FVF<right>) b@13@10) b@13@10))
; [exec]
; nodes := Set(a, b)
; [eval] Set(a, b)
(declare-const nodes@40@10 Set<$Ref>)
(assert (= nodes@40@10 (Set_unionone (Set_singleton a@3@10) b@13@10)))
; [exec]
; assert (forall n: Ref :: { (n in nodes) } (n in nodes) ==> !n.is_marked)
; [eval] (forall n: Ref :: { (n in nodes) } (n in nodes) ==> !n.is_marked)
(declare-const n@41@10 $Ref)
(set-option :timeout 0)
(push) ; 3
; [eval] (n in nodes) ==> !n.is_marked
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 0 | n@41@10 in nodes@40@10 | live]
; [else-branch: 0 | !(n@41@10 in nodes@40@10) | live]
(push) ; 5
; [then-branch: 0 | n@41@10 in nodes@40@10]
(assert (Set_in n@41@10 nodes@40@10))
; [eval] !n.is_marked
(declare-const sm@42@10 $FVF<is_marked>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(declare-const pm@43@10 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_is_marked (as pm@43@10  $FPM) r)
    (+
      (ite (= r b@13@10) $Perm.Write $Perm.No)
      (ite (= r a@3@10) $Perm.Write $Perm.No)))
  :pattern (($FVF.perm_is_marked (as pm@43@10  $FPM) r))
  :qid |qp.resPrmSumDef20|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
  :pattern (($FVF.perm_is_marked (as pm@43@10  $FPM) r))
  :qid |qp.resTrgDef21|)))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@41@10) n@41@10))
(push) ; 6
(assert (not (< $Perm.No ($FVF.perm_is_marked (as pm@43@10  $FPM) n@41@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 0 | !(n@41@10 in nodes@40@10)]
(assert (not (Set_in n@41@10 nodes@40@10)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_is_marked (as pm@43@10  $FPM) r)
    (+
      (ite (= r b@13@10) $Perm.Write $Perm.No)
      (ite (= r a@3@10) $Perm.Write $Perm.No)))
  :pattern (($FVF.perm_is_marked (as pm@43@10  $FPM) r))
  :qid |qp.resPrmSumDef20|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
  :pattern (($FVF.perm_is_marked (as pm@43@10  $FPM) r))
  :qid |qp.resTrgDef21|)))
(assert (=>
  (Set_in n@41@10 nodes@40@10)
  (and
    (Set_in n@41@10 nodes@40@10)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@41@10) n@41@10))))
; Joined path conditions
(assert (or (not (Set_in n@41@10 nodes@40@10)) (Set_in n@41@10 nodes@40@10)))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_is_marked (as pm@43@10  $FPM) r)
    (+
      (ite (= r b@13@10) $Perm.Write $Perm.No)
      (ite (= r a@3@10) $Perm.Write $Perm.No)))
  :pattern (($FVF.perm_is_marked (as pm@43@10  $FPM) r))
  :qid |qp.resPrmSumDef20|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
  :pattern (($FVF.perm_is_marked (as pm@43@10  $FPM) r))
  :qid |qp.resTrgDef21|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@41@10 $Ref)) (!
  (and
    (=>
      (Set_in n@41@10 nodes@40@10)
      (and
        (Set_in n@41@10 nodes@40@10)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@41@10) n@41@10)))
    (or (not (Set_in n@41@10 nodes@40@10)) (Set_in n@41@10 nodes@40@10)))
  :pattern ((Set_in n@41@10 nodes@40@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@79@9@79@53-aux|)))
(push) ; 3
(assert (not (forall ((n@41@10 $Ref)) (!
  (=>
    (Set_in n@41@10 nodes@40@10)
    (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@41@10)))
  :pattern ((Set_in n@41@10 nodes@40@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@79@9@79@53|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (forall ((n@41@10 $Ref)) (!
  (=>
    (Set_in n@41@10 nodes@40@10)
    (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@41@10)))
  :pattern ((Set_in n@41@10 nodes@40@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@79@9@79@53|)))
; [exec]
; trav_rec(nodes, a)
; [eval] (node in nodes)
(push) ; 3
(assert (not (Set_in a@3@10 nodes@40@10)))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (Set_in a@3@10 nodes@40@10))
; [eval] !((null in nodes))
; [eval] (null in nodes)
(push) ; 3
(assert (not (not (Set_in $Ref.null nodes@40@10))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (not (Set_in $Ref.null nodes@40@10)))
(declare-const n@44@10 $Ref)
(push) ; 3
; [eval] (n in nodes)
(assert (Set_in n@44@10 nodes@40@10))
(pop) ; 3
(declare-fun inv@45@10 ($Ref) $Ref)
(declare-fun img@46@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(declare-const sm@47@10 $FVF<left>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@27@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@27@10  $FVF<left>) r))
  :qid |qp.fvfValDef22|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@35@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@35@10  $FVF<left>) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@27@10  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@35@10  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef24|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((n1@44@10 $Ref) (n2@44@10 $Ref)) (!
  (=>
    (and
      (and
        (Set_in n1@44@10 nodes@40@10)
        ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n1@44@10) n1@44@10))
      (and
        (Set_in n2@44@10 nodes@40@10)
        ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n2@44@10) n2@44@10))
      (= n1@44@10 n2@44@10))
    (= n1@44@10 n2@44@10))
  
  :qid |left-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((n@44@10 $Ref)) (!
  (=>
    (Set_in n@44@10 nodes@40@10)
    (and (= (inv@45@10 n@44@10) n@44@10) (img@46@10 n@44@10)))
  :pattern ((Set_in n@44@10 nodes@40@10))
  :pattern ((inv@45@10 n@44@10))
  :pattern ((img@46@10 n@44@10))
  :qid |left-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=> (and (img@46@10 r) (Set_in (inv@45@10 r) nodes@40@10)) (= (inv@45@10 r) r))
  :pattern ((inv@45@10 r))
  :qid |left-fctOfInv|)))
(assert (forall ((r $Ref)) (!
  (=>
    (Set_in (inv@45@10 r) nodes@40@10)
    ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) r) r))
  :pattern ((inv@45@10 r))
  :qid |quant-u-47|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@48@10 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@45@10 r) nodes@40@10) (img@46@10 r) (= r (inv@45@10 r)))
    ($Perm.min (ite (= r a@3@10) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@49@10 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@45@10 r) nodes@40@10) (img@46@10 r) (= r (inv@45@10 r)))
    ($Perm.min
      (ite (= r b@13@10) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@48@10 r)))
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
(assert (not (= (- $Perm.Write (pTaken@48@10 a@3@10)) $Perm.No)))
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
    (and (Set_in (inv@45@10 r) nodes@40@10) (img@46@10 r) (= r (inv@45@10 r)))
    (= (- $Perm.Write (pTaken@48@10 r)) $Perm.No))
  
  :qid |quant-u-54|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 500)
(assert (not (= (- $Perm.Write (pTaken@49@10 b@13@10)) $Perm.No)))
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
    (and (Set_in (inv@45@10 r) nodes@40@10) (img@46@10 r) (= r (inv@45@10 r)))
    (= (- (- $Perm.Write (pTaken@48@10 r)) (pTaken@49@10 r)) $Perm.No))
  
  :qid |quant-u-61|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
; Definitional axioms for snapshot map values
(declare-const n$0@50@10 $Ref)
(set-option :timeout 0)
(push) ; 3
; [eval] (n$0 in nodes)
(assert (Set_in n$0@50@10 nodes@40@10))
(pop) ; 3
(declare-fun inv@51@10 ($Ref) $Ref)
(declare-fun img@52@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(declare-const sm@53@10 $FVF<right>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_right (as sm@53@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@53@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@10  $FVF<right>) r))
  :qid |qp.fvfValDef25|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_right (as sm@53@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@39@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@53@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@39@10  $FVF<right>) r))
  :qid |qp.fvfValDef26|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@10  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@53@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef27|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((n$01@50@10 $Ref) (n$02@50@10 $Ref)) (!
  (=>
    (and
      (and
        (Set_in n$01@50@10 nodes@40@10)
        ($FVF.loc_right ($FVF.lookup_right (as sm@53@10  $FVF<right>) n$01@50@10) n$01@50@10))
      (and
        (Set_in n$02@50@10 nodes@40@10)
        ($FVF.loc_right ($FVF.lookup_right (as sm@53@10  $FVF<right>) n$02@50@10) n$02@50@10))
      (= n$01@50@10 n$02@50@10))
    (= n$01@50@10 n$02@50@10))
  
  :qid |right-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((n$0@50@10 $Ref)) (!
  (=>
    (Set_in n$0@50@10 nodes@40@10)
    (and (= (inv@51@10 n$0@50@10) n$0@50@10) (img@52@10 n$0@50@10)))
  :pattern ((Set_in n$0@50@10 nodes@40@10))
  :pattern ((inv@51@10 n$0@50@10))
  :pattern ((img@52@10 n$0@50@10))
  :qid |right-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=> (and (img@52@10 r) (Set_in (inv@51@10 r) nodes@40@10)) (= (inv@51@10 r) r))
  :pattern ((inv@51@10 r))
  :qid |right-fctOfInv|)))
(assert (forall ((r $Ref)) (!
  (=>
    (Set_in (inv@51@10 r) nodes@40@10)
    ($FVF.loc_right ($FVF.lookup_right (as sm@53@10  $FVF<right>) r) r))
  :pattern ((inv@51@10 r))
  :qid |quant-u-68|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@54@10 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@51@10 r) nodes@40@10) (img@52@10 r) (= r (inv@51@10 r)))
    ($Perm.min (ite (= r a@3@10) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@55@10 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@51@10 r) nodes@40@10) (img@52@10 r) (= r (inv@51@10 r)))
    ($Perm.min
      (ite (= r b@13@10) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@54@10 r)))
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
(assert (not (= (- $Perm.Write (pTaken@54@10 a@3@10)) $Perm.No)))
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
    (and (Set_in (inv@51@10 r) nodes@40@10) (img@52@10 r) (= r (inv@51@10 r)))
    (= (- $Perm.Write (pTaken@54@10 r)) $Perm.No))
  
  :qid |quant-u-75|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 500)
(assert (not (= (- $Perm.Write (pTaken@55@10 b@13@10)) $Perm.No)))
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
    (and (Set_in (inv@51@10 r) nodes@40@10) (img@52@10 r) (= r (inv@51@10 r)))
    (= (- (- $Perm.Write (pTaken@54@10 r)) (pTaken@55@10 r)) $Perm.No))
  
  :qid |quant-u-80|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
; Definitional axioms for snapshot map values
(declare-const n$1@56@10 $Ref)
(set-option :timeout 0)
(push) ; 3
; [eval] (n$1 in nodes)
(assert (Set_in n$1@56@10 nodes@40@10))
(pop) ; 3
(declare-fun inv@57@10 ($Ref) $Ref)
(declare-fun img@58@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Definitional axioms for snapshot map values
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((n$11@56@10 $Ref) (n$12@56@10 $Ref)) (!
  (=>
    (and
      (and
        (Set_in n$11@56@10 nodes@40@10)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n$11@56@10) n$11@56@10))
      (and
        (Set_in n$12@56@10 nodes@40@10)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n$12@56@10) n$12@56@10))
      (= n$11@56@10 n$12@56@10))
    (= n$11@56@10 n$12@56@10))
  
  :qid |is_marked-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((n$1@56@10 $Ref)) (!
  (=>
    (Set_in n$1@56@10 nodes@40@10)
    (and (= (inv@57@10 n$1@56@10) n$1@56@10) (img@58@10 n$1@56@10)))
  :pattern ((Set_in n$1@56@10 nodes@40@10))
  :pattern ((inv@57@10 n$1@56@10))
  :pattern ((img@58@10 n$1@56@10))
  :qid |is_marked-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=> (and (img@58@10 r) (Set_in (inv@57@10 r) nodes@40@10)) (= (inv@57@10 r) r))
  :pattern ((inv@57@10 r))
  :qid |is_marked-fctOfInv|)))
(assert (forall ((r $Ref)) (!
  (=>
    (Set_in (inv@57@10 r) nodes@40@10)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r) r))
  :pattern ((inv@57@10 r))
  :qid |quant-u-87|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@59@10 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@57@10 r) nodes@40@10) (img@58@10 r) (= r (inv@57@10 r)))
    ($Perm.min (ite (= r b@13@10) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@60@10 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@57@10 r) nodes@40@10) (img@58@10 r) (= r (inv@57@10 r)))
    ($Perm.min
      (ite (= r a@3@10) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@59@10 r)))
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
(assert (not (= (- $Perm.Write (pTaken@59@10 b@13@10)) $Perm.No)))
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
    (and (Set_in (inv@57@10 r) nodes@40@10) (img@58@10 r) (= r (inv@57@10 r)))
    (= (- $Perm.Write (pTaken@59@10 r)) $Perm.No))
  
  :qid |quant-u-92|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 500)
(assert (not (= (- $Perm.Write (pTaken@60@10 a@3@10)) $Perm.No)))
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
    (and (Set_in (inv@57@10 r) nodes@40@10) (img@58@10 r) (= r (inv@57@10 r)))
    (= (- (- $Perm.Write (pTaken@59@10 r)) (pTaken@60@10 r)) $Perm.No))
  
  :qid |quant-u-95|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
; Definitional axioms for snapshot map values
; [eval] (forall n$2: Ref :: { (n$2.left in nodes) } { (n$2 in nodes), n$2.left } (n$2 in nodes) && n$2.left != null ==> (n$2.left in nodes))
(declare-const n$2@61@10 $Ref)
(set-option :timeout 0)
(push) ; 3
; [eval] (n$2 in nodes) && n$2.left != null ==> (n$2.left in nodes)
; [eval] (n$2 in nodes) && n$2.left != null
; [eval] (n$2 in nodes)
(push) ; 4
; [then-branch: 1 | !(n$2@61@10 in nodes@40@10) | live]
; [else-branch: 1 | n$2@61@10 in nodes@40@10 | live]
(push) ; 5
; [then-branch: 1 | !(n$2@61@10 in nodes@40@10)]
(assert (not (Set_in n$2@61@10 nodes@40@10)))
(pop) ; 5
(push) ; 5
; [else-branch: 1 | n$2@61@10 in nodes@40@10]
(assert (Set_in n$2@61@10 nodes@40@10))
; [eval] n$2.left != null
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@10)
      (=
        ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
        ($FVF.lookup_left (as sm@27@10  $FVF<left>) r)))
    :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
    :pattern (($FVF.lookup_left (as sm@27@10  $FVF<left>) r))
    :qid |qp.fvfValDef22|))
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@10)
      (=
        ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
        ($FVF.lookup_left (as sm@35@10  $FVF<left>) r)))
    :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
    :pattern (($FVF.lookup_left (as sm@35@10  $FVF<left>) r))
    :qid |qp.fvfValDef23|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_left ($FVF.lookup_left (as sm@27@10  $FVF<left>) r) r)
      ($FVF.loc_left ($FVF.lookup_left (as sm@35@10  $FVF<left>) r) r))
    :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
    :qid |qp.fvfResTrgDef24|))))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) n$2@61@10))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n$2@61@10 a@3@10) $Perm.Write $Perm.No)
    (ite (= n$2@61@10 b@13@10) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@27@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@27@10  $FVF<left>) r))
  :qid |qp.fvfValDef22|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@35@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@35@10  $FVF<left>) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@27@10  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@35@10  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef24|)))
(assert (=>
  (Set_in n$2@61@10 nodes@40@10)
  (and
    (Set_in n$2@61@10 nodes@40@10)
    ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) n$2@61@10))))
(assert (or (Set_in n$2@61@10 nodes@40@10) (not (Set_in n$2@61@10 nodes@40@10))))
(push) ; 4
; [then-branch: 2 | n$2@61@10 in nodes@40@10 && Lookup(left, sm@47@10, n$2@61@10) != Null | live]
; [else-branch: 2 | !(n$2@61@10 in nodes@40@10 && Lookup(left, sm@47@10, n$2@61@10) != Null) | live]
(push) ; 5
; [then-branch: 2 | n$2@61@10 in nodes@40@10 && Lookup(left, sm@47@10, n$2@61@10) != Null]
(assert (and
  (Set_in n$2@61@10 nodes@40@10)
  (not (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null))))
; [eval] (n$2.left in nodes)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@10)
      (=
        ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
        ($FVF.lookup_left (as sm@27@10  $FVF<left>) r)))
    :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
    :pattern (($FVF.lookup_left (as sm@27@10  $FVF<left>) r))
    :qid |qp.fvfValDef22|))
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@10)
      (=
        ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
        ($FVF.lookup_left (as sm@35@10  $FVF<left>) r)))
    :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
    :pattern (($FVF.lookup_left (as sm@35@10  $FVF<left>) r))
    :qid |qp.fvfValDef23|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_left ($FVF.lookup_left (as sm@27@10  $FVF<left>) r) r)
      ($FVF.loc_left ($FVF.lookup_left (as sm@35@10  $FVF<left>) r) r))
    :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
    :qid |qp.fvfResTrgDef24|))))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) n$2@61@10))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n$2@61@10 a@3@10) $Perm.Write $Perm.No)
    (ite (= n$2@61@10 b@13@10) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 2 | !(n$2@61@10 in nodes@40@10 && Lookup(left, sm@47@10, n$2@61@10) != Null)]
(assert (not
  (and
    (Set_in n$2@61@10 nodes@40@10)
    (not (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@27@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@27@10  $FVF<left>) r))
  :qid |qp.fvfValDef22|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@35@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@35@10  $FVF<left>) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@27@10  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@35@10  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef24|)))
(assert (=>
  (and
    (Set_in n$2@61@10 nodes@40@10)
    (not (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null)))
  (and
    (Set_in n$2@61@10 nodes@40@10)
    (not (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null))
    ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) n$2@61@10))))
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in n$2@61@10 nodes@40@10)
      (not (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null))))
  (and
    (Set_in n$2@61@10 nodes@40@10)
    (not (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null)))))
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@27@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@27@10  $FVF<left>) r))
  :qid |qp.fvfValDef22|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@35@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@35@10  $FVF<left>) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@27@10  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@35@10  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef24|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n$2@61@10 $Ref)) (!
  (and
    (=>
      (Set_in n$2@61@10 nodes@40@10)
      (and
        (Set_in n$2@61@10 nodes@40@10)
        ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) n$2@61@10)))
    (or (Set_in n$2@61@10 nodes@40@10) (not (Set_in n$2@61@10 nodes@40@10)))
    (=>
      (and
        (Set_in n$2@61@10 nodes@40@10)
        (not
          (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null)))
      (and
        (Set_in n$2@61@10 nodes@40@10)
        (not
          (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null))
        ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) n$2@61@10)))
    (or
      (not
        (and
          (Set_in n$2@61@10 nodes@40@10)
          (not
            (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null))))
      (and
        (Set_in n$2@61@10 nodes@40@10)
        (not
          (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null)))))
  :pattern ((Set_in ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) nodes@40@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38-aux|)))
(assert (forall ((n$2@61@10 $Ref)) (!
  (and
    (=>
      (Set_in n$2@61@10 nodes@40@10)
      (and
        (Set_in n$2@61@10 nodes@40@10)
        ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) n$2@61@10)))
    (or (Set_in n$2@61@10 nodes@40@10) (not (Set_in n$2@61@10 nodes@40@10)))
    (=>
      (and
        (Set_in n$2@61@10 nodes@40@10)
        (not
          (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null)))
      (and
        (Set_in n$2@61@10 nodes@40@10)
        (not
          (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null))
        ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) n$2@61@10)))
    (or
      (not
        (and
          (Set_in n$2@61@10 nodes@40@10)
          (not
            (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null))))
      (and
        (Set_in n$2@61@10 nodes@40@10)
        (not
          (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null)))))
  :pattern ((Set_in n$2@61@10 nodes@40@10) ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) n$2@61@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38-aux|)))
(push) ; 3
(assert (not (forall ((n$2@61@10 $Ref)) (!
  (=>
    (and
      (Set_in n$2@61@10 nodes@40@10)
      (not (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null)))
    (Set_in ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) nodes@40@10))
  :pattern ((Set_in ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) nodes@40@10))
  :pattern ((Set_in n$2@61@10 nodes@40@10) ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) n$2@61@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (forall ((n$2@61@10 $Ref)) (!
  (=>
    (and
      (Set_in n$2@61@10 nodes@40@10)
      (not (= ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) $Ref.null)))
    (Set_in ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) nodes@40@10))
  :pattern ((Set_in ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) nodes@40@10))
  :pattern ((Set_in n$2@61@10 nodes@40@10) ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n$2@61@10) n$2@61@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38|)))
; [eval] (forall n$3: Ref :: { (n$3.right in nodes) } { (n$3 in nodes), n$3.right } (n$3 in nodes) && n$3.right != null ==> (n$3.right in nodes))
(declare-const n$3@62@10 $Ref)
(push) ; 3
; [eval] (n$3 in nodes) && n$3.right != null ==> (n$3.right in nodes)
; [eval] (n$3 in nodes) && n$3.right != null
; [eval] (n$3 in nodes)
(push) ; 4
; [then-branch: 3 | !(n$3@62@10 in nodes@40@10) | live]
; [else-branch: 3 | n$3@62@10 in nodes@40@10 | live]
(push) ; 5
; [then-branch: 3 | !(n$3@62@10 in nodes@40@10)]
(assert (not (Set_in n$3@62@10 nodes@40@10)))
(pop) ; 5
(push) ; 5
; [else-branch: 3 | n$3@62@10 in nodes@40@10]
(assert (Set_in n$3@62@10 nodes@40@10))
; [eval] n$3.right != null
(declare-const sm@63@10 $FVF<right>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@39@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@39@10  $FVF<right>) r))
  :qid |qp.fvfValDef28|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@10  $FVF<right>) r))
  :qid |qp.fvfValDef29|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@10  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef30|)))
(declare-const pm@64@10 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_right (as pm@64@10  $FPM) r)
    (+
      (ite (= r b@13@10) $Perm.Write $Perm.No)
      (ite (= r a@3@10) $Perm.Write $Perm.No)))
  :pattern (($FVF.perm_right (as pm@64@10  $FPM) r))
  :qid |qp.resPrmSumDef31|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@10  $FVF<right>) r) r))
  :pattern (($FVF.perm_right (as pm@64@10  $FPM) r))
  :qid |qp.resTrgDef32|)))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) n$3@62@10))
(push) ; 6
(assert (not (< $Perm.No ($FVF.perm_right (as pm@64@10  $FPM) n$3@62@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@39@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@39@10  $FVF<right>) r))
  :qid |qp.fvfValDef28|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@10  $FVF<right>) r))
  :qid |qp.fvfValDef29|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@10  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef30|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_right (as pm@64@10  $FPM) r)
    (+
      (ite (= r b@13@10) $Perm.Write $Perm.No)
      (ite (= r a@3@10) $Perm.Write $Perm.No)))
  :pattern (($FVF.perm_right (as pm@64@10  $FPM) r))
  :qid |qp.resPrmSumDef31|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@10  $FVF<right>) r) r))
  :pattern (($FVF.perm_right (as pm@64@10  $FPM) r))
  :qid |qp.resTrgDef32|)))
(assert (=>
  (Set_in n$3@62@10 nodes@40@10)
  (and
    (Set_in n$3@62@10 nodes@40@10)
    ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) n$3@62@10))))
(assert (or (Set_in n$3@62@10 nodes@40@10) (not (Set_in n$3@62@10 nodes@40@10))))
(push) ; 4
; [then-branch: 4 | n$3@62@10 in nodes@40@10 && Lookup(right, sm@63@10, n$3@62@10) != Null | live]
; [else-branch: 4 | !(n$3@62@10 in nodes@40@10 && Lookup(right, sm@63@10, n$3@62@10) != Null) | live]
(push) ; 5
; [then-branch: 4 | n$3@62@10 in nodes@40@10 && Lookup(right, sm@63@10, n$3@62@10) != Null]
(assert (and
  (Set_in n$3@62@10 nodes@40@10)
  (not (= ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) $Ref.null))))
; [eval] (n$3.right in nodes)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@10)
      (=
        ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
        ($FVF.lookup_right (as sm@39@10  $FVF<right>) r)))
    :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
    :pattern (($FVF.lookup_right (as sm@39@10  $FVF<right>) r))
    :qid |qp.fvfValDef28|))
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@10)
      (=
        ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
        ($FVF.lookup_right (as sm@31@10  $FVF<right>) r)))
    :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
    :pattern (($FVF.lookup_right (as sm@31@10  $FVF<right>) r))
    :qid |qp.fvfValDef29|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_right ($FVF.lookup_right (as sm@39@10  $FVF<right>) r) r)
      ($FVF.loc_right ($FVF.lookup_right (as sm@31@10  $FVF<right>) r) r))
    :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
    :qid |qp.fvfResTrgDef30|))))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) n$3@62@10))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n$3@62@10 b@13@10) $Perm.Write $Perm.No)
    (ite (= n$3@62@10 a@3@10) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 4 | !(n$3@62@10 in nodes@40@10 && Lookup(right, sm@63@10, n$3@62@10) != Null)]
(assert (not
  (and
    (Set_in n$3@62@10 nodes@40@10)
    (not (= ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) $Ref.null)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@39@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@39@10  $FVF<right>) r))
  :qid |qp.fvfValDef28|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@10  $FVF<right>) r))
  :qid |qp.fvfValDef29|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@10  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef30|)))
(assert (=>
  (and
    (Set_in n$3@62@10 nodes@40@10)
    (not (= ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) $Ref.null)))
  (and
    (Set_in n$3@62@10 nodes@40@10)
    (not (= ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) $Ref.null))
    ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) n$3@62@10))))
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in n$3@62@10 nodes@40@10)
      (not
        (= ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) $Ref.null))))
  (and
    (Set_in n$3@62@10 nodes@40@10)
    (not (= ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) $Ref.null)))))
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@39@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@39@10  $FVF<right>) r))
  :qid |qp.fvfValDef28|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@10  $FVF<right>) r))
  :qid |qp.fvfValDef29|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@10  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef30|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_right (as pm@64@10  $FPM) r)
    (+
      (ite (= r b@13@10) $Perm.Write $Perm.No)
      (ite (= r a@3@10) $Perm.Write $Perm.No)))
  :pattern (($FVF.perm_right (as pm@64@10  $FPM) r))
  :qid |qp.resPrmSumDef31|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@10  $FVF<right>) r) r))
  :pattern (($FVF.perm_right (as pm@64@10  $FPM) r))
  :qid |qp.resTrgDef32|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n$3@62@10 $Ref)) (!
  (and
    (=>
      (Set_in n$3@62@10 nodes@40@10)
      (and
        (Set_in n$3@62@10 nodes@40@10)
        ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) n$3@62@10)))
    (or (Set_in n$3@62@10 nodes@40@10) (not (Set_in n$3@62@10 nodes@40@10)))
    (=>
      (and
        (Set_in n$3@62@10 nodes@40@10)
        (not
          (= ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) $Ref.null)))
      (and
        (Set_in n$3@62@10 nodes@40@10)
        (not
          (= ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) $Ref.null))
        ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) n$3@62@10)))
    (or
      (not
        (and
          (Set_in n$3@62@10 nodes@40@10)
          (not
            (=
              ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10)
              $Ref.null))))
      (and
        (Set_in n$3@62@10 nodes@40@10)
        (not
          (= ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) $Ref.null)))))
  :pattern ((Set_in ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) nodes@40@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38-aux|)))
(assert (forall ((n$3@62@10 $Ref)) (!
  (and
    (=>
      (Set_in n$3@62@10 nodes@40@10)
      (and
        (Set_in n$3@62@10 nodes@40@10)
        ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) n$3@62@10)))
    (or (Set_in n$3@62@10 nodes@40@10) (not (Set_in n$3@62@10 nodes@40@10)))
    (=>
      (and
        (Set_in n$3@62@10 nodes@40@10)
        (not
          (= ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) $Ref.null)))
      (and
        (Set_in n$3@62@10 nodes@40@10)
        (not
          (= ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) $Ref.null))
        ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) n$3@62@10)))
    (or
      (not
        (and
          (Set_in n$3@62@10 nodes@40@10)
          (not
            (=
              ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10)
              $Ref.null))))
      (and
        (Set_in n$3@62@10 nodes@40@10)
        (not
          (= ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) $Ref.null)))))
  :pattern ((Set_in n$3@62@10 nodes@40@10) ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) n$3@62@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38-aux|)))
(push) ; 3
(assert (not (forall ((n$3@62@10 $Ref)) (!
  (=>
    (and
      (Set_in n$3@62@10 nodes@40@10)
      (not
        (= ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) $Ref.null)))
    (Set_in ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) nodes@40@10))
  :pattern ((Set_in ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) nodes@40@10))
  :pattern ((Set_in n$3@62@10 nodes@40@10) ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) n$3@62@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (forall ((n$3@62@10 $Ref)) (!
  (=>
    (and
      (Set_in n$3@62@10 nodes@40@10)
      (not
        (= ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) $Ref.null)))
    (Set_in ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) nodes@40@10))
  :pattern ((Set_in ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) nodes@40@10))
  :pattern ((Set_in n$3@62@10 nodes@40@10) ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) n$3@62@10) n$3@62@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38|)))
; [eval] !node.is_marked
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@10)
      (=
        ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r))
    :qid |qp.fvfValDef17|))
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@10)
      (=
        ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r))
    :qid |qp.fvfValDef18|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
    :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef19|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) a@3@10) a@3@10))
(push) ; 3
(assert (not (< $Perm.No (+ (ite (= a@3@10 b@13@10) $Perm.Write $Perm.No) $Perm.Write))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(push) ; 3
(assert (not (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) a@3@10))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) a@3@10)))
(declare-const $t@65@10 $Snap)
(assert (= $t@65@10 ($Snap.combine ($Snap.first $t@65@10) ($Snap.second $t@65@10))))
(assert (= ($Snap.first $t@65@10) $Snap.unit))
; [eval] (node in nodes)
(assert (=
  ($Snap.second $t@65@10)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@65@10))
    ($Snap.second ($Snap.second $t@65@10)))))
(assert (= ($Snap.first ($Snap.second $t@65@10)) $Snap.unit))
; [eval] !((null in nodes))
; [eval] (null in nodes)
(assert (=
  ($Snap.second ($Snap.second $t@65@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@65@10)))
    ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))
(declare-const n$4@66@10 $Ref)
(push) ; 3
; [eval] (n$4 in nodes)
(assert (Set_in n$4@66@10 nodes@40@10))
(pop) ; 3
(declare-fun inv@67@10 ($Ref) $Ref)
(declare-fun img@68@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((n$41@66@10 $Ref) (n$42@66@10 $Ref)) (!
  (=>
    (and
      (Set_in n$41@66@10 nodes@40@10)
      (Set_in n$42@66@10 nodes@40@10)
      (= n$41@66@10 n$42@66@10))
    (= n$41@66@10 n$42@66@10))
  
  :qid |left-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((n$4@66@10 $Ref)) (!
  (=>
    (Set_in n$4@66@10 nodes@40@10)
    (and (= (inv@67@10 n$4@66@10) n$4@66@10) (img@68@10 n$4@66@10)))
  :pattern ((Set_in n$4@66@10 nodes@40@10))
  :pattern ((inv@67@10 n$4@66@10))
  :pattern ((img@68@10 n$4@66@10))
  :qid |quant-u-99|)))
(assert (forall ((r $Ref)) (!
  (=> (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10)) (= (inv@67@10 r) r))
  :pattern ((inv@67@10 r))
  :qid |left-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((n$4@66@10 $Ref)) (!
  (=> (Set_in n$4@66@10 nodes@40@10) (not (= n$4@66@10 $Ref.null)))
  :pattern ((Set_in n$4@66@10 nodes@40@10))
  :pattern ((inv@67@10 n$4@66@10))
  :pattern ((img@68@10 n$4@66@10))
  :qid |left-permImpliesNonNull|)))
(declare-const sm@69@10 $FVF<left>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
    (=
      ($FVF.lookup_left (as sm@69@10  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (forall ((r $Ref)) (!
  (=>
    (Set_in (inv@67@10 r) nodes@40@10)
    ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) r) r))
  :pattern ((inv@67@10 r))
  :qid |quant-u-101|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@65@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))))
(declare-const n$5@70@10 $Ref)
(push) ; 3
; [eval] (n$5 in nodes)
(assert (Set_in n$5@70@10 nodes@40@10))
(pop) ; 3
(declare-fun inv@71@10 ($Ref) $Ref)
(declare-fun img@72@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((n$51@70@10 $Ref) (n$52@70@10 $Ref)) (!
  (=>
    (and
      (Set_in n$51@70@10 nodes@40@10)
      (Set_in n$52@70@10 nodes@40@10)
      (= n$51@70@10 n$52@70@10))
    (= n$51@70@10 n$52@70@10))
  
  :qid |right-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((n$5@70@10 $Ref)) (!
  (=>
    (Set_in n$5@70@10 nodes@40@10)
    (and (= (inv@71@10 n$5@70@10) n$5@70@10) (img@72@10 n$5@70@10)))
  :pattern ((Set_in n$5@70@10 nodes@40@10))
  :pattern ((inv@71@10 n$5@70@10))
  :pattern ((img@72@10 n$5@70@10))
  :qid |quant-u-105|)))
(assert (forall ((r $Ref)) (!
  (=> (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10)) (= (inv@71@10 r) r))
  :pattern ((inv@71@10 r))
  :qid |right-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((n$5@70@10 $Ref)) (!
  (=> (Set_in n$5@70@10 nodes@40@10) (not (= n$5@70@10 $Ref.null)))
  :pattern ((Set_in n$5@70@10 nodes@40@10))
  :pattern ((inv@71@10 n$5@70@10))
  :pattern ((img@72@10 n$5@70@10))
  :qid |right-permImpliesNonNull|)))
(declare-const sm@73@10 $FVF<right>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
    (=
      ($FVF.lookup_right (as sm@73@10  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (forall ((r $Ref)) (!
  (=>
    (Set_in (inv@71@10 r) nodes@40@10)
    ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) r) r))
  :pattern ((inv@71@10 r))
  :qid |quant-u-107|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))))
(declare-const n$6@74@10 $Ref)
(push) ; 3
; [eval] (n$6 in nodes)
(assert (Set_in n$6@74@10 nodes@40@10))
(pop) ; 3
(declare-fun inv@75@10 ($Ref) $Ref)
(declare-fun img@76@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((n$61@74@10 $Ref) (n$62@74@10 $Ref)) (!
  (=>
    (and
      (Set_in n$61@74@10 nodes@40@10)
      (Set_in n$62@74@10 nodes@40@10)
      (= n$61@74@10 n$62@74@10))
    (= n$61@74@10 n$62@74@10))
  
  :qid |is_marked-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((n$6@74@10 $Ref)) (!
  (=>
    (Set_in n$6@74@10 nodes@40@10)
    (and (= (inv@75@10 n$6@74@10) n$6@74@10) (img@76@10 n$6@74@10)))
  :pattern ((Set_in n$6@74@10 nodes@40@10))
  :pattern ((inv@75@10 n$6@74@10))
  :pattern ((img@76@10 n$6@74@10))
  :qid |quant-u-111|)))
(assert (forall ((r $Ref)) (!
  (=> (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10)) (= (inv@75@10 r) r))
  :pattern ((inv@75@10 r))
  :qid |is_marked-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((n$6@74@10 $Ref)) (!
  (=> (Set_in n$6@74@10 nodes@40@10) (not (= n$6@74@10 $Ref.null)))
  :pattern ((Set_in n$6@74@10 nodes@40@10))
  :pattern ((inv@75@10 n$6@74@10))
  :pattern ((img@76@10 n$6@74@10))
  :qid |is_marked-permImpliesNonNull|)))
(declare-const sm@77@10 $FVF<is_marked>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (forall ((r $Ref)) (!
  (=>
    (Set_in (inv@75@10 r) nodes@40@10)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r) r))
  :pattern ((inv@75@10 r))
  :qid |quant-u-113|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))
  $Snap.unit))
; [eval] (forall n$7: Ref :: { (n$7.left in nodes) } { (n$7 in nodes), n$7.left } (n$7 in nodes) && n$7.left != null ==> (n$7.left in nodes))
(declare-const n$7@78@10 $Ref)
(push) ; 3
; [eval] (n$7 in nodes) && n$7.left != null ==> (n$7.left in nodes)
; [eval] (n$7 in nodes) && n$7.left != null
; [eval] (n$7 in nodes)
(push) ; 4
; [then-branch: 5 | !(n$7@78@10 in nodes@40@10) | live]
; [else-branch: 5 | n$7@78@10 in nodes@40@10 | live]
(push) ; 5
; [then-branch: 5 | !(n$7@78@10 in nodes@40@10)]
(assert (not (Set_in n$7@78@10 nodes@40@10)))
(pop) ; 5
(push) ; 5
; [else-branch: 5 | n$7@78@10 in nodes@40@10]
(assert (Set_in n$7@78@10 nodes@40@10))
; [eval] n$7.left != null
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
      (=
        ($FVF.lookup_left (as sm@69@10  $FVF<left>) r)
        ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r)))
    :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
    :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r))
    :qid |qp.fvfValDef33|))
  (forall ((r $Ref)) (!
    ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r)
    :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
    :qid |qp.fvfResTrgDef34|))))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) n$7@78@10))
(push) ; 6
(assert (not (and (img@68@10 n$7@78@10) (Set_in (inv@67@10 n$7@78@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
    (=
      ($FVF.lookup_left (as sm@69@10  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (=>
  (Set_in n$7@78@10 nodes@40@10)
  (and
    (Set_in n$7@78@10 nodes@40@10)
    ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) n$7@78@10))))
(assert (or (Set_in n$7@78@10 nodes@40@10) (not (Set_in n$7@78@10 nodes@40@10))))
(push) ; 4
; [then-branch: 6 | n$7@78@10 in nodes@40@10 && Lookup(left, sm@69@10, n$7@78@10) != Null | live]
; [else-branch: 6 | !(n$7@78@10 in nodes@40@10 && Lookup(left, sm@69@10, n$7@78@10) != Null) | live]
(push) ; 5
; [then-branch: 6 | n$7@78@10 in nodes@40@10 && Lookup(left, sm@69@10, n$7@78@10) != Null]
(assert (and
  (Set_in n$7@78@10 nodes@40@10)
  (not (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) $Ref.null))))
; [eval] (n$7.left in nodes)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
      (=
        ($FVF.lookup_left (as sm@69@10  $FVF<left>) r)
        ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r)))
    :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
    :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r))
    :qid |qp.fvfValDef33|))
  (forall ((r $Ref)) (!
    ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r)
    :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
    :qid |qp.fvfResTrgDef34|))))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) n$7@78@10))
(push) ; 6
(assert (not (and (img@68@10 n$7@78@10) (Set_in (inv@67@10 n$7@78@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 6 | !(n$7@78@10 in nodes@40@10 && Lookup(left, sm@69@10, n$7@78@10) != Null)]
(assert (not
  (and
    (Set_in n$7@78@10 nodes@40@10)
    (not (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) $Ref.null)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
    (=
      ($FVF.lookup_left (as sm@69@10  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (=>
  (and
    (Set_in n$7@78@10 nodes@40@10)
    (not (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) $Ref.null)))
  (and
    (Set_in n$7@78@10 nodes@40@10)
    (not (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) $Ref.null))
    ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) n$7@78@10))))
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in n$7@78@10 nodes@40@10)
      (not (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) $Ref.null))))
  (and
    (Set_in n$7@78@10 nodes@40@10)
    (not (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) $Ref.null)))))
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
    (=
      ($FVF.lookup_left (as sm@69@10  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n$7@78@10 $Ref)) (!
  (and
    (=>
      (Set_in n$7@78@10 nodes@40@10)
      (and
        (Set_in n$7@78@10 nodes@40@10)
        ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) n$7@78@10)))
    (or (Set_in n$7@78@10 nodes@40@10) (not (Set_in n$7@78@10 nodes@40@10)))
    (=>
      (and
        (Set_in n$7@78@10 nodes@40@10)
        (not
          (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) $Ref.null)))
      (and
        (Set_in n$7@78@10 nodes@40@10)
        (not
          (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) $Ref.null))
        ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) n$7@78@10)))
    (or
      (not
        (and
          (Set_in n$7@78@10 nodes@40@10)
          (not
            (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) $Ref.null))))
      (and
        (Set_in n$7@78@10 nodes@40@10)
        (not
          (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) $Ref.null)))))
  :pattern ((Set_in ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) nodes@40@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@26@27@26@37-aux|)))
(assert (forall ((n$7@78@10 $Ref)) (!
  (and
    (=>
      (Set_in n$7@78@10 nodes@40@10)
      (and
        (Set_in n$7@78@10 nodes@40@10)
        ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) n$7@78@10)))
    (or (Set_in n$7@78@10 nodes@40@10) (not (Set_in n$7@78@10 nodes@40@10)))
    (=>
      (and
        (Set_in n$7@78@10 nodes@40@10)
        (not
          (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) $Ref.null)))
      (and
        (Set_in n$7@78@10 nodes@40@10)
        (not
          (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) $Ref.null))
        ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) n$7@78@10)))
    (or
      (not
        (and
          (Set_in n$7@78@10 nodes@40@10)
          (not
            (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) $Ref.null))))
      (and
        (Set_in n$7@78@10 nodes@40@10)
        (not
          (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) $Ref.null)))))
  :pattern ((Set_in n$7@78@10 nodes@40@10) ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) n$7@78@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@26@27@26@37-aux|)))
(assert (forall ((n$7@78@10 $Ref)) (!
  (=>
    (and
      (Set_in n$7@78@10 nodes@40@10)
      (not (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) $Ref.null)))
    (Set_in ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) nodes@40@10))
  :pattern ((Set_in ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) nodes@40@10))
  :pattern ((Set_in n$7@78@10 nodes@40@10) ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n$7@78@10) n$7@78@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@26@27@26@37|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))))
  $Snap.unit))
; [eval] (forall n$8: Ref :: { (n$8.right in nodes) } { (n$8 in nodes), n$8.right } (n$8 in nodes) && n$8.right != null ==> (n$8.right in nodes))
(declare-const n$8@79@10 $Ref)
(push) ; 3
; [eval] (n$8 in nodes) && n$8.right != null ==> (n$8.right in nodes)
; [eval] (n$8 in nodes) && n$8.right != null
; [eval] (n$8 in nodes)
(push) ; 4
; [then-branch: 7 | !(n$8@79@10 in nodes@40@10) | live]
; [else-branch: 7 | n$8@79@10 in nodes@40@10 | live]
(push) ; 5
; [then-branch: 7 | !(n$8@79@10 in nodes@40@10)]
(assert (not (Set_in n$8@79@10 nodes@40@10)))
(pop) ; 5
(push) ; 5
; [else-branch: 7 | n$8@79@10 in nodes@40@10]
(assert (Set_in n$8@79@10 nodes@40@10))
; [eval] n$8.right != null
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
      (=
        ($FVF.lookup_right (as sm@73@10  $FVF<right>) r)
        ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r)))
    :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
    :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r))
    :qid |qp.fvfValDef35|))
  (forall ((r $Ref)) (!
    ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r)
    :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
    :qid |qp.fvfResTrgDef36|))))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) n$8@79@10))
(push) ; 6
(assert (not (and (img@72@10 n$8@79@10) (Set_in (inv@71@10 n$8@79@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
    (=
      ($FVF.lookup_right (as sm@73@10  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (=>
  (Set_in n$8@79@10 nodes@40@10)
  (and
    (Set_in n$8@79@10 nodes@40@10)
    ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) n$8@79@10))))
(assert (or (Set_in n$8@79@10 nodes@40@10) (not (Set_in n$8@79@10 nodes@40@10))))
(push) ; 4
; [then-branch: 8 | n$8@79@10 in nodes@40@10 && Lookup(right, sm@73@10, n$8@79@10) != Null | live]
; [else-branch: 8 | !(n$8@79@10 in nodes@40@10 && Lookup(right, sm@73@10, n$8@79@10) != Null) | live]
(push) ; 5
; [then-branch: 8 | n$8@79@10 in nodes@40@10 && Lookup(right, sm@73@10, n$8@79@10) != Null]
(assert (and
  (Set_in n$8@79@10 nodes@40@10)
  (not (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) $Ref.null))))
; [eval] (n$8.right in nodes)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
      (=
        ($FVF.lookup_right (as sm@73@10  $FVF<right>) r)
        ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r)))
    :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
    :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r))
    :qid |qp.fvfValDef35|))
  (forall ((r $Ref)) (!
    ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r)
    :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
    :qid |qp.fvfResTrgDef36|))))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) n$8@79@10))
(push) ; 6
(assert (not (and (img@72@10 n$8@79@10) (Set_in (inv@71@10 n$8@79@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 8 | !(n$8@79@10 in nodes@40@10 && Lookup(right, sm@73@10, n$8@79@10) != Null)]
(assert (not
  (and
    (Set_in n$8@79@10 nodes@40@10)
    (not (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) $Ref.null)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
    (=
      ($FVF.lookup_right (as sm@73@10  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (=>
  (and
    (Set_in n$8@79@10 nodes@40@10)
    (not (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) $Ref.null)))
  (and
    (Set_in n$8@79@10 nodes@40@10)
    (not (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) $Ref.null))
    ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) n$8@79@10))))
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in n$8@79@10 nodes@40@10)
      (not
        (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) $Ref.null))))
  (and
    (Set_in n$8@79@10 nodes@40@10)
    (not (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) $Ref.null)))))
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
    (=
      ($FVF.lookup_right (as sm@73@10  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n$8@79@10 $Ref)) (!
  (and
    (=>
      (Set_in n$8@79@10 nodes@40@10)
      (and
        (Set_in n$8@79@10 nodes@40@10)
        ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) n$8@79@10)))
    (or (Set_in n$8@79@10 nodes@40@10) (not (Set_in n$8@79@10 nodes@40@10)))
    (=>
      (and
        (Set_in n$8@79@10 nodes@40@10)
        (not
          (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) $Ref.null)))
      (and
        (Set_in n$8@79@10 nodes@40@10)
        (not
          (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) $Ref.null))
        ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) n$8@79@10)))
    (or
      (not
        (and
          (Set_in n$8@79@10 nodes@40@10)
          (not
            (=
              ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10)
              $Ref.null))))
      (and
        (Set_in n$8@79@10 nodes@40@10)
        (not
          (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) $Ref.null)))))
  :pattern ((Set_in ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) nodes@40@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@26@27@26@37-aux|)))
(assert (forall ((n$8@79@10 $Ref)) (!
  (and
    (=>
      (Set_in n$8@79@10 nodes@40@10)
      (and
        (Set_in n$8@79@10 nodes@40@10)
        ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) n$8@79@10)))
    (or (Set_in n$8@79@10 nodes@40@10) (not (Set_in n$8@79@10 nodes@40@10)))
    (=>
      (and
        (Set_in n$8@79@10 nodes@40@10)
        (not
          (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) $Ref.null)))
      (and
        (Set_in n$8@79@10 nodes@40@10)
        (not
          (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) $Ref.null))
        ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) n$8@79@10)))
    (or
      (not
        (and
          (Set_in n$8@79@10 nodes@40@10)
          (not
            (=
              ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10)
              $Ref.null))))
      (and
        (Set_in n$8@79@10 nodes@40@10)
        (not
          (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) $Ref.null)))))
  :pattern ((Set_in n$8@79@10 nodes@40@10) ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) n$8@79@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@26@27@26@37-aux|)))
(assert (forall ((n$8@79@10 $Ref)) (!
  (=>
    (and
      (Set_in n$8@79@10 nodes@40@10)
      (not
        (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) $Ref.null)))
    (Set_in ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) nodes@40@10))
  :pattern ((Set_in ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) nodes@40@10))
  :pattern ((Set_in n$8@79@10 nodes@40@10) ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n$8@79@10) n$8@79@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@26@27@26@37|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))))
  $Snap.unit))
; [eval] (forall n: Ref :: { (n in nodes), n.is_marked } (n in nodes) ==> old(n.is_marked) ==> n.is_marked)
(declare-const n@80@10 $Ref)
(push) ; 3
; [eval] (n in nodes) ==> old(n.is_marked) ==> n.is_marked
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 9 | n@80@10 in nodes@40@10 | live]
; [else-branch: 9 | !(n@80@10 in nodes@40@10) | live]
(push) ; 5
; [then-branch: 9 | n@80@10 in nodes@40@10]
(assert (Set_in n@80@10 nodes@40@10))
; [eval] old(n.is_marked) ==> n.is_marked
; [eval] old(n.is_marked)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@10)
      (=
        ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r))
    :qid |qp.fvfValDef17|))
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@10)
      (=
        ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r))
    :qid |qp.fvfValDef18|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
    :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef19|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10) n@80@10))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n@80@10 b@13@10) $Perm.Write $Perm.No)
    (ite (= n@80@10 a@3@10) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
; [then-branch: 10 | Lookup(is_marked, sm@42@10, n@80@10) | live]
; [else-branch: 10 | !(Lookup(is_marked, sm@42@10, n@80@10)) | live]
(push) ; 7
; [then-branch: 10 | Lookup(is_marked, sm@42@10, n@80@10)]
(assert ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10))
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
      (=
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@80@10) n@80@10))
(push) ; 8
(assert (not (and (img@76@10 n@80@10) (Set_in (inv@75@10 n@80@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 10 | !(Lookup(is_marked, sm@42@10, n@80@10))]
(assert (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10)))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10)
  (and
    ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@80@10) n@80@10))))
; Joined path conditions
(assert (or
  (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10))
  ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10)))
(pop) ; 5
(push) ; 5
; [else-branch: 9 | !(n@80@10 in nodes@40@10)]
(assert (not (Set_in n@80@10 nodes@40@10)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (Set_in n@80@10 nodes@40@10)
  (and
    (Set_in n@80@10 nodes@40@10)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10) n@80@10)
    (=>
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10)
      (and
        ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@80@10) n@80@10)))
    (or
      (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10))
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10)))))
; Joined path conditions
(assert (or (not (Set_in n@80@10 nodes@40@10)) (Set_in n@80@10 nodes@40@10)))
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@80@10 $Ref)) (!
  (and
    (=>
      (Set_in n@80@10 nodes@40@10)
      (and
        (Set_in n@80@10 nodes@40@10)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10) n@80@10)
        (=>
          ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10)
          (and
            ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10)
            ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@80@10) n@80@10)))
        (or
          (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10))
          ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10))))
    (or (not (Set_in n@80@10 nodes@40@10)) (Set_in n@80@10 nodes@40@10)))
  :pattern ((Set_in n@80@10 nodes@40@10) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@80@10) n@80@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@30@10@30@102-aux|)))
(assert (forall ((n@80@10 $Ref)) (!
  (=>
    (and
      (Set_in n@80@10 nodes@40@10)
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@80@10))
    ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@80@10))
  :pattern ((Set_in n@80@10 nodes@40@10) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@80@10) n@80@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@30@10@30@102|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))))))
  $Snap.unit))
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
      (=
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) a@3@10) a@3@10))
(push) ; 3
(assert (not (and (img@76@10 a@3@10) (Set_in (inv@75@10 a@3@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) a@3@10))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))))))
  $Snap.unit))
; [eval] (forall n: Ref :: { (n in nodes), n.left } (n in nodes) ==> n.left == old(n.left))
(declare-const n@81@10 $Ref)
(push) ; 3
; [eval] (n in nodes) ==> n.left == old(n.left)
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 11 | n@81@10 in nodes@40@10 | live]
; [else-branch: 11 | !(n@81@10 in nodes@40@10) | live]
(push) ; 5
; [then-branch: 11 | n@81@10 in nodes@40@10]
(assert (Set_in n@81@10 nodes@40@10))
; [eval] n.left == old(n.left)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
      (=
        ($FVF.lookup_left (as sm@69@10  $FVF<left>) r)
        ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r)))
    :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
    :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r))
    :qid |qp.fvfValDef33|))
  (forall ((r $Ref)) (!
    ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r)
    :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
    :qid |qp.fvfResTrgDef34|))))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@81@10) n@81@10))
(push) ; 6
(assert (not (and (img@68@10 n@81@10) (Set_in (inv@67@10 n@81@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] old(n.left)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@10)
      (=
        ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
        ($FVF.lookup_left (as sm@27@10  $FVF<left>) r)))
    :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
    :pattern (($FVF.lookup_left (as sm@27@10  $FVF<left>) r))
    :qid |qp.fvfValDef22|))
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@10)
      (=
        ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
        ($FVF.lookup_left (as sm@35@10  $FVF<left>) r)))
    :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
    :pattern (($FVF.lookup_left (as sm@35@10  $FVF<left>) r))
    :qid |qp.fvfValDef23|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_left ($FVF.lookup_left (as sm@27@10  $FVF<left>) r) r)
      ($FVF.loc_left ($FVF.lookup_left (as sm@35@10  $FVF<left>) r) r))
    :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
    :qid |qp.fvfResTrgDef24|))))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n@81@10) n@81@10))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n@81@10 a@3@10) $Perm.Write $Perm.No)
    (ite (= n@81@10 b@13@10) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 11 | !(n@81@10 in nodes@40@10)]
(assert (not (Set_in n@81@10 nodes@40@10)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
    (=
      ($FVF.lookup_left (as sm@69@10  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@27@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@27@10  $FVF<left>) r))
  :qid |qp.fvfValDef22|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@35@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@35@10  $FVF<left>) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@27@10  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@35@10  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef24|)))
(assert (=>
  (Set_in n@81@10 nodes@40@10)
  (and
    (Set_in n@81@10 nodes@40@10)
    ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@81@10) n@81@10)
    ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n@81@10) n@81@10))))
; Joined path conditions
(assert (or (not (Set_in n@81@10 nodes@40@10)) (Set_in n@81@10 nodes@40@10)))
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
    (=
      ($FVF.lookup_left (as sm@69@10  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@27@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@27@10  $FVF<left>) r))
  :qid |qp.fvfValDef22|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_left (as sm@47@10  $FVF<left>) r)
      ($FVF.lookup_left (as sm@35@10  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@35@10  $FVF<left>) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@27@10  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@35@10  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@47@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef24|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@81@10 $Ref)) (!
  (and
    (=>
      (Set_in n@81@10 nodes@40@10)
      (and
        (Set_in n@81@10 nodes@40@10)
        ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@81@10) n@81@10)
        ($FVF.loc_left ($FVF.lookup_left (as sm@47@10  $FVF<left>) n@81@10) n@81@10)))
    (or (not (Set_in n@81@10 nodes@40@10)) (Set_in n@81@10 nodes@40@10)))
  :pattern ((Set_in n@81@10 nodes@40@10) ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@81@10) n@81@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@34@10@34@86-aux|)))
(assert (forall ((n@81@10 $Ref)) (!
  (=>
    (Set_in n@81@10 nodes@40@10)
    (=
      ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@81@10)
      ($FVF.lookup_left (as sm@47@10  $FVF<left>) n@81@10)))
  :pattern ((Set_in n@81@10 nodes@40@10) ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@81@10) n@81@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@34@10@34@86|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))))))))
  $Snap.unit))
; [eval] (forall n: Ref :: { (n in nodes), n.right } (n in nodes) ==> n.right == old(n.right))
(declare-const n@82@10 $Ref)
(push) ; 3
; [eval] (n in nodes) ==> n.right == old(n.right)
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 12 | n@82@10 in nodes@40@10 | live]
; [else-branch: 12 | !(n@82@10 in nodes@40@10) | live]
(push) ; 5
; [then-branch: 12 | n@82@10 in nodes@40@10]
(assert (Set_in n@82@10 nodes@40@10))
; [eval] n.right == old(n.right)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
      (=
        ($FVF.lookup_right (as sm@73@10  $FVF<right>) r)
        ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r)))
    :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
    :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r))
    :qid |qp.fvfValDef35|))
  (forall ((r $Ref)) (!
    ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r)
    :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
    :qid |qp.fvfResTrgDef36|))))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@82@10) n@82@10))
(push) ; 6
(assert (not (and (img@72@10 n@82@10) (Set_in (inv@71@10 n@82@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] old(n.right)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@10)
      (=
        ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
        ($FVF.lookup_right (as sm@39@10  $FVF<right>) r)))
    :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
    :pattern (($FVF.lookup_right (as sm@39@10  $FVF<right>) r))
    :qid |qp.fvfValDef28|))
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@10)
      (=
        ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
        ($FVF.lookup_right (as sm@31@10  $FVF<right>) r)))
    :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
    :pattern (($FVF.lookup_right (as sm@31@10  $FVF<right>) r))
    :qid |qp.fvfValDef29|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_right ($FVF.lookup_right (as sm@39@10  $FVF<right>) r) r)
      ($FVF.loc_right ($FVF.lookup_right (as sm@31@10  $FVF<right>) r) r))
    :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
    :qid |qp.fvfResTrgDef30|))))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) n@82@10) n@82@10))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n@82@10 b@13@10) $Perm.Write $Perm.No)
    (ite (= n@82@10 a@3@10) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 12 | !(n@82@10 in nodes@40@10)]
(assert (not (Set_in n@82@10 nodes@40@10)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
    (=
      ($FVF.lookup_right (as sm@73@10  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@39@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@39@10  $FVF<right>) r))
  :qid |qp.fvfValDef28|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@10  $FVF<right>) r))
  :qid |qp.fvfValDef29|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@10  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef30|)))
(assert (=>
  (Set_in n@82@10 nodes@40@10)
  (and
    (Set_in n@82@10 nodes@40@10)
    ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@82@10) n@82@10)
    ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) n@82@10) n@82@10))))
; Joined path conditions
(assert (or (not (Set_in n@82@10 nodes@40@10)) (Set_in n@82@10 nodes@40@10)))
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
    (=
      ($FVF.lookup_right (as sm@73@10  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@39@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@39@10  $FVF<right>) r))
  :qid |qp.fvfValDef28|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_right (as sm@63@10  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@10  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@10  $FVF<right>) r))
  :qid |qp.fvfValDef29|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@10  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@63@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef30|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@82@10 $Ref)) (!
  (and
    (=>
      (Set_in n@82@10 nodes@40@10)
      (and
        (Set_in n@82@10 nodes@40@10)
        ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@82@10) n@82@10)
        ($FVF.loc_right ($FVF.lookup_right (as sm@63@10  $FVF<right>) n@82@10) n@82@10)))
    (or (not (Set_in n@82@10 nodes@40@10)) (Set_in n@82@10 nodes@40@10)))
  :pattern ((Set_in n@82@10 nodes@40@10) ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@82@10) n@82@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@35@10@35@89-aux|)))
(assert (forall ((n@82@10 $Ref)) (!
  (=>
    (Set_in n@82@10 nodes@40@10)
    (=
      ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@82@10)
      ($FVF.lookup_right (as sm@63@10  $FVF<right>) n@82@10)))
  :pattern ((Set_in n@82@10 nodes@40@10) ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@82@10) n@82@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@35@10@35@89|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))))))))
  $Snap.unit))
; [eval] (forall n: Ref :: { (n in nodes), n.is_marked } { (n in nodes), n.left.is_marked } (n in nodes) ==> old(!n.is_marked) && n.is_marked ==> n.left == null || n.left.is_marked)
(declare-const n@83@10 $Ref)
(push) ; 3
; [eval] (n in nodes) ==> old(!n.is_marked) && n.is_marked ==> n.left == null || n.left.is_marked
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 13 | n@83@10 in nodes@40@10 | live]
; [else-branch: 13 | !(n@83@10 in nodes@40@10) | live]
(push) ; 5
; [then-branch: 13 | n@83@10 in nodes@40@10]
(assert (Set_in n@83@10 nodes@40@10))
; [eval] old(!n.is_marked) && n.is_marked ==> n.left == null || n.left.is_marked
; [eval] old(!n.is_marked) && n.is_marked
; [eval] old(!n.is_marked)
; [eval] !n.is_marked
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@10)
      (=
        ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r))
    :qid |qp.fvfValDef17|))
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@10)
      (=
        ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r))
    :qid |qp.fvfValDef18|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
    :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef19|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10) n@83@10))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n@83@10 b@13@10) $Perm.Write $Perm.No)
    (ite (= n@83@10 a@3@10) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
; [then-branch: 14 | Lookup(is_marked, sm@42@10, n@83@10) | live]
; [else-branch: 14 | !(Lookup(is_marked, sm@42@10, n@83@10)) | live]
(push) ; 7
; [then-branch: 14 | Lookup(is_marked, sm@42@10, n@83@10)]
(assert ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
(pop) ; 7
(push) ; 7
; [else-branch: 14 | !(Lookup(is_marked, sm@42@10, n@83@10))]
(assert (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10)))
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
      (=
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10) n@83@10))
(push) ; 8
(assert (not (and (img@76@10 n@83@10) (Set_in (inv@75@10 n@83@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
  (and
    (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10) n@83@10))))
(assert (or
  (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
  ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10)))
(push) ; 6
; [then-branch: 15 | !(Lookup(is_marked, sm@42@10, n@83@10)) && Lookup(is_marked, sm@77@10, n@83@10) | live]
; [else-branch: 15 | !(!(Lookup(is_marked, sm@42@10, n@83@10)) && Lookup(is_marked, sm@77@10, n@83@10)) | live]
(push) ; 7
; [then-branch: 15 | !(Lookup(is_marked, sm@42@10, n@83@10)) && Lookup(is_marked, sm@77@10, n@83@10)]
(assert (and
  (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
  ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10)))
; [eval] n.left == null || n.left.is_marked
; [eval] n.left == null
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
      (=
        ($FVF.lookup_left (as sm@69@10  $FVF<left>) r)
        ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r)))
    :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
    :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r))
    :qid |qp.fvfValDef33|))
  (forall ((r $Ref)) (!
    ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r)
    :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
    :qid |qp.fvfResTrgDef34|))))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) n@83@10))
(push) ; 8
(assert (not (and (img@68@10 n@83@10) (Set_in (inv@67@10 n@83@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(push) ; 8
; [then-branch: 16 | Lookup(left, sm@69@10, n@83@10) == Null | live]
; [else-branch: 16 | Lookup(left, sm@69@10, n@83@10) != Null | live]
(push) ; 9
; [then-branch: 16 | Lookup(left, sm@69@10, n@83@10) == Null]
(assert (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null))
(pop) ; 9
(push) ; 9
; [else-branch: 16 | Lookup(left, sm@69@10, n@83@10) != Null]
(assert (not (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null)))
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
      (=
        ($FVF.lookup_left (as sm@69@10  $FVF<left>) r)
        ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r)))
    :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
    :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r))
    :qid |qp.fvfValDef33|))
  (forall ((r $Ref)) (!
    ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r)
    :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
    :qid |qp.fvfResTrgDef34|))))
(push) ; 10
(assert (not (and (img@68@10 n@83@10) (Set_in (inv@67@10 n@83@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
      (=
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)))
(push) ; 10
(assert (not (and
  (img@76@10 ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10))
  (Set_in (inv@75@10 ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
    (=
      ($FVF.lookup_left (as sm@69@10  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (not (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null))
  (and
    (not (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null))
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)))))
(assert (or
  (not (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null))
  (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null)))
(pop) ; 7
(push) ; 7
; [else-branch: 15 | !(!(Lookup(is_marked, sm@42@10, n@83@10)) && Lookup(is_marked, sm@77@10, n@83@10))]
(assert (not
  (and
    (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
    ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
    (=
      ($FVF.lookup_left (as sm@69@10  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (and
    (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
    ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10))
  (and
    (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
    ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10)
    ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) n@83@10)
    (=>
      (not (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null))
      (and
        (not (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null))
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10))))
    (or
      (not (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null))
      (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null)))))
; Joined path conditions
(assert (or
  (not
    (and
      (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10)))
  (and
    (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
    ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10))))
(pop) ; 5
(push) ; 5
; [else-branch: 13 | !(n@83@10 in nodes@40@10)]
(assert (not (Set_in n@83@10 nodes@40@10)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
    (=
      ($FVF.lookup_left (as sm@69@10  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (=>
  (Set_in n@83@10 nodes@40@10)
  (and
    (Set_in n@83@10 nodes@40@10)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10) n@83@10)
    (=>
      (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
      (and
        (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10) n@83@10)))
    (or
      (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
    (=>
      (and
        (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10))
      (and
        (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10)
        ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) n@83@10)
        (=>
          (not
            (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null))
          (and
            (not
              (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null))
            ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10))))
        (or
          (not
            (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null))
          (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null))))
    (or
      (not
        (and
          (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
          ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10)))
      (and
        (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10))))))
; Joined path conditions
(assert (or (not (Set_in n@83@10 nodes@40@10)) (Set_in n@83@10 nodes@40@10)))
; Definitional axioms for snapshot map values
; Definitional axioms for snapshot map values
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
    (=
      ($FVF.lookup_left (as sm@69@10  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@10  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@83@10 $Ref)) (!
  (and
    (=>
      (Set_in n@83@10 nodes@40@10)
      (and
        (Set_in n@83@10 nodes@40@10)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10) n@83@10)
        (=>
          (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
            ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10) n@83@10)))
        (or
          (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
          ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
        (=>
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
            ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
            ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10)
            ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) n@83@10)
            (=>
              (not
                (=
                  ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)
                  $Ref.null))
              (and
                (not
                  (=
                    ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)
                    $Ref.null))
                ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10))))
            (or
              (not
                (=
                  ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)
                  $Ref.null))
              (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null))))
        (or
          (not
            (and
              (not
                ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
              ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10)))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
            ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10)))))
    (or (not (Set_in n@83@10 nodes@40@10)) (Set_in n@83@10 nodes@40@10)))
  :pattern ((Set_in n@83@10 nodes@40@10) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10) n@83@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@38@10@39@103-aux|)))
(assert (forall ((n@83@10 $Ref)) (!
  (and
    (=>
      (Set_in n@83@10 nodes@40@10)
      (and
        (Set_in n@83@10 nodes@40@10)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10) n@83@10)
        (=>
          (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
            ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10) n@83@10)))
        (or
          (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
          ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
        (=>
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
            ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
            ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10)
            ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) n@83@10)
            (=>
              (not
                (=
                  ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)
                  $Ref.null))
              (and
                (not
                  (=
                    ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)
                    $Ref.null))
                ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10))))
            (or
              (not
                (=
                  ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)
                  $Ref.null))
              (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null))))
        (or
          (not
            (and
              (not
                ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
              ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10)))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
            ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10)))))
    (or (not (Set_in n@83@10 nodes@40@10)) (Set_in n@83@10 nodes@40@10)))
  :pattern ((Set_in n@83@10 nodes@40@10) ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) n@83@10) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@38@10@39@103-aux|)))
(assert (forall ((n@83@10 $Ref)) (!
  (=>
    (and
      (Set_in n@83@10 nodes@40@10)
      (and
        (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@83@10))
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10)))
    (or
      (= ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) $Ref.null)
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10))))
  :pattern ((Set_in n@83@10 nodes@40@10) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@83@10) n@83@10))
  :pattern ((Set_in n@83@10 nodes@40@10) ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10) n@83@10) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)) ($FVF.lookup_left (as sm@69@10  $FVF<left>) n@83@10)))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@38@10@39@103|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10))))))))))))
  $Snap.unit))
; [eval] (forall n: Ref :: { (n in nodes), n.is_marked } { (n in nodes), n.right.is_marked } (n in nodes) ==> old(!n.is_marked) && n.is_marked ==> n.right == null || n.right.is_marked)
(declare-const n@84@10 $Ref)
(push) ; 3
; [eval] (n in nodes) ==> old(!n.is_marked) && n.is_marked ==> n.right == null || n.right.is_marked
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 17 | n@84@10 in nodes@40@10 | live]
; [else-branch: 17 | !(n@84@10 in nodes@40@10) | live]
(push) ; 5
; [then-branch: 17 | n@84@10 in nodes@40@10]
(assert (Set_in n@84@10 nodes@40@10))
; [eval] old(!n.is_marked) && n.is_marked ==> n.right == null || n.right.is_marked
; [eval] old(!n.is_marked) && n.is_marked
; [eval] old(!n.is_marked)
; [eval] !n.is_marked
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@10)
      (=
        ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r))
    :qid |qp.fvfValDef17|))
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@10)
      (=
        ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r))
    :qid |qp.fvfValDef18|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
    :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef19|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10) n@84@10))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n@84@10 b@13@10) $Perm.Write $Perm.No)
    (ite (= n@84@10 a@3@10) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
; [then-branch: 18 | Lookup(is_marked, sm@42@10, n@84@10) | live]
; [else-branch: 18 | !(Lookup(is_marked, sm@42@10, n@84@10)) | live]
(push) ; 7
; [then-branch: 18 | Lookup(is_marked, sm@42@10, n@84@10)]
(assert ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
(pop) ; 7
(push) ; 7
; [else-branch: 18 | !(Lookup(is_marked, sm@42@10, n@84@10))]
(assert (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10)))
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
      (=
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10) n@84@10))
(push) ; 8
(assert (not (and (img@76@10 n@84@10) (Set_in (inv@75@10 n@84@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
  (and
    (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10) n@84@10))))
(assert (or
  (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
  ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10)))
(push) ; 6
; [then-branch: 19 | !(Lookup(is_marked, sm@42@10, n@84@10)) && Lookup(is_marked, sm@77@10, n@84@10) | live]
; [else-branch: 19 | !(!(Lookup(is_marked, sm@42@10, n@84@10)) && Lookup(is_marked, sm@77@10, n@84@10)) | live]
(push) ; 7
; [then-branch: 19 | !(Lookup(is_marked, sm@42@10, n@84@10)) && Lookup(is_marked, sm@77@10, n@84@10)]
(assert (and
  (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
  ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10)))
; [eval] n.right == null || n.right.is_marked
; [eval] n.right == null
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
      (=
        ($FVF.lookup_right (as sm@73@10  $FVF<right>) r)
        ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r)))
    :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
    :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r))
    :qid |qp.fvfValDef35|))
  (forall ((r $Ref)) (!
    ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r)
    :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
    :qid |qp.fvfResTrgDef36|))))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) n@84@10))
(push) ; 8
(assert (not (and (img@72@10 n@84@10) (Set_in (inv@71@10 n@84@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(push) ; 8
; [then-branch: 20 | Lookup(right, sm@73@10, n@84@10) == Null | live]
; [else-branch: 20 | Lookup(right, sm@73@10, n@84@10) != Null | live]
(push) ; 9
; [then-branch: 20 | Lookup(right, sm@73@10, n@84@10) == Null]
(assert (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) $Ref.null))
(pop) ; 9
(push) ; 9
; [else-branch: 20 | Lookup(right, sm@73@10, n@84@10) != Null]
(assert (not (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) $Ref.null)))
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
      (=
        ($FVF.lookup_right (as sm@73@10  $FVF<right>) r)
        ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r)))
    :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
    :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r))
    :qid |qp.fvfValDef35|))
  (forall ((r $Ref)) (!
    ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r)
    :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
    :qid |qp.fvfResTrgDef36|))))
(push) ; 10
(assert (not (and (img@72@10 n@84@10) (Set_in (inv@71@10 n@84@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
      (=
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)))
(push) ; 10
(assert (not (and
  (img@76@10 ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10))
  (Set_in (inv@75@10 ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
    (=
      ($FVF.lookup_right (as sm@73@10  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (not (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) $Ref.null))
  (and
    (not (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) $Ref.null))
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)))))
(assert (or
  (not (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) $Ref.null))
  (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) $Ref.null)))
(pop) ; 7
(push) ; 7
; [else-branch: 19 | !(!(Lookup(is_marked, sm@42@10, n@84@10)) && Lookup(is_marked, sm@77@10, n@84@10))]
(assert (not
  (and
    (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
    ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
    (=
      ($FVF.lookup_right (as sm@73@10  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (and
    (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
    ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10))
  (and
    (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
    ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10)
    ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) n@84@10)
    (=>
      (not (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) $Ref.null))
      (and
        (not
          (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) $Ref.null))
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10))))
    (or
      (not (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) $Ref.null))
      (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) $Ref.null)))))
; Joined path conditions
(assert (or
  (not
    (and
      (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10)))
  (and
    (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
    ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10))))
(pop) ; 5
(push) ; 5
; [else-branch: 17 | !(n@84@10 in nodes@40@10)]
(assert (not (Set_in n@84@10 nodes@40@10)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
    (=
      ($FVF.lookup_right (as sm@73@10  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (=>
  (Set_in n@84@10 nodes@40@10)
  (and
    (Set_in n@84@10 nodes@40@10)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10) n@84@10)
    (=>
      (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
      (and
        (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10) n@84@10)))
    (or
      (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
    (=>
      (and
        (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10))
      (and
        (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10)
        ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) n@84@10)
        (=>
          (not
            (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) $Ref.null))
          (and
            (not
              (=
                ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)
                $Ref.null))
            ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10))))
        (or
          (not
            (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) $Ref.null))
          (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) $Ref.null))))
    (or
      (not
        (and
          (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
          ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10)))
      (and
        (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10))))))
; Joined path conditions
(assert (or (not (Set_in n@84@10 nodes@40@10)) (Set_in n@84@10 nodes@40@10)))
; Definitional axioms for snapshot map values
; Definitional axioms for snapshot map values
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@10)
    (=
      ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@10  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
    (=
      ($FVF.lookup_right (as sm@73@10  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@10  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@84@10 $Ref)) (!
  (and
    (=>
      (Set_in n@84@10 nodes@40@10)
      (and
        (Set_in n@84@10 nodes@40@10)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10) n@84@10)
        (=>
          (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
            ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10) n@84@10)))
        (or
          (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
          ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
        (=>
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
            ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
            ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10)
            ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) n@84@10)
            (=>
              (not
                (=
                  ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)
                  $Ref.null))
              (and
                (not
                  (=
                    ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)
                    $Ref.null))
                ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10))))
            (or
              (not
                (=
                  ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)
                  $Ref.null))
              (=
                ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)
                $Ref.null))))
        (or
          (not
            (and
              (not
                ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
              ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10)))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
            ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10)))))
    (or (not (Set_in n@84@10 nodes@40@10)) (Set_in n@84@10 nodes@40@10)))
  :pattern ((Set_in n@84@10 nodes@40@10) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10) n@84@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@40@10@41@104-aux|)))
(assert (forall ((n@84@10 $Ref)) (!
  (and
    (=>
      (Set_in n@84@10 nodes@40@10)
      (and
        (Set_in n@84@10 nodes@40@10)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10) n@84@10)
        (=>
          (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
            ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10) n@84@10)))
        (or
          (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
          ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
        (=>
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
            ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
            ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10)
            ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) n@84@10)
            (=>
              (not
                (=
                  ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)
                  $Ref.null))
              (and
                (not
                  (=
                    ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)
                    $Ref.null))
                ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10))))
            (or
              (not
                (=
                  ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)
                  $Ref.null))
              (=
                ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)
                $Ref.null))))
        (or
          (not
            (and
              (not
                ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
              ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10)))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
            ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10)))))
    (or (not (Set_in n@84@10 nodes@40@10)) (Set_in n@84@10 nodes@40@10)))
  :pattern ((Set_in n@84@10 nodes@40@10) ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) n@84@10) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@40@10@41@104-aux|)))
(assert (forall ((n@84@10 $Ref)) (!
  (=>
    (and
      (Set_in n@84@10 nodes@40@10)
      (and
        (not ($FVF.lookup_is_marked (as sm@42@10  $FVF<is_marked>) n@84@10))
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10)))
    (or
      (= ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) $Ref.null)
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10))))
  :pattern ((Set_in n@84@10 nodes@40@10) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@84@10) n@84@10))
  :pattern ((Set_in n@84@10 nodes@40@10) ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10) n@84@10) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)) ($FVF.lookup_right (as sm@73@10  $FVF<right>) n@84@10)))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@40@10@41@104|)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
; [exec]
; assert (forall n: Ref :: { (n in nodes) } (n in nodes) ==> n.is_marked)
; [eval] (forall n: Ref :: { (n in nodes) } (n in nodes) ==> n.is_marked)
(declare-const n@85@10 $Ref)
(set-option :timeout 0)
(push) ; 3
; [eval] (n in nodes) ==> n.is_marked
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 21 | n@85@10 in nodes@40@10 | live]
; [else-branch: 21 | !(n@85@10 in nodes@40@10) | live]
(push) ; 5
; [then-branch: 21 | n@85@10 in nodes@40@10]
(assert (Set_in n@85@10 nodes@40@10))
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
      (=
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@85@10) n@85@10))
(push) ; 6
(assert (not (and (img@76@10 n@85@10) (Set_in (inv@75@10 n@85@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 21 | !(n@85@10 in nodes@40@10)]
(assert (not (Set_in n@85@10 nodes@40@10)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (Set_in n@85@10 nodes@40@10)
  (and
    (Set_in n@85@10 nodes@40@10)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@85@10) n@85@10))))
; Joined path conditions
(assert (or (not (Set_in n@85@10 nodes@40@10)) (Set_in n@85@10 nodes@40@10)))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@85@10 $Ref)) (!
  (and
    (=>
      (Set_in n@85@10 nodes@40@10)
      (and
        (Set_in n@85@10 nodes@40@10)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@85@10) n@85@10)))
    (or (not (Set_in n@85@10 nodes@40@10)) (Set_in n@85@10 nodes@40@10)))
  :pattern ((Set_in n@85@10 nodes@40@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@85@9@85@52-aux|)))
(push) ; 3
(assert (not (forall ((n@85@10 $Ref)) (!
  (=>
    (Set_in n@85@10 nodes@40@10)
    ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@85@10))
  :pattern ((Set_in n@85@10 nodes@40@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@85@9@85@52|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Definitional axioms for snapshot map values
(declare-const pm@86@10 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_is_marked (as pm@86@10  $FPM) r)
    (ite
      (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
      $Perm.Write
      $Perm.No))
  :pattern (($FVF.perm_is_marked (as pm@86@10  $FPM) r))
  :qid |qp.resPrmSumDef39|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r))
  :pattern (($FVF.perm_is_marked (as pm@86@10  $FPM) r))
  :qid |qp.resTrgDef40|)))
; Assume upper permission bound for field is_marked
(assert (forall ((r $Ref)) (!
  (<= ($FVF.perm_is_marked (as pm@86@10  $FPM) r) $Perm.Write)
  :pattern (($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r) r))
  :qid |qp-fld-prm-bnd|)))
; Definitional axioms for snapshot map values
(declare-const pm@87@10 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_left (as pm@87@10  $FPM) r)
    (ite
      (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
      $Perm.Write
      $Perm.No))
  :pattern (($FVF.perm_left (as pm@87@10  $FPM) r))
  :qid |qp.resPrmSumDef41|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r))
  :pattern (($FVF.perm_left (as pm@87@10  $FPM) r))
  :qid |qp.resTrgDef42|)))
; Assume upper permission bound for field left
(assert (forall ((r $Ref)) (!
  (<= ($FVF.perm_left (as pm@87@10  $FPM) r) $Perm.Write)
  :pattern (($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) r) r))
  :qid |qp-fld-prm-bnd|)))
; Definitional axioms for snapshot map values
(declare-const pm@88@10 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_right (as pm@88@10  $FPM) r)
    (ite
      (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
      $Perm.Write
      $Perm.No))
  :pattern (($FVF.perm_right (as pm@88@10  $FPM) r))
  :qid |qp.resPrmSumDef43|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r))
  :pattern (($FVF.perm_right (as pm@88@10  $FPM) r))
  :qid |qp.resTrgDef44|)))
; Assume upper permission bound for field right
(assert (forall ((r $Ref)) (!
  (<= ($FVF.perm_right (as pm@88@10  $FPM) r) $Perm.Write)
  :pattern (($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) r) r))
  :qid |qp-fld-prm-bnd|)))
; [eval] (forall n: Ref :: { (n in nodes) } (n in nodes) ==> n.is_marked)
(declare-const n@89@10 $Ref)
(set-option :timeout 0)
(push) ; 3
; [eval] (n in nodes) ==> n.is_marked
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 22 | n@89@10 in nodes@40@10 | live]
; [else-branch: 22 | !(n@89@10 in nodes@40@10) | live]
(push) ; 5
; [then-branch: 22 | n@89@10 in nodes@40@10]
(assert (Set_in n@89@10 nodes@40@10))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Definitional axioms for snapshot map values
; Assume upper permission bound for field is_marked
; Definitional axioms for snapshot map values
; Assume upper permission bound for field left
; Definitional axioms for snapshot map values
; Assume upper permission bound for field right
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
      (=
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@89@10) n@89@10))
(set-option :timeout 0)
(push) ; 6
(assert (not (and (img@76@10 n@89@10) (Set_in (inv@75@10 n@89@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 22 | !(n@89@10 in nodes@40@10)]
(assert (not (Set_in n@89@10 nodes@40@10)))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
; Assume upper permission bound for field is_marked
; Definitional axioms for snapshot map values
; Assume upper permission bound for field left
; Definitional axioms for snapshot map values
; Assume upper permission bound for field right
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (Set_in n@89@10 nodes@40@10)
  (and
    (Set_in n@89@10 nodes@40@10)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@89@10) n@89@10))))
; Joined path conditions
(assert (or (not (Set_in n@89@10 nodes@40@10)) (Set_in n@89@10 nodes@40@10)))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@89@10 $Ref)) (!
  (and
    (=>
      (Set_in n@89@10 nodes@40@10)
      (and
        (Set_in n@89@10 nodes@40@10)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@89@10) n@89@10)))
    (or (not (Set_in n@89@10 nodes@40@10)) (Set_in n@89@10 nodes@40@10)))
  :pattern ((Set_in n@89@10 nodes@40@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@85@9@85@52-aux|)))
(set-option :timeout 0)
(push) ; 3
(assert (not (forall ((n@89@10 $Ref)) (!
  (=>
    (Set_in n@89@10 nodes@40@10)
    ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@89@10))
  :pattern ((Set_in n@89@10 nodes@40@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@85@9@85@52|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Definitional axioms for snapshot map values
(declare-const pm@90@10 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_is_marked (as pm@90@10  $FPM) r)
    (ite
      (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
      $Perm.Write
      $Perm.No))
  :pattern (($FVF.perm_is_marked (as pm@90@10  $FPM) r))
  :qid |qp.resPrmSumDef45|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r))
  :pattern (($FVF.perm_is_marked (as pm@90@10  $FPM) r))
  :qid |qp.resTrgDef46|)))
; Assume upper permission bound for field is_marked
(assert (forall ((r $Ref)) (!
  (<= ($FVF.perm_is_marked (as pm@90@10  $FPM) r) $Perm.Write)
  :pattern (($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r) r))
  :qid |qp-fld-prm-bnd|)))
; Definitional axioms for snapshot map values
(declare-const pm@91@10 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_left (as pm@91@10  $FPM) r)
    (ite
      (and (img@68@10 r) (Set_in (inv@67@10 r) nodes@40@10))
      $Perm.Write
      $Perm.No))
  :pattern (($FVF.perm_left (as pm@91@10  $FPM) r))
  :qid |qp.resPrmSumDef47|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@10)))) r) r))
  :pattern (($FVF.perm_left (as pm@91@10  $FPM) r))
  :qid |qp.resTrgDef48|)))
; Assume upper permission bound for field left
(assert (forall ((r $Ref)) (!
  (<= ($FVF.perm_left (as pm@91@10  $FPM) r) $Perm.Write)
  :pattern (($FVF.loc_left ($FVF.lookup_left (as sm@69@10  $FVF<left>) r) r))
  :qid |qp-fld-prm-bnd|)))
; Definitional axioms for snapshot map values
(declare-const pm@92@10 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_right (as pm@92@10  $FPM) r)
    (ite
      (and (img@72@10 r) (Set_in (inv@71@10 r) nodes@40@10))
      $Perm.Write
      $Perm.No))
  :pattern (($FVF.perm_right (as pm@92@10  $FPM) r))
  :qid |qp.resPrmSumDef49|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@10))))) r) r))
  :pattern (($FVF.perm_right (as pm@92@10  $FPM) r))
  :qid |qp.resTrgDef50|)))
; Assume upper permission bound for field right
(assert (forall ((r $Ref)) (!
  (<= ($FVF.perm_right (as pm@92@10  $FPM) r) $Perm.Write)
  :pattern (($FVF.loc_right ($FVF.lookup_right (as sm@73@10  $FVF<right>) r) r))
  :qid |qp-fld-prm-bnd|)))
; [eval] (forall n: Ref :: { (n in nodes) } (n in nodes) ==> n.is_marked)
(declare-const n@93@10 $Ref)
(set-option :timeout 0)
(push) ; 3
; [eval] (n in nodes) ==> n.is_marked
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 23 | n@93@10 in nodes@40@10 | live]
; [else-branch: 23 | !(n@93@10 in nodes@40@10) | live]
(push) ; 5
; [then-branch: 23 | n@93@10 in nodes@40@10]
(assert (Set_in n@93@10 nodes@40@10))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Definitional axioms for snapshot map values
; Assume upper permission bound for field is_marked
; Definitional axioms for snapshot map values
; Assume upper permission bound for field left
; Definitional axioms for snapshot map values
; Assume upper permission bound for field right
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
      (=
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@93@10) n@93@10))
(set-option :timeout 0)
(push) ; 6
(assert (not (and (img@76@10 n@93@10) (Set_in (inv@75@10 n@93@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 23 | !(n@93@10 in nodes@40@10)]
(assert (not (Set_in n@93@10 nodes@40@10)))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
; Assume upper permission bound for field is_marked
; Definitional axioms for snapshot map values
; Assume upper permission bound for field left
; Definitional axioms for snapshot map values
; Assume upper permission bound for field right
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (Set_in n@93@10 nodes@40@10)
  (and
    (Set_in n@93@10 nodes@40@10)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@93@10) n@93@10))))
; Joined path conditions
(assert (or (not (Set_in n@93@10 nodes@40@10)) (Set_in n@93@10 nodes@40@10)))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@93@10 $Ref)) (!
  (and
    (=>
      (Set_in n@93@10 nodes@40@10)
      (and
        (Set_in n@93@10 nodes@40@10)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@93@10) n@93@10)))
    (or (not (Set_in n@93@10 nodes@40@10)) (Set_in n@93@10 nodes@40@10)))
  :pattern ((Set_in n@93@10 nodes@40@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@85@9@85@52-aux|)))
(set-option :timeout 0)
(push) ; 3
(assert (not (forall ((n@93@10 $Ref)) (!
  (=>
    (Set_in n@93@10 nodes@40@10)
    ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@93@10))
  :pattern ((Set_in n@93@10 nodes@40@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@85@9@85@52|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Definitional axioms for snapshot map values
; Assume upper permission bound for field is_marked
; Definitional axioms for snapshot map values
; Assume upper permission bound for field left
; Definitional axioms for snapshot map values
; Assume upper permission bound for field right
; [eval] (forall n: Ref :: { (n in nodes) } (n in nodes) ==> n.is_marked)
(declare-const n@94@10 $Ref)
(set-option :timeout 0)
(push) ; 3
; [eval] (n in nodes) ==> n.is_marked
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 24 | n@94@10 in nodes@40@10 | live]
; [else-branch: 24 | !(n@94@10 in nodes@40@10) | live]
(push) ; 5
; [then-branch: 24 | n@94@10 in nodes@40@10]
(assert (Set_in n@94@10 nodes@40@10))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Definitional axioms for snapshot map values
; Assume upper permission bound for field is_marked
; Definitional axioms for snapshot map values
; Assume upper permission bound for field left
; Definitional axioms for snapshot map values
; Assume upper permission bound for field right
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
      (=
        ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@94@10) n@94@10))
(set-option :timeout 0)
(push) ; 6
(assert (not (and (img@76@10 n@94@10) (Set_in (inv@75@10 n@94@10) nodes@40@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 24 | !(n@94@10 in nodes@40@10)]
(assert (not (Set_in n@94@10 nodes@40@10)))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
; Assume upper permission bound for field is_marked
; Definitional axioms for snapshot map values
; Assume upper permission bound for field left
; Definitional axioms for snapshot map values
; Assume upper permission bound for field right
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (Set_in n@94@10 nodes@40@10)
  (and
    (Set_in n@94@10 nodes@40@10)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@94@10) n@94@10))))
; Joined path conditions
(assert (or (not (Set_in n@94@10 nodes@40@10)) (Set_in n@94@10 nodes@40@10)))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@10 r) (Set_in (inv@75@10 r) nodes@40@10))
    (=
      ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@10)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@94@10 $Ref)) (!
  (and
    (=>
      (Set_in n@94@10 nodes@40@10)
      (and
        (Set_in n@94@10 nodes@40@10)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@94@10) n@94@10)))
    (or (not (Set_in n@94@10 nodes@40@10)) (Set_in n@94@10 nodes@40@10)))
  :pattern ((Set_in n@94@10 nodes@40@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@85@9@85@52-aux|)))
(set-option :timeout 0)
(push) ; 3
(assert (not (forall ((n@94@10 $Ref)) (!
  (=>
    (Set_in n@94@10 nodes@40@10)
    ($FVF.lookup_is_marked (as sm@77@10  $FVF<is_marked>) n@94@10))
  :pattern ((Set_in n@94@10 nodes@40@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@85@9@85@52|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(pop) ; 2
(pop) ; 1
