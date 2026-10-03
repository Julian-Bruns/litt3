import Definitions.CartierAndSpin.SkewKernel

namespace Litt3.CartierAndSpin.Specifications

variable {K V : Type*} [CommRing K] [AddCommGroup V] [Module K V]

/-- The exact algebraic skew-kernel criterion used in scalar-graph recovery. -/
def RankTwoSkewKernelCriterion (e u : V) (a b : V →ₗ[K] K) : Prop :=
  LinearIndependent K ![e, u] →
    ∀ x : V, rankTwoSkew e u a b x = 0 ↔ a x = 0 ∧ b x = 0

end Litt3.CartierAndSpin.Specifications
