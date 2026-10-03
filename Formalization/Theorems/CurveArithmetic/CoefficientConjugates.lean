import Mathlib.FieldTheory.Finite.GaloisField
import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic

namespace Litt3.CurveArithmetic.Targets

/-- Distinct automorphisms of a coefficient field give distinct tuples
when the coefficients generate the field. The conclusion counts actual
field embeddings, not formal coefficient labels. -/
def CoefficientConjugatesInjective : Prop :=
  ∀ (K L ι : Type) [Field K] [Field L] [Algebra K L]
    (coefficient : ι → L),
    IntermediateField.adjoin K (Set.range coefficient) = ⊤ →
    Function.Injective (fun σ : L ≃ₐ[K] L => fun i => σ (coefficient i))

end Litt3.CurveArithmetic.Targets
