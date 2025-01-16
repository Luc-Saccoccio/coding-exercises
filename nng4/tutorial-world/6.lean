example (a b c : Nat) : a + (b + 0) + (c + 0) = a + b + c := by
  rw [Nat.add_zero c]
  rw [Nat.add_zero]
  rfl
