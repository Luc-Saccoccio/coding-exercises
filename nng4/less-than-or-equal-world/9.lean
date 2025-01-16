/-
cases hx with a h
rw [succ_add] at h
apply succ_inj at h
use a
exact h
-/
