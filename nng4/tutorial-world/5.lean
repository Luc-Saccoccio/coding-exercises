example (a b c : Nat) : a + (b + 0) + (c + 0) = a + b + c := by
  rw [Nat.add_zero]
  rw [Nat.add_zero]
  rfl
