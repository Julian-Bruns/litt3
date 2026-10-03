import Solutions.CartierAndSpin.RationalFieldTraceExtension
import Solutions.CartierAndSpin.CriticalQuadraticTranslation

namespace Litt3.CartierAndSpin

open Polynomial
open scoped RatFunc

attribute [local instance] Polynomial.algebra

variable {K L : Type*} [Field K] [Field L] [Algebra K L]

/-- The explicit canonical critical quadratic in the actual rational
extension is literally the coefficient extension of the original one.
All trace and denominator compatibility is proved, rather than supplied. -/
theorem rational_critical_quadratic_constant_extension
    (w u : L) (F D : K[X]) (hF : F ≠ 0) (hroot : aeval w F = 0)
    (hgen : IntermediateField.adjoin K ({w} : Set L) = ⊤)
    (hdegree : F.natDegree = Module.finrank K L) (leading : K) (phiUnit : Lˣ) :
    criticalQuadraticTrace (algebraMap K (RatFunc K) leading)
      (D.map (algebraMap K (RatFunc K))) (RatFunc.C w) (RatFunc.C u)
      (Units.map (RatFunc.C : L →+* RatFunc L).toMonoidHom phiUnit) =
    (criticalQuadraticTrace leading D w u phiUnit).map (algebraMap K (RatFunc K)) := by
  have htrace (a : L) := primitive_rational_field_trace_constant_extension w F hF hroot hgen hdegree a
  have hinverse : (↑(Units.map (RatFunc.C : L →+* RatFunc L).toMonoidHom phiUnit)⁻¹ : RatFunc L) =
      RatFunc.C (↑phiUnit⁻¹ : L) := rfl
  have hrho : Algebra.trace (RatFunc K) (RatFunc L)
      (RatFunc.C u * (RatFunc.C w) ^ 4 *
        (↑(Units.map (RatFunc.C : L →+* RatFunc L).toMonoidHom phiUnit)⁻¹ : RatFunc L)) =
      RatFunc.C (Algebra.trace K L (u * w ^ 4 * (↑phiUnit⁻¹ : L))) := by
    rw [hinverse, ← map_pow, ← map_mul, ← map_mul]
    exact htrace _
  have hmu (j : ℕ) : Algebra.trace (RatFunc K) (RatFunc L)
      ((RatFunc.C u) ^ 2 * (RatFunc.C w) ^ j *
        (↑(Units.map (RatFunc.C : L →+* RatFunc L).toMonoidHom phiUnit)⁻¹ : RatFunc L)) =
      RatFunc.C (Algebra.trace K L (u ^ 2 * w ^ j * (↑phiUnit⁻¹ : L))) := by
    rw [hinverse, ← map_pow, ← map_pow, ← map_mul, ← map_mul]
    exact htrace _
  simp only [criticalQuadraticTrace, criticalQuadraticFromMoments, hrho, hmu,
    coeff_map, Polynomial.map_sub, Polynomial.map_C, Polynomial.map_mul,
    Polynomial.map_pow, Polynomial.map_X, map_sub, map_mul, map_pow,
    RatFunc.algebraMap_eq_C, map_add, Polynomial.map_add]

end Litt3.CartierAndSpin
