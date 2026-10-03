import Solutions.CartierAndSpin.GeneralDegreeTenCriticalQuadratic
import Solutions.CartierAndSpin.QuadraticInterpolationTrace
import Solutions.CartierAndSpin.TraceDualNumeratorMoments

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The literal canonical critical quadratic and exact reduced
interpolator follow from the actual numerator equation and actual traces.
Source F may be nonmonic, unsplit or disconnected; no critical leading
coefficient, critical discriminant or high-source coefficient is inverted.
The identity holds in every characteristic. -/
theorem actual_degree_ten_critical_incidence (F phi D U : K[X])
    (hFdegree : F.natDegree = 10) (hsep : F.Separable)
    (hderivative : F.derivative = phi * D)
    (hUdegree : U.natDegree ≤ 5) (hDdegree : D.natDegree ≤ 3)
    (u : AdjoinRoot F) (hequation : AdjoinRoot.mk F U = u * AdjoinRoot.mk F D) :
    ∃ (phiUnit DUnit : (AdjoinRoot F)ˣ) (V2 : K[X]),
      (phiUnit : AdjoinRoot F) = AdjoinRoot.mk F phi ∧
      (DUnit : AdjoinRoot F) = AdjoinRoot.mk F D ∧
      V2.degree < F.degree ∧
      AdjoinRoot.mk F V2 = u ^ 2 * AdjoinRoot.mk F D ∧
      U ^ 2 - F * criticalQuadraticTrace F.leadingCoeff D (AdjoinRoot.root F) u phiUnit =
        D * V2 := by
  have hF : F ≠ 0 := by
    intro hzero
    simp [hzero] at hFdegree
  have hleading : F.leadingCoeff ≠ 0 := leadingCoeff_ne_zero.mpr hF
  obtain ⟨phiUnit, DUnit, V2, Q, hphi, hD, hVdegree, hVvalue,
      hidentity, _hQdegree, htrace⟩ :=
    actual_quadratic_interpolation_with_moments F phi D U hF (by omega)
      hsep hderivative u hequation
  let rho := Algebra.trace K (AdjoinRoot F)
    (u * AdjoinRoot.root F ^ 4 * (↑phiUnit⁻¹ : AdjoinRoot F))
  let mu := fun j => Algebra.trace K (AdjoinRoot F)
    (u ^ 2 * AdjoinRoot.root F ^ j * (↑phiUnit⁻¹ : AdjoinRoot F))
  have hrho : F.leadingCoeff * rho = U.coeff 5 := by
    dsimp only [rho]
    rw [source_degree_ten_numerator_leading_trace F phi D U hFdegree hsep
      hderivative hUdegree phiUnit DUnit hphi hD u hequation]
    field_simp [hleading]
  have hmu0 : mu 0 = V2.coeff 9 / F.leadingCoeff := by
    simpa only [mu, hFdegree, Nat.reduceSub, pow_zero, one_mul,
      (mod_eq_self_iff hF).mpr hVdegree] using htrace 0
  have hmu1 : mu 1 = ((X * V2) % F).coeff 9 / F.leadingCoeff := by
    simpa only [mu, hFdegree, Nat.reduceSub, pow_one] using htrace 1
  have hmu2 : mu 2 = ((X ^ 2 * V2) % F).coeff 9 / F.leadingCoeff := by
    simpa only [mu, hFdegree, Nat.reduceSub] using htrace 2
  obtain ⟨hrec1, hrec2⟩ :=
    source_two_step_remainder_top_recurrence F V2 hF (by omega) hVdegree
  simp only [hFdegree, Nat.reduceSub] at hrec1 hrec2
  have hm0 : F.leadingCoeff * mu 0 = V2.coeff 9 := by
    rw [hmu0]
    field_simp [hleading]
  have hm1 : F.leadingCoeff * mu 1 = V2.coeff 8 - mu 0 * F.coeff 9 := by
    rw [hmu1, hmu0, hrec1]
    field_simp [hleading]
  have hm2 : F.leadingCoeff * mu 2 = V2.coeff 7 -
      mu 0 * F.coeff 8 - mu 1 * F.coeff 9 := by
    rw [hmu2, hmu0, hmu1, hrec2]
    field_simp [hleading]
  have hQ : Q = criticalQuadraticTrace F.leadingCoeff D (AdjoinRoot.root F) u phiUnit :=
    general_degree_ten_critical_quadratic F D U V2 Q hFdegree hUdegree hDdegree
      hVdegree hidentity rho mu hrho hm0 hm1 hm2
  refine ⟨phiUnit, DUnit, V2, hphi, hD, hVdegree, hVvalue, ?_⟩
  rwa [hQ] at hidentity

end Litt3.CartierAndSpin
