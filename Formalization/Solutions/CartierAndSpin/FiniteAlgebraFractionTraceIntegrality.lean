import Mathlib.RingTheory.Trace.Basic
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
import Mathlib.RingTheory.IntegralClosure.Algebra.Basic

namespace Litt3.CartierAndSpin

variable {R K L A : Type*} [CommRing R]
  [Field K] [Field L] [Algebra R K] [IsFractionRing R K]
  [IsIntegrallyClosed R] [Algebra K L] [Algebra R L]
  [IsScalarTower R K L] [FiniteDimensional K L]

/-- Every genuinely integral element of a finite field extension has
its actual field trace in the original integrally closed base ring.
Separability and a split embedding family are unnecessary. -/
theorem integral_fraction_field_trace_descends (x : L) (hx : IsIntegral R x) :
    ∃ r : R, algebraMap R K r = Algebra.trace K L x :=
  IsIntegrallyClosed.algebraMap_eq_of_integral (Algebra.isIntegral_trace hx)

variable [CommRing A] [Algebra R A] [Module.Finite R A]

/-- Any true finite algebra and any actual map into the field extension
provide the integrality input. No local trace-regularity premise occurs. -/
theorem finite_algebra_fraction_field_trace_descends (f : A →ₐ[R] L) (a : A) :
    ∃ r : R, algebraMap R K r = Algebra.trace K L (f a) :=
  integral_fraction_field_trace_descends (f a) ((IsIntegral.of_finite R a).map f)

/-- All actual weighted moments of integral algebra elements against a
true algebra unit have regular field traces, in every moment order. -/
theorem finite_algebra_unit_weighted_moment_trace_descends
    (f : A →ₐ[R] L) (u w : A) (phi : Aˣ) (j : ℕ) :
    ∃ r : R, algebraMap R K r = Algebra.trace K L
      (f u ^ 2 * f w ^ j * (f (phi : A))⁻¹) := by
  have hphi : f (↑phi⁻¹ : A) = (f (phi : A))⁻¹ := by
    have h := congrArg f (phi.mul_inv)
    rw [map_mul, map_one] at h
    exact eq_inv_of_mul_eq_one_right h
  have h := finite_algebra_fraction_field_trace_descends (K := K) f
    (u ^ 2 * w ^ j * (↑phi⁻¹ : A))
  simpa only [map_mul, map_pow, hphi] using h

end Litt3.CartierAndSpin
