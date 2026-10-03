import Mathlib.Algebra.Algebra.Basic

namespace Litt3.Deformations

/-- Actual fixed-point step for x^p-a*x-b, with a genuine original
coefficient unit. No choice of root or convergence is assumed. -/
noncomputable def artinSchreierRootStep {R A : Type*} [CommRing R] [CommRing A] [Algebra R A]
    (p : ℕ) (a : Rˣ) (b : R) (x : A) : A :=
  (a⁻¹ : Rˣ).val • (x ^ p - algebraMap R A b)

end Litt3.Deformations
