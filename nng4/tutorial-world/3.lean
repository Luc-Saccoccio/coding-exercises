open Nat

theorem two_eq_succ_one : 2 = succ 1 := rfl

theorem one_eq_succ_zero : 1 = succ 0 := rfl

example : 2 = succ (succ 0) := by
  rw [two_eq_succ_one]
  rw [one_eq_succ_zero]
  rfl
