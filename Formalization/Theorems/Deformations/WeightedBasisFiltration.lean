import Definitions.Deformations.WeightedBasisFiltration

namespace Litt3.Deformations.Specifications

open Module

variable {k V ι : Type*} [DivisionRing k] [AddCommGroup V] [Module k V]
variable [FiniteDimensional k V] [Fintype ι]

/-- Every coefficient of the generating polynomial is the actual
dimension of the corresponding successive quotient. -/
def WeightedBasisHilbertDimensions (basis : Basis ι k V) (weight : ι → ℕ) : Prop :=
  ∀ n, Module.finrank k (FiltrationLayer (weightedBasisFiltration basis weight) n) =
    (weightedBasisHilbertPolynomial weight).coeff n

end Litt3.Deformations.Specifications
