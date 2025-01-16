/-
  induction b with d hd
  rw [mul_zero]
  rw [zero_mul]
  rfl
  rw [mul_succ]
  rw [succ_mul]
  rw [hd]
  rfl
-/
