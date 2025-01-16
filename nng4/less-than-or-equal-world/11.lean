/-
cases x
left
rfl
rw [two_eq_succ_one] at hx
apply succ_le_succ at hx
apply le_one at hx
cases hx
right
left
rw [h, one_eq_succ_zero]
rfl
right
right
rw [h, two_eq_succ_one]
rfl
-/
