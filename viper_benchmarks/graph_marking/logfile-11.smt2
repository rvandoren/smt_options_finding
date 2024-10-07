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
; ---------- client_success ----------
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
(declare-const a@0@11 $Ref)
; [exec]
; var b: Ref
(declare-const b@1@11 $Ref)
; [exec]
; var nodes: Set[Ref]
(declare-const nodes@2@11 Set<$Ref>)
; [exec]
; a := new(left, right, is_marked)
(declare-const a@3@11 $Ref)
(assert (not (= a@3@11 $Ref.null)))
(declare-const left@4@11 $Ref)
(declare-const sm@5@11 $FVF<left>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_left (as sm@5@11  $FVF<left>) a@3@11) left@4@11))
(declare-const right@6@11 $Ref)
(declare-const sm@7@11 $FVF<right>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_right (as sm@7@11  $FVF<right>) a@3@11) right@6@11))
(declare-const is_marked@8@11 Bool)
(declare-const sm@9@11 $FVF<is_marked>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_is_marked (as sm@9@11  $FVF<is_marked>) a@3@11) is_marked@8@11))
(assert (not (= a@3@11 a@0@11)))
(assert (not (= a@3@11 b@1@11)))
(assert (not (Set_in a@3@11 nodes@2@11)))
; [exec]
; a.is_marked := false
(declare-const sm@10@11 $FVF<is_marked>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_is_marked (as sm@10@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@9@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@10@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@9@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef0|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@9@11  $FVF<is_marked>) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@10@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef1|)))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@10@11  $FVF<is_marked>) a@3@11) a@3@11))
; Precomputing data for removing quantified permissions
(define-fun pTaken@11@11 ((r $Ref)) $Perm
  (ite
    (= r a@3@11)
    ($Perm.min (ite (= r a@3@11) $Perm.Write $Perm.No) $Perm.Write)
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
(assert (not (= (- $Perm.Write (pTaken@11@11 a@3@11)) $Perm.No)))
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
  (=> (= r a@3@11) (= (- $Perm.Write (pTaken@11@11 r)) $Perm.No))
  
  :qid |quant-u-5|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@12@11 $FVF<is_marked>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) a@3@11) false))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) a@3@11) a@3@11))
; [exec]
; b := new(left, right, is_marked)
(declare-const b@13@11 $Ref)
(assert (not (= b@13@11 $Ref.null)))
(declare-const left@14@11 $Ref)
(declare-const sm@15@11 $FVF<left>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_left (as sm@15@11  $FVF<left>) b@13@11) left@14@11))
(declare-const right@16@11 $Ref)
(declare-const sm@17@11 $FVF<right>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_right (as sm@17@11  $FVF<right>) b@13@11) right@16@11))
(declare-const is_marked@18@11 Bool)
(declare-const sm@19@11 $FVF<is_marked>)
; Definitional axioms for singleton-FVF's value
(assert (=
  ($FVF.lookup_is_marked (as sm@19@11  $FVF<is_marked>) b@13@11)
  is_marked@18@11))
(assert (not (= b@13@11 a@3@11)))
(assert (not (= b@13@11 b@1@11)))
(assert (not (= b@13@11 ($FVF.lookup_left (as sm@5@11  $FVF<left>) a@3@11))))
(assert (not (= b@13@11 ($FVF.lookup_right (as sm@7@11  $FVF<right>) a@3@11))))
(assert (not (Set_in b@13@11 nodes@2@11)))
; [exec]
; b.is_marked := false
(declare-const sm@20@11 $FVF<is_marked>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_is_marked (as sm@20@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@19@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@20@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@19@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef2|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_is_marked (as sm@20@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@20@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@19@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@20@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef4|)))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@20@11  $FVF<is_marked>) b@13@11) b@13@11))
; Precomputing data for removing quantified permissions
(define-fun pTaken@21@11 ((r $Ref)) $Perm
  (ite
    (= r b@13@11)
    ($Perm.min (ite (= r b@13@11) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@22@11 ((r $Ref)) $Perm
  (ite
    (= r b@13@11)
    ($Perm.min
      (ite (= r a@3@11) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@21@11 r)))
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
(assert (not (= (- $Perm.Write (pTaken@21@11 b@13@11)) $Perm.No)))
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
  (=> (= r b@13@11) (= (- $Perm.Write (pTaken@21@11 r)) $Perm.No))
  
  :qid |quant-u-11|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@23@11 $FVF<is_marked>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) b@13@11) false))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) b@13@11) b@13@11))
; [exec]
; a.left := b
(declare-const sm@24@11 $FVF<left>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_left (as sm@24@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@5@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@24@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@5@11  $FVF<left>) r))
  :qid |qp.fvfValDef5|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_left (as sm@24@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@15@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@24@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@15@11  $FVF<left>) r))
  :qid |qp.fvfValDef6|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@5@11  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@15@11  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@24@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef7|)))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@24@11  $FVF<left>) a@3@11) a@3@11))
; Precomputing data for removing quantified permissions
(define-fun pTaken@25@11 ((r $Ref)) $Perm
  (ite
    (= r a@3@11)
    ($Perm.min (ite (= r a@3@11) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@26@11 ((r $Ref)) $Perm
  (ite
    (= r a@3@11)
    ($Perm.min
      (ite (= r b@13@11) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@25@11 r)))
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
(assert (not (= (- $Perm.Write (pTaken@25@11 a@3@11)) $Perm.No)))
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
  (=> (= r a@3@11) (= (- $Perm.Write (pTaken@25@11 r)) $Perm.No))
  
  :qid |quant-u-17|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@27@11 $FVF<left>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_left (as sm@27@11  $FVF<left>) a@3@11) b@13@11))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@27@11  $FVF<left>) a@3@11) a@3@11))
; [exec]
; a.right := null
(declare-const sm@28@11 $FVF<right>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_right (as sm@28@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@17@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@28@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@17@11  $FVF<right>) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_right (as sm@28@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@7@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@28@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@7@11  $FVF<right>) r))
  :qid |qp.fvfValDef9|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@17@11  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@7@11  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@28@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef10|)))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@28@11  $FVF<right>) a@3@11) a@3@11))
; Precomputing data for removing quantified permissions
(define-fun pTaken@29@11 ((r $Ref)) $Perm
  (ite
    (= r a@3@11)
    ($Perm.min (ite (= r a@3@11) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@30@11 ((r $Ref)) $Perm
  (ite
    (= r a@3@11)
    ($Perm.min
      (ite (= r b@13@11) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@29@11 r)))
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
(assert (not (= (- $Perm.Write (pTaken@29@11 a@3@11)) $Perm.No)))
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
  (=> (= r a@3@11) (= (- $Perm.Write (pTaken@29@11 r)) $Perm.No))
  
  :qid |quant-u-25|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@31@11 $FVF<right>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_right (as sm@31@11  $FVF<right>) a@3@11) $Ref.null))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@31@11  $FVF<right>) a@3@11) a@3@11))
; [exec]
; b.left := null
(declare-const sm@32@11 $FVF<left>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_left (as sm@32@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@15@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@32@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@15@11  $FVF<left>) r))
  :qid |qp.fvfValDef11|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_left (as sm@32@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@27@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@32@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@27@11  $FVF<left>) r))
  :qid |qp.fvfValDef12|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@15@11  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@27@11  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@32@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef13|)))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@32@11  $FVF<left>) b@13@11) b@13@11))
; Precomputing data for removing quantified permissions
(define-fun pTaken@33@11 ((r $Ref)) $Perm
  (ite
    (= r b@13@11)
    ($Perm.min (ite (= r b@13@11) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@34@11 ((r $Ref)) $Perm
  (ite
    (= r b@13@11)
    ($Perm.min
      (ite (= r a@3@11) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@33@11 r)))
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
(assert (not (= (- $Perm.Write (pTaken@33@11 b@13@11)) $Perm.No)))
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
  (=> (= r b@13@11) (= (- $Perm.Write (pTaken@33@11 r)) $Perm.No))
  
  :qid |quant-u-31|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@35@11 $FVF<left>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_left (as sm@35@11  $FVF<left>) b@13@11) $Ref.null))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@35@11  $FVF<left>) b@13@11) b@13@11))
; [exec]
; b.right := a
(declare-const sm@36@11 $FVF<right>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_right (as sm@36@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@17@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@36@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@17@11  $FVF<right>) r))
  :qid |qp.fvfValDef14|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_right (as sm@36@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@36@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@11  $FVF<right>) r))
  :qid |qp.fvfValDef15|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@17@11  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@11  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@36@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef16|)))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@36@11  $FVF<right>) b@13@11) b@13@11))
; Precomputing data for removing quantified permissions
(define-fun pTaken@37@11 ((r $Ref)) $Perm
  (ite
    (= r b@13@11)
    ($Perm.min (ite (= r b@13@11) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@38@11 ((r $Ref)) $Perm
  (ite
    (= r b@13@11)
    ($Perm.min
      (ite (= r a@3@11) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@37@11 r)))
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
(assert (not (= (- $Perm.Write (pTaken@37@11 b@13@11)) $Perm.No)))
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
  (=> (= r b@13@11) (= (- $Perm.Write (pTaken@37@11 r)) $Perm.No))
  
  :qid |quant-u-36|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@39@11 $FVF<right>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_right (as sm@39@11  $FVF<right>) b@13@11) a@3@11))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@39@11  $FVF<right>) b@13@11) b@13@11))
; [exec]
; nodes := Set(a, b)
; [eval] Set(a, b)
(declare-const nodes@40@11 Set<$Ref>)
(assert (= nodes@40@11 (Set_unionone (Set_singleton a@3@11) b@13@11)))
; [exec]
; assert (forall n: Ref :: { (n in nodes) } (n in nodes) ==> !n.is_marked)
; [eval] (forall n: Ref :: { (n in nodes) } (n in nodes) ==> !n.is_marked)
(declare-const n@41@11 $Ref)
(set-option :timeout 0)
(push) ; 3
; [eval] (n in nodes) ==> !n.is_marked
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 0 | n@41@11 in nodes@40@11 | live]
; [else-branch: 0 | !(n@41@11 in nodes@40@11) | live]
(push) ; 5
; [then-branch: 0 | n@41@11 in nodes@40@11]
(assert (Set_in n@41@11 nodes@40@11))
; [eval] !n.is_marked
(declare-const sm@42@11 $FVF<is_marked>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(declare-const pm@43@11 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_is_marked (as pm@43@11  $FPM) r)
    (+
      (ite (= r b@13@11) $Perm.Write $Perm.No)
      (ite (= r a@3@11) $Perm.Write $Perm.No)))
  :pattern (($FVF.perm_is_marked (as pm@43@11  $FPM) r))
  :qid |qp.resPrmSumDef20|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
  :pattern (($FVF.perm_is_marked (as pm@43@11  $FPM) r))
  :qid |qp.resTrgDef21|)))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@41@11) n@41@11))
(push) ; 6
(assert (not (< $Perm.No ($FVF.perm_is_marked (as pm@43@11  $FPM) n@41@11))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 0 | !(n@41@11 in nodes@40@11)]
(assert (not (Set_in n@41@11 nodes@40@11)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_is_marked (as pm@43@11  $FPM) r)
    (+
      (ite (= r b@13@11) $Perm.Write $Perm.No)
      (ite (= r a@3@11) $Perm.Write $Perm.No)))
  :pattern (($FVF.perm_is_marked (as pm@43@11  $FPM) r))
  :qid |qp.resPrmSumDef20|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
  :pattern (($FVF.perm_is_marked (as pm@43@11  $FPM) r))
  :qid |qp.resTrgDef21|)))
(assert (=>
  (Set_in n@41@11 nodes@40@11)
  (and
    (Set_in n@41@11 nodes@40@11)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@41@11) n@41@11))))
; Joined path conditions
(assert (or (not (Set_in n@41@11 nodes@40@11)) (Set_in n@41@11 nodes@40@11)))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_is_marked (as pm@43@11  $FPM) r)
    (+
      (ite (= r b@13@11) $Perm.Write $Perm.No)
      (ite (= r a@3@11) $Perm.Write $Perm.No)))
  :pattern (($FVF.perm_is_marked (as pm@43@11  $FPM) r))
  :qid |qp.resPrmSumDef20|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
  :pattern (($FVF.perm_is_marked (as pm@43@11  $FPM) r))
  :qid |qp.resTrgDef21|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@41@11 $Ref)) (!
  (and
    (=>
      (Set_in n@41@11 nodes@40@11)
      (and
        (Set_in n@41@11 nodes@40@11)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@41@11) n@41@11)))
    (or (not (Set_in n@41@11 nodes@40@11)) (Set_in n@41@11 nodes@40@11)))
  :pattern ((Set_in n@41@11 nodes@40@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@63@9@63@53-aux|)))
(push) ; 3
(assert (not (forall ((n@41@11 $Ref)) (!
  (=>
    (Set_in n@41@11 nodes@40@11)
    (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@41@11)))
  :pattern ((Set_in n@41@11 nodes@40@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@63@9@63@53|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (forall ((n@41@11 $Ref)) (!
  (=>
    (Set_in n@41@11 nodes@40@11)
    (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@41@11)))
  :pattern ((Set_in n@41@11 nodes@40@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@63@9@63@53|)))
; [exec]
; trav_rec(nodes, a)
; [eval] (node in nodes)
(push) ; 3
(assert (not (Set_in a@3@11 nodes@40@11)))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (Set_in a@3@11 nodes@40@11))
; [eval] !((null in nodes))
; [eval] (null in nodes)
(push) ; 3
(assert (not (not (Set_in $Ref.null nodes@40@11))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (not (Set_in $Ref.null nodes@40@11)))
(declare-const n@44@11 $Ref)
(push) ; 3
; [eval] (n in nodes)
(assert (Set_in n@44@11 nodes@40@11))
(pop) ; 3
(declare-fun inv@45@11 ($Ref) $Ref)
(declare-fun img@46@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(declare-const sm@47@11 $FVF<left>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@27@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@27@11  $FVF<left>) r))
  :qid |qp.fvfValDef22|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@35@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@35@11  $FVF<left>) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@27@11  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@35@11  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef24|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((n1@44@11 $Ref) (n2@44@11 $Ref)) (!
  (=>
    (and
      (and
        (Set_in n1@44@11 nodes@40@11)
        ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n1@44@11) n1@44@11))
      (and
        (Set_in n2@44@11 nodes@40@11)
        ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n2@44@11) n2@44@11))
      (= n1@44@11 n2@44@11))
    (= n1@44@11 n2@44@11))
  
  :qid |left-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((n@44@11 $Ref)) (!
  (=>
    (Set_in n@44@11 nodes@40@11)
    (and (= (inv@45@11 n@44@11) n@44@11) (img@46@11 n@44@11)))
  :pattern ((Set_in n@44@11 nodes@40@11))
  :pattern ((inv@45@11 n@44@11))
  :pattern ((img@46@11 n@44@11))
  :qid |left-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=> (and (img@46@11 r) (Set_in (inv@45@11 r) nodes@40@11)) (= (inv@45@11 r) r))
  :pattern ((inv@45@11 r))
  :qid |left-fctOfInv|)))
(assert (forall ((r $Ref)) (!
  (=>
    (Set_in (inv@45@11 r) nodes@40@11)
    ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) r) r))
  :pattern ((inv@45@11 r))
  :qid |quant-u-48|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@48@11 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@45@11 r) nodes@40@11) (img@46@11 r) (= r (inv@45@11 r)))
    ($Perm.min (ite (= r a@3@11) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@49@11 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@45@11 r) nodes@40@11) (img@46@11 r) (= r (inv@45@11 r)))
    ($Perm.min
      (ite (= r b@13@11) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@48@11 r)))
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
(assert (not (= (- $Perm.Write (pTaken@48@11 a@3@11)) $Perm.No)))
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
    (and (Set_in (inv@45@11 r) nodes@40@11) (img@46@11 r) (= r (inv@45@11 r)))
    (= (- $Perm.Write (pTaken@48@11 r)) $Perm.No))
  
  :qid |quant-u-55|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 500)
(assert (not (= (- $Perm.Write (pTaken@49@11 b@13@11)) $Perm.No)))
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
    (and (Set_in (inv@45@11 r) nodes@40@11) (img@46@11 r) (= r (inv@45@11 r)))
    (= (- (- $Perm.Write (pTaken@48@11 r)) (pTaken@49@11 r)) $Perm.No))
  
  :qid |quant-u-58|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
; Definitional axioms for snapshot map values
(declare-const n$0@50@11 $Ref)
(set-option :timeout 0)
(push) ; 3
; [eval] (n$0 in nodes)
(assert (Set_in n$0@50@11 nodes@40@11))
(pop) ; 3
(declare-fun inv@51@11 ($Ref) $Ref)
(declare-fun img@52@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(declare-const sm@53@11 $FVF<right>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_right (as sm@53@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@53@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@11  $FVF<right>) r))
  :qid |qp.fvfValDef25|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_right (as sm@53@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@39@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@53@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@39@11  $FVF<right>) r))
  :qid |qp.fvfValDef26|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@11  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@11  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@53@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef27|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((n$01@50@11 $Ref) (n$02@50@11 $Ref)) (!
  (=>
    (and
      (and
        (Set_in n$01@50@11 nodes@40@11)
        ($FVF.loc_right ($FVF.lookup_right (as sm@53@11  $FVF<right>) n$01@50@11) n$01@50@11))
      (and
        (Set_in n$02@50@11 nodes@40@11)
        ($FVF.loc_right ($FVF.lookup_right (as sm@53@11  $FVF<right>) n$02@50@11) n$02@50@11))
      (= n$01@50@11 n$02@50@11))
    (= n$01@50@11 n$02@50@11))
  
  :qid |right-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((n$0@50@11 $Ref)) (!
  (=>
    (Set_in n$0@50@11 nodes@40@11)
    (and (= (inv@51@11 n$0@50@11) n$0@50@11) (img@52@11 n$0@50@11)))
  :pattern ((Set_in n$0@50@11 nodes@40@11))
  :pattern ((inv@51@11 n$0@50@11))
  :pattern ((img@52@11 n$0@50@11))
  :qid |right-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=> (and (img@52@11 r) (Set_in (inv@51@11 r) nodes@40@11)) (= (inv@51@11 r) r))
  :pattern ((inv@51@11 r))
  :qid |right-fctOfInv|)))
(assert (forall ((r $Ref)) (!
  (=>
    (Set_in (inv@51@11 r) nodes@40@11)
    ($FVF.loc_right ($FVF.lookup_right (as sm@53@11  $FVF<right>) r) r))
  :pattern ((inv@51@11 r))
  :qid |quant-u-66|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@54@11 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@51@11 r) nodes@40@11) (img@52@11 r) (= r (inv@51@11 r)))
    ($Perm.min (ite (= r a@3@11) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@55@11 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@51@11 r) nodes@40@11) (img@52@11 r) (= r (inv@51@11 r)))
    ($Perm.min
      (ite (= r b@13@11) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@54@11 r)))
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
(assert (not (= (- $Perm.Write (pTaken@54@11 a@3@11)) $Perm.No)))
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
    (and (Set_in (inv@51@11 r) nodes@40@11) (img@52@11 r) (= r (inv@51@11 r)))
    (= (- $Perm.Write (pTaken@54@11 r)) $Perm.No))
  
  :qid |quant-u-71|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 500)
(assert (not (= (- $Perm.Write (pTaken@55@11 b@13@11)) $Perm.No)))
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
    (and (Set_in (inv@51@11 r) nodes@40@11) (img@52@11 r) (= r (inv@51@11 r)))
    (= (- (- $Perm.Write (pTaken@54@11 r)) (pTaken@55@11 r)) $Perm.No))
  
  :qid |quant-u-78|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
; Definitional axioms for snapshot map values
(declare-const n$1@56@11 $Ref)
(set-option :timeout 0)
(push) ; 3
; [eval] (n$1 in nodes)
(assert (Set_in n$1@56@11 nodes@40@11))
(pop) ; 3
(declare-fun inv@57@11 ($Ref) $Ref)
(declare-fun img@58@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Definitional axioms for snapshot map values
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((n$11@56@11 $Ref) (n$12@56@11 $Ref)) (!
  (=>
    (and
      (and
        (Set_in n$11@56@11 nodes@40@11)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n$11@56@11) n$11@56@11))
      (and
        (Set_in n$12@56@11 nodes@40@11)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n$12@56@11) n$12@56@11))
      (= n$11@56@11 n$12@56@11))
    (= n$11@56@11 n$12@56@11))
  
  :qid |is_marked-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((n$1@56@11 $Ref)) (!
  (=>
    (Set_in n$1@56@11 nodes@40@11)
    (and (= (inv@57@11 n$1@56@11) n$1@56@11) (img@58@11 n$1@56@11)))
  :pattern ((Set_in n$1@56@11 nodes@40@11))
  :pattern ((inv@57@11 n$1@56@11))
  :pattern ((img@58@11 n$1@56@11))
  :qid |is_marked-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=> (and (img@58@11 r) (Set_in (inv@57@11 r) nodes@40@11)) (= (inv@57@11 r) r))
  :pattern ((inv@57@11 r))
  :qid |is_marked-fctOfInv|)))
(assert (forall ((r $Ref)) (!
  (=>
    (Set_in (inv@57@11 r) nodes@40@11)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r) r))
  :pattern ((inv@57@11 r))
  :qid |quant-u-83|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@59@11 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@57@11 r) nodes@40@11) (img@58@11 r) (= r (inv@57@11 r)))
    ($Perm.min (ite (= r b@13@11) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@60@11 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@57@11 r) nodes@40@11) (img@58@11 r) (= r (inv@57@11 r)))
    ($Perm.min
      (ite (= r a@3@11) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@59@11 r)))
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
(assert (not (= (- $Perm.Write (pTaken@59@11 b@13@11)) $Perm.No)))
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
    (and (Set_in (inv@57@11 r) nodes@40@11) (img@58@11 r) (= r (inv@57@11 r)))
    (= (- $Perm.Write (pTaken@59@11 r)) $Perm.No))
  
  :qid |quant-u-88|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 500)
(assert (not (= (- $Perm.Write (pTaken@60@11 a@3@11)) $Perm.No)))
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
    (and (Set_in (inv@57@11 r) nodes@40@11) (img@58@11 r) (= r (inv@57@11 r)))
    (= (- (- $Perm.Write (pTaken@59@11 r)) (pTaken@60@11 r)) $Perm.No))
  
  :qid |quant-u-93|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
; Definitional axioms for snapshot map values
; [eval] (forall n$2: Ref :: { (n$2.left in nodes) } { (n$2 in nodes), n$2.left } (n$2 in nodes) && n$2.left != null ==> (n$2.left in nodes))
(declare-const n$2@61@11 $Ref)
(set-option :timeout 0)
(push) ; 3
; [eval] (n$2 in nodes) && n$2.left != null ==> (n$2.left in nodes)
; [eval] (n$2 in nodes) && n$2.left != null
; [eval] (n$2 in nodes)
(push) ; 4
; [then-branch: 1 | !(n$2@61@11 in nodes@40@11) | live]
; [else-branch: 1 | n$2@61@11 in nodes@40@11 | live]
(push) ; 5
; [then-branch: 1 | !(n$2@61@11 in nodes@40@11)]
(assert (not (Set_in n$2@61@11 nodes@40@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 1 | n$2@61@11 in nodes@40@11]
(assert (Set_in n$2@61@11 nodes@40@11))
; [eval] n$2.left != null
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@11)
      (=
        ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
        ($FVF.lookup_left (as sm@27@11  $FVF<left>) r)))
    :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
    :pattern (($FVF.lookup_left (as sm@27@11  $FVF<left>) r))
    :qid |qp.fvfValDef22|))
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@11)
      (=
        ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
        ($FVF.lookup_left (as sm@35@11  $FVF<left>) r)))
    :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
    :pattern (($FVF.lookup_left (as sm@35@11  $FVF<left>) r))
    :qid |qp.fvfValDef23|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_left ($FVF.lookup_left (as sm@27@11  $FVF<left>) r) r)
      ($FVF.loc_left ($FVF.lookup_left (as sm@35@11  $FVF<left>) r) r))
    :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
    :qid |qp.fvfResTrgDef24|))))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) n$2@61@11))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n$2@61@11 a@3@11) $Perm.Write $Perm.No)
    (ite (= n$2@61@11 b@13@11) $Perm.Write $Perm.No)))))
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
    (= r a@3@11)
    (=
      ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@27@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@27@11  $FVF<left>) r))
  :qid |qp.fvfValDef22|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@35@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@35@11  $FVF<left>) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@27@11  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@35@11  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef24|)))
(assert (=>
  (Set_in n$2@61@11 nodes@40@11)
  (and
    (Set_in n$2@61@11 nodes@40@11)
    ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) n$2@61@11))))
(assert (or (Set_in n$2@61@11 nodes@40@11) (not (Set_in n$2@61@11 nodes@40@11))))
(push) ; 4
; [then-branch: 2 | n$2@61@11 in nodes@40@11 && Lookup(left, sm@47@11, n$2@61@11) != Null | live]
; [else-branch: 2 | !(n$2@61@11 in nodes@40@11 && Lookup(left, sm@47@11, n$2@61@11) != Null) | live]
(push) ; 5
; [then-branch: 2 | n$2@61@11 in nodes@40@11 && Lookup(left, sm@47@11, n$2@61@11) != Null]
(assert (and
  (Set_in n$2@61@11 nodes@40@11)
  (not (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null))))
; [eval] (n$2.left in nodes)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@11)
      (=
        ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
        ($FVF.lookup_left (as sm@27@11  $FVF<left>) r)))
    :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
    :pattern (($FVF.lookup_left (as sm@27@11  $FVF<left>) r))
    :qid |qp.fvfValDef22|))
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@11)
      (=
        ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
        ($FVF.lookup_left (as sm@35@11  $FVF<left>) r)))
    :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
    :pattern (($FVF.lookup_left (as sm@35@11  $FVF<left>) r))
    :qid |qp.fvfValDef23|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_left ($FVF.lookup_left (as sm@27@11  $FVF<left>) r) r)
      ($FVF.loc_left ($FVF.lookup_left (as sm@35@11  $FVF<left>) r) r))
    :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
    :qid |qp.fvfResTrgDef24|))))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) n$2@61@11))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n$2@61@11 a@3@11) $Perm.Write $Perm.No)
    (ite (= n$2@61@11 b@13@11) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 2 | !(n$2@61@11 in nodes@40@11 && Lookup(left, sm@47@11, n$2@61@11) != Null)]
(assert (not
  (and
    (Set_in n$2@61@11 nodes@40@11)
    (not (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@27@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@27@11  $FVF<left>) r))
  :qid |qp.fvfValDef22|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@35@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@35@11  $FVF<left>) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@27@11  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@35@11  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef24|)))
(assert (=>
  (and
    (Set_in n$2@61@11 nodes@40@11)
    (not (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null)))
  (and
    (Set_in n$2@61@11 nodes@40@11)
    (not (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null))
    ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) n$2@61@11))))
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in n$2@61@11 nodes@40@11)
      (not (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null))))
  (and
    (Set_in n$2@61@11 nodes@40@11)
    (not (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null)))))
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@27@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@27@11  $FVF<left>) r))
  :qid |qp.fvfValDef22|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@35@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@35@11  $FVF<left>) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@27@11  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@35@11  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef24|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n$2@61@11 $Ref)) (!
  (and
    (=>
      (Set_in n$2@61@11 nodes@40@11)
      (and
        (Set_in n$2@61@11 nodes@40@11)
        ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) n$2@61@11)))
    (or (Set_in n$2@61@11 nodes@40@11) (not (Set_in n$2@61@11 nodes@40@11)))
    (=>
      (and
        (Set_in n$2@61@11 nodes@40@11)
        (not
          (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null)))
      (and
        (Set_in n$2@61@11 nodes@40@11)
        (not
          (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null))
        ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) n$2@61@11)))
    (or
      (not
        (and
          (Set_in n$2@61@11 nodes@40@11)
          (not
            (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null))))
      (and
        (Set_in n$2@61@11 nodes@40@11)
        (not
          (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null)))))
  :pattern ((Set_in ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) nodes@40@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38-aux|)))
(assert (forall ((n$2@61@11 $Ref)) (!
  (and
    (=>
      (Set_in n$2@61@11 nodes@40@11)
      (and
        (Set_in n$2@61@11 nodes@40@11)
        ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) n$2@61@11)))
    (or (Set_in n$2@61@11 nodes@40@11) (not (Set_in n$2@61@11 nodes@40@11)))
    (=>
      (and
        (Set_in n$2@61@11 nodes@40@11)
        (not
          (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null)))
      (and
        (Set_in n$2@61@11 nodes@40@11)
        (not
          (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null))
        ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) n$2@61@11)))
    (or
      (not
        (and
          (Set_in n$2@61@11 nodes@40@11)
          (not
            (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null))))
      (and
        (Set_in n$2@61@11 nodes@40@11)
        (not
          (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null)))))
  :pattern ((Set_in n$2@61@11 nodes@40@11) ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) n$2@61@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38-aux|)))
(push) ; 3
(assert (not (forall ((n$2@61@11 $Ref)) (!
  (=>
    (and
      (Set_in n$2@61@11 nodes@40@11)
      (not (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null)))
    (Set_in ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) nodes@40@11))
  :pattern ((Set_in ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) nodes@40@11))
  :pattern ((Set_in n$2@61@11 nodes@40@11) ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) n$2@61@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (forall ((n$2@61@11 $Ref)) (!
  (=>
    (and
      (Set_in n$2@61@11 nodes@40@11)
      (not (= ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) $Ref.null)))
    (Set_in ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) nodes@40@11))
  :pattern ((Set_in ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) nodes@40@11))
  :pattern ((Set_in n$2@61@11 nodes@40@11) ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n$2@61@11) n$2@61@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38|)))
; [eval] (forall n$3: Ref :: { (n$3.right in nodes) } { (n$3 in nodes), n$3.right } (n$3 in nodes) && n$3.right != null ==> (n$3.right in nodes))
(declare-const n$3@62@11 $Ref)
(push) ; 3
; [eval] (n$3 in nodes) && n$3.right != null ==> (n$3.right in nodes)
; [eval] (n$3 in nodes) && n$3.right != null
; [eval] (n$3 in nodes)
(push) ; 4
; [then-branch: 3 | !(n$3@62@11 in nodes@40@11) | live]
; [else-branch: 3 | n$3@62@11 in nodes@40@11 | live]
(push) ; 5
; [then-branch: 3 | !(n$3@62@11 in nodes@40@11)]
(assert (not (Set_in n$3@62@11 nodes@40@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 3 | n$3@62@11 in nodes@40@11]
(assert (Set_in n$3@62@11 nodes@40@11))
; [eval] n$3.right != null
(declare-const sm@63@11 $FVF<right>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@39@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@39@11  $FVF<right>) r))
  :qid |qp.fvfValDef28|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@11  $FVF<right>) r))
  :qid |qp.fvfValDef29|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@11  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@11  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef30|)))
(declare-const pm@64@11 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_right (as pm@64@11  $FPM) r)
    (+
      (ite (= r b@13@11) $Perm.Write $Perm.No)
      (ite (= r a@3@11) $Perm.Write $Perm.No)))
  :pattern (($FVF.perm_right (as pm@64@11  $FPM) r))
  :qid |qp.resPrmSumDef31|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@11  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@11  $FVF<right>) r) r))
  :pattern (($FVF.perm_right (as pm@64@11  $FPM) r))
  :qid |qp.resTrgDef32|)))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) n$3@62@11))
(push) ; 6
(assert (not (< $Perm.No ($FVF.perm_right (as pm@64@11  $FPM) n$3@62@11))))
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
    (= r b@13@11)
    (=
      ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@39@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@39@11  $FVF<right>) r))
  :qid |qp.fvfValDef28|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@11  $FVF<right>) r))
  :qid |qp.fvfValDef29|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@11  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@11  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef30|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_right (as pm@64@11  $FPM) r)
    (+
      (ite (= r b@13@11) $Perm.Write $Perm.No)
      (ite (= r a@3@11) $Perm.Write $Perm.No)))
  :pattern (($FVF.perm_right (as pm@64@11  $FPM) r))
  :qid |qp.resPrmSumDef31|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@11  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@11  $FVF<right>) r) r))
  :pattern (($FVF.perm_right (as pm@64@11  $FPM) r))
  :qid |qp.resTrgDef32|)))
(assert (=>
  (Set_in n$3@62@11 nodes@40@11)
  (and
    (Set_in n$3@62@11 nodes@40@11)
    ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) n$3@62@11))))
(assert (or (Set_in n$3@62@11 nodes@40@11) (not (Set_in n$3@62@11 nodes@40@11))))
(push) ; 4
; [then-branch: 4 | n$3@62@11 in nodes@40@11 && Lookup(right, sm@63@11, n$3@62@11) != Null | live]
; [else-branch: 4 | !(n$3@62@11 in nodes@40@11 && Lookup(right, sm@63@11, n$3@62@11) != Null) | live]
(push) ; 5
; [then-branch: 4 | n$3@62@11 in nodes@40@11 && Lookup(right, sm@63@11, n$3@62@11) != Null]
(assert (and
  (Set_in n$3@62@11 nodes@40@11)
  (not (= ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) $Ref.null))))
; [eval] (n$3.right in nodes)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@11)
      (=
        ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
        ($FVF.lookup_right (as sm@39@11  $FVF<right>) r)))
    :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
    :pattern (($FVF.lookup_right (as sm@39@11  $FVF<right>) r))
    :qid |qp.fvfValDef28|))
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@11)
      (=
        ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
        ($FVF.lookup_right (as sm@31@11  $FVF<right>) r)))
    :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
    :pattern (($FVF.lookup_right (as sm@31@11  $FVF<right>) r))
    :qid |qp.fvfValDef29|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_right ($FVF.lookup_right (as sm@39@11  $FVF<right>) r) r)
      ($FVF.loc_right ($FVF.lookup_right (as sm@31@11  $FVF<right>) r) r))
    :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
    :qid |qp.fvfResTrgDef30|))))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) n$3@62@11))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n$3@62@11 b@13@11) $Perm.Write $Perm.No)
    (ite (= n$3@62@11 a@3@11) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 4 | !(n$3@62@11 in nodes@40@11 && Lookup(right, sm@63@11, n$3@62@11) != Null)]
(assert (not
  (and
    (Set_in n$3@62@11 nodes@40@11)
    (not (= ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) $Ref.null)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@39@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@39@11  $FVF<right>) r))
  :qid |qp.fvfValDef28|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@11  $FVF<right>) r))
  :qid |qp.fvfValDef29|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@11  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@11  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef30|)))
(assert (=>
  (and
    (Set_in n$3@62@11 nodes@40@11)
    (not (= ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) $Ref.null)))
  (and
    (Set_in n$3@62@11 nodes@40@11)
    (not (= ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) $Ref.null))
    ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) n$3@62@11))))
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in n$3@62@11 nodes@40@11)
      (not
        (= ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) $Ref.null))))
  (and
    (Set_in n$3@62@11 nodes@40@11)
    (not (= ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) $Ref.null)))))
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@39@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@39@11  $FVF<right>) r))
  :qid |qp.fvfValDef28|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@11  $FVF<right>) r))
  :qid |qp.fvfValDef29|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@11  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@11  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef30|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_right (as pm@64@11  $FPM) r)
    (+
      (ite (= r b@13@11) $Perm.Write $Perm.No)
      (ite (= r a@3@11) $Perm.Write $Perm.No)))
  :pattern (($FVF.perm_right (as pm@64@11  $FPM) r))
  :qid |qp.resPrmSumDef31|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@11  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@11  $FVF<right>) r) r))
  :pattern (($FVF.perm_right (as pm@64@11  $FPM) r))
  :qid |qp.resTrgDef32|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n$3@62@11 $Ref)) (!
  (and
    (=>
      (Set_in n$3@62@11 nodes@40@11)
      (and
        (Set_in n$3@62@11 nodes@40@11)
        ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) n$3@62@11)))
    (or (Set_in n$3@62@11 nodes@40@11) (not (Set_in n$3@62@11 nodes@40@11)))
    (=>
      (and
        (Set_in n$3@62@11 nodes@40@11)
        (not
          (= ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) $Ref.null)))
      (and
        (Set_in n$3@62@11 nodes@40@11)
        (not
          (= ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) $Ref.null))
        ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) n$3@62@11)))
    (or
      (not
        (and
          (Set_in n$3@62@11 nodes@40@11)
          (not
            (=
              ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11)
              $Ref.null))))
      (and
        (Set_in n$3@62@11 nodes@40@11)
        (not
          (= ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) $Ref.null)))))
  :pattern ((Set_in ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) nodes@40@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38-aux|)))
(assert (forall ((n$3@62@11 $Ref)) (!
  (and
    (=>
      (Set_in n$3@62@11 nodes@40@11)
      (and
        (Set_in n$3@62@11 nodes@40@11)
        ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) n$3@62@11)))
    (or (Set_in n$3@62@11 nodes@40@11) (not (Set_in n$3@62@11 nodes@40@11)))
    (=>
      (and
        (Set_in n$3@62@11 nodes@40@11)
        (not
          (= ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) $Ref.null)))
      (and
        (Set_in n$3@62@11 nodes@40@11)
        (not
          (= ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) $Ref.null))
        ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) n$3@62@11)))
    (or
      (not
        (and
          (Set_in n$3@62@11 nodes@40@11)
          (not
            (=
              ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11)
              $Ref.null))))
      (and
        (Set_in n$3@62@11 nodes@40@11)
        (not
          (= ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) $Ref.null)))))
  :pattern ((Set_in n$3@62@11 nodes@40@11) ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) n$3@62@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38-aux|)))
(push) ; 3
(assert (not (forall ((n$3@62@11 $Ref)) (!
  (=>
    (and
      (Set_in n$3@62@11 nodes@40@11)
      (not
        (= ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) $Ref.null)))
    (Set_in ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) nodes@40@11))
  :pattern ((Set_in ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) nodes@40@11))
  :pattern ((Set_in n$3@62@11 nodes@40@11) ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) n$3@62@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (forall ((n$3@62@11 $Ref)) (!
  (=>
    (and
      (Set_in n$3@62@11 nodes@40@11)
      (not
        (= ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) $Ref.null)))
    (Set_in ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) nodes@40@11))
  :pattern ((Set_in ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) nodes@40@11))
  :pattern ((Set_in n$3@62@11 nodes@40@11) ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) n$3@62@11) n$3@62@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@23@28@23@38|)))
; [eval] !node.is_marked
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@11)
      (=
        ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r))
    :qid |qp.fvfValDef17|))
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@11)
      (=
        ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r))
    :qid |qp.fvfValDef18|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
    :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef19|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) a@3@11) a@3@11))
(push) ; 3
(assert (not (< $Perm.No (+ (ite (= a@3@11 b@13@11) $Perm.Write $Perm.No) $Perm.Write))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(push) ; 3
(assert (not (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) a@3@11))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) a@3@11)))
(declare-const $t@65@11 $Snap)
(assert (= $t@65@11 ($Snap.combine ($Snap.first $t@65@11) ($Snap.second $t@65@11))))
(assert (= ($Snap.first $t@65@11) $Snap.unit))
; [eval] (node in nodes)
(assert (=
  ($Snap.second $t@65@11)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@65@11))
    ($Snap.second ($Snap.second $t@65@11)))))
(assert (= ($Snap.first ($Snap.second $t@65@11)) $Snap.unit))
; [eval] !((null in nodes))
; [eval] (null in nodes)
(assert (=
  ($Snap.second ($Snap.second $t@65@11))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@65@11)))
    ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))
(declare-const n$4@66@11 $Ref)
(push) ; 3
; [eval] (n$4 in nodes)
(assert (Set_in n$4@66@11 nodes@40@11))
(pop) ; 3
(declare-fun inv@67@11 ($Ref) $Ref)
(declare-fun img@68@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((n$41@66@11 $Ref) (n$42@66@11 $Ref)) (!
  (=>
    (and
      (Set_in n$41@66@11 nodes@40@11)
      (Set_in n$42@66@11 nodes@40@11)
      (= n$41@66@11 n$42@66@11))
    (= n$41@66@11 n$42@66@11))
  
  :qid |left-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((n$4@66@11 $Ref)) (!
  (=>
    (Set_in n$4@66@11 nodes@40@11)
    (and (= (inv@67@11 n$4@66@11) n$4@66@11) (img@68@11 n$4@66@11)))
  :pattern ((Set_in n$4@66@11 nodes@40@11))
  :pattern ((inv@67@11 n$4@66@11))
  :pattern ((img@68@11 n$4@66@11))
  :qid |quant-u-98|)))
(assert (forall ((r $Ref)) (!
  (=> (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11)) (= (inv@67@11 r) r))
  :pattern ((inv@67@11 r))
  :qid |left-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((n$4@66@11 $Ref)) (!
  (=> (Set_in n$4@66@11 nodes@40@11) (not (= n$4@66@11 $Ref.null)))
  :pattern ((Set_in n$4@66@11 nodes@40@11))
  :pattern ((inv@67@11 n$4@66@11))
  :pattern ((img@68@11 n$4@66@11))
  :qid |left-permImpliesNonNull|)))
(declare-const sm@69@11 $FVF<left>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11))
    (=
      ($FVF.lookup_left (as sm@69@11  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (forall ((r $Ref)) (!
  (=>
    (Set_in (inv@67@11 r) nodes@40@11)
    ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) r) r))
  :pattern ((inv@67@11 r))
  :qid |quant-u-100|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@65@11)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))))
(declare-const n$5@70@11 $Ref)
(push) ; 3
; [eval] (n$5 in nodes)
(assert (Set_in n$5@70@11 nodes@40@11))
(pop) ; 3
(declare-fun inv@71@11 ($Ref) $Ref)
(declare-fun img@72@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((n$51@70@11 $Ref) (n$52@70@11 $Ref)) (!
  (=>
    (and
      (Set_in n$51@70@11 nodes@40@11)
      (Set_in n$52@70@11 nodes@40@11)
      (= n$51@70@11 n$52@70@11))
    (= n$51@70@11 n$52@70@11))
  
  :qid |right-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((n$5@70@11 $Ref)) (!
  (=>
    (Set_in n$5@70@11 nodes@40@11)
    (and (= (inv@71@11 n$5@70@11) n$5@70@11) (img@72@11 n$5@70@11)))
  :pattern ((Set_in n$5@70@11 nodes@40@11))
  :pattern ((inv@71@11 n$5@70@11))
  :pattern ((img@72@11 n$5@70@11))
  :qid |quant-u-104|)))
(assert (forall ((r $Ref)) (!
  (=> (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11)) (= (inv@71@11 r) r))
  :pattern ((inv@71@11 r))
  :qid |right-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((n$5@70@11 $Ref)) (!
  (=> (Set_in n$5@70@11 nodes@40@11) (not (= n$5@70@11 $Ref.null)))
  :pattern ((Set_in n$5@70@11 nodes@40@11))
  :pattern ((inv@71@11 n$5@70@11))
  :pattern ((img@72@11 n$5@70@11))
  :qid |right-permImpliesNonNull|)))
(declare-const sm@73@11 $FVF<right>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11))
    (=
      ($FVF.lookup_right (as sm@73@11  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (forall ((r $Ref)) (!
  (=>
    (Set_in (inv@71@11 r) nodes@40@11)
    ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) r) r))
  :pattern ((inv@71@11 r))
  :qid |quant-u-106|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))))
(declare-const n$6@74@11 $Ref)
(push) ; 3
; [eval] (n$6 in nodes)
(assert (Set_in n$6@74@11 nodes@40@11))
(pop) ; 3
(declare-fun inv@75@11 ($Ref) $Ref)
(declare-fun img@76@11 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((n$61@74@11 $Ref) (n$62@74@11 $Ref)) (!
  (=>
    (and
      (Set_in n$61@74@11 nodes@40@11)
      (Set_in n$62@74@11 nodes@40@11)
      (= n$61@74@11 n$62@74@11))
    (= n$61@74@11 n$62@74@11))
  
  :qid |is_marked-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((n$6@74@11 $Ref)) (!
  (=>
    (Set_in n$6@74@11 nodes@40@11)
    (and (= (inv@75@11 n$6@74@11) n$6@74@11) (img@76@11 n$6@74@11)))
  :pattern ((Set_in n$6@74@11 nodes@40@11))
  :pattern ((inv@75@11 n$6@74@11))
  :pattern ((img@76@11 n$6@74@11))
  :qid |quant-u-109|)))
(assert (forall ((r $Ref)) (!
  (=> (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11)) (= (inv@75@11 r) r))
  :pattern ((inv@75@11 r))
  :qid |is_marked-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((n$6@74@11 $Ref)) (!
  (=> (Set_in n$6@74@11 nodes@40@11) (not (= n$6@74@11 $Ref.null)))
  :pattern ((Set_in n$6@74@11 nodes@40@11))
  :pattern ((inv@75@11 n$6@74@11))
  :pattern ((img@76@11 n$6@74@11))
  :qid |is_marked-permImpliesNonNull|)))
(declare-const sm@77@11 $FVF<is_marked>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (forall ((r $Ref)) (!
  (=>
    (Set_in (inv@75@11 r) nodes@40@11)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r) r))
  :pattern ((inv@75@11 r))
  :qid |quant-u-112|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))
  $Snap.unit))
; [eval] (forall n$7: Ref :: { (n$7.left in nodes) } { (n$7 in nodes), n$7.left } (n$7 in nodes) && n$7.left != null ==> (n$7.left in nodes))
(declare-const n$7@78@11 $Ref)
(push) ; 3
; [eval] (n$7 in nodes) && n$7.left != null ==> (n$7.left in nodes)
; [eval] (n$7 in nodes) && n$7.left != null
; [eval] (n$7 in nodes)
(push) ; 4
; [then-branch: 5 | !(n$7@78@11 in nodes@40@11) | live]
; [else-branch: 5 | n$7@78@11 in nodes@40@11 | live]
(push) ; 5
; [then-branch: 5 | !(n$7@78@11 in nodes@40@11)]
(assert (not (Set_in n$7@78@11 nodes@40@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 5 | n$7@78@11 in nodes@40@11]
(assert (Set_in n$7@78@11 nodes@40@11))
; [eval] n$7.left != null
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11))
      (=
        ($FVF.lookup_left (as sm@69@11  $FVF<left>) r)
        ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r)))
    :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
    :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r))
    :qid |qp.fvfValDef33|))
  (forall ((r $Ref)) (!
    ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r) r)
    :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
    :qid |qp.fvfResTrgDef34|))))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) n$7@78@11))
(push) ; 6
(assert (not (and (img@68@11 n$7@78@11) (Set_in (inv@67@11 n$7@78@11) nodes@40@11))))
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
    (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11))
    (=
      ($FVF.lookup_left (as sm@69@11  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (=>
  (Set_in n$7@78@11 nodes@40@11)
  (and
    (Set_in n$7@78@11 nodes@40@11)
    ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) n$7@78@11))))
(assert (or (Set_in n$7@78@11 nodes@40@11) (not (Set_in n$7@78@11 nodes@40@11))))
(push) ; 4
; [then-branch: 6 | n$7@78@11 in nodes@40@11 && Lookup(left, sm@69@11, n$7@78@11) != Null | live]
; [else-branch: 6 | !(n$7@78@11 in nodes@40@11 && Lookup(left, sm@69@11, n$7@78@11) != Null) | live]
(push) ; 5
; [then-branch: 6 | n$7@78@11 in nodes@40@11 && Lookup(left, sm@69@11, n$7@78@11) != Null]
(assert (and
  (Set_in n$7@78@11 nodes@40@11)
  (not (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) $Ref.null))))
; [eval] (n$7.left in nodes)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11))
      (=
        ($FVF.lookup_left (as sm@69@11  $FVF<left>) r)
        ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r)))
    :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
    :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r))
    :qid |qp.fvfValDef33|))
  (forall ((r $Ref)) (!
    ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r) r)
    :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
    :qid |qp.fvfResTrgDef34|))))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) n$7@78@11))
(push) ; 6
(assert (not (and (img@68@11 n$7@78@11) (Set_in (inv@67@11 n$7@78@11) nodes@40@11))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 6 | !(n$7@78@11 in nodes@40@11 && Lookup(left, sm@69@11, n$7@78@11) != Null)]
(assert (not
  (and
    (Set_in n$7@78@11 nodes@40@11)
    (not (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) $Ref.null)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11))
    (=
      ($FVF.lookup_left (as sm@69@11  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (=>
  (and
    (Set_in n$7@78@11 nodes@40@11)
    (not (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) $Ref.null)))
  (and
    (Set_in n$7@78@11 nodes@40@11)
    (not (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) $Ref.null))
    ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) n$7@78@11))))
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in n$7@78@11 nodes@40@11)
      (not (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) $Ref.null))))
  (and
    (Set_in n$7@78@11 nodes@40@11)
    (not (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) $Ref.null)))))
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11))
    (=
      ($FVF.lookup_left (as sm@69@11  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n$7@78@11 $Ref)) (!
  (and
    (=>
      (Set_in n$7@78@11 nodes@40@11)
      (and
        (Set_in n$7@78@11 nodes@40@11)
        ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) n$7@78@11)))
    (or (Set_in n$7@78@11 nodes@40@11) (not (Set_in n$7@78@11 nodes@40@11)))
    (=>
      (and
        (Set_in n$7@78@11 nodes@40@11)
        (not
          (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) $Ref.null)))
      (and
        (Set_in n$7@78@11 nodes@40@11)
        (not
          (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) $Ref.null))
        ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) n$7@78@11)))
    (or
      (not
        (and
          (Set_in n$7@78@11 nodes@40@11)
          (not
            (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) $Ref.null))))
      (and
        (Set_in n$7@78@11 nodes@40@11)
        (not
          (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) $Ref.null)))))
  :pattern ((Set_in ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) nodes@40@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@26@27@26@37-aux|)))
(assert (forall ((n$7@78@11 $Ref)) (!
  (and
    (=>
      (Set_in n$7@78@11 nodes@40@11)
      (and
        (Set_in n$7@78@11 nodes@40@11)
        ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) n$7@78@11)))
    (or (Set_in n$7@78@11 nodes@40@11) (not (Set_in n$7@78@11 nodes@40@11)))
    (=>
      (and
        (Set_in n$7@78@11 nodes@40@11)
        (not
          (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) $Ref.null)))
      (and
        (Set_in n$7@78@11 nodes@40@11)
        (not
          (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) $Ref.null))
        ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) n$7@78@11)))
    (or
      (not
        (and
          (Set_in n$7@78@11 nodes@40@11)
          (not
            (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) $Ref.null))))
      (and
        (Set_in n$7@78@11 nodes@40@11)
        (not
          (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) $Ref.null)))))
  :pattern ((Set_in n$7@78@11 nodes@40@11) ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) n$7@78@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@26@27@26@37-aux|)))
(assert (forall ((n$7@78@11 $Ref)) (!
  (=>
    (and
      (Set_in n$7@78@11 nodes@40@11)
      (not (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) $Ref.null)))
    (Set_in ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) nodes@40@11))
  :pattern ((Set_in ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) nodes@40@11))
  :pattern ((Set_in n$7@78@11 nodes@40@11) ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n$7@78@11) n$7@78@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@26@27@26@37|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))))
  $Snap.unit))
; [eval] (forall n$8: Ref :: { (n$8.right in nodes) } { (n$8 in nodes), n$8.right } (n$8 in nodes) && n$8.right != null ==> (n$8.right in nodes))
(declare-const n$8@79@11 $Ref)
(push) ; 3
; [eval] (n$8 in nodes) && n$8.right != null ==> (n$8.right in nodes)
; [eval] (n$8 in nodes) && n$8.right != null
; [eval] (n$8 in nodes)
(push) ; 4
; [then-branch: 7 | !(n$8@79@11 in nodes@40@11) | live]
; [else-branch: 7 | n$8@79@11 in nodes@40@11 | live]
(push) ; 5
; [then-branch: 7 | !(n$8@79@11 in nodes@40@11)]
(assert (not (Set_in n$8@79@11 nodes@40@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 7 | n$8@79@11 in nodes@40@11]
(assert (Set_in n$8@79@11 nodes@40@11))
; [eval] n$8.right != null
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11))
      (=
        ($FVF.lookup_right (as sm@73@11  $FVF<right>) r)
        ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r)))
    :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
    :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r))
    :qid |qp.fvfValDef35|))
  (forall ((r $Ref)) (!
    ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r) r)
    :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
    :qid |qp.fvfResTrgDef36|))))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) n$8@79@11))
(push) ; 6
(assert (not (and (img@72@11 n$8@79@11) (Set_in (inv@71@11 n$8@79@11) nodes@40@11))))
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
    (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11))
    (=
      ($FVF.lookup_right (as sm@73@11  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (=>
  (Set_in n$8@79@11 nodes@40@11)
  (and
    (Set_in n$8@79@11 nodes@40@11)
    ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) n$8@79@11))))
(assert (or (Set_in n$8@79@11 nodes@40@11) (not (Set_in n$8@79@11 nodes@40@11))))
(push) ; 4
; [then-branch: 8 | n$8@79@11 in nodes@40@11 && Lookup(right, sm@73@11, n$8@79@11) != Null | live]
; [else-branch: 8 | !(n$8@79@11 in nodes@40@11 && Lookup(right, sm@73@11, n$8@79@11) != Null) | live]
(push) ; 5
; [then-branch: 8 | n$8@79@11 in nodes@40@11 && Lookup(right, sm@73@11, n$8@79@11) != Null]
(assert (and
  (Set_in n$8@79@11 nodes@40@11)
  (not (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) $Ref.null))))
; [eval] (n$8.right in nodes)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11))
      (=
        ($FVF.lookup_right (as sm@73@11  $FVF<right>) r)
        ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r)))
    :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
    :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r))
    :qid |qp.fvfValDef35|))
  (forall ((r $Ref)) (!
    ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r) r)
    :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
    :qid |qp.fvfResTrgDef36|))))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) n$8@79@11))
(push) ; 6
(assert (not (and (img@72@11 n$8@79@11) (Set_in (inv@71@11 n$8@79@11) nodes@40@11))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 8 | !(n$8@79@11 in nodes@40@11 && Lookup(right, sm@73@11, n$8@79@11) != Null)]
(assert (not
  (and
    (Set_in n$8@79@11 nodes@40@11)
    (not (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) $Ref.null)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11))
    (=
      ($FVF.lookup_right (as sm@73@11  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (=>
  (and
    (Set_in n$8@79@11 nodes@40@11)
    (not (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) $Ref.null)))
  (and
    (Set_in n$8@79@11 nodes@40@11)
    (not (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) $Ref.null))
    ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) n$8@79@11))))
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in n$8@79@11 nodes@40@11)
      (not
        (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) $Ref.null))))
  (and
    (Set_in n$8@79@11 nodes@40@11)
    (not (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) $Ref.null)))))
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11))
    (=
      ($FVF.lookup_right (as sm@73@11  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n$8@79@11 $Ref)) (!
  (and
    (=>
      (Set_in n$8@79@11 nodes@40@11)
      (and
        (Set_in n$8@79@11 nodes@40@11)
        ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) n$8@79@11)))
    (or (Set_in n$8@79@11 nodes@40@11) (not (Set_in n$8@79@11 nodes@40@11)))
    (=>
      (and
        (Set_in n$8@79@11 nodes@40@11)
        (not
          (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) $Ref.null)))
      (and
        (Set_in n$8@79@11 nodes@40@11)
        (not
          (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) $Ref.null))
        ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) n$8@79@11)))
    (or
      (not
        (and
          (Set_in n$8@79@11 nodes@40@11)
          (not
            (=
              ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11)
              $Ref.null))))
      (and
        (Set_in n$8@79@11 nodes@40@11)
        (not
          (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) $Ref.null)))))
  :pattern ((Set_in ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) nodes@40@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@26@27@26@37-aux|)))
(assert (forall ((n$8@79@11 $Ref)) (!
  (and
    (=>
      (Set_in n$8@79@11 nodes@40@11)
      (and
        (Set_in n$8@79@11 nodes@40@11)
        ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) n$8@79@11)))
    (or (Set_in n$8@79@11 nodes@40@11) (not (Set_in n$8@79@11 nodes@40@11)))
    (=>
      (and
        (Set_in n$8@79@11 nodes@40@11)
        (not
          (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) $Ref.null)))
      (and
        (Set_in n$8@79@11 nodes@40@11)
        (not
          (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) $Ref.null))
        ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) n$8@79@11)))
    (or
      (not
        (and
          (Set_in n$8@79@11 nodes@40@11)
          (not
            (=
              ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11)
              $Ref.null))))
      (and
        (Set_in n$8@79@11 nodes@40@11)
        (not
          (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) $Ref.null)))))
  :pattern ((Set_in n$8@79@11 nodes@40@11) ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) n$8@79@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@26@27@26@37-aux|)))
(assert (forall ((n$8@79@11 $Ref)) (!
  (=>
    (and
      (Set_in n$8@79@11 nodes@40@11)
      (not
        (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) $Ref.null)))
    (Set_in ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) nodes@40@11))
  :pattern ((Set_in ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) nodes@40@11))
  :pattern ((Set_in n$8@79@11 nodes@40@11) ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n$8@79@11) n$8@79@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@26@27@26@37|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))))
  $Snap.unit))
; [eval] (forall n: Ref :: { (n in nodes), n.is_marked } (n in nodes) ==> old(n.is_marked) ==> n.is_marked)
(declare-const n@80@11 $Ref)
(push) ; 3
; [eval] (n in nodes) ==> old(n.is_marked) ==> n.is_marked
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 9 | n@80@11 in nodes@40@11 | live]
; [else-branch: 9 | !(n@80@11 in nodes@40@11) | live]
(push) ; 5
; [then-branch: 9 | n@80@11 in nodes@40@11]
(assert (Set_in n@80@11 nodes@40@11))
; [eval] old(n.is_marked) ==> n.is_marked
; [eval] old(n.is_marked)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@11)
      (=
        ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r))
    :qid |qp.fvfValDef17|))
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@11)
      (=
        ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r))
    :qid |qp.fvfValDef18|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
    :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef19|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11) n@80@11))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n@80@11 b@13@11) $Perm.Write $Perm.No)
    (ite (= n@80@11 a@3@11) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
; [then-branch: 10 | Lookup(is_marked, sm@42@11, n@80@11) | live]
; [else-branch: 10 | !(Lookup(is_marked, sm@42@11, n@80@11)) | live]
(push) ; 7
; [then-branch: 10 | Lookup(is_marked, sm@42@11, n@80@11)]
(assert ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11))
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
      (=
        ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@80@11) n@80@11))
(push) ; 8
(assert (not (and (img@76@11 n@80@11) (Set_in (inv@75@11 n@80@11) nodes@40@11))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 10 | !(Lookup(is_marked, sm@42@11, n@80@11))]
(assert (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11)))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11)
  (and
    ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@80@11) n@80@11))))
; Joined path conditions
(assert (or
  (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11))
  ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 9 | !(n@80@11 in nodes@40@11)]
(assert (not (Set_in n@80@11 nodes@40@11)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (Set_in n@80@11 nodes@40@11)
  (and
    (Set_in n@80@11 nodes@40@11)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11) n@80@11)
    (=>
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11)
      (and
        ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@80@11) n@80@11)))
    (or
      (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11))
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11)))))
; Joined path conditions
(assert (or (not (Set_in n@80@11 nodes@40@11)) (Set_in n@80@11 nodes@40@11)))
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@80@11 $Ref)) (!
  (and
    (=>
      (Set_in n@80@11 nodes@40@11)
      (and
        (Set_in n@80@11 nodes@40@11)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11) n@80@11)
        (=>
          ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11)
          (and
            ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11)
            ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@80@11) n@80@11)))
        (or
          (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11))
          ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11))))
    (or (not (Set_in n@80@11 nodes@40@11)) (Set_in n@80@11 nodes@40@11)))
  :pattern ((Set_in n@80@11 nodes@40@11) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@80@11) n@80@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@30@10@30@102-aux|)))
(assert (forall ((n@80@11 $Ref)) (!
  (=>
    (and
      (Set_in n@80@11 nodes@40@11)
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@80@11))
    ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@80@11))
  :pattern ((Set_in n@80@11 nodes@40@11) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@80@11) n@80@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@30@10@30@102|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))))))
  $Snap.unit))
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
      (=
        ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) a@3@11) a@3@11))
(push) ; 3
(assert (not (and (img@76@11 a@3@11) (Set_in (inv@75@11 a@3@11) nodes@40@11))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) a@3@11))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))))))
  $Snap.unit))
; [eval] (forall n: Ref :: { (n in nodes), n.left } (n in nodes) ==> n.left == old(n.left))
(declare-const n@81@11 $Ref)
(push) ; 3
; [eval] (n in nodes) ==> n.left == old(n.left)
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 11 | n@81@11 in nodes@40@11 | live]
; [else-branch: 11 | !(n@81@11 in nodes@40@11) | live]
(push) ; 5
; [then-branch: 11 | n@81@11 in nodes@40@11]
(assert (Set_in n@81@11 nodes@40@11))
; [eval] n.left == old(n.left)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11))
      (=
        ($FVF.lookup_left (as sm@69@11  $FVF<left>) r)
        ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r)))
    :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
    :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r))
    :qid |qp.fvfValDef33|))
  (forall ((r $Ref)) (!
    ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r) r)
    :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
    :qid |qp.fvfResTrgDef34|))))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@81@11) n@81@11))
(push) ; 6
(assert (not (and (img@68@11 n@81@11) (Set_in (inv@67@11 n@81@11) nodes@40@11))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] old(n.left)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@11)
      (=
        ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
        ($FVF.lookup_left (as sm@27@11  $FVF<left>) r)))
    :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
    :pattern (($FVF.lookup_left (as sm@27@11  $FVF<left>) r))
    :qid |qp.fvfValDef22|))
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@11)
      (=
        ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
        ($FVF.lookup_left (as sm@35@11  $FVF<left>) r)))
    :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
    :pattern (($FVF.lookup_left (as sm@35@11  $FVF<left>) r))
    :qid |qp.fvfValDef23|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_left ($FVF.lookup_left (as sm@27@11  $FVF<left>) r) r)
      ($FVF.loc_left ($FVF.lookup_left (as sm@35@11  $FVF<left>) r) r))
    :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
    :qid |qp.fvfResTrgDef24|))))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n@81@11) n@81@11))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n@81@11 a@3@11) $Perm.Write $Perm.No)
    (ite (= n@81@11 b@13@11) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 11 | !(n@81@11 in nodes@40@11)]
(assert (not (Set_in n@81@11 nodes@40@11)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11))
    (=
      ($FVF.lookup_left (as sm@69@11  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@27@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@27@11  $FVF<left>) r))
  :qid |qp.fvfValDef22|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@35@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@35@11  $FVF<left>) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@27@11  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@35@11  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef24|)))
(assert (=>
  (Set_in n@81@11 nodes@40@11)
  (and
    (Set_in n@81@11 nodes@40@11)
    ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@81@11) n@81@11)
    ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n@81@11) n@81@11))))
; Joined path conditions
(assert (or (not (Set_in n@81@11 nodes@40@11)) (Set_in n@81@11 nodes@40@11)))
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11))
    (=
      ($FVF.lookup_left (as sm@69@11  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@27@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@27@11  $FVF<left>) r))
  :qid |qp.fvfValDef22|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_left (as sm@47@11  $FVF<left>) r)
      ($FVF.lookup_left (as sm@35@11  $FVF<left>) r)))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left (as sm@35@11  $FVF<left>) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_left ($FVF.lookup_left (as sm@27@11  $FVF<left>) r) r)
    ($FVF.loc_left ($FVF.lookup_left (as sm@35@11  $FVF<left>) r) r))
  :pattern (($FVF.lookup_left (as sm@47@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef24|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@81@11 $Ref)) (!
  (and
    (=>
      (Set_in n@81@11 nodes@40@11)
      (and
        (Set_in n@81@11 nodes@40@11)
        ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@81@11) n@81@11)
        ($FVF.loc_left ($FVF.lookup_left (as sm@47@11  $FVF<left>) n@81@11) n@81@11)))
    (or (not (Set_in n@81@11 nodes@40@11)) (Set_in n@81@11 nodes@40@11)))
  :pattern ((Set_in n@81@11 nodes@40@11) ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@81@11) n@81@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@34@10@34@86-aux|)))
(assert (forall ((n@81@11 $Ref)) (!
  (=>
    (Set_in n@81@11 nodes@40@11)
    (=
      ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@81@11)
      ($FVF.lookup_left (as sm@47@11  $FVF<left>) n@81@11)))
  :pattern ((Set_in n@81@11 nodes@40@11) ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@81@11) n@81@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@34@10@34@86|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))))))))
  $Snap.unit))
; [eval] (forall n: Ref :: { (n in nodes), n.right } (n in nodes) ==> n.right == old(n.right))
(declare-const n@82@11 $Ref)
(push) ; 3
; [eval] (n in nodes) ==> n.right == old(n.right)
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 12 | n@82@11 in nodes@40@11 | live]
; [else-branch: 12 | !(n@82@11 in nodes@40@11) | live]
(push) ; 5
; [then-branch: 12 | n@82@11 in nodes@40@11]
(assert (Set_in n@82@11 nodes@40@11))
; [eval] n.right == old(n.right)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11))
      (=
        ($FVF.lookup_right (as sm@73@11  $FVF<right>) r)
        ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r)))
    :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
    :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r))
    :qid |qp.fvfValDef35|))
  (forall ((r $Ref)) (!
    ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r) r)
    :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
    :qid |qp.fvfResTrgDef36|))))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@82@11) n@82@11))
(push) ; 6
(assert (not (and (img@72@11 n@82@11) (Set_in (inv@71@11 n@82@11) nodes@40@11))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] old(n.right)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@11)
      (=
        ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
        ($FVF.lookup_right (as sm@39@11  $FVF<right>) r)))
    :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
    :pattern (($FVF.lookup_right (as sm@39@11  $FVF<right>) r))
    :qid |qp.fvfValDef28|))
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@11)
      (=
        ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
        ($FVF.lookup_right (as sm@31@11  $FVF<right>) r)))
    :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
    :pattern (($FVF.lookup_right (as sm@31@11  $FVF<right>) r))
    :qid |qp.fvfValDef29|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_right ($FVF.lookup_right (as sm@39@11  $FVF<right>) r) r)
      ($FVF.loc_right ($FVF.lookup_right (as sm@31@11  $FVF<right>) r) r))
    :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
    :qid |qp.fvfResTrgDef30|))))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) n@82@11) n@82@11))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n@82@11 b@13@11) $Perm.Write $Perm.No)
    (ite (= n@82@11 a@3@11) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 12 | !(n@82@11 in nodes@40@11)]
(assert (not (Set_in n@82@11 nodes@40@11)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11))
    (=
      ($FVF.lookup_right (as sm@73@11  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@39@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@39@11  $FVF<right>) r))
  :qid |qp.fvfValDef28|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@11  $FVF<right>) r))
  :qid |qp.fvfValDef29|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@11  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@11  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef30|)))
(assert (=>
  (Set_in n@82@11 nodes@40@11)
  (and
    (Set_in n@82@11 nodes@40@11)
    ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@82@11) n@82@11)
    ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) n@82@11) n@82@11))))
; Joined path conditions
(assert (or (not (Set_in n@82@11 nodes@40@11)) (Set_in n@82@11 nodes@40@11)))
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11))
    (=
      ($FVF.lookup_right (as sm@73@11  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@39@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@39@11  $FVF<right>) r))
  :qid |qp.fvfValDef28|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_right (as sm@63@11  $FVF<right>) r)
      ($FVF.lookup_right (as sm@31@11  $FVF<right>) r)))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right (as sm@31@11  $FVF<right>) r))
  :qid |qp.fvfValDef29|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_right ($FVF.lookup_right (as sm@39@11  $FVF<right>) r) r)
    ($FVF.loc_right ($FVF.lookup_right (as sm@31@11  $FVF<right>) r) r))
  :pattern (($FVF.lookup_right (as sm@63@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef30|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@82@11 $Ref)) (!
  (and
    (=>
      (Set_in n@82@11 nodes@40@11)
      (and
        (Set_in n@82@11 nodes@40@11)
        ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@82@11) n@82@11)
        ($FVF.loc_right ($FVF.lookup_right (as sm@63@11  $FVF<right>) n@82@11) n@82@11)))
    (or (not (Set_in n@82@11 nodes@40@11)) (Set_in n@82@11 nodes@40@11)))
  :pattern ((Set_in n@82@11 nodes@40@11) ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@82@11) n@82@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@35@10@35@89-aux|)))
(assert (forall ((n@82@11 $Ref)) (!
  (=>
    (Set_in n@82@11 nodes@40@11)
    (=
      ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@82@11)
      ($FVF.lookup_right (as sm@63@11  $FVF<right>) n@82@11)))
  :pattern ((Set_in n@82@11 nodes@40@11) ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@82@11) n@82@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@35@10@35@89|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))))))))
  $Snap.unit))
; [eval] (forall n: Ref :: { (n in nodes), n.is_marked } { (n in nodes), n.left.is_marked } (n in nodes) ==> old(!n.is_marked) && n.is_marked ==> n.left == null || n.left.is_marked)
(declare-const n@83@11 $Ref)
(push) ; 3
; [eval] (n in nodes) ==> old(!n.is_marked) && n.is_marked ==> n.left == null || n.left.is_marked
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 13 | n@83@11 in nodes@40@11 | live]
; [else-branch: 13 | !(n@83@11 in nodes@40@11) | live]
(push) ; 5
; [then-branch: 13 | n@83@11 in nodes@40@11]
(assert (Set_in n@83@11 nodes@40@11))
; [eval] old(!n.is_marked) && n.is_marked ==> n.left == null || n.left.is_marked
; [eval] old(!n.is_marked) && n.is_marked
; [eval] old(!n.is_marked)
; [eval] !n.is_marked
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@11)
      (=
        ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r))
    :qid |qp.fvfValDef17|))
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@11)
      (=
        ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r))
    :qid |qp.fvfValDef18|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
    :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef19|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11) n@83@11))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n@83@11 b@13@11) $Perm.Write $Perm.No)
    (ite (= n@83@11 a@3@11) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
; [then-branch: 14 | Lookup(is_marked, sm@42@11, n@83@11) | live]
; [else-branch: 14 | !(Lookup(is_marked, sm@42@11, n@83@11)) | live]
(push) ; 7
; [then-branch: 14 | Lookup(is_marked, sm@42@11, n@83@11)]
(assert ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
(pop) ; 7
(push) ; 7
; [else-branch: 14 | !(Lookup(is_marked, sm@42@11, n@83@11))]
(assert (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11)))
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
      (=
        ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11) n@83@11))
(push) ; 8
(assert (not (and (img@76@11 n@83@11) (Set_in (inv@75@11 n@83@11) nodes@40@11))))
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
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
  (and
    (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11) n@83@11))))
(assert (or
  (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
  ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11)))
(push) ; 6
; [then-branch: 15 | !(Lookup(is_marked, sm@42@11, n@83@11)) && Lookup(is_marked, sm@77@11, n@83@11) | live]
; [else-branch: 15 | !(!(Lookup(is_marked, sm@42@11, n@83@11)) && Lookup(is_marked, sm@77@11, n@83@11)) | live]
(push) ; 7
; [then-branch: 15 | !(Lookup(is_marked, sm@42@11, n@83@11)) && Lookup(is_marked, sm@77@11, n@83@11)]
(assert (and
  (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
  ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11)))
; [eval] n.left == null || n.left.is_marked
; [eval] n.left == null
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11))
      (=
        ($FVF.lookup_left (as sm@69@11  $FVF<left>) r)
        ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r)))
    :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
    :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r))
    :qid |qp.fvfValDef33|))
  (forall ((r $Ref)) (!
    ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r) r)
    :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
    :qid |qp.fvfResTrgDef34|))))
(assert ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) n@83@11))
(push) ; 8
(assert (not (and (img@68@11 n@83@11) (Set_in (inv@67@11 n@83@11) nodes@40@11))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(push) ; 8
; [then-branch: 16 | Lookup(left, sm@69@11, n@83@11) == Null | live]
; [else-branch: 16 | Lookup(left, sm@69@11, n@83@11) != Null | live]
(push) ; 9
; [then-branch: 16 | Lookup(left, sm@69@11, n@83@11) == Null]
(assert (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null))
(pop) ; 9
(push) ; 9
; [else-branch: 16 | Lookup(left, sm@69@11, n@83@11) != Null]
(assert (not (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null)))
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11))
      (=
        ($FVF.lookup_left (as sm@69@11  $FVF<left>) r)
        ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r)))
    :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
    :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r))
    :qid |qp.fvfValDef33|))
  (forall ((r $Ref)) (!
    ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r) r)
    :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
    :qid |qp.fvfResTrgDef34|))))
(push) ; 10
(assert (not (and (img@68@11 n@83@11) (Set_in (inv@67@11 n@83@11) nodes@40@11))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
      (=
        ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)))
(push) ; 10
(assert (not (and
  (img@76@11 ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11))
  (Set_in (inv@75@11 ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)) nodes@40@11))))
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
    (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11))
    (=
      ($FVF.lookup_left (as sm@69@11  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (not (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null))
  (and
    (not (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null))
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)))))
(assert (or
  (not (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null))
  (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null)))
(pop) ; 7
(push) ; 7
; [else-branch: 15 | !(!(Lookup(is_marked, sm@42@11, n@83@11)) && Lookup(is_marked, sm@77@11, n@83@11))]
(assert (not
  (and
    (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
    ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11))
    (=
      ($FVF.lookup_left (as sm@69@11  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (and
    (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
    ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11))
  (and
    (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
    ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11)
    ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) n@83@11)
    (=>
      (not (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null))
      (and
        (not (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null))
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11))))
    (or
      (not (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null))
      (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null)))))
; Joined path conditions
(assert (or
  (not
    (and
      (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11)))
  (and
    (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
    ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11))))
(pop) ; 5
(push) ; 5
; [else-branch: 13 | !(n@83@11 in nodes@40@11)]
(assert (not (Set_in n@83@11 nodes@40@11)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11))
    (=
      ($FVF.lookup_left (as sm@69@11  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
(assert (=>
  (Set_in n@83@11 nodes@40@11)
  (and
    (Set_in n@83@11 nodes@40@11)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11) n@83@11)
    (=>
      (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
      (and
        (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11) n@83@11)))
    (or
      (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
    (=>
      (and
        (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
        ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11))
      (and
        (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
        ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11)
        ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) n@83@11)
        (=>
          (not
            (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null))
          (and
            (not
              (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null))
            ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11))))
        (or
          (not
            (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null))
          (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null))))
    (or
      (not
        (and
          (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
          ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11)))
      (and
        (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
        ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11))))))
; Joined path conditions
(assert (or (not (Set_in n@83@11 nodes@40@11)) (Set_in n@83@11 nodes@40@11)))
; Definitional axioms for snapshot map values
; Definitional axioms for snapshot map values
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@68@11 r) (Set_in (inv@67@11 r) nodes@40@11))
    (=
      ($FVF.lookup_left (as sm@69@11  $FVF<left>) r)
      ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r)))
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :pattern (($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_left ($FVF.lookup_left ($SortWrappers.$SnapTo$FVF<left> ($Snap.first ($Snap.second ($Snap.second $t@65@11)))) r) r)
  :pattern (($FVF.lookup_left (as sm@69@11  $FVF<left>) r))
  :qid |qp.fvfResTrgDef34|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@83@11 $Ref)) (!
  (and
    (=>
      (Set_in n@83@11 nodes@40@11)
      (and
        (Set_in n@83@11 nodes@40@11)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11) n@83@11)
        (=>
          (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
            ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11) n@83@11)))
        (or
          (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
          ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
        (=>
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
            ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
            ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11)
            ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) n@83@11)
            (=>
              (not
                (=
                  ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)
                  $Ref.null))
              (and
                (not
                  (=
                    ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)
                    $Ref.null))
                ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11))))
            (or
              (not
                (=
                  ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)
                  $Ref.null))
              (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null))))
        (or
          (not
            (and
              (not
                ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
              ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11)))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
            ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11)))))
    (or (not (Set_in n@83@11 nodes@40@11)) (Set_in n@83@11 nodes@40@11)))
  :pattern ((Set_in n@83@11 nodes@40@11) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11) n@83@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@38@10@39@103-aux|)))
(assert (forall ((n@83@11 $Ref)) (!
  (and
    (=>
      (Set_in n@83@11 nodes@40@11)
      (and
        (Set_in n@83@11 nodes@40@11)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11) n@83@11)
        (=>
          (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
            ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11) n@83@11)))
        (or
          (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
          ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
        (=>
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
            ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
            ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11)
            ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) n@83@11)
            (=>
              (not
                (=
                  ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)
                  $Ref.null))
              (and
                (not
                  (=
                    ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)
                    $Ref.null))
                ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11))))
            (or
              (not
                (=
                  ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)
                  $Ref.null))
              (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null))))
        (or
          (not
            (and
              (not
                ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
              ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11)))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
            ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11)))))
    (or (not (Set_in n@83@11 nodes@40@11)) (Set_in n@83@11 nodes@40@11)))
  :pattern ((Set_in n@83@11 nodes@40@11) ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) n@83@11) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@38@10@39@103-aux|)))
(assert (forall ((n@83@11 $Ref)) (!
  (=>
    (and
      (Set_in n@83@11 nodes@40@11)
      (and
        (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@83@11))
        ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11)))
    (or
      (= ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) $Ref.null)
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11))))
  :pattern ((Set_in n@83@11 nodes@40@11) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@83@11) n@83@11))
  :pattern ((Set_in n@83@11 nodes@40@11) ($FVF.loc_left ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11) n@83@11) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)) ($FVF.lookup_left (as sm@69@11  $FVF<left>) n@83@11)))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@38@10@39@103|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11))))))))))))
  $Snap.unit))
; [eval] (forall n: Ref :: { (n in nodes), n.is_marked } { (n in nodes), n.right.is_marked } (n in nodes) ==> old(!n.is_marked) && n.is_marked ==> n.right == null || n.right.is_marked)
(declare-const n@84@11 $Ref)
(push) ; 3
; [eval] (n in nodes) ==> old(!n.is_marked) && n.is_marked ==> n.right == null || n.right.is_marked
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 17 | n@84@11 in nodes@40@11 | live]
; [else-branch: 17 | !(n@84@11 in nodes@40@11) | live]
(push) ; 5
; [then-branch: 17 | n@84@11 in nodes@40@11]
(assert (Set_in n@84@11 nodes@40@11))
; [eval] old(!n.is_marked) && n.is_marked ==> n.right == null || n.right.is_marked
; [eval] old(!n.is_marked) && n.is_marked
; [eval] old(!n.is_marked)
; [eval] !n.is_marked
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r b@13@11)
      (=
        ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r))
    :qid |qp.fvfValDef17|))
  (forall ((r $Ref)) (!
    (=>
      (= r a@3@11)
      (=
        ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r)))
    :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r))
    :qid |qp.fvfValDef18|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
      ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
    :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef19|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11) n@84@11))
(push) ; 6
(assert (not (<
  $Perm.No
  (+
    (ite (= n@84@11 b@13@11) $Perm.Write $Perm.No)
    (ite (= n@84@11 a@3@11) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(push) ; 6
; [then-branch: 18 | Lookup(is_marked, sm@42@11, n@84@11) | live]
; [else-branch: 18 | !(Lookup(is_marked, sm@42@11, n@84@11)) | live]
(push) ; 7
; [then-branch: 18 | Lookup(is_marked, sm@42@11, n@84@11)]
(assert ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
(pop) ; 7
(push) ; 7
; [else-branch: 18 | !(Lookup(is_marked, sm@42@11, n@84@11))]
(assert (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11)))
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
      (=
        ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11) n@84@11))
(push) ; 8
(assert (not (and (img@76@11 n@84@11) (Set_in (inv@75@11 n@84@11) nodes@40@11))))
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
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
  (and
    (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11) n@84@11))))
(assert (or
  (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
  ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11)))
(push) ; 6
; [then-branch: 19 | !(Lookup(is_marked, sm@42@11, n@84@11)) && Lookup(is_marked, sm@77@11, n@84@11) | live]
; [else-branch: 19 | !(!(Lookup(is_marked, sm@42@11, n@84@11)) && Lookup(is_marked, sm@77@11, n@84@11)) | live]
(push) ; 7
; [then-branch: 19 | !(Lookup(is_marked, sm@42@11, n@84@11)) && Lookup(is_marked, sm@77@11, n@84@11)]
(assert (and
  (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
  ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11)))
; [eval] n.right == null || n.right.is_marked
; [eval] n.right == null
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11))
      (=
        ($FVF.lookup_right (as sm@73@11  $FVF<right>) r)
        ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r)))
    :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
    :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r))
    :qid |qp.fvfValDef35|))
  (forall ((r $Ref)) (!
    ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r) r)
    :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
    :qid |qp.fvfResTrgDef36|))))
(assert ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) n@84@11))
(push) ; 8
(assert (not (and (img@72@11 n@84@11) (Set_in (inv@71@11 n@84@11) nodes@40@11))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(push) ; 8
; [then-branch: 20 | Lookup(right, sm@73@11, n@84@11) == Null | live]
; [else-branch: 20 | Lookup(right, sm@73@11, n@84@11) != Null | live]
(push) ; 9
; [then-branch: 20 | Lookup(right, sm@73@11, n@84@11) == Null]
(assert (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) $Ref.null))
(pop) ; 9
(push) ; 9
; [else-branch: 20 | Lookup(right, sm@73@11, n@84@11) != Null]
(assert (not (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) $Ref.null)))
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11))
      (=
        ($FVF.lookup_right (as sm@73@11  $FVF<right>) r)
        ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r)))
    :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
    :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r))
    :qid |qp.fvfValDef35|))
  (forall ((r $Ref)) (!
    ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r) r)
    :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
    :qid |qp.fvfResTrgDef36|))))
(push) ; 10
(assert (not (and (img@72@11 n@84@11) (Set_in (inv@71@11 n@84@11) nodes@40@11))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
      (=
        ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)))
(push) ; 10
(assert (not (and
  (img@76@11 ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11))
  (Set_in (inv@75@11 ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)) nodes@40@11))))
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
    (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11))
    (=
      ($FVF.lookup_right (as sm@73@11  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (not (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) $Ref.null))
  (and
    (not (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) $Ref.null))
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)))))
(assert (or
  (not (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) $Ref.null))
  (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) $Ref.null)))
(pop) ; 7
(push) ; 7
; [else-branch: 19 | !(!(Lookup(is_marked, sm@42@11, n@84@11)) && Lookup(is_marked, sm@77@11, n@84@11))]
(assert (not
  (and
    (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
    ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11))
    (=
      ($FVF.lookup_right (as sm@73@11  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (and
    (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
    ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11))
  (and
    (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
    ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11)
    ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) n@84@11)
    (=>
      (not (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) $Ref.null))
      (and
        (not
          (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) $Ref.null))
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11))))
    (or
      (not (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) $Ref.null))
      (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) $Ref.null)))))
; Joined path conditions
(assert (or
  (not
    (and
      (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11)))
  (and
    (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
    ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11))))
(pop) ; 5
(push) ; 5
; [else-branch: 17 | !(n@84@11 in nodes@40@11)]
(assert (not (Set_in n@84@11 nodes@40@11)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11))
    (=
      ($FVF.lookup_right (as sm@73@11  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
(assert (=>
  (Set_in n@84@11 nodes@40@11)
  (and
    (Set_in n@84@11 nodes@40@11)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11) n@84@11)
    (=>
      (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
      (and
        (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11) n@84@11)))
    (or
      (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
    (=>
      (and
        (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
        ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11))
      (and
        (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
        ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11)
        ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) n@84@11)
        (=>
          (not
            (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) $Ref.null))
          (and
            (not
              (=
                ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)
                $Ref.null))
            ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11))))
        (or
          (not
            (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) $Ref.null))
          (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) $Ref.null))))
    (or
      (not
        (and
          (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
          ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11)))
      (and
        (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
        ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11))))))
; Joined path conditions
(assert (or (not (Set_in n@84@11 nodes@40@11)) (Set_in n@84@11 nodes@40@11)))
; Definitional axioms for snapshot map values
; Definitional axioms for snapshot map values
; Definitional axioms for snapshot map values
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r b@13@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r a@3@11)
    (=
      ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r)))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@23@11  $FVF<is_marked>) r) r)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@12@11  $FVF<is_marked>) r) r))
  :pattern (($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@72@11 r) (Set_in (inv@71@11 r) nodes@40@11))
    (=
      ($FVF.lookup_right (as sm@73@11  $FVF<right>) r)
      ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r)))
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :pattern (($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_right ($FVF.lookup_right ($SortWrappers.$SnapTo$FVF<right> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@65@11))))) r) r)
  :pattern (($FVF.lookup_right (as sm@73@11  $FVF<right>) r))
  :qid |qp.fvfResTrgDef36|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@84@11 $Ref)) (!
  (and
    (=>
      (Set_in n@84@11 nodes@40@11)
      (and
        (Set_in n@84@11 nodes@40@11)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11) n@84@11)
        (=>
          (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
            ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11) n@84@11)))
        (or
          (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
          ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
        (=>
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
            ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
            ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11)
            ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) n@84@11)
            (=>
              (not
                (=
                  ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)
                  $Ref.null))
              (and
                (not
                  (=
                    ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)
                    $Ref.null))
                ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11))))
            (or
              (not
                (=
                  ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)
                  $Ref.null))
              (=
                ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)
                $Ref.null))))
        (or
          (not
            (and
              (not
                ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
              ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11)))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
            ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11)))))
    (or (not (Set_in n@84@11 nodes@40@11)) (Set_in n@84@11 nodes@40@11)))
  :pattern ((Set_in n@84@11 nodes@40@11) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11) n@84@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@40@10@41@104-aux|)))
(assert (forall ((n@84@11 $Ref)) (!
  (and
    (=>
      (Set_in n@84@11 nodes@40@11)
      (and
        (Set_in n@84@11 nodes@40@11)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11) n@84@11)
        (=>
          (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
            ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11) n@84@11)))
        (or
          (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
          ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
        (=>
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
            ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
            ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11)
            ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) n@84@11)
            (=>
              (not
                (=
                  ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)
                  $Ref.null))
              (and
                (not
                  (=
                    ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)
                    $Ref.null))
                ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11))))
            (or
              (not
                (=
                  ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)
                  $Ref.null))
              (=
                ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)
                $Ref.null))))
        (or
          (not
            (and
              (not
                ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
              ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11)))
          (and
            (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
            ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11)))))
    (or (not (Set_in n@84@11 nodes@40@11)) (Set_in n@84@11 nodes@40@11)))
  :pattern ((Set_in n@84@11 nodes@40@11) ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) n@84@11) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@40@10@41@104-aux|)))
(assert (forall ((n@84@11 $Ref)) (!
  (=>
    (and
      (Set_in n@84@11 nodes@40@11)
      (and
        (not ($FVF.lookup_is_marked (as sm@42@11  $FVF<is_marked>) n@84@11))
        ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11)))
    (or
      (= ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) $Ref.null)
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11))))
  :pattern ((Set_in n@84@11 nodes@40@11) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@84@11) n@84@11))
  :pattern ((Set_in n@84@11 nodes@40@11) ($FVF.loc_right ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11) n@84@11) ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)) ($FVF.lookup_right (as sm@73@11  $FVF<right>) n@84@11)))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@40@10@41@104|)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
; [exec]
; assert (forall n: Ref :: { (n in nodes) } (n in nodes) ==> n.is_marked)
; [eval] (forall n: Ref :: { (n in nodes) } (n in nodes) ==> n.is_marked)
(declare-const n@85@11 $Ref)
(set-option :timeout 0)
(push) ; 3
; [eval] (n in nodes) ==> n.is_marked
; [eval] (n in nodes)
(push) ; 4
; [then-branch: 21 | n@85@11 in nodes@40@11 | live]
; [else-branch: 21 | !(n@85@11 in nodes@40@11) | live]
(push) ; 5
; [then-branch: 21 | n@85@11 in nodes@40@11]
(assert (Set_in n@85@11 nodes@40@11))
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
      (=
        ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
        ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
    :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
    :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
    :qid |qp.fvfValDef37|))
  (forall ((r $Ref)) (!
    ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
    :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
    :qid |qp.fvfResTrgDef38|))))
(assert ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@85@11) n@85@11))
(push) ; 6
(assert (not (and (img@76@11 n@85@11) (Set_in (inv@75@11 n@85@11) nodes@40@11))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 21 | !(n@85@11 in nodes@40@11)]
(assert (not (Set_in n@85@11 nodes@40@11)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
(assert (=>
  (Set_in n@85@11 nodes@40@11)
  (and
    (Set_in n@85@11 nodes@40@11)
    ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@85@11) n@85@11))))
; Joined path conditions
(assert (or (not (Set_in n@85@11 nodes@40@11)) (Set_in n@85@11 nodes@40@11)))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@76@11 r) (Set_in (inv@75@11 r) nodes@40@11))
    (=
      ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r)
      ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r)))
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :pattern (($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r))
  :qid |qp.fvfValDef37|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_is_marked ($FVF.lookup_is_marked ($SortWrappers.$SnapTo$FVF<is_marked> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@65@11)))))) r) r)
  :pattern (($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) r))
  :qid |qp.fvfResTrgDef38|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((n@85@11 $Ref)) (!
  (and
    (=>
      (Set_in n@85@11 nodes@40@11)
      (and
        (Set_in n@85@11 nodes@40@11)
        ($FVF.loc_is_marked ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@85@11) n@85@11)))
    (or (not (Set_in n@85@11 nodes@40@11)) (Set_in n@85@11 nodes@40@11)))
  :pattern ((Set_in n@85@11 nodes@40@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@67@9@67@52-aux|)))
(push) ; 3
(assert (not (forall ((n@85@11 $Ref)) (!
  (=>
    (Set_in n@85@11 nodes@40@11)
    ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@85@11))
  :pattern ((Set_in n@85@11 nodes@40@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@67@9@67@52|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (forall ((n@85@11 $Ref)) (!
  (=>
    (Set_in n@85@11 nodes@40@11)
    ($FVF.lookup_is_marked (as sm@77@11  $FVF<is_marked>) n@85@11))
  :pattern ((Set_in n@85@11 nodes@40@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-marking/graph-marking.vpr@67@9@67@52|)))
(pop) ; 2
(pop) ; 1
