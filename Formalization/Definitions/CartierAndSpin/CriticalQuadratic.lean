import Mathlib.RingTheory.Trace.Basic
import Mathlib.Algebra.Polynomial.Basic

namespace Litt3.CartierAndSpin

open Polynomial

noncomputable section

/-- The explicit degree-ten critical quadratic, with formal coefficients
retained at every actual degree drop of D or of the numerator. -/
def criticalQuadraticFromMoments {K : Type*} [CommRing K]
    (leading : K) (D : K[X]) (rho : K) (mu : ℕ → K) : K[X] :=
  C (leading * rho ^ 2 - D.coeff 3 * mu 2 - D.coeff 2 * mu 1 - D.coeff 1 * mu 0) -
    C (D.coeff 3 * mu 1 + D.coeff 2 * mu 0) * X - C (D.coeff 3 * mu 0) * X ^ 2

/-- The same quadratic built from genuine traces in an actual algebra. -/
def criticalQuadraticTrace {K A : Type*} [Field K] [CommRing A] [Algebra K A]
    (leading : K) (D : K[X]) (w u : A) (phiUnit : Aˣ) : K[X] :=
  criticalQuadraticFromMoments leading D
    (Algebra.trace K A (u * w ^ 4 * (↑phiUnit⁻¹ : A)))
    (fun j => Algebra.trace K A (u ^ 2 * w ^ j * (↑phiUnit⁻¹ : A)))

end
end Litt3.CartierAndSpin
