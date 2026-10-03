import Definitions.Deformations.BalancedNodeAlgebra

namespace Litt3.Deformations

/-- The actual surviving original node monomials: the constant and
the two nonzero axis strings of length Q−1. -/
noncomputable def balancedNodeNormalExponent (Q : ℕ) :
    Option (Fin (Q - 1) ⊕ Fin (Q - 1)) → Fin 2 →₀ ℕ
  | none => 0
  | some (.inl i) => Finsupp.single 0 (i.val + 1)
  | some (.inr i) => Finsupp.single 1 (i.val + 1)

end Litt3.Deformations
