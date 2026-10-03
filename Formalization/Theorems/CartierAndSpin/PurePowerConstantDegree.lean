import Definitions.CartierAndSpin.PurePowerQuotient
import Definitions.CurveArithmetic.RationalCoefficientAction

namespace Litt3.CartierAndSpin.Specifications

open Litt3.CurveArithmetic

variable {K Ω : Type*} [Field K] [Finite K] [Field Ω] [Algebra K Ω]
  [Algebra.IsAlgebraic K Ω]

/-- The actual solution pair over an algebraic constant extension descends
to an embedded finite constant extension of degree at most m². -/
def PurePowerRationalDescent (rational : Fin 2 → RatFunc Ω)
    (m : ℕ) (a b c d : RatFunc K) (R S : MvPolynomial (Fin 2) (RatFunc K)) : Prop :=
  R.totalDegree < m → S.totalDegree < m → a * d - b * c ≠ 0 →
    MvPolynomial.eval₂Hom (rationalCoefficientMap (algebraMap K Ω)) rational
      (purePowerPolynomial m a b R) = 0 →
    MvPolynomial.eval₂Hom (rationalCoefficientMap (algebraMap K Ω)) rational
      (purePowerPolynomial m c d S) = 0 →
    ∃ E : IntermediateField K Ω, FiniteDimensional K E ∧
      Module.finrank K E ≤ m ^ 2 ∧ ∃ descended : Fin 2 → RatFunc E,
        ∀ i, rationalCoefficientMap E.val.toRingHom (descended i) = rational i

end Litt3.CartierAndSpin.Specifications
