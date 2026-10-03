import Solutions.CartierAndSpin.SeparableResidueTrace
import Solutions.CartierAndSpin.CriticalTranslation
import Theorems.CartierAndSpin.CriticalTraceTranslation

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

theorem separable_quotient_derivative_factor_units (F phi D : K[X])
    (hsep : F.Separable) (hderivative : F.derivative = phi * D) :
    IsUnit (AdjoinRoot.mk F phi) ∧ IsUnit (AdjoinRoot.mk F D) := by
  have h := separable_quotient_derivative_isUnit F hsep
  rw [hderivative, map_mul] at h
  exact ⟨isUnit_of_mul_isUnit_left h, isUnit_of_mul_isUnit_right h⟩

/-- The actual factor weight 1/phi has zero trace against every polynomial
whose product with D lies below the trace-dual top coefficient. -/
theorem separable_quotient_factor_weight_trace_zero (F phi D J : K[X])
    (hF : F ≠ 0) (hsep : F.Separable) (hderivative : F.derivative = phi * D)
    (phiUnit DUnit : (AdjoinRoot F)ˣ)
    (hphi : (phiUnit : AdjoinRoot F) = AdjoinRoot.mk F phi)
    (hD : (DUnit : AdjoinRoot F) = AdjoinRoot.mk F D)
    (hdegree : (J * D).degree < ↑(F.natDegree - 1)) :
    Algebra.trace K (AdjoinRoot F)
      (AdjoinRoot.mk F J * (↑phiUnit⁻¹ : AdjoinRoot F)) = 0 := by
  have hproduct : (↑(phiUnit * DUnit) : AdjoinRoot F) = AdjoinRoot.mk F F.derivative := by
    rw [Units.val_mul, hphi, hD, ← map_mul, ← hderivative]
  have htrace := separable_quotient_low_residue_trace F (J * D) hF hsep
    (phiUnit * DUnit) hproduct hdegree
  have heq : AdjoinRoot.mk F (J * D) * (↑(phiUnit * DUnit)⁻¹ : AdjoinRoot F) =
      AdjoinRoot.mk F J * (↑phiUnit⁻¹ : AdjoinRoot F) := by
    rw [map_mul, ← hD, mul_inv_rev, Units.val_mul]
    calc
      (AdjoinRoot.mk F J * (DUnit : AdjoinRoot F)) *
          ((↑DUnit⁻¹ : AdjoinRoot F) * (↑phiUnit⁻¹ : AdjoinRoot F)) =
          AdjoinRoot.mk F J *
            (((DUnit : AdjoinRoot F) * (↑DUnit⁻¹ : AdjoinRoot F)) *
              (↑phiUnit⁻¹ : AdjoinRoot F)) := by ring
      _ = _ := by rw [Units.mul_inv]; ring
  rwa [heq] at htrace

/-- The actual quotient value U/D has zero weighted trace below the
trace-dual top degree. No critical-root discriminant is needed. -/
theorem separable_quotient_factor_value_trace_zero (F phi D U J : K[X])
    (hF : F ≠ 0) (hsep : F.Separable) (hderivative : F.derivative = phi * D)
    (phiUnit DUnit : (AdjoinRoot F)ˣ)
    (hphi : (phiUnit : AdjoinRoot F) = AdjoinRoot.mk F phi)
    (hD : (DUnit : AdjoinRoot F) = AdjoinRoot.mk F D)
    (hdegree : (U * J).degree < ↑(F.natDegree - 1)) :
    Algebra.trace K (AdjoinRoot F)
      ((AdjoinRoot.mk F U * (↑DUnit⁻¹ : AdjoinRoot F)) *
        AdjoinRoot.mk F J * (↑phiUnit⁻¹ : AdjoinRoot F)) = 0 := by
  have hproduct : (↑(phiUnit * DUnit) : AdjoinRoot F) = AdjoinRoot.mk F F.derivative := by
    rw [Units.val_mul, hphi, hD, ← map_mul, ← hderivative]
  have htrace := separable_quotient_low_residue_trace F (U * J) hF hsep
    (phiUnit * DUnit) hproduct hdegree
  have heq : AdjoinRoot.mk F (U * J) * (↑(phiUnit * DUnit)⁻¹ : AdjoinRoot F) =
      (AdjoinRoot.mk F U * (↑DUnit⁻¹ : AdjoinRoot F)) *
        AdjoinRoot.mk F J * (↑phiUnit⁻¹ : AdjoinRoot F) := by
    rw [map_mul, mul_inv_rev, Units.val_mul]
    ring
  rwa [heq] at htrace

section ActualTrace

variable {A : Type*} [CommRing A] [Algebra K A]

theorem actual_trace_linear_translation (u weight : A) (z : K) :
    Algebra.trace K A ((u - algebraMap K A z) * weight) =
      Algebra.trace K A (u * weight) - z * Algebra.trace K A weight := by
  have heq : (u - algebraMap K A z) * weight = u * weight - z • weight := by
    rw [Algebra.smul_def]
    ring
  rw [heq, map_sub, map_smul]
  rfl

theorem actual_trace_square_translation_invariant (u weight : A) (z : K)
    (hzero : Algebra.trace K A weight = 0)
    (hone : Algebra.trace K A (u * weight) = 0) :
    Algebra.trace K A ((u - algebraMap K A z) ^ 2 * weight) =
      Algebra.trace K A (u ^ 2 * weight) := by
  have heq : (u - algebraMap K A z) ^ 2 * weight =
      u ^ 2 * weight - (2 * z) • (u * weight) + (z ^ 2) • weight := by
    simp only [Algebra.smul_def, map_mul, map_pow, map_ofNat]
    ring
  rw [heq, map_add, map_sub, map_smul, map_smul, hzero, hone]
  simp

end ActualTrace

theorem polynomial_quotient_trace_scalar_eq_zero (F : K[X]) (hF : F ≠ 0)
    (hdegree : (F.natDegree : K) = 0) (z : K) :
    Algebra.trace K (AdjoinRoot F) (algebraMap K (AdjoinRoot F) z) = 0 := by
  rw [Algebra.trace_algebraMap, Module.finrank_eq_card_basis (AdjoinRoot.powerBasis hF).basis,
    Fintype.card_fin, AdjoinRoot.powerBasis_dim, nsmul_eq_mul, hdegree, zero_mul]

theorem critical_translation_numerator_degree (P : K[X]) (j bound : ℕ)
    (hP : P.natDegree ≤ bound) : (X ^ j * P).degree ≤ ↑(j + bound) := by
  calc
    (X ^ j * P).degree ≤ (X ^ j : K[X]).degree + P.degree := degree_mul_le _ _
    _ ≤ (j : WithBot ℕ) + P.natDegree := by
      rw [degree_X_pow]
      exact add_le_add (le_refl _) degree_le_natDegree
    _ ≤ ↑(j + bound) := by
      exact_mod_cast (show j + P.natDegree ≤ j + bound by omega)

/-- Every critical trace identity is proved in the original actual
separable quotient. The source degree ten is used only for the displayed
polynomial degree bounds and the trace of constants in characteristic five.
Repeated roots of D and numerator degree drops are retained. -/
theorem critical_trace_translation_degree_ten [CharP K 5]
    (F phi D U : K[X]) (hdegree : F.natDegree = 10) (hsep : F.Separable)
    (hderivative : F.derivative = phi * D) (hDdegree : D.natDegree ≤ 3)
    (hUdegree : U.natDegree ≤ 5) :
    ∃ phiUnit DUnit : (AdjoinRoot F)ˣ,
      (phiUnit : AdjoinRoot F) = AdjoinRoot.mk F phi ∧
      (DUnit : AdjoinRoot F) = AdjoinRoot.mk F D ∧
      Specifications.CriticalTraceTranslationOutcome F U phiUnit DUnit := by
  have hF : F ≠ 0 := by
    intro hzero
    simp only [hzero, natDegree_zero] at hdegree
    omega
  obtain ⟨hphiunit, hDunit⟩ := separable_quotient_derivative_factor_units F phi D hsep hderivative
  obtain ⟨phiUnit, hphi⟩ := hphiunit
  obtain ⟨DUnit, hD⟩ := hDunit
  refine ⟨phiUnit, DUnit, hphi, hD, ?_⟩
  let w := AdjoinRoot.root F
  let u := AdjoinRoot.mk F U * (↑DUnit⁻¹ : AdjoinRoot F)
  have hzero (j : ℕ) (hj : j ≤ 5) :
      Algebra.trace K (AdjoinRoot F) (w ^ j * (↑phiUnit⁻¹ : AdjoinRoot F)) = 0 := by
    have h := separable_quotient_factor_weight_trace_zero F phi D (X ^ j)
      hF hsep hderivative phiUnit DUnit hphi hD (by
        apply lt_of_le_of_lt (critical_translation_numerator_degree D j 3 hDdegree)
        rw [hdegree]
        exact_mod_cast (show j + 3 < 10 - 1 by omega))
    simpa only [map_pow, AdjoinRoot.mk_X] using h
  have hone (j : ℕ) (hj : j ≤ 3) :
      Algebra.trace K (AdjoinRoot F) (u * (w ^ j * (↑phiUnit⁻¹ : AdjoinRoot F))) = 0 := by
    have h := separable_quotient_factor_value_trace_zero F phi D U (X ^ j)
      hF hsep hderivative phiUnit DUnit hphi hD (by
        rw [mul_comm U]
        apply lt_of_le_of_lt (critical_translation_numerator_degree U j 5 hUdegree)
        rw [hdegree]
        exact_mod_cast (show j + 5 < 10 - 1 by omega))
    simpa only [u, w, map_pow, AdjoinRoot.mk_X, mul_assoc] using h
  change ∀ z : K, _
  intro z
  refine ⟨?_, ?_, ?_⟩
  · have h := actual_trace_linear_translation u (w ^ 4 * (↑phiUnit⁻¹ : AdjoinRoot F)) z
    have h' : Algebra.trace K (AdjoinRoot F)
        ((u - algebraMap K (AdjoinRoot F) z) * w ^ 4 * (↑phiUnit⁻¹ : AdjoinRoot F)) =
        Algebra.trace K (AdjoinRoot F) (u * w ^ 4 * (↑phiUnit⁻¹ : AdjoinRoot F)) := by
      simpa only [mul_assoc, hzero 4 (by decide), mul_zero, sub_zero] using h
    exact h'
  · rw [map_sub, polynomial_quotient_trace_scalar_eq_zero F hF (by
      rw [hdegree]
      have h5 : (5 : K) = 0 := CharP.cast_eq_zero K 5
      calc
        (10 : K) = 2 * 5 := by norm_num
        _ = 0 := by rw [h5, mul_zero]) z, sub_zero]
  · intro j hj
    have h := actual_trace_square_translation_invariant u
      (w ^ j * (↑phiUnit⁻¹ : AdjoinRoot F)) z (hzero j (by omega)) (hone j (by omega))
    simpa only [mul_assoc] using h

/-- The same package after every actual extension of the coefficient
field. In particular this applies to K(z), with z its actual indeterminate. -/
theorem critical_trace_translation_degree_ten_scalar_extension [CharP K 5]
    {L : Type*} [Field L] [Algebra K L]
    (F phi D U : K[X]) (hdegree : F.natDegree = 10) (hsep : F.Separable)
    (hderivative : F.derivative = phi * D) (hDdegree : D.natDegree ≤ 3)
    (hUdegree : U.natDegree ≤ 5) :
    ∃ phiUnit DUnit : (AdjoinRoot (F.map (algebraMap K L)))ˣ,
      (phiUnit : AdjoinRoot (F.map (algebraMap K L))) =
        AdjoinRoot.mk (F.map (algebraMap K L)) (phi.map (algebraMap K L)) ∧
      (DUnit : AdjoinRoot (F.map (algebraMap K L))) =
        AdjoinRoot.mk (F.map (algebraMap K L)) (D.map (algebraMap K L)) ∧
      Specifications.CriticalTraceTranslationOutcome
        (F.map (algebraMap K L)) (U.map (algebraMap K L)) phiUnit DUnit := by
  letI : CharP L 5 := charP_of_injective_algebraMap (algebraMap K L).injective 5
  apply critical_trace_translation_degree_ten
    (F.map (algebraMap K L)) (phi.map (algebraMap K L))
    (D.map (algebraMap K L)) (U.map (algebraMap K L))
  · simpa only [natDegree_map_eq_of_injective (algebraMap K L).injective] using hdegree
  · exact hsep.map
  · rw [derivative_map, hderivative, Polynomial.map_mul]
  · exact natDegree_map_le.trans hDdegree
  · exact natDegree_map_le.trans hUdegree

end Litt3.CartierAndSpin
