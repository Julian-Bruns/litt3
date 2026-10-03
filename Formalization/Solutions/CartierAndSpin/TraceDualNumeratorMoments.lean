import Solutions.CartierAndSpin.SeparableTraceDualRemainder
import Solutions.CartierAndSpin.CriticalTraceTranslation

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- Every weighted linear moment of the actual numerator value is a
literal reduced top coefficient, not a presumed root-sum interpretation. -/
theorem source_numerator_weighted_trace_remainder (F phi D U : K[X])
    (hF : F ≠ 0) (hsep : F.Separable)
    (hderivative : F.derivative = phi * D)
    (phiUnit DUnit : (AdjoinRoot F)ˣ)
    (hphi : (phiUnit : AdjoinRoot F) = AdjoinRoot.mk F phi)
    (hD : (DUnit : AdjoinRoot F) = AdjoinRoot.mk F D)
    (u : AdjoinRoot F) (hequation : AdjoinRoot.mk F U = u * AdjoinRoot.mk F D)
    (j : ℕ) :
    Algebra.trace K (AdjoinRoot F)
      (u * AdjoinRoot.root F ^ j * (↑phiUnit⁻¹ : AdjoinRoot F)) =
      ((U * X ^ j) % F).coeff (F.natDegree - 1) / F.leadingCoeff := by
  have hproduct : (↑(phiUnit * DUnit) : AdjoinRoot F) =
      AdjoinRoot.mk F F.derivative := by
    rw [Units.val_mul, hphi, hD, ← map_mul, ← hderivative]
  have htrace := separable_quotient_residue_trace_remainder F (U * X ^ j)
    hF hsep (phiUnit * DUnit) hproduct
  have heq : AdjoinRoot.mk F (U * X ^ j) *
      (↑(phiUnit * DUnit)⁻¹ : AdjoinRoot F) =
      u * AdjoinRoot.root F ^ j * (↑phiUnit⁻¹ : AdjoinRoot F) := by
    rw [map_mul, map_pow, AdjoinRoot.mk_X, hequation, ← hD,
      mul_inv_rev, Units.val_mul]
    calc
      ((u * (DUnit : AdjoinRoot F)) * AdjoinRoot.root F ^ j) *
          ((↑DUnit⁻¹ : AdjoinRoot F) * (↑phiUnit⁻¹ : AdjoinRoot F)) =
          u * AdjoinRoot.root F ^ j *
            (((DUnit : AdjoinRoot F) * (↑DUnit⁻¹ : AdjoinRoot F)) *
              (↑phiUnit⁻¹ : AdjoinRoot F)) := by ring
      _ = _ := by rw [Units.mul_inv]; ring
  rwa [heq] at htrace

/-- The actual degree-ten leading numerator coefficient recovers rho,
including numerator degree drops, in every characteristic. -/
theorem source_degree_ten_numerator_leading_trace (F phi D U : K[X])
    (hFdegree : F.natDegree = 10) (hsep : F.Separable)
    (hderivative : F.derivative = phi * D) (hUdegree : U.natDegree ≤ 5)
    (phiUnit DUnit : (AdjoinRoot F)ˣ)
    (hphi : (phiUnit : AdjoinRoot F) = AdjoinRoot.mk F phi)
    (hD : (DUnit : AdjoinRoot F) = AdjoinRoot.mk F D)
    (u : AdjoinRoot F) (hequation : AdjoinRoot.mk F U = u * AdjoinRoot.mk F D) :
    Algebra.trace K (AdjoinRoot F)
      (u * AdjoinRoot.root F ^ 4 * (↑phiUnit⁻¹ : AdjoinRoot F)) =
      U.coeff 5 / F.leadingCoeff := by
  have hF : F ≠ 0 := by
    intro hzero
    simp [hzero] at hFdegree
  have hsmall : (U * X ^ 4).degree < F.degree := by
    rw [degree_eq_natDegree hF, hFdegree]
    apply lt_of_le_of_lt (degree_mul_le _ _)
    calc
      U.degree + (X ^ 4 : K[X]).degree ≤ (5 : WithBot ℕ) + 4 := by
        rw [degree_X_pow]
        exact add_le_add (degree_le_natDegree.trans (by exact_mod_cast hUdegree)) le_rfl
      _ < 10 := by norm_num
  rw [source_numerator_weighted_trace_remainder F phi D U hF hsep
    hderivative phiUnit DUnit hphi hD u hequation 4,
    (mod_eq_self_iff hF).mpr hsmall, hFdegree]
  exact congrArg (fun a : K => a / F.leadingCoeff) (coeff_mul_X_pow U 4 5)

end Litt3.CartierAndSpin
