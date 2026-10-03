import Theorems.CartierAndSpin.IntegralCriticalModel
import Solutions.CartierAndSpin.IntegralCriticalCohorts
import Solutions.CartierAndSpin.ValuationRingIntegrality
import Mathlib.Algebra.CharP.Algebra

namespace Litt3.CartierAndSpin

open Finset Polynomial IsLocalRing Classical

section Ring

variable {R ι : Type*} [CommRing R] [Fintype ι]

/-- The actual split model and the unit constant term force the inseparable
factor to be a unit at every actual integral root. -/
theorem quadraticCriticalModel_factor_units (w : ι → R) (v tau : Rˣ) (phi S : R[X])
    (hmodel : C (v : R) * finiteRootPolynomial w =
      C (v : R) * phi ^ 2 + phi * S + C (tau : R)) :
    ∀ i, IsUnit (phi.eval (w i)) := by
  intro i
  have heval := congrArg (fun P : R[X] => P.eval (w i)) hmodel
  simp only [eval_add, eval_mul, eval_C, eval_pow,
    finiteRootPolynomial_eval_at_member, mul_zero] at heval
  have hproduct : phi.eval (w i) * ((v : R) * phi.eval (w i) + S.eval (w i)) =
      -(tau : R) := by
    apply eq_neg_of_add_eq_zero_left
    calc
      phi.eval (w i) * ((v : R) * phi.eval (w i) + S.eval (w i)) + (tau : R) =
          (v : R) * phi.eval (w i) ^ 2 + phi.eval (w i) * S.eval (w i) + (tau : R) := by ring
      _ = 0 := heval.symm
  apply isUnit_of_mul_isUnit_left
  rw [hproduct]
  exact tau.isUnit.neg

/-- Ordinary differentiation of the actual model gives its monic derivative
without inverting a discriminant or any critical-root difference. -/
theorem quadraticCriticalModel_monic_derivative (w : ι → R) (v tau : Rˣ) (phi S : R[X])
    (hmodel : C (v : R) * finiteRootPolynomial w =
      C (v : R) * phi ^ 2 + phi * S + C (tau : R))
    (hphi : phi.derivative = 0) :
    (finiteRootPolynomial w).derivative = C (↑(v⁻¹) : R) * phi * S.derivative := by
  have hderivative := congrArg Polynomial.derivative hmodel
  simp only [derivative_add, derivative_mul, derivative_C, derivative_pow, hphi,
    zero_mul, mul_zero, zero_add, add_zero] at hderivative
  calc
    (finiteRootPolynomial w).derivative =
        (C (↑(v⁻¹) : R) * C (v : R)) * (finiteRootPolynomial w).derivative := by
      simp only [← C_mul, Units.inv_mul, C_1, one_mul]
    _ = C (↑(v⁻¹) : R) * (C (v : R) * (finiteRootPolynomial w).derivative) := by ring
    _ = C (↑(v⁻¹) : R) * (phi * S.derivative) := by rw [hderivative]
    _ = C (↑(v⁻¹) : R) * phi * S.derivative := by ring

theorem integral_inseparable_factor_derivative (p : ℕ) [CharP R p] (q : R) :
    (X ^ p + C q : R[X]).derivative = 0 := by
  simp [Polynomial.derivative_X_pow, CharP.cast_eq_zero]

end Ring

section Valuation

variable {R K Γ ι : Type*} [CommRing R] [IsLocalRing R] [Nontrivial R]
  [Field K] [Algebra R K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

/-- Generic integral critical model criterion in arbitrary degree and for
arbitrary numerator degree. The only multiplicity bound is the actual
degree of the nonzero residue derivative. -/
theorem integral_quadratic_critical_model_criterion (valuation : Valuation K Γ)
    (hv : valuation.Integers R) (p : ℕ) [CharP (ResidueField R) p]
    (w : ι → R) (v tau : Rˣ) (phi S U : R[X])
    (hmodel : C (v : R) * finiteRootPolynomial w =
      C (v : R) * phi ^ 2 + phi * S + C (tau : R))
    (hphi : phi.derivative = 0)
    (hseparable : ((C (v : R) * finiteRootPolynomial w).map (algebraMap R K)).Separable)
    (hD : S.derivative.map (residue R) ≠ 0) (d r : ℕ)
    (hd : (S.derivative.map (residue R)).natDegree ≤ d)
    (hr : (S.derivative.map (residue R)).natDegree + 1 ≤ r) (hrp : r < p) :
    Specifications.IntegralCriticalMomentCriterion (K := K) w U S.derivative d r := by
  let u := fun i => U.eval₂ (algebraMap R K) (algebraMap R K (w i)) /
    S.derivative.eval₂ (algebraMap R K) (algebraMap R K (w i))
  have hPseparable : ((finiteRootPolynomial w).map (algebraMap R K)).Separable := by
    rw [Polynomial.map_mul] at hseparable
    exact hseparable.of_mul_right
  have hderivative := quadraticCriticalModel_monic_derivative w v tau phi S hmodel hphi
  have hcohorts := integral_critical_maximal_cohorts_bounded valuation hv w
    (↑(v⁻¹) : R) phi S.derivative U v⁻¹.isUnit
    (quadraticCriticalModel_factor_units w v tau phi S hmodel) hderivative hD
  have hcohorts' : MaximalPoleCohortsBounded valuation w u d r := by
    intro i₀ hpole hmaximum
    obtain ⟨hclasses, hsizes⟩ := hcohorts i₀ hpole hmaximum
    exact ⟨hclasses.trans hd, fun c => (hsizes c).trans hr⟩
  constructor
  · intro hmoments
    have hintegral := weightedPowerTraceIntegrality valuation hv p w u d r hrp
      hcohorts' (by
        intro j hj k hk hkr
        have hregular : finiteWeightedPowerSum (fun i => algebraMap R K (w i)) u j k ∈
            (algebraMap R K).range := by
          by_cases hk1 : k = 1
          · subst k
            exact integral_first_power_trace_regular w (↑(v⁻¹) : R) phi S.derivative U
              hPseparable hderivative j
          · exact hmoments j hj k (by omega) hkr
        obtain ⟨b, hb⟩ := hregular
        rw [← hb]
        exact hv.map_le_one b)
    intro i
    exact hintegral i
  · intro hintegral
    choose b hb using hintegral
    intro j hj k hk hkr
    refine ⟨finiteWeightedPowerSum w b j k, ?_⟩
    simpa only [hb] using finiteWeightedPowerSum_map (algebraMap R K) w b j k

end Valuation

section CharacteristicFive

variable {R K ι : Type*} [CommRing R] [IsDomain R] [ValuationRing R]
  [Field K] [Algebra R K] [IsFractionRing R K] [Fintype ι] [CharP R 5]

/-- The exact nine higher weighted tests from the characteristic-five cubic
model. The theorem permits arbitrary finite split degree and arbitrary
integral numerator degree, so in particular retains the degree-ten source
and its allowed numerator degree drops. -/
theorem integral_characteristic_five_cubic_criterion (w : ι → R) (v tau : Rˣ)
    (q : R) (S U : R[X]) (hS : S.natDegree ≤ 4)
    (hmodel : C (v : R) * finiteRootPolynomial w =
      C (v : R) * (X ^ 5 + C q) ^ 2 + (X ^ 5 + C q) * S + C (tau : R))
    (hseparable : ((C (v : R) * finiteRootPolynomial w).map (algebraMap R K)).Separable)
    (hD : S.derivative.map (residue R) ≠ 0) :
    Specifications.IntegralCriticalMomentCriterion (K := K) w U S.derivative 3 4 := by
  letI : CharP (ResidueField R) 5 :=
    CharP.of_ringHom_of_ne_zero (residue R) 5 (by decide)
  have hdegree : (S.derivative.map (residue R)).natDegree ≤ 3 := by
    have hle := (natDegree_map_le (p := S.derivative) (f := residue R)).trans
      (natDegree_derivative_le S)
    omega
  exact integral_quadratic_critical_model_criterion (ValuationRing.valuation R K)
    valuationRing_valuation_integers 5 w v tau (X ^ 5 + C q) S U hmodel
    (integral_inseparable_factor_derivative 5 q) hseparable hD 3 4 hdegree
    (by omega) (by decide)

end CharacteristicFive

end Litt3.CartierAndSpin

