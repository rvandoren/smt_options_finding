(get-info :version)
; (:version "4.13.0")
; Started: 2024-09-24 15:19:05
; Silicon.version: 1.1-SNAPSHOT (b737e366)
; Input file: /Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr
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
(declare-sort Seq<$Ref> 0)
(declare-sort Set<$Ref> 0)
(declare-sort Set<Int> 0)
(declare-sort Set<IEdges> 0)
(declare-sort Set<$Snap> 0)
(declare-sort IEdges 0)
(declare-sort INodeMap 0)
(declare-sort $FVF<val> 0)
(declare-sort $FVF<edges> 0)
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
(declare-fun $SortWrappers.Seq<$Ref>To$Snap (Seq<$Ref>) $Snap)
(declare-fun $SortWrappers.$SnapToSeq<$Ref> ($Snap) Seq<$Ref>)
(assert (forall ((x Seq<$Ref>)) (!
    (= x ($SortWrappers.$SnapToSeq<$Ref>($SortWrappers.Seq<$Ref>To$Snap x)))
    :pattern (($SortWrappers.Seq<$Ref>To$Snap x))
    :qid |$Snap.$SnapToSeq<$Ref>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.Seq<$Ref>To$Snap($SortWrappers.$SnapToSeq<$Ref> x)))
    :pattern (($SortWrappers.$SnapToSeq<$Ref> x))
    :qid |$Snap.Seq<$Ref>To$SnapToSeq<$Ref>|
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
(declare-fun $SortWrappers.Set<IEdges>To$Snap (Set<IEdges>) $Snap)
(declare-fun $SortWrappers.$SnapToSet<IEdges> ($Snap) Set<IEdges>)
(assert (forall ((x Set<IEdges>)) (!
    (= x ($SortWrappers.$SnapToSet<IEdges>($SortWrappers.Set<IEdges>To$Snap x)))
    :pattern (($SortWrappers.Set<IEdges>To$Snap x))
    :qid |$Snap.$SnapToSet<IEdges>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.Set<IEdges>To$Snap($SortWrappers.$SnapToSet<IEdges> x)))
    :pattern (($SortWrappers.$SnapToSet<IEdges> x))
    :qid |$Snap.Set<IEdges>To$SnapToSet<IEdges>|
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
(declare-fun $SortWrappers.IEdgesTo$Snap (IEdges) $Snap)
(declare-fun $SortWrappers.$SnapToIEdges ($Snap) IEdges)
(assert (forall ((x IEdges)) (!
    (= x ($SortWrappers.$SnapToIEdges($SortWrappers.IEdgesTo$Snap x)))
    :pattern (($SortWrappers.IEdgesTo$Snap x))
    :qid |$Snap.$SnapToIEdgesTo$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.IEdgesTo$Snap($SortWrappers.$SnapToIEdges x)))
    :pattern (($SortWrappers.$SnapToIEdges x))
    :qid |$Snap.IEdgesTo$SnapToIEdges|
    )))
(declare-fun $SortWrappers.INodeMapTo$Snap (INodeMap) $Snap)
(declare-fun $SortWrappers.$SnapToINodeMap ($Snap) INodeMap)
(assert (forall ((x INodeMap)) (!
    (= x ($SortWrappers.$SnapToINodeMap($SortWrappers.INodeMapTo$Snap x)))
    :pattern (($SortWrappers.INodeMapTo$Snap x))
    :qid |$Snap.$SnapToINodeMapTo$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.INodeMapTo$Snap($SortWrappers.$SnapToINodeMap x)))
    :pattern (($SortWrappers.$SnapToINodeMap x))
    :qid |$Snap.INodeMapTo$SnapToINodeMap|
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
(declare-fun $SortWrappers.$FVF<edges>To$Snap ($FVF<edges>) $Snap)
(declare-fun $SortWrappers.$SnapTo$FVF<edges> ($Snap) $FVF<edges>)
(assert (forall ((x $FVF<edges>)) (!
    (= x ($SortWrappers.$SnapTo$FVF<edges>($SortWrappers.$FVF<edges>To$Snap x)))
    :pattern (($SortWrappers.$FVF<edges>To$Snap x))
    :qid |$Snap.$SnapTo$FVF<edges>To$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.$FVF<edges>To$Snap($SortWrappers.$SnapTo$FVF<edges> x)))
    :pattern (($SortWrappers.$SnapTo$FVF<edges> x))
    :qid |$Snap.$FVF<edges>To$SnapTo$FVF<edges>|
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
(declare-fun Set_card (Set<IEdges>) Int)
(declare-const Set_empty Set<IEdges>)
(declare-fun Set_in (IEdges Set<IEdges>) Bool)
(declare-fun Set_singleton (IEdges) Set<IEdges>)
(declare-fun Set_unionone (Set<IEdges> IEdges) Set<IEdges>)
(declare-fun Set_union (Set<IEdges> Set<IEdges>) Set<IEdges>)
(declare-fun Set_intersection (Set<IEdges> Set<IEdges>) Set<IEdges>)
(declare-fun Set_difference (Set<IEdges> Set<IEdges>) Set<IEdges>)
(declare-fun Set_subset (Set<IEdges> Set<IEdges>) Bool)
(declare-fun Set_equal (Set<IEdges> Set<IEdges>) Bool)
(declare-fun Set_skolem_diff (Set<IEdges> Set<IEdges>) IEdges)
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
(declare-fun Seq_length (Seq<$Ref>) Int)
(declare-const Seq_empty Seq<$Ref>)
(declare-fun Seq_singleton ($Ref) Seq<$Ref>)
(declare-fun Seq_append (Seq<$Ref> Seq<$Ref>) Seq<$Ref>)
(declare-fun Seq_index (Seq<$Ref> Int) $Ref)
(declare-fun Seq_add (Int Int) Int)
(declare-fun Seq_sub (Int Int) Int)
(declare-fun Seq_update (Seq<$Ref> Int $Ref) Seq<$Ref>)
(declare-fun Seq_take (Seq<$Ref> Int) Seq<$Ref>)
(declare-fun Seq_drop (Seq<$Ref> Int) Seq<$Ref>)
(declare-fun Seq_contains (Seq<$Ref> $Ref) Bool)
(declare-fun Seq_contains_trigger (Seq<$Ref> $Ref) Bool)
(declare-fun Seq_skolem (Seq<$Ref> $Ref) Int)
(declare-fun Seq_equal (Seq<$Ref> Seq<$Ref>) Bool)
(declare-fun Seq_skolem_diff (Seq<$Ref> Seq<$Ref>) Int)
(declare-fun edge_lookup<Ref> (IEdges Int) $Ref)
(declare-fun has_edge<Bool> (IEdges Int) Bool)
(declare-fun insert_edge<IEdges> (IEdges Int $Ref) IEdges)
(declare-fun edges_domain<Set<Int>> (IEdges) Set<Int>)
(declare-const empty_edges<IEdges> IEdges)
(declare-fun lookup<Ref> (INodeMap $Ref) $Ref)
(declare-fun has_node<Bool> (INodeMap $Ref) Bool)
(declare-fun insert<INodeMap> (INodeMap $Ref $Ref) INodeMap)
(declare-fun map_domain<Seq<Ref>> (INodeMap) Seq<$Ref>)
(declare-const empty_map<INodeMap> INodeMap)
; /field_value_functions_declarations.smt2 [val: Int]
(declare-fun $FVF.domain_val ($FVF<val>) Set<$Ref>)
(declare-fun $FVF.lookup_val ($FVF<val> $Ref) Int)
(declare-fun $FVF.after_val ($FVF<val> $FVF<val>) Bool)
(declare-fun $FVF.loc_val (Int $Ref) Bool)
(declare-fun $FVF.perm_val ($FPM $Ref) $Perm)
(declare-const $fvfTOP_val $FVF<val>)
; /field_value_functions_declarations.smt2 [edges: IEdges]
(declare-fun $FVF.domain_edges ($FVF<edges>) Set<$Ref>)
(declare-fun $FVF.lookup_edges ($FVF<edges> $Ref) IEdges)
(declare-fun $FVF.after_edges ($FVF<edges> $FVF<edges>) Bool)
(declare-fun $FVF.loc_edges (IEdges $Ref) Bool)
(declare-fun $FVF.perm_edges ($FPM $Ref) $Perm)
(declare-const $fvfTOP_edges $FVF<edges>)
; Declaring symbols related to program functions (from program analysis)
; Snapshot variable to be used during function verification
(declare-fun s@$ () $Snap)
; Declaring predicate trigger functions
; ////////// Uniqueness assumptions from domains
; ////////// Axioms
(assert (forall ((s Seq<$Ref>)) (!
  (<= 0 (Seq_length s))
  :pattern ((Seq_length s))
  )))
(assert (= (Seq_length (as Seq_empty  Seq<$Ref>)) 0))
(assert (forall ((s Seq<$Ref>)) (!
  (=> (= (Seq_length s) 0) (= s (as Seq_empty  Seq<$Ref>)))
  :pattern ((Seq_length s))
  )))
(assert (forall ((e $Ref)) (!
  (= (Seq_length (Seq_singleton e)) 1)
  :pattern ((Seq_singleton e))
  )))
(assert (forall ((s0 Seq<$Ref>) (s1 Seq<$Ref>)) (!
  (=>
    (and
      (not (= s0 (as Seq_empty  Seq<$Ref>)))
      (not (= s1 (as Seq_empty  Seq<$Ref>))))
    (= (Seq_length (Seq_append s0 s1)) (+ (Seq_length s0) (Seq_length s1))))
  :pattern ((Seq_length (Seq_append s0 s1)))
  )))
(assert (forall ((s0 Seq<$Ref>) (s1 Seq<$Ref>)) (!
  (and
    (=> (= s0 (as Seq_empty  Seq<$Ref>)) (= (Seq_append s0 s1) s1))
    (=> (= s1 (as Seq_empty  Seq<$Ref>)) (= (Seq_append s0 s1) s0)))
  :pattern ((Seq_append s0 s1))
  )))
(assert (forall ((e $Ref)) (!
  (= (Seq_index (Seq_singleton e) 0) e)
  :pattern ((Seq_singleton e))
  )))
(assert (forall ((i Int) (j Int)) (!
  (= (Seq_add i j) (+ i j))
  :pattern ((Seq_add i j))
  )))
(assert (forall ((i Int) (j Int)) (!
  (= (Seq_sub i j) (- i j))
  :pattern ((Seq_sub i j))
  )))
(assert (forall ((s0 Seq<$Ref>) (s1 Seq<$Ref>) (n Int)) (!
  (=>
    (and
      (not (= s0 (as Seq_empty  Seq<$Ref>)))
      (and
        (not (= s1 (as Seq_empty  Seq<$Ref>)))
        (and (<= 0 n) (< n (Seq_length s0)))))
    (= (Seq_index (Seq_append s0 s1) n) (Seq_index s0 n)))
  :pattern ((Seq_index (Seq_append s0 s1) n))
  :pattern ((Seq_index s0 n) (Seq_append s0 s1))
  )))
(assert (forall ((s0 Seq<$Ref>) (s1 Seq<$Ref>) (n Int)) (!
  (=>
    (and
      (not (= s0 (as Seq_empty  Seq<$Ref>)))
      (and
        (not (= s1 (as Seq_empty  Seq<$Ref>)))
        (and (<= (Seq_length s0) n) (< n (Seq_length (Seq_append s0 s1))))))
    (and
      (= (Seq_add (Seq_sub n (Seq_length s0)) (Seq_length s0)) n)
      (=
        (Seq_index (Seq_append s0 s1) n)
        (Seq_index s1 (Seq_sub n (Seq_length s0))))))
  :pattern ((Seq_index (Seq_append s0 s1) n))
  )))
(assert (forall ((s0 Seq<$Ref>) (s1 Seq<$Ref>) (m Int)) (!
  (=>
    (and
      (not (= s0 (as Seq_empty  Seq<$Ref>)))
      (and
        (not (= s1 (as Seq_empty  Seq<$Ref>)))
        (and (<= 0 m) (< m (Seq_length s1)))))
    (and
      (= (Seq_sub (Seq_add m (Seq_length s0)) (Seq_length s0)) m)
      (=
        (Seq_index (Seq_append s0 s1) (Seq_add m (Seq_length s0)))
        (Seq_index s1 m))))
  :pattern ((Seq_index s1 m) (Seq_append s0 s1))
  )))
(assert (forall ((s Seq<$Ref>) (i Int) (v $Ref)) (!
  (=>
    (and (<= 0 i) (< i (Seq_length s)))
    (= (Seq_length (Seq_update s i v)) (Seq_length s)))
  :pattern ((Seq_length (Seq_update s i v)))
  :pattern ((Seq_length s) (Seq_update s i v))
  )))
(assert (forall ((s Seq<$Ref>) (i Int) (v $Ref) (n Int)) (!
  (=>
    (and (<= 0 n) (< n (Seq_length s)))
    (and
      (=> (= i n) (= (Seq_index (Seq_update s i v) n) v))
      (=> (not (= i n)) (= (Seq_index (Seq_update s i v) n) (Seq_index s n)))))
  :pattern ((Seq_index (Seq_update s i v) n))
  :pattern ((Seq_index s n) (Seq_update s i v))
  )))
(assert (forall ((s Seq<$Ref>) (n Int)) (!
  (and
    (=>
      (<= 0 n)
      (and
        (=> (<= n (Seq_length s)) (= (Seq_length (Seq_take s n)) n))
        (=> (< (Seq_length s) n) (= (Seq_length (Seq_take s n)) (Seq_length s)))))
    (=> (< n 0) (= (Seq_length (Seq_take s n)) 0)))
  :pattern ((Seq_length (Seq_take s n)))
  :pattern ((Seq_take s n) (Seq_length s))
  )))
(assert (forall ((s Seq<$Ref>) (n Int) (j Int)) (!
  (=>
    (and (<= 0 j) (and (< j n) (< j (Seq_length s))))
    (= (Seq_index (Seq_take s n) j) (Seq_index s j)))
  :pattern ((Seq_index (Seq_take s n) j))
  :pattern ((Seq_index s j) (Seq_take s n))
  )))
(assert (forall ((s Seq<$Ref>) (n Int)) (!
  (and
    (=>
      (<= 0 n)
      (and
        (=>
          (<= n (Seq_length s))
          (= (Seq_length (Seq_drop s n)) (- (Seq_length s) n)))
        (=> (< (Seq_length s) n) (= (Seq_length (Seq_drop s n)) 0))))
    (=> (< n 0) (= (Seq_length (Seq_drop s n)) (Seq_length s))))
  :pattern ((Seq_length (Seq_drop s n)))
  :pattern ((Seq_length s) (Seq_drop s n))
  )))
(assert (forall ((s Seq<$Ref>) (n Int) (j Int)) (!
  (=>
    (and (< 0 n) (and (<= 0 j) (< j (- (Seq_length s) n))))
    (and
      (= (Seq_sub (Seq_add j n) n) j)
      (= (Seq_index (Seq_drop s n) j) (Seq_index s (Seq_add j n)))))
  :pattern ((Seq_index (Seq_drop s n) j))
  )))
(assert (forall ((s Seq<$Ref>) (n Int) (i Int)) (!
  (=>
    (and (< 0 n) (and (<= n i) (< i (Seq_length s))))
    (and
      (= (Seq_add (Seq_sub i n) n) i)
      (= (Seq_index (Seq_drop s n) (Seq_sub i n)) (Seq_index s i))))
  :pattern ((Seq_drop s n) (Seq_index s i))
  )))
(assert (forall ((s Seq<$Ref>) (t Seq<$Ref>) (n Int)) (!
  (=>
    (and (< 0 n) (<= n (Seq_length s)))
    (= (Seq_take (Seq_append s t) n) (Seq_take s n)))
  :pattern ((Seq_take (Seq_append s t) n))
  )))
(assert (forall ((s Seq<$Ref>) (t Seq<$Ref>) (n Int)) (!
  (=>
    (and (> n 0) (> n (Seq_length s)))
    (and
      (= (Seq_add (Seq_sub n (Seq_length s)) (Seq_length s)) n)
      (=
        (Seq_take (Seq_append s t) n)
        (Seq_append s (Seq_take t (Seq_sub n (Seq_length s)))))))
  :pattern ((Seq_take (Seq_append s t) n))
  )))
(assert (forall ((s Seq<$Ref>) (t Seq<$Ref>) (n Int)) (!
  (=>
    (and (< 0 n) (<= n (Seq_length s)))
    (= (Seq_drop (Seq_append s t) n) (Seq_append (Seq_drop s n) t)))
  :pattern ((Seq_drop (Seq_append s t) n))
  )))
(assert (forall ((s Seq<$Ref>) (t Seq<$Ref>) (n Int)) (!
  (=>
    (and (> n 0) (> n (Seq_length s)))
    (and
      (= (Seq_add (Seq_sub n (Seq_length s)) (Seq_length s)) n)
      (= (Seq_drop (Seq_append s t) n) (Seq_drop t (Seq_sub n (Seq_length s))))))
  :pattern ((Seq_drop (Seq_append s t) n))
  )))
(assert (forall ((s Seq<$Ref>) (n Int)) (!
  (=> (<= n 0) (= (Seq_take s n) (as Seq_empty  Seq<$Ref>)))
  :pattern ((Seq_take s n))
  )))
(assert (forall ((s Seq<$Ref>) (n Int)) (!
  (=> (<= n 0) (= (Seq_drop s n) s))
  :pattern ((Seq_drop s n))
  )))
(assert (forall ((s Seq<$Ref>) (n Int)) (!
  (=> (>= n (Seq_length s)) (= (Seq_take s n) s))
  :pattern ((Seq_take s n))
  )))
(assert (forall ((s Seq<$Ref>) (n Int)) (!
  (=> (>= n (Seq_length s)) (= (Seq_drop s n) (as Seq_empty  Seq<$Ref>)))
  :pattern ((Seq_drop s n))
  )))
(assert (forall ((s Seq<$Ref>) (x $Ref)) (!
  (=>
    (Seq_contains s x)
    (and
      (<= 0 (Seq_skolem s x))
      (and
        (< (Seq_skolem s x) (Seq_length s))
        (= (Seq_index s (Seq_skolem s x)) x))))
  :pattern ((Seq_contains s x))
  )))
(assert (forall ((s Seq<$Ref>) (x $Ref) (i Int)) (!
  (=>
    (and (<= 0 i) (and (< i (Seq_length s)) (= (Seq_index s i) x)))
    (Seq_contains s x))
  :pattern ((Seq_contains s x) (Seq_index s i))
  )))
(assert (forall ((s Seq<$Ref>) (i Int)) (!
  (=>
    (and (<= 0 i) (< i (Seq_length s)))
    (Seq_contains_trigger s (Seq_index s i)))
  :pattern ((Seq_index s i))
  )))
(assert (forall ((s0 Seq<$Ref>) (s1 Seq<$Ref>)) (!
  (or
    (and (= s0 s1) (Seq_equal s0 s1))
    (or
      (and
        (not (= s0 s1))
        (and (not (Seq_equal s0 s1)) (not (= (Seq_length s0) (Seq_length s1)))))
      (and
        (not (= s0 s1))
        (and
          (not (Seq_equal s0 s1))
          (and
            (= (Seq_length s0) (Seq_length s1))
            (and
              (= (Seq_skolem_diff s0 s1) (Seq_skolem_diff s1 s0))
              (and
                (<= 0 (Seq_skolem_diff s0 s1))
                (and
                  (< (Seq_skolem_diff s0 s1) (Seq_length s0))
                  (not
                    (=
                      (Seq_index s0 (Seq_skolem_diff s0 s1))
                      (Seq_index s1 (Seq_skolem_diff s0 s1))))))))))))
  :pattern ((Seq_equal s0 s1))
  )))
(assert (forall ((a Seq<$Ref>) (b Seq<$Ref>)) (!
  (=> (Seq_equal a b) (= a b))
  :pattern ((Seq_equal a b))
  )))
(assert (forall ((x $Ref) (y $Ref)) (!
  (= (Seq_contains (Seq_singleton x) y) (= x y))
  :pattern ((Seq_contains (Seq_singleton x) y))
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
(assert (forall ((s Set<IEdges>)) (!
  (<= 0 (Set_card s))
  :pattern ((Set_card s))
  )))
(assert (forall ((o IEdges)) (!
  (not (Set_in o (as Set_empty  Set<IEdges>)))
  :pattern ((Set_in o (as Set_empty  Set<IEdges>)))
  )))
(assert (forall ((s Set<IEdges>)) (!
  (and
    (=> (= (Set_card s) 0) (= s (as Set_empty  Set<IEdges>)))
    (=> (not (= (Set_card s) 0)) (exists ((x IEdges))  (Set_in x s))))
  :pattern ((Set_card s))
  )))
(assert (forall ((r IEdges)) (!
  (Set_in r (Set_singleton r))
  :pattern ((Set_singleton r))
  )))
(assert (forall ((r IEdges) (o IEdges)) (!
  (= (Set_in o (Set_singleton r)) (= r o))
  :pattern ((Set_in o (Set_singleton r)))
  )))
(assert (forall ((r IEdges)) (!
  (= (Set_card (Set_singleton r)) 1)
  :pattern ((Set_card (Set_singleton r)))
  )))
(assert (forall ((a Set<IEdges>) (x IEdges) (o IEdges)) (!
  (= (Set_in o (Set_unionone a x)) (or (= o x) (Set_in o a)))
  :pattern ((Set_in o (Set_unionone a x)))
  )))
(assert (forall ((a Set<IEdges>) (x IEdges)) (!
  (Set_in x (Set_unionone a x))
  :pattern ((Set_unionone a x))
  )))
(assert (forall ((a Set<IEdges>) (x IEdges) (y IEdges)) (!
  (=> (Set_in y a) (Set_in y (Set_unionone a x)))
  :pattern ((Set_unionone a x) (Set_in y a))
  )))
(assert (forall ((a Set<IEdges>) (x IEdges)) (!
  (=> (Set_in x a) (= (Set_card (Set_unionone a x)) (Set_card a)))
  :pattern ((Set_card (Set_unionone a x)))
  )))
(assert (forall ((a Set<IEdges>) (x IEdges)) (!
  (=> (not (Set_in x a)) (= (Set_card (Set_unionone a x)) (+ (Set_card a) 1)))
  :pattern ((Set_card (Set_unionone a x)))
  )))
(assert (forall ((a Set<IEdges>) (b Set<IEdges>) (o IEdges)) (!
  (= (Set_in o (Set_union a b)) (or (Set_in o a) (Set_in o b)))
  :pattern ((Set_in o (Set_union a b)))
  )))
(assert (forall ((a Set<IEdges>) (b Set<IEdges>) (y IEdges)) (!
  (=> (Set_in y a) (Set_in y (Set_union a b)))
  :pattern ((Set_union a b) (Set_in y a))
  )))
(assert (forall ((a Set<IEdges>) (b Set<IEdges>) (y IEdges)) (!
  (=> (Set_in y b) (Set_in y (Set_union a b)))
  :pattern ((Set_union a b) (Set_in y b))
  )))
(assert (forall ((a Set<IEdges>) (b Set<IEdges>) (o IEdges)) (!
  (= (Set_in o (Set_intersection a b)) (and (Set_in o a) (Set_in o b)))
  :pattern ((Set_in o (Set_intersection a b)))
  :pattern ((Set_intersection a b) (Set_in o a))
  :pattern ((Set_intersection a b) (Set_in o b))
  )))
(assert (forall ((a Set<IEdges>) (b Set<IEdges>)) (!
  (= (Set_union (Set_union a b) b) (Set_union a b))
  :pattern ((Set_union (Set_union a b) b))
  )))
(assert (forall ((a Set<IEdges>) (b Set<IEdges>)) (!
  (= (Set_union a (Set_union a b)) (Set_union a b))
  :pattern ((Set_union a (Set_union a b)))
  )))
(assert (forall ((a Set<IEdges>) (b Set<IEdges>)) (!
  (= (Set_intersection (Set_intersection a b) b) (Set_intersection a b))
  :pattern ((Set_intersection (Set_intersection a b) b))
  )))
(assert (forall ((a Set<IEdges>) (b Set<IEdges>)) (!
  (= (Set_intersection a (Set_intersection a b)) (Set_intersection a b))
  :pattern ((Set_intersection a (Set_intersection a b)))
  )))
(assert (forall ((a Set<IEdges>) (b Set<IEdges>)) (!
  (=
    (+ (Set_card (Set_union a b)) (Set_card (Set_intersection a b)))
    (+ (Set_card a) (Set_card b)))
  :pattern ((Set_card (Set_union a b)))
  :pattern ((Set_card (Set_intersection a b)))
  )))
(assert (forall ((a Set<IEdges>) (b Set<IEdges>) (o IEdges)) (!
  (= (Set_in o (Set_difference a b)) (and (Set_in o a) (not (Set_in o b))))
  :pattern ((Set_in o (Set_difference a b)))
  :pattern ((Set_difference a b) (Set_in o a))
  )))
(assert (forall ((a Set<IEdges>) (b Set<IEdges>) (y IEdges)) (!
  (=> (Set_in y b) (not (Set_in y (Set_difference a b))))
  :pattern ((Set_difference a b) (Set_in y b))
  )))
(assert (forall ((a Set<IEdges>) (b Set<IEdges>)) (!
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
(assert (forall ((a Set<IEdges>) (b Set<IEdges>)) (!
  (=
    (Set_subset a b)
    (forall ((o IEdges)) (!
      (=> (Set_in o a) (Set_in o b))
      :pattern ((Set_in o a))
      :pattern ((Set_in o b))
      )))
  :pattern ((Set_subset a b))
  )))
(assert (forall ((a Set<IEdges>) (b Set<IEdges>)) (!
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
(assert (forall ((a Set<IEdges>) (b Set<IEdges>)) (!
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
(assert (forall ((e IEdges) (i Int) (node $Ref)) (!
  (= (edge_lookup<Ref> (insert_edge<IEdges> e i node) i) node)
  :pattern ((edge_lookup<Ref> (insert_edge<IEdges> e i node) i))
  :qid |prog.inserted_edge_present|)))
(assert (forall ((e IEdges) (i Int) (node $Ref) (j Int)) (!
  (=>
    (not (= i j))
    (=
      (edge_lookup<Ref> e j)
      (edge_lookup<Ref> (insert_edge<IEdges> e i node) j)))
  :pattern ((edge_lookup<Ref> e j) (insert_edge<IEdges> e i node))
  :pattern ((edge_lookup<Ref> e j) (edge_lookup<Ref> (insert_edge<IEdges> e i node) j))
  :pattern ((edge_lookup<Ref> (insert_edge<IEdges> e i node) j))
  :qid |prog.other_edges_preserved_after_insertion|)))
(assert (forall ((e IEdges) (i Int) (node $Ref)) (!
  (has_edge<Bool> (insert_edge<IEdges> e i node) i)
  :pattern ((has_edge<Bool> (insert_edge<IEdges> e i node) i))
  :qid |prog.inserted_edge_defined|)))
(assert (forall ((e IEdges) (i Int)) (!
  (= (has_edge<Bool> e i) (not (= (edge_lookup<Ref> e i) $Ref.null)))
  :pattern ((has_edge<Bool> e i))
  :pattern ((edge_lookup<Ref> e i))
  :qid |prog.has_edge_complete|)))
(assert (forall ((e IEdges) (i Int)) (!
  (= (Set_in i (edges_domain<Set<Int>> e)) (has_edge<Bool> e i))
  :pattern ((edges_domain<Set<Int>> e) (has_edge<Bool> e i))
  :pattern ((Set_in i (edges_domain<Set<Int>> e)))
  :pattern ((has_edge<Bool> e i))
  :qid |prog.edges_domain_defined|)))
(assert (forall ((i Int)) (!
  (not (has_edge<Bool> (as empty_edges<IEdges>  IEdges) i))
  :pattern ((has_edge<Bool> (as empty_edges<IEdges>  IEdges) i))
  :qid |prog.empty_edges_has_no_nodes|)))
(assert (forall ((node_map INodeMap) (key_node $Ref) (val_node $Ref)) (!
  (=
    (lookup<Ref> (insert<INodeMap> node_map key_node val_node) key_node)
    val_node)
  :pattern ((lookup<Ref> (insert<INodeMap> node_map key_node val_node) key_node))
  :qid |prog.inserted_node_present|)))
(assert (forall ((node_map INodeMap) (key_node $Ref) (val_node $Ref) (node $Ref)) (!
  (=>
    (not (= node key_node))
    (=
      (lookup<Ref> node_map node)
      (lookup<Ref> (insert<INodeMap> node_map key_node val_node) node)))
  :pattern ((lookup<Ref> node_map node) (insert<INodeMap> node_map key_node val_node))
  :pattern ((lookup<Ref> node_map node) (lookup<Ref> (insert<INodeMap> node_map key_node val_node) node))
  :pattern ((lookup<Ref> (insert<INodeMap> node_map key_node val_node) node))
  :qid |prog.other_nodes_preserved_after_insertion|)))
(assert (forall ((node_map INodeMap) (key_node $Ref) (val_node $Ref)) (!
  (has_node<Bool> (insert<INodeMap> node_map key_node val_node) key_node)
  :pattern ((has_node<Bool> (insert<INodeMap> node_map key_node val_node) key_node))
  :qid |prog.inserted_node_defined|)))
(assert (forall ((node_map INodeMap) (node $Ref)) (!
  (=
    (has_node<Bool> node_map node)
    (not (= (lookup<Ref> node_map node) $Ref.null)))
  :pattern ((has_node<Bool> node_map node))
  :pattern ((lookup<Ref> node_map node))
  :qid |prog.has_node_complete|)))
(assert (forall ((node_map INodeMap) (key $Ref)) (!
  (=
    (Seq_contains (map_domain<Seq<Ref>> node_map) key)
    (has_node<Bool> node_map key))
  :pattern ((map_domain<Seq<Ref>> node_map) (has_node<Bool> node_map key))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> node_map) key))
  :pattern ((Seq_contains_trigger (map_domain<Seq<Ref>> node_map) key))
  :pattern ((Seq_contains_trigger (map_domain<Seq<Ref>> node_map) key))
  :pattern ((has_node<Bool> node_map key))
  :qid |prog.domain_is_defined|)))
(assert (forall ((node $Ref)) (!
  (not (has_node<Bool> (as empty_map<INodeMap>  INodeMap) node))
  :pattern ((has_node<Bool> (as empty_map<INodeMap>  INodeMap) node))
  :qid |prog.empty_map_has_no_nodes|)))
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
; /field_value_functions_axioms.smt2 [edges: IEdges]
(assert (forall ((vs $FVF<edges>) (ws $FVF<edges>)) (!
    (=>
      (and
        (Set_equal ($FVF.domain_edges vs) ($FVF.domain_edges ws))
        (forall ((x $Ref)) (!
          (=>
            (Set_in x ($FVF.domain_edges vs))
            (= ($FVF.lookup_edges vs x) ($FVF.lookup_edges ws x)))
          :pattern (($FVF.lookup_edges vs x) ($FVF.lookup_edges ws x))
          :qid |qp.$FVF<edges>-eq-inner|
          )))
      (= vs ws))
    :pattern (($SortWrappers.$FVF<edges>To$Snap vs)
              ($SortWrappers.$FVF<edges>To$Snap ws)
              )
    :qid |qp.$FVF<edges>-eq-outer|
    )))
(assert (forall ((r $Ref) (pm $FPM)) (!
    ($Perm.isValidVar ($FVF.perm_edges pm r))
    :pattern (($FVF.perm_edges pm r)))))
(assert (forall ((r $Ref) (f IEdges)) (!
    (= ($FVF.loc_edges f r) true)
    :pattern (($FVF.loc_edges f r)))))
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
; ---------- graph_copy_rec ----------
(declare-const this@0@12 $Ref)
(declare-const node_map@1@12 INodeMap)
(declare-const setOfRef@2@12 Set<$Ref>)
(declare-const node_map_image@3@12 Set<$Ref>)
(declare-const rd@4@12 $Perm)
(declare-const nodeCopy@5@12 $Ref)
(declare-const res_node_map@6@12 INodeMap)
(declare-const res_copy_nodes@7@12 Set<$Ref>)
(declare-const this@8@12 $Ref)
(declare-const node_map@9@12 INodeMap)
(declare-const setOfRef@10@12 Set<$Ref>)
(declare-const node_map_image@11@12 Set<$Ref>)
(declare-const rd@12@12 $Perm)
(declare-const nodeCopy@13@12 $Ref)
(declare-const res_node_map@14@12 INodeMap)
(declare-const res_copy_nodes@15@12 Set<$Ref>)
(set-option :timeout 0)
(push) ; 1
(declare-const $t@16@12 $Snap)
(assert (= $t@16@12 ($Snap.combine ($Snap.first $t@16@12) ($Snap.second $t@16@12))))
(assert (= ($Snap.first $t@16@12) $Snap.unit))
; [eval] none < rd
(assert (< $Perm.No rd@12@12))
(assert (=
  ($Snap.second $t@16@12)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@16@12))
    ($Snap.second ($Snap.second $t@16@12)))))
(assert (= ($Snap.first ($Snap.second $t@16@12)) $Snap.unit))
; [eval] this != null
(assert (not (= this@8@12 $Ref.null)))
(assert (=
  ($Snap.second ($Snap.second $t@16@12))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@16@12)))
    ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@16@12))) $Snap.unit))
; [eval] (this in setOfRef)
(assert (Set_in this@8@12 setOfRef@10@12))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@16@12)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@16@12))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@16@12))))
  $Snap.unit))
; [eval] |(setOfRef intersection node_map_image)| == 0
; [eval] |(setOfRef intersection node_map_image)|
; [eval] (setOfRef intersection node_map_image)
(assert (= (Set_card (Set_intersection setOfRef@10@12 node_map_image@11@12)) 0))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))))
(declare-const x@17@12 $Ref)
(push) ; 2
; [eval] (x in setOfRef)
(assert (Set_in x@17@12 setOfRef@10@12))
(pop) ; 2
(declare-fun inv@18@12 ($Ref) $Ref)
(declare-fun img@19@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 2
(assert (not (forall ((x@17@12 $Ref)) (!
  (=>
    (Set_in x@17@12 setOfRef@10@12)
    (or (= rd@12@12 $Perm.No) (< $Perm.No rd@12@12)))
  
  :qid |quant-u-0|))))
(check-sat)
; unsat
(pop) ; 2
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 2
(assert (not (forall ((x1@17@12 $Ref) (x2@17@12 $Ref)) (!
  (=>
    (and
      (and (Set_in x1@17@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (and (Set_in x2@17@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (= x1@17@12 x2@17@12))
    (= x1@17@12 x2@17@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 2
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@17@12 $Ref)) (!
  (=>
    (and (Set_in x@17@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@18@12 x@17@12) x@17@12) (img@19@12 x@17@12)))
  :pattern ((Set_in x@17@12 setOfRef@10@12))
  :pattern ((inv@18@12 x@17@12))
  :pattern ((img@19@12 x@17@12))
  :qid |quant-u-1|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@19@12 r)
      (and (Set_in (inv@18@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@18@12 r) r))
  :pattern ((inv@18@12 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
(assert (forall ((x@17@12 $Ref)) (!
  (<= $Perm.No rd@12@12)
  :pattern ((Set_in x@17@12 setOfRef@10@12))
  :pattern ((inv@18@12 x@17@12))
  :pattern ((img@19@12 x@17@12))
  :qid |val-permAtLeastZero|)))
; Field permissions are at most one
(assert (forall ((x@17@12 $Ref)) (!
  (<= rd@12@12 $Perm.Write)
  :pattern ((Set_in x@17@12 setOfRef@10@12))
  :pattern ((inv@18@12 x@17@12))
  :pattern ((img@19@12 x@17@12))
  :qid |val-permAtMostOne|)))
; Permission implies non-null receiver
(assert (forall ((x@17@12 $Ref)) (!
  (=>
    (and (Set_in x@17@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (not (= x@17@12 $Ref.null)))
  :pattern ((Set_in x@17@12 setOfRef@10@12))
  :pattern ((inv@18@12 x@17@12))
  :pattern ((img@19@12 x@17@12))
  :qid |val-permImpliesNonNull|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))
(declare-const x@20@12 $Ref)
(push) ; 2
; [eval] (x in setOfRef)
(assert (Set_in x@20@12 setOfRef@10@12))
(pop) ; 2
(declare-fun inv@21@12 ($Ref) $Ref)
(declare-fun img@22@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 2
(assert (not (forall ((x@20@12 $Ref)) (!
  (=>
    (Set_in x@20@12 setOfRef@10@12)
    (or (= rd@12@12 $Perm.No) (< $Perm.No rd@12@12)))
  
  :qid |quant-u-2|))))
(check-sat)
; unsat
(pop) ; 2
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 2
(assert (not (forall ((x1@20@12 $Ref) (x2@20@12 $Ref)) (!
  (=>
    (and
      (and (Set_in x1@20@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (and (Set_in x2@20@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (= x1@20@12 x2@20@12))
    (= x1@20@12 x2@20@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 2
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@20@12 $Ref)) (!
  (=>
    (and (Set_in x@20@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@21@12 x@20@12) x@20@12) (img@22@12 x@20@12)))
  :pattern ((Set_in x@20@12 setOfRef@10@12))
  :pattern ((inv@21@12 x@20@12))
  :pattern ((img@22@12 x@20@12))
  :qid |quant-u-3|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@22@12 r)
      (and (Set_in (inv@21@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@21@12 r) r))
  :pattern ((inv@21@12 r))
  :qid |edges-fctOfInv|)))
; Permissions are non-negative
(assert (forall ((x@20@12 $Ref)) (!
  (<= $Perm.No rd@12@12)
  :pattern ((Set_in x@20@12 setOfRef@10@12))
  :pattern ((inv@21@12 x@20@12))
  :pattern ((img@22@12 x@20@12))
  :qid |edges-permAtLeastZero|)))
; Field permissions are at most one
(assert (forall ((x@20@12 $Ref)) (!
  (<= rd@12@12 $Perm.Write)
  :pattern ((Set_in x@20@12 setOfRef@10@12))
  :pattern ((inv@21@12 x@20@12))
  :pattern ((img@22@12 x@20@12))
  :qid |edges-permAtMostOne|)))
; Permission implies non-null receiver
(assert (forall ((x@20@12 $Ref)) (!
  (=>
    (and (Set_in x@20@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (not (= x@20@12 $Ref.null)))
  :pattern ((Set_in x@20@12 setOfRef@10@12))
  :pattern ((inv@21@12 x@20@12))
  :pattern ((img@22@12 x@20@12))
  :qid |edges-permImpliesNonNull|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))
  $Snap.unit))
; [eval] (forall x: Ref, i: Int :: { (x in setOfRef), (i in edges_domain(x.edges)) } { (x in setOfRef), edge_lookup(x.edges, i) } { (x in setOfRef), (edge_lookup(x.edges, i) in setOfRef) } { edges_domain(x.edges), edge_lookup(x.edges, i) } { edges_domain(x.edges), (edge_lookup(x.edges, i) in setOfRef) } { (i in edges_domain(x.edges)) } { (edge_lookup(x.edges, i) in setOfRef) } (x in setOfRef) && (i in edges_domain(x.edges)) ==> (edge_lookup(x.edges, i) in setOfRef))
(declare-const x@23@12 $Ref)
(declare-const i@24@12 Int)
(push) ; 2
; [eval] (x in setOfRef) && (i in edges_domain(x.edges)) ==> (edge_lookup(x.edges, i) in setOfRef)
; [eval] (x in setOfRef) && (i in edges_domain(x.edges))
; [eval] (x in setOfRef)
(push) ; 3
; [then-branch: 0 | !(x@23@12 in setOfRef@10@12) | live]
; [else-branch: 0 | x@23@12 in setOfRef@10@12 | live]
(push) ; 4
; [then-branch: 0 | !(x@23@12 in setOfRef@10@12)]
(assert (not (Set_in x@23@12 setOfRef@10@12)))
(pop) ; 4
(push) ; 4
; [else-branch: 0 | x@23@12 in setOfRef@10@12]
(assert (Set_in x@23@12 setOfRef@10@12))
; [eval] (i in edges_domain(x.edges))
; [eval] edges_domain(x.edges)
(push) ; 5
(assert (not (ite
  (and (img@22@12 x@23@12) (Set_in (inv@21@12 x@23@12) setOfRef@10@12))
  (< $Perm.No rd@12@12)
  false)))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (or (Set_in x@23@12 setOfRef@10@12) (not (Set_in x@23@12 setOfRef@10@12))))
(push) ; 3
; [then-branch: 1 | x@23@12 in setOfRef@10@12 && i@24@12 in edges_domain[Set[Int]](Lookup(edges, First:(Second:(Second:(Second:(Second:(Second:($t@16@12)))))), x@23@12)) | live]
; [else-branch: 1 | !(x@23@12 in setOfRef@10@12 && i@24@12 in edges_domain[Set[Int]](Lookup(edges, First:(Second:(Second:(Second:(Second:(Second:($t@16@12)))))), x@23@12))) | live]
(push) ; 4
; [then-branch: 1 | x@23@12 in setOfRef@10@12 && i@24@12 in edges_domain[Set[Int]](Lookup(edges, First:(Second:(Second:(Second:(Second:(Second:($t@16@12)))))), x@23@12))]
(assert (and
  (Set_in x@23@12 setOfRef@10@12)
  (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12)))))
; [eval] (edge_lookup(x.edges, i) in setOfRef)
; [eval] edge_lookup(x.edges, i)
(push) ; 5
(assert (not (ite
  (and (img@22@12 x@23@12) (Set_in (inv@21@12 x@23@12) setOfRef@10@12))
  (< $Perm.No rd@12@12)
  false)))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(pop) ; 4
(push) ; 4
; [else-branch: 1 | !(x@23@12 in setOfRef@10@12 && i@24@12 in edges_domain[Set[Int]](Lookup(edges, First:(Second:(Second:(Second:(Second:(Second:($t@16@12)))))), x@23@12)))]
(assert (not
  (and
    (Set_in x@23@12 setOfRef@10@12)
    (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12))))))
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in x@23@12 setOfRef@10@12)
      (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12)))))
  (and
    (Set_in x@23@12 setOfRef@10@12)
    (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12))))))
(pop) ; 2
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@23@12 $Ref) (i@24@12 Int)) (!
  (and
    (or (Set_in x@23@12 setOfRef@10@12) (not (Set_in x@23@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@23@12 setOfRef@10@12)
          (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12)))))
      (and
        (Set_in x@23@12 setOfRef@10@12)
        (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12))))))
  :pattern ((Set_in x@23@12 setOfRef@10@12) (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120-aux|)))
(assert (forall ((x@23@12 $Ref) (i@24@12 Int)) (!
  (and
    (or (Set_in x@23@12 setOfRef@10@12) (not (Set_in x@23@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@23@12 setOfRef@10@12)
          (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12)))))
      (and
        (Set_in x@23@12 setOfRef@10@12)
        (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12))))))
  :pattern ((Set_in x@23@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12) i@24@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120-aux|)))
(assert (forall ((x@23@12 $Ref) (i@24@12 Int)) (!
  (and
    (or (Set_in x@23@12 setOfRef@10@12) (not (Set_in x@23@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@23@12 setOfRef@10@12)
          (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12)))))
      (and
        (Set_in x@23@12 setOfRef@10@12)
        (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12))))))
  :pattern ((Set_in x@23@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12) i@24@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120-aux|)))
(assert (forall ((x@23@12 $Ref) (i@24@12 Int)) (!
  (and
    (or (Set_in x@23@12 setOfRef@10@12) (not (Set_in x@23@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@23@12 setOfRef@10@12)
          (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12)))))
      (and
        (Set_in x@23@12 setOfRef@10@12)
        (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12)) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12) i@24@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120-aux|)))
(assert (forall ((x@23@12 $Ref) (i@24@12 Int)) (!
  (and
    (or (Set_in x@23@12 setOfRef@10@12) (not (Set_in x@23@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@23@12 setOfRef@10@12)
          (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12)))))
      (and
        (Set_in x@23@12 setOfRef@10@12)
        (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12) i@24@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120-aux|)))
(assert (forall ((x@23@12 $Ref) (i@24@12 Int)) (!
  (and
    (or (Set_in x@23@12 setOfRef@10@12) (not (Set_in x@23@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@23@12 setOfRef@10@12)
          (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12)))))
      (and
        (Set_in x@23@12 setOfRef@10@12)
        (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12))))))
  :pattern ((Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120-aux|)))
(assert (forall ((x@23@12 $Ref) (i@24@12 Int)) (!
  (and
    (or (Set_in x@23@12 setOfRef@10@12) (not (Set_in x@23@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@23@12 setOfRef@10@12)
          (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12)))))
      (and
        (Set_in x@23@12 setOfRef@10@12)
        (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12))))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12) i@24@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120-aux|)))
(assert (forall ((x@23@12 $Ref) (i@24@12 Int)) (!
  (=>
    (and
      (Set_in x@23@12 setOfRef@10@12)
      (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12))))
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12) i@24@12) setOfRef@10@12))
  :pattern ((Set_in x@23@12 setOfRef@10@12) (Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12))))
  :pattern ((Set_in x@23@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12) i@24@12))
  :pattern ((Set_in x@23@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12) i@24@12) setOfRef@10@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12)) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12) i@24@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12) i@24@12) setOfRef@10@12))
  :pattern ((Set_in i@24@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) x@23@12) i@24@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))))
  $Snap.unit))
; [eval] (forall x: Ref :: { (x in map_domain(node_map)) } { (lookup(node_map, x) in node_map_image) } (x in map_domain(node_map)) ==> (lookup(node_map, x) in node_map_image))
(declare-const x@25@12 $Ref)
(push) ; 2
; [eval] (x in map_domain(node_map)) ==> (lookup(node_map, x) in node_map_image)
; [eval] (x in map_domain(node_map))
; [eval] map_domain(node_map)
(push) ; 3
; [then-branch: 2 | x@25@12 in map_domain[Seq[Ref]](node_map@9@12) | live]
; [else-branch: 2 | !(x@25@12 in map_domain[Seq[Ref]](node_map@9@12)) | live]
(push) ; 4
; [then-branch: 2 | x@25@12 in map_domain[Seq[Ref]](node_map@9@12)]
(assert (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@25@12))
; [eval] (lookup(node_map, x) in node_map_image)
; [eval] lookup(node_map, x)
(pop) ; 4
(push) ; 4
; [else-branch: 2 | !(x@25@12 in map_domain[Seq[Ref]](node_map@9@12))]
(assert (not (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@25@12)))
(pop) ; 4
(pop) ; 3
; Joined path conditions
; Joined path conditions
(assert (or
  (not (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@25@12))
  (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@25@12)))
(pop) ; 2
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@25@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@25@12))
    (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@25@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@25@12))
  :pattern ((Seq_contains_trigger (map_domain<Seq<Ref>> node_map@9@12) x@25@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@100@12@100@96-aux|)))
(assert (forall ((x@25@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@25@12))
    (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@25@12))
  :pattern ((Seq_contains_trigger (map_domain<Seq<Ref>> node_map@9@12) x@25@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@100@12@100@96-aux|)))
(assert (forall ((x@25@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@25@12))
    (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@25@12))
  :pattern ((Set_in (lookup<Ref> node_map@9@12 x@25@12) node_map_image@11@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@100@12@100@96-aux|)))
(assert (forall ((x@25@12 $Ref)) (!
  (=>
    (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@25@12)
    (Set_in (lookup<Ref> node_map@9@12 x@25@12) node_map_image@11@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@25@12))
  :pattern ((Seq_contains_trigger (map_domain<Seq<Ref>> node_map@9@12) x@25@12))
  :pattern ((Set_in (lookup<Ref> node_map@9@12 x@25@12) node_map_image@11@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@100@12@100@96|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))))))))
(declare-const x@26@12 $Ref)
(push) ; 2
; [eval] (x in node_map_image)
(assert (Set_in x@26@12 node_map_image@11@12))
(pop) ; 2
(declare-fun inv@27@12 ($Ref) $Ref)
(declare-fun img@28@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 2
(assert (not (forall ((x1@26@12 $Ref) (x2@26@12 $Ref)) (!
  (=>
    (and
      (Set_in x1@26@12 node_map_image@11@12)
      (Set_in x2@26@12 node_map_image@11@12)
      (= x1@26@12 x2@26@12))
    (= x1@26@12 x2@26@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 2
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@26@12 $Ref)) (!
  (=>
    (Set_in x@26@12 node_map_image@11@12)
    (and (= (inv@27@12 x@26@12) x@26@12) (img@28@12 x@26@12)))
  :pattern ((Set_in x@26@12 node_map_image@11@12))
  :pattern ((inv@27@12 x@26@12))
  :pattern ((img@28@12 x@26@12))
  :qid |quant-u-5|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (= (inv@27@12 r) r))
  :pattern ((inv@27@12 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((x@26@12 $Ref)) (!
  (=> (Set_in x@26@12 node_map_image@11@12) (not (= x@26@12 $Ref.null)))
  :pattern ((Set_in x@26@12 node_map_image@11@12))
  :pattern ((inv@27@12 x@26@12))
  :pattern ((img@28@12 x@26@12))
  :qid |val-permImpliesNonNull|)))
(push) ; 2
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= x@26@12 x@17@12)
    (=
      (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))))
  
  :qid |quant-u-6|))))
(check-sat)
; unknown
(pop) ; 2
; 0.00s
; (get-info :all-statistics)
(declare-const x@29@12 $Ref)
(set-option :timeout 0)
(push) ; 2
; [eval] (x in node_map_image)
(assert (Set_in x@29@12 node_map_image@11@12))
(pop) ; 2
(declare-fun inv@30@12 ($Ref) $Ref)
(declare-fun img@31@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 2
(assert (not (forall ((x1@29@12 $Ref) (x2@29@12 $Ref)) (!
  (=>
    (and
      (Set_in x1@29@12 node_map_image@11@12)
      (Set_in x2@29@12 node_map_image@11@12)
      (= x1@29@12 x2@29@12))
    (= x1@29@12 x2@29@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 2
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@29@12 $Ref)) (!
  (=>
    (Set_in x@29@12 node_map_image@11@12)
    (and (= (inv@30@12 x@29@12) x@29@12) (img@31@12 x@29@12)))
  :pattern ((Set_in x@29@12 node_map_image@11@12))
  :pattern ((inv@30@12 x@29@12))
  :pattern ((img@31@12 x@29@12))
  :qid |quant-u-8|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (= (inv@30@12 r) r))
  :pattern ((inv@30@12 r))
  :qid |edges-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((x@29@12 $Ref)) (!
  (=> (Set_in x@29@12 node_map_image@11@12) (not (= x@29@12 $Ref.null)))
  :pattern ((Set_in x@29@12 node_map_image@11@12))
  :pattern ((inv@30@12 x@29@12))
  :pattern ((img@31@12 x@29@12))
  :qid |edges-permImpliesNonNull|)))
(push) ; 2
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= x@29@12 x@20@12)
    (=
      (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))))
  
  :qid |quant-u-9|))))
(check-sat)
; unknown
(pop) ; 2
; 0.00s
; (get-info :all-statistics)
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
(set-option :timeout 0)
(push) ; 2
(declare-const $t@32@12 $Snap)
(assert (= $t@32@12 ($Snap.combine ($Snap.first $t@32@12) ($Snap.second $t@32@12))))
(assert (= ($Snap.first $t@32@12) $Snap.unit))
; [eval] nodeCopy != null
(assert (not (= nodeCopy@13@12 $Ref.null)))
(assert (=
  ($Snap.second $t@32@12)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@32@12))
    ($Snap.second ($Snap.second $t@32@12)))))
(assert (= ($Snap.first ($Snap.second $t@32@12)) $Snap.unit))
; [eval] (nodeCopy in res_copy_nodes)
(assert (Set_in nodeCopy@13@12 res_copy_nodes@15@12))
(assert (=
  ($Snap.second ($Snap.second $t@32@12))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@32@12)))
    ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@32@12))) $Snap.unit))
; [eval] |(setOfRef intersection res_copy_nodes)| == 0
; [eval] |(setOfRef intersection res_copy_nodes)|
; [eval] (setOfRef intersection res_copy_nodes)
(assert (= (Set_card (Set_intersection setOfRef@10@12 res_copy_nodes@15@12)) 0))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@32@12)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@32@12))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12)))))))
(declare-const x@33@12 $Ref)
(push) ; 3
; [eval] (x in setOfRef)
(assert (Set_in x@33@12 setOfRef@10@12))
(pop) ; 3
(declare-fun inv@34@12 ($Ref) $Ref)
(declare-fun img@35@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 3
(assert (not (forall ((x@33@12 $Ref)) (!
  (=>
    (Set_in x@33@12 setOfRef@10@12)
    (or (= rd@12@12 $Perm.No) (< $Perm.No rd@12@12)))
  
  :qid |quant-u-10|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((x1@33@12 $Ref) (x2@33@12 $Ref)) (!
  (=>
    (and
      (and (Set_in x1@33@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (and (Set_in x2@33@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (= x1@33@12 x2@33@12))
    (= x1@33@12 x2@33@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@33@12 $Ref)) (!
  (=>
    (and (Set_in x@33@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@34@12 x@33@12) x@33@12) (img@35@12 x@33@12)))
  :pattern ((Set_in x@33@12 setOfRef@10@12))
  :pattern ((inv@34@12 x@33@12))
  :pattern ((img@35@12 x@33@12))
  :qid |quant-u-11|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@35@12 r)
      (and (Set_in (inv@34@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@34@12 r) r))
  :pattern ((inv@34@12 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
(assert (forall ((x@33@12 $Ref)) (!
  (<= $Perm.No rd@12@12)
  :pattern ((Set_in x@33@12 setOfRef@10@12))
  :pattern ((inv@34@12 x@33@12))
  :pattern ((img@35@12 x@33@12))
  :qid |val-permAtLeastZero|)))
; Field permissions are at most one
(assert (forall ((x@33@12 $Ref)) (!
  (<= rd@12@12 $Perm.Write)
  :pattern ((Set_in x@33@12 setOfRef@10@12))
  :pattern ((inv@34@12 x@33@12))
  :pattern ((img@35@12 x@33@12))
  :qid |val-permAtMostOne|)))
; Permission implies non-null receiver
(assert (forall ((x@33@12 $Ref)) (!
  (=>
    (and (Set_in x@33@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (not (= x@33@12 $Ref.null)))
  :pattern ((Set_in x@33@12 setOfRef@10@12))
  :pattern ((inv@34@12 x@33@12))
  :pattern ((img@35@12 x@33@12))
  :qid |val-permImpliesNonNull|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12)))))
  $Snap.unit))
; [eval] (forall x: Ref :: { (x in setOfRef) } (x in setOfRef) ==> x.val == old(x.val))
(declare-const x@36@12 $Ref)
(push) ; 3
; [eval] (x in setOfRef) ==> x.val == old(x.val)
; [eval] (x in setOfRef)
(push) ; 4
; [then-branch: 3 | x@36@12 in setOfRef@10@12 | live]
; [else-branch: 3 | !(x@36@12 in setOfRef@10@12) | live]
(push) ; 5
; [then-branch: 3 | x@36@12 in setOfRef@10@12]
(assert (Set_in x@36@12 setOfRef@10@12))
; [eval] x.val == old(x.val)
(push) ; 6
(assert (not (ite
  (and (img@35@12 x@36@12) (Set_in (inv@34@12 x@36@12) setOfRef@10@12))
  (< $Perm.No rd@12@12)
  false)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] old(x.val)
(declare-const sm@37@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@37@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@37@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef0|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@37@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@37@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef1|)))
(declare-const pm@38@12 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@38@12  $FPM) r)
    (+
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@38@12  $FPM) r))
  :qid |qp.resPrmSumDef2|)))
(push) ; 6
(assert (not (< $Perm.No ($FVF.perm_val (as pm@38@12  $FPM) x@36@12))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 3 | !(x@36@12 in setOfRef@10@12)]
(assert (not (Set_in x@36@12 setOfRef@10@12)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@37@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@37@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef0|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@37@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@37@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef1|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@38@12  $FPM) r)
    (+
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@38@12  $FPM) r))
  :qid |qp.resPrmSumDef2|)))
; Joined path conditions
(assert (or (not (Set_in x@36@12 setOfRef@10@12)) (Set_in x@36@12 setOfRef@10@12)))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@37@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@37@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef0|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@37@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@37@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef1|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@38@12  $FPM) r)
    (+
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@38@12  $FPM) r))
  :qid |qp.resPrmSumDef2|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@36@12 $Ref)) (!
  (or (not (Set_in x@36@12 setOfRef@10@12)) (Set_in x@36@12 setOfRef@10@12))
  :pattern ((Set_in x@36@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@107@11@107@65-aux|)))
(assert (forall ((x@36@12 $Ref)) (!
  (=>
    (Set_in x@36@12 setOfRef@10@12)
    (=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@32@12))))) x@36@12)
      ($FVF.lookup_val (as sm@37@12  $FVF<val>) x@36@12)))
  :pattern ((Set_in x@36@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@107@11@107@65|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12)))))))))
(declare-const x@39@12 $Ref)
(push) ; 3
; [eval] (x in setOfRef)
(assert (Set_in x@39@12 setOfRef@10@12))
(pop) ; 3
(declare-fun inv@40@12 ($Ref) $Ref)
(declare-fun img@41@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 3
(assert (not (forall ((x@39@12 $Ref)) (!
  (=>
    (Set_in x@39@12 setOfRef@10@12)
    (or (= rd@12@12 $Perm.No) (< $Perm.No rd@12@12)))
  
  :qid |quant-u-12|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((x1@39@12 $Ref) (x2@39@12 $Ref)) (!
  (=>
    (and
      (and (Set_in x1@39@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (and (Set_in x2@39@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (= x1@39@12 x2@39@12))
    (= x1@39@12 x2@39@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@39@12 $Ref)) (!
  (=>
    (and (Set_in x@39@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@40@12 x@39@12) x@39@12) (img@41@12 x@39@12)))
  :pattern ((Set_in x@39@12 setOfRef@10@12))
  :pattern ((inv@40@12 x@39@12))
  :pattern ((img@41@12 x@39@12))
  :qid |quant-u-13|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@41@12 r)
      (and (Set_in (inv@40@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@40@12 r) r))
  :pattern ((inv@40@12 r))
  :qid |edges-fctOfInv|)))
; Permissions are non-negative
(assert (forall ((x@39@12 $Ref)) (!
  (<= $Perm.No rd@12@12)
  :pattern ((Set_in x@39@12 setOfRef@10@12))
  :pattern ((inv@40@12 x@39@12))
  :pattern ((img@41@12 x@39@12))
  :qid |edges-permAtLeastZero|)))
; Field permissions are at most one
(assert (forall ((x@39@12 $Ref)) (!
  (<= rd@12@12 $Perm.Write)
  :pattern ((Set_in x@39@12 setOfRef@10@12))
  :pattern ((inv@40@12 x@39@12))
  :pattern ((img@41@12 x@39@12))
  :qid |edges-permAtMostOne|)))
; Permission implies non-null receiver
(assert (forall ((x@39@12 $Ref)) (!
  (=>
    (and (Set_in x@39@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (not (= x@39@12 $Ref.null)))
  :pattern ((Set_in x@39@12 setOfRef@10@12))
  :pattern ((inv@40@12 x@39@12))
  :pattern ((img@41@12 x@39@12))
  :qid |edges-permImpliesNonNull|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12)))))))
  $Snap.unit))
; [eval] (forall x: Ref :: { (x in setOfRef) } (x in setOfRef) ==> x.edges == old(x.edges))
(declare-const x@42@12 $Ref)
(push) ; 3
; [eval] (x in setOfRef) ==> x.edges == old(x.edges)
; [eval] (x in setOfRef)
(push) ; 4
; [then-branch: 4 | x@42@12 in setOfRef@10@12 | live]
; [else-branch: 4 | !(x@42@12 in setOfRef@10@12) | live]
(push) ; 5
; [then-branch: 4 | x@42@12 in setOfRef@10@12]
(assert (Set_in x@42@12 setOfRef@10@12))
; [eval] x.edges == old(x.edges)
(push) ; 6
(assert (not (ite
  (and (img@41@12 x@42@12) (Set_in (inv@40@12 x@42@12) setOfRef@10@12))
  (< $Perm.No rd@12@12)
  false)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [eval] old(x.edges)
(declare-const sm@43@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@43@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@43@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@43@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@43@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef4|)))
(declare-const pm@44@12 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@44@12  $FPM) r)
    (+
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@44@12  $FPM) r))
  :qid |qp.resPrmSumDef5|)))
(push) ; 6
(assert (not (< $Perm.No ($FVF.perm_edges (as pm@44@12  $FPM) x@42@12))))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 4 | !(x@42@12 in setOfRef@10@12)]
(assert (not (Set_in x@42@12 setOfRef@10@12)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@43@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@43@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@43@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@43@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@44@12  $FPM) r)
    (+
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@44@12  $FPM) r))
  :qid |qp.resPrmSumDef5|)))
; Joined path conditions
(assert (or (not (Set_in x@42@12 setOfRef@10@12)) (Set_in x@42@12 setOfRef@10@12)))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@43@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@43@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef3|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@43@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@43@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef4|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@44@12  $FPM) r)
    (+
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@44@12  $FPM) r))
  :qid |qp.resPrmSumDef5|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@42@12 $Ref)) (!
  (or (not (Set_in x@42@12 setOfRef@10@12)) (Set_in x@42@12 setOfRef@10@12))
  :pattern ((Set_in x@42@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@109@11@109@69-aux|)))
(assert (forall ((x@42@12 $Ref)) (!
  (=>
    (Set_in x@42@12 setOfRef@10@12)
    (=
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@42@12)
      ($FVF.lookup_edges (as sm@43@12  $FVF<edges>) x@42@12)))
  :pattern ((Set_in x@42@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@109@11@109@69|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))))
  $Snap.unit))
; [eval] (forall x: Ref, i: Int :: { (x in setOfRef), (i in edges_domain(x.edges)) } { (x in setOfRef), edge_lookup(x.edges, i) } { (x in setOfRef), (edge_lookup(x.edges, i) in setOfRef) } { edges_domain(x.edges), edge_lookup(x.edges, i) } { edges_domain(x.edges), (edge_lookup(x.edges, i) in setOfRef) } { (i in edges_domain(x.edges)) } { (edge_lookup(x.edges, i) in setOfRef) } (x in setOfRef) && (i in edges_domain(x.edges)) ==> (edge_lookup(x.edges, i) in setOfRef))
(declare-const x@45@12 $Ref)
(declare-const i@46@12 Int)
(push) ; 3
; [eval] (x in setOfRef) && (i in edges_domain(x.edges)) ==> (edge_lookup(x.edges, i) in setOfRef)
; [eval] (x in setOfRef) && (i in edges_domain(x.edges))
; [eval] (x in setOfRef)
(push) ; 4
; [then-branch: 5 | !(x@45@12 in setOfRef@10@12) | live]
; [else-branch: 5 | x@45@12 in setOfRef@10@12 | live]
(push) ; 5
; [then-branch: 5 | !(x@45@12 in setOfRef@10@12)]
(assert (not (Set_in x@45@12 setOfRef@10@12)))
(pop) ; 5
(push) ; 5
; [else-branch: 5 | x@45@12 in setOfRef@10@12]
(assert (Set_in x@45@12 setOfRef@10@12))
; [eval] (i in edges_domain(x.edges))
; [eval] edges_domain(x.edges)
(push) ; 6
(assert (not (ite
  (and (img@41@12 x@45@12) (Set_in (inv@40@12 x@45@12) setOfRef@10@12))
  (< $Perm.No rd@12@12)
  false)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or (Set_in x@45@12 setOfRef@10@12) (not (Set_in x@45@12 setOfRef@10@12))))
(push) ; 4
; [then-branch: 6 | x@45@12 in setOfRef@10@12 && i@46@12 in edges_domain[Set[Int]](Lookup(edges, First:(Second:(Second:(Second:(Second:(Second:($t@32@12)))))), x@45@12)) | live]
; [else-branch: 6 | !(x@45@12 in setOfRef@10@12 && i@46@12 in edges_domain[Set[Int]](Lookup(edges, First:(Second:(Second:(Second:(Second:(Second:($t@32@12)))))), x@45@12))) | live]
(push) ; 5
; [then-branch: 6 | x@45@12 in setOfRef@10@12 && i@46@12 in edges_domain[Set[Int]](Lookup(edges, First:(Second:(Second:(Second:(Second:(Second:($t@32@12)))))), x@45@12))]
(assert (and
  (Set_in x@45@12 setOfRef@10@12)
  (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12)))))
; [eval] (edge_lookup(x.edges, i) in setOfRef)
; [eval] edge_lookup(x.edges, i)
(push) ; 6
(assert (not (ite
  (and (img@41@12 x@45@12) (Set_in (inv@40@12 x@45@12) setOfRef@10@12))
  (< $Perm.No rd@12@12)
  false)))
(check-sat)
; unsat
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(pop) ; 5
(push) ; 5
; [else-branch: 6 | !(x@45@12 in setOfRef@10@12 && i@46@12 in edges_domain[Set[Int]](Lookup(edges, First:(Second:(Second:(Second:(Second:(Second:($t@32@12)))))), x@45@12)))]
(assert (not
  (and
    (Set_in x@45@12 setOfRef@10@12)
    (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12))))))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in x@45@12 setOfRef@10@12)
      (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12)))))
  (and
    (Set_in x@45@12 setOfRef@10@12)
    (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12))))))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@45@12 $Ref) (i@46@12 Int)) (!
  (and
    (or (Set_in x@45@12 setOfRef@10@12) (not (Set_in x@45@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@45@12 setOfRef@10@12)
          (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12)))))
      (and
        (Set_in x@45@12 setOfRef@10@12)
        (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12))))))
  :pattern ((Set_in x@45@12 setOfRef@10@12) (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@45@12 $Ref) (i@46@12 Int)) (!
  (and
    (or (Set_in x@45@12 setOfRef@10@12) (not (Set_in x@45@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@45@12 setOfRef@10@12)
          (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12)))))
      (and
        (Set_in x@45@12 setOfRef@10@12)
        (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12))))))
  :pattern ((Set_in x@45@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12) i@46@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@45@12 $Ref) (i@46@12 Int)) (!
  (and
    (or (Set_in x@45@12 setOfRef@10@12) (not (Set_in x@45@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@45@12 setOfRef@10@12)
          (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12)))))
      (and
        (Set_in x@45@12 setOfRef@10@12)
        (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12))))))
  :pattern ((Set_in x@45@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12) i@46@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@45@12 $Ref) (i@46@12 Int)) (!
  (and
    (or (Set_in x@45@12 setOfRef@10@12) (not (Set_in x@45@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@45@12 setOfRef@10@12)
          (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12)))))
      (and
        (Set_in x@45@12 setOfRef@10@12)
        (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12)) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12) i@46@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@45@12 $Ref) (i@46@12 Int)) (!
  (and
    (or (Set_in x@45@12 setOfRef@10@12) (not (Set_in x@45@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@45@12 setOfRef@10@12)
          (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12)))))
      (and
        (Set_in x@45@12 setOfRef@10@12)
        (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12) i@46@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@45@12 $Ref) (i@46@12 Int)) (!
  (and
    (or (Set_in x@45@12 setOfRef@10@12) (not (Set_in x@45@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@45@12 setOfRef@10@12)
          (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12)))))
      (and
        (Set_in x@45@12 setOfRef@10@12)
        (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12))))))
  :pattern ((Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@45@12 $Ref) (i@46@12 Int)) (!
  (and
    (or (Set_in x@45@12 setOfRef@10@12) (not (Set_in x@45@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@45@12 setOfRef@10@12)
          (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12)))))
      (and
        (Set_in x@45@12 setOfRef@10@12)
        (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12))))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12) i@46@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@45@12 $Ref) (i@46@12 Int)) (!
  (=>
    (and
      (Set_in x@45@12 setOfRef@10@12)
      (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12))))
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12) i@46@12) setOfRef@10@12))
  :pattern ((Set_in x@45@12 setOfRef@10@12) (Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12))))
  :pattern ((Set_in x@45@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12) i@46@12))
  :pattern ((Set_in x@45@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12) i@46@12) setOfRef@10@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12)) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12) i@46@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12) i@46@12) setOfRef@10@12))
  :pattern ((Set_in i@46@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))) x@45@12) i@46@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12)))))))))
  $Snap.unit))
; [eval] res_copy_nodes == (res_copy_nodes union old(node_map_image))
; [eval] (res_copy_nodes union old(node_map_image))
; [eval] old(node_map_image)
(assert (Set_equal res_copy_nodes@15@12 (Set_union res_copy_nodes@15@12 node_map_image@11@12)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12)))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))))))
  $Snap.unit))
; [eval] (forall x: Ref :: { (x in map_domain(res_node_map)) } { (lookup(res_node_map, x) in res_copy_nodes) } (x in map_domain(res_node_map)) ==> (lookup(res_node_map, x) in res_copy_nodes))
(declare-const x@47@12 $Ref)
(push) ; 3
; [eval] (x in map_domain(res_node_map)) ==> (lookup(res_node_map, x) in res_copy_nodes)
; [eval] (x in map_domain(res_node_map))
; [eval] map_domain(res_node_map)
(push) ; 4
; [then-branch: 7 | x@47@12 in map_domain[Seq[Ref]](res_node_map@14@12) | live]
; [else-branch: 7 | !(x@47@12 in map_domain[Seq[Ref]](res_node_map@14@12)) | live]
(push) ; 5
; [then-branch: 7 | x@47@12 in map_domain[Seq[Ref]](res_node_map@14@12)]
(assert (Seq_contains (map_domain<Seq<Ref>> res_node_map@14@12) x@47@12))
; [eval] (lookup(res_node_map, x) in res_copy_nodes)
; [eval] lookup(res_node_map, x)
(pop) ; 5
(push) ; 5
; [else-branch: 7 | !(x@47@12 in map_domain[Seq[Ref]](res_node_map@14@12))]
(assert (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@14@12) x@47@12)))
(pop) ; 5
(pop) ; 4
; Joined path conditions
; Joined path conditions
(assert (or
  (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@14@12) x@47@12))
  (Seq_contains (map_domain<Seq<Ref>> res_node_map@14@12) x@47@12)))
(pop) ; 3
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@47@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@14@12) x@47@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@14@12) x@47@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@14@12) x@47@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@14@12)
    x@47@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102-aux|)))
(assert (forall ((x@47@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@14@12) x@47@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@14@12) x@47@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@14@12)
    x@47@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102-aux|)))
(assert (forall ((x@47@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@14@12) x@47@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@14@12) x@47@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@14@12 x@47@12) res_copy_nodes@15@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102-aux|)))
(assert (forall ((x@47@12 $Ref)) (!
  (=>
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@14@12) x@47@12)
    (Set_in (lookup<Ref> res_node_map@14@12 x@47@12) res_copy_nodes@15@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@14@12) x@47@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@14@12)
    x@47@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@14@12 x@47@12) res_copy_nodes@15@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12)))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@32@12))))))))))))))
(declare-const x@48@12 $Ref)
(push) ; 3
; [eval] (x in res_copy_nodes)
(assert (Set_in x@48@12 res_copy_nodes@15@12))
(pop) ; 3
(declare-fun inv@49@12 ($Ref) $Ref)
(declare-fun img@50@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((x1@48@12 $Ref) (x2@48@12 $Ref)) (!
  (=>
    (and
      (Set_in x1@48@12 res_copy_nodes@15@12)
      (Set_in x2@48@12 res_copy_nodes@15@12)
      (= x1@48@12 x2@48@12))
    (= x1@48@12 x2@48@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@48@12 $Ref)) (!
  (=>
    (Set_in x@48@12 res_copy_nodes@15@12)
    (and (= (inv@49@12 x@48@12) x@48@12) (img@50@12 x@48@12)))
  :pattern ((Set_in x@48@12 res_copy_nodes@15@12))
  :pattern ((inv@49@12 x@48@12))
  :pattern ((img@50@12 x@48@12))
  :qid |quant-u-15|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@50@12 r) (Set_in (inv@49@12 r) res_copy_nodes@15@12))
    (= (inv@49@12 r) r))
  :pattern ((inv@49@12 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((x@48@12 $Ref)) (!
  (=> (Set_in x@48@12 res_copy_nodes@15@12) (not (= x@48@12 $Ref.null)))
  :pattern ((Set_in x@48@12 res_copy_nodes@15@12))
  :pattern ((inv@49@12 x@48@12))
  :pattern ((img@50@12 x@48@12))
  :qid |val-permImpliesNonNull|)))
(push) ; 3
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= x@48@12 x@33@12)
    (=
      (and (img@50@12 r) (Set_in (inv@49@12 r) res_copy_nodes@15@12))
      (and (img@35@12 r) (Set_in (inv@34@12 r) setOfRef@10@12))))
  
  :qid |quant-u-16|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(declare-const x@51@12 $Ref)
(set-option :timeout 0)
(push) ; 3
; [eval] (x in res_copy_nodes)
(assert (Set_in x@51@12 res_copy_nodes@15@12))
(pop) ; 3
(declare-fun inv@52@12 ($Ref) $Ref)
(declare-fun img@53@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 3
(assert (not (forall ((x1@51@12 $Ref) (x2@51@12 $Ref)) (!
  (=>
    (and
      (Set_in x1@51@12 res_copy_nodes@15@12)
      (Set_in x2@51@12 res_copy_nodes@15@12)
      (= x1@51@12 x2@51@12))
    (= x1@51@12 x2@51@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@51@12 $Ref)) (!
  (=>
    (Set_in x@51@12 res_copy_nodes@15@12)
    (and (= (inv@52@12 x@51@12) x@51@12) (img@53@12 x@51@12)))
  :pattern ((Set_in x@51@12 res_copy_nodes@15@12))
  :pattern ((inv@52@12 x@51@12))
  :pattern ((img@53@12 x@51@12))
  :qid |quant-u-18|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@53@12 r) (Set_in (inv@52@12 r) res_copy_nodes@15@12))
    (= (inv@52@12 r) r))
  :pattern ((inv@52@12 r))
  :qid |edges-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((x@51@12 $Ref)) (!
  (=> (Set_in x@51@12 res_copy_nodes@15@12) (not (= x@51@12 $Ref.null)))
  :pattern ((Set_in x@51@12 res_copy_nodes@15@12))
  :pattern ((inv@52@12 x@51@12))
  :pattern ((img@53@12 x@51@12))
  :qid |edges-permImpliesNonNull|)))
(push) ; 3
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= x@51@12 x@39@12)
    (=
      (and (img@53@12 r) (Set_in (inv@52@12 r) res_copy_nodes@15@12))
      (and (img@41@12 r) (Set_in (inv@40@12 r) setOfRef@10@12))))
  
  :qid |quant-u-19|))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(pop) ; 2
(set-option :timeout 0)
(push) ; 2
; [exec]
; var i: Int
(declare-const i@54@12 Int)
; [exec]
; var S: Set[Int]
(declare-const S@55@12 Set<Int>)
; [eval] has_node(node_map, this)
(push) ; 3
(set-option :timeout 10)
(assert (not (not (has_node<Bool> node_map@9@12 this@8@12))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 10)
(assert (not (has_node<Bool> node_map@9@12 this@8@12)))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; [then-branch: 8 | has_node[Bool](node_map@9@12, this@8@12) | live]
; [else-branch: 8 | !(has_node[Bool](node_map@9@12, this@8@12)) | live]
(set-option :timeout 0)
(push) ; 3
; [then-branch: 8 | has_node[Bool](node_map@9@12, this@8@12)]
(assert (has_node<Bool> node_map@9@12 this@8@12))
; [exec]
; nodeCopy := lookup(node_map, this)
; [eval] lookup(node_map, this)
(declare-const nodeCopy@56@12 $Ref)
(assert (= nodeCopy@56@12 (lookup<Ref> node_map@9@12 this@8@12)))
; [exec]
; res_node_map := node_map
; [exec]
; res_copy_nodes := node_map_image
; [eval] nodeCopy != null
(push) ; 4
(assert (not (not (= nodeCopy@56@12 $Ref.null))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (not (= nodeCopy@56@12 $Ref.null)))
; [eval] (nodeCopy in res_copy_nodes)
(push) ; 4
(assert (not (Set_in nodeCopy@56@12 node_map_image@11@12)))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (Set_in nodeCopy@56@12 node_map_image@11@12))
; [eval] |(setOfRef intersection res_copy_nodes)| == 0
; [eval] |(setOfRef intersection res_copy_nodes)|
; [eval] (setOfRef intersection res_copy_nodes)
(declare-const x@57@12 $Ref)
(push) ; 4
; [eval] (x in setOfRef)
(assert (Set_in x@57@12 setOfRef@10@12))
(pop) ; 4
(declare-fun inv@58@12 ($Ref) $Ref)
(declare-fun img@59@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 4
(assert (not (forall ((x@57@12 $Ref)) (!
  (=>
    (Set_in x@57@12 setOfRef@10@12)
    (or (= rd@12@12 $Perm.No) (< $Perm.No rd@12@12)))
  
  :qid |quant-u-20|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 4
(assert (not (forall ((x1@57@12 $Ref) (x2@57@12 $Ref)) (!
  (=>
    (and
      (and (Set_in x1@57@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (and (Set_in x2@57@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (= x1@57@12 x2@57@12))
    (= x1@57@12 x2@57@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@57@12 $Ref)) (!
  (=>
    (and (Set_in x@57@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@58@12 x@57@12) x@57@12) (img@59@12 x@57@12)))
  :pattern ((Set_in x@57@12 setOfRef@10@12))
  :pattern ((inv@58@12 x@57@12))
  :pattern ((img@59@12 x@57@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@59@12 r)
      (and (Set_in (inv@58@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@58@12 r) r))
  :pattern ((inv@58@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@60@12 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@58@12 r) setOfRef@10@12) (img@59@12 r) (= r (inv@58@12 r)))
    ($Perm.min
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      rd@12@12)
    $Perm.No))
(define-fun pTaken@61@12 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@58@12 r) setOfRef@10@12) (img@59@12 r) (= r (inv@58@12 r)))
    ($Perm.min
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      (- rd@12@12 (pTaken@60@12 r)))
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
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (pTaken@60@12 r))
    $Perm.No)
  
  :qid |quant-u-22|))))
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
    (and (Set_in (inv@58@12 r) setOfRef@10@12) (img@59@12 r) (= r (inv@58@12 r)))
    (= (- rd@12@12 (pTaken@60@12 r)) $Perm.No))
  
  :qid |quant-u-23|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@62@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@62@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@62@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef6|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@62@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@62@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef7|)))
; [eval] (forall x: Ref :: { (x in setOfRef) } (x in setOfRef) ==> x.val == old(x.val))
(declare-const x@63@12 $Ref)
(set-option :timeout 0)
(push) ; 4
; [eval] (x in setOfRef) ==> x.val == old(x.val)
; [eval] (x in setOfRef)
(push) ; 5
; [then-branch: 9 | x@63@12 in setOfRef@10@12 | live]
; [else-branch: 9 | !(x@63@12 in setOfRef@10@12) | live]
(push) ; 6
; [then-branch: 9 | x@63@12 in setOfRef@10@12]
(assert (Set_in x@63@12 setOfRef@10@12))
; [eval] x.val == old(x.val)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_val (as sm@62@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
    :pattern (($FVF.lookup_val (as sm@62@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
    :qid |qp.fvfValDef6|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
      (=
        ($FVF.lookup_val (as sm@62@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
    :pattern (($FVF.lookup_val (as sm@62@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
    :qid |qp.fvfValDef7|))))
(push) ; 7
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@19@12 x@63@12) (Set_in (inv@18@12 x@63@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and (img@28@12 x@63@12) (Set_in (inv@27@12 x@63@12) node_map_image@11@12))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [eval] old(x.val)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_val (as sm@62@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
    :pattern (($FVF.lookup_val (as sm@62@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
    :qid |qp.fvfValDef6|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
      (=
        ($FVF.lookup_val (as sm@62@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
    :pattern (($FVF.lookup_val (as sm@62@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
    :qid |qp.fvfValDef7|))))
(push) ; 7
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@19@12 x@63@12) (Set_in (inv@18@12 x@63@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and (img@28@12 x@63@12) (Set_in (inv@27@12 x@63@12) node_map_image@11@12))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(pop) ; 6
(push) ; 6
; [else-branch: 9 | !(x@63@12 in setOfRef@10@12)]
(assert (not (Set_in x@63@12 setOfRef@10@12)))
(pop) ; 6
(pop) ; 5
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@62@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@62@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef6|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@62@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@62@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef7|)))
; Joined path conditions
(assert (or (not (Set_in x@63@12 setOfRef@10@12)) (Set_in x@63@12 setOfRef@10@12)))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@62@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@62@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef6|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@62@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@62@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef7|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@63@12 $Ref)) (!
  (or (not (Set_in x@63@12 setOfRef@10@12)) (Set_in x@63@12 setOfRef@10@12))
  :pattern ((Set_in x@63@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@107@11@107@65-aux|)))
(declare-const x@64@12 $Ref)
(push) ; 4
; [eval] (x in setOfRef)
(assert (Set_in x@64@12 setOfRef@10@12))
(pop) ; 4
(declare-fun inv@65@12 ($Ref) $Ref)
(declare-fun img@66@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 4
(assert (not (forall ((x@64@12 $Ref)) (!
  (=>
    (Set_in x@64@12 setOfRef@10@12)
    (or (= rd@12@12 $Perm.No) (< $Perm.No rd@12@12)))
  
  :qid |quant-u-24|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 4
(assert (not (forall ((x1@64@12 $Ref) (x2@64@12 $Ref)) (!
  (=>
    (and
      (and (Set_in x1@64@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (and (Set_in x2@64@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (= x1@64@12 x2@64@12))
    (= x1@64@12 x2@64@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@64@12 $Ref)) (!
  (=>
    (and (Set_in x@64@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@65@12 x@64@12) x@64@12) (img@66@12 x@64@12)))
  :pattern ((Set_in x@64@12 setOfRef@10@12))
  :pattern ((inv@65@12 x@64@12))
  :pattern ((img@66@12 x@64@12))
  :qid |edges-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@66@12 r)
      (and (Set_in (inv@65@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@65@12 r) r))
  :pattern ((inv@65@12 r))
  :qid |edges-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@67@12 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@65@12 r) setOfRef@10@12) (img@66@12 r) (= r (inv@65@12 r)))
    ($Perm.min
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      rd@12@12)
    $Perm.No))
(define-fun pTaken@68@12 ((r $Ref)) $Perm
  (ite
    (and (Set_in (inv@65@12 r) setOfRef@10@12) (img@66@12 r) (= r (inv@65@12 r)))
    ($Perm.min
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (- rd@12@12 (pTaken@67@12 r)))
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
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      (pTaken@67@12 r))
    $Perm.No)
  
  :qid |quant-u-26|))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@67@12 r) $Perm.No)
  
  :qid |quant-u-27|))))
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
    (and (Set_in (inv@65@12 r) setOfRef@10@12) (img@66@12 r) (= r (inv@65@12 r)))
    (= (- rd@12@12 (pTaken@67@12 r)) $Perm.No))
  
  :qid |quant-u-28|))))
(check-sat)
; unknown
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 4
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (pTaken@68@12 r))
    $Perm.No)
  
  :qid |quant-u-29|))))
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
    (and (Set_in (inv@65@12 r) setOfRef@10@12) (img@66@12 r) (= r (inv@65@12 r)))
    (= (- (- rd@12@12 (pTaken@67@12 r)) (pTaken@68@12 r)) $Perm.No))
  
  :qid |quant-u-30|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@69@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@69@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@69@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef8|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@69@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@69@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef9|)))
; [eval] (forall x: Ref :: { (x in setOfRef) } (x in setOfRef) ==> x.edges == old(x.edges))
(declare-const x@70@12 $Ref)
(set-option :timeout 0)
(push) ; 4
; [eval] (x in setOfRef) ==> x.edges == old(x.edges)
; [eval] (x in setOfRef)
(push) ; 5
; [then-branch: 10 | x@70@12 in setOfRef@10@12 | live]
; [else-branch: 10 | !(x@70@12 in setOfRef@10@12) | live]
(push) ; 6
; [then-branch: 10 | x@70@12 in setOfRef@10@12]
(assert (Set_in x@70@12 setOfRef@10@12))
; [eval] x.edges == old(x.edges)
(declare-const sm@71@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef10|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef11|)))
(declare-const pm@72@12 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@72@12  $FPM) r)
    (+
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@72@12  $FPM) r))
  :qid |qp.resPrmSumDef12|)))
(push) ; 7
(assert (not (< $Perm.No ($FVF.perm_edges (as pm@72@12  $FPM) x@70@12))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; [eval] old(x.edges)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
    :qid |qp.fvfValDef10|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
      (=
        ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
    :qid |qp.fvfValDef11|))))
(push) ; 7
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@22@12 x@70@12) (Set_in (inv@21@12 x@70@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and (img@31@12 x@70@12) (Set_in (inv@30@12 x@70@12) node_map_image@11@12))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(pop) ; 6
(push) ; 6
; [else-branch: 10 | !(x@70@12 in setOfRef@10@12)]
(assert (not (Set_in x@70@12 setOfRef@10@12)))
(pop) ; 6
(pop) ; 5
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef10|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef11|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@72@12  $FPM) r)
    (+
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@72@12  $FPM) r))
  :qid |qp.resPrmSumDef12|)))
; Joined path conditions
(assert (or (not (Set_in x@70@12 setOfRef@10@12)) (Set_in x@70@12 setOfRef@10@12)))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef10|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef11|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@72@12  $FPM) r)
    (+
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@72@12  $FPM) r))
  :qid |qp.resPrmSumDef12|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@70@12 $Ref)) (!
  (or (not (Set_in x@70@12 setOfRef@10@12)) (Set_in x@70@12 setOfRef@10@12))
  :pattern ((Set_in x@70@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@109@11@109@69-aux|)))
; [eval] (forall x: Ref, i: Int :: { (x in setOfRef), (i in edges_domain(x.edges)) } { (x in setOfRef), edge_lookup(x.edges, i) } { (x in setOfRef), (edge_lookup(x.edges, i) in setOfRef) } { edges_domain(x.edges), edge_lookup(x.edges, i) } { edges_domain(x.edges), (edge_lookup(x.edges, i) in setOfRef) } { (i in edges_domain(x.edges)) } { (edge_lookup(x.edges, i) in setOfRef) } (x in setOfRef) && (i in edges_domain(x.edges)) ==> (edge_lookup(x.edges, i) in setOfRef))
(declare-const x@73@12 $Ref)
(declare-const i@74@12 Int)
(push) ; 4
; [eval] (x in setOfRef) && (i in edges_domain(x.edges)) ==> (edge_lookup(x.edges, i) in setOfRef)
; [eval] (x in setOfRef) && (i in edges_domain(x.edges))
; [eval] (x in setOfRef)
(push) ; 5
; [then-branch: 11 | !(x@73@12 in setOfRef@10@12) | live]
; [else-branch: 11 | x@73@12 in setOfRef@10@12 | live]
(push) ; 6
; [then-branch: 11 | !(x@73@12 in setOfRef@10@12)]
(assert (not (Set_in x@73@12 setOfRef@10@12)))
(pop) ; 6
(push) ; 6
; [else-branch: 11 | x@73@12 in setOfRef@10@12]
(assert (Set_in x@73@12 setOfRef@10@12))
; [eval] (i in edges_domain(x.edges))
; [eval] edges_domain(x.edges)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
    :qid |qp.fvfValDef10|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
      (=
        ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
    :qid |qp.fvfValDef11|))))
(push) ; 7
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@22@12 x@73@12) (Set_in (inv@21@12 x@73@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and (img@31@12 x@73@12) (Set_in (inv@30@12 x@73@12) node_map_image@11@12))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef10|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef11|)))
(assert (or (Set_in x@73@12 setOfRef@10@12) (not (Set_in x@73@12 setOfRef@10@12))))
(push) ; 5
; [then-branch: 12 | x@73@12 in setOfRef@10@12 && i@74@12 in edges_domain[Set[Int]](Lookup(edges, sm@71@12, x@73@12)) | live]
; [else-branch: 12 | !(x@73@12 in setOfRef@10@12 && i@74@12 in edges_domain[Set[Int]](Lookup(edges, sm@71@12, x@73@12))) | live]
(push) ; 6
; [then-branch: 12 | x@73@12 in setOfRef@10@12 && i@74@12 in edges_domain[Set[Int]](Lookup(edges, sm@71@12, x@73@12))]
(assert (and
  (Set_in x@73@12 setOfRef@10@12)
  (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12)))))
; [eval] (edge_lookup(x.edges, i) in setOfRef)
; [eval] edge_lookup(x.edges, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
    :qid |qp.fvfValDef10|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
      (=
        ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
    :qid |qp.fvfValDef11|))))
(push) ; 7
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@22@12 x@73@12) (Set_in (inv@21@12 x@73@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and (img@31@12 x@73@12) (Set_in (inv@30@12 x@73@12) node_map_image@11@12))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(pop) ; 6
(push) ; 6
; [else-branch: 12 | !(x@73@12 in setOfRef@10@12 && i@74@12 in edges_domain[Set[Int]](Lookup(edges, sm@71@12, x@73@12)))]
(assert (not
  (and
    (Set_in x@73@12 setOfRef@10@12)
    (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))))
(pop) ; 6
(pop) ; 5
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef10|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef11|)))
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in x@73@12 setOfRef@10@12)
      (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12)))))
  (and
    (Set_in x@73@12 setOfRef@10@12)
    (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef10|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@71@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef11|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@73@12 $Ref) (i@74@12 Int)) (!
  (and
    (or (Set_in x@73@12 setOfRef@10@12) (not (Set_in x@73@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@73@12 setOfRef@10@12)
          (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12)))))
      (and
        (Set_in x@73@12 setOfRef@10@12)
        (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))))
  :pattern ((Set_in x@73@12 setOfRef@10@12) (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@73@12 $Ref) (i@74@12 Int)) (!
  (and
    (or (Set_in x@73@12 setOfRef@10@12) (not (Set_in x@73@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@73@12 setOfRef@10@12)
          (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12)))))
      (and
        (Set_in x@73@12 setOfRef@10@12)
        (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))))
  :pattern ((Set_in x@73@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@73@12 $Ref) (i@74@12 Int)) (!
  (and
    (or (Set_in x@73@12 setOfRef@10@12) (not (Set_in x@73@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@73@12 setOfRef@10@12)
          (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12)))))
      (and
        (Set_in x@73@12 setOfRef@10@12)
        (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))))
  :pattern ((Set_in x@73@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@73@12 $Ref) (i@74@12 Int)) (!
  (and
    (or (Set_in x@73@12 setOfRef@10@12) (not (Set_in x@73@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@73@12 setOfRef@10@12)
          (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12)))))
      (and
        (Set_in x@73@12 setOfRef@10@12)
        (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@73@12 $Ref) (i@74@12 Int)) (!
  (and
    (or (Set_in x@73@12 setOfRef@10@12) (not (Set_in x@73@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@73@12 setOfRef@10@12)
          (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12)))))
      (and
        (Set_in x@73@12 setOfRef@10@12)
        (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@73@12 $Ref) (i@74@12 Int)) (!
  (and
    (or (Set_in x@73@12 setOfRef@10@12) (not (Set_in x@73@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@73@12 setOfRef@10@12)
          (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12)))))
      (and
        (Set_in x@73@12 setOfRef@10@12)
        (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))))
  :pattern ((Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@73@12 $Ref) (i@74@12 Int)) (!
  (and
    (or (Set_in x@73@12 setOfRef@10@12) (not (Set_in x@73@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@73@12 setOfRef@10@12)
          (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12)))))
      (and
        (Set_in x@73@12 setOfRef@10@12)
        (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(push) ; 4
(assert (not (forall ((x@73@12 $Ref) (i@74@12 Int)) (!
  (=>
    (and
      (Set_in x@73@12 setOfRef@10@12)
      (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12) setOfRef@10@12))
  :pattern ((Set_in x@73@12 setOfRef@10@12) (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))
  :pattern ((Set_in x@73@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12))
  :pattern ((Set_in x@73@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12) setOfRef@10@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12) setOfRef@10@12))
  :pattern ((Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (forall ((x@73@12 $Ref) (i@74@12 Int)) (!
  (=>
    (and
      (Set_in x@73@12 setOfRef@10@12)
      (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12) setOfRef@10@12))
  :pattern ((Set_in x@73@12 setOfRef@10@12) (Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))
  :pattern ((Set_in x@73@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12))
  :pattern ((Set_in x@73@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12) setOfRef@10@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12) setOfRef@10@12))
  :pattern ((Set_in i@74@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@71@12  $FVF<edges>) x@73@12) i@74@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119|)))
; [eval] res_copy_nodes == (res_copy_nodes union old(node_map_image))
; [eval] (res_copy_nodes union old(node_map_image))
; [eval] old(node_map_image)
(push) ; 4
(assert (not (Set_equal node_map_image@11@12 (Set_union node_map_image@11@12 node_map_image@11@12))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (Set_equal node_map_image@11@12 (Set_union node_map_image@11@12 node_map_image@11@12)))
; [eval] (forall x: Ref :: { (x in map_domain(res_node_map)) } { (lookup(res_node_map, x) in res_copy_nodes) } (x in map_domain(res_node_map)) ==> (lookup(res_node_map, x) in res_copy_nodes))
(declare-const x@75@12 $Ref)
(push) ; 4
; [eval] (x in map_domain(res_node_map)) ==> (lookup(res_node_map, x) in res_copy_nodes)
; [eval] (x in map_domain(res_node_map))
; [eval] map_domain(res_node_map)
(push) ; 5
; [then-branch: 13 | x@75@12 in map_domain[Seq[Ref]](node_map@9@12) | live]
; [else-branch: 13 | !(x@75@12 in map_domain[Seq[Ref]](node_map@9@12)) | live]
(push) ; 6
; [then-branch: 13 | x@75@12 in map_domain[Seq[Ref]](node_map@9@12)]
(assert (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
; [eval] (lookup(res_node_map, x) in res_copy_nodes)
; [eval] lookup(res_node_map, x)
(pop) ; 6
(push) ; 6
; [else-branch: 13 | !(x@75@12 in map_domain[Seq[Ref]](node_map@9@12))]
(assert (not (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@75@12)))
(pop) ; 6
(pop) ; 5
; Joined path conditions
; Joined path conditions
(assert (or
  (not (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
  (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@75@12)))
(pop) ; 4
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@75@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
    (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
  :pattern ((Seq_contains_trigger (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102-aux|)))
(assert (forall ((x@75@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
    (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
  :pattern ((Seq_contains_trigger (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102-aux|)))
(assert (forall ((x@75@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
    (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
  :pattern ((Set_in (lookup<Ref> node_map@9@12 x@75@12) node_map_image@11@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102-aux|)))
(push) ; 4
(assert (not (forall ((x@75@12 $Ref)) (!
  (=>
    (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@75@12)
    (Set_in (lookup<Ref> node_map@9@12 x@75@12) node_map_image@11@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
  :pattern ((Seq_contains_trigger (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
  :pattern ((Seq_contains_trigger (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
  :pattern ((Set_in (lookup<Ref> node_map@9@12 x@75@12) node_map_image@11@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (forall ((x@75@12 $Ref)) (!
  (=>
    (Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@75@12)
    (Set_in (lookup<Ref> node_map@9@12 x@75@12) node_map_image@11@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
  :pattern ((Seq_contains_trigger (map_domain<Seq<Ref>> node_map@9@12) x@75@12))
  :pattern ((Set_in (lookup<Ref> node_map@9@12 x@75@12) node_map_image@11@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102|)))
(declare-const x@76@12 $Ref)
(push) ; 4
; [eval] (x in res_copy_nodes)
(assert (Set_in x@76@12 node_map_image@11@12))
(pop) ; 4
(declare-fun inv@77@12 ($Ref) $Ref)
(declare-fun img@78@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 4
(assert (not (forall ((x1@76@12 $Ref) (x2@76@12 $Ref)) (!
  (=>
    (and
      (Set_in x1@76@12 node_map_image@11@12)
      (Set_in x2@76@12 node_map_image@11@12)
      (= x1@76@12 x2@76@12))
    (= x1@76@12 x2@76@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@76@12 $Ref)) (!
  (=>
    (Set_in x@76@12 node_map_image@11@12)
    (and (= (inv@77@12 x@76@12) x@76@12) (img@78@12 x@76@12)))
  :pattern ((Set_in x@76@12 node_map_image@11@12))
  :pattern ((inv@77@12 x@76@12))
  :pattern ((img@78@12 x@76@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@78@12 r) (Set_in (inv@77@12 r) node_map_image@11@12))
    (= (inv@77@12 r) r))
  :pattern ((inv@77@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@79@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@77@12 r) node_map_image@11@12)
      (img@78@12 r)
      (= r (inv@77@12 r)))
    ($Perm.min
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
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
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      (pTaken@79@12 r))
    $Perm.No)
  
  :qid |quant-u-33|))))
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
      (Set_in (inv@77@12 r) node_map_image@11@12)
      (img@78@12 r)
      (= r (inv@77@12 r)))
    (= (- $Perm.Write (pTaken@79@12 r)) $Perm.No))
  
  :qid |quant-u-34|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@80@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@80@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@80@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef13|)))
(declare-const x@81@12 $Ref)
(set-option :timeout 0)
(push) ; 4
; [eval] (x in res_copy_nodes)
(assert (Set_in x@81@12 node_map_image@11@12))
(pop) ; 4
(declare-fun inv@82@12 ($Ref) $Ref)
(declare-fun img@83@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 4
(assert (not (forall ((x1@81@12 $Ref) (x2@81@12 $Ref)) (!
  (=>
    (and
      (Set_in x1@81@12 node_map_image@11@12)
      (Set_in x2@81@12 node_map_image@11@12)
      (= x1@81@12 x2@81@12))
    (= x1@81@12 x2@81@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@81@12 $Ref)) (!
  (=>
    (Set_in x@81@12 node_map_image@11@12)
    (and (= (inv@82@12 x@81@12) x@81@12) (img@83@12 x@81@12)))
  :pattern ((Set_in x@81@12 node_map_image@11@12))
  :pattern ((inv@82@12 x@81@12))
  :pattern ((img@83@12 x@81@12))
  :qid |edges-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@83@12 r) (Set_in (inv@82@12 r) node_map_image@11@12))
    (= (inv@82@12 r) r))
  :pattern ((inv@82@12 r))
  :qid |edges-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@84@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@82@12 r) node_map_image@11@12)
      (img@83@12 r)
      (= r (inv@82@12 r)))
    ($Perm.min
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
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
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      (pTaken@84@12 r))
    $Perm.No)
  
  :qid |quant-u-37|))))
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
      (Set_in (inv@82@12 r) node_map_image@11@12)
      (img@83@12 r)
      (= r (inv@82@12 r)))
    (= (- $Perm.Write (pTaken@84@12 r)) $Perm.No))
  
  :qid |quant-u-38|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@85@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@85@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@85@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef14|)))
(pop) ; 3
(set-option :timeout 0)
(push) ; 3
; [else-branch: 8 | !(has_node[Bool](node_map@9@12, this@8@12))]
(assert (not (has_node<Bool> node_map@9@12 this@8@12)))
(pop) ; 3
; [eval] !has_node(node_map, this)
; [eval] has_node(node_map, this)
(push) ; 3
(set-option :timeout 10)
(assert (not (has_node<Bool> node_map@9@12 this@8@12)))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 3
(set-option :timeout 10)
(assert (not (not (has_node<Bool> node_map@9@12 this@8@12))))
(check-sat)
; unknown
(pop) ; 3
; 0.00s
; (get-info :all-statistics)
; [then-branch: 14 | !(has_node[Bool](node_map@9@12, this@8@12)) | live]
; [else-branch: 14 | has_node[Bool](node_map@9@12, this@8@12) | live]
(set-option :timeout 0)
(push) ; 3
; [then-branch: 14 | !(has_node[Bool](node_map@9@12, this@8@12))]
(assert (not (has_node<Bool> node_map@9@12 this@8@12)))
; [exec]
; nodeCopy := new(val, edges)
(declare-const nodeCopy@86@12 $Ref)
(assert (not (= nodeCopy@86@12 $Ref.null)))
(declare-const val@87@12 Int)
(declare-const sm@88@12 $FVF<val>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_val (as sm@88@12  $FVF<val>) nodeCopy@86@12) val@87@12))
(declare-const edges@89@12 IEdges)
(declare-const sm@90@12 $FVF<edges>)
; Definitional axioms for singleton-FVF's value
(assert (= ($FVF.lookup_edges (as sm@90@12  $FVF<edges>) nodeCopy@86@12) edges@89@12))
(assert (not (= nodeCopy@86@12 this@8@12)))
(assert (not (= nodeCopy@86@12 nodeCopy@13@12)))
(assert (not (Set_in nodeCopy@86@12 setOfRef@10@12)))
(assert (not (Set_in nodeCopy@86@12 res_copy_nodes@15@12)))
(assert (not (Set_in nodeCopy@86@12 node_map_image@11@12)))
; [exec]
; nodeCopy.val := this.val
(declare-const sm@91@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_val (as sm@91@12  $FVF<val>) r)
      ($FVF.lookup_val (as sm@88@12  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@91@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@88@12  $FVF<val>) r))
  :qid |qp.fvfValDef15|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@91@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@91@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef16|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@91@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@91@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef17|)))
(declare-const pm@92@12 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@92@12  $FPM) r)
    (+
      (+
        (ite (= r nodeCopy@86@12) $Perm.Write $Perm.No)
        (ite
          (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
          rd@12@12
          $Perm.No))
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@92@12  $FPM) r))
  :qid |qp.resPrmSumDef18|)))
(push) ; 4
(assert (not (< $Perm.No ($FVF.perm_val (as pm@92@12  $FPM) this@8@12))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Precomputing data for removing quantified permissions
(define-fun pTaken@93@12 ((r $Ref)) $Perm
  (ite
    (= r nodeCopy@86@12)
    ($Perm.min (ite (= r nodeCopy@86@12) $Perm.Write $Perm.No) $Perm.Write)
    $Perm.No))
(define-fun pTaken@94@12 ((r $Ref)) $Perm
  (ite
    (= r nodeCopy@86@12)
    ($Perm.min
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (- $Perm.Write (pTaken@93@12 r)))
    $Perm.No))
(define-fun pTaken@95@12 ((r $Ref)) $Perm
  (ite
    (= r nodeCopy@86@12)
    ($Perm.min
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      (- (- $Perm.Write (pTaken@93@12 r)) (pTaken@94@12 r)))
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
(assert (not (= (- $Perm.Write (pTaken@93@12 nodeCopy@86@12)) $Perm.No)))
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
  (=> (= r nodeCopy@86@12) (= (- $Perm.Write (pTaken@93@12 r)) $Perm.No))
  
  :qid |quant-u-41|))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@96@12 $FVF<val>)
; Definitional axioms for singleton-FVF's value
(assert (=
  ($FVF.lookup_val (as sm@96@12  $FVF<val>) nodeCopy@86@12)
  ($FVF.lookup_val (as sm@91@12  $FVF<val>) this@8@12)))
; [exec]
; res_node_map := insert(node_map, this, nodeCopy)
; [eval] insert(node_map, this, nodeCopy)
(declare-const res_node_map@97@12 INodeMap)
(assert (= res_node_map@97@12 (insert<INodeMap> node_map@9@12 this@8@12 nodeCopy@86@12)))
; [exec]
; res_copy_nodes := (node_map_image union Set(nodeCopy))
; [eval] (node_map_image union Set(nodeCopy))
; [eval] Set(nodeCopy)
(declare-const res_copy_nodes@98@12 Set<$Ref>)
(assert (=
  res_copy_nodes@98@12
  (Set_union node_map_image@11@12 (Set_singleton nodeCopy@86@12))))
; [exec]
; assert ((setOfRef intersection node_map_image) union
;   (setOfRef intersection Set(nodeCopy))) ==
;   (setOfRef intersection res_copy_nodes)
; [eval] ((setOfRef intersection node_map_image) union (setOfRef intersection Set(nodeCopy))) == (setOfRef intersection res_copy_nodes)
; [eval] ((setOfRef intersection node_map_image) union (setOfRef intersection Set(nodeCopy)))
; [eval] (setOfRef intersection node_map_image)
; [eval] (setOfRef intersection Set(nodeCopy))
; [eval] Set(nodeCopy)
; [eval] (setOfRef intersection res_copy_nodes)
(set-option :timeout 0)
(push) ; 4
(assert (not (Set_equal (Set_union (Set_intersection setOfRef@10@12 node_map_image@11@12) (Set_intersection setOfRef@10@12 (Set_singleton nodeCopy@86@12))) (Set_intersection setOfRef@10@12 res_copy_nodes@98@12))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(assert (Set_equal (Set_union (Set_intersection setOfRef@10@12 node_map_image@11@12) (Set_intersection setOfRef@10@12 (Set_singleton nodeCopy@86@12))) (Set_intersection setOfRef@10@12 res_copy_nodes@98@12)))
; [exec]
; S := edges_domain(this.edges)
; [eval] edges_domain(this.edges)
(declare-const sm@99@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef20|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r))
  :qid |qp.fvfValDef21|)))
(declare-const pm@100@12 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@100@12  $FPM) r)
    (+
      (+
        (ite
          (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
          $Perm.Write
          $Perm.No)
        (ite
          (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
          rd@12@12
          $Perm.No))
      (ite (= r nodeCopy@86@12) $Perm.Write $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@100@12  $FPM) r))
  :qid |qp.resPrmSumDef22|)))
(push) ; 4
(assert (not (< $Perm.No ($FVF.perm_edges (as pm@100@12  $FPM) this@8@12))))
(check-sat)
; unsat
(pop) ; 4
; 0.00s
; (get-info :all-statistics)
(declare-const S@101@12 Set<Int>)
(assert (=
  S@101@12
  (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) this@8@12))))
(declare-const S@102@12 Set<Int>)
(declare-const i@103@12 Int)
(declare-const nodeForId@104@12 $Ref)
(declare-const newNode@105@12 $Ref)
(declare-const res_node_map@106@12 INodeMap)
(declare-const res_copy_nodes@107@12 Set<$Ref>)
(push) ; 4
; Loop head block: Check well-definedness of invariant
(declare-const $t@108@12 $Snap)
(assert (= $t@108@12 ($Snap.combine ($Snap.first $t@108@12) ($Snap.second $t@108@12))))
(assert (= ($Snap.first $t@108@12) $Snap.unit))
; [eval] (nodeCopy in res_copy_nodes)
(assert (Set_in nodeCopy@86@12 res_copy_nodes@107@12))
(assert (=
  ($Snap.second $t@108@12)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@108@12))
    ($Snap.second ($Snap.second $t@108@12)))))
(assert (= ($Snap.first ($Snap.second $t@108@12)) $Snap.unit))
; [eval] (this in setOfRef)
(assert (=
  ($Snap.second ($Snap.second $t@108@12))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@108@12)))
    ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))
(declare-const x@109@12 $Ref)
(push) ; 5
; [eval] (x in setOfRef)
(assert (Set_in x@109@12 setOfRef@10@12))
(pop) ; 5
(declare-fun inv@110@12 ($Ref) $Ref)
(declare-fun img@111@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 5
(assert (not (forall ((x@109@12 $Ref)) (!
  (=>
    (Set_in x@109@12 setOfRef@10@12)
    (or (= rd@12@12 $Perm.No) (< $Perm.No rd@12@12)))
  
  :qid |quant-u-42|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 5
(assert (not (forall ((x1@109@12 $Ref) (x2@109@12 $Ref)) (!
  (=>
    (and
      (and (Set_in x1@109@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (and (Set_in x2@109@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (= x1@109@12 x2@109@12))
    (= x1@109@12 x2@109@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@109@12 $Ref)) (!
  (=>
    (and (Set_in x@109@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@110@12 x@109@12) x@109@12) (img@111@12 x@109@12)))
  :pattern ((Set_in x@109@12 setOfRef@10@12))
  :pattern ((inv@110@12 x@109@12))
  :pattern ((img@111@12 x@109@12))
  :qid |quant-u-43|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@111@12 r)
      (and (Set_in (inv@110@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@110@12 r) r))
  :pattern ((inv@110@12 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
(assert (forall ((x@109@12 $Ref)) (!
  (<= $Perm.No rd@12@12)
  :pattern ((Set_in x@109@12 setOfRef@10@12))
  :pattern ((inv@110@12 x@109@12))
  :pattern ((img@111@12 x@109@12))
  :qid |val-permAtLeastZero|)))
; Field permissions are at most one
(assert (forall ((x@109@12 $Ref)) (!
  (<= rd@12@12 $Perm.Write)
  :pattern ((Set_in x@109@12 setOfRef@10@12))
  :pattern ((inv@110@12 x@109@12))
  :pattern ((img@111@12 x@109@12))
  :qid |val-permAtMostOne|)))
; Permission implies non-null receiver
(assert (forall ((x@109@12 $Ref)) (!
  (=>
    (and (Set_in x@109@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (not (= x@109@12 $Ref.null)))
  :pattern ((Set_in x@109@12 setOfRef@10@12))
  :pattern ((inv@110@12 x@109@12))
  :pattern ((img@111@12 x@109@12))
  :qid |val-permImpliesNonNull|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@108@12)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@108@12))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@108@12))))
  $Snap.unit))
; [eval] (forall x: Ref :: { (x in setOfRef) } (x in setOfRef) ==> x.val == old(x.val))
(declare-const x@112@12 $Ref)
(push) ; 5
; [eval] (x in setOfRef) ==> x.val == old(x.val)
; [eval] (x in setOfRef)
(push) ; 6
; [then-branch: 15 | x@112@12 in setOfRef@10@12 | live]
; [else-branch: 15 | !(x@112@12 in setOfRef@10@12) | live]
(push) ; 7
; [then-branch: 15 | x@112@12 in setOfRef@10@12]
(assert (Set_in x@112@12 setOfRef@10@12))
; [eval] x.val == old(x.val)
(push) ; 8
(assert (not (ite
  (and (img@111@12 x@112@12) (Set_in (inv@110@12 x@112@12) setOfRef@10@12))
  (< $Perm.No rd@12@12)
  false)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [eval] old(x.val)
(declare-const sm@113@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef24|)))
(declare-const pm@114@12 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@114@12  $FPM) r)
    (+
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@114@12  $FPM) r))
  :qid |qp.resPrmSumDef25|)))
(push) ; 8
(assert (not (< $Perm.No ($FVF.perm_val (as pm@114@12  $FPM) x@112@12))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 15 | !(x@112@12 in setOfRef@10@12)]
(assert (not (Set_in x@112@12 setOfRef@10@12)))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef24|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@114@12  $FPM) r)
    (+
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@114@12  $FPM) r))
  :qid |qp.resPrmSumDef25|)))
; Joined path conditions
(assert (or (not (Set_in x@112@12 setOfRef@10@12)) (Set_in x@112@12 setOfRef@10@12)))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef24|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@114@12  $FPM) r)
    (+
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@114@12  $FPM) r))
  :qid |qp.resPrmSumDef25|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@112@12 $Ref)) (!
  (or (not (Set_in x@112@12 setOfRef@10@12)) (Set_in x@112@12 setOfRef@10@12))
  :pattern ((Set_in x@112@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@146@17@146@71-aux|)))
(assert (forall ((x@112@12 $Ref)) (!
  (=>
    (Set_in x@112@12 setOfRef@10@12)
    (=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) x@112@12)
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) x@112@12)))
  :pattern ((Set_in x@112@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@146@17@146@71|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))
(declare-const x@115@12 $Ref)
(push) ; 5
; [eval] (x in setOfRef)
(assert (Set_in x@115@12 setOfRef@10@12))
(pop) ; 5
(declare-fun inv@116@12 ($Ref) $Ref)
(declare-fun img@117@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 5
(assert (not (forall ((x@115@12 $Ref)) (!
  (=>
    (Set_in x@115@12 setOfRef@10@12)
    (or (= rd@12@12 $Perm.No) (< $Perm.No rd@12@12)))
  
  :qid |quant-u-44|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 5
(assert (not (forall ((x1@115@12 $Ref) (x2@115@12 $Ref)) (!
  (=>
    (and
      (and (Set_in x1@115@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (and (Set_in x2@115@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (= x1@115@12 x2@115@12))
    (= x1@115@12 x2@115@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@115@12 $Ref)) (!
  (=>
    (and (Set_in x@115@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@116@12 x@115@12) x@115@12) (img@117@12 x@115@12)))
  :pattern ((Set_in x@115@12 setOfRef@10@12))
  :pattern ((inv@116@12 x@115@12))
  :pattern ((img@117@12 x@115@12))
  :qid |quant-u-45|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@117@12 r)
      (and (Set_in (inv@116@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@116@12 r) r))
  :pattern ((inv@116@12 r))
  :qid |edges-fctOfInv|)))
; Permissions are non-negative
(assert (forall ((x@115@12 $Ref)) (!
  (<= $Perm.No rd@12@12)
  :pattern ((Set_in x@115@12 setOfRef@10@12))
  :pattern ((inv@116@12 x@115@12))
  :pattern ((img@117@12 x@115@12))
  :qid |edges-permAtLeastZero|)))
; Field permissions are at most one
(assert (forall ((x@115@12 $Ref)) (!
  (<= rd@12@12 $Perm.Write)
  :pattern ((Set_in x@115@12 setOfRef@10@12))
  :pattern ((inv@116@12 x@115@12))
  :pattern ((img@117@12 x@115@12))
  :qid |edges-permAtMostOne|)))
; Permission implies non-null receiver
(assert (forall ((x@115@12 $Ref)) (!
  (=>
    (and (Set_in x@115@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (not (= x@115@12 $Ref.null)))
  :pattern ((Set_in x@115@12 setOfRef@10@12))
  :pattern ((inv@116@12 x@115@12))
  :pattern ((img@117@12 x@115@12))
  :qid |edges-permImpliesNonNull|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))
  $Snap.unit))
; [eval] (forall x: Ref :: { (x in setOfRef) } (x in setOfRef) ==> x.edges == old(x.edges))
(declare-const x@118@12 $Ref)
(push) ; 5
; [eval] (x in setOfRef) ==> x.edges == old(x.edges)
; [eval] (x in setOfRef)
(push) ; 6
; [then-branch: 16 | x@118@12 in setOfRef@10@12 | live]
; [else-branch: 16 | !(x@118@12 in setOfRef@10@12) | live]
(push) ; 7
; [then-branch: 16 | x@118@12 in setOfRef@10@12]
(assert (Set_in x@118@12 setOfRef@10@12))
; [eval] x.edges == old(x.edges)
(push) ; 8
(assert (not (ite
  (and (img@117@12 x@118@12) (Set_in (inv@116@12 x@118@12) setOfRef@10@12))
  (< $Perm.No rd@12@12)
  false)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [eval] old(x.edges)
(declare-const sm@119@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef26|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef27|)))
(declare-const pm@120@12 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@120@12  $FPM) r)
    (+
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@120@12  $FPM) r))
  :qid |qp.resPrmSumDef28|)))
(push) ; 8
(assert (not (< $Perm.No ($FVF.perm_edges (as pm@120@12  $FPM) x@118@12))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 16 | !(x@118@12 in setOfRef@10@12)]
(assert (not (Set_in x@118@12 setOfRef@10@12)))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef26|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef27|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@120@12  $FPM) r)
    (+
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@120@12  $FPM) r))
  :qid |qp.resPrmSumDef28|)))
; Joined path conditions
(assert (or (not (Set_in x@118@12 setOfRef@10@12)) (Set_in x@118@12 setOfRef@10@12)))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef26|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef27|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@120@12  $FPM) r)
    (+
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@120@12  $FPM) r))
  :qid |qp.resPrmSumDef28|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@118@12 $Ref)) (!
  (or (not (Set_in x@118@12 setOfRef@10@12)) (Set_in x@118@12 setOfRef@10@12))
  :pattern ((Set_in x@118@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@148@17@148@75-aux|)))
(assert (forall ((x@118@12 $Ref)) (!
  (=>
    (Set_in x@118@12 setOfRef@10@12)
    (=
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) x@118@12)
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) x@118@12)))
  :pattern ((Set_in x@118@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@148@17@148@75|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))
  $Snap.unit))
; [eval] (forall j: Int :: { (j in S) } { (edge_lookup(this.edges, j) in setOfRef) } (j in S) ==> (edge_lookup(this.edges, j) in setOfRef))
(declare-const j@121@12 Int)
(push) ; 5
; [eval] (j in S) ==> (edge_lookup(this.edges, j) in setOfRef)
; [eval] (j in S)
(push) ; 6
; [then-branch: 17 | j@121@12 in S@102@12 | live]
; [else-branch: 17 | !(j@121@12 in S@102@12) | live]
(push) ; 7
; [then-branch: 17 | j@121@12 in S@102@12]
(assert (Set_in j@121@12 S@102@12))
; [eval] (edge_lookup(this.edges, j) in setOfRef)
; [eval] edge_lookup(this.edges, j)
(push) ; 8
(assert (not (ite
  (and (img@117@12 this@8@12) (Set_in (inv@116@12 this@8@12) setOfRef@10@12))
  (< $Perm.No rd@12@12)
  false)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 17 | !(j@121@12 in S@102@12)]
(assert (not (Set_in j@121@12 S@102@12)))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (not (Set_in j@121@12 S@102@12)) (Set_in j@121@12 S@102@12)))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((j@121@12 Int)) (!
  (or (not (Set_in j@121@12 S@102@12)) (Set_in j@121@12 S@102@12))
  :pattern ((Set_in j@121@12 S@102@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@149@17@149@83-aux|)))
(assert (forall ((j@121@12 Int)) (!
  (or (not (Set_in j@121@12 S@102@12)) (Set_in j@121@12 S@102@12))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) this@8@12) j@121@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@149@17@149@83-aux|)))
(assert (forall ((j@121@12 Int)) (!
  (=>
    (Set_in j@121@12 S@102@12)
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) this@8@12) j@121@12) setOfRef@10@12))
  :pattern ((Set_in j@121@12 S@102@12))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) this@8@12) j@121@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@149@17@149@83|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))
  $Snap.unit))
; [eval] (forall r: Ref, j: Int :: { (r in setOfRef), (j in edges_domain(r.edges)) } { (r in setOfRef), edge_lookup(r.edges, j) } { (r in setOfRef), (edge_lookup(r.edges, j) in setOfRef) } { edges_domain(r.edges), edge_lookup(r.edges, j) } { edges_domain(r.edges), (edge_lookup(r.edges, j) in setOfRef) } { (j in edges_domain(r.edges)) } { (edge_lookup(r.edges, j) in setOfRef) } (r in setOfRef) && (j in edges_domain(r.edges)) ==> (edge_lookup(r.edges, j) in setOfRef))
(declare-const r@122@12 $Ref)
(declare-const j@123@12 Int)
(push) ; 5
; [eval] (r in setOfRef) && (j in edges_domain(r.edges)) ==> (edge_lookup(r.edges, j) in setOfRef)
; [eval] (r in setOfRef) && (j in edges_domain(r.edges))
; [eval] (r in setOfRef)
(push) ; 6
; [then-branch: 18 | !(r@122@12 in setOfRef@10@12) | live]
; [else-branch: 18 | r@122@12 in setOfRef@10@12 | live]
(push) ; 7
; [then-branch: 18 | !(r@122@12 in setOfRef@10@12)]
(assert (not (Set_in r@122@12 setOfRef@10@12)))
(pop) ; 7
(push) ; 7
; [else-branch: 18 | r@122@12 in setOfRef@10@12]
(assert (Set_in r@122@12 setOfRef@10@12))
; [eval] (j in edges_domain(r.edges))
; [eval] edges_domain(r.edges)
(push) ; 8
(assert (not (ite
  (and (img@117@12 r@122@12) (Set_in (inv@116@12 r@122@12) setOfRef@10@12))
  (< $Perm.No rd@12@12)
  false)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or (Set_in r@122@12 setOfRef@10@12) (not (Set_in r@122@12 setOfRef@10@12))))
(push) ; 6
; [then-branch: 19 | r@122@12 in setOfRef@10@12 && j@123@12 in edges_domain[Set[Int]](Lookup(edges, First:(Second:(Second:(Second:(Second:($t@108@12))))), r@122@12)) | live]
; [else-branch: 19 | !(r@122@12 in setOfRef@10@12 && j@123@12 in edges_domain[Set[Int]](Lookup(edges, First:(Second:(Second:(Second:(Second:($t@108@12))))), r@122@12))) | live]
(push) ; 7
; [then-branch: 19 | r@122@12 in setOfRef@10@12 && j@123@12 in edges_domain[Set[Int]](Lookup(edges, First:(Second:(Second:(Second:(Second:($t@108@12))))), r@122@12))]
(assert (and
  (Set_in r@122@12 setOfRef@10@12)
  (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
; [eval] (edge_lookup(r.edges, j) in setOfRef)
; [eval] edge_lookup(r.edges, j)
(push) ; 8
(assert (not (ite
  (and (img@117@12 r@122@12) (Set_in (inv@116@12 r@122@12) setOfRef@10@12))
  (< $Perm.No rd@12@12)
  false)))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 19 | !(r@122@12 in setOfRef@10@12 && j@123@12 in edges_domain[Set[Int]](Lookup(edges, First:(Second:(Second:(Second:(Second:($t@108@12))))), r@122@12)))]
(assert (not
  (and
    (Set_in r@122@12 setOfRef@10@12)
    (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in r@122@12 setOfRef@10@12)
      (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
  (and
    (Set_in r@122@12 setOfRef@10@12)
    (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (and
    (or (Set_in r@122@12 setOfRef@10@12) (not (Set_in r@122@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@122@12 setOfRef@10@12)
          (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
      (and
        (Set_in r@122@12 setOfRef@10@12)
        (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
  :pattern ((Set_in r@122@12 setOfRef@10@12) (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (and
    (or (Set_in r@122@12 setOfRef@10@12) (not (Set_in r@122@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@122@12 setOfRef@10@12)
          (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
      (and
        (Set_in r@122@12 setOfRef@10@12)
        (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
  :pattern ((Set_in r@122@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (and
    (or (Set_in r@122@12 setOfRef@10@12) (not (Set_in r@122@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@122@12 setOfRef@10@12)
          (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
      (and
        (Set_in r@122@12 setOfRef@10@12)
        (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
  :pattern ((Set_in r@122@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (and
    (or (Set_in r@122@12 setOfRef@10@12) (not (Set_in r@122@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@122@12 setOfRef@10@12)
          (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
      (and
        (Set_in r@122@12 setOfRef@10@12)
        (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (and
    (or (Set_in r@122@12 setOfRef@10@12) (not (Set_in r@122@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@122@12 setOfRef@10@12)
          (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
      (and
        (Set_in r@122@12 setOfRef@10@12)
        (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (and
    (or (Set_in r@122@12 setOfRef@10@12) (not (Set_in r@122@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@122@12 setOfRef@10@12)
          (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
      (and
        (Set_in r@122@12 setOfRef@10@12)
        (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
  :pattern ((Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (and
    (or (Set_in r@122@12 setOfRef@10@12) (not (Set_in r@122@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@122@12 setOfRef@10@12)
          (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
      (and
        (Set_in r@122@12 setOfRef@10@12)
        (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (=>
    (and
      (Set_in r@122@12 setOfRef@10@12)
      (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12) setOfRef@10@12))
  :pattern ((Set_in r@122@12 setOfRef@10@12) (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))
  :pattern ((Set_in r@122@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12))
  :pattern ((Set_in r@122@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12) setOfRef@10@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12) setOfRef@10@12))
  :pattern ((Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))
  $Snap.unit))
; [eval] (node_map_image subset res_copy_nodes)
(assert (Set_subset node_map_image@11@12 res_copy_nodes@107@12))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))
  $Snap.unit))
; [eval] |(setOfRef intersection res_copy_nodes)| == 0
; [eval] |(setOfRef intersection res_copy_nodes)|
; [eval] (setOfRef intersection res_copy_nodes)
(assert (= (Set_card (Set_intersection setOfRef@10@12 res_copy_nodes@107@12)) 0))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))))
  $Snap.unit))
; [eval] (forall r: Ref :: { (r in map_domain(res_node_map)) } { (lookup(res_node_map, r) in res_copy_nodes) } (r in map_domain(res_node_map)) ==> (lookup(res_node_map, r) in res_copy_nodes))
(declare-const r@124@12 $Ref)
(push) ; 5
; [eval] (r in map_domain(res_node_map)) ==> (lookup(res_node_map, r) in res_copy_nodes)
; [eval] (r in map_domain(res_node_map))
; [eval] map_domain(res_node_map)
(push) ; 6
; [then-branch: 20 | r@124@12 in map_domain[Seq[Ref]](res_node_map@106@12) | live]
; [else-branch: 20 | !(r@124@12 in map_domain[Seq[Ref]](res_node_map@106@12)) | live]
(push) ; 7
; [then-branch: 20 | r@124@12 in map_domain[Seq[Ref]](res_node_map@106@12)]
(assert (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
; [eval] (lookup(res_node_map, r) in res_copy_nodes)
; [eval] lookup(res_node_map, r)
(pop) ; 7
(push) ; 7
; [else-branch: 20 | !(r@124@12 in map_domain[Seq[Ref]](res_node_map@106@12))]
(assert (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12)))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or
  (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
  (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12)))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((r@124@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    r@124@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108-aux|)))
(assert (forall ((r@124@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    r@124@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108-aux|)))
(assert (forall ((r@124@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@106@12 r@124@12) res_copy_nodes@107@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108-aux|)))
(assert (forall ((r@124@12 $Ref)) (!
  (=>
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12)
    (Set_in (lookup<Ref> res_node_map@106@12 r@124@12) res_copy_nodes@107@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    r@124@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@106@12 r@124@12) res_copy_nodes@107@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))))))))
(declare-const r@125@12 $Ref)
(push) ; 5
; [eval] (r in res_copy_nodes)
(assert (Set_in r@125@12 res_copy_nodes@107@12))
(pop) ; 5
(declare-fun inv@126@12 ($Ref) $Ref)
(declare-fun img@127@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 5
(assert (not (forall ((r1@125@12 $Ref) (r2@125@12 $Ref)) (!
  (=>
    (and
      (Set_in r1@125@12 res_copy_nodes@107@12)
      (Set_in r2@125@12 res_copy_nodes@107@12)
      (= r1@125@12 r2@125@12))
    (= r1@125@12 r2@125@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((r@125@12 $Ref)) (!
  (=>
    (Set_in r@125@12 res_copy_nodes@107@12)
    (and (= (inv@126@12 r@125@12) r@125@12) (img@127@12 r@125@12)))
  :pattern ((Set_in r@125@12 res_copy_nodes@107@12))
  :pattern ((inv@126@12 r@125@12))
  :pattern ((img@127@12 r@125@12))
  :qid |quant-u-47|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
    (= (inv@126@12 r) r))
  :pattern ((inv@126@12 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((r@125@12 $Ref)) (!
  (=> (Set_in r@125@12 res_copy_nodes@107@12) (not (= r@125@12 $Ref.null)))
  :pattern ((Set_in r@125@12 res_copy_nodes@107@12))
  :pattern ((inv@126@12 r@125@12))
  :pattern ((img@127@12 r@125@12))
  :qid |val-permImpliesNonNull|)))
(push) ; 5
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= r@125@12 x@109@12)
    (=
      (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))))
  
  :qid |quant-u-48|))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(declare-const r@128@12 $Ref)
(set-option :timeout 0)
(push) ; 5
; [eval] (r in res_copy_nodes)
(assert (Set_in r@128@12 res_copy_nodes@107@12))
(pop) ; 5
(declare-fun inv@129@12 ($Ref) $Ref)
(declare-fun img@130@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 5
(assert (not (forall ((r1@128@12 $Ref) (r2@128@12 $Ref)) (!
  (=>
    (and
      (Set_in r1@128@12 res_copy_nodes@107@12)
      (Set_in r2@128@12 res_copy_nodes@107@12)
      (= r1@128@12 r2@128@12))
    (= r1@128@12 r2@128@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((r@128@12 $Ref)) (!
  (=>
    (Set_in r@128@12 res_copy_nodes@107@12)
    (and (= (inv@129@12 r@128@12) r@128@12) (img@130@12 r@128@12)))
  :pattern ((Set_in r@128@12 res_copy_nodes@107@12))
  :pattern ((inv@129@12 r@128@12))
  :pattern ((img@130@12 r@128@12))
  :qid |quant-u-50|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (= (inv@129@12 r) r))
  :pattern ((inv@129@12 r))
  :qid |edges-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((r@128@12 $Ref)) (!
  (=> (Set_in r@128@12 res_copy_nodes@107@12) (not (= r@128@12 $Ref.null)))
  :pattern ((Set_in r@128@12 res_copy_nodes@107@12))
  :pattern ((inv@129@12 r@128@12))
  :pattern ((img@130@12 r@128@12))
  :qid |edges-permImpliesNonNull|)))
(push) ; 5
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= r@128@12 x@115@12)
    (=
      (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))))
  
  :qid |quant-u-51|))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(pop) ; 4
(set-option :timeout 0)
(push) ; 4
; Loop head block: Establish invariant
; [eval] (nodeCopy in res_copy_nodes)
(push) ; 5
(assert (not (Set_in nodeCopy@86@12 res_copy_nodes@98@12)))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (Set_in nodeCopy@86@12 res_copy_nodes@98@12))
; [eval] (this in setOfRef)
(declare-const x@131@12 $Ref)
(push) ; 5
; [eval] (x in setOfRef)
(assert (Set_in x@131@12 setOfRef@10@12))
(pop) ; 5
(declare-fun inv@132@12 ($Ref) $Ref)
(declare-fun img@133@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 5
(assert (not (forall ((x@131@12 $Ref)) (!
  (=>
    (Set_in x@131@12 setOfRef@10@12)
    (or (= rd@12@12 $Perm.No) (< $Perm.No rd@12@12)))
  
  :qid |quant-u-52|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 5
(assert (not (forall ((x1@131@12 $Ref) (x2@131@12 $Ref)) (!
  (=>
    (and
      (and (Set_in x1@131@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (and (Set_in x2@131@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (= x1@131@12 x2@131@12))
    (= x1@131@12 x2@131@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@131@12 $Ref)) (!
  (=>
    (and (Set_in x@131@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@132@12 x@131@12) x@131@12) (img@133@12 x@131@12)))
  :pattern ((Set_in x@131@12 setOfRef@10@12))
  :pattern ((inv@132@12 x@131@12))
  :pattern ((img@133@12 x@131@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@133@12 r)
      (and (Set_in (inv@132@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@132@12 r) r))
  :pattern ((inv@132@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@134@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@132@12 r) setOfRef@10@12)
      (img@133@12 r)
      (= r (inv@132@12 r)))
    ($Perm.min
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      rd@12@12)
    $Perm.No))
(define-fun pTaken@135@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@132@12 r) setOfRef@10@12)
      (img@133@12 r)
      (= r (inv@132@12 r)))
    ($Perm.min
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (- rd@12@12 (pTaken@134@12 r)))
    $Perm.No))
(define-fun pTaken@136@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@132@12 r) setOfRef@10@12)
      (img@133@12 r)
      (= r (inv@132@12 r)))
    ($Perm.min
      (ite (= r nodeCopy@86@12) $Perm.Write $Perm.No)
      (- (- rd@12@12 (pTaken@134@12 r)) (pTaken@135@12 r)))
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
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      (pTaken@134@12 r))
    $Perm.No)
  
  :qid |quant-u-54|))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@134@12 r) $Perm.No)
  
  :qid |quant-u-55|))))
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
      (Set_in (inv@132@12 r) setOfRef@10@12)
      (img@133@12 r)
      (= r (inv@132@12 r)))
    (= (- rd@12@12 (pTaken@134@12 r)) $Perm.No))
  
  :qid |quant-u-56|))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (pTaken@135@12 r))
    $Perm.No)
  
  :qid |quant-u-57|))))
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
      (Set_in (inv@132@12 r) setOfRef@10@12)
      (img@133@12 r)
      (= r (inv@132@12 r)))
    (= (- (- rd@12@12 (pTaken@134@12 r)) (pTaken@135@12 r)) $Perm.No))
  
  :qid |quant-u-58|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@137@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_val (as sm@137@12  $FVF<val>) r)
      ($FVF.lookup_val (as sm@96@12  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@137@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@96@12  $FVF<val>) r))
  :qid |qp.fvfValDef29|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@137@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@137@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef30|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@137@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@137@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef31|)))
; [eval] (forall x: Ref :: { (x in setOfRef) } (x in setOfRef) ==> x.val == old(x.val))
(declare-const x@138@12 $Ref)
(set-option :timeout 0)
(push) ; 5
; [eval] (x in setOfRef) ==> x.val == old(x.val)
; [eval] (x in setOfRef)
(push) ; 6
; [then-branch: 21 | x@138@12 in setOfRef@10@12 | live]
; [else-branch: 21 | !(x@138@12 in setOfRef@10@12) | live]
(push) ; 7
; [then-branch: 21 | x@138@12 in setOfRef@10@12]
(assert (Set_in x@138@12 setOfRef@10@12))
; [eval] x.val == old(x.val)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r nodeCopy@86@12)
      (=
        ($FVF.lookup_val (as sm@137@12  $FVF<val>) r)
        ($FVF.lookup_val (as sm@96@12  $FVF<val>) r)))
    :pattern (($FVF.lookup_val (as sm@137@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val (as sm@96@12  $FVF<val>) r))
    :qid |qp.fvfValDef29|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
      (=
        ($FVF.lookup_val (as sm@137@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
    :pattern (($FVF.lookup_val (as sm@137@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
    :qid |qp.fvfValDef30|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_val (as sm@137@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
    :pattern (($FVF.lookup_val (as sm@137@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
    :qid |qp.fvfValDef31|))))
(push) ; 8
(assert (not (<
  $Perm.No
  (+
    (+
      (ite (= x@138@12 nodeCopy@86@12) $Perm.Write $Perm.No)
      (ite
        (and
          (img@28@12 x@138@12)
          (Set_in (inv@27@12 x@138@12) node_map_image@11@12))
        $Perm.Write
        $Perm.No))
    (ite
      (and (img@19@12 x@138@12) (Set_in (inv@18@12 x@138@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [eval] old(x.val)
(declare-const sm@139@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@139@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@139@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef32|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@139@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@139@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef33|)))
(declare-const pm@140@12 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@140@12  $FPM) r)
    (+
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@140@12  $FPM) r))
  :qid |qp.resPrmSumDef34|)))
(push) ; 8
(assert (not (< $Perm.No ($FVF.perm_val (as pm@140@12  $FPM) x@138@12))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 21 | !(x@138@12 in setOfRef@10@12)]
(assert (not (Set_in x@138@12 setOfRef@10@12)))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_val (as sm@137@12  $FVF<val>) r)
      ($FVF.lookup_val (as sm@96@12  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@137@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@96@12  $FVF<val>) r))
  :qid |qp.fvfValDef29|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@137@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@137@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef30|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@137@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@137@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef31|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@139@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@139@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef32|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@139@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@139@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@140@12  $FPM) r)
    (+
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@140@12  $FPM) r))
  :qid |qp.resPrmSumDef34|)))
; Joined path conditions
(assert (or (not (Set_in x@138@12 setOfRef@10@12)) (Set_in x@138@12 setOfRef@10@12)))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_val (as sm@137@12  $FVF<val>) r)
      ($FVF.lookup_val (as sm@96@12  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@137@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@96@12  $FVF<val>) r))
  :qid |qp.fvfValDef29|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@137@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@137@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef30|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@137@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@137@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef31|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@139@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@139@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef32|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@139@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@139@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef33|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@140@12  $FPM) r)
    (+
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@140@12  $FPM) r))
  :qid |qp.resPrmSumDef34|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@138@12 $Ref)) (!
  (or (not (Set_in x@138@12 setOfRef@10@12)) (Set_in x@138@12 setOfRef@10@12))
  :pattern ((Set_in x@138@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@146@17@146@71-aux|)))
(push) ; 5
(assert (not (forall ((x@138@12 $Ref)) (!
  (=>
    (Set_in x@138@12 setOfRef@10@12)
    (=
      ($FVF.lookup_val (as sm@137@12  $FVF<val>) x@138@12)
      ($FVF.lookup_val (as sm@139@12  $FVF<val>) x@138@12)))
  :pattern ((Set_in x@138@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@146@17@146@71|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (forall ((x@138@12 $Ref)) (!
  (=>
    (Set_in x@138@12 setOfRef@10@12)
    (=
      ($FVF.lookup_val (as sm@137@12  $FVF<val>) x@138@12)
      ($FVF.lookup_val (as sm@139@12  $FVF<val>) x@138@12)))
  :pattern ((Set_in x@138@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@146@17@146@71|)))
(declare-const x@141@12 $Ref)
(push) ; 5
; [eval] (x in setOfRef)
(assert (Set_in x@141@12 setOfRef@10@12))
(pop) ; 5
(declare-fun inv@142@12 ($Ref) $Ref)
(declare-fun img@143@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 5
(assert (not (forall ((x@141@12 $Ref)) (!
  (=>
    (Set_in x@141@12 setOfRef@10@12)
    (or (= rd@12@12 $Perm.No) (< $Perm.No rd@12@12)))
  
  :qid |quant-u-59|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 5
(assert (not (forall ((x1@141@12 $Ref) (x2@141@12 $Ref)) (!
  (=>
    (and
      (and (Set_in x1@141@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (and (Set_in x2@141@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (= x1@141@12 x2@141@12))
    (= x1@141@12 x2@141@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@141@12 $Ref)) (!
  (=>
    (and (Set_in x@141@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@142@12 x@141@12) x@141@12) (img@143@12 x@141@12)))
  :pattern ((Set_in x@141@12 setOfRef@10@12))
  :pattern ((inv@142@12 x@141@12))
  :pattern ((img@143@12 x@141@12))
  :qid |edges-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@143@12 r)
      (and (Set_in (inv@142@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@142@12 r) r))
  :pattern ((inv@142@12 r))
  :qid |edges-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@144@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@142@12 r) setOfRef@10@12)
      (img@143@12 r)
      (= r (inv@142@12 r)))
    ($Perm.min
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      rd@12@12)
    $Perm.No))
(define-fun pTaken@145@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@142@12 r) setOfRef@10@12)
      (img@143@12 r)
      (= r (inv@142@12 r)))
    ($Perm.min
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      (- rd@12@12 (pTaken@144@12 r)))
    $Perm.No))
(define-fun pTaken@146@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@142@12 r) setOfRef@10@12)
      (img@143@12 r)
      (= r (inv@142@12 r)))
    ($Perm.min
      (ite (= r nodeCopy@86@12) $Perm.Write $Perm.No)
      (- (- rd@12@12 (pTaken@144@12 r)) (pTaken@145@12 r)))
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
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (pTaken@144@12 r))
    $Perm.No)
  
  :qid |quant-u-61|))))
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
      (Set_in (inv@142@12 r) setOfRef@10@12)
      (img@143@12 r)
      (= r (inv@142@12 r)))
    (= (- rd@12@12 (pTaken@144@12 r)) $Perm.No))
  
  :qid |quant-u-62|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@147@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@147@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@147@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r))
  :qid |qp.fvfValDef35|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@147@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@147@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef36|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@147@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@147@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef37|)))
; [eval] (forall x: Ref :: { (x in setOfRef) } (x in setOfRef) ==> x.edges == old(x.edges))
(declare-const x@148@12 $Ref)
(set-option :timeout 0)
(push) ; 5
; [eval] (x in setOfRef) ==> x.edges == old(x.edges)
; [eval] (x in setOfRef)
(push) ; 6
; [then-branch: 22 | x@148@12 in setOfRef@10@12 | live]
; [else-branch: 22 | !(x@148@12 in setOfRef@10@12) | live]
(push) ; 7
; [then-branch: 22 | x@148@12 in setOfRef@10@12]
(assert (Set_in x@148@12 setOfRef@10@12))
; [eval] x.edges == old(x.edges)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
      (=
        ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
    :qid |qp.fvfValDef19|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
    :qid |qp.fvfValDef20|))
  (forall ((r $Ref)) (!
    (=>
      (= r nodeCopy@86@12)
      (=
        ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
        ($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r)))
    :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r))
    :qid |qp.fvfValDef21|))))
(push) ; 8
(assert (not (<
  $Perm.No
  (+
    (+
      (ite
        (and
          (img@31@12 x@148@12)
          (Set_in (inv@30@12 x@148@12) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      (ite
        (and (img@22@12 x@148@12) (Set_in (inv@21@12 x@148@12) setOfRef@10@12))
        rd@12@12
        $Perm.No))
    (ite (= x@148@12 nodeCopy@86@12) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
; [eval] old(x.edges)
(declare-const sm@149@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@149@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@149@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef38|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@149@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@149@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef39|)))
(declare-const pm@150@12 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@150@12  $FPM) r)
    (+
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@150@12  $FPM) r))
  :qid |qp.resPrmSumDef40|)))
(push) ; 8
(assert (not (< $Perm.No ($FVF.perm_edges (as pm@150@12  $FPM) x@148@12))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 22 | !(x@148@12 in setOfRef@10@12)]
(assert (not (Set_in x@148@12 setOfRef@10@12)))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef20|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r))
  :qid |qp.fvfValDef21|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@149@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@149@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef38|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@149@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@149@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef39|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@150@12  $FPM) r)
    (+
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@150@12  $FPM) r))
  :qid |qp.resPrmSumDef40|)))
; Joined path conditions
(assert (or (not (Set_in x@148@12 setOfRef@10@12)) (Set_in x@148@12 setOfRef@10@12)))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef20|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r))
  :qid |qp.fvfValDef21|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@149@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@149@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef38|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@149@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@149@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef39|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@150@12  $FPM) r)
    (+
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@150@12  $FPM) r))
  :qid |qp.resPrmSumDef40|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@148@12 $Ref)) (!
  (or (not (Set_in x@148@12 setOfRef@10@12)) (Set_in x@148@12 setOfRef@10@12))
  :pattern ((Set_in x@148@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@148@17@148@75-aux|)))
(push) ; 5
(assert (not (forall ((x@148@12 $Ref)) (!
  (=>
    (Set_in x@148@12 setOfRef@10@12)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) x@148@12)
      ($FVF.lookup_edges (as sm@149@12  $FVF<edges>) x@148@12)))
  :pattern ((Set_in x@148@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@148@17@148@75|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (forall ((x@148@12 $Ref)) (!
  (=>
    (Set_in x@148@12 setOfRef@10@12)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) x@148@12)
      ($FVF.lookup_edges (as sm@149@12  $FVF<edges>) x@148@12)))
  :pattern ((Set_in x@148@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@148@17@148@75|)))
; [eval] (forall j: Int :: { (j in S) } { (edge_lookup(this.edges, j) in setOfRef) } (j in S) ==> (edge_lookup(this.edges, j) in setOfRef))
(declare-const j@151@12 Int)
(push) ; 5
; [eval] (j in S) ==> (edge_lookup(this.edges, j) in setOfRef)
; [eval] (j in S)
(push) ; 6
; [then-branch: 23 | j@151@12 in S@101@12 | live]
; [else-branch: 23 | !(j@151@12 in S@101@12) | live]
(push) ; 7
; [then-branch: 23 | j@151@12 in S@101@12]
(assert (Set_in j@151@12 S@101@12))
; [eval] (edge_lookup(this.edges, j) in setOfRef)
; [eval] edge_lookup(this.edges, j)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
      (=
        ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
    :qid |qp.fvfValDef19|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
    :qid |qp.fvfValDef20|))
  (forall ((r $Ref)) (!
    (=>
      (= r nodeCopy@86@12)
      (=
        ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
        ($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r)))
    :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r))
    :qid |qp.fvfValDef21|))))
(push) ; 8
(assert (not (<
  $Perm.No
  (+
    (+
      (ite
        (and
          (img@31@12 this@8@12)
          (Set_in (inv@30@12 this@8@12) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      (ite
        (and (img@22@12 this@8@12) (Set_in (inv@21@12 this@8@12) setOfRef@10@12))
        rd@12@12
        $Perm.No))
    (ite (= this@8@12 nodeCopy@86@12) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 23 | !(j@151@12 in S@101@12)]
(assert (not (Set_in j@151@12 S@101@12)))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef20|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r))
  :qid |qp.fvfValDef21|)))
; Joined path conditions
(assert (or (not (Set_in j@151@12 S@101@12)) (Set_in j@151@12 S@101@12)))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef20|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r))
  :qid |qp.fvfValDef21|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((j@151@12 Int)) (!
  (or (not (Set_in j@151@12 S@101@12)) (Set_in j@151@12 S@101@12))
  :pattern ((Set_in j@151@12 S@101@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@149@17@149@83-aux|)))
(assert (forall ((j@151@12 Int)) (!
  (or (not (Set_in j@151@12 S@101@12)) (Set_in j@151@12 S@101@12))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) this@8@12) j@151@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@149@17@149@83-aux|)))
(push) ; 5
(assert (not (forall ((j@151@12 Int)) (!
  (=>
    (Set_in j@151@12 S@101@12)
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) this@8@12) j@151@12) setOfRef@10@12))
  :pattern ((Set_in j@151@12 S@101@12))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) this@8@12) j@151@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@149@17@149@83|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (forall ((j@151@12 Int)) (!
  (=>
    (Set_in j@151@12 S@101@12)
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) this@8@12) j@151@12) setOfRef@10@12))
  :pattern ((Set_in j@151@12 S@101@12))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) this@8@12) j@151@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@149@17@149@83|)))
; [eval] (forall r: Ref, j: Int :: { (r in setOfRef), (j in edges_domain(r.edges)) } { (r in setOfRef), edge_lookup(r.edges, j) } { (r in setOfRef), (edge_lookup(r.edges, j) in setOfRef) } { edges_domain(r.edges), edge_lookup(r.edges, j) } { edges_domain(r.edges), (edge_lookup(r.edges, j) in setOfRef) } { (j in edges_domain(r.edges)) } { (edge_lookup(r.edges, j) in setOfRef) } (r in setOfRef) && (j in edges_domain(r.edges)) ==> (edge_lookup(r.edges, j) in setOfRef))
(declare-const r@152@12 $Ref)
(declare-const j@153@12 Int)
(push) ; 5
; [eval] (r in setOfRef) && (j in edges_domain(r.edges)) ==> (edge_lookup(r.edges, j) in setOfRef)
; [eval] (r in setOfRef) && (j in edges_domain(r.edges))
; [eval] (r in setOfRef)
(push) ; 6
; [then-branch: 24 | !(r@152@12 in setOfRef@10@12) | live]
; [else-branch: 24 | r@152@12 in setOfRef@10@12 | live]
(push) ; 7
; [then-branch: 24 | !(r@152@12 in setOfRef@10@12)]
(assert (not (Set_in r@152@12 setOfRef@10@12)))
(pop) ; 7
(push) ; 7
; [else-branch: 24 | r@152@12 in setOfRef@10@12]
(assert (Set_in r@152@12 setOfRef@10@12))
; [eval] (j in edges_domain(r.edges))
; [eval] edges_domain(r.edges)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
      (=
        ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
    :qid |qp.fvfValDef19|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
    :qid |qp.fvfValDef20|))
  (forall ((r $Ref)) (!
    (=>
      (= r nodeCopy@86@12)
      (=
        ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
        ($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r)))
    :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r))
    :qid |qp.fvfValDef21|))))
(push) ; 8
(assert (not (<
  $Perm.No
  (+
    (+
      (ite
        (and
          (img@31@12 r@152@12)
          (Set_in (inv@30@12 r@152@12) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      (ite
        (and (img@22@12 r@152@12) (Set_in (inv@21@12 r@152@12) setOfRef@10@12))
        rd@12@12
        $Perm.No))
    (ite (= r@152@12 nodeCopy@86@12) $Perm.Write $Perm.No)))))
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
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef20|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r))
  :qid |qp.fvfValDef21|)))
(assert (or (Set_in r@152@12 setOfRef@10@12) (not (Set_in r@152@12 setOfRef@10@12))))
(push) ; 6
; [then-branch: 25 | r@152@12 in setOfRef@10@12 && j@153@12 in edges_domain[Set[Int]](Lookup(edges, sm@99@12, r@152@12)) | live]
; [else-branch: 25 | !(r@152@12 in setOfRef@10@12 && j@153@12 in edges_domain[Set[Int]](Lookup(edges, sm@99@12, r@152@12))) | live]
(push) ; 7
; [then-branch: 25 | r@152@12 in setOfRef@10@12 && j@153@12 in edges_domain[Set[Int]](Lookup(edges, sm@99@12, r@152@12))]
(assert (and
  (Set_in r@152@12 setOfRef@10@12)
  (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12)))))
; [eval] (edge_lookup(r.edges, j) in setOfRef)
; [eval] edge_lookup(r.edges, j)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
      (=
        ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
    :qid |qp.fvfValDef19|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
    :qid |qp.fvfValDef20|))
  (forall ((r $Ref)) (!
    (=>
      (= r nodeCopy@86@12)
      (=
        ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
        ($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r)))
    :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r))
    :qid |qp.fvfValDef21|))))
(push) ; 8
(assert (not (<
  $Perm.No
  (+
    (+
      (ite
        (and
          (img@31@12 r@152@12)
          (Set_in (inv@30@12 r@152@12) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      (ite
        (and (img@22@12 r@152@12) (Set_in (inv@21@12 r@152@12) setOfRef@10@12))
        rd@12@12
        $Perm.No))
    (ite (= r@152@12 nodeCopy@86@12) $Perm.Write $Perm.No)))))
(check-sat)
; unsat
(pop) ; 8
; 0.00s
; (get-info :all-statistics)
(pop) ; 7
(push) ; 7
; [else-branch: 25 | !(r@152@12 in setOfRef@10@12 && j@153@12 in edges_domain[Set[Int]](Lookup(edges, sm@99@12, r@152@12)))]
(assert (not
  (and
    (Set_in r@152@12 setOfRef@10@12)
    (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))))
(pop) ; 7
(pop) ; 6
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef20|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r))
  :qid |qp.fvfValDef21|)))
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in r@152@12 setOfRef@10@12)
      (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12)))))
  (and
    (Set_in r@152@12 setOfRef@10@12)
    (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef19|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef20|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r))
  :qid |qp.fvfValDef21|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((r@152@12 $Ref) (j@153@12 Int)) (!
  (and
    (or (Set_in r@152@12 setOfRef@10@12) (not (Set_in r@152@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@152@12 setOfRef@10@12)
          (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12)))))
      (and
        (Set_in r@152@12 setOfRef@10@12)
        (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))))
  :pattern ((Set_in r@152@12 setOfRef@10@12) (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@152@12 $Ref) (j@153@12 Int)) (!
  (and
    (or (Set_in r@152@12 setOfRef@10@12) (not (Set_in r@152@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@152@12 setOfRef@10@12)
          (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12)))))
      (and
        (Set_in r@152@12 setOfRef@10@12)
        (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))))
  :pattern ((Set_in r@152@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@152@12 $Ref) (j@153@12 Int)) (!
  (and
    (or (Set_in r@152@12 setOfRef@10@12) (not (Set_in r@152@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@152@12 setOfRef@10@12)
          (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12)))))
      (and
        (Set_in r@152@12 setOfRef@10@12)
        (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))))
  :pattern ((Set_in r@152@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@152@12 $Ref) (j@153@12 Int)) (!
  (and
    (or (Set_in r@152@12 setOfRef@10@12) (not (Set_in r@152@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@152@12 setOfRef@10@12)
          (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12)))))
      (and
        (Set_in r@152@12 setOfRef@10@12)
        (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@152@12 $Ref) (j@153@12 Int)) (!
  (and
    (or (Set_in r@152@12 setOfRef@10@12) (not (Set_in r@152@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@152@12 setOfRef@10@12)
          (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12)))))
      (and
        (Set_in r@152@12 setOfRef@10@12)
        (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@152@12 $Ref) (j@153@12 Int)) (!
  (and
    (or (Set_in r@152@12 setOfRef@10@12) (not (Set_in r@152@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@152@12 setOfRef@10@12)
          (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12)))))
      (and
        (Set_in r@152@12 setOfRef@10@12)
        (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))))
  :pattern ((Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@152@12 $Ref) (j@153@12 Int)) (!
  (and
    (or (Set_in r@152@12 setOfRef@10@12) (not (Set_in r@152@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@152@12 setOfRef@10@12)
          (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12)))))
      (and
        (Set_in r@152@12 setOfRef@10@12)
        (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(push) ; 5
(assert (not (forall ((r@152@12 $Ref) (j@153@12 Int)) (!
  (=>
    (and
      (Set_in r@152@12 setOfRef@10@12)
      (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12) setOfRef@10@12))
  :pattern ((Set_in r@152@12 setOfRef@10@12) (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))
  :pattern ((Set_in r@152@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12))
  :pattern ((Set_in r@152@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12) setOfRef@10@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12) setOfRef@10@12))
  :pattern ((Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (forall ((r@152@12 $Ref) (j@153@12 Int)) (!
  (=>
    (and
      (Set_in r@152@12 setOfRef@10@12)
      (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12) setOfRef@10@12))
  :pattern ((Set_in r@152@12 setOfRef@10@12) (Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))
  :pattern ((Set_in r@152@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12))
  :pattern ((Set_in r@152@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12) setOfRef@10@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12) setOfRef@10@12))
  :pattern ((Set_in j@153@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@99@12  $FVF<edges>) r@152@12) j@153@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125|)))
; [eval] (node_map_image subset res_copy_nodes)
(push) ; 5
(assert (not (Set_subset node_map_image@11@12 res_copy_nodes@98@12)))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (Set_subset node_map_image@11@12 res_copy_nodes@98@12))
; [eval] |(setOfRef intersection res_copy_nodes)| == 0
; [eval] |(setOfRef intersection res_copy_nodes)|
; [eval] (setOfRef intersection res_copy_nodes)
(push) ; 5
(assert (not (= (Set_card (Set_intersection setOfRef@10@12 res_copy_nodes@98@12)) 0)))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (= (Set_card (Set_intersection setOfRef@10@12 res_copy_nodes@98@12)) 0))
; [eval] (forall r: Ref :: { (r in map_domain(res_node_map)) } { (lookup(res_node_map, r) in res_copy_nodes) } (r in map_domain(res_node_map)) ==> (lookup(res_node_map, r) in res_copy_nodes))
(declare-const r@154@12 $Ref)
(push) ; 5
; [eval] (r in map_domain(res_node_map)) ==> (lookup(res_node_map, r) in res_copy_nodes)
; [eval] (r in map_domain(res_node_map))
; [eval] map_domain(res_node_map)
(push) ; 6
; [then-branch: 26 | r@154@12 in map_domain[Seq[Ref]](res_node_map@97@12) | live]
; [else-branch: 26 | !(r@154@12 in map_domain[Seq[Ref]](res_node_map@97@12)) | live]
(push) ; 7
; [then-branch: 26 | r@154@12 in map_domain[Seq[Ref]](res_node_map@97@12)]
(assert (Seq_contains (map_domain<Seq<Ref>> res_node_map@97@12) r@154@12))
; [eval] (lookup(res_node_map, r) in res_copy_nodes)
; [eval] lookup(res_node_map, r)
(pop) ; 7
(push) ; 7
; [else-branch: 26 | !(r@154@12 in map_domain[Seq[Ref]](res_node_map@97@12))]
(assert (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@97@12) r@154@12)))
(pop) ; 7
(pop) ; 6
; Joined path conditions
; Joined path conditions
(assert (or
  (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@97@12) r@154@12))
  (Seq_contains (map_domain<Seq<Ref>> res_node_map@97@12) r@154@12)))
(pop) ; 5
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((r@154@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@97@12) r@154@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@97@12) r@154@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@97@12) r@154@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@97@12)
    r@154@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108-aux|)))
(assert (forall ((r@154@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@97@12) r@154@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@97@12) r@154@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@97@12)
    r@154@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108-aux|)))
(assert (forall ((r@154@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@97@12) r@154@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@97@12) r@154@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@97@12 r@154@12) res_copy_nodes@98@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108-aux|)))
(push) ; 5
(assert (not (forall ((r@154@12 $Ref)) (!
  (=>
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@97@12) r@154@12)
    (Set_in (lookup<Ref> res_node_map@97@12 r@154@12) res_copy_nodes@98@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@97@12) r@154@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@97@12)
    r@154@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@97@12)
    r@154@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@97@12 r@154@12) res_copy_nodes@98@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
(assert (forall ((r@154@12 $Ref)) (!
  (=>
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@97@12) r@154@12)
    (Set_in (lookup<Ref> res_node_map@97@12 r@154@12) res_copy_nodes@98@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@97@12) r@154@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@97@12)
    r@154@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@97@12 r@154@12) res_copy_nodes@98@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108|)))
(declare-const r@155@12 $Ref)
(push) ; 5
; [eval] (r in res_copy_nodes)
(assert (Set_in r@155@12 res_copy_nodes@98@12))
(pop) ; 5
(declare-fun inv@156@12 ($Ref) $Ref)
(declare-fun img@157@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 5
(assert (not (forall ((r1@155@12 $Ref) (r2@155@12 $Ref)) (!
  (=>
    (and
      (Set_in r1@155@12 res_copy_nodes@98@12)
      (Set_in r2@155@12 res_copy_nodes@98@12)
      (= r1@155@12 r2@155@12))
    (= r1@155@12 r2@155@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((r@155@12 $Ref)) (!
  (=>
    (Set_in r@155@12 res_copy_nodes@98@12)
    (and (= (inv@156@12 r@155@12) r@155@12) (img@157@12 r@155@12)))
  :pattern ((Set_in r@155@12 res_copy_nodes@98@12))
  :pattern ((inv@156@12 r@155@12))
  :pattern ((img@157@12 r@155@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@157@12 r) (Set_in (inv@156@12 r) res_copy_nodes@98@12))
    (= (inv@156@12 r) r))
  :pattern ((inv@156@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@158@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@156@12 r) res_copy_nodes@98@12)
      (img@157@12 r)
      (= r (inv@156@12 r)))
    ($Perm.min
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      $Perm.Write)
    $Perm.No))
(define-fun pTaken@159@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@156@12 r) res_copy_nodes@98@12)
      (img@157@12 r)
      (= r (inv@156@12 r)))
    ($Perm.min
      (ite (= r nodeCopy@86@12) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@158@12 r)))
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
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      (pTaken@158@12 r))
    $Perm.No)
  
  :qid |quant-u-65|))))
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
      (Set_in (inv@156@12 r) res_copy_nodes@98@12)
      (img@157@12 r)
      (= r (inv@156@12 r)))
    (= (- $Perm.Write (pTaken@158@12 r)) $Perm.No))
  
  :qid |quant-u-66|))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 500)
(assert (not (= (- $Perm.Write (pTaken@159@12 nodeCopy@86@12)) $Perm.No)))
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
      (Set_in (inv@156@12 r) res_copy_nodes@98@12)
      (img@157@12 r)
      (= r (inv@156@12 r)))
    (= (- (- $Perm.Write (pTaken@158@12 r)) (pTaken@159@12 r)) $Perm.No))
  
  :qid |quant-u-68|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@160@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@160@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@160@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef41|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_val (as sm@160@12  $FVF<val>) r)
      ($FVF.lookup_val (as sm@96@12  $FVF<val>) r)))
  :pattern (($FVF.lookup_val (as sm@160@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val (as sm@96@12  $FVF<val>) r))
  :qid |qp.fvfValDef42|)))
(declare-const r@161@12 $Ref)
(set-option :timeout 0)
(push) ; 5
; [eval] (r in res_copy_nodes)
(assert (Set_in r@161@12 res_copy_nodes@98@12))
(pop) ; 5
(declare-fun inv@162@12 ($Ref) $Ref)
(declare-fun img@163@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 5
(assert (not (forall ((r1@161@12 $Ref) (r2@161@12 $Ref)) (!
  (=>
    (and
      (Set_in r1@161@12 res_copy_nodes@98@12)
      (Set_in r2@161@12 res_copy_nodes@98@12)
      (= r1@161@12 r2@161@12))
    (= r1@161@12 r2@161@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((r@161@12 $Ref)) (!
  (=>
    (Set_in r@161@12 res_copy_nodes@98@12)
    (and (= (inv@162@12 r@161@12) r@161@12) (img@163@12 r@161@12)))
  :pattern ((Set_in r@161@12 res_copy_nodes@98@12))
  :pattern ((inv@162@12 r@161@12))
  :pattern ((img@163@12 r@161@12))
  :qid |edges-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@163@12 r) (Set_in (inv@162@12 r) res_copy_nodes@98@12))
    (= (inv@162@12 r) r))
  :pattern ((inv@162@12 r))
  :qid |edges-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@164@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@162@12 r) res_copy_nodes@98@12)
      (img@163@12 r)
      (= r (inv@162@12 r)))
    ($Perm.min
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      $Perm.Write)
    $Perm.No))
(define-fun pTaken@165@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@162@12 r) res_copy_nodes@98@12)
      (img@163@12 r)
      (= r (inv@162@12 r)))
    ($Perm.min
      (ite (= r nodeCopy@86@12) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@164@12 r)))
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
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)
      (pTaken@164@12 r))
    $Perm.No)
  
  :qid |quant-u-71|))))
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
      (Set_in (inv@162@12 r) res_copy_nodes@98@12)
      (img@163@12 r)
      (= r (inv@162@12 r)))
    (= (- $Perm.Write (pTaken@164@12 r)) $Perm.No))
  
  :qid |quant-u-72|))))
(check-sat)
; unknown
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 5
(set-option :timeout 500)
(assert (not (= (- $Perm.Write (pTaken@165@12 nodeCopy@86@12)) $Perm.No)))
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
      (Set_in (inv@162@12 r) res_copy_nodes@98@12)
      (img@163@12 r)
      (= r (inv@162@12 r)))
    (= (- (- $Perm.Write (pTaken@164@12 r)) (pTaken@165@12 r)) $Perm.No))
  
  :qid |quant-u-74|))))
(check-sat)
; unsat
(pop) ; 5
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@166@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@166@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@166@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef43|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@166@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@166@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@90@12  $FVF<edges>) r))
  :qid |qp.fvfValDef44|)))
; Loop head block: Execute statements of loop head block (in invariant state)
(set-option :timeout 0)
(push) ; 5
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (= (inv@129@12 r) r))
  :pattern ((inv@129@12 r))
  :qid |edges-fctOfInv|)))
(assert (forall ((r@128@12 $Ref)) (!
  (=>
    (Set_in r@128@12 res_copy_nodes@107@12)
    (and (= (inv@129@12 r@128@12) r@128@12) (img@130@12 r@128@12)))
  :pattern ((Set_in r@128@12 res_copy_nodes@107@12))
  :pattern ((inv@129@12 r@128@12))
  :pattern ((img@130@12 r@128@12))
  :qid |quant-u-50|)))
(assert (forall ((r@128@12 $Ref)) (!
  (=> (Set_in r@128@12 res_copy_nodes@107@12) (not (= r@128@12 $Ref.null)))
  :pattern ((Set_in r@128@12 res_copy_nodes@107@12))
  :pattern ((inv@129@12 r@128@12))
  :pattern ((img@130@12 r@128@12))
  :qid |edges-permImpliesNonNull|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
    (= (inv@126@12 r) r))
  :pattern ((inv@126@12 r))
  :qid |val-fctOfInv|)))
(assert (forall ((r@125@12 $Ref)) (!
  (=>
    (Set_in r@125@12 res_copy_nodes@107@12)
    (and (= (inv@126@12 r@125@12) r@125@12) (img@127@12 r@125@12)))
  :pattern ((Set_in r@125@12 res_copy_nodes@107@12))
  :pattern ((inv@126@12 r@125@12))
  :pattern ((img@127@12 r@125@12))
  :qid |quant-u-47|)))
(assert (forall ((r@125@12 $Ref)) (!
  (=> (Set_in r@125@12 res_copy_nodes@107@12) (not (= r@125@12 $Ref.null)))
  :pattern ((Set_in r@125@12 res_copy_nodes@107@12))
  :pattern ((inv@126@12 r@125@12))
  :pattern ((img@127@12 r@125@12))
  :qid |val-permImpliesNonNull|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@117@12 r)
      (and (Set_in (inv@116@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@116@12 r) r))
  :pattern ((inv@116@12 r))
  :qid |edges-fctOfInv|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef26|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef27|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@120@12  $FPM) r)
    (+
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@120@12  $FPM) r))
  :qid |qp.resPrmSumDef28|)))
(assert (forall ((x@115@12 $Ref)) (!
  (=>
    (and (Set_in x@115@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@116@12 x@115@12) x@115@12) (img@117@12 x@115@12)))
  :pattern ((Set_in x@115@12 setOfRef@10@12))
  :pattern ((inv@116@12 x@115@12))
  :pattern ((img@117@12 x@115@12))
  :qid |quant-u-45|)))
(assert (forall ((x@115@12 $Ref)) (!
  (<= $Perm.No rd@12@12)
  :pattern ((Set_in x@115@12 setOfRef@10@12))
  :pattern ((inv@116@12 x@115@12))
  :pattern ((img@117@12 x@115@12))
  :qid |edges-permAtLeastZero|)))
(assert (forall ((x@115@12 $Ref)) (!
  (<= rd@12@12 $Perm.Write)
  :pattern ((Set_in x@115@12 setOfRef@10@12))
  :pattern ((inv@116@12 x@115@12))
  :pattern ((img@117@12 x@115@12))
  :qid |edges-permAtMostOne|)))
(assert (forall ((x@115@12 $Ref)) (!
  (=>
    (and (Set_in x@115@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (not (= x@115@12 $Ref.null)))
  :pattern ((Set_in x@115@12 setOfRef@10@12))
  :pattern ((inv@116@12 x@115@12))
  :pattern ((img@117@12 x@115@12))
  :qid |edges-permImpliesNonNull|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))
  $Snap.unit))
(assert (forall ((x@118@12 $Ref)) (!
  (or (not (Set_in x@118@12 setOfRef@10@12)) (Set_in x@118@12 setOfRef@10@12))
  :pattern ((Set_in x@118@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@148@17@148@75-aux|)))
(assert (forall ((x@118@12 $Ref)) (!
  (=>
    (Set_in x@118@12 setOfRef@10@12)
    (=
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) x@118@12)
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) x@118@12)))
  :pattern ((Set_in x@118@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@148@17@148@75|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))
  $Snap.unit))
(assert (forall ((j@121@12 Int)) (!
  (or (not (Set_in j@121@12 S@102@12)) (Set_in j@121@12 S@102@12))
  :pattern ((Set_in j@121@12 S@102@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@149@17@149@83-aux|)))
(assert (forall ((j@121@12 Int)) (!
  (or (not (Set_in j@121@12 S@102@12)) (Set_in j@121@12 S@102@12))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) this@8@12) j@121@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@149@17@149@83-aux|)))
(assert (forall ((j@121@12 Int)) (!
  (=>
    (Set_in j@121@12 S@102@12)
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) this@8@12) j@121@12) setOfRef@10@12))
  :pattern ((Set_in j@121@12 S@102@12))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) this@8@12) j@121@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@149@17@149@83|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))
  $Snap.unit))
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (and
    (or (Set_in r@122@12 setOfRef@10@12) (not (Set_in r@122@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@122@12 setOfRef@10@12)
          (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
      (and
        (Set_in r@122@12 setOfRef@10@12)
        (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
  :pattern ((Set_in r@122@12 setOfRef@10@12) (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (and
    (or (Set_in r@122@12 setOfRef@10@12) (not (Set_in r@122@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@122@12 setOfRef@10@12)
          (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
      (and
        (Set_in r@122@12 setOfRef@10@12)
        (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
  :pattern ((Set_in r@122@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (and
    (or (Set_in r@122@12 setOfRef@10@12) (not (Set_in r@122@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@122@12 setOfRef@10@12)
          (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
      (and
        (Set_in r@122@12 setOfRef@10@12)
        (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
  :pattern ((Set_in r@122@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (and
    (or (Set_in r@122@12 setOfRef@10@12) (not (Set_in r@122@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@122@12 setOfRef@10@12)
          (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
      (and
        (Set_in r@122@12 setOfRef@10@12)
        (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (and
    (or (Set_in r@122@12 setOfRef@10@12) (not (Set_in r@122@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@122@12 setOfRef@10@12)
          (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
      (and
        (Set_in r@122@12 setOfRef@10@12)
        (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (and
    (or (Set_in r@122@12 setOfRef@10@12) (not (Set_in r@122@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@122@12 setOfRef@10@12)
          (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
      (and
        (Set_in r@122@12 setOfRef@10@12)
        (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
  :pattern ((Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (and
    (or (Set_in r@122@12 setOfRef@10@12) (not (Set_in r@122@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@122@12 setOfRef@10@12)
          (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)))))
      (and
        (Set_in r@122@12 setOfRef@10@12)
        (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@122@12 $Ref) (j@123@12 Int)) (!
  (=>
    (and
      (Set_in r@122@12 setOfRef@10@12)
      (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12) setOfRef@10@12))
  :pattern ((Set_in r@122@12 setOfRef@10@12) (Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))
  :pattern ((Set_in r@122@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12))
  :pattern ((Set_in r@122@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12) setOfRef@10@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)) (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12) setOfRef@10@12))
  :pattern ((Set_in j@123@12 (edges_domain<Set<Int>> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r@122@12) j@123@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))
  $Snap.unit))
(assert (Set_subset node_map_image@11@12 res_copy_nodes@107@12))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))
  $Snap.unit))
(assert (= (Set_card (Set_intersection setOfRef@10@12 res_copy_nodes@107@12)) 0))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))))
  $Snap.unit))
(assert (forall ((r@124@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    r@124@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108-aux|)))
(assert (forall ((r@124@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    r@124@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108-aux|)))
(assert (forall ((r@124@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@106@12 r@124@12) res_copy_nodes@107@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108-aux|)))
(assert (forall ((r@124@12 $Ref)) (!
  (=>
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12)
    (Set_in (lookup<Ref> res_node_map@106@12 r@124@12) res_copy_nodes@107@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) r@124@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    r@124@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@106@12 r@124@12) res_copy_nodes@107@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))))))))))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@111@12 r)
      (and (Set_in (inv@110@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@110@12 r) r))
  :pattern ((inv@110@12 r))
  :qid |val-fctOfInv|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef24|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@114@12  $FPM) r)
    (+
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@114@12  $FPM) r))
  :qid |qp.resPrmSumDef25|)))
(assert (forall ((x@109@12 $Ref)) (!
  (=>
    (and (Set_in x@109@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@110@12 x@109@12) x@109@12) (img@111@12 x@109@12)))
  :pattern ((Set_in x@109@12 setOfRef@10@12))
  :pattern ((inv@110@12 x@109@12))
  :pattern ((img@111@12 x@109@12))
  :qid |quant-u-43|)))
(assert (forall ((x@109@12 $Ref)) (!
  (<= $Perm.No rd@12@12)
  :pattern ((Set_in x@109@12 setOfRef@10@12))
  :pattern ((inv@110@12 x@109@12))
  :pattern ((img@111@12 x@109@12))
  :qid |val-permAtLeastZero|)))
(assert (forall ((x@109@12 $Ref)) (!
  (<= rd@12@12 $Perm.Write)
  :pattern ((Set_in x@109@12 setOfRef@10@12))
  :pattern ((inv@110@12 x@109@12))
  :pattern ((img@111@12 x@109@12))
  :qid |val-permAtMostOne|)))
(assert (forall ((x@109@12 $Ref)) (!
  (=>
    (and (Set_in x@109@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (not (= x@109@12 $Ref.null)))
  :pattern ((Set_in x@109@12 setOfRef@10@12))
  :pattern ((inv@110@12 x@109@12))
  :pattern ((img@111@12 x@109@12))
  :qid |val-permImpliesNonNull|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@108@12)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@108@12))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@108@12))))
  $Snap.unit))
(assert (forall ((x@112@12 $Ref)) (!
  (or (not (Set_in x@112@12 setOfRef@10@12)) (Set_in x@112@12 setOfRef@10@12))
  :pattern ((Set_in x@112@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@146@17@146@71-aux|)))
(assert (forall ((x@112@12 $Ref)) (!
  (=>
    (Set_in x@112@12 setOfRef@10@12)
    (=
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) x@112@12)
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) x@112@12)))
  :pattern ((Set_in x@112@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@146@17@146@71|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))
(assert (= $t@108@12 ($Snap.combine ($Snap.first $t@108@12) ($Snap.second $t@108@12))))
(assert (= ($Snap.first $t@108@12) $Snap.unit))
(assert (Set_in nodeCopy@86@12 res_copy_nodes@107@12))
(assert (=
  ($Snap.second $t@108@12)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@108@12))
    ($Snap.second ($Snap.second $t@108@12)))))
(assert (= ($Snap.first ($Snap.second $t@108@12)) $Snap.unit))
(assert (=
  ($Snap.second ($Snap.second $t@108@12))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@108@12)))
    ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))
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
; [eval] |S| > 0
; [eval] |S|
(pop) ; 6
(push) ; 6
; [eval] !(|S| > 0)
; [eval] |S| > 0
; [eval] |S|
(pop) ; 6
; Loop head block: Follow loop-internal edges
; [eval] |S| > 0
; [eval] |S|
(push) ; 6
(set-option :timeout 10)
(assert (not (not (> (Set_card S@102@12) 0))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 10)
(assert (not (> (Set_card S@102@12) 0)))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [then-branch: 27 | |S@102@12| > 0 | live]
; [else-branch: 27 | !(|S@102@12| > 0) | live]
(set-option :timeout 0)
(push) ; 6
; [then-branch: 27 | |S@102@12| > 0]
(assert (> (Set_card S@102@12) 0))
; [exec]
; var newNode: Ref
(declare-const newNode@167@12 $Ref)
; [exec]
; var newResultMap: INodeMap
(declare-const newResultMap@168@12 INodeMap)
; [exec]
; var nodeForId: Ref
(declare-const nodeForId@169@12 $Ref)
; [exec]
; S, i := pop(S)
; [eval] 0 < |s1|
; [eval] |s1|
(push) ; 7
(assert (not (< 0 (Set_card S@102@12))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (< 0 (Set_card S@102@12)))
(declare-const s2@170@12 Set<Int>)
(declare-const i@171@12 Int)
(declare-const $t@172@12 $Snap)
(assert (= $t@172@12 ($Snap.combine ($Snap.first $t@172@12) ($Snap.second $t@172@12))))
(assert (= ($Snap.first $t@172@12) $Snap.unit))
; [eval] (i in s1)
(assert (Set_in i@171@12 S@102@12))
(assert (= ($Snap.second $t@172@12) $Snap.unit))
; [eval] s2 == (s1 setminus Set(i))
; [eval] (s1 setminus Set(i))
; [eval] Set(i)
(assert (Set_equal s2@170@12 (Set_difference S@102@12 (Set_singleton i@171@12))))
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
; [exec]
; nodeForId := edge_lookup(this.edges, i)
; [eval] edge_lookup(this.edges, i)
(declare-const sm@173@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef45|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef46|)))
(declare-const pm@174@12 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@174@12  $FPM) r)
    (+
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@174@12  $FPM) r))
  :qid |qp.resPrmSumDef47|)))
(set-option :timeout 0)
(push) ; 7
(assert (not (< $Perm.No ($FVF.perm_edges (as pm@174@12  $FPM) this@8@12))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(declare-const nodeForId@175@12 $Ref)
(assert (=
  nodeForId@175@12
  (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) this@8@12) i@171@12)))
; [exec]
; newNode, res_node_map, res_copy_nodes := graph_copy_rec(nodeForId, res_node_map,
;   setOfRef, res_copy_nodes, rd / 2)
; [eval] rd / 2
; [eval] none < rd
(push) ; 7
(assert (not (< $Perm.No (/ rd@12@12 (to_real 2)))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (< $Perm.No (/ rd@12@12 (to_real 2))))
; [eval] this != null
(push) ; 7
(assert (not (not (= nodeForId@175@12 $Ref.null))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (not (= nodeForId@175@12 $Ref.null)))
; [eval] (this in setOfRef)
(push) ; 7
(assert (not (Set_in nodeForId@175@12 setOfRef@10@12)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (Set_in nodeForId@175@12 setOfRef@10@12))
; [eval] |(setOfRef intersection node_map_image)| == 0
; [eval] |(setOfRef intersection node_map_image)|
; [eval] (setOfRef intersection node_map_image)
(declare-const x@176@12 $Ref)
(push) ; 7
; [eval] (x in setOfRef)
(assert (Set_in x@176@12 setOfRef@10@12))
(pop) ; 7
(declare-fun inv@177@12 ($Ref) $Ref)
(declare-fun img@178@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 7
(assert (not (forall ((x@176@12 $Ref)) (!
  (=>
    (Set_in x@176@12 setOfRef@10@12)
    (or
      (= (/ rd@12@12 (to_real 2)) $Perm.No)
      (< $Perm.No (/ rd@12@12 (to_real 2)))))
  
  :qid |quant-u-75|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((x1@176@12 $Ref) (x2@176@12 $Ref)) (!
  (=>
    (and
      (and
        (Set_in x1@176@12 setOfRef@10@12)
        (< $Perm.No (/ rd@12@12 (to_real 2))))
      (and
        (Set_in x2@176@12 setOfRef@10@12)
        (< $Perm.No (/ rd@12@12 (to_real 2))))
      (= x1@176@12 x2@176@12))
    (= x1@176@12 x2@176@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@176@12 $Ref)) (!
  (=>
    (and (Set_in x@176@12 setOfRef@10@12) (< $Perm.No (/ rd@12@12 (to_real 2))))
    (and (= (inv@177@12 x@176@12) x@176@12) (img@178@12 x@176@12)))
  :pattern ((Set_in x@176@12 setOfRef@10@12))
  :pattern ((inv@177@12 x@176@12))
  :pattern ((img@178@12 x@176@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@178@12 r)
      (and
        (Set_in (inv@177@12 r) setOfRef@10@12)
        (< $Perm.No (/ rd@12@12 (to_real 2)))))
    (= (inv@177@12 r) r))
  :pattern ((inv@177@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@179@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@177@12 r) setOfRef@10@12)
      (img@178@12 r)
      (= r (inv@177@12 r)))
    ($Perm.min
      (ite
        (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (/ rd@12@12 (to_real 2)))
    $Perm.No))
(define-fun pTaken@180@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@177@12 r) setOfRef@10@12)
      (img@178@12 r)
      (= r (inv@177@12 r)))
    ($Perm.min
      (ite
        (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)
      (- (/ rd@12@12 (to_real 2)) (pTaken@179@12 r)))
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
        (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (pTaken@179@12 r))
    $Perm.No)
  
  :qid |quant-u-77|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@179@12 r) $Perm.No)
  
  :qid |quant-u-78|))))
(check-sat)
; unknown
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
      (Set_in (inv@177@12 r) setOfRef@10@12)
      (img@178@12 r)
      (= r (inv@177@12 r)))
    (= (- (/ rd@12@12 (to_real 2)) (pTaken@179@12 r)) $Perm.No))
  
  :qid |quant-u-79|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@181@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@181@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
  :pattern (($FVF.lookup_val (as sm@181@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
  :qid |qp.fvfValDef48|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_val (as sm@181@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@181@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef49|)))
(declare-const x@182@12 $Ref)
(set-option :timeout 0)
(push) ; 7
; [eval] (x in setOfRef)
(assert (Set_in x@182@12 setOfRef@10@12))
(pop) ; 7
(declare-fun inv@183@12 ($Ref) $Ref)
(declare-fun img@184@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 7
(assert (not (forall ((x@182@12 $Ref)) (!
  (=>
    (Set_in x@182@12 setOfRef@10@12)
    (or
      (= (/ rd@12@12 (to_real 2)) $Perm.No)
      (< $Perm.No (/ rd@12@12 (to_real 2)))))
  
  :qid |quant-u-80|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((x1@182@12 $Ref) (x2@182@12 $Ref)) (!
  (=>
    (and
      (and
        (Set_in x1@182@12 setOfRef@10@12)
        (< $Perm.No (/ rd@12@12 (to_real 2))))
      (and
        (Set_in x2@182@12 setOfRef@10@12)
        (< $Perm.No (/ rd@12@12 (to_real 2))))
      (= x1@182@12 x2@182@12))
    (= x1@182@12 x2@182@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@182@12 $Ref)) (!
  (=>
    (and (Set_in x@182@12 setOfRef@10@12) (< $Perm.No (/ rd@12@12 (to_real 2))))
    (and (= (inv@183@12 x@182@12) x@182@12) (img@184@12 x@182@12)))
  :pattern ((Set_in x@182@12 setOfRef@10@12))
  :pattern ((inv@183@12 x@182@12))
  :pattern ((img@184@12 x@182@12))
  :qid |edges-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@184@12 r)
      (and
        (Set_in (inv@183@12 r) setOfRef@10@12)
        (< $Perm.No (/ rd@12@12 (to_real 2)))))
    (= (inv@183@12 r) r))
  :pattern ((inv@183@12 r))
  :qid |edges-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@185@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@183@12 r) setOfRef@10@12)
      (img@184@12 r)
      (= r (inv@183@12 r)))
    ($Perm.min
      (ite
        (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)
      (/ rd@12@12 (to_real 2)))
    $Perm.No))
(define-fun pTaken@186@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@183@12 r) setOfRef@10@12)
      (img@184@12 r)
      (= r (inv@183@12 r)))
    ($Perm.min
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (- (/ rd@12@12 (to_real 2)) (pTaken@185@12 r)))
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
        (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)
      (pTaken@185@12 r))
    $Perm.No)
  
  :qid |quant-u-82|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@185@12 r) $Perm.No)
  
  :qid |quant-u-83|))))
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
      (Set_in (inv@183@12 r) setOfRef@10@12)
      (img@184@12 r)
      (= r (inv@183@12 r)))
    (= (- (/ rd@12@12 (to_real 2)) (pTaken@185@12 r)) $Perm.No))
  
  :qid |quant-u-84|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (pTaken@186@12 r))
    $Perm.No)
  
  :qid |quant-u-85|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@186@12 r) $Perm.No)
  
  :qid |quant-u-86|))))
(check-sat)
; unknown
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
      (Set_in (inv@183@12 r) setOfRef@10@12)
      (img@184@12 r)
      (= r (inv@183@12 r)))
    (=
      (- (- (/ rd@12@12 (to_real 2)) (pTaken@185@12 r)) (pTaken@186@12 r))
      $Perm.No))
  
  :qid |quant-u-87|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@187@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@187@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@187@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef50|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@187@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@187@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef51|)))
; [eval] (forall x: Ref, i: Int :: { (x in setOfRef), (i in edges_domain(x.edges)) } { (x in setOfRef), edge_lookup(x.edges, i) } { (x in setOfRef), (edge_lookup(x.edges, i) in setOfRef) } { edges_domain(x.edges), edge_lookup(x.edges, i) } { edges_domain(x.edges), (edge_lookup(x.edges, i) in setOfRef) } { (i in edges_domain(x.edges)) } { (edge_lookup(x.edges, i) in setOfRef) } (x in setOfRef) && (i in edges_domain(x.edges)) ==> (edge_lookup(x.edges, i) in setOfRef))
(declare-const x@188@12 $Ref)
(declare-const i@189@12 Int)
(set-option :timeout 0)
(push) ; 7
; [eval] (x in setOfRef) && (i in edges_domain(x.edges)) ==> (edge_lookup(x.edges, i) in setOfRef)
; [eval] (x in setOfRef) && (i in edges_domain(x.edges))
; [eval] (x in setOfRef)
(push) ; 8
; [then-branch: 28 | !(x@188@12 in setOfRef@10@12) | live]
; [else-branch: 28 | x@188@12 in setOfRef@10@12 | live]
(push) ; 9
; [then-branch: 28 | !(x@188@12 in setOfRef@10@12)]
(assert (not (Set_in x@188@12 setOfRef@10@12)))
(pop) ; 9
(push) ; 9
; [else-branch: 28 | x@188@12 in setOfRef@10@12]
(assert (Set_in x@188@12 setOfRef@10@12))
; [eval] (i in edges_domain(x.edges))
; [eval] edges_domain(x.edges)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
    :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
    :qid |qp.fvfValDef45|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
      (=
        ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
    :qid |qp.fvfValDef46|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@117@12 x@188@12) (Set_in (inv@116@12 x@188@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and
        (img@130@12 x@188@12)
        (Set_in (inv@129@12 x@188@12) res_copy_nodes@107@12))
      $Perm.Write
      $Perm.No)))))
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
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef45|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef46|)))
(assert (or (Set_in x@188@12 setOfRef@10@12) (not (Set_in x@188@12 setOfRef@10@12))))
(push) ; 8
; [then-branch: 29 | x@188@12 in setOfRef@10@12 && i@189@12 in edges_domain[Set[Int]](Lookup(edges, sm@173@12, x@188@12)) | live]
; [else-branch: 29 | !(x@188@12 in setOfRef@10@12 && i@189@12 in edges_domain[Set[Int]](Lookup(edges, sm@173@12, x@188@12))) | live]
(push) ; 9
; [then-branch: 29 | x@188@12 in setOfRef@10@12 && i@189@12 in edges_domain[Set[Int]](Lookup(edges, sm@173@12, x@188@12))]
(assert (and
  (Set_in x@188@12 setOfRef@10@12)
  (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12)))))
; [eval] (edge_lookup(x.edges, i) in setOfRef)
; [eval] edge_lookup(x.edges, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
    :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
    :qid |qp.fvfValDef45|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
      (=
        ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
    :qid |qp.fvfValDef46|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@117@12 x@188@12) (Set_in (inv@116@12 x@188@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and
        (img@130@12 x@188@12)
        (Set_in (inv@129@12 x@188@12) res_copy_nodes@107@12))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 29 | !(x@188@12 in setOfRef@10@12 && i@189@12 in edges_domain[Set[Int]](Lookup(edges, sm@173@12, x@188@12)))]
(assert (not
  (and
    (Set_in x@188@12 setOfRef@10@12)
    (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))))
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef45|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef46|)))
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in x@188@12 setOfRef@10@12)
      (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12)))))
  (and
    (Set_in x@188@12 setOfRef@10@12)
    (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef45|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef46|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@188@12 $Ref) (i@189@12 Int)) (!
  (and
    (or (Set_in x@188@12 setOfRef@10@12) (not (Set_in x@188@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@188@12 setOfRef@10@12)
          (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12)))))
      (and
        (Set_in x@188@12 setOfRef@10@12)
        (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))))
  :pattern ((Set_in x@188@12 setOfRef@10@12) (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120-aux|)))
(assert (forall ((x@188@12 $Ref) (i@189@12 Int)) (!
  (and
    (or (Set_in x@188@12 setOfRef@10@12) (not (Set_in x@188@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@188@12 setOfRef@10@12)
          (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12)))))
      (and
        (Set_in x@188@12 setOfRef@10@12)
        (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))))
  :pattern ((Set_in x@188@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120-aux|)))
(assert (forall ((x@188@12 $Ref) (i@189@12 Int)) (!
  (and
    (or (Set_in x@188@12 setOfRef@10@12) (not (Set_in x@188@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@188@12 setOfRef@10@12)
          (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12)))))
      (and
        (Set_in x@188@12 setOfRef@10@12)
        (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))))
  :pattern ((Set_in x@188@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120-aux|)))
(assert (forall ((x@188@12 $Ref) (i@189@12 Int)) (!
  (and
    (or (Set_in x@188@12 setOfRef@10@12) (not (Set_in x@188@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@188@12 setOfRef@10@12)
          (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12)))))
      (and
        (Set_in x@188@12 setOfRef@10@12)
        (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120-aux|)))
(assert (forall ((x@188@12 $Ref) (i@189@12 Int)) (!
  (and
    (or (Set_in x@188@12 setOfRef@10@12) (not (Set_in x@188@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@188@12 setOfRef@10@12)
          (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12)))))
      (and
        (Set_in x@188@12 setOfRef@10@12)
        (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120-aux|)))
(assert (forall ((x@188@12 $Ref) (i@189@12 Int)) (!
  (and
    (or (Set_in x@188@12 setOfRef@10@12) (not (Set_in x@188@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@188@12 setOfRef@10@12)
          (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12)))))
      (and
        (Set_in x@188@12 setOfRef@10@12)
        (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))))
  :pattern ((Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120-aux|)))
(assert (forall ((x@188@12 $Ref) (i@189@12 Int)) (!
  (and
    (or (Set_in x@188@12 setOfRef@10@12) (not (Set_in x@188@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@188@12 setOfRef@10@12)
          (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12)))))
      (and
        (Set_in x@188@12 setOfRef@10@12)
        (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120-aux|)))
(push) ; 7
(assert (not (forall ((x@188@12 $Ref) (i@189@12 Int)) (!
  (=>
    (and
      (Set_in x@188@12 setOfRef@10@12)
      (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12) setOfRef@10@12))
  :pattern ((Set_in x@188@12 setOfRef@10@12) (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))
  :pattern ((Set_in x@188@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12))
  :pattern ((Set_in x@188@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12) setOfRef@10@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12) setOfRef@10@12))
  :pattern ((Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (forall ((x@188@12 $Ref) (i@189@12 Int)) (!
  (=>
    (and
      (Set_in x@188@12 setOfRef@10@12)
      (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12) setOfRef@10@12))
  :pattern ((Set_in x@188@12 setOfRef@10@12) (Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))
  :pattern ((Set_in x@188@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12))
  :pattern ((Set_in x@188@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12) setOfRef@10@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12) setOfRef@10@12))
  :pattern ((Set_in i@189@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@188@12) i@189@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@98@12@98@120|)))
; [eval] (forall x: Ref :: { (x in map_domain(node_map)) } { (lookup(node_map, x) in node_map_image) } (x in map_domain(node_map)) ==> (lookup(node_map, x) in node_map_image))
(declare-const x@190@12 $Ref)
(push) ; 7
; [eval] (x in map_domain(node_map)) ==> (lookup(node_map, x) in node_map_image)
; [eval] (x in map_domain(node_map))
; [eval] map_domain(node_map)
(push) ; 8
; [then-branch: 30 | x@190@12 in map_domain[Seq[Ref]](res_node_map@106@12) | live]
; [else-branch: 30 | !(x@190@12 in map_domain[Seq[Ref]](res_node_map@106@12)) | live]
(push) ; 9
; [then-branch: 30 | x@190@12 in map_domain[Seq[Ref]](res_node_map@106@12)]
(assert (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@190@12))
; [eval] (lookup(node_map, x) in node_map_image)
; [eval] lookup(node_map, x)
(pop) ; 9
(push) ; 9
; [else-branch: 30 | !(x@190@12 in map_domain[Seq[Ref]](res_node_map@106@12))]
(assert (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@190@12)))
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or
  (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@190@12))
  (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@190@12)))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@190@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@190@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@190@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@190@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    x@190@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@100@12@100@96-aux|)))
(assert (forall ((x@190@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@190@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@190@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    x@190@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@100@12@100@96-aux|)))
(assert (forall ((x@190@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@190@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@190@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@106@12 x@190@12) res_copy_nodes@107@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@100@12@100@96-aux|)))
(push) ; 7
(assert (not (forall ((x@190@12 $Ref)) (!
  (=>
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@190@12)
    (Set_in (lookup<Ref> res_node_map@106@12 x@190@12) res_copy_nodes@107@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@190@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    x@190@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    x@190@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@106@12 x@190@12) res_copy_nodes@107@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@100@12@100@96|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (forall ((x@190@12 $Ref)) (!
  (=>
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@190@12)
    (Set_in (lookup<Ref> res_node_map@106@12 x@190@12) res_copy_nodes@107@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@190@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    x@190@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@106@12 x@190@12) res_copy_nodes@107@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@100@12@100@96|)))
(declare-const x@191@12 $Ref)
(push) ; 7
; [eval] (x in node_map_image)
(assert (Set_in x@191@12 res_copy_nodes@107@12))
(pop) ; 7
(declare-fun inv@192@12 ($Ref) $Ref)
(declare-fun img@193@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((x1@191@12 $Ref) (x2@191@12 $Ref)) (!
  (=>
    (and
      (Set_in x1@191@12 res_copy_nodes@107@12)
      (Set_in x2@191@12 res_copy_nodes@107@12)
      (= x1@191@12 x2@191@12))
    (= x1@191@12 x2@191@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@191@12 $Ref)) (!
  (=>
    (Set_in x@191@12 res_copy_nodes@107@12)
    (and (= (inv@192@12 x@191@12) x@191@12) (img@193@12 x@191@12)))
  :pattern ((Set_in x@191@12 res_copy_nodes@107@12))
  :pattern ((inv@192@12 x@191@12))
  :pattern ((img@193@12 x@191@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@193@12 r) (Set_in (inv@192@12 r) res_copy_nodes@107@12))
    (= (inv@192@12 r) r))
  :pattern ((inv@192@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@194@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@192@12 r) res_copy_nodes@107@12)
      (img@193@12 r)
      (= r (inv@192@12 r)))
    ($Perm.min
      (ite
        (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@179@12 r))
        $Perm.No)
      $Perm.Write)
    $Perm.No))
(define-fun pTaken@195@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@192@12 r) res_copy_nodes@107@12)
      (img@193@12 r)
      (= r (inv@192@12 r)))
    ($Perm.min
      (ite
        (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)
      (- $Perm.Write (pTaken@194@12 r)))
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
        (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@179@12 r))
        $Perm.No)
      (pTaken@194@12 r))
    $Perm.No)
  
  :qid |quant-u-90|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@194@12 r) $Perm.No)
  
  :qid |quant-u-91|))))
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
      (Set_in (inv@192@12 r) res_copy_nodes@107@12)
      (img@193@12 r)
      (= r (inv@192@12 r)))
    (= (- $Perm.Write (pTaken@194@12 r)) $Perm.No))
  
  :qid |quant-u-92|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)
      (pTaken@195@12 r))
    $Perm.No)
  
  :qid |quant-u-93|))))
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
      (Set_in (inv@192@12 r) res_copy_nodes@107@12)
      (img@193@12 r)
      (= r (inv@192@12 r)))
    (= (- (- $Perm.Write (pTaken@194@12 r)) (pTaken@195@12 r)) $Perm.No))
  
  :qid |quant-u-94|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@196@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@179@12 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@196@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
  :pattern (($FVF.lookup_val (as sm@196@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
  :qid |qp.fvfValDef52|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_val (as sm@196@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@196@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef53|)))
(declare-const x@197@12 $Ref)
(set-option :timeout 0)
(push) ; 7
; [eval] (x in node_map_image)
(assert (Set_in x@197@12 res_copy_nodes@107@12))
(pop) ; 7
(declare-fun inv@198@12 ($Ref) $Ref)
(declare-fun img@199@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((x1@197@12 $Ref) (x2@197@12 $Ref)) (!
  (=>
    (and
      (Set_in x1@197@12 res_copy_nodes@107@12)
      (Set_in x2@197@12 res_copy_nodes@107@12)
      (= x1@197@12 x2@197@12))
    (= x1@197@12 x2@197@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@197@12 $Ref)) (!
  (=>
    (Set_in x@197@12 res_copy_nodes@107@12)
    (and (= (inv@198@12 x@197@12) x@197@12) (img@199@12 x@197@12)))
  :pattern ((Set_in x@197@12 res_copy_nodes@107@12))
  :pattern ((inv@198@12 x@197@12))
  :pattern ((img@199@12 x@197@12))
  :qid |edges-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@199@12 r) (Set_in (inv@198@12 r) res_copy_nodes@107@12))
    (= (inv@198@12 r) r))
  :pattern ((inv@198@12 r))
  :qid |edges-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@200@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@198@12 r) res_copy_nodes@107@12)
      (img@199@12 r)
      (= r (inv@198@12 r)))
    ($Perm.min
      (ite
        (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)
      $Perm.Write)
    $Perm.No))
(define-fun pTaken@201@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@198@12 r) res_copy_nodes@107@12)
      (img@199@12 r)
      (= r (inv@198@12 r)))
    ($Perm.min
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@186@12 r))
        $Perm.No)
      (- $Perm.Write (pTaken@200@12 r)))
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
        (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)
      (pTaken@200@12 r))
    $Perm.No)
  
  :qid |quant-u-97|))))
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
      (Set_in (inv@198@12 r) res_copy_nodes@107@12)
      (img@199@12 r)
      (= r (inv@198@12 r)))
    (= (- $Perm.Write (pTaken@200@12 r)) $Perm.No))
  
  :qid |quant-u-98|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@202@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@202@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@202@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef54|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@202@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@202@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef55|)))
(declare-const nodeCopy@203@12 $Ref)
(declare-const res_node_map@204@12 INodeMap)
(declare-const res_copy_nodes@205@12 Set<$Ref>)
(declare-const $t@206@12 $Snap)
(assert (= $t@206@12 ($Snap.combine ($Snap.first $t@206@12) ($Snap.second $t@206@12))))
(assert (= ($Snap.first $t@206@12) $Snap.unit))
; [eval] nodeCopy != null
(assert (not (= nodeCopy@203@12 $Ref.null)))
(assert (=
  ($Snap.second $t@206@12)
  ($Snap.combine
    ($Snap.first ($Snap.second $t@206@12))
    ($Snap.second ($Snap.second $t@206@12)))))
(assert (= ($Snap.first ($Snap.second $t@206@12)) $Snap.unit))
; [eval] (nodeCopy in res_copy_nodes)
(assert (Set_in nodeCopy@203@12 res_copy_nodes@205@12))
(assert (=
  ($Snap.second ($Snap.second $t@206@12))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second $t@206@12)))
    ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))
(assert (= ($Snap.first ($Snap.second ($Snap.second $t@206@12))) $Snap.unit))
; [eval] |(setOfRef intersection res_copy_nodes)| == 0
; [eval] |(setOfRef intersection res_copy_nodes)|
; [eval] (setOfRef intersection res_copy_nodes)
(assert (= (Set_card (Set_intersection setOfRef@10@12 res_copy_nodes@205@12)) 0))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second $t@206@12)))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@206@12))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))
(declare-const x@207@12 $Ref)
(set-option :timeout 0)
(push) ; 7
; [eval] (x in setOfRef)
(assert (Set_in x@207@12 setOfRef@10@12))
(pop) ; 7
(declare-fun inv@208@12 ($Ref) $Ref)
(declare-fun img@209@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 7
(assert (not (forall ((x@207@12 $Ref)) (!
  (=>
    (Set_in x@207@12 setOfRef@10@12)
    (or
      (= (/ rd@12@12 (to_real 2)) $Perm.No)
      (< $Perm.No (/ rd@12@12 (to_real 2)))))
  
  :qid |quant-u-99|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((x1@207@12 $Ref) (x2@207@12 $Ref)) (!
  (=>
    (and
      (and
        (Set_in x1@207@12 setOfRef@10@12)
        (< $Perm.No (/ rd@12@12 (to_real 2))))
      (and
        (Set_in x2@207@12 setOfRef@10@12)
        (< $Perm.No (/ rd@12@12 (to_real 2))))
      (= x1@207@12 x2@207@12))
    (= x1@207@12 x2@207@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@207@12 $Ref)) (!
  (=>
    (and (Set_in x@207@12 setOfRef@10@12) (< $Perm.No (/ rd@12@12 (to_real 2))))
    (and (= (inv@208@12 x@207@12) x@207@12) (img@209@12 x@207@12)))
  :pattern ((Set_in x@207@12 setOfRef@10@12))
  :pattern ((inv@208@12 x@207@12))
  :pattern ((img@209@12 x@207@12))
  :qid |quant-u-100|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@209@12 r)
      (and
        (Set_in (inv@208@12 r) setOfRef@10@12)
        (< $Perm.No (/ rd@12@12 (to_real 2)))))
    (= (inv@208@12 r) r))
  :pattern ((inv@208@12 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
(assert (forall ((x@207@12 $Ref)) (!
  (<= $Perm.No (/ rd@12@12 (to_real 2)))
  :pattern ((Set_in x@207@12 setOfRef@10@12))
  :pattern ((inv@208@12 x@207@12))
  :pattern ((img@209@12 x@207@12))
  :qid |val-permAtLeastZero|)))
; Field permissions are at most one
(assert (forall ((x@207@12 $Ref)) (!
  (<= (/ rd@12@12 (to_real 2)) $Perm.Write)
  :pattern ((Set_in x@207@12 setOfRef@10@12))
  :pattern ((inv@208@12 x@207@12))
  :pattern ((img@209@12 x@207@12))
  :qid |val-permAtMostOne|)))
; Permission implies non-null receiver
(assert (forall ((x@207@12 $Ref)) (!
  (=>
    (and (Set_in x@207@12 setOfRef@10@12) (< $Perm.No (/ rd@12@12 (to_real 2))))
    (not (= x@207@12 $Ref.null)))
  :pattern ((Set_in x@207@12 setOfRef@10@12))
  :pattern ((inv@208@12 x@207@12))
  :pattern ((img@209@12 x@207@12))
  :qid |val-permImpliesNonNull|)))
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= x@207@12 x@109@12)
    (=
      (and (img@209@12 r) (Set_in (inv@208@12 r) setOfRef@10@12))
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))))
  
  :qid |quant-u-101|))))
(check-sat)
; unknown
(pop) ; 7
; 0.01s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))
  $Snap.unit))
; [eval] (forall x: Ref :: { (x in setOfRef) } (x in setOfRef) ==> x.val == old(x.val))
(declare-const x@210@12 $Ref)
(set-option :timeout 0)
(push) ; 7
; [eval] (x in setOfRef) ==> x.val == old(x.val)
; [eval] (x in setOfRef)
(push) ; 8
; [then-branch: 31 | x@210@12 in setOfRef@10@12 | live]
; [else-branch: 31 | !(x@210@12 in setOfRef@10@12) | live]
(push) ; 9
; [then-branch: 31 | x@210@12 in setOfRef@10@12]
(assert (Set_in x@210@12 setOfRef@10@12))
; [eval] x.val == old(x.val)
(declare-const sm@211@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@179@12 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@211@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
  :pattern (($FVF.lookup_val (as sm@211@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
  :qid |qp.fvfValDef56|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@209@12 r) (Set_in (inv@208@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_val (as sm@211@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@206@12))))) r)))
  :pattern (($FVF.lookup_val (as sm@211@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@206@12))))) r))
  :qid |qp.fvfValDef57|)))
(declare-const pm@212@12 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@212@12  $FPM) r)
    (+
      (ite
        (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@179@12 r))
        $Perm.No)
      (ite
        (and (img@209@12 r) (Set_in (inv@208@12 r) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@212@12  $FPM) r))
  :qid |qp.resPrmSumDef58|)))
(push) ; 10
(assert (not (< $Perm.No ($FVF.perm_val (as pm@212@12  $FPM) x@210@12))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [eval] old(x.val)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_val (as sm@181@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
    :pattern (($FVF.lookup_val (as sm@181@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
    :qid |qp.fvfValDef48|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
      (=
        ($FVF.lookup_val (as sm@181@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
    :pattern (($FVF.lookup_val (as sm@181@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
    :qid |qp.fvfValDef49|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@111@12 x@210@12) (Set_in (inv@110@12 x@210@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and
        (img@127@12 x@210@12)
        (Set_in (inv@126@12 x@210@12) res_copy_nodes@107@12))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 31 | !(x@210@12 in setOfRef@10@12)]
(assert (not (Set_in x@210@12 setOfRef@10@12)))
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@179@12 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@211@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
  :pattern (($FVF.lookup_val (as sm@211@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
  :qid |qp.fvfValDef56|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@209@12 r) (Set_in (inv@208@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_val (as sm@211@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@206@12))))) r)))
  :pattern (($FVF.lookup_val (as sm@211@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@206@12))))) r))
  :qid |qp.fvfValDef57|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@212@12  $FPM) r)
    (+
      (ite
        (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@179@12 r))
        $Perm.No)
      (ite
        (and (img@209@12 r) (Set_in (inv@208@12 r) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@212@12  $FPM) r))
  :qid |qp.resPrmSumDef58|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@181@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
  :pattern (($FVF.lookup_val (as sm@181@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
  :qid |qp.fvfValDef48|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_val (as sm@181@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@181@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef49|)))
; Joined path conditions
(assert (or (not (Set_in x@210@12 setOfRef@10@12)) (Set_in x@210@12 setOfRef@10@12)))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@179@12 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@211@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
  :pattern (($FVF.lookup_val (as sm@211@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
  :qid |qp.fvfValDef56|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@209@12 r) (Set_in (inv@208@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_val (as sm@211@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@206@12))))) r)))
  :pattern (($FVF.lookup_val (as sm@211@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@206@12))))) r))
  :qid |qp.fvfValDef57|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_val (as pm@212@12  $FPM) r)
    (+
      (ite
        (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@179@12 r))
        $Perm.No)
      (ite
        (and (img@209@12 r) (Set_in (inv@208@12 r) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No)))
  :pattern (($FVF.perm_val (as pm@212@12  $FPM) r))
  :qid |qp.resPrmSumDef58|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@181@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
  :pattern (($FVF.lookup_val (as sm@181@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
  :qid |qp.fvfValDef48|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_val (as sm@181@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@181@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef49|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@210@12 $Ref)) (!
  (or (not (Set_in x@210@12 setOfRef@10@12)) (Set_in x@210@12 setOfRef@10@12))
  :pattern ((Set_in x@210@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@107@11@107@65-aux|)))
(assert (forall ((x@210@12 $Ref)) (!
  (=>
    (Set_in x@210@12 setOfRef@10@12)
    (=
      ($FVF.lookup_val (as sm@211@12  $FVF<val>) x@210@12)
      ($FVF.lookup_val (as sm@181@12  $FVF<val>) x@210@12)))
  :pattern ((Set_in x@210@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@107@11@107@65|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))
(declare-const x@213@12 $Ref)
(push) ; 7
; [eval] (x in setOfRef)
(assert (Set_in x@213@12 setOfRef@10@12))
(pop) ; 7
(declare-fun inv@214@12 ($Ref) $Ref)
(declare-fun img@215@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 7
(assert (not (forall ((x@213@12 $Ref)) (!
  (=>
    (Set_in x@213@12 setOfRef@10@12)
    (or
      (= (/ rd@12@12 (to_real 2)) $Perm.No)
      (< $Perm.No (/ rd@12@12 (to_real 2)))))
  
  :qid |quant-u-102|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((x1@213@12 $Ref) (x2@213@12 $Ref)) (!
  (=>
    (and
      (and
        (Set_in x1@213@12 setOfRef@10@12)
        (< $Perm.No (/ rd@12@12 (to_real 2))))
      (and
        (Set_in x2@213@12 setOfRef@10@12)
        (< $Perm.No (/ rd@12@12 (to_real 2))))
      (= x1@213@12 x2@213@12))
    (= x1@213@12 x2@213@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@213@12 $Ref)) (!
  (=>
    (and (Set_in x@213@12 setOfRef@10@12) (< $Perm.No (/ rd@12@12 (to_real 2))))
    (and (= (inv@214@12 x@213@12) x@213@12) (img@215@12 x@213@12)))
  :pattern ((Set_in x@213@12 setOfRef@10@12))
  :pattern ((inv@214@12 x@213@12))
  :pattern ((img@215@12 x@213@12))
  :qid |quant-u-103|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@215@12 r)
      (and
        (Set_in (inv@214@12 r) setOfRef@10@12)
        (< $Perm.No (/ rd@12@12 (to_real 2)))))
    (= (inv@214@12 r) r))
  :pattern ((inv@214@12 r))
  :qid |edges-fctOfInv|)))
; Permissions are non-negative
(assert (forall ((x@213@12 $Ref)) (!
  (<= $Perm.No (/ rd@12@12 (to_real 2)))
  :pattern ((Set_in x@213@12 setOfRef@10@12))
  :pattern ((inv@214@12 x@213@12))
  :pattern ((img@215@12 x@213@12))
  :qid |edges-permAtLeastZero|)))
; Field permissions are at most one
(assert (forall ((x@213@12 $Ref)) (!
  (<= (/ rd@12@12 (to_real 2)) $Perm.Write)
  :pattern ((Set_in x@213@12 setOfRef@10@12))
  :pattern ((inv@214@12 x@213@12))
  :pattern ((img@215@12 x@213@12))
  :qid |edges-permAtMostOne|)))
; Permission implies non-null receiver
(assert (forall ((x@213@12 $Ref)) (!
  (=>
    (and (Set_in x@213@12 setOfRef@10@12) (< $Perm.No (/ rd@12@12 (to_real 2))))
    (not (= x@213@12 $Ref.null)))
  :pattern ((Set_in x@213@12 setOfRef@10@12))
  :pattern ((inv@214@12 x@213@12))
  :pattern ((img@215@12 x@213@12))
  :qid |edges-permImpliesNonNull|)))
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= x@213@12 x@115@12)
    (=
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))))
  
  :qid |quant-u-104|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))
  $Snap.unit))
; [eval] (forall x: Ref :: { (x in setOfRef) } (x in setOfRef) ==> x.edges == old(x.edges))
(declare-const x@216@12 $Ref)
(set-option :timeout 0)
(push) ; 7
; [eval] (x in setOfRef) ==> x.edges == old(x.edges)
; [eval] (x in setOfRef)
(push) ; 8
; [then-branch: 32 | x@216@12 in setOfRef@10@12 | live]
; [else-branch: 32 | !(x@216@12 in setOfRef@10@12) | live]
(push) ; 9
; [then-branch: 32 | x@216@12 in setOfRef@10@12]
(assert (Set_in x@216@12 setOfRef@10@12))
; [eval] x.edges == old(x.edges)
(declare-const sm@217@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef59|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef60|)))
(declare-const pm@218@12 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@218@12  $FPM) r)
    (+
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@186@12 r))
        $Perm.No)
      (ite
        (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@218@12  $FPM) r))
  :qid |qp.resPrmSumDef61|)))
(push) ; 10
(assert (not (< $Perm.No ($FVF.perm_edges (as pm@218@12  $FPM) x@216@12))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [eval] old(x.edges)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
    :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
    :qid |qp.fvfValDef45|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
      (=
        ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
    :qid |qp.fvfValDef46|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@117@12 x@216@12) (Set_in (inv@116@12 x@216@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and
        (img@130@12 x@216@12)
        (Set_in (inv@129@12 x@216@12) res_copy_nodes@107@12))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 32 | !(x@216@12 in setOfRef@10@12)]
(assert (not (Set_in x@216@12 setOfRef@10@12)))
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef59|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef60|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@218@12  $FPM) r)
    (+
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@186@12 r))
        $Perm.No)
      (ite
        (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@218@12  $FPM) r))
  :qid |qp.resPrmSumDef61|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef45|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef46|)))
; Joined path conditions
(assert (or (not (Set_in x@216@12 setOfRef@10@12)) (Set_in x@216@12 setOfRef@10@12)))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef59|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef60|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@218@12  $FPM) r)
    (+
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@186@12 r))
        $Perm.No)
      (ite
        (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@218@12  $FPM) r))
  :qid |qp.resPrmSumDef61|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef45|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@173@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef46|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@216@12 $Ref)) (!
  (or (not (Set_in x@216@12 setOfRef@10@12)) (Set_in x@216@12 setOfRef@10@12))
  :pattern ((Set_in x@216@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@109@11@109@69-aux|)))
(assert (forall ((x@216@12 $Ref)) (!
  (=>
    (Set_in x@216@12 setOfRef@10@12)
    (=
      ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@216@12)
      ($FVF.lookup_edges (as sm@173@12  $FVF<edges>) x@216@12)))
  :pattern ((Set_in x@216@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@109@11@109@69|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))))
  $Snap.unit))
; [eval] (forall x: Ref, i: Int :: { (x in setOfRef), (i in edges_domain(x.edges)) } { (x in setOfRef), edge_lookup(x.edges, i) } { (x in setOfRef), (edge_lookup(x.edges, i) in setOfRef) } { edges_domain(x.edges), edge_lookup(x.edges, i) } { edges_domain(x.edges), (edge_lookup(x.edges, i) in setOfRef) } { (i in edges_domain(x.edges)) } { (edge_lookup(x.edges, i) in setOfRef) } (x in setOfRef) && (i in edges_domain(x.edges)) ==> (edge_lookup(x.edges, i) in setOfRef))
(declare-const x@219@12 $Ref)
(declare-const i@220@12 Int)
(push) ; 7
; [eval] (x in setOfRef) && (i in edges_domain(x.edges)) ==> (edge_lookup(x.edges, i) in setOfRef)
; [eval] (x in setOfRef) && (i in edges_domain(x.edges))
; [eval] (x in setOfRef)
(push) ; 8
; [then-branch: 33 | !(x@219@12 in setOfRef@10@12) | live]
; [else-branch: 33 | x@219@12 in setOfRef@10@12 | live]
(push) ; 9
; [then-branch: 33 | !(x@219@12 in setOfRef@10@12)]
(assert (not (Set_in x@219@12 setOfRef@10@12)))
(pop) ; 9
(push) ; 9
; [else-branch: 33 | x@219@12 in setOfRef@10@12]
(assert (Set_in x@219@12 setOfRef@10@12))
; [eval] (i in edges_domain(x.edges))
; [eval] edges_domain(x.edges)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
        false)
      (=
        ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
    :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
    :qid |qp.fvfValDef59|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
        (< $Perm.No (/ rd@12@12 (to_real 2)))
        false)
      (=
        ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
    :qid |qp.fvfValDef60|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@117@12 x@219@12) (Set_in (inv@116@12 x@219@12) setOfRef@10@12))
      (- rd@12@12 (pTaken@186@12 x@219@12))
      $Perm.No)
    (ite
      (and (img@215@12 x@219@12) (Set_in (inv@214@12 x@219@12) setOfRef@10@12))
      (/ rd@12@12 (to_real 2))
      $Perm.No)))))
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
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef59|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef60|)))
(assert (or (Set_in x@219@12 setOfRef@10@12) (not (Set_in x@219@12 setOfRef@10@12))))
(push) ; 8
; [then-branch: 34 | x@219@12 in setOfRef@10@12 && i@220@12 in edges_domain[Set[Int]](Lookup(edges, sm@217@12, x@219@12)) | live]
; [else-branch: 34 | !(x@219@12 in setOfRef@10@12 && i@220@12 in edges_domain[Set[Int]](Lookup(edges, sm@217@12, x@219@12))) | live]
(push) ; 9
; [then-branch: 34 | x@219@12 in setOfRef@10@12 && i@220@12 in edges_domain[Set[Int]](Lookup(edges, sm@217@12, x@219@12))]
(assert (and
  (Set_in x@219@12 setOfRef@10@12)
  (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12)))))
; [eval] (edge_lookup(x.edges, i) in setOfRef)
; [eval] edge_lookup(x.edges, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
        false)
      (=
        ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
    :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
    :qid |qp.fvfValDef59|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
        (< $Perm.No (/ rd@12@12 (to_real 2)))
        false)
      (=
        ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
    :qid |qp.fvfValDef60|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@117@12 x@219@12) (Set_in (inv@116@12 x@219@12) setOfRef@10@12))
      (- rd@12@12 (pTaken@186@12 x@219@12))
      $Perm.No)
    (ite
      (and (img@215@12 x@219@12) (Set_in (inv@214@12 x@219@12) setOfRef@10@12))
      (/ rd@12@12 (to_real 2))
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 34 | !(x@219@12 in setOfRef@10@12 && i@220@12 in edges_domain[Set[Int]](Lookup(edges, sm@217@12, x@219@12)))]
(assert (not
  (and
    (Set_in x@219@12 setOfRef@10@12)
    (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12))))))
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef59|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef60|)))
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in x@219@12 setOfRef@10@12)
      (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12)))))
  (and
    (Set_in x@219@12 setOfRef@10@12)
    (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12))))))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef59|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@217@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef60|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@219@12 $Ref) (i@220@12 Int)) (!
  (and
    (or (Set_in x@219@12 setOfRef@10@12) (not (Set_in x@219@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@219@12 setOfRef@10@12)
          (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12)))))
      (and
        (Set_in x@219@12 setOfRef@10@12)
        (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12))))))
  :pattern ((Set_in x@219@12 setOfRef@10@12) (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@219@12 $Ref) (i@220@12 Int)) (!
  (and
    (or (Set_in x@219@12 setOfRef@10@12) (not (Set_in x@219@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@219@12 setOfRef@10@12)
          (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12)))))
      (and
        (Set_in x@219@12 setOfRef@10@12)
        (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12))))))
  :pattern ((Set_in x@219@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12) i@220@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@219@12 $Ref) (i@220@12 Int)) (!
  (and
    (or (Set_in x@219@12 setOfRef@10@12) (not (Set_in x@219@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@219@12 setOfRef@10@12)
          (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12)))))
      (and
        (Set_in x@219@12 setOfRef@10@12)
        (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12))))))
  :pattern ((Set_in x@219@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12) i@220@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@219@12 $Ref) (i@220@12 Int)) (!
  (and
    (or (Set_in x@219@12 setOfRef@10@12) (not (Set_in x@219@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@219@12 setOfRef@10@12)
          (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12)))))
      (and
        (Set_in x@219@12 setOfRef@10@12)
        (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12) i@220@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@219@12 $Ref) (i@220@12 Int)) (!
  (and
    (or (Set_in x@219@12 setOfRef@10@12) (not (Set_in x@219@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@219@12 setOfRef@10@12)
          (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12)))))
      (and
        (Set_in x@219@12 setOfRef@10@12)
        (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12) i@220@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@219@12 $Ref) (i@220@12 Int)) (!
  (and
    (or (Set_in x@219@12 setOfRef@10@12) (not (Set_in x@219@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@219@12 setOfRef@10@12)
          (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12)))))
      (and
        (Set_in x@219@12 setOfRef@10@12)
        (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12))))))
  :pattern ((Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@219@12 $Ref) (i@220@12 Int)) (!
  (and
    (or (Set_in x@219@12 setOfRef@10@12) (not (Set_in x@219@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@219@12 setOfRef@10@12)
          (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12)))))
      (and
        (Set_in x@219@12 setOfRef@10@12)
        (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12))))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12) i@220@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@219@12 $Ref) (i@220@12 Int)) (!
  (=>
    (and
      (Set_in x@219@12 setOfRef@10@12)
      (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12))))
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12) i@220@12) setOfRef@10@12))
  :pattern ((Set_in x@219@12 setOfRef@10@12) (Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12))))
  :pattern ((Set_in x@219@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12) i@220@12))
  :pattern ((Set_in x@219@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12) i@220@12) setOfRef@10@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12) i@220@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12) i@220@12) setOfRef@10@12))
  :pattern ((Set_in i@220@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@217@12  $FVF<edges>) x@219@12) i@220@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))
  $Snap.unit))
; [eval] res_copy_nodes == (res_copy_nodes union old(node_map_image))
; [eval] (res_copy_nodes union old(node_map_image))
; [eval] old(node_map_image)
(assert (Set_equal res_copy_nodes@205@12 (Set_union res_copy_nodes@205@12 res_copy_nodes@107@12)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))))
(assert (=
  ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))))))
  $Snap.unit))
; [eval] (forall x: Ref :: { (x in map_domain(res_node_map)) } { (lookup(res_node_map, x) in res_copy_nodes) } (x in map_domain(res_node_map)) ==> (lookup(res_node_map, x) in res_copy_nodes))
(declare-const x@221@12 $Ref)
(push) ; 7
; [eval] (x in map_domain(res_node_map)) ==> (lookup(res_node_map, x) in res_copy_nodes)
; [eval] (x in map_domain(res_node_map))
; [eval] map_domain(res_node_map)
(push) ; 8
; [then-branch: 35 | x@221@12 in map_domain[Seq[Ref]](res_node_map@204@12) | live]
; [else-branch: 35 | !(x@221@12 in map_domain[Seq[Ref]](res_node_map@204@12)) | live]
(push) ; 9
; [then-branch: 35 | x@221@12 in map_domain[Seq[Ref]](res_node_map@204@12)]
(assert (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) x@221@12))
; [eval] (lookup(res_node_map, x) in res_copy_nodes)
; [eval] lookup(res_node_map, x)
(pop) ; 9
(push) ; 9
; [else-branch: 35 | !(x@221@12 in map_domain[Seq[Ref]](res_node_map@204@12))]
(assert (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) x@221@12)))
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or
  (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) x@221@12))
  (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) x@221@12)))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@221@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) x@221@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) x@221@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) x@221@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@204@12)
    x@221@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102-aux|)))
(assert (forall ((x@221@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) x@221@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) x@221@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@204@12)
    x@221@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102-aux|)))
(assert (forall ((x@221@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) x@221@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) x@221@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@204@12 x@221@12) res_copy_nodes@205@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102-aux|)))
(assert (forall ((x@221@12 $Ref)) (!
  (=>
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) x@221@12)
    (Set_in (lookup<Ref> res_node_map@204@12 x@221@12) res_copy_nodes@205@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) x@221@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@204@12)
    x@221@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@204@12 x@221@12) res_copy_nodes@205@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102|)))
(assert (=
  ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))))))
  ($Snap.combine
    ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))
    ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))))))))))
(declare-const x@222@12 $Ref)
(push) ; 7
; [eval] (x in res_copy_nodes)
(assert (Set_in x@222@12 res_copy_nodes@205@12))
(pop) ; 7
(declare-fun inv@223@12 ($Ref) $Ref)
(declare-fun img@224@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((x1@222@12 $Ref) (x2@222@12 $Ref)) (!
  (=>
    (and
      (Set_in x1@222@12 res_copy_nodes@205@12)
      (Set_in x2@222@12 res_copy_nodes@205@12)
      (= x1@222@12 x2@222@12))
    (= x1@222@12 x2@222@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@222@12 $Ref)) (!
  (=>
    (Set_in x@222@12 res_copy_nodes@205@12)
    (and (= (inv@223@12 x@222@12) x@222@12) (img@224@12 x@222@12)))
  :pattern ((Set_in x@222@12 res_copy_nodes@205@12))
  :pattern ((inv@223@12 x@222@12))
  :pattern ((img@224@12 x@222@12))
  :qid |quant-u-106|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@224@12 r) (Set_in (inv@223@12 r) res_copy_nodes@205@12))
    (= (inv@223@12 r) r))
  :pattern ((inv@223@12 r))
  :qid |val-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((x@222@12 $Ref)) (!
  (=> (Set_in x@222@12 res_copy_nodes@205@12) (not (= x@222@12 $Ref.null)))
  :pattern ((Set_in x@222@12 res_copy_nodes@205@12))
  :pattern ((inv@223@12 x@222@12))
  :pattern ((img@224@12 x@222@12))
  :qid |val-permImpliesNonNull|)))
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= x@222@12 x@207@12)
    (=
      (and (img@224@12 r) (Set_in (inv@223@12 r) res_copy_nodes@205@12))
      (and (img@209@12 r) (Set_in (inv@208@12 r) setOfRef@10@12))))
  
  :qid |quant-u-107|))))
(check-sat)
; unknown
(pop) ; 7
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= x@222@12 x@109@12)
    (=
      (and (img@224@12 r) (Set_in (inv@223@12 r) res_copy_nodes@205@12))
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))))
  
  :qid |quant-u-108|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(declare-const x@225@12 $Ref)
(set-option :timeout 0)
(push) ; 7
; [eval] (x in res_copy_nodes)
(assert (Set_in x@225@12 res_copy_nodes@205@12))
(pop) ; 7
(declare-fun inv@226@12 ($Ref) $Ref)
(declare-fun img@227@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((x1@225@12 $Ref) (x2@225@12 $Ref)) (!
  (=>
    (and
      (Set_in x1@225@12 res_copy_nodes@205@12)
      (Set_in x2@225@12 res_copy_nodes@205@12)
      (= x1@225@12 x2@225@12))
    (= x1@225@12 x2@225@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@225@12 $Ref)) (!
  (=>
    (Set_in x@225@12 res_copy_nodes@205@12)
    (and (= (inv@226@12 x@225@12) x@225@12) (img@227@12 x@225@12)))
  :pattern ((Set_in x@225@12 res_copy_nodes@205@12))
  :pattern ((inv@226@12 x@225@12))
  :pattern ((img@227@12 x@225@12))
  :qid |quant-u-110|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
    (= (inv@226@12 r) r))
  :pattern ((inv@226@12 r))
  :qid |edges-fctOfInv|)))
; Permissions are non-negative
; Field permissions are at most one
; Permission implies non-null receiver
(assert (forall ((x@225@12 $Ref)) (!
  (=> (Set_in x@225@12 res_copy_nodes@205@12) (not (= x@225@12 $Ref.null)))
  :pattern ((Set_in x@225@12 res_copy_nodes@205@12))
  :pattern ((inv@226@12 x@225@12))
  :pattern ((img@227@12 x@225@12))
  :qid |edges-permImpliesNonNull|)))
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= x@225@12 x@213@12)
    (=
      (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))))
  
  :qid |quant-u-111|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (and
    (= x@225@12 x@115@12)
    (=
      (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))))
  
  :qid |quant-u-112|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
; [exec]
; nodeCopy.edges := insert_edge(nodeCopy.edges, i, newNode)
; [eval] insert_edge(nodeCopy.edges, i, newNode)
(declare-const sm@228@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@228@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@228@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef62|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@228@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@228@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef63|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
    (=
      ($FVF.lookup_edges (as sm@228@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@228@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
  :qid |qp.fvfValDef64|)))
(declare-const pm@229@12 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@229@12  $FPM) r)
    (+
      (+
        (ite
          (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
          (- rd@12@12 (pTaken@186@12 r))
          $Perm.No)
        (ite
          (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
          (/ rd@12@12 (to_real 2))
          $Perm.No))
      (ite
        (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@229@12  $FPM) r))
  :qid |qp.resPrmSumDef65|)))
(set-option :timeout 0)
(push) ; 7
(assert (not (< $Perm.No ($FVF.perm_edges (as pm@229@12  $FPM) nodeCopy@86@12))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Precomputing data for removing quantified permissions
(define-fun pTaken@230@12 ((r $Ref)) $Perm
  (ite
    (= r nodeCopy@86@12)
    ($Perm.min
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@186@12 r))
        $Perm.No)
      $Perm.Write)
    $Perm.No))
(define-fun pTaken@231@12 ((r $Ref)) $Perm
  (ite
    (= r nodeCopy@86@12)
    ($Perm.min
      (ite
        (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No)
      (- $Perm.Write (pTaken@230@12 r)))
    $Perm.No))
(define-fun pTaken@232@12 ((r $Ref)) $Perm
  (ite
    (= r nodeCopy@86@12)
    ($Perm.min
      (ite
        (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
        $Perm.Write
        $Perm.No)
      (- (- $Perm.Write (pTaken@230@12 r)) (pTaken@231@12 r)))
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
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@186@12 r))
        $Perm.No)
      (pTaken@230@12 r))
    $Perm.No)
  
  :qid |quant-u-114|))))
(check-sat)
; unknown
(pop) ; 7
; 0.01s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@230@12 r) $Perm.No)
  
  :qid |quant-u-115|))))
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
  (=> (= r nodeCopy@86@12) (= (- $Perm.Write (pTaken@230@12 r)) $Perm.No))
  
  :qid |quant-u-116|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No)
      (pTaken@231@12 r))
    $Perm.No)
  
  :qid |quant-u-117|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@231@12 r) $Perm.No)
  
  :qid |quant-u-118|))))
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
    (= r nodeCopy@86@12)
    (= (- (- $Perm.Write (pTaken@230@12 r)) (pTaken@231@12 r)) $Perm.No))
  
  :qid |quant-u-119|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
        $Perm.Write
        $Perm.No)
      (pTaken@232@12 r))
    $Perm.No)
  
  :qid |quant-u-120|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@232@12 r) $Perm.No)
  
  :qid |quant-u-121|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Intermediate check if already taken enough permissions
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      (-
        (- (- $Perm.Write (pTaken@230@12 r)) (pTaken@231@12 r))
        (pTaken@232@12 r))
      $Perm.No))
  
  :qid |quant-u-122|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@233@12 $FVF<edges>)
; Definitional axioms for singleton-FVF's value
(assert (=
  ($FVF.lookup_edges (as sm@233@12  $FVF<edges>) nodeCopy@86@12)
  (insert_edge<IEdges> ($FVF.lookup_edges (as sm@228@12  $FVF<edges>) nodeCopy@86@12) i@171@12 nodeCopy@203@12)))
; Loop head block: Re-establish invariant
; [eval] (nodeCopy in res_copy_nodes)
(set-option :timeout 0)
(push) ; 7
(assert (not (Set_in nodeCopy@86@12 res_copy_nodes@205@12)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (Set_in nodeCopy@86@12 res_copy_nodes@205@12))
; [eval] (this in setOfRef)
(declare-const x@234@12 $Ref)
(push) ; 7
; [eval] (x in setOfRef)
(assert (Set_in x@234@12 setOfRef@10@12))
(pop) ; 7
(declare-fun inv@235@12 ($Ref) $Ref)
(declare-fun img@236@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 7
(assert (not (forall ((x@234@12 $Ref)) (!
  (=>
    (Set_in x@234@12 setOfRef@10@12)
    (or (= rd@12@12 $Perm.No) (< $Perm.No rd@12@12)))
  
  :qid |quant-u-123|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((x1@234@12 $Ref) (x2@234@12 $Ref)) (!
  (=>
    (and
      (and (Set_in x1@234@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (and (Set_in x2@234@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (= x1@234@12 x2@234@12))
    (= x1@234@12 x2@234@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@234@12 $Ref)) (!
  (=>
    (and (Set_in x@234@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@235@12 x@234@12) x@234@12) (img@236@12 x@234@12)))
  :pattern ((Set_in x@234@12 setOfRef@10@12))
  :pattern ((inv@235@12 x@234@12))
  :pattern ((img@236@12 x@234@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@236@12 r)
      (and (Set_in (inv@235@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@235@12 r) r))
  :pattern ((inv@235@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@237@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@235@12 r) setOfRef@10@12)
      (img@236@12 r)
      (= r (inv@235@12 r)))
    ($Perm.min
      (ite
        (and (img@224@12 r) (Set_in (inv@223@12 r) res_copy_nodes@205@12))
        $Perm.Write
        $Perm.No)
      rd@12@12)
    $Perm.No))
(define-fun pTaken@238@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@235@12 r) setOfRef@10@12)
      (img@236@12 r)
      (= r (inv@235@12 r)))
    ($Perm.min
      (ite
        (and (img@209@12 r) (Set_in (inv@208@12 r) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No)
      (- rd@12@12 (pTaken@237@12 r)))
    $Perm.No))
(define-fun pTaken@239@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@235@12 r) setOfRef@10@12)
      (img@236@12 r)
      (= r (inv@235@12 r)))
    ($Perm.min
      (ite
        (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@179@12 r))
        $Perm.No)
      (- (- rd@12@12 (pTaken@237@12 r)) (pTaken@238@12 r)))
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
        (and (img@224@12 r) (Set_in (inv@223@12 r) res_copy_nodes@205@12))
        $Perm.Write
        $Perm.No)
      (pTaken@237@12 r))
    $Perm.No)
  
  :qid |quant-u-125|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@237@12 r) $Perm.No)
  
  :qid |quant-u-126|))))
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
      (Set_in (inv@235@12 r) setOfRef@10@12)
      (img@236@12 r)
      (= r (inv@235@12 r)))
    (= (- rd@12@12 (pTaken@237@12 r)) $Perm.No))
  
  :qid |quant-u-127|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and (img@209@12 r) (Set_in (inv@208@12 r) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No)
      (pTaken@238@12 r))
    $Perm.No)
  
  :qid |quant-u-128|))))
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
      (Set_in (inv@235@12 r) setOfRef@10@12)
      (img@236@12 r)
      (= r (inv@235@12 r)))
    (= (- (- rd@12@12 (pTaken@237@12 r)) (pTaken@238@12 r)) $Perm.No))
  
  :qid |quant-u-129|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@179@12 r))
        $Perm.No)
      (pTaken@239@12 r))
    $Perm.No)
  
  :qid |quant-u-130|))))
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
      (Set_in (inv@235@12 r) setOfRef@10@12)
      (img@236@12 r)
      (= r (inv@235@12 r)))
    (=
      (- (- (- rd@12@12 (pTaken@237@12 r)) (pTaken@238@12 r)) (pTaken@239@12 r))
      $Perm.No))
  
  :qid |quant-u-131|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@240@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@224@12 r) (Set_in (inv@223@12 r) res_copy_nodes@205@12))
    (=
      ($FVF.lookup_val (as sm@240@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@240@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
  :qid |qp.fvfValDef66|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@209@12 r) (Set_in (inv@208@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_val (as sm@240@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@206@12))))) r)))
  :pattern (($FVF.lookup_val (as sm@240@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@206@12))))) r))
  :qid |qp.fvfValDef67|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@179@12 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@240@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
  :pattern (($FVF.lookup_val (as sm@240@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
  :qid |qp.fvfValDef68|)))
; [eval] (forall x: Ref :: { (x in setOfRef) } (x in setOfRef) ==> x.val == old(x.val))
(declare-const x@241@12 $Ref)
(set-option :timeout 0)
(push) ; 7
; [eval] (x in setOfRef) ==> x.val == old(x.val)
; [eval] (x in setOfRef)
(push) ; 8
; [then-branch: 36 | x@241@12 in setOfRef@10@12 | live]
; [else-branch: 36 | !(x@241@12 in setOfRef@10@12) | live]
(push) ; 9
; [then-branch: 36 | x@241@12 in setOfRef@10@12]
(assert (Set_in x@241@12 setOfRef@10@12))
; [eval] x.val == old(x.val)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (and (img@224@12 r) (Set_in (inv@223@12 r) res_copy_nodes@205@12))
      (=
        ($FVF.lookup_val (as sm@240@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
    :pattern (($FVF.lookup_val (as sm@240@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
    :qid |qp.fvfValDef66|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@209@12 r) (Set_in (inv@208@12 r) setOfRef@10@12))
        (< $Perm.No (/ rd@12@12 (to_real 2)))
        false)
      (=
        ($FVF.lookup_val (as sm@240@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@206@12))))) r)))
    :pattern (($FVF.lookup_val (as sm@240@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@206@12))))) r))
    :qid |qp.fvfValDef67|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
        (< $Perm.No (- rd@12@12 (pTaken@179@12 r)))
        false)
      (=
        ($FVF.lookup_val (as sm@240@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
    :pattern (($FVF.lookup_val (as sm@240@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
    :qid |qp.fvfValDef68|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (+
      (ite
        (and
          (img@224@12 x@241@12)
          (Set_in (inv@223@12 x@241@12) res_copy_nodes@205@12))
        $Perm.Write
        $Perm.No)
      (ite
        (and (img@209@12 x@241@12) (Set_in (inv@208@12 x@241@12) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No))
    (ite
      (and (img@111@12 x@241@12) (Set_in (inv@110@12 x@241@12) setOfRef@10@12))
      (- rd@12@12 (pTaken@179@12 x@241@12))
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [eval] old(x.val)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
    :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
    :qid |qp.fvfValDef23|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
      (=
        ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
    :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
    :qid |qp.fvfValDef24|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@19@12 x@241@12) (Set_in (inv@18@12 x@241@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and
        (img@28@12 x@241@12)
        (Set_in (inv@27@12 x@241@12) node_map_image@11@12))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 36 | !(x@241@12 in setOfRef@10@12)]
(assert (not (Set_in x@241@12 setOfRef@10@12)))
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@224@12 r) (Set_in (inv@223@12 r) res_copy_nodes@205@12))
    (=
      ($FVF.lookup_val (as sm@240@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@240@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
  :qid |qp.fvfValDef66|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@209@12 r) (Set_in (inv@208@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_val (as sm@240@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@206@12))))) r)))
  :pattern (($FVF.lookup_val (as sm@240@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@206@12))))) r))
  :qid |qp.fvfValDef67|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@179@12 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@240@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
  :pattern (($FVF.lookup_val (as sm@240@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
  :qid |qp.fvfValDef68|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef24|)))
; Joined path conditions
(assert (or (not (Set_in x@241@12 setOfRef@10@12)) (Set_in x@241@12 setOfRef@10@12)))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@224@12 r) (Set_in (inv@223@12 r) res_copy_nodes@205@12))
    (=
      ($FVF.lookup_val (as sm@240@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@240@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
  :qid |qp.fvfValDef66|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@209@12 r) (Set_in (inv@208@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_val (as sm@240@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@206@12))))) r)))
  :pattern (($FVF.lookup_val (as sm@240@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second $t@206@12))))) r))
  :qid |qp.fvfValDef67|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@179@12 r)))
      false)
    (=
      ($FVF.lookup_val (as sm@240@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
  :pattern (($FVF.lookup_val (as sm@240@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
  :qid |qp.fvfValDef68|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef24|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@241@12 $Ref)) (!
  (or (not (Set_in x@241@12 setOfRef@10@12)) (Set_in x@241@12 setOfRef@10@12))
  :pattern ((Set_in x@241@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@146@17@146@71-aux|)))
(push) ; 7
(assert (not (forall ((x@241@12 $Ref)) (!
  (=>
    (Set_in x@241@12 setOfRef@10@12)
    (=
      ($FVF.lookup_val (as sm@240@12  $FVF<val>) x@241@12)
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) x@241@12)))
  :pattern ((Set_in x@241@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@146@17@146@71|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (forall ((x@241@12 $Ref)) (!
  (=>
    (Set_in x@241@12 setOfRef@10@12)
    (=
      ($FVF.lookup_val (as sm@240@12  $FVF<val>) x@241@12)
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) x@241@12)))
  :pattern ((Set_in x@241@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@146@17@146@71|)))
(declare-const x@242@12 $Ref)
(push) ; 7
; [eval] (x in setOfRef)
(assert (Set_in x@242@12 setOfRef@10@12))
(pop) ; 7
(declare-fun inv@243@12 ($Ref) $Ref)
(declare-fun img@244@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 7
(assert (not (forall ((x@242@12 $Ref)) (!
  (=>
    (Set_in x@242@12 setOfRef@10@12)
    (or (= rd@12@12 $Perm.No) (< $Perm.No rd@12@12)))
  
  :qid |quant-u-132|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((x1@242@12 $Ref) (x2@242@12 $Ref)) (!
  (=>
    (and
      (and (Set_in x1@242@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (and (Set_in x2@242@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (= x1@242@12 x2@242@12))
    (= x1@242@12 x2@242@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@242@12 $Ref)) (!
  (=>
    (and (Set_in x@242@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@243@12 x@242@12) x@242@12) (img@244@12 x@242@12)))
  :pattern ((Set_in x@242@12 setOfRef@10@12))
  :pattern ((inv@243@12 x@242@12))
  :pattern ((img@244@12 x@242@12))
  :qid |edges-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@244@12 r)
      (and (Set_in (inv@243@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@243@12 r) r))
  :pattern ((inv@243@12 r))
  :qid |edges-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@245@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@243@12 r) setOfRef@10@12)
      (img@244@12 r)
      (= r (inv@243@12 r)))
    ($Perm.min
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@186@12 r))
        $Perm.No)
      rd@12@12)
    $Perm.No))
(define-fun pTaken@246@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@243@12 r) setOfRef@10@12)
      (img@244@12 r)
      (= r (inv@243@12 r)))
    ($Perm.min
      (ite
        (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No)
      (- rd@12@12 (pTaken@245@12 r)))
    $Perm.No))
(define-fun pTaken@247@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@243@12 r) setOfRef@10@12)
      (img@244@12 r)
      (= r (inv@243@12 r)))
    ($Perm.min
      (ite
        (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
        (- $Perm.Write (pTaken@232@12 r))
        $Perm.No)
      (- (- rd@12@12 (pTaken@245@12 r)) (pTaken@246@12 r)))
    $Perm.No))
(define-fun pTaken@248@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@243@12 r) setOfRef@10@12)
      (img@244@12 r)
      (= r (inv@243@12 r)))
    ($Perm.min
      (ite (= r nodeCopy@86@12) $Perm.Write $Perm.No)
      (- (- (- rd@12@12 (pTaken@245@12 r)) (pTaken@246@12 r)) (pTaken@247@12 r)))
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
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@186@12 r))
        $Perm.No)
      (pTaken@245@12 r))
    $Perm.No)
  
  :qid |quant-u-134|))))
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
      (Set_in (inv@243@12 r) setOfRef@10@12)
      (img@244@12 r)
      (= r (inv@243@12 r)))
    (= (- rd@12@12 (pTaken@245@12 r)) $Perm.No))
  
  :qid |quant-u-135|))))
(check-sat)
; unknown
(pop) ; 7
; 0.01s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No)
      (pTaken@246@12 r))
    $Perm.No)
  
  :qid |quant-u-136|))))
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
      (Set_in (inv@243@12 r) setOfRef@10@12)
      (img@244@12 r)
      (= r (inv@243@12 r)))
    (= (- (- rd@12@12 (pTaken@245@12 r)) (pTaken@246@12 r)) $Perm.No))
  
  :qid |quant-u-137|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@249@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@249@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@249@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef69|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@249@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@249@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef70|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
      (< $Perm.No (- $Perm.Write (pTaken@232@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@249@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@249@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
  :qid |qp.fvfValDef71|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@249@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@249@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r))
  :qid |qp.fvfValDef72|)))
; [eval] (forall x: Ref :: { (x in setOfRef) } (x in setOfRef) ==> x.edges == old(x.edges))
(declare-const x@250@12 $Ref)
(set-option :timeout 0)
(push) ; 7
; [eval] (x in setOfRef) ==> x.edges == old(x.edges)
; [eval] (x in setOfRef)
(push) ; 8
; [then-branch: 37 | x@250@12 in setOfRef@10@12 | live]
; [else-branch: 37 | !(x@250@12 in setOfRef@10@12) | live]
(push) ; 9
; [then-branch: 37 | x@250@12 in setOfRef@10@12]
(assert (Set_in x@250@12 setOfRef@10@12))
; [eval] x.edges == old(x.edges)
(declare-const sm@251@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r))
  :qid |qp.fvfValDef73|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
      (< $Perm.No (- $Perm.Write (pTaken@232@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
  :qid |qp.fvfValDef74|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef75|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef76|)))
(declare-const pm@252@12 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@252@12  $FPM) r)
    (+
      (+
        (+
          (ite (= r nodeCopy@86@12) $Perm.Write $Perm.No)
          (ite
            (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
            (- $Perm.Write (pTaken@232@12 r))
            $Perm.No))
        (ite
          (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
          (/ rd@12@12 (to_real 2))
          $Perm.No))
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@186@12 r))
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@252@12  $FPM) r))
  :qid |qp.resPrmSumDef77|)))
(push) ; 10
(assert (not (< $Perm.No ($FVF.perm_edges (as pm@252@12  $FPM) x@250@12))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [eval] old(x.edges)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
    :qid |qp.fvfValDef26|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
      (=
        ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
    :qid |qp.fvfValDef27|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@22@12 x@250@12) (Set_in (inv@21@12 x@250@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and
        (img@31@12 x@250@12)
        (Set_in (inv@30@12 x@250@12) node_map_image@11@12))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 37 | !(x@250@12 in setOfRef@10@12)]
(assert (not (Set_in x@250@12 setOfRef@10@12)))
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r))
  :qid |qp.fvfValDef73|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
      (< $Perm.No (- $Perm.Write (pTaken@232@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
  :qid |qp.fvfValDef74|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef75|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef76|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@252@12  $FPM) r)
    (+
      (+
        (+
          (ite (= r nodeCopy@86@12) $Perm.Write $Perm.No)
          (ite
            (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
            (- $Perm.Write (pTaken@232@12 r))
            $Perm.No))
        (ite
          (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
          (/ rd@12@12 (to_real 2))
          $Perm.No))
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@186@12 r))
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@252@12  $FPM) r))
  :qid |qp.resPrmSumDef77|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef26|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef27|)))
; Joined path conditions
(assert (or (not (Set_in x@250@12 setOfRef@10@12)) (Set_in x@250@12 setOfRef@10@12)))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r))
  :qid |qp.fvfValDef73|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
      (< $Perm.No (- $Perm.Write (pTaken@232@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
  :qid |qp.fvfValDef74|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef75|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef76|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@252@12  $FPM) r)
    (+
      (+
        (+
          (ite (= r nodeCopy@86@12) $Perm.Write $Perm.No)
          (ite
            (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
            (- $Perm.Write (pTaken@232@12 r))
            $Perm.No))
        (ite
          (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
          (/ rd@12@12 (to_real 2))
          $Perm.No))
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (- rd@12@12 (pTaken@186@12 r))
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@252@12  $FPM) r))
  :qid |qp.resPrmSumDef77|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef26|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef27|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@250@12 $Ref)) (!
  (or (not (Set_in x@250@12 setOfRef@10@12)) (Set_in x@250@12 setOfRef@10@12))
  :pattern ((Set_in x@250@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@148@17@148@75-aux|)))
(push) ; 7
(assert (not (forall ((x@250@12 $Ref)) (!
  (=>
    (Set_in x@250@12 setOfRef@10@12)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) x@250@12)
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) x@250@12)))
  :pattern ((Set_in x@250@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@148@17@148@75|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (forall ((x@250@12 $Ref)) (!
  (=>
    (Set_in x@250@12 setOfRef@10@12)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) x@250@12)
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) x@250@12)))
  :pattern ((Set_in x@250@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@148@17@148@75|)))
; [eval] (forall j: Int :: { (j in S) } { (edge_lookup(this.edges, j) in setOfRef) } (j in S) ==> (edge_lookup(this.edges, j) in setOfRef))
(declare-const j@253@12 Int)
(push) ; 7
; [eval] (j in S) ==> (edge_lookup(this.edges, j) in setOfRef)
; [eval] (j in S)
(push) ; 8
; [then-branch: 38 | j@253@12 in s2@170@12 | live]
; [else-branch: 38 | !(j@253@12 in s2@170@12) | live]
(push) ; 9
; [then-branch: 38 | j@253@12 in s2@170@12]
(assert (Set_in j@253@12 s2@170@12))
; [eval] (edge_lookup(this.edges, j) in setOfRef)
; [eval] edge_lookup(this.edges, j)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r nodeCopy@86@12)
      (=
        ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
        ($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r)))
    :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r))
    :qid |qp.fvfValDef73|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
        (< $Perm.No (- $Perm.Write (pTaken@232@12 r)))
        false)
      (=
        ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
    :qid |qp.fvfValDef74|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
        (< $Perm.No (/ rd@12@12 (to_real 2)))
        false)
      (=
        ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
    :qid |qp.fvfValDef75|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
        false)
      (=
        ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
    :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
    :qid |qp.fvfValDef76|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (+
      (+
        (ite (= this@8@12 nodeCopy@86@12) $Perm.Write $Perm.No)
        (ite
          (and
            (img@227@12 this@8@12)
            (Set_in (inv@226@12 this@8@12) res_copy_nodes@205@12))
          (- $Perm.Write (pTaken@232@12 this@8@12))
          $Perm.No))
      (ite
        (and
          (img@215@12 this@8@12)
          (Set_in (inv@214@12 this@8@12) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No))
    (ite
      (and (img@117@12 this@8@12) (Set_in (inv@116@12 this@8@12) setOfRef@10@12))
      (- rd@12@12 (pTaken@186@12 this@8@12))
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 38 | !(j@253@12 in s2@170@12)]
(assert (not (Set_in j@253@12 s2@170@12)))
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r))
  :qid |qp.fvfValDef73|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
      (< $Perm.No (- $Perm.Write (pTaken@232@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
  :qid |qp.fvfValDef74|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef75|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef76|)))
; Joined path conditions
(assert (or (not (Set_in j@253@12 s2@170@12)) (Set_in j@253@12 s2@170@12)))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r))
  :qid |qp.fvfValDef73|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
      (< $Perm.No (- $Perm.Write (pTaken@232@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
  :qid |qp.fvfValDef74|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef75|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef76|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((j@253@12 Int)) (!
  (or (not (Set_in j@253@12 s2@170@12)) (Set_in j@253@12 s2@170@12))
  :pattern ((Set_in j@253@12 s2@170@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@149@17@149@83-aux|)))
(assert (forall ((j@253@12 Int)) (!
  (or (not (Set_in j@253@12 s2@170@12)) (Set_in j@253@12 s2@170@12))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) this@8@12) j@253@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@149@17@149@83-aux|)))
(push) ; 7
(assert (not (forall ((j@253@12 Int)) (!
  (=>
    (Set_in j@253@12 s2@170@12)
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) this@8@12) j@253@12) setOfRef@10@12))
  :pattern ((Set_in j@253@12 s2@170@12))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) this@8@12) j@253@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@149@17@149@83|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (forall ((j@253@12 Int)) (!
  (=>
    (Set_in j@253@12 s2@170@12)
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) this@8@12) j@253@12) setOfRef@10@12))
  :pattern ((Set_in j@253@12 s2@170@12))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) this@8@12) j@253@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@149@17@149@83|)))
; [eval] (forall r: Ref, j: Int :: { (r in setOfRef), (j in edges_domain(r.edges)) } { (r in setOfRef), edge_lookup(r.edges, j) } { (r in setOfRef), (edge_lookup(r.edges, j) in setOfRef) } { edges_domain(r.edges), edge_lookup(r.edges, j) } { edges_domain(r.edges), (edge_lookup(r.edges, j) in setOfRef) } { (j in edges_domain(r.edges)) } { (edge_lookup(r.edges, j) in setOfRef) } (r in setOfRef) && (j in edges_domain(r.edges)) ==> (edge_lookup(r.edges, j) in setOfRef))
(declare-const r@254@12 $Ref)
(declare-const j@255@12 Int)
(push) ; 7
; [eval] (r in setOfRef) && (j in edges_domain(r.edges)) ==> (edge_lookup(r.edges, j) in setOfRef)
; [eval] (r in setOfRef) && (j in edges_domain(r.edges))
; [eval] (r in setOfRef)
(push) ; 8
; [then-branch: 39 | !(r@254@12 in setOfRef@10@12) | live]
; [else-branch: 39 | r@254@12 in setOfRef@10@12 | live]
(push) ; 9
; [then-branch: 39 | !(r@254@12 in setOfRef@10@12)]
(assert (not (Set_in r@254@12 setOfRef@10@12)))
(pop) ; 9
(push) ; 9
; [else-branch: 39 | r@254@12 in setOfRef@10@12]
(assert (Set_in r@254@12 setOfRef@10@12))
; [eval] (j in edges_domain(r.edges))
; [eval] edges_domain(r.edges)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r nodeCopy@86@12)
      (=
        ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
        ($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r)))
    :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r))
    :qid |qp.fvfValDef73|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
        (< $Perm.No (- $Perm.Write (pTaken@232@12 r)))
        false)
      (=
        ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
    :qid |qp.fvfValDef74|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
        (< $Perm.No (/ rd@12@12 (to_real 2)))
        false)
      (=
        ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
    :qid |qp.fvfValDef75|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
        false)
      (=
        ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
    :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
    :qid |qp.fvfValDef76|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (+
      (+
        (ite (= r@254@12 nodeCopy@86@12) $Perm.Write $Perm.No)
        (ite
          (and
            (img@227@12 r@254@12)
            (Set_in (inv@226@12 r@254@12) res_copy_nodes@205@12))
          (- $Perm.Write (pTaken@232@12 r@254@12))
          $Perm.No))
      (ite
        (and (img@215@12 r@254@12) (Set_in (inv@214@12 r@254@12) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No))
    (ite
      (and (img@117@12 r@254@12) (Set_in (inv@116@12 r@254@12) setOfRef@10@12))
      (- rd@12@12 (pTaken@186@12 r@254@12))
      $Perm.No)))))
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
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r))
  :qid |qp.fvfValDef73|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
      (< $Perm.No (- $Perm.Write (pTaken@232@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
  :qid |qp.fvfValDef74|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef75|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef76|)))
(assert (or (Set_in r@254@12 setOfRef@10@12) (not (Set_in r@254@12 setOfRef@10@12))))
(push) ; 8
; [then-branch: 40 | r@254@12 in setOfRef@10@12 && j@255@12 in edges_domain[Set[Int]](Lookup(edges, sm@251@12, r@254@12)) | live]
; [else-branch: 40 | !(r@254@12 in setOfRef@10@12 && j@255@12 in edges_domain[Set[Int]](Lookup(edges, sm@251@12, r@254@12))) | live]
(push) ; 9
; [then-branch: 40 | r@254@12 in setOfRef@10@12 && j@255@12 in edges_domain[Set[Int]](Lookup(edges, sm@251@12, r@254@12))]
(assert (and
  (Set_in r@254@12 setOfRef@10@12)
  (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12)))))
; [eval] (edge_lookup(r.edges, j) in setOfRef)
; [eval] edge_lookup(r.edges, j)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (= r nodeCopy@86@12)
      (=
        ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
        ($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r)))
    :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r))
    :qid |qp.fvfValDef73|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
        (< $Perm.No (- $Perm.Write (pTaken@232@12 r)))
        false)
      (=
        ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
    :qid |qp.fvfValDef74|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
        (< $Perm.No (/ rd@12@12 (to_real 2)))
        false)
      (=
        ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
    :qid |qp.fvfValDef75|))
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
        false)
      (=
        ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
    :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
    :qid |qp.fvfValDef76|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (+
      (+
        (ite (= r@254@12 nodeCopy@86@12) $Perm.Write $Perm.No)
        (ite
          (and
            (img@227@12 r@254@12)
            (Set_in (inv@226@12 r@254@12) res_copy_nodes@205@12))
          (- $Perm.Write (pTaken@232@12 r@254@12))
          $Perm.No))
      (ite
        (and (img@215@12 r@254@12) (Set_in (inv@214@12 r@254@12) setOfRef@10@12))
        (/ rd@12@12 (to_real 2))
        $Perm.No))
    (ite
      (and (img@117@12 r@254@12) (Set_in (inv@116@12 r@254@12) setOfRef@10@12))
      (- rd@12@12 (pTaken@186@12 r@254@12))
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 40 | !(r@254@12 in setOfRef@10@12 && j@255@12 in edges_domain[Set[Int]](Lookup(edges, sm@251@12, r@254@12)))]
(assert (not
  (and
    (Set_in r@254@12 setOfRef@10@12)
    (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))))
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r))
  :qid |qp.fvfValDef73|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
      (< $Perm.No (- $Perm.Write (pTaken@232@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
  :qid |qp.fvfValDef74|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef75|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef76|)))
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in r@254@12 setOfRef@10@12)
      (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12)))))
  (and
    (Set_in r@254@12 setOfRef@10@12)
    (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r))
  :qid |qp.fvfValDef73|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
      (< $Perm.No (- $Perm.Write (pTaken@232@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
  :qid |qp.fvfValDef74|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@215@12 r) (Set_in (inv@214@12 r) setOfRef@10@12))
      (< $Perm.No (/ rd@12@12 (to_real 2)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12))))))) r))
  :qid |qp.fvfValDef75|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No (- rd@12@12 (pTaken@186@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef76|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((r@254@12 $Ref) (j@255@12 Int)) (!
  (and
    (or (Set_in r@254@12 setOfRef@10@12) (not (Set_in r@254@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@254@12 setOfRef@10@12)
          (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12)))))
      (and
        (Set_in r@254@12 setOfRef@10@12)
        (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))))
  :pattern ((Set_in r@254@12 setOfRef@10@12) (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@254@12 $Ref) (j@255@12 Int)) (!
  (and
    (or (Set_in r@254@12 setOfRef@10@12) (not (Set_in r@254@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@254@12 setOfRef@10@12)
          (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12)))))
      (and
        (Set_in r@254@12 setOfRef@10@12)
        (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))))
  :pattern ((Set_in r@254@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@254@12 $Ref) (j@255@12 Int)) (!
  (and
    (or (Set_in r@254@12 setOfRef@10@12) (not (Set_in r@254@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@254@12 setOfRef@10@12)
          (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12)))))
      (and
        (Set_in r@254@12 setOfRef@10@12)
        (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))))
  :pattern ((Set_in r@254@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@254@12 $Ref) (j@255@12 Int)) (!
  (and
    (or (Set_in r@254@12 setOfRef@10@12) (not (Set_in r@254@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@254@12 setOfRef@10@12)
          (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12)))))
      (and
        (Set_in r@254@12 setOfRef@10@12)
        (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@254@12 $Ref) (j@255@12 Int)) (!
  (and
    (or (Set_in r@254@12 setOfRef@10@12) (not (Set_in r@254@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@254@12 setOfRef@10@12)
          (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12)))))
      (and
        (Set_in r@254@12 setOfRef@10@12)
        (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@254@12 $Ref) (j@255@12 Int)) (!
  (and
    (or (Set_in r@254@12 setOfRef@10@12) (not (Set_in r@254@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@254@12 setOfRef@10@12)
          (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12)))))
      (and
        (Set_in r@254@12 setOfRef@10@12)
        (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))))
  :pattern ((Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(assert (forall ((r@254@12 $Ref) (j@255@12 Int)) (!
  (and
    (or (Set_in r@254@12 setOfRef@10@12) (not (Set_in r@254@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in r@254@12 setOfRef@10@12)
          (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12)))))
      (and
        (Set_in r@254@12 setOfRef@10@12)
        (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125-aux|)))
(push) ; 7
(assert (not (forall ((r@254@12 $Ref) (j@255@12 Int)) (!
  (=>
    (and
      (Set_in r@254@12 setOfRef@10@12)
      (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12) setOfRef@10@12))
  :pattern ((Set_in r@254@12 setOfRef@10@12) (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))
  :pattern ((Set_in r@254@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12))
  :pattern ((Set_in r@254@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12) setOfRef@10@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12) setOfRef@10@12))
  :pattern ((Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (forall ((r@254@12 $Ref) (j@255@12 Int)) (!
  (=>
    (and
      (Set_in r@254@12 setOfRef@10@12)
      (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12) setOfRef@10@12))
  :pattern ((Set_in r@254@12 setOfRef@10@12) (Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))
  :pattern ((Set_in r@254@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12))
  :pattern ((Set_in r@254@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12) setOfRef@10@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12) setOfRef@10@12))
  :pattern ((Set_in j@255@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@251@12  $FVF<edges>) r@254@12) j@255@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@150@17@150@125|)))
; [eval] (node_map_image subset res_copy_nodes)
(push) ; 7
(assert (not (Set_subset node_map_image@11@12 res_copy_nodes@205@12)))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (Set_subset node_map_image@11@12 res_copy_nodes@205@12))
; [eval] |(setOfRef intersection res_copy_nodes)| == 0
; [eval] |(setOfRef intersection res_copy_nodes)|
; [eval] (setOfRef intersection res_copy_nodes)
; [eval] (forall r: Ref :: { (r in map_domain(res_node_map)) } { (lookup(res_node_map, r) in res_copy_nodes) } (r in map_domain(res_node_map)) ==> (lookup(res_node_map, r) in res_copy_nodes))
(declare-const r@256@12 $Ref)
(push) ; 7
; [eval] (r in map_domain(res_node_map)) ==> (lookup(res_node_map, r) in res_copy_nodes)
; [eval] (r in map_domain(res_node_map))
; [eval] map_domain(res_node_map)
(push) ; 8
; [then-branch: 41 | r@256@12 in map_domain[Seq[Ref]](res_node_map@204@12) | live]
; [else-branch: 41 | !(r@256@12 in map_domain[Seq[Ref]](res_node_map@204@12)) | live]
(push) ; 9
; [then-branch: 41 | r@256@12 in map_domain[Seq[Ref]](res_node_map@204@12)]
(assert (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) r@256@12))
; [eval] (lookup(res_node_map, r) in res_copy_nodes)
; [eval] lookup(res_node_map, r)
(pop) ; 9
(push) ; 9
; [else-branch: 41 | !(r@256@12 in map_domain[Seq[Ref]](res_node_map@204@12))]
(assert (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) r@256@12)))
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or
  (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) r@256@12))
  (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) r@256@12)))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((r@256@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) r@256@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) r@256@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) r@256@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@204@12)
    r@256@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108-aux|)))
(assert (forall ((r@256@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) r@256@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) r@256@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@204@12)
    r@256@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108-aux|)))
(assert (forall ((r@256@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) r@256@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) r@256@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@204@12 r@256@12) res_copy_nodes@205@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108-aux|)))
(push) ; 7
(assert (not (forall ((r@256@12 $Ref)) (!
  (=>
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) r@256@12)
    (Set_in (lookup<Ref> res_node_map@204@12 r@256@12) res_copy_nodes@205@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) r@256@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@204@12)
    r@256@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@204@12)
    r@256@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@204@12 r@256@12) res_copy_nodes@205@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (forall ((r@256@12 $Ref)) (!
  (=>
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) r@256@12)
    (Set_in (lookup<Ref> res_node_map@204@12 r@256@12) res_copy_nodes@205@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@204@12) r@256@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@204@12)
    r@256@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@204@12 r@256@12) res_copy_nodes@205@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@153@17@153@108|)))
(declare-const r@257@12 $Ref)
(push) ; 7
; [eval] (r in res_copy_nodes)
(assert (Set_in r@257@12 res_copy_nodes@205@12))
(pop) ; 7
(declare-fun inv@258@12 ($Ref) $Ref)
(declare-fun img@259@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((r1@257@12 $Ref) (r2@257@12 $Ref)) (!
  (=>
    (and
      (Set_in r1@257@12 res_copy_nodes@205@12)
      (Set_in r2@257@12 res_copy_nodes@205@12)
      (= r1@257@12 r2@257@12))
    (= r1@257@12 r2@257@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((r@257@12 $Ref)) (!
  (=>
    (Set_in r@257@12 res_copy_nodes@205@12)
    (and (= (inv@258@12 r@257@12) r@257@12) (img@259@12 r@257@12)))
  :pattern ((Set_in r@257@12 res_copy_nodes@205@12))
  :pattern ((inv@258@12 r@257@12))
  :pattern ((img@259@12 r@257@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@259@12 r) (Set_in (inv@258@12 r) res_copy_nodes@205@12))
    (= (inv@258@12 r) r))
  :pattern ((inv@258@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@260@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@258@12 r) res_copy_nodes@205@12)
      (img@259@12 r)
      (= r (inv@258@12 r)))
    ($Perm.min
      (ite
        (and (img@224@12 r) (Set_in (inv@223@12 r) res_copy_nodes@205@12))
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
        (and (img@224@12 r) (Set_in (inv@223@12 r) res_copy_nodes@205@12))
        $Perm.Write
        $Perm.No)
      (pTaken@260@12 r))
    $Perm.No)
  
  :qid |quant-u-140|))))
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
      (Set_in (inv@258@12 r) res_copy_nodes@205@12)
      (img@259@12 r)
      (= r (inv@258@12 r)))
    (= (- $Perm.Write (pTaken@260@12 r)) $Perm.No))
  
  :qid |quant-u-141|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@261@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@224@12 r) (Set_in (inv@223@12 r) res_copy_nodes@205@12))
    (=
      ($FVF.lookup_val (as sm@261@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@261@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
  :qid |qp.fvfValDef78|)))
(declare-const r@262@12 $Ref)
(set-option :timeout 0)
(push) ; 7
; [eval] (r in res_copy_nodes)
(assert (Set_in r@262@12 res_copy_nodes@205@12))
(pop) ; 7
(declare-fun inv@263@12 ($Ref) $Ref)
(declare-fun img@264@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((r1@262@12 $Ref) (r2@262@12 $Ref)) (!
  (=>
    (and
      (Set_in r1@262@12 res_copy_nodes@205@12)
      (Set_in r2@262@12 res_copy_nodes@205@12)
      (= r1@262@12 r2@262@12))
    (= r1@262@12 r2@262@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((r@262@12 $Ref)) (!
  (=>
    (Set_in r@262@12 res_copy_nodes@205@12)
    (and (= (inv@263@12 r@262@12) r@262@12) (img@264@12 r@262@12)))
  :pattern ((Set_in r@262@12 res_copy_nodes@205@12))
  :pattern ((inv@263@12 r@262@12))
  :pattern ((img@264@12 r@262@12))
  :qid |edges-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@264@12 r) (Set_in (inv@263@12 r) res_copy_nodes@205@12))
    (= (inv@263@12 r) r))
  :pattern ((inv@263@12 r))
  :qid |edges-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@265@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@263@12 r) res_copy_nodes@205@12)
      (img@264@12 r)
      (= r (inv@263@12 r)))
    ($Perm.min
      (ite
        (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
        (- $Perm.Write (pTaken@232@12 r))
        $Perm.No)
      $Perm.Write)
    $Perm.No))
(define-fun pTaken@266@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@263@12 r) res_copy_nodes@205@12)
      (img@264@12 r)
      (= r (inv@263@12 r)))
    ($Perm.min
      (ite (= r nodeCopy@86@12) $Perm.Write $Perm.No)
      (- $Perm.Write (pTaken@265@12 r)))
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
        (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
        (- $Perm.Write (pTaken@232@12 r))
        $Perm.No)
      (pTaken@265@12 r))
    $Perm.No)
  
  :qid |quant-u-144|))))
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
      (Set_in (inv@263@12 r) res_copy_nodes@205@12)
      (img@264@12 r)
      (= r (inv@263@12 r)))
    (= (- $Perm.Write (pTaken@265@12 r)) $Perm.No))
  
  :qid |quant-u-145|))))
(check-sat)
; unknown
(pop) ; 7
; 0.01s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 500)
(assert (not (= (- $Perm.Write (pTaken@266@12 nodeCopy@86@12)) $Perm.No)))
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
      (Set_in (inv@263@12 r) res_copy_nodes@205@12)
      (img@264@12 r)
      (= r (inv@263@12 r)))
    (= (- (- $Perm.Write (pTaken@265@12 r)) (pTaken@266@12 r)) $Perm.No))
  
  :qid |quant-u-147|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@267@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@227@12 r) (Set_in (inv@226@12 r) res_copy_nodes@205@12))
      (< $Perm.No (- $Perm.Write (pTaken@232@12 r)))
      false)
    (=
      ($FVF.lookup_edges (as sm@267@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@267@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@206@12)))))))))))) r))
  :qid |qp.fvfValDef79|)))
(assert (forall ((r $Ref)) (!
  (=>
    (= r nodeCopy@86@12)
    (=
      ($FVF.lookup_edges (as sm@267@12  $FVF<edges>) r)
      ($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r)))
  :pattern (($FVF.lookup_edges (as sm@267@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges (as sm@233@12  $FVF<edges>) r))
  :qid |qp.fvfValDef80|)))
(pop) ; 6
(set-option :timeout 0)
(push) ; 6
; [else-branch: 27 | !(|S@102@12| > 0)]
(assert (not (> (Set_card S@102@12) 0)))
(pop) ; 6
; [eval] !(|S| > 0)
; [eval] |S| > 0
; [eval] |S|
(push) ; 6
(set-option :timeout 10)
(assert (not (> (Set_card S@102@12) 0)))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 6
(set-option :timeout 10)
(assert (not (not (> (Set_card S@102@12) 0))))
(check-sat)
; unknown
(pop) ; 6
; 0.00s
; (get-info :all-statistics)
; [then-branch: 42 | !(|S@102@12| > 0) | live]
; [else-branch: 42 | |S@102@12| > 0 | live]
(set-option :timeout 0)
(push) ; 6
; [then-branch: 42 | !(|S@102@12| > 0)]
(assert (not (> (Set_card S@102@12) 0)))
; [eval] nodeCopy != null
; [eval] (nodeCopy in res_copy_nodes)
; [eval] |(setOfRef intersection res_copy_nodes)| == 0
; [eval] |(setOfRef intersection res_copy_nodes)|
; [eval] (setOfRef intersection res_copy_nodes)
(declare-const x@268@12 $Ref)
(push) ; 7
; [eval] (x in setOfRef)
(assert (Set_in x@268@12 setOfRef@10@12))
(pop) ; 7
(declare-fun inv@269@12 ($Ref) $Ref)
(declare-fun img@270@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 7
(assert (not (forall ((x@268@12 $Ref)) (!
  (=>
    (Set_in x@268@12 setOfRef@10@12)
    (or (= rd@12@12 $Perm.No) (< $Perm.No rd@12@12)))
  
  :qid |quant-u-148|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((x1@268@12 $Ref) (x2@268@12 $Ref)) (!
  (=>
    (and
      (and (Set_in x1@268@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (and (Set_in x2@268@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (= x1@268@12 x2@268@12))
    (= x1@268@12 x2@268@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@268@12 $Ref)) (!
  (=>
    (and (Set_in x@268@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@269@12 x@268@12) x@268@12) (img@270@12 x@268@12)))
  :pattern ((Set_in x@268@12 setOfRef@10@12))
  :pattern ((inv@269@12 x@268@12))
  :pattern ((img@270@12 x@268@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@270@12 r)
      (and (Set_in (inv@269@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@269@12 r) r))
  :pattern ((inv@269@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@271@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@269@12 r) setOfRef@10@12)
      (img@270@12 r)
      (= r (inv@269@12 r)))
    ($Perm.min
      (ite
        (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      rd@12@12)
    $Perm.No))
(define-fun pTaken@272@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@269@12 r) setOfRef@10@12)
      (img@270@12 r)
      (= r (inv@269@12 r)))
    ($Perm.min
      (ite
        (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)
      (- rd@12@12 (pTaken@271@12 r)))
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
        (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (pTaken@271@12 r))
    $Perm.No)
  
  :qid |quant-u-150|))))
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
      (Set_in (inv@269@12 r) setOfRef@10@12)
      (img@270@12 r)
      (= r (inv@269@12 r)))
    (= (- rd@12@12 (pTaken@271@12 r)) $Perm.No))
  
  :qid |quant-u-151|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@273@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@273@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
  :pattern (($FVF.lookup_val (as sm@273@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
  :qid |qp.fvfValDef81|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_val (as sm@273@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@273@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef82|)))
; [eval] (forall x: Ref :: { (x in setOfRef) } (x in setOfRef) ==> x.val == old(x.val))
(declare-const x@274@12 $Ref)
(set-option :timeout 0)
(push) ; 7
; [eval] (x in setOfRef) ==> x.val == old(x.val)
; [eval] (x in setOfRef)
(push) ; 8
; [then-branch: 43 | x@274@12 in setOfRef@10@12 | live]
; [else-branch: 43 | !(x@274@12 in setOfRef@10@12) | live]
(push) ; 9
; [then-branch: 43 | x@274@12 in setOfRef@10@12]
(assert (Set_in x@274@12 setOfRef@10@12))
; [eval] x.val == old(x.val)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_val (as sm@273@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
    :pattern (($FVF.lookup_val (as sm@273@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
    :qid |qp.fvfValDef81|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
      (=
        ($FVF.lookup_val (as sm@273@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
    :pattern (($FVF.lookup_val (as sm@273@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
    :qid |qp.fvfValDef82|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@111@12 x@274@12) (Set_in (inv@110@12 x@274@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and
        (img@127@12 x@274@12)
        (Set_in (inv@126@12 x@274@12) res_copy_nodes@107@12))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [eval] old(x.val)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
    :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
    :qid |qp.fvfValDef23|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
      (=
        ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
        ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
    :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
    :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
    :qid |qp.fvfValDef24|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@19@12 x@274@12) (Set_in (inv@18@12 x@274@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and
        (img@28@12 x@274@12)
        (Set_in (inv@27@12 x@274@12) node_map_image@11@12))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 43 | !(x@274@12 in setOfRef@10@12)]
(assert (not (Set_in x@274@12 setOfRef@10@12)))
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@273@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
  :pattern (($FVF.lookup_val (as sm@273@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
  :qid |qp.fvfValDef81|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_val (as sm@273@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@273@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef82|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef24|)))
; Joined path conditions
(assert (or (not (Set_in x@274@12 setOfRef@10@12)) (Set_in x@274@12 setOfRef@10@12)))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@111@12 r) (Set_in (inv@110@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@273@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r)))
  :pattern (($FVF.lookup_val (as sm@273@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second $t@108@12)))) r))
  :qid |qp.fvfValDef81|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_val (as sm@273@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@273@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef82|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@19@12 r) (Set_in (inv@18@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))) r))
  :qid |qp.fvfValDef23|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@28@12 r) (Set_in (inv@27@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@113@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef24|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@274@12 $Ref)) (!
  (or (not (Set_in x@274@12 setOfRef@10@12)) (Set_in x@274@12 setOfRef@10@12))
  :pattern ((Set_in x@274@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@107@11@107@65-aux|)))
(push) ; 7
(assert (not (forall ((x@274@12 $Ref)) (!
  (=>
    (Set_in x@274@12 setOfRef@10@12)
    (=
      ($FVF.lookup_val (as sm@273@12  $FVF<val>) x@274@12)
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) x@274@12)))
  :pattern ((Set_in x@274@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@107@11@107@65|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (forall ((x@274@12 $Ref)) (!
  (=>
    (Set_in x@274@12 setOfRef@10@12)
    (=
      ($FVF.lookup_val (as sm@273@12  $FVF<val>) x@274@12)
      ($FVF.lookup_val (as sm@113@12  $FVF<val>) x@274@12)))
  :pattern ((Set_in x@274@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@107@11@107@65|)))
(declare-const x@275@12 $Ref)
(push) ; 7
; [eval] (x in setOfRef)
(assert (Set_in x@275@12 setOfRef@10@12))
(pop) ; 7
(declare-fun inv@276@12 ($Ref) $Ref)
(declare-fun img@277@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
(push) ; 7
(assert (not (forall ((x@275@12 $Ref)) (!
  (=>
    (Set_in x@275@12 setOfRef@10@12)
    (or (= rd@12@12 $Perm.No) (< $Perm.No rd@12@12)))
  
  :qid |quant-u-152|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((x1@275@12 $Ref) (x2@275@12 $Ref)) (!
  (=>
    (and
      (and (Set_in x1@275@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (and (Set_in x2@275@12 setOfRef@10@12) (< $Perm.No rd@12@12))
      (= x1@275@12 x2@275@12))
    (= x1@275@12 x2@275@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@275@12 $Ref)) (!
  (=>
    (and (Set_in x@275@12 setOfRef@10@12) (< $Perm.No rd@12@12))
    (and (= (inv@276@12 x@275@12) x@275@12) (img@277@12 x@275@12)))
  :pattern ((Set_in x@275@12 setOfRef@10@12))
  :pattern ((inv@276@12 x@275@12))
  :pattern ((img@277@12 x@275@12))
  :qid |edges-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and
      (img@277@12 r)
      (and (Set_in (inv@276@12 r) setOfRef@10@12) (< $Perm.No rd@12@12)))
    (= (inv@276@12 r) r))
  :pattern ((inv@276@12 r))
  :qid |edges-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@278@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@276@12 r) setOfRef@10@12)
      (img@277@12 r)
      (= r (inv@276@12 r)))
    ($Perm.min
      (ite
        (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)
      rd@12@12)
    $Perm.No))
(define-fun pTaken@279@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@276@12 r) setOfRef@10@12)
      (img@277@12 r)
      (= r (inv@276@12 r)))
    ($Perm.min
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (- rd@12@12 (pTaken@278@12 r)))
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
        (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)
      (pTaken@278@12 r))
    $Perm.No)
  
  :qid |quant-u-154|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 10)
(assert (not (forall ((r $Ref)) (!
  (= (pTaken@278@12 r) $Perm.No)
  
  :qid |quant-u-155|))))
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
      (Set_in (inv@276@12 r) setOfRef@10@12)
      (img@277@12 r)
      (= r (inv@276@12 r)))
    (= (- rd@12@12 (pTaken@278@12 r)) $Perm.No))
  
  :qid |quant-u-156|))))
(check-sat)
; unknown
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Chunk depleted?
(set-option :timeout 0)
(push) ; 7
(set-option :timeout 500)
(assert (not (forall ((r $Ref)) (!
  (=
    (-
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (pTaken@279@12 r))
    $Perm.No)
  
  :qid |quant-u-157|))))
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
      (Set_in (inv@276@12 r) setOfRef@10@12)
      (img@277@12 r)
      (= r (inv@276@12 r)))
    (= (- (- rd@12@12 (pTaken@278@12 r)) (pTaken@279@12 r)) $Perm.No))
  
  :qid |quant-u-158|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@280@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@280@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@280@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef83|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@280@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@280@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef84|)))
; [eval] (forall x: Ref :: { (x in setOfRef) } (x in setOfRef) ==> x.edges == old(x.edges))
(declare-const x@281@12 $Ref)
(set-option :timeout 0)
(push) ; 7
; [eval] (x in setOfRef) ==> x.edges == old(x.edges)
; [eval] (x in setOfRef)
(push) ; 8
; [then-branch: 44 | x@281@12 in setOfRef@10@12 | live]
; [else-branch: 44 | !(x@281@12 in setOfRef@10@12) | live]
(push) ; 9
; [then-branch: 44 | x@281@12 in setOfRef@10@12]
(assert (Set_in x@281@12 setOfRef@10@12))
; [eval] x.edges == old(x.edges)
(declare-const sm@282@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef85|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef86|)))
(declare-const pm@283@12 $FPM)
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@283@12  $FPM) r)
    (+
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@283@12  $FPM) r))
  :qid |qp.resPrmSumDef87|)))
(push) ; 10
(assert (not (< $Perm.No ($FVF.perm_edges (as pm@283@12  $FPM) x@281@12))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
; [eval] old(x.edges)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
    :qid |qp.fvfValDef26|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
      (=
        ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
    :qid |qp.fvfValDef27|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@22@12 x@281@12) (Set_in (inv@21@12 x@281@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and
        (img@31@12 x@281@12)
        (Set_in (inv@30@12 x@281@12) node_map_image@11@12))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 44 | !(x@281@12 in setOfRef@10@12)]
(assert (not (Set_in x@281@12 setOfRef@10@12)))
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef85|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef86|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@283@12  $FPM) r)
    (+
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@283@12  $FPM) r))
  :qid |qp.resPrmSumDef87|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef26|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef27|)))
; Joined path conditions
(assert (or (not (Set_in x@281@12 setOfRef@10@12)) (Set_in x@281@12 setOfRef@10@12)))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef85|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef86|)))
(assert (forall ((r $Ref)) (!
  (=
    ($FVF.perm_edges (as pm@283@12  $FPM) r)
    (+
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        rd@12@12
        $Perm.No)
      (ite
        (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)))
  :pattern (($FVF.perm_edges (as pm@283@12  $FPM) r))
  :qid |qp.resPrmSumDef87|)))
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@22@12 r) (Set_in (inv@21@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12))))))) r))
  :qid |qp.fvfValDef26|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@31@12 r) (Set_in (inv@30@12 r) node_map_image@11@12))
    (=
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@119@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@16@12)))))))))) r))
  :qid |qp.fvfValDef27|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@281@12 $Ref)) (!
  (or (not (Set_in x@281@12 setOfRef@10@12)) (Set_in x@281@12 setOfRef@10@12))
  :pattern ((Set_in x@281@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@109@11@109@69-aux|)))
(push) ; 7
(assert (not (forall ((x@281@12 $Ref)) (!
  (=>
    (Set_in x@281@12 setOfRef@10@12)
    (=
      ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@281@12)
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) x@281@12)))
  :pattern ((Set_in x@281@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@109@11@109@69|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (forall ((x@281@12 $Ref)) (!
  (=>
    (Set_in x@281@12 setOfRef@10@12)
    (=
      ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@281@12)
      ($FVF.lookup_edges (as sm@119@12  $FVF<edges>) x@281@12)))
  :pattern ((Set_in x@281@12 setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@109@11@109@69|)))
; [eval] (forall x: Ref, i: Int :: { (x in setOfRef), (i in edges_domain(x.edges)) } { (x in setOfRef), edge_lookup(x.edges, i) } { (x in setOfRef), (edge_lookup(x.edges, i) in setOfRef) } { edges_domain(x.edges), edge_lookup(x.edges, i) } { edges_domain(x.edges), (edge_lookup(x.edges, i) in setOfRef) } { (i in edges_domain(x.edges)) } { (edge_lookup(x.edges, i) in setOfRef) } (x in setOfRef) && (i in edges_domain(x.edges)) ==> (edge_lookup(x.edges, i) in setOfRef))
(declare-const x@284@12 $Ref)
(declare-const i@285@12 Int)
(push) ; 7
; [eval] (x in setOfRef) && (i in edges_domain(x.edges)) ==> (edge_lookup(x.edges, i) in setOfRef)
; [eval] (x in setOfRef) && (i in edges_domain(x.edges))
; [eval] (x in setOfRef)
(push) ; 8
; [then-branch: 45 | !(x@284@12 in setOfRef@10@12) | live]
; [else-branch: 45 | x@284@12 in setOfRef@10@12 | live]
(push) ; 9
; [then-branch: 45 | !(x@284@12 in setOfRef@10@12)]
(assert (not (Set_in x@284@12 setOfRef@10@12)))
(pop) ; 9
(push) ; 9
; [else-branch: 45 | x@284@12 in setOfRef@10@12]
(assert (Set_in x@284@12 setOfRef@10@12))
; [eval] (i in edges_domain(x.edges))
; [eval] edges_domain(x.edges)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
    :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
    :qid |qp.fvfValDef85|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
      (=
        ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
    :qid |qp.fvfValDef86|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@117@12 x@284@12) (Set_in (inv@116@12 x@284@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and
        (img@130@12 x@284@12)
        (Set_in (inv@129@12 x@284@12) res_copy_nodes@107@12))
      $Perm.Write
      $Perm.No)))))
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
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef85|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef86|)))
(assert (or (Set_in x@284@12 setOfRef@10@12) (not (Set_in x@284@12 setOfRef@10@12))))
(push) ; 8
; [then-branch: 46 | x@284@12 in setOfRef@10@12 && i@285@12 in edges_domain[Set[Int]](Lookup(edges, sm@282@12, x@284@12)) | live]
; [else-branch: 46 | !(x@284@12 in setOfRef@10@12 && i@285@12 in edges_domain[Set[Int]](Lookup(edges, sm@282@12, x@284@12))) | live]
(push) ; 9
; [then-branch: 46 | x@284@12 in setOfRef@10@12 && i@285@12 in edges_domain[Set[Int]](Lookup(edges, sm@282@12, x@284@12))]
(assert (and
  (Set_in x@284@12 setOfRef@10@12)
  (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12)))))
; [eval] (edge_lookup(x.edges, i) in setOfRef)
; [eval] edge_lookup(x.edges, i)
(assert (and
  (forall ((r $Ref)) (!
    (=>
      (ite
        (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
        (< $Perm.No rd@12@12)
        false)
      (=
        ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
    :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
    :qid |qp.fvfValDef85|))
  (forall ((r $Ref)) (!
    (=>
      (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
      (=
        ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
        ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
    :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
    :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
    :qid |qp.fvfValDef86|))))
(push) ; 10
(assert (not (<
  $Perm.No
  (+
    (ite
      (and (img@117@12 x@284@12) (Set_in (inv@116@12 x@284@12) setOfRef@10@12))
      rd@12@12
      $Perm.No)
    (ite
      (and
        (img@130@12 x@284@12)
        (Set_in (inv@129@12 x@284@12) res_copy_nodes@107@12))
      $Perm.Write
      $Perm.No)))))
(check-sat)
; unsat
(pop) ; 10
; 0.00s
; (get-info :all-statistics)
(pop) ; 9
(push) ; 9
; [else-branch: 46 | !(x@284@12 in setOfRef@10@12 && i@285@12 in edges_domain[Set[Int]](Lookup(edges, sm@282@12, x@284@12)))]
(assert (not
  (and
    (Set_in x@284@12 setOfRef@10@12)
    (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))))
(pop) ; 9
(pop) ; 8
; Joined path conditions
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef85|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef86|)))
; Joined path conditions
(assert (or
  (not
    (and
      (Set_in x@284@12 setOfRef@10@12)
      (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12)))))
  (and
    (Set_in x@284@12 setOfRef@10@12)
    (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
(assert (forall ((r $Ref)) (!
  (=>
    (ite
      (and (img@117@12 r) (Set_in (inv@116@12 r) setOfRef@10@12))
      (< $Perm.No rd@12@12)
      false)
    (=
      ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r)))
  :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12)))))) r))
  :qid |qp.fvfValDef85|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@282@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef86|)))
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@284@12 $Ref) (i@285@12 Int)) (!
  (and
    (or (Set_in x@284@12 setOfRef@10@12) (not (Set_in x@284@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@284@12 setOfRef@10@12)
          (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12)))))
      (and
        (Set_in x@284@12 setOfRef@10@12)
        (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))))
  :pattern ((Set_in x@284@12 setOfRef@10@12) (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@284@12 $Ref) (i@285@12 Int)) (!
  (and
    (or (Set_in x@284@12 setOfRef@10@12) (not (Set_in x@284@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@284@12 setOfRef@10@12)
          (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12)))))
      (and
        (Set_in x@284@12 setOfRef@10@12)
        (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))))
  :pattern ((Set_in x@284@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@284@12 $Ref) (i@285@12 Int)) (!
  (and
    (or (Set_in x@284@12 setOfRef@10@12) (not (Set_in x@284@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@284@12 setOfRef@10@12)
          (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12)))))
      (and
        (Set_in x@284@12 setOfRef@10@12)
        (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))))
  :pattern ((Set_in x@284@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@284@12 $Ref) (i@285@12 Int)) (!
  (and
    (or (Set_in x@284@12 setOfRef@10@12) (not (Set_in x@284@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@284@12 setOfRef@10@12)
          (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12)))))
      (and
        (Set_in x@284@12 setOfRef@10@12)
        (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@284@12 $Ref) (i@285@12 Int)) (!
  (and
    (or (Set_in x@284@12 setOfRef@10@12) (not (Set_in x@284@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@284@12 setOfRef@10@12)
          (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12)))))
      (and
        (Set_in x@284@12 setOfRef@10@12)
        (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@284@12 $Ref) (i@285@12 Int)) (!
  (and
    (or (Set_in x@284@12 setOfRef@10@12) (not (Set_in x@284@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@284@12 setOfRef@10@12)
          (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12)))))
      (and
        (Set_in x@284@12 setOfRef@10@12)
        (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))))
  :pattern ((Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(assert (forall ((x@284@12 $Ref) (i@285@12 Int)) (!
  (and
    (or (Set_in x@284@12 setOfRef@10@12) (not (Set_in x@284@12 setOfRef@10@12)))
    (or
      (not
        (and
          (Set_in x@284@12 setOfRef@10@12)
          (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12)))))
      (and
        (Set_in x@284@12 setOfRef@10@12)
        (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119-aux|)))
(push) ; 7
(assert (not (forall ((x@284@12 $Ref) (i@285@12 Int)) (!
  (=>
    (and
      (Set_in x@284@12 setOfRef@10@12)
      (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12) setOfRef@10@12))
  :pattern ((Set_in x@284@12 setOfRef@10@12) (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))
  :pattern ((Set_in x@284@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12))
  :pattern ((Set_in x@284@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12) setOfRef@10@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12) setOfRef@10@12))
  :pattern ((Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (forall ((x@284@12 $Ref) (i@285@12 Int)) (!
  (=>
    (and
      (Set_in x@284@12 setOfRef@10@12)
      (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))
    (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12) setOfRef@10@12))
  :pattern ((Set_in x@284@12 setOfRef@10@12) (Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))
  :pattern ((Set_in x@284@12 setOfRef@10@12) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12))
  :pattern ((Set_in x@284@12 setOfRef@10@12) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12) setOfRef@10@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12)) (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12))
  :pattern ((edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12)) (Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12) setOfRef@10@12))
  :pattern ((Set_in i@285@12 (edges_domain<Set<Int>> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12))))
  :pattern ((Set_in (edge_lookup<Ref> ($FVF.lookup_edges (as sm@282@12  $FVF<edges>) x@284@12) i@285@12) setOfRef@10@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@110@11@110@119|)))
; [eval] res_copy_nodes == (res_copy_nodes union old(node_map_image))
; [eval] (res_copy_nodes union old(node_map_image))
; [eval] old(node_map_image)
(push) ; 7
(assert (not (Set_equal res_copy_nodes@107@12 (Set_union res_copy_nodes@107@12 node_map_image@11@12))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (Set_equal res_copy_nodes@107@12 (Set_union res_copy_nodes@107@12 node_map_image@11@12)))
; [eval] (forall x: Ref :: { (x in map_domain(res_node_map)) } { (lookup(res_node_map, x) in res_copy_nodes) } (x in map_domain(res_node_map)) ==> (lookup(res_node_map, x) in res_copy_nodes))
(declare-const x@286@12 $Ref)
(push) ; 7
; [eval] (x in map_domain(res_node_map)) ==> (lookup(res_node_map, x) in res_copy_nodes)
; [eval] (x in map_domain(res_node_map))
; [eval] map_domain(res_node_map)
(push) ; 8
; [then-branch: 47 | x@286@12 in map_domain[Seq[Ref]](res_node_map@106@12) | live]
; [else-branch: 47 | !(x@286@12 in map_domain[Seq[Ref]](res_node_map@106@12)) | live]
(push) ; 9
; [then-branch: 47 | x@286@12 in map_domain[Seq[Ref]](res_node_map@106@12)]
(assert (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@286@12))
; [eval] (lookup(res_node_map, x) in res_copy_nodes)
; [eval] lookup(res_node_map, x)
(pop) ; 9
(push) ; 9
; [else-branch: 47 | !(x@286@12 in map_domain[Seq[Ref]](res_node_map@106@12))]
(assert (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@286@12)))
(pop) ; 9
(pop) ; 8
; Joined path conditions
; Joined path conditions
(assert (or
  (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@286@12))
  (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@286@12)))
(pop) ; 7
; Nested auxiliary terms: globals (aux)
; Nested auxiliary terms: non-globals (aux)
(assert (forall ((x@286@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@286@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@286@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@286@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    x@286@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102-aux|)))
(assert (forall ((x@286@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@286@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@286@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    x@286@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102-aux|)))
(assert (forall ((x@286@12 $Ref)) (!
  (or
    (not (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@286@12))
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@286@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@106@12 x@286@12) res_copy_nodes@107@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102-aux|)))
(push) ; 7
(assert (not (forall ((x@286@12 $Ref)) (!
  (=>
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@286@12)
    (Set_in (lookup<Ref> res_node_map@106@12 x@286@12) res_copy_nodes@107@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@286@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    x@286@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    x@286@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@106@12 x@286@12) res_copy_nodes@107@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
(assert (forall ((x@286@12 $Ref)) (!
  (=>
    (Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@286@12)
    (Set_in (lookup<Ref> res_node_map@106@12 x@286@12) res_copy_nodes@107@12))
  :pattern ((Seq_contains (map_domain<Seq<Ref>> res_node_map@106@12) x@286@12))
  :pattern ((Seq_contains_trigger
    (map_domain<Seq<Ref>> res_node_map@106@12)
    x@286@12))
  :pattern ((Set_in (lookup<Ref> res_node_map@106@12 x@286@12) res_copy_nodes@107@12))
  :qid |prog./Users/raoulvandoren/Desktop/Master/Master_Semester_3/silicon/silver/src/test/resources/examples/graph-copy/graph-copy.vpr@112@11@112@102|)))
(declare-const x@287@12 $Ref)
(push) ; 7
; [eval] (x in res_copy_nodes)
(assert (Set_in x@287@12 res_copy_nodes@107@12))
(pop) ; 7
(declare-fun inv@288@12 ($Ref) $Ref)
(declare-fun img@289@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((x1@287@12 $Ref) (x2@287@12 $Ref)) (!
  (=>
    (and
      (Set_in x1@287@12 res_copy_nodes@107@12)
      (Set_in x2@287@12 res_copy_nodes@107@12)
      (= x1@287@12 x2@287@12))
    (= x1@287@12 x2@287@12))
  
  :qid |val-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@287@12 $Ref)) (!
  (=>
    (Set_in x@287@12 res_copy_nodes@107@12)
    (and (= (inv@288@12 x@287@12) x@287@12) (img@289@12 x@287@12)))
  :pattern ((Set_in x@287@12 res_copy_nodes@107@12))
  :pattern ((inv@288@12 x@287@12))
  :pattern ((img@289@12 x@287@12))
  :qid |val-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@289@12 r) (Set_in (inv@288@12 r) res_copy_nodes@107@12))
    (= (inv@288@12 r) r))
  :pattern ((inv@288@12 r))
  :qid |val-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@290@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@288@12 r) res_copy_nodes@107@12)
      (img@289@12 r)
      (= r (inv@288@12 r)))
    ($Perm.min
      (ite
        (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
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
        (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)
      (pTaken@290@12 r))
    $Perm.No)
  
  :qid |quant-u-161|))))
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
      (Set_in (inv@288@12 r) res_copy_nodes@107@12)
      (img@289@12 r)
      (= r (inv@288@12 r)))
    (= (- $Perm.Write (pTaken@290@12 r)) $Perm.No))
  
  :qid |quant-u-162|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@291@12 $FVF<val>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@127@12 r) (Set_in (inv@126@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_val (as sm@291@12  $FVF<val>) r)
      ($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_val (as sm@291@12  $FVF<val>) r))
  :pattern (($FVF.lookup_val ($SortWrappers.$SnapTo$FVF<val> ($Snap.first ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef88|)))
(declare-const x@292@12 $Ref)
(set-option :timeout 0)
(push) ; 7
; [eval] (x in res_copy_nodes)
(assert (Set_in x@292@12 res_copy_nodes@107@12))
(pop) ; 7
(declare-fun inv@293@12 ($Ref) $Ref)
(declare-fun img@294@12 ($Ref) Bool)
; Nested auxiliary terms: globals
; Nested auxiliary terms: non-globals
; Check receiver injectivity
(push) ; 7
(assert (not (forall ((x1@292@12 $Ref) (x2@292@12 $Ref)) (!
  (=>
    (and
      (Set_in x1@292@12 res_copy_nodes@107@12)
      (Set_in x2@292@12 res_copy_nodes@107@12)
      (= x1@292@12 x2@292@12))
    (= x1@292@12 x2@292@12))
  
  :qid |edges-rcvrInj|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Definitional axioms for inverse functions
(assert (forall ((x@292@12 $Ref)) (!
  (=>
    (Set_in x@292@12 res_copy_nodes@107@12)
    (and (= (inv@293@12 x@292@12) x@292@12) (img@294@12 x@292@12)))
  :pattern ((Set_in x@292@12 res_copy_nodes@107@12))
  :pattern ((inv@293@12 x@292@12))
  :pattern ((img@294@12 x@292@12))
  :qid |edges-invOfFct|)))
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@294@12 r) (Set_in (inv@293@12 r) res_copy_nodes@107@12))
    (= (inv@293@12 r) r))
  :pattern ((inv@293@12 r))
  :qid |edges-fctOfInv|)))
; Precomputing data for removing quantified permissions
(define-fun pTaken@295@12 ((r $Ref)) $Perm
  (ite
    (and
      (Set_in (inv@293@12 r) res_copy_nodes@107@12)
      (img@294@12 r)
      (= r (inv@293@12 r)))
    ($Perm.min
      (ite
        (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
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
        (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
        $Perm.Write
        $Perm.No)
      (pTaken@295@12 r))
    $Perm.No)
  
  :qid |quant-u-165|))))
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
      (Set_in (inv@293@12 r) res_copy_nodes@107@12)
      (img@294@12 r)
      (= r (inv@293@12 r)))
    (= (- $Perm.Write (pTaken@295@12 r)) $Perm.No))
  
  :qid |quant-u-166|))))
(check-sat)
; unsat
(pop) ; 7
; 0.00s
; (get-info :all-statistics)
; Final check if taken enough permissions
; Done removing quantified permissions
(declare-const sm@296@12 $FVF<edges>)
; Definitional axioms for snapshot map values
(assert (forall ((r $Ref)) (!
  (=>
    (and (img@130@12 r) (Set_in (inv@129@12 r) res_copy_nodes@107@12))
    (=
      ($FVF.lookup_edges (as sm@296@12  $FVF<edges>) r)
      ($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r)))
  :pattern (($FVF.lookup_edges (as sm@296@12  $FVF<edges>) r))
  :pattern (($FVF.lookup_edges ($SortWrappers.$SnapTo$FVF<edges> ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second ($Snap.second $t@108@12))))))))))))) r))
  :qid |qp.fvfValDef89|)))
(pop) ; 6
(set-option :timeout 0)
(push) ; 6
; [else-branch: 42 | |S@102@12| > 0]
(assert (> (Set_card S@102@12) 0))
(pop) ; 6
(pop) ; 5
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch: 14 | has_node[Bool](node_map@9@12, this@8@12)]
(assert (has_node<Bool> node_map@9@12 this@8@12))
(pop) ; 3
(pop) ; 2
(pop) ; 1
