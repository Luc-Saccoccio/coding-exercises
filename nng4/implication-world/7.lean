/-
intro h
repeat rw [←succ_eq_add_one] at h
exact (succ_inj x y h)
-/
