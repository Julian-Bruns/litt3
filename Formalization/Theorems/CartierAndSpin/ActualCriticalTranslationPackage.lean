import Solutions.CartierAndSpin.RationalCriticalTranslation
import Solutions.CartierAndSpin.RationalCriticalQuadratic

namespace Litt3.CartierAndSpin.Specifications

open Polynomial
open scoped RatFunc

attribute [local instance] Polynomial.algebra

variable {K L : Type*} [Field K] [Field L] [Algebra K L]

/-- Literal actual-field translation package: every original trace,
explicit quadratic, fixed-degree resultant and transformed identity,
together with actual independent-rational-parameter transport. -/
def ActualCriticalTranslationPackage (w u : L) (F phi D U : K[X]) : Prop :=
  ∃ phiUnit DUnit : Lˣ,
    (phiUnit : L) = aeval w phi ∧ (DUnit : L) = aeval w D ∧
    AlgebraCriticalTraceTranslationOutcome (K := K) w u phiUnit ∧
    (∀ z : K,
      aeval w (U - C z * D) = (u - algebraMap K L z) * aeval w D ∧
      criticalQuadraticTrace F.leadingCoeff D w (u - algebraMap K L z) phiUnit =
        criticalQuadraticTrace F.leadingCoeff D w u phiUnit ∧
      resultant D (U - C z * D) 3 5 = resultant D U 3 5 ∧
      resultant D (criticalQuadraticTrace F.leadingCoeff D w
        (u - algebraMap K L z) phiUnit) 3 2 =
        resultant D (criticalQuadraticTrace F.leadingCoeff D w u phiUnit) 3 2 ∧
      (∀ V2 : K[X], U ^ 2 - F * criticalQuadraticTrace F.leadingCoeff D w u phiUnit = D * V2 →
        (U - C z * D) ^ 2 - F * criticalQuadraticTrace F.leadingCoeff D w u phiUnit =
          D * (V2 - 2 * C z * U + (C z) ^ 2 * D))) ∧
    AlgebraCriticalTraceTranslationOutcome (K := RatFunc K)
      (RatFunc.C w) (RatFunc.C u)
      (Units.map (RatFunc.C : L →+* RatFunc L).toMonoidHom phiUnit) ∧
    criticalQuadraticTrace (algebraMap K (RatFunc K) F.leadingCoeff)
      (D.map (algebraMap K (RatFunc K))) (RatFunc.C w) (RatFunc.C u)
      (Units.map (RatFunc.C : L →+* RatFunc L).toMonoidHom phiUnit) =
      (criticalQuadraticTrace F.leadingCoeff D w u phiUnit).map
        (algebraMap K (RatFunc K))

end Litt3.CartierAndSpin.Specifications
