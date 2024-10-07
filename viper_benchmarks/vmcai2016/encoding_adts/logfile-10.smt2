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
; ---------- pattern_match_exhaustiveness_test ----------
(declare-const xs@0@10 list)
(declare-const xs@1@10 list)
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
; assert !is_Nil(xs) &&
;   (!(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))) &&
;   !(is_Cons(xs) &&
;   (let y ==
;     (head_Cons(xs)) in
;     (let ys ==
;       (tail_Cons(xs)) in
;       is_Cons(ys))))) ==>
;   false
; [eval] !is_Nil(xs) && (!(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))) && !(is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys))))) ==> false
; [eval] !is_Nil(xs) && (!(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))) && !(is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys)))))
; [eval] !is_Nil(xs)
; [eval] is_Nil(xs)
(push) ; 3
; [then-branch: 0 | is_Nil[Bool](xs@1@10) | live]
; [else-branch: 0 | !(is_Nil[Bool](xs@1@10)) | live]
(push) ; 4
; [then-branch: 0 | is_Nil[Bool](xs@1@10)]
(assert (is_Nil<Bool> xs@1@10))
(pop) ; 4
(push) ; 4
; [else-branch: 0 | !(is_Nil[Bool](xs@1@10))]
(assert (not (is_Nil<Bool> xs@1@10)))
; [eval] !(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys)))
; [eval] is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))
; [eval] is_Cons(xs)
(push) ; 5
; [then-branch: 1 | !(is_Cons[Bool](xs@1@10)) | live]
; [else-branch: 1 | is_Cons[Bool](xs@1@10) | live]
(push) ; 6
; [then-branch: 1 | !(is_Cons[Bool](xs@1@10))]
(assert (not (is_Cons<Bool> xs@1@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 1 | is_Cons[Bool](xs@1@10)]
(assert (is_Cons<Bool> xs@1@10))
; [eval] (let ys == (tail_Cons(xs)) in is_Nil(ys))
; [eval] tail_Cons(xs)
(declare-const letvar@2@10 list)
(assert (= (as letvar@2@10  list) (tail_Cons<list> xs@1@10)))
; [eval] is_Nil(ys)
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (=>
  (is_Cons<Bool> xs@1@10)
  (and
    (is_Cons<Bool> xs@1@10)
    (= (as letvar@2@10  list) (tail_Cons<list> xs@1@10)))))
(assert (or (is_Cons<Bool> xs@1@10) (not (is_Cons<Bool> xs@1@10))))
(push) ; 5
; [then-branch: 2 | is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10)) | live]
; [else-branch: 2 | !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) | live]
(push) ; 6
; [then-branch: 2 | is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))]
(assert (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
(pop) ; 6
(push) ; 6
; [else-branch: 2 | !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10)))]
(assert (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10)))))
; [eval] !(is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys))))
; [eval] is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys)))
; [eval] is_Cons(xs)
(push) ; 7
; [then-branch: 3 | !(is_Cons[Bool](xs@1@10)) | live]
; [else-branch: 3 | is_Cons[Bool](xs@1@10) | live]
(push) ; 8
; [then-branch: 3 | !(is_Cons[Bool](xs@1@10))]
(assert (not (is_Cons<Bool> xs@1@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 3 | is_Cons[Bool](xs@1@10)]
(assert (is_Cons<Bool> xs@1@10))
; [eval] (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys)))
; [eval] head_Cons(xs)
(declare-const letvar@3@10 Int)
(assert (= (as letvar@3@10  Int) (head_Cons<Int> xs@1@10)))
; [eval] (let ys == (tail_Cons(xs)) in is_Cons(ys))
; [eval] tail_Cons(xs)
(declare-const letvar@4@10 list)
(assert (= (as letvar@4@10  list) (tail_Cons<list> xs@1@10)))
; [eval] is_Cons(ys)
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (=>
  (is_Cons<Bool> xs@1@10)
  (and
    (is_Cons<Bool> xs@1@10)
    (= (as letvar@3@10  Int) (head_Cons<Int> xs@1@10))
    (= (as letvar@4@10  list) (tail_Cons<list> xs@1@10)))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
  (and
    (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
    (=>
      (is_Cons<Bool> xs@1@10)
      (and
        (is_Cons<Bool> xs@1@10)
        (= (as letvar@3@10  Int) (head_Cons<Int> xs@1@10))
        (= (as letvar@4@10  list) (tail_Cons<list> xs@1@10)))))))
(assert (or
  (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
  (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10)))))
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (is_Nil<Bool> xs@1@10))
  (and
    (not (is_Nil<Bool> xs@1@10))
    (=>
      (is_Cons<Bool> xs@1@10)
      (and
        (is_Cons<Bool> xs@1@10)
        (= (as letvar@2@10  list) (tail_Cons<list> xs@1@10))))
    (or (is_Cons<Bool> xs@1@10) (not (is_Cons<Bool> xs@1@10)))
    (=>
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (and
        (not
          (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
        (=>
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> xs@1@10)
            (= (as letvar@3@10  Int) (head_Cons<Int> xs@1@10))
            (= (as letvar@4@10  list) (tail_Cons<list> xs@1@10))))))
    (or
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10)))))))
(assert (or (not (is_Nil<Bool> xs@1@10)) (is_Nil<Bool> xs@1@10)))
(push) ; 3
(push) ; 4
(set-option :timeout 10)
(assert (not (not
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Cons<Bool> (tail_Cons<list> xs@1@10)))))))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; [then-branch: 4 | !(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10))) | dead]
; [else-branch: 4 | !(!(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)))) | live]
(set-option :timeout 0)
(push) ; 4
; [else-branch: 4 | !(!(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10))))]
(assert (not
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Cons<Bool> (tail_Cons<list> xs@1@10))))))))
(pop) ; 4
(pop) ; 3
; Joined path conditions
(assert (not
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Cons<Bool> (tail_Cons<list> xs@1@10))))))))
; [exec]
; assert !is_Nil(xs) &&
;   (!(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))) &&
;   !(is_Cons(xs) &&
;   (let y ==
;     (head_Cons(xs)) in
;     (let ys ==
;       (tail_Cons(xs)) in
;       is_Cons(ys) && (let z == (head_Cons(ys)) in y < z))))) ==>
;   false
; [eval] !is_Nil(xs) && (!(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))) && !(is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z))))) ==> false
; [eval] !is_Nil(xs) && (!(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))) && !(is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)))))
; [eval] !is_Nil(xs)
; [eval] is_Nil(xs)
(push) ; 3
; [then-branch: 5 | is_Nil[Bool](xs@1@10) | live]
; [else-branch: 5 | !(is_Nil[Bool](xs@1@10)) | live]
(push) ; 4
; [then-branch: 5 | is_Nil[Bool](xs@1@10)]
(assert (is_Nil<Bool> xs@1@10))
(pop) ; 4
(push) ; 4
; [else-branch: 5 | !(is_Nil[Bool](xs@1@10))]
(assert (not (is_Nil<Bool> xs@1@10)))
; [eval] !(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys)))
; [eval] is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))
; [eval] is_Cons(xs)
(push) ; 5
; [then-branch: 6 | !(is_Cons[Bool](xs@1@10)) | live]
; [else-branch: 6 | is_Cons[Bool](xs@1@10) | live]
(push) ; 6
; [then-branch: 6 | !(is_Cons[Bool](xs@1@10))]
(assert (not (is_Cons<Bool> xs@1@10)))
(pop) ; 6
(push) ; 6
; [else-branch: 6 | is_Cons[Bool](xs@1@10)]
(assert (is_Cons<Bool> xs@1@10))
; [eval] (let ys == (tail_Cons(xs)) in is_Nil(ys))
; [eval] tail_Cons(xs)
(declare-const letvar@5@10 list)
(assert (= (as letvar@5@10  list) (tail_Cons<list> xs@1@10)))
; [eval] is_Nil(ys)
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (=>
  (is_Cons<Bool> xs@1@10)
  (and
    (is_Cons<Bool> xs@1@10)
    (= (as letvar@5@10  list) (tail_Cons<list> xs@1@10)))))
(assert (or (is_Cons<Bool> xs@1@10) (not (is_Cons<Bool> xs@1@10))))
(push) ; 5
; [then-branch: 7 | is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10)) | live]
; [else-branch: 7 | !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) | live]
(push) ; 6
; [then-branch: 7 | is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))]
(assert (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
(pop) ; 6
(push) ; 6
; [else-branch: 7 | !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10)))]
(assert (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10)))))
; [eval] !(is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z))))
; [eval] is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)))
; [eval] is_Cons(xs)
(push) ; 7
; [then-branch: 8 | !(is_Cons[Bool](xs@1@10)) | live]
; [else-branch: 8 | is_Cons[Bool](xs@1@10) | live]
(push) ; 8
; [then-branch: 8 | !(is_Cons[Bool](xs@1@10))]
(assert (not (is_Cons<Bool> xs@1@10)))
(pop) ; 8
(push) ; 8
; [else-branch: 8 | is_Cons[Bool](xs@1@10)]
(assert (is_Cons<Bool> xs@1@10))
; [eval] (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)))
; [eval] head_Cons(xs)
(declare-const letvar@6@10 Int)
(assert (= (as letvar@6@10  Int) (head_Cons<Int> xs@1@10)))
; [eval] (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z))
; [eval] tail_Cons(xs)
(declare-const letvar@7@10 list)
(assert (= (as letvar@7@10  list) (tail_Cons<list> xs@1@10)))
; [eval] is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)
; [eval] is_Cons(ys)
(push) ; 9
; [then-branch: 9 | !(is_Cons[Bool](tail_Cons[list](xs@1@10))) | live]
; [else-branch: 9 | is_Cons[Bool](tail_Cons[list](xs@1@10)) | live]
(push) ; 10
; [then-branch: 9 | !(is_Cons[Bool](tail_Cons[list](xs@1@10)))]
(assert (not (is_Cons<Bool> (tail_Cons<list> xs@1@10))))
(pop) ; 10
(push) ; 10
; [else-branch: 9 | is_Cons[Bool](tail_Cons[list](xs@1@10))]
(assert (is_Cons<Bool> (tail_Cons<list> xs@1@10)))
; [eval] (let z == (head_Cons(ys)) in y < z)
; [eval] head_Cons(ys)
(declare-const letvar@8@10 Int)
(assert (= (as letvar@8@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10))))
; [eval] y < z
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (=>
  (is_Cons<Bool> (tail_Cons<list> xs@1@10))
  (and
    (is_Cons<Bool> (tail_Cons<list> xs@1@10))
    (= (as letvar@8@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10))))))
(assert (or
  (is_Cons<Bool> (tail_Cons<list> xs@1@10))
  (not (is_Cons<Bool> (tail_Cons<list> xs@1@10)))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (=>
  (is_Cons<Bool> xs@1@10)
  (and
    (is_Cons<Bool> xs@1@10)
    (= (as letvar@6@10  Int) (head_Cons<Int> xs@1@10))
    (= (as letvar@7@10  list) (tail_Cons<list> xs@1@10))
    (=>
      (is_Cons<Bool> (tail_Cons<list> xs@1@10))
      (and
        (is_Cons<Bool> (tail_Cons<list> xs@1@10))
        (= (as letvar@8@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10)))))
    (or
      (is_Cons<Bool> (tail_Cons<list> xs@1@10))
      (not (is_Cons<Bool> (tail_Cons<list> xs@1@10)))))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
  (and
    (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
    (=>
      (is_Cons<Bool> xs@1@10)
      (and
        (is_Cons<Bool> xs@1@10)
        (= (as letvar@6@10  Int) (head_Cons<Int> xs@1@10))
        (= (as letvar@7@10  list) (tail_Cons<list> xs@1@10))
        (=>
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (= (as letvar@8@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10)))))
        (or
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (not (is_Cons<Bool> (tail_Cons<list> xs@1@10)))))))))
(assert (or
  (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
  (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10)))))
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (is_Nil<Bool> xs@1@10))
  (and
    (not (is_Nil<Bool> xs@1@10))
    (=>
      (is_Cons<Bool> xs@1@10)
      (and
        (is_Cons<Bool> xs@1@10)
        (= (as letvar@5@10  list) (tail_Cons<list> xs@1@10))))
    (or (is_Cons<Bool> xs@1@10) (not (is_Cons<Bool> xs@1@10)))
    (=>
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (and
        (not
          (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
        (=>
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> xs@1@10)
            (= (as letvar@6@10  Int) (head_Cons<Int> xs@1@10))
            (= (as letvar@7@10  list) (tail_Cons<list> xs@1@10))
            (=>
              (is_Cons<Bool> (tail_Cons<list> xs@1@10))
              (and
                (is_Cons<Bool> (tail_Cons<list> xs@1@10))
                (=
                  (as letvar@8@10  Int)
                  (head_Cons<Int> (tail_Cons<list> xs@1@10)))))
            (or
              (is_Cons<Bool> (tail_Cons<list> xs@1@10))
              (not (is_Cons<Bool> (tail_Cons<list> xs@1@10))))))))
    (or
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10)))))))
(push) ; 3
(push) ; 4
(set-option :timeout 10)
(assert (not (not
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (<
              (head_Cons<Int> xs@1@10)
              (head_Cons<Int> (tail_Cons<list> xs@1@10)))))))))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 10)
(assert (not (and
  (not (is_Nil<Bool> xs@1@10))
  (and
    (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
    (not
      (and
        (is_Cons<Bool> xs@1@10)
        (and
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (< (head_Cons<Int> xs@1@10) (head_Cons<Int> (tail_Cons<list> xs@1@10))))))))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; [then-branch: 10 | !(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10))) | live]
; [else-branch: 10 | !(!(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10)))) | live]
(set-option :timeout 0)
(push) ; 4
; [then-branch: 10 | !(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10)))]
(assert (and
  (not (is_Nil<Bool> xs@1@10))
  (and
    (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
    (not
      (and
        (is_Cons<Bool> xs@1@10)
        (and
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (< (head_Cons<Int> xs@1@10) (head_Cons<Int> (tail_Cons<list> xs@1@10)))))))))
(pop) ; 4
(push) ; 4
; [else-branch: 10 | !(!(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10))))]
(assert (not
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (<
              (head_Cons<Int> xs@1@10)
              (head_Cons<Int> (tail_Cons<list> xs@1@10))))))))))
(pop) ; 4
(pop) ; 3
; Joined path conditions
(assert (=>
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (<
              (head_Cons<Int> xs@1@10)
              (head_Cons<Int> (tail_Cons<list> xs@1@10))))))))
  (and
    (not (is_Nil<Bool> xs@1@10))
    (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
    (not
      (and
        (is_Cons<Bool> xs@1@10)
        (and
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (< (head_Cons<Int> xs@1@10) (head_Cons<Int> (tail_Cons<list> xs@1@10)))))))))
; Joined path conditions
(assert (or
  (not
    (and
      (not (is_Nil<Bool> xs@1@10))
      (and
        (not
          (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
        (not
          (and
            (is_Cons<Bool> xs@1@10)
            (and
              (is_Cons<Bool> (tail_Cons<list> xs@1@10))
              (<
                (head_Cons<Int> xs@1@10)
                (head_Cons<Int> (tail_Cons<list> xs@1@10)))))))))
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (<
              (head_Cons<Int> xs@1@10)
              (head_Cons<Int> (tail_Cons<list> xs@1@10))))))))))
(push) ; 3
(assert (not (=>
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (<
              (head_Cons<Int> xs@1@10)
              (head_Cons<Int> (tail_Cons<list> xs@1@10))))))))
  false)))
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
; [eval] !is_Nil(xs) && (!(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))) && !(is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z))))) ==> false
; [eval] !is_Nil(xs) && (!(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))) && !(is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)))))
; [eval] !is_Nil(xs)
; [eval] is_Nil(xs)
(set-option :timeout 0)
(push) ; 3
; [then-branch: 11 | is_Nil[Bool](xs@1@10) | live]
; [else-branch: 11 | !(is_Nil[Bool](xs@1@10)) | live]
(push) ; 4
; [then-branch: 11 | is_Nil[Bool](xs@1@10)]
(assert (is_Nil<Bool> xs@1@10))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
(pop) ; 4
(set-option :timeout 0)
(push) ; 4
; [else-branch: 11 | !(is_Nil[Bool](xs@1@10))]
(assert (not (is_Nil<Bool> xs@1@10)))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] !(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys)))
; [eval] is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))
; [eval] is_Cons(xs)
(set-option :timeout 0)
(push) ; 5
; [then-branch: 12 | !(is_Cons[Bool](xs@1@10)) | live]
; [else-branch: 12 | is_Cons[Bool](xs@1@10) | live]
(push) ; 6
; [then-branch: 12 | !(is_Cons[Bool](xs@1@10))]
(assert (not (is_Cons<Bool> xs@1@10)))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unsat
(pop) ; 6
(set-option :timeout 0)
(push) ; 6
; [else-branch: 12 | is_Cons[Bool](xs@1@10)]
(assert (is_Cons<Bool> xs@1@10))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] (let ys == (tail_Cons(xs)) in is_Nil(ys))
; [eval] tail_Cons(xs)
(declare-const letvar@9@10 list)
(assert (= (as letvar@9@10  list) (tail_Cons<list> xs@1@10)))
; [eval] is_Nil(ys)
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (=>
  (is_Cons<Bool> xs@1@10)
  (and
    (is_Cons<Bool> xs@1@10)
    (= (as letvar@9@10  list) (tail_Cons<list> xs@1@10)))))
(assert (or (is_Cons<Bool> xs@1@10) (not (is_Cons<Bool> xs@1@10))))
(set-option :timeout 0)
(push) ; 5
; [then-branch: 13 | is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10)) | live]
; [else-branch: 13 | !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) | live]
(push) ; 6
; [then-branch: 13 | is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))]
(assert (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
(pop) ; 6
(set-option :timeout 0)
(push) ; 6
; [else-branch: 13 | !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10)))]
(assert (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10)))))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] !(is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z))))
; [eval] is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)))
; [eval] is_Cons(xs)
(set-option :timeout 0)
(push) ; 7
; [then-branch: 14 | !(is_Cons[Bool](xs@1@10)) | live]
; [else-branch: 14 | is_Cons[Bool](xs@1@10) | live]
(push) ; 8
; [then-branch: 14 | !(is_Cons[Bool](xs@1@10))]
(assert (not (is_Cons<Bool> xs@1@10)))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unsat
(pop) ; 8
(set-option :timeout 0)
(push) ; 8
; [else-branch: 14 | is_Cons[Bool](xs@1@10)]
(assert (is_Cons<Bool> xs@1@10))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)))
; [eval] head_Cons(xs)
(declare-const letvar@10@10 Int)
(assert (= (as letvar@10@10  Int) (head_Cons<Int> xs@1@10)))
; [eval] (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z))
; [eval] tail_Cons(xs)
(declare-const letvar@11@10 list)
(assert (= (as letvar@11@10  list) (tail_Cons<list> xs@1@10)))
; [eval] is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)
; [eval] is_Cons(ys)
(set-option :timeout 0)
(push) ; 9
; [then-branch: 15 | !(is_Cons[Bool](tail_Cons[list](xs@1@10))) | live]
; [else-branch: 15 | is_Cons[Bool](tail_Cons[list](xs@1@10)) | live]
(push) ; 10
; [then-branch: 15 | !(is_Cons[Bool](tail_Cons[list](xs@1@10)))]
(assert (not (is_Cons<Bool> (tail_Cons<list> xs@1@10))))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unsat
(pop) ; 10
(set-option :timeout 0)
(push) ; 10
; [else-branch: 15 | is_Cons[Bool](tail_Cons[list](xs@1@10))]
(assert (is_Cons<Bool> (tail_Cons<list> xs@1@10)))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] (let z == (head_Cons(ys)) in y < z)
; [eval] head_Cons(ys)
(declare-const letvar@12@10 Int)
(assert (= (as letvar@12@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10))))
; [eval] y < z
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (=>
  (is_Cons<Bool> (tail_Cons<list> xs@1@10))
  (and
    (is_Cons<Bool> (tail_Cons<list> xs@1@10))
    (= (as letvar@12@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10))))))
(assert (or
  (is_Cons<Bool> (tail_Cons<list> xs@1@10))
  (not (is_Cons<Bool> (tail_Cons<list> xs@1@10)))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (=>
  (is_Cons<Bool> xs@1@10)
  (and
    (is_Cons<Bool> xs@1@10)
    (= (as letvar@10@10  Int) (head_Cons<Int> xs@1@10))
    (= (as letvar@11@10  list) (tail_Cons<list> xs@1@10))
    (=>
      (is_Cons<Bool> (tail_Cons<list> xs@1@10))
      (and
        (is_Cons<Bool> (tail_Cons<list> xs@1@10))
        (= (as letvar@12@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10)))))
    (or
      (is_Cons<Bool> (tail_Cons<list> xs@1@10))
      (not (is_Cons<Bool> (tail_Cons<list> xs@1@10)))))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
  (and
    (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
    (=>
      (is_Cons<Bool> xs@1@10)
      (and
        (is_Cons<Bool> xs@1@10)
        (= (as letvar@10@10  Int) (head_Cons<Int> xs@1@10))
        (= (as letvar@11@10  list) (tail_Cons<list> xs@1@10))
        (=>
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (= (as letvar@12@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10)))))
        (or
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (not (is_Cons<Bool> (tail_Cons<list> xs@1@10)))))))))
(assert (or
  (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
  (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10)))))
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (is_Nil<Bool> xs@1@10))
  (and
    (not (is_Nil<Bool> xs@1@10))
    (=>
      (is_Cons<Bool> xs@1@10)
      (and
        (is_Cons<Bool> xs@1@10)
        (= (as letvar@9@10  list) (tail_Cons<list> xs@1@10))))
    (or (is_Cons<Bool> xs@1@10) (not (is_Cons<Bool> xs@1@10)))
    (=>
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (and
        (not
          (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
        (=>
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> xs@1@10)
            (= (as letvar@10@10  Int) (head_Cons<Int> xs@1@10))
            (= (as letvar@11@10  list) (tail_Cons<list> xs@1@10))
            (=>
              (is_Cons<Bool> (tail_Cons<list> xs@1@10))
              (and
                (is_Cons<Bool> (tail_Cons<list> xs@1@10))
                (=
                  (as letvar@12@10  Int)
                  (head_Cons<Int> (tail_Cons<list> xs@1@10)))))
            (or
              (is_Cons<Bool> (tail_Cons<list> xs@1@10))
              (not (is_Cons<Bool> (tail_Cons<list> xs@1@10))))))))
    (or
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10)))))))
(set-option :timeout 0)
(push) ; 3
(push) ; 4
(set-option :timeout 10)
(assert (not (not
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (<
              (head_Cons<Int> xs@1@10)
              (head_Cons<Int> (tail_Cons<list> xs@1@10)))))))))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 10)
(assert (not (and
  (not (is_Nil<Bool> xs@1@10))
  (and
    (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
    (not
      (and
        (is_Cons<Bool> xs@1@10)
        (and
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (< (head_Cons<Int> xs@1@10) (head_Cons<Int> (tail_Cons<list> xs@1@10))))))))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; [then-branch: 16 | !(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10))) | live]
; [else-branch: 16 | !(!(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10)))) | live]
(set-option :timeout 0)
(push) ; 4
; [then-branch: 16 | !(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10)))]
(assert (and
  (not (is_Nil<Bool> xs@1@10))
  (and
    (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
    (not
      (and
        (is_Cons<Bool> xs@1@10)
        (and
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (< (head_Cons<Int> xs@1@10) (head_Cons<Int> (tail_Cons<list> xs@1@10)))))))))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
(pop) ; 4
(set-option :timeout 0)
(push) ; 4
; [else-branch: 16 | !(!(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10))))]
(assert (not
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (<
              (head_Cons<Int> xs@1@10)
              (head_Cons<Int> (tail_Cons<list> xs@1@10))))))))))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(set-option :timeout 0)
(push) ; 3
(assert (not (=>
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (<
              (head_Cons<Int> xs@1@10)
              (head_Cons<Int> (tail_Cons<list> xs@1@10))))))))
  false)))
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
; [eval] !is_Nil(xs) && (!(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))) && !(is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z))))) ==> false
; [eval] !is_Nil(xs) && (!(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))) && !(is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)))))
; [eval] !is_Nil(xs)
; [eval] is_Nil(xs)
(set-option :timeout 0)
(push) ; 3
; [then-branch: 17 | is_Nil[Bool](xs@1@10) | live]
; [else-branch: 17 | !(is_Nil[Bool](xs@1@10)) | live]
(push) ; 4
; [then-branch: 17 | is_Nil[Bool](xs@1@10)]
(assert (is_Nil<Bool> xs@1@10))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
(pop) ; 4
(set-option :timeout 0)
(push) ; 4
; [else-branch: 17 | !(is_Nil[Bool](xs@1@10))]
(assert (not (is_Nil<Bool> xs@1@10)))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] !(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys)))
; [eval] is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))
; [eval] is_Cons(xs)
(set-option :timeout 0)
(push) ; 5
; [then-branch: 18 | !(is_Cons[Bool](xs@1@10)) | live]
; [else-branch: 18 | is_Cons[Bool](xs@1@10) | live]
(push) ; 6
; [then-branch: 18 | !(is_Cons[Bool](xs@1@10))]
(assert (not (is_Cons<Bool> xs@1@10)))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unsat
(pop) ; 6
(set-option :timeout 0)
(push) ; 6
; [else-branch: 18 | is_Cons[Bool](xs@1@10)]
(assert (is_Cons<Bool> xs@1@10))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] (let ys == (tail_Cons(xs)) in is_Nil(ys))
; [eval] tail_Cons(xs)
(declare-const letvar@13@10 list)
(assert (= (as letvar@13@10  list) (tail_Cons<list> xs@1@10)))
; [eval] is_Nil(ys)
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (=>
  (is_Cons<Bool> xs@1@10)
  (and
    (is_Cons<Bool> xs@1@10)
    (= (as letvar@13@10  list) (tail_Cons<list> xs@1@10)))))
(assert (or (is_Cons<Bool> xs@1@10) (not (is_Cons<Bool> xs@1@10))))
(set-option :timeout 0)
(push) ; 5
; [then-branch: 19 | is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10)) | live]
; [else-branch: 19 | !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) | live]
(push) ; 6
; [then-branch: 19 | is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))]
(assert (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
(pop) ; 6
(set-option :timeout 0)
(push) ; 6
; [else-branch: 19 | !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10)))]
(assert (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10)))))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] !(is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z))))
; [eval] is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)))
; [eval] is_Cons(xs)
(set-option :timeout 0)
(push) ; 7
; [then-branch: 20 | !(is_Cons[Bool](xs@1@10)) | live]
; [else-branch: 20 | is_Cons[Bool](xs@1@10) | live]
(push) ; 8
; [then-branch: 20 | !(is_Cons[Bool](xs@1@10))]
(assert (not (is_Cons<Bool> xs@1@10)))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unsat
(pop) ; 8
(set-option :timeout 0)
(push) ; 8
; [else-branch: 20 | is_Cons[Bool](xs@1@10)]
(assert (is_Cons<Bool> xs@1@10))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)))
; [eval] head_Cons(xs)
(declare-const letvar@14@10 Int)
(assert (= (as letvar@14@10  Int) (head_Cons<Int> xs@1@10)))
; [eval] (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z))
; [eval] tail_Cons(xs)
(declare-const letvar@15@10 list)
(assert (= (as letvar@15@10  list) (tail_Cons<list> xs@1@10)))
; [eval] is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)
; [eval] is_Cons(ys)
(set-option :timeout 0)
(push) ; 9
; [then-branch: 21 | !(is_Cons[Bool](tail_Cons[list](xs@1@10))) | live]
; [else-branch: 21 | is_Cons[Bool](tail_Cons[list](xs@1@10)) | live]
(push) ; 10
; [then-branch: 21 | !(is_Cons[Bool](tail_Cons[list](xs@1@10)))]
(assert (not (is_Cons<Bool> (tail_Cons<list> xs@1@10))))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unsat
(pop) ; 10
(set-option :timeout 0)
(push) ; 10
; [else-branch: 21 | is_Cons[Bool](tail_Cons[list](xs@1@10))]
(assert (is_Cons<Bool> (tail_Cons<list> xs@1@10)))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] (let z == (head_Cons(ys)) in y < z)
; [eval] head_Cons(ys)
(declare-const letvar@16@10 Int)
(assert (= (as letvar@16@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10))))
; [eval] y < z
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (=>
  (is_Cons<Bool> (tail_Cons<list> xs@1@10))
  (and
    (is_Cons<Bool> (tail_Cons<list> xs@1@10))
    (= (as letvar@16@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10))))))
(assert (or
  (is_Cons<Bool> (tail_Cons<list> xs@1@10))
  (not (is_Cons<Bool> (tail_Cons<list> xs@1@10)))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (=>
  (is_Cons<Bool> xs@1@10)
  (and
    (is_Cons<Bool> xs@1@10)
    (= (as letvar@14@10  Int) (head_Cons<Int> xs@1@10))
    (= (as letvar@15@10  list) (tail_Cons<list> xs@1@10))
    (=>
      (is_Cons<Bool> (tail_Cons<list> xs@1@10))
      (and
        (is_Cons<Bool> (tail_Cons<list> xs@1@10))
        (= (as letvar@16@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10)))))
    (or
      (is_Cons<Bool> (tail_Cons<list> xs@1@10))
      (not (is_Cons<Bool> (tail_Cons<list> xs@1@10)))))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
  (and
    (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
    (=>
      (is_Cons<Bool> xs@1@10)
      (and
        (is_Cons<Bool> xs@1@10)
        (= (as letvar@14@10  Int) (head_Cons<Int> xs@1@10))
        (= (as letvar@15@10  list) (tail_Cons<list> xs@1@10))
        (=>
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (= (as letvar@16@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10)))))
        (or
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (not (is_Cons<Bool> (tail_Cons<list> xs@1@10)))))))))
(assert (or
  (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
  (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10)))))
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (is_Nil<Bool> xs@1@10))
  (and
    (not (is_Nil<Bool> xs@1@10))
    (=>
      (is_Cons<Bool> xs@1@10)
      (and
        (is_Cons<Bool> xs@1@10)
        (= (as letvar@13@10  list) (tail_Cons<list> xs@1@10))))
    (or (is_Cons<Bool> xs@1@10) (not (is_Cons<Bool> xs@1@10)))
    (=>
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (and
        (not
          (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
        (=>
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> xs@1@10)
            (= (as letvar@14@10  Int) (head_Cons<Int> xs@1@10))
            (= (as letvar@15@10  list) (tail_Cons<list> xs@1@10))
            (=>
              (is_Cons<Bool> (tail_Cons<list> xs@1@10))
              (and
                (is_Cons<Bool> (tail_Cons<list> xs@1@10))
                (=
                  (as letvar@16@10  Int)
                  (head_Cons<Int> (tail_Cons<list> xs@1@10)))))
            (or
              (is_Cons<Bool> (tail_Cons<list> xs@1@10))
              (not (is_Cons<Bool> (tail_Cons<list> xs@1@10))))))))
    (or
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10)))))))
(set-option :timeout 0)
(push) ; 3
(push) ; 4
(set-option :timeout 10)
(assert (not (not
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (<
              (head_Cons<Int> xs@1@10)
              (head_Cons<Int> (tail_Cons<list> xs@1@10)))))))))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 10)
(assert (not (and
  (not (is_Nil<Bool> xs@1@10))
  (and
    (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
    (not
      (and
        (is_Cons<Bool> xs@1@10)
        (and
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (< (head_Cons<Int> xs@1@10) (head_Cons<Int> (tail_Cons<list> xs@1@10))))))))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; [then-branch: 22 | !(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10))) | live]
; [else-branch: 22 | !(!(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10)))) | live]
(set-option :timeout 0)
(push) ; 4
; [then-branch: 22 | !(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10)))]
(assert (and
  (not (is_Nil<Bool> xs@1@10))
  (and
    (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
    (not
      (and
        (is_Cons<Bool> xs@1@10)
        (and
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (< (head_Cons<Int> xs@1@10) (head_Cons<Int> (tail_Cons<list> xs@1@10)))))))))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
(pop) ; 4
(set-option :timeout 0)
(push) ; 4
; [else-branch: 22 | !(!(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10))))]
(assert (not
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (<
              (head_Cons<Int> xs@1@10)
              (head_Cons<Int> (tail_Cons<list> xs@1@10))))))))))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(set-option :timeout 0)
(push) ; 3
(assert (not (=>
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (<
              (head_Cons<Int> xs@1@10)
              (head_Cons<Int> (tail_Cons<list> xs@1@10))))))))
  false)))
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
; [eval] !is_Nil(xs) && (!(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))) && !(is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z))))) ==> false
; [eval] !is_Nil(xs) && (!(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))) && !(is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)))))
; [eval] !is_Nil(xs)
; [eval] is_Nil(xs)
(set-option :timeout 0)
(push) ; 3
; [then-branch: 23 | is_Nil[Bool](xs@1@10) | live]
; [else-branch: 23 | !(is_Nil[Bool](xs@1@10)) | live]
(push) ; 4
; [then-branch: 23 | is_Nil[Bool](xs@1@10)]
(assert (is_Nil<Bool> xs@1@10))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
(pop) ; 4
(set-option :timeout 0)
(push) ; 4
; [else-branch: 23 | !(is_Nil[Bool](xs@1@10))]
(assert (not (is_Nil<Bool> xs@1@10)))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] !(is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys)))
; [eval] is_Cons(xs) && (let ys == (tail_Cons(xs)) in is_Nil(ys))
; [eval] is_Cons(xs)
(set-option :timeout 0)
(push) ; 5
; [then-branch: 24 | !(is_Cons[Bool](xs@1@10)) | live]
; [else-branch: 24 | is_Cons[Bool](xs@1@10) | live]
(push) ; 6
; [then-branch: 24 | !(is_Cons[Bool](xs@1@10))]
(assert (not (is_Cons<Bool> xs@1@10)))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unsat
(pop) ; 6
(set-option :timeout 0)
(push) ; 6
; [else-branch: 24 | is_Cons[Bool](xs@1@10)]
(assert (is_Cons<Bool> xs@1@10))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] (let ys == (tail_Cons(xs)) in is_Nil(ys))
; [eval] tail_Cons(xs)
(declare-const letvar@17@10 list)
(assert (= (as letvar@17@10  list) (tail_Cons<list> xs@1@10)))
; [eval] is_Nil(ys)
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (=>
  (is_Cons<Bool> xs@1@10)
  (and
    (is_Cons<Bool> xs@1@10)
    (= (as letvar@17@10  list) (tail_Cons<list> xs@1@10)))))
(assert (or (is_Cons<Bool> xs@1@10) (not (is_Cons<Bool> xs@1@10))))
(set-option :timeout 0)
(push) ; 5
; [then-branch: 25 | is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10)) | live]
; [else-branch: 25 | !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) | live]
(push) ; 6
; [then-branch: 25 | is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))]
(assert (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
(pop) ; 6
(set-option :timeout 0)
(push) ; 6
; [else-branch: 25 | !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10)))]
(assert (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10)))))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] !(is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z))))
; [eval] is_Cons(xs) && (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)))
; [eval] is_Cons(xs)
(set-option :timeout 0)
(push) ; 7
; [then-branch: 26 | !(is_Cons[Bool](xs@1@10)) | live]
; [else-branch: 26 | is_Cons[Bool](xs@1@10) | live]
(push) ; 8
; [then-branch: 26 | !(is_Cons[Bool](xs@1@10))]
(assert (not (is_Cons<Bool> xs@1@10)))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unsat
(pop) ; 8
(set-option :timeout 0)
(push) ; 8
; [else-branch: 26 | is_Cons[Bool](xs@1@10)]
(assert (is_Cons<Bool> xs@1@10))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] (let y == (head_Cons(xs)) in (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)))
; [eval] head_Cons(xs)
(declare-const letvar@18@10 Int)
(assert (= (as letvar@18@10  Int) (head_Cons<Int> xs@1@10)))
; [eval] (let ys == (tail_Cons(xs)) in is_Cons(ys) && (let z == (head_Cons(ys)) in y < z))
; [eval] tail_Cons(xs)
(declare-const letvar@19@10 list)
(assert (= (as letvar@19@10  list) (tail_Cons<list> xs@1@10)))
; [eval] is_Cons(ys) && (let z == (head_Cons(ys)) in y < z)
; [eval] is_Cons(ys)
(set-option :timeout 0)
(push) ; 9
; [then-branch: 27 | !(is_Cons[Bool](tail_Cons[list](xs@1@10))) | live]
; [else-branch: 27 | is_Cons[Bool](tail_Cons[list](xs@1@10)) | live]
(push) ; 10
; [then-branch: 27 | !(is_Cons[Bool](tail_Cons[list](xs@1@10)))]
(assert (not (is_Cons<Bool> (tail_Cons<list> xs@1@10))))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unsat
(pop) ; 10
(set-option :timeout 0)
(push) ; 10
; [else-branch: 27 | is_Cons[Bool](tail_Cons[list](xs@1@10))]
(assert (is_Cons<Bool> (tail_Cons<list> xs@1@10)))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
; [eval] (let z == (head_Cons(ys)) in y < z)
; [eval] head_Cons(ys)
(declare-const letvar@20@10 Int)
(assert (= (as letvar@20@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10))))
; [eval] y < z
(pop) ; 10
(pop) ; 9
; Joined path conditions
; Joined path conditions
(assert (=>
  (is_Cons<Bool> (tail_Cons<list> xs@1@10))
  (and
    (is_Cons<Bool> (tail_Cons<list> xs@1@10))
    (= (as letvar@20@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10))))))
(assert (or
  (is_Cons<Bool> (tail_Cons<list> xs@1@10))
  (not (is_Cons<Bool> (tail_Cons<list> xs@1@10)))))
(pop) ; 8
(pop) ; 7
; Joined path conditions
; Joined path conditions
(assert (=>
  (is_Cons<Bool> xs@1@10)
  (and
    (is_Cons<Bool> xs@1@10)
    (= (as letvar@18@10  Int) (head_Cons<Int> xs@1@10))
    (= (as letvar@19@10  list) (tail_Cons<list> xs@1@10))
    (=>
      (is_Cons<Bool> (tail_Cons<list> xs@1@10))
      (and
        (is_Cons<Bool> (tail_Cons<list> xs@1@10))
        (= (as letvar@20@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10)))))
    (or
      (is_Cons<Bool> (tail_Cons<list> xs@1@10))
      (not (is_Cons<Bool> (tail_Cons<list> xs@1@10)))))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
  (and
    (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
    (=>
      (is_Cons<Bool> xs@1@10)
      (and
        (is_Cons<Bool> xs@1@10)
        (= (as letvar@18@10  Int) (head_Cons<Int> xs@1@10))
        (= (as letvar@19@10  list) (tail_Cons<list> xs@1@10))
        (=>
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (= (as letvar@20@10  Int) (head_Cons<Int> (tail_Cons<list> xs@1@10)))))
        (or
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (not (is_Cons<Bool> (tail_Cons<list> xs@1@10)))))))))
(assert (or
  (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
  (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10)))))
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (=>
  (not (is_Nil<Bool> xs@1@10))
  (and
    (not (is_Nil<Bool> xs@1@10))
    (=>
      (is_Cons<Bool> xs@1@10)
      (and
        (is_Cons<Bool> xs@1@10)
        (= (as letvar@17@10  list) (tail_Cons<list> xs@1@10))))
    (or (is_Cons<Bool> xs@1@10) (not (is_Cons<Bool> xs@1@10)))
    (=>
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (and
        (not
          (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
        (=>
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> xs@1@10)
            (= (as letvar@18@10  Int) (head_Cons<Int> xs@1@10))
            (= (as letvar@19@10  list) (tail_Cons<list> xs@1@10))
            (=>
              (is_Cons<Bool> (tail_Cons<list> xs@1@10))
              (and
                (is_Cons<Bool> (tail_Cons<list> xs@1@10))
                (=
                  (as letvar@20@10  Int)
                  (head_Cons<Int> (tail_Cons<list> xs@1@10)))))
            (or
              (is_Cons<Bool> (tail_Cons<list> xs@1@10))
              (not (is_Cons<Bool> (tail_Cons<list> xs@1@10))))))))
    (or
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10)))))))
(set-option :timeout 0)
(push) ; 3
(push) ; 4
(set-option :timeout 10)
(assert (not (not
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (<
              (head_Cons<Int> xs@1@10)
              (head_Cons<Int> (tail_Cons<list> xs@1@10)))))))))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 10)
(assert (not (and
  (not (is_Nil<Bool> xs@1@10))
  (and
    (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
    (not
      (and
        (is_Cons<Bool> xs@1@10)
        (and
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (< (head_Cons<Int> xs@1@10) (head_Cons<Int> (tail_Cons<list> xs@1@10))))))))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; [then-branch: 28 | !(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10))) | live]
; [else-branch: 28 | !(!(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10)))) | live]
(set-option :timeout 0)
(push) ; 4
; [then-branch: 28 | !(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10)))]
(assert (and
  (not (is_Nil<Bool> xs@1@10))
  (and
    (not (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
    (not
      (and
        (is_Cons<Bool> xs@1@10)
        (and
          (is_Cons<Bool> (tail_Cons<list> xs@1@10))
          (< (head_Cons<Int> xs@1@10) (head_Cons<Int> (tail_Cons<list> xs@1@10)))))))))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
(pop) ; 4
(set-option :timeout 0)
(push) ; 4
; [else-branch: 28 | !(!(is_Nil[Bool](xs@1@10)) && !(is_Cons[Bool](xs@1@10) && is_Nil[Bool](tail_Cons[list](xs@1@10))) && !(is_Cons[Bool](xs@1@10) && is_Cons[Bool](tail_Cons[list](xs@1@10)) && head_Cons[Int](xs@1@10) < head_Cons[Int](tail_Cons[list](xs@1@10))))]
(assert (not
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (<
              (head_Cons<Int> xs@1@10)
              (head_Cons<Int> (tail_Cons<list> xs@1@10))))))))))
; [state consolidation]
; State saturation: before repetition
(set-option :timeout 10)
(check-sat)
; unknown
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(set-option :timeout 0)
(push) ; 3
(assert (not (=>
  (and
    (not (is_Nil<Bool> xs@1@10))
    (and
      (not
        (and (is_Cons<Bool> xs@1@10) (is_Nil<Bool> (tail_Cons<list> xs@1@10))))
      (not
        (and
          (is_Cons<Bool> xs@1@10)
          (and
            (is_Cons<Bool> (tail_Cons<list> xs@1@10))
            (<
              (head_Cons<Int> xs@1@10)
              (head_Cons<Int> (tail_Cons<list> xs@1@10))))))))
  false)))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(pop) ; 2
(pop) ; 1
