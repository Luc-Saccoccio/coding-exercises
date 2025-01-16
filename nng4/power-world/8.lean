/-
induction n with d hd
rw [pow_zero, mul_zero, pow_zero]
rfl
rw [mul_succ]
rw [pow_add]
rw [pow_succ]
rw [hd]
rfl
-/
