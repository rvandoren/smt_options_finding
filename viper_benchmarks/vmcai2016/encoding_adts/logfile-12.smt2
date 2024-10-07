(get-info :version)
; (:version "4.13.0")
; Started: 2024-09-24 15:31:55
; Silicon.version: 1.1-SNAPSHOT (b737e366)
; Input file: /Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/encoding-adts.vpr
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
(declare-sort list 0)
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
(declare-fun $SortWrappers.listTo$Snap (list) $Snap)
(declare-fun $SortWrappers.$SnapTolist ($Snap) list)
(assert (forall ((x list)) (!
    (= x ($SortWrappers.$SnapTolist($SortWrappers.listTo$Snap x)))
    :pattern (($SortWrappers.listTo$Snap x))
    :qid |$Snap.$SnapTolistTo$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.listTo$Snap($SortWrappers.$SnapTolist x)))
    :pattern (($SortWrappers.$SnapTolist x))
    :qid |$Snap.listTo$SnapTolist|
    )))
; ////////// Symbols
(declare-const Nil<list> list)
(declare-fun Cons<list> (Int list) list)
(declare-fun head_Cons<Int> (list) Int)
(declare-fun tail_Cons<list> (list) list)
(declare-fun type<Int> (list) Int)
(declare-const type_Nil<Int> Int)
(declare-const type_Cons<Int> Int)
(declare-fun is_Nil<Bool> (list) Bool)
(declare-fun is_Cons<Bool> (list) Bool)
; Declaring symbols related to program functions (from program analysis)
; Snapshot variable to be used during function verification
(declare-fun s@$ () $Snap)
; Declaring predicate trigger functions
; ////////// Uniqueness assumptions from domains
(assert (distinct type_Nil<Int> type_Cons<Int>))
; ////////// Axioms
(assert (forall ((head Int) (tail list)) (!
  (and
    (= (head_Cons<Int> (Cons<list> head tail)) head)
    (= (tail_Cons<list> (Cons<list> head tail)) tail))
  :pattern ((Cons<list> head tail))
  :qid |prog.destruct_over_construct_Cons|)))
(assert (forall ((xs list)) (!
  (=>
    (is_Cons<Bool> xs)
    (= xs (Cons<list> (head_Cons<Int> xs) (tail_Cons<list> xs))))
  :pattern ((head_Cons<Int> xs))
  :pattern ((tail_Cons<list> xs))
  :qid |prog.construct_over_destruct_Cons|)))
(assert (= (type<Int> (as Nil<list>  list)) (as type_Nil<Int>  Int)))
(assert (forall ((head Int) (tail list)) (!
  (= (type<Int> (Cons<list> head tail)) (as type_Cons<Int>  Int))
  :pattern ((type<Int> (Cons<list> head tail)))
  :qid |prog.type_of_Cons|)))
(assert (forall ((xs list)) (!
  (or
    (= (type<Int> xs) (as type_Nil<Int>  Int))
    (= (type<Int> xs) (as type_Cons<Int>  Int)))
  :pattern ((type<Int> xs))
  :qid |prog.type_existence|)))
(assert (forall ((xs list)) (!
  (= (= (type<Int> xs) (as type_Nil<Int>  Int)) (is_Nil<Bool> xs))
  :pattern ((type<Int> xs))
  :pattern ((is_Nil<Bool> xs))
  :qid |prog.type_is_Nil|)))
(assert (forall ((xs list)) (!
  (= (= (type<Int> xs) (as type_Cons<Int>  Int)) (is_Cons<Bool> xs))
  :pattern ((type<Int> xs))
  :pattern ((is_Cons<Bool> xs))
  :qid |prog.type_IsElem|)))
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
; ---------- test_types ----------
(declare-const x@0@12 list)
(declare-const x@1@12 list)
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
; assert is_Nil(x) == !is_Cons(x)
; [eval] is_Nil(x) == !is_Cons(x)
; [eval] is_Nil(x)
; [eval] !is_Cons(x)
; [eval] is_Cons(x)
(push) ; 3
(assert (not (= (is_Nil<Bool> x@1@12) (not (is_Cons<Bool> x@1@12)))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (= (is_Nil<Bool> x@1@12) (not (is_Cons<Bool> x@1@12))))
(pop) ; 2
(pop) ; 1
