/-
  induction a with d hd
  rw [zero_add]
  rw [add_zero]
  rfl
  rw [succ_add]
  rw [add_succ]
  rw [hd]
  rfl
-/
