import Definitions.CurveArithmetic.RationalCoefficientAction
import Theorems.CurveArithmetic.CoefficientConjugates

namespace Litt3.CurveArithmetic.Targets

/-- Conjugating rational functions faithfully detects their entire
constant coefficient field, provided those coefficients generate it. -/
def RationalCoefficientConjugatesInjective : Prop :=
  ∀ (K L ι : Type) [Field K] [Field L] [Algebra K L]
    (rational : ι → RatFunc L),
    IntermediateField.adjoin K (Set.range (rationalFamilyCoefficients rational)) = ⊤ →
    Function.Injective (fun σ : L ≃ₐ[K] L => fun i =>
      rationalCoefficientConjugate σ (rational i))

end Litt3.CurveArithmetic.Targets
