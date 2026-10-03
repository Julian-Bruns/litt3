import Definitions.Deformations.BasisWeightedPowers

namespace Litt3.Deformations

/-- Literal signed upper-degree carries in an arbitrary fixed free
module basis, including all coefficient prime powers. -/
noncomputable def signedBasisPowerFiltration {R M I : Type*}
    [CommRing R] [AddCommGroup M] [Module R M]
    (B : Module.Basis I R M) (a : R) (w : ℕ) (degree : I → ℕ) (d : ℤ) :
    Submodule R M :=
  Submodule.span R {x | ∃ j : ℕ, ∃ i : I,
    (degree i : ℤ) ≤ d + (w : ℤ) * j ∧ x = a ^ j • B i}

/-- The exact least original coefficient exponent required by an
integer degree bound. It is zero when the normal basis degree is small. -/
def signedBasisWeightExponent (w : ℕ) (d : ℤ) (degree : ℕ) : ℕ :=
  basisWeightExponent w ((degree : ℤ) - d).toNat 0

end Litt3.Deformations
