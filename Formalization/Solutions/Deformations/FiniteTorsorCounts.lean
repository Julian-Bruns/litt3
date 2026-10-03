import Theorems.Deformations.FiniteTorsorCounts

namespace Litt3.Deformations

variable {k V A : Type*} [DivisionRing k] [AddCommGroup V]
variable [Module k V] [Module.Finite k V] [AddTorsor V A]

/-- Cardinality does not depend on an origin or on the torsor's
presentation. No enumeration of torsor points is performed. -/
theorem vector_torsor_cardinality :
    Specifications.ExactVectorTorsorCount (k := k) (V := V) (A := A) := by
  let a : A := Classical.choice (inferInstance : Nonempty A)
  change Nat.card A = Nat.card k ^ Module.finrank k V
  rw [← Nat.card_congr (Equiv.vaddConst (G := V) a)]
  exact Module.natCard_eq_pow_finrank (K := k) (V := V)

end Litt3.Deformations
