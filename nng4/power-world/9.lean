/-
rw [pow_two]
rw [add_mul]
rw [mul_add, mul_add]
rw [←pow_two, ←pow_two]
rw [add_assoc, ←add_assoc (a*b)]
rw [mul_comm b a]
rw [←two_mul, ←mul_assoc]
rw [add_comm (2*a*b)]
rw [←add_assoc]
rfl
-/
