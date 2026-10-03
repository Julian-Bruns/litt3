import Solutions.CartierAndSpin.PowerBasisSourceQuotient
import Mathlib.RingTheory.Adjoin.PowerBasis
import Mathlib.FieldTheory.IntermediateField.Adjoin.Algebra

namespace Litt3.CartierAndSpin

open Polynomial

variable {K L : Type*} [Field K] [Field L] [Algebra K L]

/-- A genuine field generator satisfying a nonzero polynomial constructs
its full power basis, without a supplied basis or finite-dimensional instance. -/
theorem primitive_field_power_basis (w : L) (F : K[X]) (hF : F ≠ 0)
    (hroot : aeval w F = 0)
    (hgen : IntermediateField.adjoin K ({w} : Set L) = ⊤) :
    ∃ pb : PowerBasis K L, pb.gen = w ∧ pb.dim = (minpoly K w).natDegree := by
  have hw : IsIntegral K w := IsAlgebraic.isIntegral ⟨F, hF, hroot⟩
  have hsub := IntermediateField.adjoin_simple_toSubalgebra_of_isAlgebraic hw.isAlgebraic
  rw [hgen, IntermediateField.top_toSubalgebra] at hsub
  let pb := PowerBasis.ofAdjoinEqTop hw hsub.symm
  exact ⟨pb, PowerBasis.ofAdjoinEqTop_gen hw hsub.symm,
    PowerBasis.ofAdjoinEqTop_dim hw hsub.symm⟩

/-- A nonzero root polynomial of the actual extension degree is exactly
the raw minimal polynomial, retaining its original leading coefficient. -/
theorem primitive_field_raw_polynomial (w : L) (F : K[X]) (hF : F ≠ 0)
    (hroot : aeval w F = 0)
    (hgen : IntermediateField.adjoin K ({w} : Set L) = ⊤)
    (hdegree : F.natDegree = Module.finrank K L) :
    ∃ pb : PowerBasis K L, pb.gen = w ∧
      F = C F.leadingCoeff * minpoly K pb.gen := by
  obtain ⟨pb, hpb, hdim⟩ := primitive_field_power_basis w F hF hroot hgen
  have hminDegree : (minpoly K w).natDegree = F.natDegree := by
    rw [← hdim, hdegree, Module.finrank_eq_card_basis pb.basis, Fintype.card_fin]
  have hleading : F.leadingCoeff ≠ 0 := leadingCoeff_ne_zero.mpr hF
  have hnorm : F * C F.leadingCoeff⁻¹ = minpoly K w := by
    apply minpoly.unique_of_degree_le_degree_minpoly K w
      (monic_mul_leadingCoeff_inv hF)
    · rw [map_mul, hroot, zero_mul]
    · rw [degree_mul_leadingCoeff_inv F hF, degree_eq_natDegree hF,
        degree_eq_natDegree (minpoly.ne_zero (IsAlgebraic.isIntegral ⟨F, hF, hroot⟩)),
        hminDegree]
  refine ⟨pb, hpb, ?_⟩
  rw [hpb, ← hnorm]
  calc
    F = C F.leadingCoeff * (F * C F.leadingCoeff⁻¹) := by
      rw [mul_comm F (C _), ← mul_assoc, ← C_mul, mul_inv_cancel₀ hleading, C_1, one_mul]
    _ = _ := rfl

/-- All five canonical translation invariants in the actual generated
degree-ten field. Neither a power basis nor a raw-minpoly identification
is an input: both are constructed from the original field generator,
root equation and actual extension degree. -/
theorem critical_trace_translation_actual_field [CharP K 5]
    (w u : L) (F phi D U : K[X])
    (hgen : IntermediateField.adjoin K ({w} : Set L) = ⊤)
    (hroot : aeval w F = 0) (hactualdegree : Module.finrank K L = 10)
    (hdegree : F.natDegree = 10) (hsep : F.Separable)
    (hderivative : F.derivative = phi * D) (hDdegree : D.natDegree ≤ 3)
    (hUdegree : U.natDegree ≤ 5) (hequation : aeval w U = u * aeval w D) :
    ∃ phiUnit DUnit : Lˣ,
      (phiUnit : L) = aeval w phi ∧ (DUnit : L) = aeval w D ∧
      Specifications.AlgebraCriticalTraceTranslationOutcome (K := K) w u phiUnit := by
  have hF : F ≠ 0 := by
    intro hz
    simp only [hz, natDegree_zero] at hdegree
    omega
  obtain ⟨pb, hpb, hraw⟩ := primitive_field_raw_polynomial w F hF hroot hgen
    (hdegree.trans hactualdegree.symm)
  have hleading : F.leadingCoeff ≠ 0 := leadingCoeff_ne_zero.mpr hF
  have h := critical_trace_translation_power_basis pb F phi D U F.leadingCoeff hleading
    hraw hdegree hsep hderivative hDdegree hUdegree u (by simpa only [hpb] using hequation)
  simpa only [hpb] using h

end Litt3.CartierAndSpin
