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
; ---------- create ----------
(declare-const this@0@12 $Ref)
(declare-const this@1@12 $Ref)
(set-option :timeout 0)
(push) ; 1
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
(set-option :timeout 0)
(push) ; 2
(declare-const $t@2@12 $Snap)
(assert (= $t@2@12 ($Snap.combine ($Snap.first $t@2@12) ($Snap.second $t@2@12))))
(assert (= ($Snap.second $t@2@12) $Snap.unit))
; [eval] length(this) == 0
; [eval] length(this)
(push) ; 3
(assert (length%precondition ($Snap.first $t@2@12) this@1@12))
(pop) ; 3
; Joined path conditions
(assert (length%precondition ($Snap.first $t@2@12) this@1@12))
(assert (= (length ($Snap.first $t@2@12) this@1@12) 0))
(pop) ; 2
(push) ; 2
; [exec]
; var a: Array
(declare-const a@3@12 Array_)
; [exec]
; this := new(elems, size)
(declare-const this@4@12 $Ref)
(assert (not (= this@4@12 $Ref.null)))
(declare-const elems@5@12 Array_)
(declare-const size@6@12 Int)
(assert (not (= this@4@12 this@1@12)))
; [exec]
; inhale len(a) == 10
(declare-const $t@7@12 $Snap)
(assert (= $t@7@12 $Snap.unit))
; [eval] len(a) == 10
; [eval] len(a)
(assert (= (len<Int> a@3@12) 10))
; State saturation: after inhale
(set-option :timeout 20)
(check-sat)
; unknown
; [exec]
; inhale (forall i: Int ::0 <= i && i < len(a) ==> acc(loc(a, i).val, write))
(declare-const i@8@12 Int)
(set-option :timeout 0)
(push) ; 3
; [eval] 0 <= i && i < len(a)
; [eval] 0 <= i
(push) ; 4
; [then-branch: 0 | !(0 <= i@8@12) | live]
; [else-branch: 0 | 0 <= i@8@12 | live]
(push) ; 5
; [then-branch: 0 | !(0 <= i@8@12)]
(assert (not (<= 0 i@8@12)))
(pop) ; 5
(push) ; 5
; [else-branch: 0 | 0 <= i@8@12]
(assert (<= 0 i@8@12))
; [eval] i < len(a)
; [eval] len(a)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@8@12) (not (<= 0 i@8@12))))
(assert (and (<= 0 i@8@12) (< i@8@12 (len<Int> a@3@12))))
; [eval] loc(a, i)
(pop) ; 3
(declare-const $t@9@12 $FVF<val>)
(declare-fun inv@10@12 ($Ref) Int)
(declare-fun img@11@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@8@12 Int)) (!
  (=>
    (and (<= 0 i@8@12) (< i@8@12 (len<Int> a@3@12)))
    (or (<= 0 i@8@12) (not (<= 0 i@8@12))))
  :pattern ((loc<Ref> a@3@12 i@8@12))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((i1@8@12 Int) (i2@8@12 Int)) (!
  (=>
    (and
      (and (<= 0 i1@8@12) (< i1@8@12 (len<Int> a@3@12)))
      (and (<= 0 i2@8@12) (< i2@8@12 (len<Int> a@3@12)))
      (= (loc<Ref> a@3@12 i1@8@12) (loc<Ref> a@3@12 i2@8@12)))
    (= i1@8@12 i2@8@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@8@12 Int)) (!
  (=>
    (and (<= 0 i@8@12) (< i@8@12 (len<Int> a@3@12)))
    (and
      (= (inv@10@12 (loc<Ref> a@3@12 i@8@12)) i@8@12)
      (img@11@12 (loc<Ref> a@3@12 i@8@12))))
  :pattern ((loc<Ref> a@3@12 i@8@12))
  :qid |quant-u-17|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@11@12 r)
      (and (<= 0 (inv@10@12 r)) (< (inv@10@12 r) (len<Int> a@3@12))))
    (= (loc<Ref> a@3@12 (inv@10@12 r)) r))
  :pattern ((inv@10@12 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((i@8@12 Int)) (!
  (=>
    (and (<= 0 i@8@12) (< i@8@12 (len<Int> a@3@12)))
    (not (= (loc<Ref> a@3@12 i@8@12) $Ref.null)))
  :pattern ((loc<Ref> a@3@12 i@8@12))
  :qid |val-permImpliesNonNull|)))
; State saturation: after inhale
(set-option :timeout 20)
(check-sat)
; unknown
; [exec]
; this.size := 0
; [exec]
; this.elems := a
; [exec]
; fold acc(AList(this), write)
; [eval] 0 <= this.size
; [eval] this.size <= len(this.elems)
; [eval] len(this.elems)
(set-option :timeout 0)
(push) ; 3
(assert (not (<= 0 (len<Int> a@3@12))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (<= 0 (len<Int> a@3@12)))
; [eval] 0 < len(this.elems)
; [eval] len(this.elems)
(push) ; 3
(assert (not (< 0 (len<Int> a@3@12))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (< 0 (len<Int> a@3@12)))
(declare-const i@12@12 Int)
(push) ; 3
; [eval] 0 <= i && i < len(this.elems)
; [eval] 0 <= i
(push) ; 4
; [then-branch: 1 | !(0 <= i@12@12) | live]
; [else-branch: 1 | 0 <= i@12@12 | live]
(push) ; 5
; [then-branch: 1 | !(0 <= i@12@12)]
(assert (not (<= 0 i@12@12)))
(pop) ; 5
(push) ; 5
; [else-branch: 1 | 0 <= i@12@12]
(assert (<= 0 i@12@12))
; [eval] i < len(this.elems)
; [eval] len(this.elems)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (<= 0 i@12@12) (not (<= 0 i@12@12))))
(assert (and (<= 0 i@12@12) (< i@12@12 (len<Int> a@3@12))))
; [eval] loc(this.elems, i)
(pop) ; 3
(declare-fun inv@13@12 ($Ref) Int)
(declare-fun img@14@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(assert (forall ((i@12@12 Int)) (!
  (=>
    (and (<= 0 i@12@12) (< i@12@12 (len<Int> a@3@12)))
    (or (<= 0 i@12@12) (not (<= 0 i@12@12))))
  :pattern ((loc<Ref> a@3@12 i@12@12))
  :qid |val-aux|)))
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((i1@12@12 Int) (i2@12@12 Int)) (!
  (=>
    (and
      (and (<= 0 i1@12@12) (< i1@12@12 (len<Int> a@3@12)))
      (and (<= 0 i2@12@12) (< i2@12@12 (len<Int> a@3@12)))
      (= (loc<Ref> a@3@12 i1@12@12) (loc<Ref> a@3@12 i2@12@12)))
    (= i1@12@12 i2@12@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((i@12@12 Int)) (!
  (=>
    (and (<= 0 i@12@12) (< i@12@12 (len<Int> a@3@12)))
    (and
      (= (inv@13@12 (loc<Ref> a@3@12 i@12@12)) i@12@12)
      (img@14@12 (loc<Ref> a@3@12 i@12@12))))
  :pattern ((loc<Ref> a@3@12 i@12@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@14@12 r)
      (and (<= 0 (inv@13@12 r)) (< (inv@13@12 r) (len<Int> a@3@12))))
    (= (loc<Ref> a@3@12 (inv@13@12 r)) r))
  :pattern ((inv@13@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@15@12 ((r $Ref)) $Perm
  (ite
    (and
      (and (<= 0 (inv@13@12 r)) (< (inv@13@12 r) (len<Int> a@3@12)))
      (img@14@12 r)
      (= r (loc<Ref> a@3@12 (inv@13@12 r))))
    ($Perm.min
      (ite
        (and
          (img@11@12 r)
          (and (<= 0 (inv@10@12 r)) (< (inv@10@12 r) (len<Int> a@3@12))))
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
          (img@11@12 r)
          (and (<= 0 (inv@10@12 r)) (< (inv@10@12 r) (len<Int> a@3@12))))
        $Perm.Write
        $Perm.No)
      (pTaken@15@12 r))
    $Perm.No)
  
  :qid |quant-u-20|))))
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
      (and (<= 0 (inv@13@12 r)) (< (inv@13@12 r) (len<Int> a@3@12)))
      (img@14@12 r)
      (= r (loc<Ref> a@3@12 (inv@13@12 r))))
    (= (- $Perm.Write (pTaken@15@12 r)) $Perm.No))
  
  :qid |quant-u-21|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@16@12 $FVF<val>)
; Definitional axioms for snapshot map domain
(assert (forall ((r $Ref)) (!
  (and
    (=>
      (Set_in r ($FVF.domain_val (as sm@16@12  $FVF<val>)))
      (and
        (and (<= 0 (inv@13@12 r)) (< (inv@13@12 r) (len<Int> a@3@12)))
        (img@14@12 r)))
    (=>
      (and
        (and (<= 0 (inv@13@12 r)) (< (inv@13@12 r) (len<Int> a@3@12)))
        (img@14@12 r))
      (Set_in r ($FVF.domain_val (as sm@16@12  $FVF<val>)))))
  :pattern ((Set_in r ($FVF.domain_val (as sm@16@12  $FVF<val>))))
  :qid |qp.fvfDomDef1|)))
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (and
        (and (<= 0 (inv@13@12 r)) (< (inv@13@12 r) (len<Int> a@3@12)))
        (img@14@12 r))
      (and
        (img@11@12 r)
        (and (<= 0 (inv@10@12 r)) (< (inv@10@12 r) (len<Int> a@3@12)))))
    (= ($FVF.lookup_val (as sm@16@12  $FVF<val>) r) ($FVF.lookup_val $t@9@12 r)))
  :pattern (($FVF.lookup_val (as sm@16@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val $t@9@12 r))
  :qid |qp.fvfValDef0|)))
(assert (AList%trigger ($Snap.combine
  ($SortWrappers.Array_To$Snap a@3@12)
  ($Snap.combine
    ($SortWrappers.IntTo$Snap 0)
    ($Snap.combine
      $Snap.unit
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($SortWrappers.$FVF<val>To$Snap (as sm@16@12  $FVF<val>))))))) this@4@12))
; [eval] length(this) == 0
; [eval] length(this)
(set-option :timeout 0)
(push) ; 3
(assert (length%precondition ($Snap.combine
  ($SortWrappers.Array_To$Snap a@3@12)
  ($Snap.combine
    ($SortWrappers.IntTo$Snap 0)
    ($Snap.combine
      $Snap.unit
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($SortWrappers.$FVF<val>To$Snap (as sm@16@12  $FVF<val>))))))) this@4@12))
(pop) ; 3
; Joined path conditions
(assert (length%precondition ($Snap.combine
  ($SortWrappers.Array_To$Snap a@3@12)
  ($Snap.combine
    ($SortWrappers.IntTo$Snap 0)
    ($Snap.combine
      $Snap.unit
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($SortWrappers.$FVF<val>To$Snap (as sm@16@12  $FVF<val>))))))) this@4@12))
(push) ; 3
(assert (not (=
  (length ($Snap.combine
    ($SortWrappers.Array_To$Snap a@3@12)
    ($Snap.combine
      ($SortWrappers.IntTo$Snap 0)
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($Snap.combine
            $Snap.unit
            ($SortWrappers.$FVF<val>To$Snap (as sm@16@12  $FVF<val>))))))) this@4@12)
  0)))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (=
  (length ($Snap.combine
    ($SortWrappers.Array_To$Snap a@3@12)
    ($Snap.combine
      ($SortWrappers.IntTo$Snap 0)
      ($Snap.combine
        $Snap.unit
        ($Snap.combine
          $Snap.unit
          ($Snap.combine
            $Snap.unit
            ($SortWrappers.$FVF<val>To$Snap (as sm@16@12  $FVF<val>))))))) this@4@12)
  0))
(pop) ; 2
(pop) ; 1
