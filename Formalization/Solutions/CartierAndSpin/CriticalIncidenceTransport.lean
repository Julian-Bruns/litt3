import Solutions.CartierAndSpin.ActualDegreeTenCriticalIncidence
import Solutions.CartierAndSpin.PrimitiveFieldPresentations

namespace Litt3.CartierAndSpin

open Polynomial

variable {K A B : Type*} [Field K] [CommRing A] [CommRing B]
  [Algebra K A] [Algebra K B]

/-- The actual critical trace quadratic is invariant under an actual
coefficient-algebra equivalence; all traces and denominator inverses are
transported, not replaced by a root-sum proxy. -/
theorem critical_quadratic_trace_alg_equiv (e : A ≃ₐ[K] B)
    (leading : K) (D : K[X]) (w u : A) (phiUnit : Aˣ) :
    criticalQuadraticTrace leading D (e w) (e u) (Units.map e.toMonoidHom phiUnit) =
      criticalQuadraticTrace leading D w u phiUnit := by
  have hinverse : (↑(Units.map e.toMonoidHom phiUnit)⁻¹ : B) = e (↑phiUnit⁻¹ : A) := rfl
  have hrho : Algebra.trace K B (e u * (e w) ^ 4 *
      (↑(Units.map e.toMonoidHom phiUnit)⁻¹ : B)) =
      Algebra.trace K A (u * w ^ 4 * (↑phiUnit⁻¹ : A)) := by
    rw [hinverse, ← map_pow, ← map_mul, ← map_mul, Algebra.trace_eq_of_algEquiv e]
  have hmu (j : ℕ) : Algebra.trace K B ((e u) ^ 2 * (e w) ^ j *
      (↑(Units.map e.toMonoidHom phiUnit)⁻¹ : B)) =
      Algebra.trace K A (u ^ 2 * w ^ j * (↑phiUnit⁻¹ : A)) := by
    rw [hinverse, ← map_pow, ← map_pow, ← map_mul, ← map_mul,
      Algebra.trace_eq_of_algEquiv e]
  simp only [criticalQuadraticTrace, criticalQuadraticFromMoments, hrho, hmu]

section ActualField

variable {L : Type*} [Field L] [Algebra K L]

/-- The full literal critical incidence in an actual primitive field
source. The actual power basis and raw-polynomial quotient equivalence
are constructed from its generator, root equation and actual degree. -/
theorem primitive_field_degree_ten_critical_incidence (w u : L) (F phi D U : K[X])
    (hgen : IntermediateField.adjoin K ({w} : Set L) = ⊤)
    (hroot : aeval w F = 0) (hactualdegree : Module.finrank K L = 10)
    (hdegree : F.natDegree = 10) (hsep : F.Separable)
    (hderivative : F.derivative = phi * D)
    (hDdegree : D.natDegree ≤ 3) (hUdegree : U.natDegree ≤ 5)
    (hequation : aeval w U = u * aeval w D) :
    ∃ (phiUnit DUnit : Lˣ) (V2 : K[X]),
      (phiUnit : L) = aeval w phi ∧ (DUnit : L) = aeval w D ∧
      V2.degree < F.degree ∧ aeval w V2 = u ^ 2 * aeval w D ∧
      U ^ 2 - F * criticalQuadraticTrace F.leadingCoeff D w u phiUnit = D * V2 := by
  have hF : F ≠ 0 := by
    intro hzero
    simp [hzero] at hdegree
  have hleading : F.leadingCoeff ≠ 0 := leadingCoeff_ne_zero.mpr hF
  obtain ⟨pb, hpb, hraw⟩ := primitive_field_raw_polynomial w F hF hroot hgen
    (hdegree.trans hactualdegree.symm)
  let e := powerBasisRawQuotientEquiv pb F F.leadingCoeff hleading hraw
  have he_mk (P : K[X]) : e (AdjoinRoot.mk F P) = aeval w P := by
    rw [powerBasisRawQuotientEquiv_mk, hpb]
  have he_root : e (AdjoinRoot.root F) = w := by
    rw [powerBasisRawQuotientEquiv_root, hpb]
  have horiginal : AdjoinRoot.mk F U = e.symm u * AdjoinRoot.mk F D := by
    apply e.injective
    rw [map_mul, e.apply_symm_apply, he_mk, he_mk]
    exact hequation
  obtain ⟨phiOriginal, DOriginal, V2, hphi, hD, hVdegree, hVvalue, hidentity⟩ :=
    actual_degree_ten_critical_incidence F phi D U hdegree hsep
      hderivative hUdegree hDdegree (e.symm u) horiginal
  let phiActual := Units.map e.toMonoidHom phiOriginal
  let DActual := Units.map e.toMonoidHom DOriginal
  have hphiActual : (phiActual : L) = aeval w phi := by
    change e (phiOriginal : AdjoinRoot F) = _
    rw [hphi, he_mk]
  have hDActual : (DActual : L) = aeval w D := by
    change e (DOriginal : AdjoinRoot F) = _
    rw [hD, he_mk]
  refine ⟨phiActual, DActual, V2, hphiActual, hDActual, hVdegree, ?_, ?_⟩
  · have h := congrArg e hVvalue
    simpa only [map_mul, map_pow, e.apply_symm_apply, he_mk] using h
  · have hQ := critical_quadratic_trace_alg_equiv e F.leadingCoeff D
      (AdjoinRoot.root F) (e.symm u) phiOriginal
    rw [he_root, e.apply_symm_apply] at hQ
    rwa [← hQ] at hidentity

end ActualField

end Litt3.CartierAndSpin
