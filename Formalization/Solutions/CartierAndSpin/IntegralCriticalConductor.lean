import Theorems.CartierAndSpin.IntegralCriticalConductor
import Solutions.CartierAndSpin.IntegralCriticalModel
import Solutions.CartierAndSpin.IntegralSplitConductor

namespace Litt3.CartierAndSpin

open Polynomial IsLocalRing

variable {R K ι : Type*} [CommRing R] [Nontrivial R] [Field K]
  [Algebra R K] [Fintype ι]

omit [Nontrivial R] in
/-- A unit of the actual base ring does not change actual descent when
used as an additional denominator. -/
theorem div_unit_factor_mem_range_iff (x : K) (a : R) (ha : IsUnit a) :
    x / algebraMap R K a ∈ (algebraMap R K).range ↔ x ∈ (algebraMap R K).range := by
  have hane : algebraMap R K a ≠ 0 := (ha.map (algebraMap R K)).ne_zero
  constructor
  · rintro ⟨b, hb⟩
    refine ⟨b * a, ?_⟩
    rw [map_mul, hb, div_mul_cancel₀ _ hane]
  · rintro ⟨b, hb⟩
    refine ⟨b * (↑(ha.unit⁻¹) : R), ?_⟩
    simp only [map_mul, map_units_inv, IsUnit.unit_spec, hb, div_eq_mul_inv]

/-- The actual quadratic critical presentation converts the split-order
conductor into the denominator-D lattice, using only its actual unit
factors. No trace or integrality condition is assumed in this conversion. -/
theorem integral_quadratic_critical_model_conductor_iff (w : ι → R) (v tau : Rˣ)
    (phi S U : R[X]) (hinjective : Function.Injective (algebraMap R K))
    (hmodel : C (v : R) * finiteRootPolynomial w =
      C (v : R) * phi ^ 2 + phi * S + C (tau : R))
    (hphi : phi.derivative = 0)
    (hseparable : ((C (v : R) * finiteRootPolynomial w).map (algebraMap R K)).Separable) :
    Specifications.IntegralCriticalConductorCriterion (K := K) w S U := by
  have hPseparable : ((finiteRootPolynomial w).map (algebraMap R K)).Separable := by
    rw [Polynomial.map_mul] at hseparable
    exact hseparable.of_mul_right
  have hderivative := quadraticCriticalModel_monic_derivative w v tau phi S hmodel hphi
  have hphi_units := quadraticCriticalModel_factor_units w v tau phi S hmodel
  unfold Specifications.IntegralCriticalConductorCriterion
  rw [integralSplitQuotientMap_mk]
  rw [integral_split_conductor_iff (K := K) w (aeval w U) hinjective hPseparable]
  apply forall_congr'
  intro i
  have hdenominator :
      ((finiteRootPolynomial w).map (algebraMap R K)).derivative.eval (algebraMap R K (w i)) =
        algebraMap R K ((↑(v⁻¹) : R) * phi.eval (w i)) *
          algebraMap R K (S.derivative.eval (w i)) := by
    rw [derivative_map, eval_map, eval₂_at_apply, hderivative,
      eval_mul, eval_mul, eval_C, map_mul, map_mul]
  have hratio :
      algebraMap R K ((aeval w U) i) /
          ((finiteRootPolynomial w).map (algebraMap R K)).derivative.eval (algebraMap R K (w i)) =
        (U.eval₂ (algebraMap R K) (algebraMap R K (w i)) /
          S.derivative.eval₂ (algebraMap R K) (algebraMap R K (w i))) /
            algebraMap R K ((↑(v⁻¹) : R) * phi.eval (w i)) := by
    rw [hdenominator]
    simp only [aeval_fn_apply, aeval_def, Algebra.algebraMap_self, eval₂_id,
      eval₂_at_apply, div_eq_mul_inv, mul_inv_rev]
    ring
  rw [hratio]
  exact div_unit_factor_mem_range_iff _ _ (v⁻¹.isUnit.mul (hphi_units i))

section CharacteristicFive

variable [IsDomain R] [ValuationRing R] [IsFractionRing R K] [CharP R 5]

/-- The canonical nine higher-power tests detect the actual linear
conductor lattice in the genuine split integral quotient order. -/
theorem integral_characteristic_five_cubic_tests_iff_conductor (w : ι → R)
    (v tau : Rˣ) (q : R) (S U : R[X]) (hS : S.natDegree ≤ 4)
    (hmodel : C (v : R) * finiteRootPolynomial w =
      C (v : R) * (X ^ 5 + C q) ^ 2 + (X ^ 5 + C q) * S + C (tau : R))
    (hseparable : ((C (v : R) * finiteRootPolynomial w).map (algebraMap R K)).Separable)
    (hD : S.derivative.map (residue R) ≠ 0) :
    (∀ j, j < 3 → ∀ k, 2 ≤ k → k ≤ 4 →
      finiteWeightedPowerSum (fun i => algebraMap R K (w i))
        (fun i => U.eval₂ (algebraMap R K) (algebraMap R K (w i)) /
          S.derivative.eval₂ (algebraMap R K) (algebraMap R K (w i))) j k ∈
        (algebraMap R K).range) ↔
      integralSplitQuotientMap w (AdjoinRoot.mk (finiteRootPolynomial w) U) ∈ conductor R w := by
  have hcriterion := integral_characteristic_five_cubic_criterion w v tau q S U hS hmodel
    hseparable hD
  have hconductor := integral_quadratic_critical_model_conductor_iff w v tau (X ^ 5 + C q) S U
    (IsFractionRing.injective R K) hmodel (integral_inseparable_factor_derivative 5 q) hseparable
  exact hcriterion.trans hconductor.symm

end CharacteristicFive

end Litt3.CartierAndSpin
