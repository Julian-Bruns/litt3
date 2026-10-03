import Theorems.CartierAndSpin.ActualCriticalTranslationPackage
import Definitions.CartierAndSpin.SmoothSelectedTranslation
import Solutions.SharedTensors.ConstantPrincipalDivisors
import Solutions.CartierAndSpin.SchemeSelectedTranslation

namespace Litt3.CartierAndSpin.Specifications

open CategoryTheory AlgebraicGeometry Polynomial
open scoped RatFunc

attribute [local instance] Polynomial.algebra

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {Z : Scheme.{u}} [IsIntegral Z]
  {K : Type*} [Field K] [Algebra K Z.functionField]

/-- Full literal translation scope on the actual original smooth source:
algebraic identities over K and independent K(z), plus the actual
constant-scalar selected-double-zero obstruction on the same source. -/
def AnnihilatorCriticalTranslation
    (sZ : Z ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sZ]
    (w u : Z.functionField) (F phi D U : K[X]) : Prop :=
  ActualCriticalTranslationPackage w u F phi D U ∧
  ActualCriticalTranslationPackage (K := RatFunc K) (RatFunc.C w) (RatFunc.C u)
    (F.map (algebraMap K (RatFunc K))) (phi.map (algebraMap K (RatFunc K)))
    (D.map (algebraMap K (RatFunc K))) (U.map (algebraMap K (RatFunc K))) ∧
  (∀ P : Litt3.SharedTensors.ClosedPoint Z,
    integerFieldOrder (smoothCurveClosedPointValuation sZ P) u = 2 →
    ∀ z : k, z ≠ 0 →
      ∃ germ : Z.presheaf.stalk P.val, IsUnit germ ∧
        algebraMap (Z.presheaf.stalk P.val) Z.functionField germ =
          u - Litt3.QuotientGeometry.genericBaseFieldHom sZ z ∧
        u - Litt3.QuotientGeometry.genericBaseFieldHom sZ z ≠ 0 ∧
        integerFieldOrder (smoothCurveClosedPointValuation sZ P)
          (u - Litt3.QuotientGeometry.genericBaseFieldHom sZ z) = 0) ∧
  (∀ selected : Set (Litt3.SharedTensors.ClosedPoint Z), selected.Nonempty →
    (∀ P ∈ selected, integerFieldOrder (smoothCurveClosedPointValuation sZ P) u = 2) →
    ∀ z : k, z ≠ 0 →
      ¬∀ P ∈ selected, integerFieldOrder (smoothCurveClosedPointValuation sZ P)
        (u - Litt3.QuotientGeometry.genericBaseFieldHom sZ z) = 2)

end Litt3.CartierAndSpin.Specifications
