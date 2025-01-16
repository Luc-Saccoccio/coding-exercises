/-
intro h
induction n with d hd
repeat rw [zero_add] at h
exact h
repeat rw [succ_add] at h
apply succ_inj at h
exact (hd h)
-/
