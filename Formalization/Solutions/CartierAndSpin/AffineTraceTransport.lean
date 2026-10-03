import Definitions.CartierAndSpin.AffineDifferentialEnergy
import Solutions.CartierAndSpin.DerivationTransport
import Solutions.CartierAndSpin.AffineDifferentialEnergy
import Mathlib.Algebra.Algebra.Tower

namespace Litt3.CartierAndSpin

variable {R K A B : Type*} [CommRing R] [Field K] [Algebra R K]
  [CommRing A] [CommRing B] [Algebra K A] [Algebra K B]
  [Algebra R A] [Algebra R B] [IsScalarTower R K A] [IsScalarTower R K B]

theorem scaledAlgebraUnit_value (a : K) (ha : a ≠ 0) (unit : Aˣ) :
    (scaledAlgebraUnit a ha unit : A) = algebraMap K A a * (unit : A) := rfl

theorem scaledAlgebraUnit_inverse_value (a : K) (ha : a ≠ 0) (unit : Aˣ) :
    (↑(scaledAlgebraUnit a ha unit)⁻¹ : A) = a⁻¹ • (↑unit⁻¹ : A) := by
  simp [scaledAlgebraUnit, mul_inv_rev, Algebra.smul_def, mul_comm]

/-- Actual centered trace energy is transported through an actual
algebra equivalence. Both the new derivation and denominator unit are
constructed; the claimed energy identity is not an input. -/
theorem trace_centered_energy_equiv_scaling (D : Derivation R K K)
    (E : Derivation R A A)
    (compatible : ∀ c : K, E (algebraMap K A c) = algebraMap K A (D c))
    (e : B ≃ₐ[K] A) (unit : Aˣ) (z : A) (a : K) (ha : a ≠ 0) (p : ℕ)
    (hcross : Algebra.trace K A (z * E z * (↑unit⁻¹ : A)) = 0)
    (hsquare : Algebra.trace K A (z ^ 2 * (↑unit⁻¹ : A)) = 0) :
    let E' := transportedDerivation (e.symm.restrictScalars R) E
    let unit' := Units.map e.symm.toMonoidHom (scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit)
    Algebra.trace K B (E' (e.symm (algebraMap K A a * z)) ^ 2 * (↑unit'⁻¹ : B)) =
      a ^ 2 / a ^ p * Algebra.trace K A (E z ^ 2 * (↑unit⁻¹ : A)) := by
  dsimp only
  rw [← Algebra.trace_eq_of_algEquiv e, map_mul, map_pow]
  have hderivative : e (transportedDerivation (e.symm.restrictScalars R) E
      (e.symm (algebraMap K A a * z))) = E (algebraMap K A a * z) := by
    change e (e.symm (E (e (e.symm (algebraMap K A a * z))))) = _
    simp only [e.apply_symm_apply]
  have hinverse : e (↑(Units.map e.symm.toMonoidHom
      (scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit))⁻¹ : B) =
      (a ^ p)⁻¹ • (↑unit⁻¹ : A) := by
    rw [← map_inv]
    change e (e.symm (↑(scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit)⁻¹ : A)) = _
    rw [e.apply_symm_apply, scaledAlgebraUnit_inverse_value]
  rw [hderivative, hinverse]
  exact functional_centered_derivative_square_scaling D E compatible (Algebra.trace K A)
    (↑unit⁻¹ : A) z a p hcross hsquare

end Litt3.CartierAndSpin
