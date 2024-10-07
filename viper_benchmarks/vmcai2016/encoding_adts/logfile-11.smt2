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
; ---------- test_quantifiers ----------
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
; assert (forall head: Int, tail: list, xs: list ::
;     { is_Cons(xs), Cons(head, tail) }
;     { head_Cons(xs), Cons(head, tail) }
;     { tail_Cons(xs), Cons(head, tail) }
;     is_Cons(xs) ==>
;     (head == head_Cons(xs) && tail == tail_Cons(xs)) ==
;     (Cons(head, tail) == xs))
; [eval] (forall head: Int, tail: list, xs: list :: { is_Cons(xs), Cons(head, tail) } { head_Cons(xs), Cons(head, tail) } { tail_Cons(xs), Cons(head, tail) } is_Cons(xs) ==> (head == head_Cons(xs) && tail == tail_Cons(xs)) == (Cons(head, tail) == xs))
(declare-const head@0@11 Int)
(declare-const tail@1@11 list)
(declare-const xs@2@11 list)
(push) ; 3
; [eval] is_Cons(xs) ==> (head == head_Cons(xs) && tail == tail_Cons(xs)) == (Cons(head, tail) == xs)
; [eval] is_Cons(xs)
(push) ; 4
; [then-branch: 0 | is_Cons[Bool](xs@2@11) | live]
; [else-branch: 0 | !(is_Cons[Bool](xs@2@11)) | live]
(push) ; 5
; [then-branch: 0 | is_Cons[Bool](xs@2@11)]
(assert (is_Cons<Bool> xs@2@11))
; [eval] (head == head_Cons(xs) && tail == tail_Cons(xs)) == (Cons(head, tail) == xs)
; [eval] head == head_Cons(xs) && tail == tail_Cons(xs)
; [eval] head == head_Cons(xs)
; [eval] head_Cons(xs)
(push) ; 6
; [then-branch: 1 | head@0@11 != head_Cons[Int](xs@2@11) | live]
; [else-branch: 1 | head@0@11 == head_Cons[Int](xs@2@11) | live]
(push) ; 7
; [then-branch: 1 | head@0@11 != head_Cons[Int](xs@2@11)]
(assert (not (= head@0@11 (head_Cons<Int> xs@2@11))))
(pop) ; 7
(push) ; 7
; [else-branch: 1 | head@0@11 == head_Cons[Int](xs@2@11)]
(assert (= head@0@11 (head_Cons<Int> xs@2@11)))
; [eval] tail == tail_Cons(xs)
; [eval] tail_Cons(xs)
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or
  (= head@0@11 (head_Cons<Int> xs@2@11))
  (not (= head@0@11 (head_Cons<Int> xs@2@11)))))
; [eval] Cons(head, tail) == xs
; [eval] Cons(head, tail)
(pop) ; 5
(push) ; 5
; [else-branch: 0 | !(is_Cons[Bool](xs@2@11))]
(assert (not (is_Cons<Bool> xs@2@11)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (=>
  (is_Cons<Bool> xs@2@11)
  (and
    (is_Cons<Bool> xs@2@11)
    (or
      (= head@0@11 (head_Cons<Int> xs@2@11))
      (not (= head@0@11 (head_Cons<Int> xs@2@11)))))))
; Joined path conditions
(assert (or (not (is_Cons<Bool> xs@2@11)) (is_Cons<Bool> xs@2@11)))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((head@0@11 Int) (tail@1@11 list) (xs@2@11 list)) (!
  (and
    (=>
      (is_Cons<Bool> xs@2@11)
      (and
        (is_Cons<Bool> xs@2@11)
        (or
          (= head@0@11 (head_Cons<Int> xs@2@11))
          (not (= head@0@11 (head_Cons<Int> xs@2@11))))))
    (or (not (is_Cons<Bool> xs@2@11)) (is_Cons<Bool> xs@2@11)))
  :pattern ((is_Cons<Bool> xs@2@11) (Cons<list> head@0@11 tail@1@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/encoding-adts.vpr@78@12@79@99-aux|)))
(assert (forall ((head@0@11 Int) (tail@1@11 list) (xs@2@11 list)) (!
  (and
    (=>
      (is_Cons<Bool> xs@2@11)
      (and
        (is_Cons<Bool> xs@2@11)
        (or
          (= head@0@11 (head_Cons<Int> xs@2@11))
          (not (= head@0@11 (head_Cons<Int> xs@2@11))))))
    (or (not (is_Cons<Bool> xs@2@11)) (is_Cons<Bool> xs@2@11)))
  :pattern ((head_Cons<Int> xs@2@11) (Cons<list> head@0@11 tail@1@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/encoding-adts.vpr@78@12@79@99-aux|)))
(assert (forall ((head@0@11 Int) (tail@1@11 list) (xs@2@11 list)) (!
  (and
    (=>
      (is_Cons<Bool> xs@2@11)
      (and
        (is_Cons<Bool> xs@2@11)
        (or
          (= head@0@11 (head_Cons<Int> xs@2@11))
          (not (= head@0@11 (head_Cons<Int> xs@2@11))))))
    (or (not (is_Cons<Bool> xs@2@11)) (is_Cons<Bool> xs@2@11)))
  :pattern ((tail_Cons<list> xs@2@11) (Cons<list> head@0@11 tail@1@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/encoding-adts.vpr@78@12@79@99-aux|)))
(push) ; 3
(assert (not (forall ((head@0@11 Int) (tail@1@11 list) (xs@2@11 list)) (!
  (=>
    (is_Cons<Bool> xs@2@11)
    (=
      (and
        (= head@0@11 (head_Cons<Int> xs@2@11))
        (= tail@1@11 (tail_Cons<list> xs@2@11)))
      (= (Cons<list> head@0@11 tail@1@11) xs@2@11)))
  :pattern ((is_Cons<Bool> xs@2@11) (Cons<list> head@0@11 tail@1@11))
  :pattern ((head_Cons<Int> xs@2@11) (Cons<list> head@0@11 tail@1@11))
  :pattern ((tail_Cons<list> xs@2@11) (Cons<list> head@0@11 tail@1@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/encoding-adts.vpr@78@12@79@99|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (forall ((head@0@11 Int) (tail@1@11 list) (xs@2@11 list)) (!
  (=>
    (is_Cons<Bool> xs@2@11)
    (=
      (and
        (= head@0@11 (head_Cons<Int> xs@2@11))
        (= tail@1@11 (tail_Cons<list> xs@2@11)))
      (= (Cons<list> head@0@11 tail@1@11) xs@2@11)))
  :pattern ((is_Cons<Bool> xs@2@11) (Cons<list> head@0@11 tail@1@11))
  :pattern ((head_Cons<Int> xs@2@11) (Cons<list> head@0@11 tail@1@11))
  :pattern ((tail_Cons<list> xs@2@11) (Cons<list> head@0@11 tail@1@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/encoding-adts.vpr@78@12@79@99|)))
; [exec]
; assert (forall head1: Int, head2: Int, tail1: list, tail2: list ::
;     { Cons(head1, tail1), Cons(head2, tail2) }
;     (Cons(head1, tail1) == Cons(head2, tail2)) ==
;     (head1 == head2 && tail1 == tail2))
; [eval] (forall head1: Int, head2: Int, tail1: list, tail2: list :: { Cons(head1, tail1), Cons(head2, tail2) } (Cons(head1, tail1) == Cons(head2, tail2)) == (head1 == head2 && tail1 == tail2))
(declare-const head1@3@11 Int)
(declare-const head2@4@11 Int)
(declare-const tail1@5@11 list)
(declare-const tail2@6@11 list)
(push) ; 3
; [eval] (Cons(head1, tail1) == Cons(head2, tail2)) == (head1 == head2 && tail1 == tail2)
; [eval] Cons(head1, tail1) == Cons(head2, tail2)
; [eval] Cons(head1, tail1)
; [eval] Cons(head2, tail2)
; [eval] head1 == head2 && tail1 == tail2
; [eval] head1 == head2
(push) ; 4
; [then-branch: 2 | head1@3@11 != head2@4@11 | live]
; [else-branch: 2 | head1@3@11 == head2@4@11 | live]
(push) ; 5
; [then-branch: 2 | head1@3@11 != head2@4@11]
(assert (not (= head1@3@11 head2@4@11)))
(pop) ; 5
(push) ; 5
; [else-branch: 2 | head1@3@11 == head2@4@11]
(assert (= head1@3@11 head2@4@11))
; [eval] tail1 == tail2
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (= head1@3@11 head2@4@11) (not (= head1@3@11 head2@4@11))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((head1@3@11 Int) (head2@4@11 Int) (tail1@5@11 list) (tail2@6@11 list)) (!
  (or (= head1@3@11 head2@4@11) (not (= head1@3@11 head2@4@11)))
  :pattern ((Cons<list> head1@3@11 tail1@5@11) (Cons<list> head2@4@11 tail2@6@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/encoding-adts.vpr@82@12@83@85-aux|)))
(push) ; 3
(assert (not (forall ((head1@3@11 Int) (head2@4@11 Int) (tail1@5@11 list) (tail2@6@11 list)) (!
  (=
    (= (Cons<list> head1@3@11 tail1@5@11) (Cons<list> head2@4@11 tail2@6@11))
    (and (= head1@3@11 head2@4@11) (= tail1@5@11 tail2@6@11)))
  :pattern ((Cons<list> head1@3@11 tail1@5@11) (Cons<list> head2@4@11 tail2@6@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/encoding-adts.vpr@82@12@83@85|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(assert (forall ((head1@3@11 Int) (head2@4@11 Int) (tail1@5@11 list) (tail2@6@11 list)) (!
  (=
    (= (Cons<list> head1@3@11 tail1@5@11) (Cons<list> head2@4@11 tail2@6@11))
    (and (= head1@3@11 head2@4@11) (= tail1@5@11 tail2@6@11)))
  :pattern ((Cons<list> head1@3@11 tail1@5@11) (Cons<list> head2@4@11 tail2@6@11))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/vmcai2016/encoding-adts.vpr@82@12@83@85|)))
(pop) ; 2
(pop) ; 1
