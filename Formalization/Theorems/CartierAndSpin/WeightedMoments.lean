import Definitions.CartierAndSpin.WeightedMoments

/-! Precise proposition-valued specifications. This module declares no axioms
and admits no proofs. The solution module proves these specifications. -/

namespace Litt3.CartierAndSpin.Specifications

variable {R ι : Type*} [CommRing R]

/-- The computation-free translation-invariant component of
`source_quadratic_calculus`. -/
def TraceZeroMomentTranslationInvariant (s : Finset ι) (weight value : ι → R) : Prop :=
  weightedMoment s weight value 0 = 0 →
  weightedMoment s weight value 1 = 0 →
  ∀ b : R,
    weightedMoment s weight (fun i => value i + b) 2 =
      weightedMoment s weight value 2 ∧
    momentDiscriminant s weight (fun i => value i + b) =
      momentDiscriminant s weight value

end Litt3.CartierAndSpin.Specifications
