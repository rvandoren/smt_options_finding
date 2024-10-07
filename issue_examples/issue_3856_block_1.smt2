(set-option :fp.xform.bit_blast true)
(set-option :fp.xform.scale true)
(assert (distinct (cos 0.0) 1.0))
(check-sat)