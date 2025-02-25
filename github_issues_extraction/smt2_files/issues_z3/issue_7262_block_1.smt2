(set-option :opt.priority lex))
; custom Optional datatype to encode nillable types
(declare-datatypes ((Optional 1)) ((par (T) ((nil) (value (val T))))))

(declare-const d (Optional Int))
(declare-const e (Optional Int))

; The basic variable used to constraint the domain and to express optimization criteria
(declare-const d__basic Int)
(assert (or (= d (as nil (Optional Int))) (= d (value d__basic))))
; Assert the domain [0..1000]
(assert (and (>= d__basic 0) (<= d__basic 1000)))


; The basic variable used to constraint the domain and to express optimization criteria
(declare-const e__basic Int)
(assert (or (= e (as nil (Optional Int))) (= e (value e__basic))))
; Assert the domain [0..1000]
(assert (and (>= e__basic 0) (<= e__basic 1000)))

; The actual constraint expressed on the optional type (d <= e && e = 1000)
(assert (match d (
(nil false)
((value lhs) (match e (
(nil false)
((value rhs) (and (<= lhs rhs) (= rhs 1000)) )) )))))

(maximize d__basic)
(maximize e__basic)

(check-sat)