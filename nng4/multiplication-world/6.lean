/-
  induction m with d hd
  rw [mul_zero, add_zero]
  rfl
  rw [mul_succ, add_succ]
  rw [succ_add]
  rw [succ_eq_add_one]
  rw [succ_eq_add_one]
  nth_rewrite 2 [two_eq_succ_one]
  rw [succ_eq_add_one]
  rw [hd]
  rw [←add_assoc]
  rfl
-/
