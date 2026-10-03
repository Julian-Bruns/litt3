import Theorems.CartierAndSpin.IntegralCriticalModel
import Definitions.CartierAndSpin.IntegralSplitOrder

namespace Litt3.CartierAndSpin.Specifications

open Polynomial

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K] [Fintype ι]

/-- Actual conductor membership of the actual quotient class, under its
actual evaluation map into the integral product algebra. -/
def IntegralCriticalConductorCriterion (w : ι → R) (S U : R[X]) : Prop :=
  integralSplitQuotientMap w (AdjoinRoot.mk (finiteRootPolynomial w) U) ∈ conductor R w ↔
    ∀ i, U.eval₂ (algebraMap R K) (algebraMap R K (w i)) /
      S.derivative.eval₂ (algebraMap R K) (algebraMap R K (w i)) ∈ (algebraMap R K).range

end Litt3.CartierAndSpin.Specifications
