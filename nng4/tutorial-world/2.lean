example (x y : Nat) (h : y = x + 7) : 2 * y = 2 * (x + 7) := by
  rw [h]
