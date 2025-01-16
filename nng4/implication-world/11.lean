/-
intro h
repeat rw [add_succ] at h
rw [add_zero] at h
repeat apply succ_inj at h
exact (zero_ne_succ 0 h)
-/
