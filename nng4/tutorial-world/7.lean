open Nat

theorem one_eq_succ_zero : 1 = succ 0 := rfl

example (n : Nat) : succ n = n + 1 := by
  rw [one_eq_succ_zero]
  rw [add_succ]
  rw [add_zero]
  rfl
