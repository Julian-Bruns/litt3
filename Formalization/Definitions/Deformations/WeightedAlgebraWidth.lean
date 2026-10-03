import Definitions.Deformations.MultiplicativeFiltration
import Definitions.Deformations.WeightedBasisFiltration
import Definitions.Deformations.HilbertCoefficients

namespace Litt3.Deformations

open Module

variable {k A ι : Type*} [Field k] [Ring A] [Algebra k A]

/-- A concrete basis multiplication respects the prescribed weight
filtration. This can be established by actual reordering identities;
it asserts no dimensions or defect values. -/
def BasisProductsRespectWeight (basis : Basis ι k A) (weight : ι → ℕ) : Prop :=
  ∀ i j, basis i * basis j ∈
    weightedBasisFiltration basis weight (weight i + weight j)

end Litt3.Deformations
