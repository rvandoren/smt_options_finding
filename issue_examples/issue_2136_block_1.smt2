(set-option :produce-models true)
(set-logic qf_fpbv)
(define-fun s8 () (_ bitvec 8) #x00)
(define-fun s1 () roundingmode roundnearesttiestoeven)
(declare-fun s0 () (_ bitvec 8))
(define-fun s2 () (_ floatingpoint  8 24) ((_ to_fp 8 24) s1 s0))
(define-fun s3 () bool (fp.isnan s2))
(define-fun s4 () bool (fp.isinfinite s2))
(define-fun s5 () bool (or s3 s4))
(define-fun s6 () bool (not s5))
(define-fun s7 () (_ bitvec 8) ((_ fp.to_sbv 8) s1 s2))
(define-fun s9 () (_ bitvec 8) (ite s6 s7 s8))
(define-fun s10 () bool (= s0 s9))
(assert (not s10))
(check-sat)