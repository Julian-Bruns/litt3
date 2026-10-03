import Solutions.CartierAndSpin.SeparableTraceDualRemainder
import Solutions.CartierAndSpin.CriticalTraceTranslation
import Solutions.CartierAndSpin.CriticalInterpolationIdentity

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The genuine quadratic moments are exactly reduced top coefficients of
the interpolator in the original source algebra. No splitting, distinct
critical roots, monicity or characteristic restriction is needed. -/
theorem quadratic_interpolator_trace_remainder (F phi D V2 : K[X])
    (hF : F ≠ 0) (hsep : F.Separable)
    (hderivative : F.derivative = phi * D)
    (phiUnit DUnit : (AdjoinRoot F)ˣ)
    (hphi : (phiUnit : AdjoinRoot F) = AdjoinRoot.mk F phi)
    (hD : (DUnit : AdjoinRoot F) = AdjoinRoot.mk F D)
    (u : AdjoinRoot F)
    (hV2 : AdjoinRoot.mk F V2 = u ^ 2 * AdjoinRoot.mk F D) (j : ℕ) :
    Algebra.trace K (AdjoinRoot F)
      (u ^ 2 * AdjoinRoot.root F ^ j * (↑phiUnit⁻¹ : AdjoinRoot F)) =
      (X ^ j * V2 % F).coeff (F.natDegree - 1) / F.leadingCoeff := by
  have hproduct : (↑(phiUnit * DUnit) : AdjoinRoot F) =
      AdjoinRoot.mk F F.derivative := by
    rw [Units.val_mul, hphi, hD, ← map_mul, ← hderivative]
  have htrace := separable_quotient_residue_trace_remainder
    F (X ^ j * V2) hF hsep (phiUnit * DUnit) hproduct
  have heq : AdjoinRoot.mk F (X ^ j * V2) *
      (↑(phiUnit * DUnit)⁻¹ : AdjoinRoot F) =
      u ^ 2 * AdjoinRoot.root F ^ j * (↑phiUnit⁻¹ : AdjoinRoot F) := by
    rw [map_mul, map_pow, AdjoinRoot.mk_X, hV2, ← hD,
      mul_inv_rev, Units.val_mul]
    calc
      (AdjoinRoot.root F ^ j * (u ^ 2 * (DUnit : AdjoinRoot F))) *
          ((↑DUnit⁻¹ : AdjoinRoot F) * (↑phiUnit⁻¹ : AdjoinRoot F)) =
          u ^ 2 * AdjoinRoot.root F ^ j *
            (((DUnit : AdjoinRoot F) * (↑DUnit⁻¹ : AdjoinRoot F)) *
              (↑phiUnit⁻¹ : AdjoinRoot F)) := by ring
      _ = _ := by rw [Units.mul_inv]; ring
  rwa [heq] at htrace

/-- Existence of the exact quadratic interpolator, its quotient degree
bound and all actual trace-coefficient identities, derived together from
the numerator equation in the original separable source algebra. -/
theorem actual_quadratic_interpolation_with_moments (F phi D U : K[X])
    (hF : F ≠ 0) (hpositive : 0 < F.natDegree) (hsep : F.Separable)
    (hderivative : F.derivative = phi * D)
    (u : AdjoinRoot F) (hequation : AdjoinRoot.mk F U = u * AdjoinRoot.mk F D) :
    ∃ (phiUnit DUnit : (AdjoinRoot F)ˣ) (V2 Q : K[X]),
      (phiUnit : AdjoinRoot F) = AdjoinRoot.mk F phi ∧
      (DUnit : AdjoinRoot F) = AdjoinRoot.mk F D ∧
      V2.degree < F.degree ∧
      AdjoinRoot.mk F V2 = u ^ 2 * AdjoinRoot.mk F D ∧
      U ^ 2 - F * Q = D * V2 ∧
      Q.natDegree ≤ max (2 * U.natDegree - F.natDegree) (D.natDegree - 1) ∧
      ∀ j : ℕ, Algebra.trace K (AdjoinRoot F)
        (u ^ 2 * AdjoinRoot.root F ^ j * (↑phiUnit⁻¹ : AdjoinRoot F)) =
        (X ^ j * V2 % F).coeff (F.natDegree - 1) / F.leadingCoeff := by
  obtain ⟨hphiunit, hDunit⟩ :=
    separable_quotient_derivative_factor_units F phi D hsep hderivative
  obtain ⟨phiUnit, hphi⟩ := hphiunit
  obtain ⟨DUnit, hD⟩ := hDunit
  obtain ⟨V2, Q, hVdegree, hV2, hidentity⟩ :=
    actual_source_quadratic_interpolator F D U hF u hequation
  refine ⟨phiUnit, DUnit, V2, Q, hphi, hD, hVdegree, hV2, hidentity,
    critical_interpolation_quotient_degree_bound F D U V2 Q hF hpositive
      hVdegree hidentity, ?_⟩
  intro j
  exact quadratic_interpolator_trace_remainder F phi D V2 hF hsep
    hderivative phiUnit DUnit hphi hD u hV2 j

end Litt3.CartierAndSpin
