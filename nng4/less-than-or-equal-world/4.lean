/-
cases hxy with a ha
cases hyz with b hb
use (a+b)
rw [←add_assoc x a b, ←ha, ←hb]
rfl
-/
