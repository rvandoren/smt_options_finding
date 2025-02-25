(set-option :produce-models true)
(set-logic QF_ABV)

; Variables declaration
(declare-fun eax0 () (_ BitVec 32))
(declare-fun ebx0 () (_ BitVec 32))
(declare-fun ecx0 () (_ BitVec 32))

; Entry contraints
(assert (= eax0 (_ bv1 32)))
(assert (= ebx0 (_ bv2 32)))
(assert (= ecx0 (_ bv8 32)))

; Code instructions representation
(define-fun ebx1 () (_ BitVec 32) (bvadd ebx0 eax0))    ; ADD EBX, EAX
(define-fun ecx1 () (_ BitVec 32) (bvsub ecx0 ebx1))    ; SUB ECX, EBX

; Get final values
(check-sat)