import Definitions.Deformations.PreparedCyclicLogNorm

namespace Litt3.Deformations.Specifications

variable {R B : Type*} [CommRing R] [Ring B] [Algebra R B]

/-- The actual full cyclic norm on the prepared module is the precise
highest p-power scalar times its actual truncated logarithmic unit. -/
def PreparedCyclicLogNorm (p a h : ℕ) (x : B) : Prop :=
  integralCyclicNormValue (R := R) p a x = (p : R) ^ a • truncatedLogValue (R := R) h x ∧
    IsUnit (truncatedLogValue (R := R) h x)

end Litt3.Deformations.Specifications
