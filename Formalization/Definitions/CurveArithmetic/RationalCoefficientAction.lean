import Mathlib.FieldTheory.RatFunc.Basic
import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic

namespace Litt3.CurveArithmetic

noncomputable section

/-- Extension of a field coefficient homomorphism to rational functions,
fixing the indeterminate. The fraction-field construction checks the
nonzero-denominator condition from injectivity of the field homomorphism. -/
def rationalCoefficientMap
    {L M : Type*} [Field L] [Field M] (φ : L →+* M) : RatFunc L →+* RatFunc M :=
  RatFunc.mapRingHom (Polynomial.mapRingHom φ)
    (nonZeroDivisors_le_comap_nonZeroDivisors_of_injective
      (Polynomial.mapRingHom φ) (Polynomial.map_injective φ φ.injective))

/-- The coefficient action on an actual rational function fixes the
indeterminate. Both numerator and monic denominator are the canonical
normalized representatives supplied by `RatFunc`. -/
def rationalCoefficientConjugate
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (σ : L ≃ₐ[K] L) (r : RatFunc L) : RatFunc L :=
  algebraMap (Polynomial L) (RatFunc L) (r.num.map σ.toRingHom) /
    algebraMap (Polynomial L) (RatFunc L) (r.denom.map σ.toRingHom)

/-- Every canonical numerator and denominator coefficient is included.
The coefficient index has no arbitrary truncation bound. -/
def rationalFamilyCoefficients {L ι : Type*} [Field L]
    (rational : ι → RatFunc L) : (ι × Bool × ℕ) → L :=
  fun index => if index.2.1 then (rational index.1).num.coeff index.2.2
    else (rational index.1).denom.coeff index.2.2

/-- The smallest actual embedded constant subfield containing every
canonical numerator and denominator coefficient of the rational family. -/
def rationalCoefficientField {K L ι : Type*} [Field K] [Field L] [Algebra K L]
    (rational : ι → RatFunc L) : IntermediateField K L :=
  IntermediateField.adjoin K (Set.range (rationalFamilyCoefficients rational))

def rationalFamilyCoefficientLift {K L ι : Type*} [Field K] [Field L] [Algebra K L]
    (rational : ι → RatFunc L) : (ι × Bool × ℕ) → rationalCoefficientField (K := K) rational :=
  fun index => ⟨rationalFamilyCoefficients rational index,
    IntermediateField.subset_adjoin K _ ⟨index, rfl⟩⟩

end
end Litt3.CurveArithmetic
