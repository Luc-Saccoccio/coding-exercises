/-
  induction n with d hd
  rw [add_zero, pow_zero, mul_one]
  rfl
  rw [add_succ, pow_succ]
  rw [hd]
  rw [pow_succ]
  rw [mul_assoc]
  rfl
-/
