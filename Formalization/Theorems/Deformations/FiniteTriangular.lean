import Definitions.Deformations.FiniteTriangular

namespace Litt3.Deformations

variable {K O : ℕ → Type*} [∀ n, AddCommGroup (O n)]

/-- Pointwise bijectivity of the complete finite triangular system. -/
def FiniteTriangularBijective (diagonal : ∀ n, K n ≃ O n)
    (tail : ∀ n, BlockPrefix K n → O n) : Prop :=
  ∀ n, Function.Bijective (finiteTriangularEquiv diagonal tail n)

end Litt3.Deformations
