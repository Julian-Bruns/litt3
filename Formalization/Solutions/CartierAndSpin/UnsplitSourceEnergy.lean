import Solutions.CartierAndSpin.TraceEnergy
import Theorems.CartierAndSpin.SourceQuotientEnergy

namespace Litt3.CartierAndSpin

open Polynomial Module

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]

/-- The complete differential-field coefficient/twisted-square
calculus is realized in the actual original quotient. All splitting,
trace compatibility, units and derivation extensions are constructed. -/
theorem sourceQuotientDifferentialCalculus (D : Derivation R K K)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K) :
    Specifications.SourceQuotientDifferentialCalculus D F H p q tau := by
  intro hp hdegree htau hseparable hsource
  have hF : F ≠ 0 := by
    intro hzero
    rw [hzero, Polynomial.natDegree_zero] at hdegree
    omega
  have htwo : (2 : K) ≠ 0 := by
    intro hzero
    have hdivides : p ∣ 2 := (CharP.cast_eq_zero_iff K p 2).mp hzero
    have hle := Nat.le_of_dvd (by decide : 0 < 2) hdivides
    omega
  obtain ⟨unit, hunit, hmoments⟩ := source_coefficient_moments F H p q tau
    (by omega) hdegree htau hseparable hsource
  obtain ⟨E, compatible⟩ := separable_polynomial_quotient_derivation_exists D F hseparable
  let basis := (AdjoinRoot.powerBasis hF).basis
  have hunitDerivative := source_quotient_factor_derivation D F E compatible p q unit hunit
  have hdifferential (j : ℕ) (hjzero : 0 < j) (hj : j < p) :
      Algebra.trace K (AdjoinRoot F) ((AdjoinRoot.root F) ^ (j - 1) *
        E (AdjoinRoot.root F) * (↑unit⁻¹ : AdjoinRoot F)) =
          (H %ₘ (X ^ p + C q)).coeff (p - j) * D q / tau := by
    have hjcast : (j : K) ≠ 0 := by
      intro hzero
      have hdivides : p ∣ j := (CharP.cast_eq_zero_iff K p j).mp hzero
      have hle := Nat.le_of_dvd hjzero hdivides
      omega
    have h := trace_first_differential_moment_equation D E compatible basis
      (AdjoinRoot.root F) unit q hunitDerivative j (hmoments j hj).1
    rw [(hmoments j hj).2] at h
    apply mul_left_cancel₀ hjcast
    exact h.trans (by ring)
  have hsquare : sourceQuotientDifferentialEnergy F E unit -
      4 * D q * D ((H %ₘ (X ^ p + C q)).coeff (p - 2) / tau) =
        sourceQuotientTwistedDifferentialEnergy D F E unit q := by
    exact trace_twisted_differential_square D E compatible basis (AdjoinRoot.root F)
      unit q ((H %ₘ (X ^ p + C q)).coeff (p - 2)) tau htwo hunitDerivative
      (hmoments 2 (by omega)).2
  refine ⟨unit, E, hunit, compatible, hdifferential, hsquare, ?_⟩
  rw [hsquare]
  unfold sourceQuotientTwistedDifferentialEnergy
  congr 1
  exact (characteristic_unit_twisted_power_square E p (AdjoinRoot.root F) unit
    (D q) hp hunitDerivative).symm

end Litt3.CartierAndSpin
