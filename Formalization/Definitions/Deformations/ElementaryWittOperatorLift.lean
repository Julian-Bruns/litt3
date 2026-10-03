import Solutions.Deformations.GroupCoefficientFrobenius

namespace Litt3.Deformations

/-- The actual additive multiplication/Frobenius approximation in the
original Witt group algebra. -/
noncomputable def elementaryWittMultiplier (N r : ℕ) (k : Type*) [CommRing k]
    [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]
    (f : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5)) :
    AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5) where
  toFun x := f * elementaryWittFrobenius 5 N r k x
  map_zero' := by rw [map_zero, mul_zero]
  map_add' x y := by rw [map_add, mul_add]

/-- Literal additive discrepancy, allowing arbitrary mixed coefficient
corrections rather than imposing coefficient-ring linearity. -/
noncomputable def elementaryWittOperatorCorrection (N r : ℕ) (k : Type*) [CommRing k]
    [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]
    (L : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (f : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5)) :
    AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5) :=
  L - elementaryWittMultiplier N r k f

end Litt3.Deformations
