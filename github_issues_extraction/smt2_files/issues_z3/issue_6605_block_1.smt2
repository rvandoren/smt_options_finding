(set-option :timeout 10000)

(declare-fun e () Int)
(declare-fun i () Int)
(declare-fun s () (Seq Int))

(assert (not (<= (seq.len s) i)))
(assert (<= 0 i))

(assert (not (seq.contains (seq.extract s 0 i) (seq.unit e))))
(assert (seq.contains s (seq.unit e)))
(assert (= s (seq.++ (seq.extract s 0 i) (seq.extract s i (+ (seq.len s) (* (- 1) i))))))
(assert (not (seq.contains (seq.++ (seq.extract s 0 i) (seq.extract s i (+ (seq.len s) (* (- 1) i)))) (seq.unit e))))

(check-sat)