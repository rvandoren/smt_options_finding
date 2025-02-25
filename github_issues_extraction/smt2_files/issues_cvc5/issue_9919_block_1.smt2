(set-logic QF_SLIA)
(set-option :produce-models true)
(set-option :tlimit-per 2500)
(set-option :seed 42)
(set-option :sat-random-seed 42)

;; value for x declared on test1.rsl:4:3
(declare-const |Test1.T.x.value| String)
(define-const |Test1.T.x.valid| Bool true)
;; value for y declared on test1.rsl:5:3
(declare-const |Test1.T.y.value| Bool)
(declare-const |Test1.T.y.valid| Bool)
(assert |Test1.T.x.valid|)
;; result of len(x) at test1.rsl:9:3
(define-const |tmp.1| Int (str.len |Test1.T.x.value|))
;; result of len(x) > 10 at test1.rsl:9:10
(define-const |tmp.2| Bool (> |tmp.1| 10))
(assert |tmp.2|)
(assert |Test1.T.x.valid|)
;; result of kitten in x at test1.rsl:10:12
(define-const |tmp.3| Bool (str.contains |Test1.T.x.value| "kitten"))
(assert |tmp.3|)
(assert |Test1.T.x.valid|)
;; result of AA in x at test1.rsl:11:12
(define-const |tmp.4| Bool (str.contains |Test1.T.x.value| "AA"))
;; result of not AA in x at test1.rsl:11:8
(define-const |tmp.5| Bool (not |tmp.4|))
(assert |tmp.5|)
(assert |Test1.T.x.valid|)
;; result of startswith(x, m) at test1.rsl:12:3
(define-const |tmp.6| Bool (str.prefixof "m" |Test1.T.x.value|))
(assert |tmp.6|)
(assert |Test1.T.x.valid|)
;; result of endswith(x, ?) at test1.rsl:13:3
(define-const |tmp.7| Bool (str.suffixof "?" |Test1.T.x.value|))
(assert |tmp.7|)
;; validity check for y
(assert (not |Test1.T.y.valid|))
(check-sat)