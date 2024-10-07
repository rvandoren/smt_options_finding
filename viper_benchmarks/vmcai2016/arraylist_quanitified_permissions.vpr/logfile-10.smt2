(get-info :version)
; (:version "4.13.0")
; Started: 2024-09-24 15:31:00
; Silicon.version: 1.1-SNAPSHOT (b737e366)
; Input file: /Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr
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
(declare-sort Set<Array_> 0)
(declare-sort Set<$Ref> 0)
(declare-sort Set<$Snap> 0)
(declare-sort Array_ 0)
(declare-sort Pair<Array~_Int> 0)
(declare-sort $FVF<val> 0)
(declare-sort $FVF<elems> 0)
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
(declare-fun $SortWrappers.Set<Array_>To$Snap (Set<Array_>) $Snap)
(declare-fun $SortWrappers.$SnapToSet<Array_> ($Snap) Set<Array_>)
(assert (forall ((x Set<Array_>)) (!
    (= x ($SortWrappers.$SnapToSet<Array_>($SortWrappers.Set<Array_>To$Snap x)))
    :pattern (($SortWrappers.Set<Array_>To$Snap x))
    :qid |$Snap.$SnapToSet<Array_>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.Set<Array_>To$Snap($SortWrappers.$SnapToSet<Array_> x)))
    :pattern (($SortWrappers.$SnapToSet<Array_> x))
    :qid |$Snap.Set<Array_>To$SnapToSet<Array_>|
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
(declare-fun $SortWrappers.Pair<Array~_Int>To$Snap (Pair<Array~_Int>) $Snap)
(declare-fun $SortWrappers.$SnapToPair<Array~_Int> ($Snap) Pair<Array~_Int>)
(assert (forall ((x Pair<Array~_Int>)) (!
    (= x ($SortWrappers.$SnapToPair<Array~_Int>($SortWrappers.Pair<Array~_Int>To$Snap x)))
    :pattern (($SortWrappers.Pair<Array~_Int>To$Snap x))
    :qid |$Snap.$SnapToPair<Array~_Int>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.Pair<Array~_Int>To$Snap($SortWrappers.$SnapToPair<Array~_Int> x)))
    :pattern (($SortWrappers.$SnapToPair<Array~_Int> x))
    :qid |$Snap.Pair<Array~_Int>To$SnapToPair<Array~_Int>|
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
(declare-fun $SortWrappers.$FVF<elems>To$Snap ($FVF<elems>) $Snap)
(declare-fun $SortWrappers.$SnapTo$FVF<elems> ($Snap) $FVF<elems>)
(assert (forall ((x $FVF<elems>)) (!
    (= x ($SortWrappers.$SnapTo$FVF<elems>($SortWrappers.$FVF<elems>To$Snap x)))
    :pattern (($SortWrappers.$FVF<elems>To$Snap x))
    :qid |$Snap.$SnapTo$FVF<elems>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.$FVF<elems>To$Snap($SortWrappers.$SnapTo$FVF<elems> x)))
    :pattern (($SortWrappers.$SnapTo$FVF<elems> x))
    :qid |$Snap.$FVF<elems>To$SnapTo$FVF<elems>|
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
(declare-fun Set_card (Set<Array_>) Int)
(declare-const Set_empty Set<Array_>)
(declare-fun Set_in (Array_ Set<Array_>) Bool)
(declare-fun Set_singleton (Array_) Set<Array_>)
(declare-fun Set_unionone (Set<Array_> Array_) Set<Array_>)
(declare-fun Set_union (Set<Array_> Set<Array_>) Set<Array_>)
(declare-fun Set_intersection (Set<Array_> Set<Array_>) Set<Array_>)
(declare-fun Set_difference (Set<Array_> Set<Array_>) Set<Array_>)
(declare-fun Set_subset (Set<Array_> Set<Array_>) Bool)
(declare-fun Set_equal (Set<Array_> Set<Array_>) Bool)
(declare-fun Set_skolem_diff (Set<Array_> Set<Array_>) Array_)
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
(declare-fun first<Array> (Pair<Array~_Int>) Array_)
(declare-fun second<Int> (Pair<Array~_Int>) Int)
(declare-fun loc<Ref> (Array_ Int) $Ref)
(declare-fun len<Int> (Array_) Int)
(declare-fun inv_loc<Pair<Array~_Int>> ($Ref) Pair<Array~_Int>)
; /field_value_functions_declarations.smt2 [val: Int]
(declare-fun $FVF.domain_val ($FVF<val>) Set<$Ref>)
(declare-fun $FVF.lookup_val ($FVF<val> $Ref) Int)
(declare-fun $FVF.after_val ($FVF<val> $FVF<val>) Bool)
(declare-fun $FVF.loc_val (Int $Ref) Bool)
(declare-fun $FVF.perm_val ($FPM $Ref) $Perm)
(declare-const $fvfTOP_val $FVF<val>)
; /field_value_functions_declarations.smt2 [elems: Array]
(declare-fun $FVF.domain_elems ($FVF<elems>) Set<$Ref>)
(declare-fun $FVF.lookup_elems ($FVF<elems> $Ref) Array_)
(declare-fun $FVF.after_elems ($FVF<elems> $FVF<elems>) Bool)
(declare-fun $FVF.loc_elems (Array_ $Ref) Bool)
(declare-fun $FVF.perm_elems ($FPM $Ref) $Perm)
(declare-const $fvfTOP_elems $FVF<elems>)
; Declaring symbols related to program functions (from program analysis)
(declare-fun length ($Snap $Ref) Int)
(declare-fun length%limited ($Snap $Ref) Int)
(declare-fun length%stateless ($Ref) Bool)
(declare-fun length%precondition ($Snap $Ref) Bool)
(declare-fun itemAt ($Snap $Ref Int) Int)
(declare-fun itemAt%limited ($Snap $Ref Int) Int)
(declare-fun itemAt%stateless ($Ref Int) Bool)
(declare-fun itemAt%precondition ($Snap $Ref Int) Bool)
; Snapshot variable to be used during function verification
(declare-fun s@$ () $Snap)
; Declaring predicate trigger functions
(declare-fun AList%trigger ($Snap $Ref) Bool)
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
(assert (forall ((s Set<Array_>)) (!
  (<= 0 (Set_card s))
  :pattern ((Set_card s))
  )))
(assert (forall ((o Array_)) (!
  (not (Set_in o (as Set_empty  Set<Array_>)))
  :pattern ((Set_in o (as Set_empty  Set<Array_>)))
  )))
(assert (forall ((s Set<Array_>)) (!
  (and
    (=> (= (Set_card s) 0) (= s (as Set_empty  Set<Array_>)))
    (=> (not (= (Set_card s) 0)) (exists ((x Array_))  (Set_in x s))))
  :pattern ((Set_card s))
  )))
(assert (forall ((r Array_)) (!
  (Set_in r (Set_singleton r))
  :pattern ((Set_singleton r))
  )))
(assert (forall ((r Array_) (o Array_)) (!
  (= (Set_in o (Set_singleton r)) (= r o))
  :pattern ((Set_in o (Set_singleton r)))
  )))
(assert (forall ((r Array_)) (!
  (= (Set_card (Set_singleton r)) 1)
  :pattern ((Set_card (Set_singleton r)))
  )))
(assert (forall ((a Set<Array_>) (x Array_) (o Array_)) (!
  (= (Set_in o (Set_unionone a x)) (or (= o x) (Set_in o a)))
  :pattern ((Set_in o (Set_unionone a x)))
  )))
(assert (forall ((a Set<Array_>) (x Array_)) (!
  (Set_in x (Set_unionone a x))
  :pattern ((Set_unionone a x))
  )))
(assert (forall ((a Set<Array_>) (x Array_) (y Array_)) (!
  (=> (Set_in y a) (Set_in y (Set_unionone a x)))
  :pattern ((Set_unionone a x) (Set_in y a))
  )))
(assert (forall ((a Set<Array_>) (x Array_)) (!
  (=> (Set_in x a) (= (Set_card (Set_unionone a x)) (Set_card a)))
  :pattern ((Set_card (Set_unionone a x)))
  )))
(assert (forall ((a Set<Array_>) (x Array_)) (!
  (=> (not (Set_in x a)) (= (Set_card (Set_unionone a x)) (+ (Set_card a) 1)))
  :pattern ((Set_card (Set_unionone a x)))
  )))
(assert (forall ((a Set<Array_>) (b Set<Array_>) (o Array_)) (!
  (= (Set_in o (Set_union a b)) (or (Set_in o a) (Set_in o b)))
  :pattern ((Set_in o (Set_union a b)))
  )))
(assert (forall ((a Set<Array_>) (b Set<Array_>) (y Array_)) (!
  (=> (Set_in y a) (Set_in y (Set_union a b)))
  :pattern ((Set_union a b) (Set_in y a))
  )))
(assert (forall ((a Set<Array_>) (b Set<Array_>) (y Array_)) (!
  (=> (Set_in y b) (Set_in y (Set_union a b)))
  :pattern ((Set_union a b) (Set_in y b))
  )))
(assert (forall ((a Set<Array_>) (b Set<Array_>) (o Array_)) (!
  (= (Set_in o (Set_intersection a b)) (and (Set_in o a) (Set_in o b)))
  :pattern ((Set_in o (Set_intersection a b)))
  :pattern ((Set_intersection a b) (Set_in o a))
  :pattern ((Set_intersection a b) (Set_in o b))
  )))
(assert (forall ((a Set<Array_>) (b Set<Array_>)) (!
  (= (Set_union (Set_union a b) b) (Set_union a b))
  :pattern ((Set_union (Set_union a b) b))
  )))
(assert (forall ((a Set<Array_>) (b Set<Array_>)) (!
  (= (Set_union a (Set_union a b)) (Set_union a b))
  :pattern ((Set_union a (Set_union a b)))
  )))
(assert (forall ((a Set<Array_>) (b Set<Array_>)) (!
  (= (Set_intersection (Set_intersection a b) b) (Set_intersection a b))
  :pattern ((Set_intersection (Set_intersection a b) b))
  )))
(assert (forall ((a Set<Array_>) (b Set<Array_>)) (!
  (= (Set_intersection a (Set_intersection a b)) (Set_intersection a b))
  :pattern ((Set_intersection a (Set_intersection a b)))
  )))
(assert (forall ((a Set<Array_>) (b Set<Array_>)) (!
  (=
    (+ (Set_card (Set_union a b)) (Set_card (Set_intersection a b)))
    (+ (Set_card a) (Set_card b)))
  :pattern ((Set_card (Set_union a b)))
  :pattern ((Set_card (Set_intersection a b)))
  )))
(assert (forall ((a Set<Array_>) (b Set<Array_>) (o Array_)) (!
  (= (Set_in o (Set_difference a b)) (and (Set_in o a) (not (Set_in o b))))
  :pattern ((Set_in o (Set_difference a b)))
  :pattern ((Set_difference a b) (Set_in o a))
  )))
(assert (forall ((a Set<Array_>) (b Set<Array_>) (y Array_)) (!
  (=> (Set_in y b) (not (Set_in y (Set_difference a b))))
  :pattern ((Set_difference a b) (Set_in y b))
  )))
(assert (forall ((a Set<Array_>) (b Set<Array_>)) (!
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
(assert (forall ((a Set<Array_>) (b Set<Array_>)) (!
  (=
    (Set_subset a b)
    (forall ((o Array_)) (!
      (=> (Set_in o a) (Set_in o b))
      :pattern ((Set_in o a))
      :pattern ((Set_in o b))
      )))
  :pattern ((Set_subset a b))
  )))
(assert (forall ((a Set<Array_>) (b Set<Array_>)) (!
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
(assert (forall ((a Set<Array_>) (b Set<Array_>)) (!
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
  (=>
    (and (<= 0 i) (< i (len<Int> a)))
    (and
      (= (first<Array> (inv_loc<Pair<Array~_Int>> (loc<Ref> a i))) a)
      (= (second<Int> (inv_loc<Pair<Array~_Int>> (loc<Ref> a i))) i)))
  :pattern ((loc<Ref> a i))
  :qid |prog.loc_injective|)))
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
; /field_value_functions_axioms.smt2 [elems: Array]
(assert (forall ((vs $FVF<elems>) (ws $FVF<elems>)) (!
    (=>
      (and
        (Set_equal ($FVF.domain_elems vs) ($FVF.domain_elems ws))
        (forall ((x $Ref)) (!
          (=>
            (Set_in x ($FVF.domain_elems vs))
            (= ($FVF.lookup_elems vs x) ($FVF.lookup_elems ws x)))
          :pattern (($FVF.lookup_elems vs x) ($FVF.lookup_elems ws x))
          :qid |qp.$FVF<elems>-eq-inner|
          )))
      (= vs ws))
    :pattern (($SortWrappers.$FVF<elems>To$Snap vs)
              ($SortWrappers.$FVF<elems>To$Snap ws)
              )
    :qid |qp.$FVF<elems>-eq-outer|
    )))
(assert (forall ((r $Ref) (pm $FPM)) (!
    ($Perm.isValidVar ($FVF.perm_elems pm r))
    :pattern (($FVF.perm_elems pm r)))))
(assert (forall ((r $Ref) (f Array_)) (!
    (= ($FVF.loc_elems f r) true)
    :pattern (($FVF.loc_elems f r)))))
; End preamble
; ------------------------------------------------------------
; State saturation: after preamble
(set-option :timeout 100)
(check-sat)
; unknown
; ------------------------------------------------------------
; Begin function- and predicate-related preamble
; Declaring symbols related to program functions (from verification)
(declare-fun inv@7@00 ($Snap $Ref $Ref) Int)
(declare-fun img@8@00 ($Snap $Ref $Ref) Bool)
(declare-fun inv@10@00 ($Snap $Ref Int $Ref) Int)
(declare-fun img@11@00 ($Snap $Ref Int $Ref) Bool)
(assert (forall ((s@$ $Snap) (this@0@00 $Ref)) (!
  (= (length%limited s@$ this@0@00) (length s@$ this@0@00))
  :pattern ((length s@$ this@0@00))
  :qid |quant-u-0|)))
(assert (forall ((s@$ $Snap) (this@0@00 $Ref)) (!
  (length%stateless this@0@00)
  :pattern ((length%limited s@$ this@0@00))
  :qid |quant-u-1|)))
(assert (forall ((s@$ $Snap) (this@0@00 $Ref)) (!
  (let ((result@1@00 (length%limited s@$ this@0@00))) (=>
    (length%precondition s@$ this@0@00)
    (>= result@1@00 0)))
  :pattern ((length%limited s@$ this@0@00))
  :qid |quant-u-4|)))
(assert (forall ((s@$ $Snap) (this@0@00 $Ref)) (!
  (let ((result@1@00 (length%limited s@$ this@0@00))) true)
  :pattern ((length%limited s@$ this@0@00))
  :qid |quant-u-5|)))
(assert (forall ((s@$ $Snap) (this@0@00 $Ref)) (!
  (and
    (forall ((i@6@00 Int)) (!
      (=>
        (and
          (<= 0 i@6@00)
          (< i@6@00 (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first s@$)))))
        (and
          (=
            (inv@7@00 s@$ this@0@00 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first s@$)) i@6@00))
            i@6@00)
          (img@8@00 s@$ this@0@00 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first s@$)) i@6@00))))
      :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first s@$)) i@6@00))
      :qid |quant-u-7|))
    (forall ((r $Ref)) (!
      (=>
        (and
          (img@8@00 s@$ this@0@00 r)
          (and
            (<= 0 (inv@7@00 s@$ this@0@00 r))
            (<
              (inv@7@00 s@$ this@0@00 r)
              (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first s@$))))))
        (=
          (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first s@$)) (inv@7@00 s@$ this@0@00 r))
          r))
      :pattern ((inv@7@00 s@$ this@0@00 r))
      :qid |val-fctOfInv|))
    (=>
      (length%precondition s@$ this@0@00)
      (=
        (length s@$ this@0@00)
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second s@$))))))
  :pattern ((length s@$ this@0@00))
  :qid |quant-u-8|)))
(assert (forall ((s@$ $Snap) (this@0@00 $Ref)) (!
  true
  :pattern ((length s@$ this@0@00))
  :qid |quant-u-9|)))
(assert (forall ((s@$ $Snap) (this@2@00 $Ref) (index@3@00 Int)) (!
  (= (itemAt%limited s@$ this@2@00 index@3@00) (itemAt s@$ this@2@00 index@3@00))
  :pattern ((itemAt s@$ this@2@00 index@3@00))
  :qid |quant-u-2|)))
(assert (forall ((s@$ $Snap) (this@2@00 $Ref) (index@3@00 Int)) (!
  (itemAt%stateless this@2@00 index@3@00)
  :pattern ((itemAt%limited s@$ this@2@00 index@3@00))
  :qid |quant-u-3|)))
(assert (forall ((s@$ $Snap) (this@2@00 $Ref) (index@3@00 Int)) (!
  (and
    (forall ((i@9@00 Int)) (!
      (=>
        (and
          (<= 0 i@9@00)
          (<
            i@9@00
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first s@$))))))
        (and
          (=
            (inv@10@00 s@$ this@2@00 index@3@00 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first s@$))) i@9@00))
            i@9@00)
          (img@11@00 s@$ this@2@00 index@3@00 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first s@$))) i@9@00))))
      :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first s@$))) i@9@00))
      :qid |quant-u-11|))
    (forall ((r $Ref)) (!
      (=>
        (and
          (img@11@00 s@$ this@2@00 index@3@00 r)
          (and
            (<= 0 (inv@10@00 s@$ this@2@00 index@3@00 r))
            (<
              (inv@10@00 s@$ this@2@00 index@3@00 r)
              (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first s@$)))))))
        (=
          (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first s@$))) (inv@10@00 s@$ this@2@00 index@3@00 r))
          r))
      :pattern ((inv@10@00 s@$ this@2@00 index@3@00 r))
      :qid |val-fctOfInv|))
    (=>
      (itemAt%precondition s@$ this@2@00 index@3@00)
      (=
        (itemAt s@$ this@2@00 index@3@00)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first s@$))))))) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first s@$))) index@3@00)))))
  :pattern ((itemAt s@$ this@2@00 index@3@00))
  :qid |quant-u-12|)))
(assert (forall ((s@$ $Snap) (this@2@00 $Ref) (index@3@00 Int)) (!
  true
  :pattern ((itemAt s@$ this@2@00 index@3@00))
  :qid |quant-u-13|)))
; End function- and predicate-related preamble
; ------------------------------------------------------------
; ---------- insert ----------
(declare-const this@0@10 $Ref)
(declare-const elem@1@10 Int)
(declare-const j@2@10 Int)
(declare-const this@3@10 $Ref)
(declare-const elem@4@10 Int)
(declare-const j@5@10 Int)
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
; [eval] 0 <= j
(assert (<= 0 j@5@10))
(assert (=
  ($Snap.second ($Snap.second $t@7@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@7@10)))
    ($Snap.second ($Snap.second ($Snap.second $t@7@10))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@7@10))) $Snap.unit))
; [eval] j < length(this)
; [eval] length(this)
(push) ; 3
(assert (length%precondition ($Snap.first $t@7@10) this@3@10))
(pop) ; 3
; Joined path conditions
(assert (length%precondition ($Snap.first $t@7@10) this@3@10))
(assert (< j@5@10 (length ($Snap.first $t@7@10) this@3@10)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@7@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@7@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@7@10)))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@7@10)))) $Snap.unit))
; [eval] length(this) == old(length(this)) + 1
; [eval] length(this)
(push) ; 3
(pop) ; 3
; Joined path conditions
; [eval] old(length(this)) + 1
; [eval] old(length(this))
; [eval] length(this)
(push) ; 3
(assert (length%precondition $t@6@10 this@3@10))
(pop) ; 3
; Joined path conditions
(assert (length%precondition $t@6@10 this@3@10))
(assert (= (length ($Snap.first $t@7@10) this@3@10) (+ (length $t@6@10 this@3@10) 1)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@7@10))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@7@10)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@7@10))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@7@10)))))
  $Snap.unit))
; [eval] (forall k: Int :: { old(itemAt(this, k)) } 0 <= k && k < j ==> itemAt(this, k) == old(itemAt(this, k)))
(declare-const k@8@10 Int)
(push) ; 3
; [eval] 0 <= k && k < j ==> itemAt(this, k) == old(itemAt(this, k))
; [eval] 0 <= k && k < j
; [eval] 0 <= k
(push) ; 4
; [then-branch: 0 | !(0 <= k@8@10) | live]
; [else-branch: 0 | 0 <= k@8@10 | live]
(push) ; 5
; [then-branch: 0 | !(0 <= k@8@10)]
(assert (not (<= 0 k@8@10)))
(pop) ; 5
(push) ; 5
; [else-branch: 0 | 0 <= k@8@10]
(assert (<= 0 k@8@10))
; [eval] k < j
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 k@8@10) (not (<= 0 k@8@10))))
(push) ; 4
; [then-branch: 1 | 0 <= k@8@10 && k@8@10 < j@5@10 | live]
; [else-branch: 1 | !(0 <= k@8@10 && k@8@10 < j@5@10) | live]
(push) ; 5
; [then-branch: 1 | 0 <= k@8@10 && k@8@10 < j@5@10]
(assert (and (<= 0 k@8@10) (< k@8@10 j@5@10)))
; [eval] itemAt(this, k) == old(itemAt(this, k))
; [eval] itemAt(this, k)
(push) ; 6
; [eval] 0 <= index
; [eval] index < length(this)
; [eval] length(this)
(push) ; 7
(pop) ; 7
; Joined path conditions
(push) ; 7
(assert (not (< k@8@10 (length ($Snap.first $t@7@10) this@3@10))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (< k@8@10 (length ($Snap.first $t@7@10) this@3@10)))
(assert (itemAt%precondition ($Snap.combine
  ($Snap.first $t@7@10)
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@8@10))
(pop) ; 6
; Joined path conditions
(assert (and
  (< k@8@10 (length ($Snap.first $t@7@10) this@3@10))
  (itemAt%precondition ($Snap.combine
    ($Snap.first $t@7@10)
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@8@10)))
; [eval] old(itemAt(this, k))
; [eval] itemAt(this, k)
(push) ; 6
; [eval] 0 <= index
; [eval] index < length(this)
; [eval] length(this)
(push) ; 7
(pop) ; 7
; Joined path conditions
(push) ; 7
(assert (not (< k@8@10 (length $t@6@10 this@3@10))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (< k@8@10 (length $t@6@10 this@3@10)))
(assert (itemAt%precondition ($Snap.combine
  $t@6@10
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@8@10))
(pop) ; 6
; Joined path conditions
(assert (and
  (< k@8@10 (length $t@6@10 this@3@10))
  (itemAt%precondition ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@8@10)))
(pop) ; 5
(push) ; 5
; [else-branch: 1 | !(0 <= k@8@10 && k@8@10 < j@5@10)]
(assert (not (and (<= 0 k@8@10) (< k@8@10 j@5@10))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (=>
  (and (<= 0 k@8@10) (< k@8@10 j@5@10))
  (and
    (<= 0 k@8@10)
    (< k@8@10 j@5@10)
    (< k@8@10 (length ($Snap.first $t@7@10) this@3@10))
    (itemAt%precondition ($Snap.combine
      ($Snap.first $t@7@10)
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@8@10)
    (< k@8@10 (length $t@6@10 this@3@10))
    (itemAt%precondition ($Snap.combine
      $t@6@10
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@8@10))))
; Joined path conditions
(assert (or
  (not (and (<= 0 k@8@10) (< k@8@10 j@5@10)))
  (and (<= 0 k@8@10) (< k@8@10 j@5@10))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((k@8@10 Int)) (!
  (and
    (or (<= 0 k@8@10) (not (<= 0 k@8@10)))
    (=>
      (and (<= 0 k@8@10) (< k@8@10 j@5@10))
      (and
        (<= 0 k@8@10)
        (< k@8@10 j@5@10)
        (< k@8@10 (length ($Snap.first $t@7@10) this@3@10))
        (itemAt%precondition ($Snap.combine
          ($Snap.first $t@7@10)
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@8@10)
        (< k@8@10 (length $t@6@10 this@3@10))
        (itemAt%precondition ($Snap.combine
          $t@6@10
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@8@10)))
    (or
      (not (and (<= 0 k@8@10) (< k@8@10 j@5@10)))
      (and (<= 0 k@8@10) (< k@8@10 j@5@10))))
  :pattern ((itemAt%limited ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@8@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@101@11@101@87-aux|)))
(assert (forall ((k@8@10 Int)) (!
  (=>
    (and (<= 0 k@8@10) (< k@8@10 j@5@10))
    (=
      (itemAt ($Snap.combine
        ($Snap.first $t@7@10)
        ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@8@10)
      (itemAt ($Snap.combine $t@6@10 ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@8@10)))
  :pattern ((itemAt%limited ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@8@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@101@11@101@87|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@7@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@7@10))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@7@10)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@7@10))))))
  $Snap.unit))
; [eval] itemAt(this, j) == elem
; [eval] itemAt(this, j)
(push) ; 3
; [eval] 0 <= index
; [eval] index < length(this)
; [eval] length(this)
(push) ; 4
(pop) ; 4
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  ($Snap.first $t@7@10)
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@5@10))
(pop) ; 3
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  ($Snap.first $t@7@10)
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@5@10))
(assert (=
  (itemAt ($Snap.combine
    ($Snap.first $t@7@10)
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@5@10)
  elem@4@10))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@7@10))))))
  $Snap.unit))
; [eval] (forall k: Int :: { itemAt(this, k) } j < k && k < length(this) ==> itemAt(this, k) == old(itemAt(this, k - 1)))
(declare-const k@9@10 Int)
(push) ; 3
; [eval] j < k && k < length(this) ==> itemAt(this, k) == old(itemAt(this, k - 1))
; [eval] j < k && k < length(this)
; [eval] j < k
(push) ; 4
; [then-branch: 2 | !(j@5@10 < k@9@10) | live]
; [else-branch: 2 | j@5@10 < k@9@10 | live]
(push) ; 5
; [then-branch: 2 | !(j@5@10 < k@9@10)]
(assert (not (< j@5@10 k@9@10)))
(pop) ; 5
(push) ; 5
; [else-branch: 2 | j@5@10 < k@9@10]
(assert (< j@5@10 k@9@10))
; [eval] k < length(this)
; [eval] length(this)
(push) ; 6
(pop) ; 6
; Joined path conditions
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (< j@5@10 k@9@10) (not (< j@5@10 k@9@10))))
(push) ; 4
; [then-branch: 3 | j@5@10 < k@9@10 && k@9@10 < length(First:($t@7@10), this@3@10) | live]
; [else-branch: 3 | !(j@5@10 < k@9@10 && k@9@10 < length(First:($t@7@10), this@3@10)) | live]
(push) ; 5
; [then-branch: 3 | j@5@10 < k@9@10 && k@9@10 < length(First:($t@7@10), this@3@10)]
(assert (and (< j@5@10 k@9@10) (< k@9@10 (length ($Snap.first $t@7@10) this@3@10))))
; [eval] itemAt(this, k) == old(itemAt(this, k - 1))
; [eval] itemAt(this, k)
(push) ; 6
; [eval] 0 <= index
(push) ; 7
(assert (not (<= 0 k@9@10)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 k@9@10))
; [eval] index < length(this)
; [eval] length(this)
(push) ; 7
(pop) ; 7
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  ($Snap.first $t@7@10)
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@9@10))
(pop) ; 6
; Joined path conditions
(assert (and
  (<= 0 k@9@10)
  (itemAt%precondition ($Snap.combine
    ($Snap.first $t@7@10)
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@9@10)))
; [eval] old(itemAt(this, k - 1))
; [eval] itemAt(this, k - 1)
; [eval] k - 1
(push) ; 6
; [eval] 0 <= index
(push) ; 7
(assert (not (<= 0 (- k@9@10 1))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 (- k@9@10 1)))
; [eval] index < length(this)
; [eval] length(this)
(push) ; 7
(pop) ; 7
; Joined path conditions
(push) ; 7
(assert (not (< (- k@9@10 1) (length $t@6@10 this@3@10))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (< (- k@9@10 1) (length $t@6@10 this@3@10)))
(assert (itemAt%precondition ($Snap.combine
  $t@6@10
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- k@9@10 1)))
(pop) ; 6
; Joined path conditions
(assert (and
  (<= 0 (- k@9@10 1))
  (< (- k@9@10 1) (length $t@6@10 this@3@10))
  (itemAt%precondition ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- k@9@10 1))))
(pop) ; 5
(push) ; 5
; [else-branch: 3 | !(j@5@10 < k@9@10 && k@9@10 < length(First:($t@7@10), this@3@10))]
(assert (not (and (< j@5@10 k@9@10) (< k@9@10 (length ($Snap.first $t@7@10) this@3@10)))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (=>
  (and (< j@5@10 k@9@10) (< k@9@10 (length ($Snap.first $t@7@10) this@3@10)))
  (and
    (< j@5@10 k@9@10)
    (< k@9@10 (length ($Snap.first $t@7@10) this@3@10))
    (<= 0 k@9@10)
    (itemAt%precondition ($Snap.combine
      ($Snap.first $t@7@10)
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@9@10)
    (<= 0 (- k@9@10 1))
    (< (- k@9@10 1) (length $t@6@10 this@3@10))
    (itemAt%precondition ($Snap.combine
      $t@6@10
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- k@9@10 1)))))
; Joined path conditions
(assert (or
  (not
    (and (< j@5@10 k@9@10) (< k@9@10 (length ($Snap.first $t@7@10) this@3@10))))
  (and (< j@5@10 k@9@10) (< k@9@10 (length ($Snap.first $t@7@10) this@3@10)))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((k@9@10 Int)) (!
  (and
    (or (< j@5@10 k@9@10) (not (< j@5@10 k@9@10)))
    (=>
      (and (< j@5@10 k@9@10) (< k@9@10 (length ($Snap.first $t@7@10) this@3@10)))
      (and
        (< j@5@10 k@9@10)
        (< k@9@10 (length ($Snap.first $t@7@10) this@3@10))
        (<= 0 k@9@10)
        (itemAt%precondition ($Snap.combine
          ($Snap.first $t@7@10)
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@9@10)
        (<= 0 (- k@9@10 1))
        (< (- k@9@10 1) (length $t@6@10 this@3@10))
        (itemAt%precondition ($Snap.combine
          $t@6@10
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- k@9@10 1))))
    (or
      (not
        (and
          (< j@5@10 k@9@10)
          (< k@9@10 (length ($Snap.first $t@7@10) this@3@10))))
      (and (< j@5@10 k@9@10) (< k@9@10 (length ($Snap.first $t@7@10) this@3@10)))))
  :pattern ((itemAt%limited ($Snap.combine
    ($Snap.first $t@7@10)
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@9@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@103@11@103@101-aux|)))
(assert (forall ((k@9@10 Int)) (!
  (=>
    (and (< j@5@10 k@9@10) (< k@9@10 (length ($Snap.first $t@7@10) this@3@10)))
    (=
      (itemAt ($Snap.combine
        ($Snap.first $t@7@10)
        ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@9@10)
      (itemAt ($Snap.combine $t@6@10 ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (-
        k@9@10
        1))))
  :pattern ((itemAt%limited ($Snap.combine
    ($Snap.first $t@7@10)
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@9@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@103@11@103@101|)))
(pop) ; 2
(push) ; 2
; [exec]
; var t: Int
(declare-const t@10@10 Int)
; [exec]
; j := 0
(declare-const j@11@10 Int)
(push) ; 3
; Loop head block: Check well-definedness of invariant
(declare-const $t@12@10 $Snap)
(assert (= $t@12@10 ($Snap.combine ($Snap.first $t@12@10) ($Snap.second $t@12@10))))
(assert (=
  ($Snap.second $t@12@10)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@12@10))
    ($Snap.second ($Snap.second $t@12@10)))))
(assert (= ($Snap.first ($Snap.second $t@12@10)) $Snap.unit))
; [eval] 0 <= j
(assert (<= 0 j@11@10))
(assert (=
  ($Snap.second ($Snap.second $t@12@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@12@10)))
    ($Snap.second ($Snap.second ($Snap.second $t@12@10))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@12@10))) $Snap.unit))
; [eval] j <= length(this)
; [eval] length(this)
(push) ; 4
(assert (length%precondition ($Snap.first $t@12@10) this@3@10))
(pop) ; 4
; Joined path conditions
(assert (length%precondition ($Snap.first $t@12@10) this@3@10))
(assert (<= j@11@10 (length ($Snap.first $t@12@10) this@3@10)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@12@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@12@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@12@10))))
  $Snap.unit))
; [eval] j > 0 ==> itemAt(this, j - 1) <= elem
; [eval] j > 0
(push) ; 4
(push) ; 5
(set-option :timeout 10)
(assert (not (not (> j@11@10 0))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 10)
(assert (not (> j@11@10 0)))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [then-branch: 4 | j@11@10 > 0 | live]
; [else-branch: 4 | !(j@11@10 > 0) | live]
(set-option :timeout 0)
(push) ; 5
; [then-branch: 4 | j@11@10 > 0]
(assert (> j@11@10 0))
; [eval] itemAt(this, j - 1) <= elem
; [eval] itemAt(this, j - 1)
; [eval] j - 1
(push) ; 6
; [eval] 0 <= index
(push) ; 7
(assert (not (<= 0 (- j@11@10 1))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 (- j@11@10 1)))
; [eval] index < length(this)
; [eval] length(this)
(push) ; 7
(pop) ; 7
; Joined path conditions
(push) ; 7
(assert (not (< (- j@11@10 1) (length ($Snap.first $t@12@10) this@3@10))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (< (- j@11@10 1) (length ($Snap.first $t@12@10) this@3@10)))
(assert (itemAt%precondition ($Snap.combine
  ($Snap.first $t@12@10)
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- j@11@10 1)))
(pop) ; 6
; Joined path conditions
(assert (and
  (<= 0 (- j@11@10 1))
  (< (- j@11@10 1) (length ($Snap.first $t@12@10) this@3@10))
  (itemAt%precondition ($Snap.combine
    ($Snap.first $t@12@10)
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- j@11@10 1))))
(pop) ; 5
(push) ; 5
; [else-branch: 4 | !(j@11@10 > 0)]
(assert (not (> j@11@10 0)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (=>
  (> j@11@10 0)
  (and
    (> j@11@10 0)
    (<= 0 (- j@11@10 1))
    (< (- j@11@10 1) (length ($Snap.first $t@12@10) this@3@10))
    (itemAt%precondition ($Snap.combine
      ($Snap.first $t@12@10)
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- j@11@10 1)))))
; Joined path conditions
(assert (or (not (> j@11@10 0)) (> j@11@10 0)))
(assert (=>
  (> j@11@10 0)
  (<=
    (itemAt ($Snap.combine
      ($Snap.first $t@12@10)
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- j@11@10 1))
    elem@4@10)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))
  $Snap.unit))
; [eval] length(this) == old(length(this))
; [eval] length(this)
(push) ; 4
(pop) ; 4
; Joined path conditions
; [eval] old(length(this))
; [eval] length(this)
(push) ; 4
(assert (length%precondition $t@6@10 this@3@10))
(pop) ; 4
; Joined path conditions
(assert (length%precondition $t@6@10 this@3@10))
(assert (= (length ($Snap.first $t@12@10) this@3@10) (length $t@6@10 this@3@10)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))
  $Snap.unit))
; [eval] (forall k: Int :: { old(itemAt(this, k)) } 0 <= k && k < length(this) ==> itemAt(this, k) == old(itemAt(this, k)))
(declare-const k@13@10 Int)
(push) ; 4
; [eval] 0 <= k && k < length(this) ==> itemAt(this, k) == old(itemAt(this, k))
; [eval] 0 <= k && k < length(this)
; [eval] 0 <= k
(push) ; 5
; [then-branch: 5 | !(0 <= k@13@10) | live]
; [else-branch: 5 | 0 <= k@13@10 | live]
(push) ; 6
; [then-branch: 5 | !(0 <= k@13@10)]
(assert (not (<= 0 k@13@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 5 | 0 <= k@13@10]
(assert (<= 0 k@13@10))
; [eval] k < length(this)
; [eval] length(this)
(push) ; 7
(pop) ; 7
; Joined path conditions
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 k@13@10) (not (<= 0 k@13@10))))
(push) ; 5
; [then-branch: 6 | 0 <= k@13@10 && k@13@10 < length(First:($t@12@10), this@3@10) | live]
; [else-branch: 6 | !(0 <= k@13@10 && k@13@10 < length(First:($t@12@10), this@3@10)) | live]
(push) ; 6
; [then-branch: 6 | 0 <= k@13@10 && k@13@10 < length(First:($t@12@10), this@3@10)]
(assert (and (<= 0 k@13@10) (< k@13@10 (length ($Snap.first $t@12@10) this@3@10))))
; [eval] itemAt(this, k) == old(itemAt(this, k))
; [eval] itemAt(this, k)
(push) ; 7
; [eval] 0 <= index
; [eval] index < length(this)
; [eval] length(this)
(push) ; 8
(pop) ; 8
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  ($Snap.first $t@12@10)
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10))
(pop) ; 7
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  ($Snap.first $t@12@10)
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10))
; [eval] old(itemAt(this, k))
; [eval] itemAt(this, k)
(push) ; 7
; [eval] 0 <= index
; [eval] index < length(this)
; [eval] length(this)
(push) ; 8
(pop) ; 8
; Joined path conditions
(push) ; 8
(assert (not (< k@13@10 (length $t@6@10 this@3@10))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (< k@13@10 (length $t@6@10 this@3@10)))
(assert (itemAt%precondition ($Snap.combine
  $t@6@10
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10))
(pop) ; 7
; Joined path conditions
(assert (and
  (< k@13@10 (length $t@6@10 this@3@10))
  (itemAt%precondition ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 6 | !(0 <= k@13@10 && k@13@10 < length(First:($t@12@10), this@3@10))]
(assert (not (and (<= 0 k@13@10) (< k@13@10 (length ($Snap.first $t@12@10) this@3@10)))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
(assert (=>
  (and (<= 0 k@13@10) (< k@13@10 (length ($Snap.first $t@12@10) this@3@10)))
  (and
    (<= 0 k@13@10)
    (< k@13@10 (length ($Snap.first $t@12@10) this@3@10))
    (itemAt%precondition ($Snap.combine
      ($Snap.first $t@12@10)
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10)
    (< k@13@10 (length $t@6@10 this@3@10))
    (itemAt%precondition ($Snap.combine
      $t@6@10
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10))))
; Joined path conditions
(assert (or
  (not
    (and (<= 0 k@13@10) (< k@13@10 (length ($Snap.first $t@12@10) this@3@10))))
  (and (<= 0 k@13@10) (< k@13@10 (length ($Snap.first $t@12@10) this@3@10)))))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((k@13@10 Int)) (!
  (and
    (or (<= 0 k@13@10) (not (<= 0 k@13@10)))
    (=>
      (and (<= 0 k@13@10) (< k@13@10 (length ($Snap.first $t@12@10) this@3@10)))
      (and
        (<= 0 k@13@10)
        (< k@13@10 (length ($Snap.first $t@12@10) this@3@10))
        (itemAt%precondition ($Snap.combine
          ($Snap.first $t@12@10)
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10)
        (< k@13@10 (length $t@6@10 this@3@10))
        (itemAt%precondition ($Snap.combine
          $t@6@10
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10)))
    (or
      (not
        (and
          (<= 0 k@13@10)
          (< k@13@10 (length ($Snap.first $t@12@10) this@3@10))))
      (and (<= 0 k@13@10) (< k@13@10 (length ($Snap.first $t@12@10) this@3@10)))))
  :pattern ((itemAt%limited ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@111@15@111@122-aux|)))
(assert (forall ((k@13@10 Int)) (!
  (=>
    (and (<= 0 k@13@10) (< k@13@10 (length ($Snap.first $t@12@10) this@3@10)))
    (=
      (itemAt ($Snap.combine
        ($Snap.first $t@12@10)
        ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10)
      (itemAt ($Snap.combine $t@6@10 ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10)))
  :pattern ((itemAt%limited ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@111@15@111@122|)))
(pop) ; 3
(push) ; 3
; Loop head block: Establish invariant
; [eval] 0 <= j
; [eval] j <= length(this)
; [eval] length(this)
(push) ; 4
(assert (length%precondition $t@6@10 this@3@10))
(pop) ; 4
; Joined path conditions
(assert (length%precondition $t@6@10 this@3@10))
(push) ; 4
(assert (not (<= 0 (length $t@6@10 this@3@10))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 (length $t@6@10 this@3@10)))
; [eval] j > 0 ==> itemAt(this, j - 1) <= elem
; [eval] j > 0
(push) ; 4
; [then-branch: 7 | False | dead]
; [else-branch: 7 | True | live]
(push) ; 5
; [else-branch: 7 | True]
(pop) ; 5
(pop) ; 4
; Joined path conditions
; [eval] length(this) == old(length(this))
; [eval] length(this)
(push) ; 4
(pop) ; 4
; Joined path conditions
; [eval] old(length(this))
; [eval] length(this)
(push) ; 4
(pop) ; 4
; Joined path conditions
; [eval] (forall k: Int :: { old(itemAt(this, k)) } 0 <= k && k < length(this) ==> itemAt(this, k) == old(itemAt(this, k)))
(declare-const k@14@10 Int)
(push) ; 4
; [eval] 0 <= k && k < length(this) ==> itemAt(this, k) == old(itemAt(this, k))
; [eval] 0 <= k && k < length(this)
; [eval] 0 <= k
(push) ; 5
; [then-branch: 8 | !(0 <= k@14@10) | live]
; [else-branch: 8 | 0 <= k@14@10 | live]
(push) ; 6
; [then-branch: 8 | !(0 <= k@14@10)]
(assert (not (<= 0 k@14@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 8 | 0 <= k@14@10]
(assert (<= 0 k@14@10))
; [eval] k < length(this)
; [eval] length(this)
(push) ; 7
(pop) ; 7
; Joined path conditions
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 k@14@10) (not (<= 0 k@14@10))))
(push) ; 5
; [then-branch: 9 | 0 <= k@14@10 && k@14@10 < length($t@6@10, this@3@10) | live]
; [else-branch: 9 | !(0 <= k@14@10 && k@14@10 < length($t@6@10, this@3@10)) | live]
(push) ; 6
; [then-branch: 9 | 0 <= k@14@10 && k@14@10 < length($t@6@10, this@3@10)]
(assert (and (<= 0 k@14@10) (< k@14@10 (length $t@6@10 this@3@10))))
; [eval] itemAt(this, k) == old(itemAt(this, k))
; [eval] itemAt(this, k)
(push) ; 7
; [eval] 0 <= index
; [eval] index < length(this)
; [eval] length(this)
(push) ; 8
(pop) ; 8
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  $t@6@10
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@14@10))
(pop) ; 7
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  $t@6@10
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@14@10))
; [eval] old(itemAt(this, k))
; [eval] itemAt(this, k)
(push) ; 7
; [eval] 0 <= index
; [eval] index < length(this)
; [eval] length(this)
(push) ; 8
(pop) ; 8
; Joined path conditions
(pop) ; 7
; Joined path conditions
(pop) ; 6
(push) ; 6
; [else-branch: 9 | !(0 <= k@14@10 && k@14@10 < length($t@6@10, this@3@10))]
(assert (not (and (<= 0 k@14@10) (< k@14@10 (length $t@6@10 this@3@10)))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
(assert (=>
  (and (<= 0 k@14@10) (< k@14@10 (length $t@6@10 this@3@10)))
  (and
    (<= 0 k@14@10)
    (< k@14@10 (length $t@6@10 this@3@10))
    (itemAt%precondition ($Snap.combine
      $t@6@10
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@14@10))))
; Joined path conditions
(assert (or
  (not (and (<= 0 k@14@10) (< k@14@10 (length $t@6@10 this@3@10))))
  (and (<= 0 k@14@10) (< k@14@10 (length $t@6@10 this@3@10)))))
; [eval] old(itemAt(this, k))
; [eval] itemAt(this, k)
(push) ; 5
; [eval] 0 <= index
(push) ; 6
(assert (not (<= 0 k@14@10)))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] 0 <= index
(set-option :timeout 0)
(push) ; 6
(assert (not (<= 0 k@14@10)))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] 0 <= index
(set-option :timeout 0)
(push) ; 6
(assert (not (<= 0 k@14@10)))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] 0 <= index
(set-option :timeout 0)
(push) ; 6
(assert (not (<= 0 k@14@10)))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(pop) ; 4
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((k@14@10 Int)) (!
  (and
    (or (<= 0 k@14@10) (not (<= 0 k@14@10)))
    (=>
      (and (<= 0 k@14@10) (< k@14@10 (length $t@6@10 this@3@10)))
      (and
        (<= 0 k@14@10)
        (< k@14@10 (length $t@6@10 this@3@10))
        (itemAt%precondition ($Snap.combine
          $t@6@10
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@14@10)))
    (or
      (not (and (<= 0 k@14@10) (< k@14@10 (length $t@6@10 this@3@10))))
      (and (<= 0 k@14@10) (< k@14@10 (length $t@6@10 this@3@10)))))
  
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@111@15@111@122-aux|)))
; Loop head block: Execute statements of loop head block (in invariant state)
(push) ; 4
(assert (= $t@12@10 ($Snap.combine ($Snap.first $t@12@10) ($Snap.second $t@12@10))))
(assert (=
  ($Snap.second $t@12@10)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@12@10))
    ($Snap.second ($Snap.second $t@12@10)))))
(assert (= ($Snap.first ($Snap.second $t@12@10)) $Snap.unit))
(assert (<= 0 j@11@10))
(assert (=
  ($Snap.second ($Snap.second $t@12@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@12@10)))
    ($Snap.second ($Snap.second ($Snap.second $t@12@10))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@12@10))) $Snap.unit))
(assert (length%precondition ($Snap.first $t@12@10) this@3@10))
(assert (<= j@11@10 (length ($Snap.first $t@12@10) this@3@10)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@12@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@12@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@12@10))))
  $Snap.unit))
(assert (=>
  (> j@11@10 0)
  (and
    (> j@11@10 0)
    (<= 0 (- j@11@10 1))
    (< (- j@11@10 1) (length ($Snap.first $t@12@10) this@3@10))
    (itemAt%precondition ($Snap.combine
      ($Snap.first $t@12@10)
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- j@11@10 1)))))
(assert (or (not (> j@11@10 0)) (> j@11@10 0)))
(assert (=>
  (> j@11@10 0)
  (<=
    (itemAt ($Snap.combine
      ($Snap.first $t@12@10)
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- j@11@10 1))
    elem@4@10)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))
  $Snap.unit))
(assert (= (length ($Snap.first $t@12@10) this@3@10) (length $t@6@10 this@3@10)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@12@10)))))
  $Snap.unit))
(assert (forall ((k@13@10 Int)) (!
  (and
    (or (<= 0 k@13@10) (not (<= 0 k@13@10)))
    (=>
      (and (<= 0 k@13@10) (< k@13@10 (length ($Snap.first $t@12@10) this@3@10)))
      (and
        (<= 0 k@13@10)
        (< k@13@10 (length ($Snap.first $t@12@10) this@3@10))
        (itemAt%precondition ($Snap.combine
          ($Snap.first $t@12@10)
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10)
        (< k@13@10 (length $t@6@10 this@3@10))
        (itemAt%precondition ($Snap.combine
          $t@6@10
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10)))
    (or
      (not
        (and
          (<= 0 k@13@10)
          (< k@13@10 (length ($Snap.first $t@12@10) this@3@10))))
      (and (<= 0 k@13@10) (< k@13@10 (length ($Snap.first $t@12@10) this@3@10)))))
  :pattern ((itemAt%limited ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@111@15@111@122-aux|)))
(assert (forall ((k@13@10 Int)) (!
  (=>
    (and (<= 0 k@13@10) (< k@13@10 (length ($Snap.first $t@12@10) this@3@10)))
    (=
      (itemAt ($Snap.combine
        ($Snap.first $t@12@10)
        ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10)
      (itemAt ($Snap.combine $t@6@10 ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10)))
  :pattern ((itemAt%limited ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@13@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@111@15@111@122|)))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
(set-option :timeout 10)
(check-sat)
; unknown
; Loop head block: Check well-definedness of edge conditions
(set-option :timeout 0)
(push) ; 5
; [eval] j < length(this) && itemAt(this, j) < elem
; [eval] j < length(this)
; [eval] length(this)
(push) ; 6
(pop) ; 6
; Joined path conditions
(push) ; 6
; [then-branch: 10 | !(j@11@10 < length(First:($t@12@10), this@3@10)) | live]
; [else-branch: 10 | j@11@10 < length(First:($t@12@10), this@3@10) | live]
(push) ; 7
; [then-branch: 10 | !(j@11@10 < length(First:($t@12@10), this@3@10))]
(assert (not (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))))
(pop) ; 7
(push) ; 7
; [else-branch: 10 | j@11@10 < length(First:($t@12@10), this@3@10)]
(assert (< j@11@10 (length ($Snap.first $t@12@10) this@3@10)))
; [eval] itemAt(this, j) < elem
; [eval] itemAt(this, j)
(push) ; 8
; [eval] 0 <= index
; [eval] index < length(this)
; [eval] length(this)
(push) ; 9
(pop) ; 9
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  ($Snap.first $t@12@10)
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10))
(pop) ; 8
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  ($Snap.first $t@12@10)
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (=>
  (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
  (and
    (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
    (itemAt%precondition ($Snap.combine
      ($Snap.first $t@12@10)
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10))))
(assert (or
  (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
  (not (< j@11@10 (length ($Snap.first $t@12@10) this@3@10)))))
(pop) ; 5
(push) ; 5
; [eval] !(j < length(this) && itemAt(this, j) < elem)
; [eval] j < length(this) && itemAt(this, j) < elem
; [eval] j < length(this)
; [eval] length(this)
(push) ; 6
(pop) ; 6
; Joined path conditions
(push) ; 6
; [then-branch: 11 | !(j@11@10 < length(First:($t@12@10), this@3@10)) | live]
; [else-branch: 11 | j@11@10 < length(First:($t@12@10), this@3@10) | live]
(push) ; 7
; [then-branch: 11 | !(j@11@10 < length(First:($t@12@10), this@3@10))]
(assert (not (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))))
(pop) ; 7
(push) ; 7
; [else-branch: 11 | j@11@10 < length(First:($t@12@10), this@3@10)]
(assert (< j@11@10 (length ($Snap.first $t@12@10) this@3@10)))
; [eval] itemAt(this, j) < elem
; [eval] itemAt(this, j)
(push) ; 8
; [eval] 0 <= index
; [eval] index < length(this)
; [eval] length(this)
(push) ; 9
(pop) ; 9
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  ($Snap.first $t@12@10)
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10))
(pop) ; 8
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  ($Snap.first $t@12@10)
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (=>
  (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
  (and
    (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
    (itemAt%precondition ($Snap.combine
      ($Snap.first $t@12@10)
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10))))
(assert (or
  (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
  (not (< j@11@10 (length ($Snap.first $t@12@10) this@3@10)))))
(pop) ; 5
; Loop head block: Follow loop-internal edges
; [eval] j < length(this) && itemAt(this, j) < elem
; [eval] j < length(this)
; [eval] length(this)
(push) ; 5
(pop) ; 5
; Joined path conditions
(push) ; 5
; [then-branch: 12 | !(j@11@10 < length(First:($t@12@10), this@3@10)) | live]
; [else-branch: 12 | j@11@10 < length(First:($t@12@10), this@3@10) | live]
(push) ; 6
; [then-branch: 12 | !(j@11@10 < length(First:($t@12@10), this@3@10))]
(assert (not (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))))
(pop) ; 6
(push) ; 6
; [else-branch: 12 | j@11@10 < length(First:($t@12@10), this@3@10)]
(assert (< j@11@10 (length ($Snap.first $t@12@10) this@3@10)))
; [eval] itemAt(this, j) < elem
; [eval] itemAt(this, j)
(push) ; 7
; [eval] 0 <= index
; [eval] index < length(this)
; [eval] length(this)
(push) ; 8
(pop) ; 8
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  ($Snap.first $t@12@10)
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10))
(pop) ; 7
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  ($Snap.first $t@12@10)
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (=>
  (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
  (and
    (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
    (itemAt%precondition ($Snap.combine
      ($Snap.first $t@12@10)
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10))))
(assert (or
  (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
  (not (< j@11@10 (length ($Snap.first $t@12@10) this@3@10)))))
(push) ; 5
(set-option :timeout 10)
(assert (not (not
  (and
    (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
    (<
      (itemAt ($Snap.combine
        ($Snap.first $t@12@10)
        ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10)
      elem@4@10)))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 10)
(assert (not (and
  (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
  (<
    (itemAt ($Snap.combine
      ($Snap.first $t@12@10)
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10)
    elem@4@10))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [then-branch: 13 | j@11@10 < length(First:($t@12@10), this@3@10) && itemAt((First:($t@12@10), (_, _)), this@3@10, j@11@10) < elem@4@10 | live]
; [else-branch: 13 | !(j@11@10 < length(First:($t@12@10), this@3@10) && itemAt((First:($t@12@10), (_, _)), this@3@10, j@11@10) < elem@4@10) | live]
(set-option :timeout 0)
(push) ; 5
; [then-branch: 13 | j@11@10 < length(First:($t@12@10), this@3@10) && itemAt((First:($t@12@10), (_, _)), this@3@10, j@11@10) < elem@4@10]
(assert (and
  (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
  (<
    (itemAt ($Snap.combine
      ($Snap.first $t@12@10)
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10)
    elem@4@10)))
; [exec]
; unfold acc(AList(this), write)
(assert (=
  ($Snap.first $t@12@10)
  ($Snap.combine
    ($Snap.first ($Snap.first $t@12@10))
    ($Snap.second ($Snap.first $t@12@10)))))
(assert (not (= this@3@10 $Ref.null)))
(assert (=
  ($Snap.second ($Snap.first $t@12@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
    ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.first $t@12@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first $t@12@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10)))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second ($Snap.first $t@12@10)))) $Snap.unit))
; [eval] 0 <= this.size
(assert (<=
  0
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10)))))
  $Snap.unit))
; [eval] this.size <= len(this.elems)
; [eval] len(this.elems)
(assert (<=
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))
  (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))
  $Snap.unit))
; [eval] 0 < len(this.elems)
; [eval] len(this.elems)
(assert (<
  0
  (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
(declare-const i@15@10 Int)
(push) ; 6
; [eval] 0 <= i && i < len(this.elems)
; [eval] 0 <= i
(push) ; 7
; [then-branch: 14 | !(0 <= i@15@10) | live]
; [else-branch: 14 | 0 <= i@15@10 | live]
(push) ; 8
; [then-branch: 14 | !(0 <= i@15@10)]
(assert (not (<= 0 i@15@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 14 | 0 <= i@15@10]
(assert (<= 0 i@15@10))
; [eval] i < len(this.elems)
; [eval] len(this.elems)
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@15@10) (not (<= 0 i@15@10))))
(assert (and
  (<= 0 i@15@10)
  (<
    i@15@10
    (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
; [eval] loc(this.elems, i)
(pop) ; 6
(declare-fun inv@16@10 ($Ref) Int)
(declare-fun img@17@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@15@10 Int)) (!
  (=>
    (and
      (<= 0 i@15@10)
      (<
        i@15@10
        (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
    (or (<= 0 i@15@10) (not (<= 0 i@15@10))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@15@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 6
(assert (not (forall ((i1@15@10 Int) (i2@15@10 Int)) (!
  (=>
    (and
      (and
        (<= 0 i1@15@10)
        (<
          i1@15@10
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
      (and
        (<= 0 i2@15@10)
        (<
          i2@15@10
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
      (=
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i1@15@10)
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i2@15@10)))
    (= i1@15@10 i2@15@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@15@10 Int)) (!
  (=>
    (and
      (<= 0 i@15@10)
      (<
        i@15@10
        (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
    (and
      (=
        (inv@16@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@15@10))
        i@15@10)
      (img@17@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@15@10))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@15@10))
  :qid |quant-u-36|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@17@10 r)
      (and
        (<= 0 (inv@16@10 r))
        (<
          (inv@16@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
    (=
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) (inv@16@10 r))
      r))
  :pattern ((inv@16@10 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@15@10 Int)) (!
  (=>
    (and
      (<= 0 i@15@10)
      (<
        i@15@10
        (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
    (not
      (=
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@15@10)
        $Ref.null)))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@15@10))
  :qid |val-permImpliesNonNull|)))
(declare-const sm@18@10 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@17@10 r)
      (and
        (<= 0 (inv@16@10 r))
        (<
          (inv@16@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
    (=
      ($FVF.lookup_val (as sm@18@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
  :pattern (($FVF.lookup_val (as sm@18@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
  :qid |qp.fvfValDef0|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
  :pattern (($FVF.lookup_val (as sm@18@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef1|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (<= 0 (inv@16@10 r))
      (<
        (inv@16@10 r)
        (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
    ($FVF.loc_val ($FVF.lookup_val (as sm@18@10  $FVF<val>) r) r))
  :pattern ((inv@16@10 r))
  :qid |quant-u-38|)))
; State saturation: after unfold
(set-option :timeout 40)
(check-sat)
; unknown
(assert (AList%trigger ($Snap.first $t@12@10) this@3@10))
; [exec]
; j := j + 1
; [eval] j + 1
(declare-const j@19@10 Int)
(assert (= j@19@10 (+ j@11@10 1)))
; [exec]
; fold acc(AList(this), write)
; [eval] 0 <= this.size
; [eval] this.size <= len(this.elems)
; [eval] len(this.elems)
; [eval] 0 < len(this.elems)
; [eval] len(this.elems)
(declare-const i@20@10 Int)
(set-option :timeout 0)
(push) ; 6
; [eval] 0 <= i && i < len(this.elems)
; [eval] 0 <= i
(push) ; 7
; [then-branch: 15 | !(0 <= i@20@10) | live]
; [else-branch: 15 | 0 <= i@20@10 | live]
(push) ; 8
; [then-branch: 15 | !(0 <= i@20@10)]
(assert (not (<= 0 i@20@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 15 | 0 <= i@20@10]
(assert (<= 0 i@20@10))
; [eval] i < len(this.elems)
; [eval] len(this.elems)
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@20@10) (not (<= 0 i@20@10))))
(assert (and
  (<= 0 i@20@10)
  (<
    i@20@10
    (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
; [eval] loc(this.elems, i)
(pop) ; 6
(declare-fun inv@21@10 ($Ref) Int)
(declare-fun img@22@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@20@10 Int)) (!
  (=>
    (and
      (<= 0 i@20@10)
      (<
        i@20@10
        (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
    (or (<= 0 i@20@10) (not (<= 0 i@20@10))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@20@10))
  :qid |val-aux|)))
; Definitional axioms for snapshot map domain
; Definitional axioms for snapshot map values
; Check receiver injectivity
(push) ; 6
(assert (not (forall ((i1@20@10 Int) (i2@20@10 Int)) (!
  (=>
    (and
      (and
        (and
          (<= 0 i1@20@10)
          (<
            i1@20@10
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
        ($FVF.loc_val ($FVF.lookup_val (as sm@18@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i1@20@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i1@20@10)))
      (and
        (and
          (<= 0 i2@20@10)
          (<
            i2@20@10
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
        ($FVF.loc_val ($FVF.lookup_val (as sm@18@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i2@20@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i2@20@10)))
      (=
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i1@20@10)
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i2@20@10)))
    (= i1@20@10 i2@20@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@20@10 Int)) (!
  (=>
    (and
      (<= 0 i@20@10)
      (<
        i@20@10
        (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
    (and
      (=
        (inv@21@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@20@10))
        i@20@10)
      (img@22@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@20@10))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@20@10))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@22@10 r)
      (and
        (<= 0 (inv@21@10 r))
        (<
          (inv@21@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
    (=
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) (inv@21@10 r))
      r))
  :pattern ((inv@21@10 r))
  :qid |val-fctOfInv|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (<= 0 (inv@21@10 r))
      (<
        (inv@21@10 r)
        (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
    ($FVF.loc_val ($FVF.lookup_val (as sm@18@10  $FVF<val>) r) r))
  :pattern ((inv@21@10 r))
  :qid |quant-u-44|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@23@10 ((r $Ref)) $Perm
  (ite
    (and
      (and
        (<= 0 (inv@21@10 r))
        (<
          (inv@21@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
      (img@22@10 r)
      (=
        r
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) (inv@21@10 r))))
    ($Perm.min
      (ite
        (and
          (img@17@10 r)
          (and
            (<= 0 (inv@16@10 r))
            (<
              (inv@16@10 r)
              (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
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
          (img@17@10 r)
          (and
            (<= 0 (inv@16@10 r))
            (<
              (inv@16@10 r)
              (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
        $Perm.Write
        $Perm.No)
      (pTaken@23@10 r))
    $Perm.No)
  
  :qid |quant-u-47|))))
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
      (and
        (<= 0 (inv@21@10 r))
        (<
          (inv@21@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
      (img@22@10 r)
      (=
        r
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) (inv@21@10 r))))
    (= (- $Perm.Write (pTaken@23@10 r)) $Perm.No))
  
  :qid |quant-u-48|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@24@10 $FVF<val>)
; Definitional axioms for snapshot map domain
(assert (forall ((r $Ref)) (!
  (and
    (=>
      (Set_in r ($FVF.domain_val (as sm@24@10  $FVF<val>)))
      (and
        (and
          (<= 0 (inv@21@10 r))
          (<
            (inv@21@10 r)
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
        (img@22@10 r)))
    (=>
      (and
        (and
          (<= 0 (inv@21@10 r))
          (<
            (inv@21@10 r)
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
        (img@22@10 r))
      (Set_in r ($FVF.domain_val (as sm@24@10  $FVF<val>)))))
  :pattern ((Set_in r ($FVF.domain_val (as sm@24@10  $FVF<val>))))
  :qid |qp.fvfDomDef4|)))
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (and
        (and
          (<= 0 (inv@21@10 r))
          (<
            (inv@21@10 r)
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
        (img@22@10 r))
      (and
        (img@17@10 r)
        (and
          (<= 0 (inv@16@10 r))
          (<
            (inv@16@10 r)
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))))
    (=
      ($FVF.lookup_val (as sm@24@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
  :pattern (($FVF.lookup_val (as sm@24@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
  :qid |qp.fvfValDef2|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
  :pattern (($FVF.lookup_val (as sm@24@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef3|)))
(assert (AList%trigger ($Snap.combine
  ($Snap.first ($Snap.first $t@12@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
    ($Snap.combine
      $Snap.unit
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10))
; Loop head block: Re-establish invariant
; [eval] 0 <= j
(set-option :timeout 0)
(push) ; 6
(assert (not (<= 0 j@19@10)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 j@19@10))
; [eval] j <= length(this)
; [eval] length(this)
(push) ; 6
(assert (length%precondition ($Snap.combine
  ($Snap.first ($Snap.first $t@12@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
    ($Snap.combine
      $Snap.unit
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10))
(pop) ; 6
; Joined path conditions
(assert (length%precondition ($Snap.combine
  ($Snap.first ($Snap.first $t@12@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
    ($Snap.combine
      $Snap.unit
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10))
(push) ; 6
(assert (not (<=
  j@19@10
  (length ($Snap.combine
    ($Snap.first ($Snap.first $t@12@10))
    ($Snap.combine
      ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($Snap.combine
            $Snap.unit
            ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (<=
  j@19@10
  (length ($Snap.combine
    ($Snap.first ($Snap.first $t@12@10))
    ($Snap.combine
      ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($Snap.combine
            $Snap.unit
            ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10)))
; [eval] j > 0 ==> itemAt(this, j - 1) <= elem
; [eval] j > 0
(push) ; 6
(push) ; 7
(set-option :timeout 10)
(assert (not (not (> j@19@10 0))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (> j@19@10 0)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [then-branch: 16 | j@19@10 > 0 | live]
; [else-branch: 16 | !(j@19@10 > 0) | dead]
(set-option :timeout 0)
(push) ; 7
; [then-branch: 16 | j@19@10 > 0]
(assert (> j@19@10 0))
; [eval] itemAt(this, j - 1) <= elem
; [eval] itemAt(this, j - 1)
; [eval] j - 1
(push) ; 8
; [eval] 0 <= index
(push) ; 9
(assert (not (<= 0 (- j@19@10 1))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 (- j@19@10 1)))
; [eval] index < length(this)
; [eval] length(this)
(push) ; 9
(pop) ; 9
; Joined path conditions
(push) ; 9
(assert (not (<
  (- j@19@10 1)
  (length ($Snap.combine
    ($Snap.first ($Snap.first $t@12@10))
    ($Snap.combine
      ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($Snap.combine
            $Snap.unit
            ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10))))
(check-sat)
; unsat
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(assert (<
  (- j@19@10 1)
  (length ($Snap.combine
    ($Snap.first ($Snap.first $t@12@10))
    ($Snap.combine
      ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($Snap.combine
            $Snap.unit
            ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10)))
(assert (itemAt%precondition ($Snap.combine
  ($Snap.combine
    ($Snap.first ($Snap.first $t@12@10))
    ($Snap.combine
      ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($Snap.combine
            $Snap.unit
            ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>)))))))
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- j@19@10 1)))
(pop) ; 8
; Joined path conditions
(assert (and
  (<= 0 (- j@19@10 1))
  (<
    (- j@19@10 1)
    (length ($Snap.combine
      ($Snap.first ($Snap.first $t@12@10))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
        ($Snap.combine
          $Snap.unit
          ($Snap.combine
            $Snap.unit
            ($Snap.combine
              $Snap.unit
              ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10))
  (itemAt%precondition ($Snap.combine
    ($Snap.combine
      ($Snap.first ($Snap.first $t@12@10))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
        ($Snap.combine
          $Snap.unit
          ($Snap.combine
            $Snap.unit
            ($Snap.combine
              $Snap.unit
              ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>)))))))
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- j@19@10 1))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (=>
  (> j@19@10 0)
  (and
    (> j@19@10 0)
    (<= 0 (- j@19@10 1))
    (<
      (- j@19@10 1)
      (length ($Snap.combine
        ($Snap.first ($Snap.first $t@12@10))
        ($Snap.combine
          ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
          ($Snap.combine
            $Snap.unit
            ($Snap.combine
              $Snap.unit
              ($Snap.combine
                $Snap.unit
                ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10))
    (itemAt%precondition ($Snap.combine
      ($Snap.combine
        ($Snap.first ($Snap.first $t@12@10))
        ($Snap.combine
          ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
          ($Snap.combine
            $Snap.unit
            ($Snap.combine
              $Snap.unit
              ($Snap.combine
                $Snap.unit
                ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>)))))))
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- j@19@10 1)))))
(assert (> j@19@10 0))
(push) ; 6
(assert (not (=>
  (> j@19@10 0)
  (<=
    (itemAt ($Snap.combine
      ($Snap.combine
        ($Snap.first ($Snap.first $t@12@10))
        ($Snap.combine
          ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
          ($Snap.combine
            $Snap.unit
            ($Snap.combine
              $Snap.unit
              ($Snap.combine
                $Snap.unit
                ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>)))))))
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- j@19@10 1))
    elem@4@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (=>
  (> j@19@10 0)
  (<=
    (itemAt ($Snap.combine
      ($Snap.combine
        ($Snap.first ($Snap.first $t@12@10))
        ($Snap.combine
          ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
          ($Snap.combine
            $Snap.unit
            ($Snap.combine
              $Snap.unit
              ($Snap.combine
                $Snap.unit
                ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>)))))))
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- j@19@10 1))
    elem@4@10)))
; [eval] length(this) == old(length(this))
; [eval] length(this)
(push) ; 6
(pop) ; 6
; Joined path conditions
; [eval] old(length(this))
; [eval] length(this)
(push) ; 6
(pop) ; 6
; Joined path conditions
(push) ; 6
(assert (not (=
  (length ($Snap.combine
    ($Snap.first ($Snap.first $t@12@10))
    ($Snap.combine
      ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($Snap.combine
            $Snap.unit
            ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10)
  (length $t@6@10 this@3@10))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (=
  (length ($Snap.combine
    ($Snap.first ($Snap.first $t@12@10))
    ($Snap.combine
      ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($Snap.combine
            $Snap.unit
            ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10)
  (length $t@6@10 this@3@10)))
; [eval] (forall k: Int :: { old(itemAt(this, k)) } 0 <= k && k < length(this) ==> itemAt(this, k) == old(itemAt(this, k)))
(declare-const k@25@10 Int)
(push) ; 6
; [eval] 0 <= k && k < length(this) ==> itemAt(this, k) == old(itemAt(this, k))
; [eval] 0 <= k && k < length(this)
; [eval] 0 <= k
(push) ; 7
; [then-branch: 17 | !(0 <= k@25@10) | live]
; [else-branch: 17 | 0 <= k@25@10 | live]
(push) ; 8
; [then-branch: 17 | !(0 <= k@25@10)]
(assert (not (<= 0 k@25@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 17 | 0 <= k@25@10]
(assert (<= 0 k@25@10))
; [eval] k < length(this)
; [eval] length(this)
(push) ; 9
(pop) ; 9
; Joined path conditions
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 k@25@10) (not (<= 0 k@25@10))))
(push) ; 7
; [then-branch: 18 | 0 <= k@25@10 && k@25@10 < length((First:(First:($t@12@10)), (First:(Second:(First:($t@12@10))), (_, (_, (_, sm@24@10))))), this@3@10) | live]
; [else-branch: 18 | !(0 <= k@25@10 && k@25@10 < length((First:(First:($t@12@10)), (First:(Second:(First:($t@12@10))), (_, (_, (_, sm@24@10))))), this@3@10)) | live]
(push) ; 8
; [then-branch: 18 | 0 <= k@25@10 && k@25@10 < length((First:(First:($t@12@10)), (First:(Second:(First:($t@12@10))), (_, (_, (_, sm@24@10))))), this@3@10)]
(assert (and
  (<= 0 k@25@10)
  (<
    k@25@10
    (length ($Snap.combine
      ($Snap.first ($Snap.first $t@12@10))
      ($Snap.combine
        ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
        ($Snap.combine
          $Snap.unit
          ($Snap.combine
            $Snap.unit
            ($Snap.combine
              $Snap.unit
              ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10))))
; [eval] itemAt(this, k) == old(itemAt(this, k))
; [eval] itemAt(this, k)
(push) ; 9
; [eval] 0 <= index
; [eval] index < length(this)
; [eval] length(this)
(push) ; 10
(pop) ; 10
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  ($Snap.combine
    ($Snap.first ($Snap.first $t@12@10))
    ($Snap.combine
      ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($Snap.combine
            $Snap.unit
            ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>)))))))
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10))
(pop) ; 9
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  ($Snap.combine
    ($Snap.first ($Snap.first $t@12@10))
    ($Snap.combine
      ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($Snap.combine
            $Snap.unit
            ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>)))))))
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10))
; [eval] old(itemAt(this, k))
; [eval] itemAt(this, k)
(push) ; 9
; [eval] 0 <= index
; [eval] index < length(this)
; [eval] length(this)
(push) ; 10
(pop) ; 10
; Joined path conditions
(push) ; 10
(assert (not (< k@25@10 (length $t@6@10 this@3@10))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(assert (< k@25@10 (length $t@6@10 this@3@10)))
(assert (itemAt%precondition ($Snap.combine
  $t@6@10
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10))
(pop) ; 9
; Joined path conditions
(assert (and
  (< k@25@10 (length $t@6@10 this@3@10))
  (itemAt%precondition ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 18 | !(0 <= k@25@10 && k@25@10 < length((First:(First:($t@12@10)), (First:(Second:(First:($t@12@10))), (_, (_, (_, sm@24@10))))), this@3@10))]
(assert (not
  (and
    (<= 0 k@25@10)
    (<
      k@25@10
      (length ($Snap.combine
        ($Snap.first ($Snap.first $t@12@10))
        ($Snap.combine
          ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
          ($Snap.combine
            $Snap.unit
            ($Snap.combine
              $Snap.unit
              ($Snap.combine
                $Snap.unit
                ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10)))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
(assert (=>
  (and
    (<= 0 k@25@10)
    (<
      k@25@10
      (length ($Snap.combine
        ($Snap.first ($Snap.first $t@12@10))
        ($Snap.combine
          ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
          ($Snap.combine
            $Snap.unit
            ($Snap.combine
              $Snap.unit
              ($Snap.combine
                $Snap.unit
                ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10)))
  (and
    (<= 0 k@25@10)
    (<
      k@25@10
      (length ($Snap.combine
        ($Snap.first ($Snap.first $t@12@10))
        ($Snap.combine
          ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
          ($Snap.combine
            $Snap.unit
            ($Snap.combine
              $Snap.unit
              ($Snap.combine
                $Snap.unit
                ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10))
    (itemAt%precondition ($Snap.combine
      ($Snap.combine
        ($Snap.first ($Snap.first $t@12@10))
        ($Snap.combine
          ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
          ($Snap.combine
            $Snap.unit
            ($Snap.combine
              $Snap.unit
              ($Snap.combine
                $Snap.unit
                ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>)))))))
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10)
    (< k@25@10 (length $t@6@10 this@3@10))
    (itemAt%precondition ($Snap.combine
      $t@6@10
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= 0 k@25@10)
      (<
        k@25@10
        (length ($Snap.combine
          ($Snap.first ($Snap.first $t@12@10))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
            ($Snap.combine
              $Snap.unit
              ($Snap.combine
                $Snap.unit
                ($Snap.combine
                  $Snap.unit
                  ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10))))
  (and
    (<= 0 k@25@10)
    (<
      k@25@10
      (length ($Snap.combine
        ($Snap.first ($Snap.first $t@12@10))
        ($Snap.combine
          ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
          ($Snap.combine
            $Snap.unit
            ($Snap.combine
              $Snap.unit
              ($Snap.combine
                $Snap.unit
                ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10)))))
(pop) ; 6
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((k@25@10 Int)) (!
  (and
    (or (<= 0 k@25@10) (not (<= 0 k@25@10)))
    (=>
      (and
        (<= 0 k@25@10)
        (<
          k@25@10
          (length ($Snap.combine
            ($Snap.first ($Snap.first $t@12@10))
            ($Snap.combine
              ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
              ($Snap.combine
                $Snap.unit
                ($Snap.combine
                  $Snap.unit
                  ($Snap.combine
                    $Snap.unit
                    ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10)))
      (and
        (<= 0 k@25@10)
        (<
          k@25@10
          (length ($Snap.combine
            ($Snap.first ($Snap.first $t@12@10))
            ($Snap.combine
              ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
              ($Snap.combine
                $Snap.unit
                ($Snap.combine
                  $Snap.unit
                  ($Snap.combine
                    $Snap.unit
                    ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10))
        (itemAt%precondition ($Snap.combine
          ($Snap.combine
            ($Snap.first ($Snap.first $t@12@10))
            ($Snap.combine
              ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
              ($Snap.combine
                $Snap.unit
                ($Snap.combine
                  $Snap.unit
                  ($Snap.combine
                    $Snap.unit
                    ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>)))))))
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10)
        (< k@25@10 (length $t@6@10 this@3@10))
        (itemAt%precondition ($Snap.combine
          $t@6@10
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10)))
    (or
      (not
        (and
          (<= 0 k@25@10)
          (<
            k@25@10
            (length ($Snap.combine
              ($Snap.first ($Snap.first $t@12@10))
              ($Snap.combine
                ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
                ($Snap.combine
                  $Snap.unit
                  ($Snap.combine
                    $Snap.unit
                    ($Snap.combine
                      $Snap.unit
                      ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10))))
      (and
        (<= 0 k@25@10)
        (<
          k@25@10
          (length ($Snap.combine
            ($Snap.first ($Snap.first $t@12@10))
            ($Snap.combine
              ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
              ($Snap.combine
                $Snap.unit
                ($Snap.combine
                  $Snap.unit
                  ($Snap.combine
                    $Snap.unit
                    ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10)))))
  :pattern ((itemAt%limited ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@111@15@111@122-aux|)))
(assert (forall ((k@25@10 Int)) (!
  (and
    (=>
      (<= 0 k@25@10)
      (length%precondition ($Snap.combine
        ($Snap.first ($Snap.first $t@12@10))
        ($Snap.combine
          ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
          ($Snap.combine
            $Snap.unit
            ($Snap.combine
              $Snap.unit
              ($Snap.combine
                $Snap.unit
                ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10))
    (=>
      (and
        (<= 0 k@25@10)
        (<
          k@25@10
          (length ($Snap.combine
            ($Snap.first ($Snap.first $t@12@10))
            ($Snap.combine
              ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
              ($Snap.combine
                $Snap.unit
                ($Snap.combine
                  $Snap.unit
                  ($Snap.combine
                    $Snap.unit
                    ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10)))
      (and
        (itemAt%precondition ($Snap.combine
          ($Snap.combine
            ($Snap.first ($Snap.first $t@12@10))
            ($Snap.combine
              ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
              ($Snap.combine
                $Snap.unit
                ($Snap.combine
                  $Snap.unit
                  ($Snap.combine
                    $Snap.unit
                    ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>)))))))
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10)
        (itemAt%precondition ($Snap.combine
          $t@6@10
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10))))
  :pattern ((itemAt%limited ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@111@15@111@122_precondition|)))
(push) ; 6
(assert (not (forall ((k@25@10 Int)) (!
  (=>
    (and
      (and
        (=>
          (<= 0 k@25@10)
          (length%precondition ($Snap.combine
            ($Snap.first ($Snap.first $t@12@10))
            ($Snap.combine
              ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
              ($Snap.combine
                $Snap.unit
                ($Snap.combine
                  $Snap.unit
                  ($Snap.combine
                    $Snap.unit
                    ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10))
        (=>
          (and
            (<= 0 k@25@10)
            (<
              k@25@10
              (length ($Snap.combine
                ($Snap.first ($Snap.first $t@12@10))
                ($Snap.combine
                  ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
                  ($Snap.combine
                    $Snap.unit
                    ($Snap.combine
                      $Snap.unit
                      ($Snap.combine
                        $Snap.unit
                        ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10)))
          (and
            (itemAt%precondition ($Snap.combine
              ($Snap.combine
                ($Snap.first ($Snap.first $t@12@10))
                ($Snap.combine
                  ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
                  ($Snap.combine
                    $Snap.unit
                    ($Snap.combine
                      $Snap.unit
                      ($Snap.combine
                        $Snap.unit
                        ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>)))))))
              ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10)
            (itemAt%precondition ($Snap.combine
              $t@6@10
              ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10))))
      (and
        (<= 0 k@25@10)
        (<
          k@25@10
          (length ($Snap.combine
            ($Snap.first ($Snap.first $t@12@10))
            ($Snap.combine
              ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
              ($Snap.combine
                $Snap.unit
                ($Snap.combine
                  $Snap.unit
                  ($Snap.combine
                    $Snap.unit
                    ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10))))
    (=
      (itemAt ($Snap.combine
        ($Snap.combine
          ($Snap.first ($Snap.first $t@12@10))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
            ($Snap.combine
              $Snap.unit
              ($Snap.combine
                $Snap.unit
                ($Snap.combine
                  $Snap.unit
                  ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>)))))))
        ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10)
      (itemAt ($Snap.combine $t@6@10 ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10)))
  :pattern ((itemAt%limited ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@111@15@111@122|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(assert (forall ((k@25@10 Int)) (!
  (=>
    (and
      (<= 0 k@25@10)
      (<
        k@25@10
        (length ($Snap.combine
          ($Snap.first ($Snap.first $t@12@10))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
            ($Snap.combine
              $Snap.unit
              ($Snap.combine
                $Snap.unit
                ($Snap.combine
                  $Snap.unit
                  ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>))))))) this@3@10)))
    (=
      (itemAt ($Snap.combine
        ($Snap.combine
          ($Snap.first ($Snap.first $t@12@10))
          ($Snap.combine
            ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
            ($Snap.combine
              $Snap.unit
              ($Snap.combine
                $Snap.unit
                ($Snap.combine
                  $Snap.unit
                  ($SortWrappers.$FVF<val>To$Snap (as sm@24@10  $FVF<val>)))))))
        ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10)
      (itemAt ($Snap.combine $t@6@10 ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10)))
  :pattern ((itemAt%limited ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 k@25@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@111@15@111@122|)))
(pop) ; 5
(push) ; 5
; [else-branch: 13 | !(j@11@10 < length(First:($t@12@10), this@3@10) && itemAt((First:($t@12@10), (_, _)), this@3@10, j@11@10) < elem@4@10)]
(assert (not
  (and
    (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
    (<
      (itemAt ($Snap.combine
        ($Snap.first $t@12@10)
        ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10)
      elem@4@10))))
(pop) ; 5
; [eval] !(j < length(this) && itemAt(this, j) < elem)
; [eval] j < length(this) && itemAt(this, j) < elem
; [eval] j < length(this)
; [eval] length(this)
(push) ; 5
(pop) ; 5
; Joined path conditions
(push) ; 5
; [then-branch: 19 | !(j@11@10 < length(First:($t@12@10), this@3@10)) | live]
; [else-branch: 19 | j@11@10 < length(First:($t@12@10), this@3@10) | live]
(push) ; 6
; [then-branch: 19 | !(j@11@10 < length(First:($t@12@10), this@3@10))]
(assert (not (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))))
(pop) ; 6
(push) ; 6
; [else-branch: 19 | j@11@10 < length(First:($t@12@10), this@3@10)]
(assert (< j@11@10 (length ($Snap.first $t@12@10) this@3@10)))
; [eval] itemAt(this, j) < elem
; [eval] itemAt(this, j)
(push) ; 7
; [eval] 0 <= index
; [eval] index < length(this)
; [eval] length(this)
(push) ; 8
(pop) ; 8
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  ($Snap.first $t@12@10)
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10))
(pop) ; 7
; Joined path conditions
(assert (itemAt%precondition ($Snap.combine
  ($Snap.first $t@12@10)
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(push) ; 5
(set-option :timeout 10)
(assert (not (and
  (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
  (<
    (itemAt ($Snap.combine
      ($Snap.first $t@12@10)
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10)
    elem@4@10))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 10)
(assert (not (not
  (and
    (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
    (<
      (itemAt ($Snap.combine
        ($Snap.first $t@12@10)
        ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10)
      elem@4@10)))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; [then-branch: 20 | !(j@11@10 < length(First:($t@12@10), this@3@10) && itemAt((First:($t@12@10), (_, _)), this@3@10, j@11@10) < elem@4@10) | live]
; [else-branch: 20 | j@11@10 < length(First:($t@12@10), this@3@10) && itemAt((First:($t@12@10), (_, _)), this@3@10, j@11@10) < elem@4@10 | live]
(set-option :timeout 0)
(push) ; 5
; [then-branch: 20 | !(j@11@10 < length(First:($t@12@10), this@3@10) && itemAt((First:($t@12@10), (_, _)), this@3@10, j@11@10) < elem@4@10)]
(assert (not
  (and
    (< j@11@10 (length ($Snap.first $t@12@10) this@3@10))
    (<
      (itemAt ($Snap.combine
        ($Snap.first $t@12@10)
        ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 j@11@10)
      elem@4@10))))
; [exec]
; unfold acc(AList(this), write)
(assert (=
  ($Snap.first $t@12@10)
  ($Snap.combine
    ($Snap.first ($Snap.first $t@12@10))
    ($Snap.second ($Snap.first $t@12@10)))))
(assert (not (= this@3@10 $Ref.null)))
(assert (=
  ($Snap.second ($Snap.first $t@12@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.first $t@12@10)))
    ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.first $t@12@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.first $t@12@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10)))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second ($Snap.first $t@12@10)))) $Snap.unit))
; [eval] 0 <= this.size
(assert (<=
  0
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10)))))
  $Snap.unit))
; [eval] this.size <= len(this.elems)
; [eval] len(this.elems)
(assert (<=
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))
  (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))
  $Snap.unit))
; [eval] 0 < len(this.elems)
; [eval] len(this.elems)
(assert (<
  0
  (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
(declare-const i@26@10 Int)
(push) ; 6
; [eval] 0 <= i && i < len(this.elems)
; [eval] 0 <= i
(push) ; 7
; [then-branch: 21 | !(0 <= i@26@10) | live]
; [else-branch: 21 | 0 <= i@26@10 | live]
(push) ; 8
; [then-branch: 21 | !(0 <= i@26@10)]
(assert (not (<= 0 i@26@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 21 | 0 <= i@26@10]
(assert (<= 0 i@26@10))
; [eval] i < len(this.elems)
; [eval] len(this.elems)
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@26@10) (not (<= 0 i@26@10))))
(assert (and
  (<= 0 i@26@10)
  (<
    i@26@10
    (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
; [eval] loc(this.elems, i)
(pop) ; 6
(declare-fun inv@27@10 ($Ref) Int)
(declare-fun img@28@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@26@10 Int)) (!
  (=>
    (and
      (<= 0 i@26@10)
      (<
        i@26@10
        (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
    (or (<= 0 i@26@10) (not (<= 0 i@26@10))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@26@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 6
(assert (not (forall ((i1@26@10 Int) (i2@26@10 Int)) (!
  (=>
    (and
      (and
        (<= 0 i1@26@10)
        (<
          i1@26@10
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
      (and
        (<= 0 i2@26@10)
        (<
          i2@26@10
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
      (=
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i1@26@10)
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i2@26@10)))
    (= i1@26@10 i2@26@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@26@10 Int)) (!
  (=>
    (and
      (<= 0 i@26@10)
      (<
        i@26@10
        (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
    (and
      (=
        (inv@27@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@26@10))
        i@26@10)
      (img@28@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@26@10))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@26@10))
  :qid |quant-u-54|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@10 r)
      (and
        (<= 0 (inv@27@10 r))
        (<
          (inv@27@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
    (=
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) (inv@27@10 r))
      r))
  :pattern ((inv@27@10 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@26@10 Int)) (!
  (=>
    (and
      (<= 0 i@26@10)
      (<
        i@26@10
        (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
    (not
      (=
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@26@10)
        $Ref.null)))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@26@10))
  :qid |val-permImpliesNonNull|)))
(declare-const sm@29@10 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@10 r)
      (and
        (<= 0 (inv@27@10 r))
        (<
          (inv@27@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
    (=
      ($FVF.lookup_val (as sm@29@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
  :pattern (($FVF.lookup_val (as sm@29@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
  :qid |qp.fvfValDef5|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
  :pattern (($FVF.lookup_val (as sm@29@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef6|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (<= 0 (inv@27@10 r))
      (<
        (inv@27@10 r)
        (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
    ($FVF.loc_val ($FVF.lookup_val (as sm@29@10  $FVF<val>) r) r))
  :pattern ((inv@27@10 r))
  :qid |quant-u-56|)))
; State saturation: after unfold
(set-option :timeout 40)
(check-sat)
; unknown
(assert (AList%trigger ($Snap.first $t@12@10) this@3@10))
; [eval] this.size == len(this.elems)
; [eval] len(this.elems)
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 10)
(assert (not (not
  (=
    ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))
    (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 10)
(assert (not (=
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))
  (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [then-branch: 22 | First:(Second:(First:($t@12@10))) == len[Int](First:(First:($t@12@10))) | live]
; [else-branch: 22 | First:(Second:(First:($t@12@10))) != len[Int](First:(First:($t@12@10))) | live]
(set-option :timeout 0)
(push) ; 6
; [then-branch: 22 | First:(Second:(First:($t@12@10))) == len[Int](First:(First:($t@12@10)))]
(assert (=
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))
  (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
; [exec]
; var a: Array
(declare-const a@30@10 Array_)
; [exec]
; inhale len(a) == len(this.elems) * 2 &&
;   (forall i: Int ::0 <= i && i < len(a) ==> acc(loc(a, i).val, write))
(declare-const $t@31@10 $Snap)
(assert (= $t@31@10 ($Snap.combine ($Snap.first $t@31@10) ($Snap.second $t@31@10))))
(assert (= ($Snap.first $t@31@10) $Snap.unit))
; [eval] len(a) == len(this.elems) * 2
; [eval] len(a)
; [eval] len(this.elems) * 2
; [eval] len(this.elems)
(assert (=
  (len<Int> a@30@10)
  (*
    (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))
    2)))
(declare-const i@32@10 Int)
(push) ; 7
; [eval] 0 <= i && i < len(a)
; [eval] 0 <= i
(push) ; 8
; [then-branch: 23 | !(0 <= i@32@10) | live]
; [else-branch: 23 | 0 <= i@32@10 | live]
(push) ; 9
; [then-branch: 23 | !(0 <= i@32@10)]
(assert (not (<= 0 i@32@10)))
(pop) ; 9
(push) ; 9
; [else-branch: 23 | 0 <= i@32@10]
(assert (<= 0 i@32@10))
; [eval] i < len(a)
; [eval] len(a)
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@32@10) (not (<= 0 i@32@10))))
(assert (and (<= 0 i@32@10) (< i@32@10 (len<Int> a@30@10))))
; [eval] loc(a, i)
(pop) ; 7
(declare-fun inv@33@10 ($Ref) Int)
(declare-fun img@34@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@32@10 Int)) (!
  (=>
    (and (<= 0 i@32@10) (< i@32@10 (len<Int> a@30@10)))
    (or (<= 0 i@32@10) (not (<= 0 i@32@10))))
  :pattern ((loc<Ref> a@30@10 i@32@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((i1@32@10 Int) (i2@32@10 Int)) (!
  (=>
    (and
      (and (<= 0 i1@32@10) (< i1@32@10 (len<Int> a@30@10)))
      (and (<= 0 i2@32@10) (< i2@32@10 (len<Int> a@30@10)))
      (= (loc<Ref> a@30@10 i1@32@10) (loc<Ref> a@30@10 i2@32@10)))
    (= i1@32@10 i2@32@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@32@10 Int)) (!
  (=>
    (and (<= 0 i@32@10) (< i@32@10 (len<Int> a@30@10)))
    (and
      (= (inv@33@10 (loc<Ref> a@30@10 i@32@10)) i@32@10)
      (img@34@10 (loc<Ref> a@30@10 i@32@10))))
  :pattern ((loc<Ref> a@30@10 i@32@10))
  :qid |quant-u-63|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@34@10 r)
      (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
    (= (loc<Ref> a@30@10 (inv@33@10 r)) r))
  :pattern ((inv@33@10 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@32@10 Int)) (!
  (=>
    (and (<= 0 i@32@10) (< i@32@10 (len<Int> a@30@10)))
    (not (= (loc<Ref> a@30@10 i@32@10) $Ref.null)))
  :pattern ((loc<Ref> a@30@10 i@32@10))
  :qid |val-permImpliesNonNull|)))
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (=
      (loc<Ref> a@30@10 i@32@10)
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@26@10))
    (=
      (and
        (img@34@10 r)
        (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
      (and
        (img@28@10 r)
        (and
          (<= 0 (inv@27@10 r))
          (<
            (inv@27@10 r)
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))))
  
  :qid |quant-u-64|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(declare-const sm@35@10 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@10 r)
      (and
        (<= 0 (inv@27@10 r))
        (<
          (inv@27@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
  :qid |qp.fvfValDef7|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@34@10 r)
      (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r) r))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef9|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10)))
    ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) r) r))
  :pattern ((inv@33@10 r))
  :qid |quant-u-65|)))
; State saturation: after inhale
(set-option :timeout 20)
(check-sat)
; unknown
; [exec]
; inhale (forall i: Int ::
;     { loc(a, i).val }
;     0 <= i && i < len(this.elems) ==>
;     loc(a, i).val == loc(this.elems, i).val)
(declare-const $t@36@10 $Snap)
(assert (= $t@36@10 $Snap.unit))
; [eval] (forall i: Int :: { loc(a, i).val } 0 <= i && i < len(this.elems) ==> loc(a, i).val == loc(this.elems, i).val)
(declare-const i@37@10 Int)
(set-option :timeout 0)
(push) ; 7
; [eval] 0 <= i && i < len(this.elems) ==> loc(a, i).val == loc(this.elems, i).val
; [eval] 0 <= i && i < len(this.elems)
; [eval] 0 <= i
(push) ; 8
; [then-branch: 24 | !(0 <= i@37@10) | live]
; [else-branch: 24 | 0 <= i@37@10 | live]
(push) ; 9
; [then-branch: 24 | !(0 <= i@37@10)]
(assert (not (<= 0 i@37@10)))
(pop) ; 9
(push) ; 9
; [else-branch: 24 | 0 <= i@37@10]
(assert (<= 0 i@37@10))
; [eval] i < len(this.elems)
; [eval] len(this.elems)
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@37@10) (not (<= 0 i@37@10))))
(push) ; 8
; [then-branch: 25 | 0 <= i@37@10 && i@37@10 < len[Int](First:(First:($t@12@10))) | live]
; [else-branch: 25 | !(0 <= i@37@10 && i@37@10 < len[Int](First:(First:($t@12@10)))) | live]
(push) ; 9
; [then-branch: 25 | 0 <= i@37@10 && i@37@10 < len[Int](First:(First:($t@12@10)))]
(assert (and
  (<= 0 i@37@10)
  (<
    i@37@10
    (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
; [eval] loc(a, i).val == loc(this.elems, i).val
; [eval] loc(a, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@28@10 r)
        (and
          (<= 0 (inv@27@10 r))
          (<
            (inv@27@10 r)
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
      (=
        ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
    :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
    :qid |qp.fvfValDef7|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@34@10 r)
        (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
      (=
        ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r)))
    :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r))
    :qid |qp.fvfValDef8|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
      ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r) r))
    :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
    :qid |qp.fvfResTrgDef9|))))
(assert ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@37@10)) (loc<Ref> a@30@10 i@37@10)))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@28@10 (loc<Ref> a@30@10 i@37@10))
        (and
          (<= 0 (inv@27@10 (loc<Ref> a@30@10 i@37@10)))
          (<
            (inv@27@10 (loc<Ref> a@30@10 i@37@10))
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
      $Perm.Write
      $Perm.No)
    (ite
      (and
        (img@34@10 (loc<Ref> a@30@10 i@37@10))
        (and
          (<= 0 (inv@33@10 (loc<Ref> a@30@10 i@37@10)))
          (< (inv@33@10 (loc<Ref> a@30@10 i@37@10)) (len<Int> a@30@10))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [eval] loc(this.elems, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@28@10 r)
        (and
          (<= 0 (inv@27@10 r))
          (<
            (inv@27@10 r)
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
      (=
        ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
    :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
    :qid |qp.fvfValDef7|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@34@10 r)
        (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
      (=
        ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r)))
    :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r))
    :qid |qp.fvfValDef8|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
      ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r) r))
    :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
    :qid |qp.fvfResTrgDef9|))))
(assert ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@37@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@37@10)))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@28@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@37@10))
        (and
          (<=
            0
            (inv@27@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@37@10)))
          (<
            (inv@27@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@37@10))
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
      $Perm.Write
      $Perm.No)
    (ite
      (and
        (img@34@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@37@10))
        (and
          (<=
            0
            (inv@33@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@37@10)))
          (<
            (inv@33@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@37@10))
            (len<Int> a@30@10))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 25 | !(0 <= i@37@10 && i@37@10 < len[Int](First:(First:($t@12@10))))]
(assert (not
  (and
    (<= 0 i@37@10)
    (<
      i@37@10
      (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))))
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@10 r)
      (and
        (<= 0 (inv@27@10 r))
        (<
          (inv@27@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
  :qid |qp.fvfValDef7|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@34@10 r)
      (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r) r))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef9|)))
(assert (=>
  (and
    (<= 0 i@37@10)
    (<
      i@37@10
      (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
  (and
    (<= 0 i@37@10)
    (<
      i@37@10
      (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))
    ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@37@10)) (loc<Ref> a@30@10 i@37@10))
    ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@37@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@37@10)))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= 0 i@37@10)
      (<
        i@37@10
        (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
  (and
    (<= 0 i@37@10)
    (<
      i@37@10
      (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))))
; Definitional axioms for snapshot map values
(pop) ; 7
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@10 r)
      (and
        (<= 0 (inv@27@10 r))
        (<
          (inv@27@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
  :qid |qp.fvfValDef7|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@34@10 r)
      (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r) r))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef9|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@37@10 Int)) (!
  (and
    (or (<= 0 i@37@10) (not (<= 0 i@37@10)))
    (=>
      (and
        (<= 0 i@37@10)
        (<
          i@37@10
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
      (and
        (<= 0 i@37@10)
        (<
          i@37@10
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))
        ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@37@10)) (loc<Ref> a@30@10 i@37@10))
        ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@37@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@37@10))))
    (or
      (not
        (and
          (<= 0 i@37@10)
          (<
            i@37@10
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
      (and
        (<= 0 i@37@10)
        (<
          i@37@10
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))))
  :pattern (($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@37@10)) (loc<Ref> a@30@10 i@37@10)))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@123@12@123@114-aux|)))
(assert (forall ((i@37@10 Int)) (!
  (=>
    (and
      (<= 0 i@37@10)
      (<
        i@37@10
        (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@37@10))
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@37@10))))
  :pattern (($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@37@10)) (loc<Ref> a@30@10 i@37@10)))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@123@12@123@114|)))
; State saturation: after inhale
(set-option :timeout 20)
(check-sat)
; unknown
; [exec]
; this.elems := a
; [exec]
; t := this.size
(declare-const t@38@10 Int)
(assert (=
  t@38@10
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
(declare-const t@39@10 Int)
(set-option :timeout 0)
(push) ; 7
; Loop head block: Check well-definedness of invariant
(declare-const $t@40@10 $Snap)
(assert (= $t@40@10 ($Snap.combine ($Snap.first $t@40@10) ($Snap.second $t@40@10))))
(assert (=
  ($Snap.second $t@40@10)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@40@10))
    ($Snap.second ($Snap.second $t@40@10)))))
(assert (=
  ($Snap.second ($Snap.second $t@40@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@40@10)))
    ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))
; [eval] loc(this.elems, j)
(declare-const sm@41@10 $FVF<val>)
; Definitional axioms for singleton-SM's value
(assert (=
  ($FVF.lookup_val (as sm@41@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.second $t@40@10))))))
(assert (<=
  $Perm.No
  (ite
    (=
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (/ (to_real 1) (to_real 2))
    $Perm.No)))
(assert (<=
  (ite
    (=
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (/ (to_real 1) (to_real 2))
    $Perm.No)
  $Perm.Write))
(assert (=>
  (=
    (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)
    (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
  (not
    (=
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)
      $Ref.null))))
(declare-const sm@42@10 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (=
      ($FVF.lookup_val (as sm@42@10  $FVF<val>) r)
      ($FVF.lookup_val (as sm@41@10  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@42@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@41@10  $FVF<val>) r))
  :qid |qp.fvfValDef10|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_val ($FVF.lookup_val (as sm@41@10  $FVF<val>) r) r)
  :pattern (($FVF.lookup_val (as sm@42@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef11|)))
(assert ($FVF.loc_val ($FVF.lookup_val (as sm@42@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@40@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@40@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@40@10))))
  $Snap.unit))
; [eval] j <= t
(assert (<= j@11@10 t@39@10))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))
  $Snap.unit))
; [eval] t <= this.size
(assert (<= t@39@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))
  $Snap.unit))
; [eval] this.size == old(length(this))
; [eval] old(length(this))
; [eval] length(this)
(push) ; 8
(pop) ; 8
; Joined path conditions
(assert (=
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))
  (length $t@6@10 this@3@10)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))
  $Snap.unit))
; [eval] -1 <= j
; [eval] -1
(assert (<= (- 0 1) j@11@10))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))
  $Snap.unit))
; [eval] this.size < len(this.elems)
; [eval] len(this.elems)
(assert (<
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))
  (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))))))
(declare-const i@43@10 Int)
(push) ; 8
; [eval] j < i && i <= this.size
; [eval] j < i
(push) ; 9
; [then-branch: 26 | !(j@11@10 < i@43@10) | live]
; [else-branch: 26 | j@11@10 < i@43@10 | live]
(push) ; 10
; [then-branch: 26 | !(j@11@10 < i@43@10)]
(assert (not (< j@11@10 i@43@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 26 | j@11@10 < i@43@10]
(assert (< j@11@10 i@43@10))
; [eval] i <= this.size
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (< j@11@10 i@43@10) (not (< j@11@10 i@43@10))))
(assert (and
  (< j@11@10 i@43@10)
  (<= i@43@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
; [eval] loc(this.elems, i)
(pop) ; 8
(declare-fun inv@44@10 ($Ref) Int)
(declare-fun img@45@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@43@10 Int)) (!
  (=>
    (and
      (< j@11@10 i@43@10)
      (<=
        i@43@10
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
    (or (< j@11@10 i@43@10) (not (< j@11@10 i@43@10))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@43@10))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 8
(assert (not (forall ((i1@43@10 Int) (i2@43@10 Int)) (!
  (=>
    (and
      (and
        (< j@11@10 i1@43@10)
        (<=
          i1@43@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
      (and
        (< j@11@10 i2@43@10)
        (<=
          i2@43@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
      (=
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i1@43@10)
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i2@43@10)))
    (= i1@43@10 i2@43@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@43@10 Int)) (!
  (=>
    (and
      (< j@11@10 i@43@10)
      (<=
        i@43@10
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
    (and
      (=
        (inv@44@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@43@10))
        i@43@10)
      (img@45@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@43@10))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@43@10))
  :qid |quant-u-67|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@45@10 r)
      (and
        (< j@11@10 (inv@44@10 r))
        (<=
          (inv@44@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
    (=
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) (inv@44@10 r))
      r))
  :pattern ((inv@44@10 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@43@10 Int)) (!
  (=>
    (and
      (< j@11@10 i@43@10)
      (<=
        i@43@10
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
    (not
      (=
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@43@10)
        $Ref.null)))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@43@10))
  :qid |val-permImpliesNonNull|)))
(declare-const sm@46@10 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val (as sm@41@10  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@41@10  $FVF<val>) r))
  :qid |qp.fvfValDef12|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@45@10 r)
      (and
        (< j@11@10 (inv@44@10 r))
        (<=
          (inv@44@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r))
  :qid |qp.fvfValDef13|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val (as sm@41@10  $FVF<val>) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r) r))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef14|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (< j@11@10 (inv@44@10 r))
      (<=
        (inv@44@10 r)
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
    ($FVF.loc_val ($FVF.lookup_val (as sm@46@10  $FVF<val>) r) r))
  :pattern ((inv@44@10 r))
  :qid |quant-u-68|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(this.elems, i) } j <= i && i <= this.size ==> i < t ==> loc(this.elems, i).val == old(itemAt(this, i)))
(declare-const i@47@10 Int)
(push) ; 8
; [eval] j <= i && i <= this.size ==> i < t ==> loc(this.elems, i).val == old(itemAt(this, i))
; [eval] j <= i && i <= this.size
; [eval] j <= i
(push) ; 9
; [then-branch: 27 | !(j@11@10 <= i@47@10) | live]
; [else-branch: 27 | j@11@10 <= i@47@10 | live]
(push) ; 10
; [then-branch: 27 | !(j@11@10 <= i@47@10)]
(assert (not (<= j@11@10 i@47@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 27 | j@11@10 <= i@47@10]
(assert (<= j@11@10 i@47@10))
; [eval] i <= this.size
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (<= j@11@10 i@47@10) (not (<= j@11@10 i@47@10))))
(push) ; 9
; [then-branch: 28 | j@11@10 <= i@47@10 && i@47@10 <= First:(Second:($t@40@10)) | live]
; [else-branch: 28 | !(j@11@10 <= i@47@10 && i@47@10 <= First:(Second:($t@40@10))) | live]
(push) ; 10
; [then-branch: 28 | j@11@10 <= i@47@10 && i@47@10 <= First:(Second:($t@40@10))]
(assert (and
  (<= j@11@10 i@47@10)
  (<= i@47@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
; [eval] i < t ==> loc(this.elems, i).val == old(itemAt(this, i))
; [eval] i < t
(push) ; 11
; [then-branch: 29 | i@47@10 < t@39@10 | live]
; [else-branch: 29 | !(i@47@10 < t@39@10) | live]
(push) ; 12
; [then-branch: 29 | i@47@10 < t@39@10]
(assert (< i@47@10 t@39@10))
; [eval] loc(this.elems, i).val == old(itemAt(this, i))
; [eval] loc(this.elems, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (=
        r
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
      (=
        ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
        ($FVF.lookup_val (as sm@41@10  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@41@10  $FVF<val>) r))
    :qid |qp.fvfValDef12|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@45@10 r)
        (and
          (< j@11@10 (inv@44@10 r))
          (<=
            (inv@44@10 r)
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
      (=
        ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r)))
    :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r))
    :qid |qp.fvfValDef13|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_val ($FVF.lookup_val (as sm@41@10  $FVF<val>) r) r)
      ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r) r))
    :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
    :qid |qp.fvfResTrgDef14|))))
(assert ($FVF.loc_val ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10)))
(push) ; 13
(assert (not (<
  $Perm.No
  (+
    (ite
      (=
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10)
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
      (/ (to_real 1) (to_real 2))
      $Perm.No)
    (ite
      (and
        (img@45@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10))
        (and
          (<
            j@11@10
            (inv@44@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10)))
          (<=
            (inv@44@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10))
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 13
; 0.00s
; (get-info :all-statistics)
; [eval] old(itemAt(this, i))
; [eval] itemAt(this, i)
(push) ; 13
; [eval] 0 <= index
(push) ; 14
(assert (not (<= 0 i@47@10)))
(check-sat)
; unsat
(pop) ; 14
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 i@47@10))
; [eval] index < length(this)
; [eval] length(this)
(push) ; 14
(pop) ; 14
; Joined path conditions
(push) ; 14
(assert (not (< i@47@10 (length $t@6@10 this@3@10))))
(check-sat)
; unsat
(pop) ; 14
; 0.00s
; (get-info :all-statistics)
(assert (< i@47@10 (length $t@6@10 this@3@10)))
(assert (itemAt%precondition ($Snap.combine
  $t@6@10
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@47@10))
(pop) ; 13
; Joined path conditions
(assert (and
  (<= 0 i@47@10)
  (< i@47@10 (length $t@6@10 this@3@10))
  (itemAt%precondition ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@47@10)))
(pop) ; 12
(push) ; 12
; [else-branch: 29 | !(i@47@10 < t@39@10)]
(assert (not (< i@47@10 t@39@10)))
(pop) ; 12
(pop) ; 11
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val (as sm@41@10  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@41@10  $FVF<val>) r))
  :qid |qp.fvfValDef12|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@45@10 r)
      (and
        (< j@11@10 (inv@44@10 r))
        (<=
          (inv@44@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r))
  :qid |qp.fvfValDef13|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val (as sm@41@10  $FVF<val>) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r) r))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef14|)))
(assert (=>
  (< i@47@10 t@39@10)
  (and
    (< i@47@10 t@39@10)
    ($FVF.loc_val ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10))
    (<= 0 i@47@10)
    (< i@47@10 (length $t@6@10 this@3@10))
    (itemAt%precondition ($Snap.combine
      $t@6@10
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@47@10))))
; Joined path conditions
(assert (or (not (< i@47@10 t@39@10)) (< i@47@10 t@39@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 28 | !(j@11@10 <= i@47@10 && i@47@10 <= First:(Second:($t@40@10)))]
(assert (not
  (and
    (<= j@11@10 i@47@10)
    (<= i@47@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val (as sm@41@10  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@41@10  $FVF<val>) r))
  :qid |qp.fvfValDef12|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@45@10 r)
      (and
        (< j@11@10 (inv@44@10 r))
        (<=
          (inv@44@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r))
  :qid |qp.fvfValDef13|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val (as sm@41@10  $FVF<val>) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r) r))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef14|)))
(assert (=>
  (and
    (<= j@11@10 i@47@10)
    (<= i@47@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
  (and
    (<= j@11@10 i@47@10)
    (<= i@47@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))
    (=>
      (< i@47@10 t@39@10)
      (and
        (< i@47@10 t@39@10)
        ($FVF.loc_val ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10))
        (<= 0 i@47@10)
        (< i@47@10 (length $t@6@10 this@3@10))
        (itemAt%precondition ($Snap.combine
          $t@6@10
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@47@10)))
    (or (not (< i@47@10 t@39@10)) (< i@47@10 t@39@10)))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= j@11@10 i@47@10)
      (<=
        i@47@10
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
  (and
    (<= j@11@10 i@47@10)
    (<= i@47@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))))
(pop) ; 8
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val (as sm@41@10  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@41@10  $FVF<val>) r))
  :qid |qp.fvfValDef12|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@45@10 r)
      (and
        (< j@11@10 (inv@44@10 r))
        (<=
          (inv@44@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r))
  :qid |qp.fvfValDef13|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val (as sm@41@10  $FVF<val>) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r) r))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef14|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@47@10 Int)) (!
  (and
    (or (<= j@11@10 i@47@10) (not (<= j@11@10 i@47@10)))
    (=>
      (and
        (<= j@11@10 i@47@10)
        (<=
          i@47@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
      (and
        (<= j@11@10 i@47@10)
        (<=
          i@47@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))
        (=>
          (< i@47@10 t@39@10)
          (and
            (< i@47@10 t@39@10)
            ($FVF.loc_val ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10))
            (<= 0 i@47@10)
            (< i@47@10 (length $t@6@10 this@3@10))
            (itemAt%precondition ($Snap.combine
              $t@6@10
              ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@47@10)))
        (or (not (< i@47@10 t@39@10)) (< i@47@10 t@39@10))))
    (or
      (not
        (and
          (<= j@11@10 i@47@10)
          (<=
            i@47@10
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
      (and
        (<= j@11@10 i@47@10)
        (<=
          i@47@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@136@15@136@137-aux|)))
(assert (forall ((i@47@10 Int)) (!
  (=>
    (and
      (and
        (<= j@11@10 i@47@10)
        (<=
          i@47@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
      (< i@47@10 t@39@10))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10))
      (itemAt ($Snap.combine $t@6@10 ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@47@10)))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@136@15@136@137|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))))
  $Snap.unit))
; [eval] (forall i: Int :: { loc(this.elems, i) } j < i && i <= this.size ==> i > t ==> loc(this.elems, i).val == old(itemAt(this, i - 1)))
(declare-const i@48@10 Int)
(push) ; 8
; [eval] j < i && i <= this.size ==> i > t ==> loc(this.elems, i).val == old(itemAt(this, i - 1))
; [eval] j < i && i <= this.size
; [eval] j < i
(push) ; 9
; [then-branch: 30 | !(j@11@10 < i@48@10) | live]
; [else-branch: 30 | j@11@10 < i@48@10 | live]
(push) ; 10
; [then-branch: 30 | !(j@11@10 < i@48@10)]
(assert (not (< j@11@10 i@48@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 30 | j@11@10 < i@48@10]
(assert (< j@11@10 i@48@10))
; [eval] i <= this.size
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (< j@11@10 i@48@10) (not (< j@11@10 i@48@10))))
(push) ; 9
; [then-branch: 31 | j@11@10 < i@48@10 && i@48@10 <= First:(Second:($t@40@10)) | live]
; [else-branch: 31 | !(j@11@10 < i@48@10 && i@48@10 <= First:(Second:($t@40@10))) | live]
(push) ; 10
; [then-branch: 31 | j@11@10 < i@48@10 && i@48@10 <= First:(Second:($t@40@10))]
(assert (and
  (< j@11@10 i@48@10)
  (<= i@48@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
; [eval] i > t ==> loc(this.elems, i).val == old(itemAt(this, i - 1))
; [eval] i > t
(push) ; 11
; [then-branch: 32 | i@48@10 > t@39@10 | live]
; [else-branch: 32 | !(i@48@10 > t@39@10) | live]
(push) ; 12
; [then-branch: 32 | i@48@10 > t@39@10]
(assert (> i@48@10 t@39@10))
; [eval] loc(this.elems, i).val == old(itemAt(this, i - 1))
; [eval] loc(this.elems, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (=
        r
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
      (=
        ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
        ($FVF.lookup_val (as sm@41@10  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@41@10  $FVF<val>) r))
    :qid |qp.fvfValDef12|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@45@10 r)
        (and
          (< j@11@10 (inv@44@10 r))
          (<=
            (inv@44@10 r)
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
      (=
        ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r)))
    :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r))
    :qid |qp.fvfValDef13|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_val ($FVF.lookup_val (as sm@41@10  $FVF<val>) r) r)
      ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r) r))
    :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
    :qid |qp.fvfResTrgDef14|))))
(assert ($FVF.loc_val ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10)))
(push) ; 13
(assert (not (<
  $Perm.No
  (+
    (ite
      (=
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10)
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
      (/ (to_real 1) (to_real 2))
      $Perm.No)
    (ite
      (and
        (img@45@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10))
        (and
          (<
            j@11@10
            (inv@44@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10)))
          (<=
            (inv@44@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10))
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 13
; 0.00s
; (get-info :all-statistics)
; [eval] old(itemAt(this, i - 1))
; [eval] itemAt(this, i - 1)
; [eval] i - 1
(push) ; 13
; [eval] 0 <= index
(push) ; 14
(assert (not (<= 0 (- i@48@10 1))))
(check-sat)
; unsat
(pop) ; 14
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 (- i@48@10 1)))
; [eval] index < length(this)
; [eval] length(this)
(push) ; 14
(pop) ; 14
; Joined path conditions
(push) ; 14
(assert (not (< (- i@48@10 1) (length $t@6@10 this@3@10))))
(check-sat)
; unsat
(pop) ; 14
; 0.00s
; (get-info :all-statistics)
(assert (< (- i@48@10 1) (length $t@6@10 this@3@10)))
(assert (itemAt%precondition ($Snap.combine
  $t@6@10
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- i@48@10 1)))
(pop) ; 13
; Joined path conditions
(assert (and
  (<= 0 (- i@48@10 1))
  (< (- i@48@10 1) (length $t@6@10 this@3@10))
  (itemAt%precondition ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- i@48@10 1))))
(pop) ; 12
(push) ; 12
; [else-branch: 32 | !(i@48@10 > t@39@10)]
(assert (not (> i@48@10 t@39@10)))
(pop) ; 12
(pop) ; 11
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val (as sm@41@10  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@41@10  $FVF<val>) r))
  :qid |qp.fvfValDef12|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@45@10 r)
      (and
        (< j@11@10 (inv@44@10 r))
        (<=
          (inv@44@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r))
  :qid |qp.fvfValDef13|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val (as sm@41@10  $FVF<val>) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r) r))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef14|)))
(assert (=>
  (> i@48@10 t@39@10)
  (and
    (> i@48@10 t@39@10)
    ($FVF.loc_val ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10))
    (<= 0 (- i@48@10 1))
    (< (- i@48@10 1) (length $t@6@10 this@3@10))
    (itemAt%precondition ($Snap.combine
      $t@6@10
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- i@48@10 1)))))
; Joined path conditions
(assert (or (not (> i@48@10 t@39@10)) (> i@48@10 t@39@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 31 | !(j@11@10 < i@48@10 && i@48@10 <= First:(Second:($t@40@10)))]
(assert (not
  (and
    (< j@11@10 i@48@10)
    (<= i@48@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val (as sm@41@10  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@41@10  $FVF<val>) r))
  :qid |qp.fvfValDef12|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@45@10 r)
      (and
        (< j@11@10 (inv@44@10 r))
        (<=
          (inv@44@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r))
  :qid |qp.fvfValDef13|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val (as sm@41@10  $FVF<val>) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r) r))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef14|)))
(assert (=>
  (and
    (< j@11@10 i@48@10)
    (<= i@48@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
  (and
    (< j@11@10 i@48@10)
    (<= i@48@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))
    (=>
      (> i@48@10 t@39@10)
      (and
        (> i@48@10 t@39@10)
        ($FVF.loc_val ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10))
        (<= 0 (- i@48@10 1))
        (< (- i@48@10 1) (length $t@6@10 this@3@10))
        (itemAt%precondition ($Snap.combine
          $t@6@10
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- i@48@10 1))))
    (or (not (> i@48@10 t@39@10)) (> i@48@10 t@39@10)))))
; Joined path conditions
(assert (or
  (not
    (and
      (< j@11@10 i@48@10)
      (<=
        i@48@10
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
  (and
    (< j@11@10 i@48@10)
    (<= i@48@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))))
(pop) ; 8
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val (as sm@41@10  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@41@10  $FVF<val>) r))
  :qid |qp.fvfValDef12|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@45@10 r)
      (and
        (< j@11@10 (inv@44@10 r))
        (<=
          (inv@44@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r))
  :qid |qp.fvfValDef13|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val (as sm@41@10  $FVF<val>) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r) r))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef14|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@48@10 Int)) (!
  (and
    (or (< j@11@10 i@48@10) (not (< j@11@10 i@48@10)))
    (=>
      (and
        (< j@11@10 i@48@10)
        (<=
          i@48@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
      (and
        (< j@11@10 i@48@10)
        (<=
          i@48@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))
        (=>
          (> i@48@10 t@39@10)
          (and
            (> i@48@10 t@39@10)
            ($FVF.loc_val ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10))
            (<= 0 (- i@48@10 1))
            (< (- i@48@10 1) (length $t@6@10 this@3@10))
            (itemAt%precondition ($Snap.combine
              $t@6@10
              ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- i@48@10 1))))
        (or (not (> i@48@10 t@39@10)) (> i@48@10 t@39@10))))
    (or
      (not
        (and
          (< j@11@10 i@48@10)
          (<=
            i@48@10
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
      (and
        (< j@11@10 i@48@10)
        (<=
          i@48@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@137@15@137@138-aux|)))
(assert (forall ((i@48@10 Int)) (!
  (=>
    (and
      (and
        (< j@11@10 i@48@10)
        (<=
          i@48@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
      (> i@48@10 t@39@10))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10))
      (itemAt ($Snap.combine $t@6@10 ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (-
        i@48@10
        1))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@137@15@137@138|)))
(pop) ; 7
(push) ; 7
; Loop head block: Establish invariant
(push) ; 8
(set-option :timeout 10)
(assert (not false))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 8
(set-option :timeout 10)
(assert (not false))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [eval] loc(this.elems, j)
; Definitional axioms for snapshot map values
(assert ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 j@11@10)) (loc<Ref> a@30@10 j@11@10)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@49@10 ((r $Ref)) $Perm
  (ite
    (= r (loc<Ref> a@30@10 j@11@10))
    ($Perm.min
      (ite
        (and
          (img@28@10 r)
          (and
            (<= 0 (inv@27@10 r))
            (<
              (inv@27@10 r)
              (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
        $Perm.Write
        $Perm.No)
      (/ (to_real 1) (to_real 2)))
    $Perm.No))
(define-fun pTaken@50@10 ((r $Ref)) $Perm
  (ite
    (= r (loc<Ref> a@30@10 j@11@10))
    ($Perm.min
      (ite
        (and
          (img@34@10 r)
          (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
        $Perm.Write
        $Perm.No)
      (- (/ (to_real 1) (to_real 2)) (pTaken@49@10 r)))
    $Perm.No))
; Done precomputing, updating quantified chunks
; State saturation: before repetition
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
          (img@28@10 r)
          (and
            (<= 0 (inv@27@10 r))
            (<
              (inv@27@10 r)
              (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
        $Perm.Write
        $Perm.No)
      (pTaken@49@10 r))
    $Perm.No)
  
  :qid |quant-u-70|))))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 8
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@49@10 r) $Perm.No)
  
  :qid |quant-u-71|))))
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
    (= r (loc<Ref> a@30@10 j@11@10))
    (= (- (/ (to_real 1) (to_real 2)) (pTaken@49@10 r)) $Perm.No))
  
  :qid |quant-u-72|))))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 8
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and
          (img@34@10 r)
          (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
        $Perm.Write
        $Perm.No)
      (pTaken@50@10 r))
    $Perm.No)
  
  :qid |quant-u-73|))))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 8
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@50@10 r) $Perm.No)
  
  :qid |quant-u-74|))))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 8
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> a@30@10 j@11@10))
    (=
      (- (- (/ (to_real 1) (to_real 2)) (pTaken@49@10 r)) (pTaken@50@10 r))
      $Perm.No))
  
  :qid |quant-u-75|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
; Definitional axioms for snapshot map values (instantiated)
(assert (=>
  (and
    (img@28@10 (loc<Ref> a@30@10 j@11@10))
    (and
      (<= 0 (inv@27@10 (loc<Ref> a@30@10 j@11@10)))
      (<
        (inv@27@10 (loc<Ref> a@30@10 j@11@10))
        (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
  (=
    ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 j@11@10))
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) (loc<Ref> a@30@10 j@11@10)))))
(assert (=>
  (and
    (img@34@10 (loc<Ref> a@30@10 j@11@10))
    (and
      (<= 0 (inv@33@10 (loc<Ref> a@30@10 j@11@10)))
      (< (inv@33@10 (loc<Ref> a@30@10 j@11@10)) (len<Int> a@30@10))))
  (=
    ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 j@11@10))
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) (loc<Ref> a@30@10 j@11@10)))))
(assert (and
  ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) (loc<Ref> a@30@10 j@11@10)) (loc<Ref> a@30@10 j@11@10))
  ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) (loc<Ref> a@30@10 j@11@10)) (loc<Ref> a@30@10 j@11@10))))
; [eval] j <= t
(set-option :timeout 0)
(push) ; 8
(assert (not (<= j@11@10 t@38@10)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (<= j@11@10 t@38@10))
; [eval] t <= this.size
(push) ; 8
(assert (not (<=
  t@38@10
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10)))))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (<=
  t@38@10
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
; [eval] this.size == old(length(this))
; [eval] old(length(this))
; [eval] length(this)
(push) ; 8
(pop) ; 8
; Joined path conditions
(push) ; 8
(assert (not (=
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))
  (length $t@6@10 this@3@10))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))
  (length $t@6@10 this@3@10)))
; [eval] -1 <= j
; [eval] -1
(push) ; 8
(assert (not (<= (- 0 1) j@11@10)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (<= (- 0 1) j@11@10))
; [eval] this.size < len(this.elems)
; [eval] len(this.elems)
(push) ; 8
(assert (not (<
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))
  (len<Int> a@30@10))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (<
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))
  (len<Int> a@30@10)))
(declare-const i@51@10 Int)
(push) ; 8
; [eval] j < i && i <= this.size
; [eval] j < i
(push) ; 9
; [then-branch: 33 | !(j@11@10 < i@51@10) | live]
; [else-branch: 33 | j@11@10 < i@51@10 | live]
(push) ; 10
; [then-branch: 33 | !(j@11@10 < i@51@10)]
(assert (not (< j@11@10 i@51@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 33 | j@11@10 < i@51@10]
(assert (< j@11@10 i@51@10))
; [eval] i <= this.size
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (< j@11@10 i@51@10) (not (< j@11@10 i@51@10))))
(assert (and
  (< j@11@10 i@51@10)
  (<=
    i@51@10
    ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10)))))))
; [eval] loc(this.elems, i)
(pop) ; 8
(declare-fun inv@52@10 ($Ref) Int)
(declare-fun img@53@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@51@10 Int)) (!
  (=>
    (and
      (< j@11@10 i@51@10)
      (<=
        i@51@10
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
    (or (< j@11@10 i@51@10) (not (< j@11@10 i@51@10))))
  :pattern ((loc<Ref> a@30@10 i@51@10))
  :qid |val-aux|)))
(declare-const sm@54@10 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@34@10 r)
        (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
      (< $Perm.No (- $Perm.Write (pTaken@50@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@54@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r)))
  :pattern (($FVF.lookup_val (as sm@54@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r))
  :qid |qp.fvfValDef15|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@10 r)
      (and
        (<= 0 (inv@27@10 r))
        (<
          (inv@27@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
    (=
      ($FVF.lookup_val (as sm@54@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
  :pattern (($FVF.lookup_val (as sm@54@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
  :qid |qp.fvfValDef16|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r))
  :pattern (($FVF.lookup_val (as sm@54@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef17|)))
; Check receiver injectivity
(push) ; 8
(assert (not (forall ((i1@51@10 Int) (i2@51@10 Int)) (!
  (=>
    (and
      (and
        (and
          (< j@11@10 i1@51@10)
          (<=
            i1@51@10
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
        ($FVF.loc_val ($FVF.lookup_val (as sm@54@10  $FVF<val>) (loc<Ref> a@30@10 i1@51@10)) (loc<Ref> a@30@10 i1@51@10)))
      (and
        (and
          (< j@11@10 i2@51@10)
          (<=
            i2@51@10
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
        ($FVF.loc_val ($FVF.lookup_val (as sm@54@10  $FVF<val>) (loc<Ref> a@30@10 i2@51@10)) (loc<Ref> a@30@10 i2@51@10)))
      (= (loc<Ref> a@30@10 i1@51@10) (loc<Ref> a@30@10 i2@51@10)))
    (= i1@51@10 i2@51@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@51@10 Int)) (!
  (=>
    (and
      (< j@11@10 i@51@10)
      (<=
        i@51@10
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
    (and
      (= (inv@52@10 (loc<Ref> a@30@10 i@51@10)) i@51@10)
      (img@53@10 (loc<Ref> a@30@10 i@51@10))))
  :pattern ((loc<Ref> a@30@10 i@51@10))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@53@10 r)
      (and
        (< j@11@10 (inv@52@10 r))
        (<=
          (inv@52@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10)))))))
    (= (loc<Ref> a@30@10 (inv@52@10 r)) r))
  :pattern ((inv@52@10 r))
  :qid |val-fctOfInv|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (< j@11@10 (inv@52@10 r))
      (<=
        (inv@52@10 r)
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
    ($FVF.loc_val ($FVF.lookup_val (as sm@54@10  $FVF<val>) r) r))
  :pattern ((inv@52@10 r))
  :qid |quant-u-77|)))
(push) ; 8
(set-option :timeout 10)
(assert (not (forall ((i@51@10 Int)) (!
  (=
    (loc<Ref> a@30@10 i@51@10)
    (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10))) i@51@10))
  
  :qid |quant-u-78|))))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; Precomputing data for removing quantified permissions
(define-fun pTaken@55@10 ((r $Ref)) $Perm
  (ite
    (and
      (and
        (< j@11@10 (inv@52@10 r))
        (<=
          (inv@52@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
      (img@53@10 r)
      (= r (loc<Ref> a@30@10 (inv@52@10 r))))
    ($Perm.min
      (ite
        (and
          (img@34@10 r)
          (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
        (- $Perm.Write (pTaken@50@10 r))
        $Perm.No)
      $Perm.Write)
    $Perm.No))
(define-fun pTaken@56@10 ((r $Ref)) $Perm
  (ite
    (and
      (and
        (< j@11@10 (inv@52@10 r))
        (<=
          (inv@52@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
      (img@53@10 r)
      (= r (loc<Ref> a@30@10 (inv@52@10 r))))
    ($Perm.min
      (ite
        (and
          (img@28@10 r)
          (and
            (<= 0 (inv@27@10 r))
            (<
              (inv@27@10 r)
              (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
        $Perm.Write
        $Perm.No)
      (- $Perm.Write (pTaken@55@10 r)))
    $Perm.No))
; Done precomputing, updating quantified chunks
; State saturation: before repetition
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
          (img@34@10 r)
          (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
        (- $Perm.Write (pTaken@50@10 r))
        $Perm.No)
      (pTaken@55@10 r))
    $Perm.No)
  
  :qid |quant-u-80|))))
(check-sat)
; unknown
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 8
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@55@10 r) $Perm.No)
  
  :qid |quant-u-81|))))
(check-sat)
; unknown
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
      (and
        (< j@11@10 (inv@52@10 r))
        (<=
          (inv@52@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
      (img@53@10 r)
      (= r (loc<Ref> a@30@10 (inv@52@10 r))))
    (= (- $Perm.Write (pTaken@55@10 r)) $Perm.No))
  
  :qid |quant-u-82|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
; Definitional axioms for snapshot map values
; [eval] (forall i: Int :: { loc(this.elems, i) } j <= i && i <= this.size ==> i < t ==> loc(this.elems, i).val == old(itemAt(this, i)))
(declare-const i@57@10 Int)
(set-option :timeout 0)
(push) ; 8
; [eval] j <= i && i <= this.size ==> i < t ==> loc(this.elems, i).val == old(itemAt(this, i))
; [eval] j <= i && i <= this.size
; [eval] j <= i
(push) ; 9
; [then-branch: 34 | !(j@11@10 <= i@57@10) | live]
; [else-branch: 34 | j@11@10 <= i@57@10 | live]
(push) ; 10
; [then-branch: 34 | !(j@11@10 <= i@57@10)]
(assert (not (<= j@11@10 i@57@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 34 | j@11@10 <= i@57@10]
(assert (<= j@11@10 i@57@10))
; [eval] i <= this.size
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (<= j@11@10 i@57@10) (not (<= j@11@10 i@57@10))))
(push) ; 9
; [then-branch: 35 | j@11@10 <= i@57@10 && i@57@10 <= First:(Second:(First:($t@12@10))) | live]
; [else-branch: 35 | !(j@11@10 <= i@57@10 && i@57@10 <= First:(Second:(First:($t@12@10)))) | live]
(push) ; 10
; [then-branch: 35 | j@11@10 <= i@57@10 && i@57@10 <= First:(Second:(First:($t@12@10)))]
(assert (and
  (<= j@11@10 i@57@10)
  (<=
    i@57@10
    ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10)))))))
; [eval] i < t ==> loc(this.elems, i).val == old(itemAt(this, i))
; [eval] i < t
(push) ; 11
; [then-branch: 36 | i@57@10 < t@38@10 | live]
; [else-branch: 36 | !(i@57@10 < t@38@10) | live]
(push) ; 12
; [then-branch: 36 | i@57@10 < t@38@10]
(assert (< i@57@10 t@38@10))
; [eval] loc(this.elems, i).val == old(itemAt(this, i))
; [eval] loc(this.elems, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@28@10 r)
        (and
          (<= 0 (inv@27@10 r))
          (<
            (inv@27@10 r)
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
      (=
        ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
    :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
    :qid |qp.fvfValDef7|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@34@10 r)
        (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
      (=
        ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r)))
    :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r))
    :qid |qp.fvfValDef8|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
      ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r) r))
    :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
    :qid |qp.fvfResTrgDef9|))))
(assert ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@57@10)) (loc<Ref> a@30@10 i@57@10)))
(push) ; 13
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@28@10 (loc<Ref> a@30@10 i@57@10))
        (and
          (<= 0 (inv@27@10 (loc<Ref> a@30@10 i@57@10)))
          (<
            (inv@27@10 (loc<Ref> a@30@10 i@57@10))
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
      $Perm.Write
      $Perm.No)
    (ite
      (and
        (img@34@10 (loc<Ref> a@30@10 i@57@10))
        (and
          (<= 0 (inv@33@10 (loc<Ref> a@30@10 i@57@10)))
          (< (inv@33@10 (loc<Ref> a@30@10 i@57@10)) (len<Int> a@30@10))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 13
; 0.00s
; (get-info :all-statistics)
; [eval] old(itemAt(this, i))
; [eval] itemAt(this, i)
(push) ; 13
; [eval] 0 <= index
(push) ; 14
(assert (not (<= 0 i@57@10)))
(check-sat)
; unsat
(pop) ; 14
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 i@57@10))
; [eval] index < length(this)
; [eval] length(this)
(push) ; 14
(pop) ; 14
; Joined path conditions
(push) ; 14
(assert (not (< i@57@10 (length $t@6@10 this@3@10))))
(check-sat)
; unsat
(pop) ; 14
; 0.00s
; (get-info :all-statistics)
(assert (< i@57@10 (length $t@6@10 this@3@10)))
(assert (itemAt%precondition ($Snap.combine
  $t@6@10
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@57@10))
(pop) ; 13
; Joined path conditions
(assert (and
  (<= 0 i@57@10)
  (< i@57@10 (length $t@6@10 this@3@10))
  (itemAt%precondition ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@57@10)))
(pop) ; 12
(push) ; 12
; [else-branch: 36 | !(i@57@10 < t@38@10)]
(assert (not (< i@57@10 t@38@10)))
(pop) ; 12
(pop) ; 11
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@10 r)
      (and
        (<= 0 (inv@27@10 r))
        (<
          (inv@27@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
  :qid |qp.fvfValDef7|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@34@10 r)
      (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r) r))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef9|)))
(assert (=>
  (< i@57@10 t@38@10)
  (and
    (< i@57@10 t@38@10)
    ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@57@10)) (loc<Ref> a@30@10 i@57@10))
    (<= 0 i@57@10)
    (< i@57@10 (length $t@6@10 this@3@10))
    (itemAt%precondition ($Snap.combine
      $t@6@10
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@57@10))))
; Joined path conditions
(assert (or (not (< i@57@10 t@38@10)) (< i@57@10 t@38@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 35 | !(j@11@10 <= i@57@10 && i@57@10 <= First:(Second:(First:($t@12@10))))]
(assert (not
  (and
    (<= j@11@10 i@57@10)
    (<=
      i@57@10
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@10 r)
      (and
        (<= 0 (inv@27@10 r))
        (<
          (inv@27@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
  :qid |qp.fvfValDef7|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@34@10 r)
      (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r) r))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef9|)))
(assert (=>
  (and
    (<= j@11@10 i@57@10)
    (<=
      i@57@10
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
  (and
    (<= j@11@10 i@57@10)
    (<=
      i@57@10
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10)))))
    (=>
      (< i@57@10 t@38@10)
      (and
        (< i@57@10 t@38@10)
        ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@57@10)) (loc<Ref> a@30@10 i@57@10))
        (<= 0 i@57@10)
        (< i@57@10 (length $t@6@10 this@3@10))
        (itemAt%precondition ($Snap.combine
          $t@6@10
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@57@10)))
    (or (not (< i@57@10 t@38@10)) (< i@57@10 t@38@10)))))
; Joined path conditions
(assert (or
  (not
    (and
      (<= j@11@10 i@57@10)
      (<=
        i@57@10
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10)))))))
  (and
    (<= j@11@10 i@57@10)
    (<=
      i@57@10
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))))
(pop) ; 8
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@10 r)
      (and
        (<= 0 (inv@27@10 r))
        (<
          (inv@27@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
  :qid |qp.fvfValDef7|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@34@10 r)
      (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r) r))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef9|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@57@10 Int)) (!
  (and
    (or (<= j@11@10 i@57@10) (not (<= j@11@10 i@57@10)))
    (=>
      (and
        (<= j@11@10 i@57@10)
        (<=
          i@57@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
      (and
        (<= j@11@10 i@57@10)
        (<=
          i@57@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10)))))
        (=>
          (< i@57@10 t@38@10)
          (and
            (< i@57@10 t@38@10)
            ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@57@10)) (loc<Ref> a@30@10 i@57@10))
            (<= 0 i@57@10)
            (< i@57@10 (length $t@6@10 this@3@10))
            (itemAt%precondition ($Snap.combine
              $t@6@10
              ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@57@10)))
        (or (not (< i@57@10 t@38@10)) (< i@57@10 t@38@10))))
    (or
      (not
        (and
          (<= j@11@10 i@57@10)
          (<=
            i@57@10
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10)))))))
      (and
        (<= j@11@10 i@57@10)
        (<=
          i@57@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))))
  :pattern ((loc<Ref> a@30@10 i@57@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@136@15@136@137-aux|)))
(assert (forall ((i@57@10 Int)) (!
  (=>
    (and
      (and
        (<= j@11@10 i@57@10)
        (<=
          i@57@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
      (< i@57@10 t@38@10))
    (itemAt%precondition ($Snap.combine
      $t@6@10
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@57@10))
  :pattern ((loc<Ref> a@30@10 i@57@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@136@15@136@137_precondition|)))
(push) ; 8
(assert (not (forall ((i@57@10 Int)) (!
  (=>
    (and
      (=>
        (and
          (and
            (<= j@11@10 i@57@10)
            (<=
              i@57@10
              ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
          (< i@57@10 t@38@10))
        (itemAt%precondition ($Snap.combine
          $t@6@10
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@57@10))
      (and
        (and
          (<= j@11@10 i@57@10)
          (<=
            i@57@10
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
        (< i@57@10 t@38@10)))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@57@10))
      (itemAt ($Snap.combine $t@6@10 ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@57@10)))
  :pattern ((loc<Ref> a@30@10 i@57@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@136@15@136@137|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@57@10 Int)) (!
  (=>
    (and
      (and
        (<= j@11@10 i@57@10)
        (<=
          i@57@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
      (< i@57@10 t@38@10))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@57@10))
      (itemAt ($Snap.combine $t@6@10 ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@57@10)))
  :pattern ((loc<Ref> a@30@10 i@57@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@136@15@136@137|)))
; [eval] (forall i: Int :: { loc(this.elems, i) } j < i && i <= this.size ==> i > t ==> loc(this.elems, i).val == old(itemAt(this, i - 1)))
(declare-const i@58@10 Int)
(push) ; 8
; [eval] j < i && i <= this.size ==> i > t ==> loc(this.elems, i).val == old(itemAt(this, i - 1))
; [eval] j < i && i <= this.size
; [eval] j < i
(push) ; 9
; [then-branch: 37 | !(j@11@10 < i@58@10) | live]
; [else-branch: 37 | j@11@10 < i@58@10 | live]
(push) ; 10
; [then-branch: 37 | !(j@11@10 < i@58@10)]
(assert (not (< j@11@10 i@58@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 37 | j@11@10 < i@58@10]
(assert (< j@11@10 i@58@10))
; [eval] i <= this.size
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (or (< j@11@10 i@58@10) (not (< j@11@10 i@58@10))))
(push) ; 9
; [then-branch: 38 | j@11@10 < i@58@10 && i@58@10 <= First:(Second:(First:($t@12@10))) | live]
; [else-branch: 38 | !(j@11@10 < i@58@10 && i@58@10 <= First:(Second:(First:($t@12@10)))) | live]
(push) ; 10
; [then-branch: 38 | j@11@10 < i@58@10 && i@58@10 <= First:(Second:(First:($t@12@10)))]
(assert (and
  (< j@11@10 i@58@10)
  (<=
    i@58@10
    ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10)))))))
; [eval] i > t ==> loc(this.elems, i).val == old(itemAt(this, i - 1))
; [eval] i > t
(push) ; 11
; [then-branch: 39 | i@58@10 > t@38@10 | live]
; [else-branch: 39 | !(i@58@10 > t@38@10) | live]
(push) ; 12
; [then-branch: 39 | i@58@10 > t@38@10]
(assert (> i@58@10 t@38@10))
; [eval] loc(this.elems, i).val == old(itemAt(this, i - 1))
; [eval] loc(this.elems, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@28@10 r)
        (and
          (<= 0 (inv@27@10 r))
          (<
            (inv@27@10 r)
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
      (=
        ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
    :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
    :qid |qp.fvfValDef7|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@34@10 r)
        (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
      (=
        ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r)))
    :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r))
    :qid |qp.fvfValDef8|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
      ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r) r))
    :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
    :qid |qp.fvfResTrgDef9|))))
(assert ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@58@10)) (loc<Ref> a@30@10 i@58@10)))
(push) ; 13
(assert (not (<
  $Perm.No
  (+
    (ite
      (and
        (img@28@10 (loc<Ref> a@30@10 i@58@10))
        (and
          (<= 0 (inv@27@10 (loc<Ref> a@30@10 i@58@10)))
          (<
            (inv@27@10 (loc<Ref> a@30@10 i@58@10))
            (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
      $Perm.Write
      $Perm.No)
    (ite
      (and
        (img@34@10 (loc<Ref> a@30@10 i@58@10))
        (and
          (<= 0 (inv@33@10 (loc<Ref> a@30@10 i@58@10)))
          (< (inv@33@10 (loc<Ref> a@30@10 i@58@10)) (len<Int> a@30@10))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 13
; 0.00s
; (get-info :all-statistics)
; [eval] old(itemAt(this, i - 1))
; [eval] itemAt(this, i - 1)
; [eval] i - 1
(push) ; 13
; [eval] 0 <= index
(push) ; 14
(assert (not (<= 0 (- i@58@10 1))))
(check-sat)
; unsat
(pop) ; 14
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 (- i@58@10 1)))
; [eval] index < length(this)
; [eval] length(this)
(push) ; 14
(pop) ; 14
; Joined path conditions
(push) ; 14
(assert (not (< (- i@58@10 1) (length $t@6@10 this@3@10))))
(check-sat)
; unsat
(pop) ; 14
; 0.00s
; (get-info :all-statistics)
(assert (< (- i@58@10 1) (length $t@6@10 this@3@10)))
(assert (itemAt%precondition ($Snap.combine
  $t@6@10
  ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- i@58@10 1)))
(pop) ; 13
; Joined path conditions
(assert (and
  (<= 0 (- i@58@10 1))
  (< (- i@58@10 1) (length $t@6@10 this@3@10))
  (itemAt%precondition ($Snap.combine
    $t@6@10
    ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- i@58@10 1))))
(pop) ; 12
(push) ; 12
; [else-branch: 39 | !(i@58@10 > t@38@10)]
(assert (not (> i@58@10 t@38@10)))
(pop) ; 12
(pop) ; 11
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@10 r)
      (and
        (<= 0 (inv@27@10 r))
        (<
          (inv@27@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
  :qid |qp.fvfValDef7|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@34@10 r)
      (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r) r))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef9|)))
(assert (=>
  (> i@58@10 t@38@10)
  (and
    (> i@58@10 t@38@10)
    ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@58@10)) (loc<Ref> a@30@10 i@58@10))
    (<= 0 (- i@58@10 1))
    (< (- i@58@10 1) (length $t@6@10 this@3@10))
    (itemAt%precondition ($Snap.combine
      $t@6@10
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- i@58@10 1)))))
; Joined path conditions
(assert (or (not (> i@58@10 t@38@10)) (> i@58@10 t@38@10)))
(pop) ; 10
(push) ; 10
; [else-branch: 38 | !(j@11@10 < i@58@10 && i@58@10 <= First:(Second:(First:($t@12@10))))]
(assert (not
  (and
    (< j@11@10 i@58@10)
    (<=
      i@58@10
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))))
(pop) ; 10
(pop) ; 9
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@10 r)
      (and
        (<= 0 (inv@27@10 r))
        (<
          (inv@27@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
  :qid |qp.fvfValDef7|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@34@10 r)
      (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r) r))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef9|)))
(assert (=>
  (and
    (< j@11@10 i@58@10)
    (<=
      i@58@10
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
  (and
    (< j@11@10 i@58@10)
    (<=
      i@58@10
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10)))))
    (=>
      (> i@58@10 t@38@10)
      (and
        (> i@58@10 t@38@10)
        ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@58@10)) (loc<Ref> a@30@10 i@58@10))
        (<= 0 (- i@58@10 1))
        (< (- i@58@10 1) (length $t@6@10 this@3@10))
        (itemAt%precondition ($Snap.combine
          $t@6@10
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- i@58@10 1))))
    (or (not (> i@58@10 t@38@10)) (> i@58@10 t@38@10)))))
; Joined path conditions
(assert (or
  (not
    (and
      (< j@11@10 i@58@10)
      (<=
        i@58@10
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10)))))))
  (and
    (< j@11@10 i@58@10)
    (<=
      i@58@10
      ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))))
(pop) ; 8
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@28@10 r)
      (and
        (<= 0 (inv@27@10 r))
        (<
          (inv@27@10 r)
          (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first ($Snap.first $t@12@10)))))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r))
  :qid |qp.fvfValDef7|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@34@10 r)
      (and (<= 0 (inv@33@10 r)) (< (inv@33@10 r) (len<Int> a@30@10))))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r)))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.first $t@12@10))))))) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.second $t@31@10)) r) r))
  :pattern (($FVF.lookup_val (as sm@35@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef9|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((i@58@10 Int)) (!
  (and
    (or (< j@11@10 i@58@10) (not (< j@11@10 i@58@10)))
    (=>
      (and
        (< j@11@10 i@58@10)
        (<=
          i@58@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
      (and
        (< j@11@10 i@58@10)
        (<=
          i@58@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10)))))
        (=>
          (> i@58@10 t@38@10)
          (and
            (> i@58@10 t@38@10)
            ($FVF.loc_val ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@58@10)) (loc<Ref> a@30@10 i@58@10))
            (<= 0 (- i@58@10 1))
            (< (- i@58@10 1) (length $t@6@10 this@3@10))
            (itemAt%precondition ($Snap.combine
              $t@6@10
              ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- i@58@10 1))))
        (or (not (> i@58@10 t@38@10)) (> i@58@10 t@38@10))))
    (or
      (not
        (and
          (< j@11@10 i@58@10)
          (<=
            i@58@10
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10)))))))
      (and
        (< j@11@10 i@58@10)
        (<=
          i@58@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))))
  :pattern ((loc<Ref> a@30@10 i@58@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@137@15@137@138-aux|)))
(assert (forall ((i@58@10 Int)) (!
  (=>
    (and
      (and
        (< j@11@10 i@58@10)
        (<=
          i@58@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
      (> i@58@10 t@38@10))
    (itemAt%precondition ($Snap.combine
      $t@6@10
      ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- i@58@10 1)))
  :pattern ((loc<Ref> a@30@10 i@58@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@137@15@137@138_precondition|)))
(push) ; 8
(assert (not (forall ((i@58@10 Int)) (!
  (=>
    (and
      (=>
        (and
          (and
            (< j@11@10 i@58@10)
            (<=
              i@58@10
              ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
          (> i@58@10 t@38@10))
        (itemAt%precondition ($Snap.combine
          $t@6@10
          ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- i@58@10 1)))
      (and
        (and
          (< j@11@10 i@58@10)
          (<=
            i@58@10
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
        (> i@58@10 t@38@10)))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@58@10))
      (itemAt ($Snap.combine $t@6@10 ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (-
        i@58@10
        1))))
  :pattern ((loc<Ref> a@30@10 i@58@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@137@15@137@138|))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(assert (forall ((i@58@10 Int)) (!
  (=>
    (and
      (and
        (< j@11@10 i@58@10)
        (<=
          i@58@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.first $t@12@10))))))
      (> i@58@10 t@38@10))
    (=
      ($FVF.lookup_val (as sm@35@10  $FVF<val>) (loc<Ref> a@30@10 i@58@10))
      (itemAt ($Snap.combine $t@6@10 ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (-
        i@58@10
        1))))
  :pattern ((loc<Ref> a@30@10 i@58@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@137@15@137@138|)))
; Loop head block: Execute statements of loop head block (in invariant state)
(push) ; 8
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@45@10 r)
      (and
        (< j@11@10 (inv@44@10 r))
        (<=
          (inv@44@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
    (=
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) (inv@44@10 r))
      r))
  :pattern ((inv@44@10 r))
  :qid |val-fctOfInv|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val (as sm@41@10  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@41@10  $FVF<val>) r))
  :qid |qp.fvfValDef12|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@45@10 r)
      (and
        (< j@11@10 (inv@44@10 r))
        (<=
          (inv@44@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r))
  :qid |qp.fvfValDef13|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val (as sm@41@10  $FVF<val>) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r) r))
  :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef14|)))
(assert (forall ((i@43@10 Int)) (!
  (=>
    (and
      (< j@11@10 i@43@10)
      (<=
        i@43@10
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
    (and
      (=
        (inv@44@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@43@10))
        i@43@10)
      (img@45@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@43@10))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@43@10))
  :qid |quant-u-67|)))
(assert (forall ((i@43@10 Int)) (!
  (=>
    (and
      (< j@11@10 i@43@10)
      (<=
        i@43@10
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
    (not
      (=
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@43@10)
        $Ref.null)))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@43@10))
  :qid |val-permImpliesNonNull|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (< j@11@10 (inv@44@10 r))
      (<=
        (inv@44@10 r)
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
    ($FVF.loc_val ($FVF.lookup_val (as sm@46@10  $FVF<val>) r) r))
  :pattern ((inv@44@10 r))
  :qid |quant-u-68|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))))
  $Snap.unit))
(assert (forall ((i@47@10 Int)) (!
  (and
    (or (<= j@11@10 i@47@10) (not (<= j@11@10 i@47@10)))
    (=>
      (and
        (<= j@11@10 i@47@10)
        (<=
          i@47@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
      (and
        (<= j@11@10 i@47@10)
        (<=
          i@47@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))
        (=>
          (< i@47@10 t@39@10)
          (and
            (< i@47@10 t@39@10)
            ($FVF.loc_val ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10))
            (<= 0 i@47@10)
            (< i@47@10 (length $t@6@10 this@3@10))
            (itemAt%precondition ($Snap.combine
              $t@6@10
              ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@47@10)))
        (or (not (< i@47@10 t@39@10)) (< i@47@10 t@39@10))))
    (or
      (not
        (and
          (<= j@11@10 i@47@10)
          (<=
            i@47@10
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
      (and
        (<= j@11@10 i@47@10)
        (<=
          i@47@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@136@15@136@137-aux|)))
(assert (forall ((i@47@10 Int)) (!
  (=>
    (and
      (and
        (<= j@11@10 i@47@10)
        (<=
          i@47@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
      (< i@47@10 t@39@10))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10))
      (itemAt ($Snap.combine $t@6@10 ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 i@47@10)))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@47@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@136@15@136@137|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))))
  $Snap.unit))
(assert (forall ((i@48@10 Int)) (!
  (and
    (or (< j@11@10 i@48@10) (not (< j@11@10 i@48@10)))
    (=>
      (and
        (< j@11@10 i@48@10)
        (<=
          i@48@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
      (and
        (< j@11@10 i@48@10)
        (<=
          i@48@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))
        (=>
          (> i@48@10 t@39@10)
          (and
            (> i@48@10 t@39@10)
            ($FVF.loc_val ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10))
            (<= 0 (- i@48@10 1))
            (< (- i@48@10 1) (length $t@6@10 this@3@10))
            (itemAt%precondition ($Snap.combine
              $t@6@10
              ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (- i@48@10 1))))
        (or (not (> i@48@10 t@39@10)) (> i@48@10 t@39@10))))
    (or
      (not
        (and
          (< j@11@10 i@48@10)
          (<=
            i@48@10
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
      (and
        (< j@11@10 i@48@10)
        (<=
          i@48@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@137@15@137@138-aux|)))
(assert (forall ((i@48@10 Int)) (!
  (=>
    (and
      (and
        (< j@11@10 i@48@10)
        (<=
          i@48@10
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
      (> i@48@10 t@39@10))
    (=
      ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10))
      (itemAt ($Snap.combine $t@6@10 ($Snap.combine $Snap.unit $Snap.unit)) this@3@10 (-
        i@48@10
        1))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@48@10))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/arraylist-quantified-permissions.vpr@137@15@137@138|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (=
      ($FVF.lookup_val (as sm@42@10  $FVF<val>) r)
      ($FVF.lookup_val (as sm@41@10  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@42@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@41@10  $FVF<val>) r))
  :qid |qp.fvfValDef10|)))
(assert (forall ((r $Ref)) (!
  ($FVF.loc_val ($FVF.lookup_val (as sm@41@10  $FVF<val>) r) r)
  :pattern (($FVF.lookup_val (as sm@42@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef11|)))
(assert (=
  ($FVF.lookup_val (as sm@41@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second ($Snap.second $t@40@10))))))
(assert (<=
  $Perm.No
  (ite
    (=
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (/ (to_real 1) (to_real 2))
    $Perm.No)))
(assert (<=
  (ite
    (=
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (/ (to_real 1) (to_real 2))
    $Perm.No)
  $Perm.Write))
(assert (=>
  (=
    (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)
    (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
  (not
    (=
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)
      $Ref.null))))
(assert ($FVF.loc_val ($FVF.lookup_val (as sm@42@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@40@10)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@40@10))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@40@10))))
  $Snap.unit))
(assert (<= j@11@10 t@39@10))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))
  $Snap.unit))
(assert (<= t@39@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))
  $Snap.unit))
(assert (=
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))
  (length $t@6@10 this@3@10)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))
  $Snap.unit))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))
  $Snap.unit))
(assert (<
  ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))
  (len<Int> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)))))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))))))))
(assert (forall ((i@43@10 Int)) (!
  (=>
    (and
      (< j@11@10 i@43@10)
      (<=
        i@43@10
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
    (or (< j@11@10 i@43@10) (not (< j@11@10 i@43@10))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@43@10))
  :qid |val-aux|)))
(assert (= $t@40@10 ($Snap.combine ($Snap.first $t@40@10) ($Snap.second $t@40@10))))
(assert (=
  ($Snap.second $t@40@10)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@40@10))
    ($Snap.second ($Snap.second $t@40@10)))))
(assert (=
  ($Snap.second ($Snap.second $t@40@10))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@40@10)))
    ($Snap.second ($Snap.second ($Snap.second $t@40@10))))))
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
; [eval] t > j
(pop) ; 9
(push) ; 9
; [eval] !(t > j)
; [eval] t > j
(pop) ; 9
; Loop head block: Follow loop-internal edges
; [eval] t > j
(push) ; 9
(set-option :timeout 10)
(assert (not (not (> t@39@10 j@11@10))))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 9
(set-option :timeout 10)
(assert (not (> t@39@10 j@11@10)))
(check-sat)
; unknown
(pop) ; 9
; 0.00s
; (get-info :all-statistics)
; [then-branch: 40 | t@39@10 > j@11@10 | live]
; [else-branch: 40 | !(t@39@10 > j@11@10) | live]
(set-option :timeout 0)
(push) ; 9
; [then-branch: 40 | t@39@10 > j@11@10]
(assert (> t@39@10 j@11@10))
; [exec]
; loc(this.elems, t).val := loc(this.elems, t - 1).val
; [eval] loc(this.elems, t)
; [eval] loc(this.elems, t - 1)
; [eval] t - 1
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (=
        r
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
      (=
        ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
        ($FVF.lookup_val (as sm@41@10  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@41@10  $FVF<val>) r))
    :qid |qp.fvfValDef12|))
  (forall ((r $Ref)) (!
    (=>
      (and
        (img@45@10 r)
        (and
          (< j@11@10 (inv@44@10 r))
          (<=
            (inv@44@10 r)
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
      (=
        ($FVF.lookup_val (as sm@46@10  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r)))
    :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r))
    :qid |qp.fvfValDef13|))
  (forall ((r $Ref)) (!
    (and
      ($FVF.loc_val ($FVF.lookup_val (as sm@41@10  $FVF<val>) r) r)
      ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r) r))
    :pattern (($FVF.lookup_val (as sm@46@10  $FVF<val>) r))
    :qid |qp.fvfResTrgDef14|))))
(assert ($FVF.loc_val ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) (-
  t@39@10
  1))) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) (-
  t@39@10
  1))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (=
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) (-
          t@39@10
          1))
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
      (/ (to_real 1) (to_real 2))
      $Perm.No)
    (ite
      (and
        (img@45@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) (-
          t@39@10
          1)))
        (and
          (<
            j@11@10
            (inv@44@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) (-
              t@39@10
              1))))
          (<=
            (inv@44@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) (-
              t@39@10
              1)))
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for snapshot map values
(assert ($FVF.loc_val ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10)))
(push) ; 10
(set-option :timeout 10)
(assert (not (=
  (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)
  (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10))))
(check-sat)
; unknown
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; Precomputing data for removing quantified permissions
(define-fun pTaken@59@10 ((r $Ref)) $Perm
  (ite
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10))
    ($Perm.min
      (ite
        (and
          (img@45@10 r)
          (and
            (< j@11@10 (inv@44@10 r))
            (<=
              (inv@44@10 r)
              ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
        $Perm.Write
        $Perm.No)
      $Perm.Write)
    $Perm.No))
(define-fun pTaken@60@10 ((r $Ref)) $Perm
  (ite
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10))
    ($Perm.min
      (ite
        (=
          r
          (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
        (/ (to_real 1) (to_real 2))
        $Perm.No)
      (- $Perm.Write (pTaken@59@10 r)))
    $Perm.No))
; Done precomputing, updating quantified chunks
; State saturation: before repetition
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
          (img@45@10 r)
          (and
            (< j@11@10 (inv@44@10 r))
            (<=
              (inv@44@10 r)
              ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
        $Perm.Write
        $Perm.No)
      (pTaken@59@10 r))
    $Perm.No)
  
  :qid |quant-u-84|))))
(check-sat)
; unknown
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 10
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@59@10 r) $Perm.No)
  
  :qid |quant-u-85|))))
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
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10))
    (= (- $Perm.Write (pTaken@59@10 r)) $Perm.No))
  
  :qid |quant-u-86|))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@61@10 $FVF<val>)
; Definitional axioms for singleton-FVF's value
(assert (=
  ($FVF.lookup_val (as sm@61@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10))
  ($FVF.lookup_val (as sm@46@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) (-
    t@39@10
    1)))))
(assert ($FVF.loc_val ($FVF.lookup_val (as sm@61@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10)))
; [exec]
; t := t - 1
; [eval] t - 1
(declare-const t@62@10 Int)
(assert (= t@62@10 (- t@39@10 1)))
; Loop head block: Re-establish invariant
; [eval] loc(this.elems, j)
(declare-const sm@63@10 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10))
    (=
      ($FVF.lookup_val (as sm@63@10  $FVF<val>) r)
      ($FVF.lookup_val (as sm@61@10  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@63@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@61@10  $FVF<val>) r))
  :qid |qp.fvfValDef18|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (=
      ($FVF.lookup_val (as sm@63@10  $FVF<val>) r)
      ($FVF.lookup_val (as sm@41@10  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@63@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@41@10  $FVF<val>) r))
  :qid |qp.fvfValDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@45@10 r)
        (and
          (< j@11@10 (inv@44@10 r))
          (<=
            (inv@44@10 r)
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
      (< $Perm.No (- $Perm.Write (pTaken@59@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@63@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@63@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r))
  :qid |qp.fvfValDef20|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val (as sm@61@10  $FVF<val>) r) r)
    ($FVF.loc_val ($FVF.lookup_val (as sm@41@10  $FVF<val>) r) r)
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r) r))
  :pattern (($FVF.lookup_val (as sm@63@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef21|)))
(assert ($FVF.loc_val ($FVF.lookup_val (as sm@63@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@64@10 ((r $Ref)) $Perm
  (ite
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    ($Perm.min
      (ite
        (=
          r
          (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
        (/ (to_real 1) (to_real 2))
        $Perm.No)
      (/ (to_real 1) (to_real 2)))
    $Perm.No))
(define-fun pTaken@65@10 ((r $Ref)) $Perm
  (ite
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    ($Perm.min
      (ite
        (=
          r
          (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10))
        $Perm.Write
        $Perm.No)
      (- (/ (to_real 1) (to_real 2)) (pTaken@64@10 r)))
    $Perm.No))
(define-fun pTaken@66@10 ((r $Ref)) $Perm
  (ite
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    ($Perm.min
      (ite
        (and
          (img@45@10 r)
          (and
            (< j@11@10 (inv@44@10 r))
            (<=
              (inv@44@10 r)
              ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
        (- $Perm.Write (pTaken@59@10 r))
        $Perm.No)
      (- (- (/ (to_real 1) (to_real 2)) (pTaken@64@10 r)) (pTaken@65@10 r)))
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
(assert (not (=
  (-
    (ite
      (=
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
      (/ (to_real 1) (to_real 2))
      $Perm.No)
    (pTaken@64@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)))
  $Perm.No)))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 10
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    (= (- (/ (to_real 1) (to_real 2)) (pTaken@64@10 r)) $Perm.No))
  
  :qid |quant-u-89|))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
; Definitional axioms for snapshot map values (instantiated)
(assert (=>
  (=
    (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)
    (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10))
  (=
    ($FVF.lookup_val (as sm@63@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    ($FVF.lookup_val (as sm@61@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)))))
(assert (=>
  (=
    (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)
    (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
  (=
    ($FVF.lookup_val (as sm@63@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    ($FVF.lookup_val (as sm@41@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)))))
(assert (=>
  (ite
    (and
      (img@45@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
      (and
        (<
          j@11@10
          (inv@44@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)))
        (<=
          (inv@44@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
    (<
      $Perm.No
      (-
        $Perm.Write
        (pTaken@59@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))))
    false)
  (=
    ($FVF.lookup_val (as sm@63@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
    ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)))))
(assert (and
  ($FVF.loc_val ($FVF.lookup_val (as sm@61@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
  ($FVF.loc_val ($FVF.lookup_val (as sm@41@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))
  ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) j@11@10))))
; [eval] j <= t
(set-option :timeout 0)
(push) ; 10
(assert (not (<= j@11@10 t@62@10)))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(assert (<= j@11@10 t@62@10))
; [eval] t <= this.size
(push) ; 10
(assert (not (<= t@62@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(assert (<= t@62@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
; [eval] this.size == old(length(this))
; [eval] old(length(this))
; [eval] length(this)
(push) ; 10
(pop) ; 10
; Joined path conditions
; [eval] -1 <= j
; [eval] -1
; [eval] this.size < len(this.elems)
; [eval] len(this.elems)
(declare-const i@67@10 Int)
(push) ; 10
; [eval] j < i && i <= this.size
; [eval] j < i
(push) ; 11
; [then-branch: 41 | !(j@11@10 < i@67@10) | live]
; [else-branch: 41 | j@11@10 < i@67@10 | live]
(push) ; 12
; [then-branch: 41 | !(j@11@10 < i@67@10)]
(assert (not (< j@11@10 i@67@10)))
(pop) ; 12
(push) ; 12
; [else-branch: 41 | j@11@10 < i@67@10]
(assert (< j@11@10 i@67@10))
; [eval] i <= this.size
(pop) ; 12
(pop) ; 11
; Joined path conditions
; Joined path conditions
(assert (or (< j@11@10 i@67@10) (not (< j@11@10 i@67@10))))
(assert (and
  (< j@11@10 i@67@10)
  (<= i@67@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
; [eval] loc(this.elems, i)
(pop) ; 10
(declare-fun inv@68@10 ($Ref) Int)
(declare-fun img@69@10 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@67@10 Int)) (!
  (=>
    (and
      (< j@11@10 i@67@10)
      (<=
        i@67@10
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
    (or (< j@11@10 i@67@10) (not (< j@11@10 i@67@10))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@67@10))
  :qid |val-aux|)))
(declare-const sm@70@10 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and
        (img@45@10 r)
        (and
          (< j@11@10 (inv@44@10 r))
          (<=
            (inv@44@10 r)
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
      (< $Perm.No (- $Perm.Write (pTaken@59@10 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@70@10  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@70@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r))
  :qid |qp.fvfValDef22|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10))
    (=
      ($FVF.lookup_val (as sm@70@10  $FVF<val>) r)
      ($FVF.lookup_val (as sm@61@10  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@70@10  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@61@10  $FVF<val>) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (and
    ($FVF.loc_val ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@40@10)))))))))) r) r)
    ($FVF.loc_val ($FVF.lookup_val (as sm@61@10  $FVF<val>) r) r))
  :pattern (($FVF.lookup_val (as sm@70@10  $FVF<val>) r))
  :qid |qp.fvfResTrgDef24|)))
; Check receiver injectivity
(push) ; 10
(assert (not (forall ((i1@67@10 Int) (i2@67@10 Int)) (!
  (=>
    (and
      (and
        (and
          (< j@11@10 i1@67@10)
          (<=
            i1@67@10
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
        ($FVF.loc_val ($FVF.lookup_val (as sm@70@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i1@67@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i1@67@10)))
      (and
        (and
          (< j@11@10 i2@67@10)
          (<=
            i2@67@10
            ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
        ($FVF.loc_val ($FVF.lookup_val (as sm@70@10  $FVF<val>) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i2@67@10)) (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i2@67@10)))
      (=
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i1@67@10)
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i2@67@10)))
    (= i1@67@10 i2@67@10))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@67@10 Int)) (!
  (=>
    (and
      (< j@11@10 i@67@10)
      (<=
        i@67@10
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
    (and
      (=
        (inv@68@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@67@10))
        i@67@10)
      (img@69@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@67@10))))
  :pattern ((loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) i@67@10))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@69@10 r)
      (and
        (< j@11@10 (inv@68@10 r))
        (<=
          (inv@68@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
    (=
      (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) (inv@68@10 r))
      r))
  :pattern ((inv@68@10 r))
  :qid |val-fctOfInv|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (< j@11@10 (inv@68@10 r))
      (<=
        (inv@68@10 r)
        ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
    ($FVF.loc_val ($FVF.lookup_val (as sm@70@10  $FVF<val>) r) r))
  :pattern ((inv@68@10 r))
  :qid |quant-u-91|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@71@10 ((r $Ref)) $Perm
  (ite
    (and
      (and
        (< j@11@10 (inv@68@10 r))
        (<=
          (inv@68@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
      (img@69@10 r)
      (=
        r
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) (inv@68@10 r))))
    ($Perm.min
      (ite
        (and
          (img@45@10 r)
          (and
            (< j@11@10 (inv@44@10 r))
            (<=
              (inv@44@10 r)
              ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
        (- $Perm.Write (pTaken@59@10 r))
        $Perm.No)
      $Perm.Write)
    $Perm.No))
(define-fun pTaken@72@10 ((r $Ref)) $Perm
  (ite
    (and
      (and
        (< j@11@10 (inv@68@10 r))
        (<=
          (inv@68@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
      (img@69@10 r)
      (=
        r
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) (inv@68@10 r))))
    ($Perm.min
      (ite
        (=
          r
          (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10))
        $Perm.Write
        $Perm.No)
      (- $Perm.Write (pTaken@71@10 r)))
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
          (img@45@10 r)
          (and
            (< j@11@10 (inv@44@10 r))
            (<=
              (inv@44@10 r)
              ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
        (- $Perm.Write (pTaken@59@10 r))
        $Perm.No)
      (pTaken@71@10 r))
    $Perm.No)
  
  :qid |quant-u-93|))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 10
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and
        (< j@11@10 (inv@68@10 r))
        (<=
          (inv@68@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
      (img@69@10 r)
      (=
        r
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) (inv@68@10 r))))
    (= (- $Perm.Write (pTaken@71@10 r)) $Perm.No))
  
  :qid |quant-u-94|))))
(check-sat)
; unknown
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 10
(set-option :timeout 500)
(assert (not (=
  (-
    (ite
      (=
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10)
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10))
      $Perm.Write
      $Perm.No)
    (pTaken@72@10 (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) t@39@10)))
  $Perm.No)))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 10
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (and
      (and
        (< j@11@10 (inv@68@10 r))
        (<=
          (inv@68@10 r)
          ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10)))))
      (img@69@10 r)
      (=
        r
        (loc<Ref> ($SortWrappers.$SnapToArray_ ($Snap.first $t@40@10)) (inv@68@10 r))))
    (= (- (- $Perm.Write (pTaken@71@10 r)) (pTaken@72@10 r)) $Perm.No))
  
  :qid |quant-u-96|))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
; Definitional axioms for snapshot map values
; [eval] (forall i: Int :: { loc(this.elems, i) } j <= i && i <= this.size ==> i < t ==> loc(this.elems, i).val == old(itemAt(this, i)))
(declare-const i@73@10 Int)
(set-option :timeout 0)
(push) ; 10
; [eval] j <= i && i <= this.size ==> i < t ==> loc(this.elems, i).val == old(itemAt(this, i))
; [eval] j <= i && i <= this.size
; [eval] j <= i
(push) ; 11
; [then-branch: 42 | !(j@11@10 <= i@73@10) | live]
; [else-branch: 42 | j@11@10 <= i@73@10 | live]
(push) ; 12
; [then-branch: 42 | !(j@11@10 <= i@73@10)]
(assert (not (<= j@11@10 i@73@10)))
(pop) ; 12
(push) ; 12
; [else-branch: 42 | j@11@10 <= i@73@10]
(assert (<= j@11@10 i@73@10))
; [eval] i <= this.size
(pop) ; 12
(pop) ; 11
; Joined path conditions
; Joined path conditions
(assert (or (<= j@11@10 i@73@10) (not (<= j@11@10 i@73@10))))
(push) ; 11
; [then-branch: 43 | j@11@10 <= i@73@10 && i@73@10 <= First:(Second:($t@40@10)) | live]
; [else-branch: 43 | !(j@11@10 <= i@73@10 && i@73@10 <= First:(Second:($t@40@10))) | live]
(push) ; 12
; [then-branch: 43 | j@11@10 <= i@73@10 && i@73@10 <= First:(Second:($t@40@10))]
(assert (and
  (<= j@11@10 i@73@10)
  (<= i@73@10 ($SortWrappers.$SnapToInt ($Snap.first ($Snap.second $t@40@10))))))
; [eval] i < t ==> loc(this.elems, i).val == old(itemAt(this, i))
; [eval] i < t
(push) ; 13
; [then-branch: 44 | i@73@10 < t@62@10 | live]
; [else-branch: 44 | !(i@73@10 < t@62@10) | live]
(push) ; 14
; [then-branch: 44 | i@73@10 < t@62@10]
(assert (< i@73@10 t@62@10))
; [eval] loc(this.elems, i).val == old(itemAt(this, i))
; [eval] loc(this.elems, i)
