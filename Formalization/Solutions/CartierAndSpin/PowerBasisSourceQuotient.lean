import Solutions.CartierAndSpin.CriticalTraceTranslation

namespace Litt3.CartierAndSpin

open Polynomial

variable {K A : Type*} [Field K] [CommRing A] [Algebra K A]

/-- An actual primitive algebra with an actual power basis is identified
with its raw minimal-polynomial quotient, retaining the leading scalar. -/
noncomputable def powerBasisRawQuotientEquiv (pb : PowerBasis K A)
    (F : K[X]) (leading : K) (hleading : leading ≠ 0)
    (hF : F = C leading * minpoly K pb.gen) : AdjoinRoot F ≃ₐ[K] A :=
  AdjoinRoot.equiv' F pb
    (by
      rw [AdjoinRoot.aeval_eq]
      have hpoly : minpoly K pb.gen = C leading⁻¹ * F := by
        rw [hF, ← mul_assoc, ← C_mul, inv_mul_cancel₀ hleading, C_1, one_mul]
      rw [hpoly, map_mul, AdjoinRoot.mk_self, mul_zero])
    (by rw [hF, map_mul, minpoly.aeval, mul_zero])

theorem powerBasisRawQuotientEquiv_root (pb : PowerBasis K A)
    (F : K[X]) (leading : K) (hleading : leading ≠ 0)
    (hF : F = C leading * minpoly K pb.gen) :
    powerBasisRawQuotientEquiv pb F leading hleading hF (AdjoinRoot.root F) = pb.gen := by
  simp [powerBasisRawQuotientEquiv, AdjoinRoot.equiv']

theorem powerBasisRawQuotientEquiv_mk (pb : PowerBasis K A)
    (F : K[X]) (leading : K) (hleading : leading ≠ 0)
    (hF : F = C leading * minpoly K pb.gen) (P : K[X]) :
    powerBasisRawQuotientEquiv pb F leading hleading hF (AdjoinRoot.mk F P) =
      aeval pb.gen P := by
  simp [powerBasisRawQuotientEquiv, AdjoinRoot.equiv', aeval_def]

/-- Low trace-dual interpolation in every actual primitive algebra,
transported through a constructed quotient equivalence. -/
theorem power_basis_low_residue_trace (pb : PowerBasis K A)
    (F J : K[X]) (leading : K) (hleading : leading ≠ 0)
    (hF : F = C leading * minpoly K pb.gen) (hFne : F ≠ 0) (hsep : F.Separable)
    (derivativeUnit : Aˣ) (hunit : (derivativeUnit : A) = aeval pb.gen F.derivative)
    (hdegree : J.degree < ↑(F.natDegree - 1)) :
    Algebra.trace K A (aeval pb.gen J * (↑derivativeUnit⁻¹ : A)) = 0 := by
  let e := powerBasisRawQuotientEquiv pb F leading hleading hF
  let originalUnit := Units.map e.symm.toMonoidHom derivativeUnit
  have hunitOriginal : (originalUnit : AdjoinRoot F) = AdjoinRoot.mk F F.derivative := by
    change e.symm (derivativeUnit : A) = _
    rw [hunit]
    apply e.injective
    rw [e.apply_symm_apply]
    exact (powerBasisRawQuotientEquiv_mk pb F leading hleading hF F.derivative).symm
  have htrace := separable_quotient_low_residue_trace F J hFne hsep originalUnit
    hunitOriginal hdegree
  have heunit : Units.map e.toMonoidHom originalUnit = derivativeUnit := by
    apply Units.ext
    exact e.apply_symm_apply derivativeUnit.val
  have hinverse : e (↑originalUnit⁻¹ : AdjoinRoot F) = (↑derivativeUnit⁻¹ : A) := by
    change (↑(Units.map e.toMonoidHom originalUnit⁻¹) : A) = _
    rw [map_inv, heunit]
  rw [← Algebra.trace_eq_of_algEquiv e] at htrace
  rw [map_mul, powerBasisRawQuotientEquiv_mk, hinverse] at htrace
  exact htrace

theorem actual_trace_translation_transport (F U : K[X]) (e : AdjoinRoot F ≃ₐ[K] A)
    (phiUnit DUnit : (AdjoinRoot F)ˣ)
    (houtcome : Specifications.CriticalTraceTranslationOutcome F U phiUnit DUnit) :
    Specifications.AlgebraCriticalTraceTranslationOutcome (K := K) (e (AdjoinRoot.root F))
      (e (AdjoinRoot.mk F U * (↑DUnit⁻¹ : AdjoinRoot F)))
      (Units.map e.toMonoidHom phiUnit) := by
  have hinverse : e (↑phiUnit⁻¹ : AdjoinRoot F) =
      (↑(Units.map e.toMonoidHom phiUnit)⁻¹ : A) := by
    change (↑(Units.map e.toMonoidHom phiUnit⁻¹) : A) = _
    rw [map_inv]
  intro z
  obtain ⟨hrho, hmfive, hmu⟩ := houtcome z
  refine ⟨?_, ?_, ?_⟩
  · simpa only [← Algebra.trace_eq_of_algEquiv e, map_mul, map_pow, map_sub,
      e.commutes, hinverse] using hrho
  · simpa only [← Algebra.trace_eq_of_algEquiv e, map_sub, e.commutes] using hmfive
  · intro j hj
    simpa only [← Algebra.trace_eq_of_algEquiv e, map_mul, map_pow, map_sub,
      e.commutes, hinverse] using hmu j hj

/-- The source's displayed numerator equation identifies the actual
function u uniquely with the actual quotient value U/D. -/
theorem numerator_equation_value_unique (w u : A) (D U : K[X]) (DUnit : Aˣ)
    (hD : (DUnit : A) = aeval w D) (hequation : aeval w U = u * aeval w D) :
    u = aeval w U * (↑DUnit⁻¹ : A) := by
  calc
    u = u * ((DUnit : A) * (↑DUnit⁻¹ : A)) := by rw [Units.mul_inv, mul_one]
    _ = (u * aeval w D) * (↑DUnit⁻¹ : A) := by rw [← hD]; ring
    _ = aeval w U * (↑DUnit⁻¹ : A) := by rw [← hequation]

/-- The exact five translation invariants for the actual primitive source
algebra, with its quotient equivalence constructed from the raw minimal
polynomial and its numerator equation. -/
theorem critical_trace_translation_power_basis [CharP K 5]
    (pb : PowerBasis K A) (F phi D U : K[X]) (leading : K) (hleading : leading ≠ 0)
    (hF : F = C leading * minpoly K pb.gen)
    (hdegree : F.natDegree = 10) (hsep : F.Separable)
    (hderivative : F.derivative = phi * D) (hDdegree : D.natDegree ≤ 3)
    (hUdegree : U.natDegree ≤ 5) (u : A)
    (hequation : aeval pb.gen U = u * aeval pb.gen D) :
    ∃ phiUnit DUnit : Aˣ,
      (phiUnit : A) = aeval pb.gen phi ∧ (DUnit : A) = aeval pb.gen D ∧
      Specifications.AlgebraCriticalTraceTranslationOutcome (K := K) pb.gen u phiUnit := by
  obtain ⟨phiUnit, DUnit, hphi, hD, houtcome⟩ := critical_trace_translation_degree_ten
    F phi D U hdegree hsep hderivative hDdegree hUdegree
  let e := powerBasisRawQuotientEquiv pb F leading hleading hF
  let phiActual := Units.map e.toMonoidHom phiUnit
  let DActual := Units.map e.toMonoidHom DUnit
  have hphiActual : (phiActual : A) = aeval pb.gen phi := by
    change e (phiUnit : AdjoinRoot F) = _
    rw [hphi]
    exact powerBasisRawQuotientEquiv_mk pb F leading hleading hF phi
  have hDActual : (DActual : A) = aeval pb.gen D := by
    change e (DUnit : AdjoinRoot F) = _
    rw [hD]
    exact powerBasisRawQuotientEquiv_mk pb F leading hleading hF D
  have hu : u = aeval pb.gen U * (↑DActual⁻¹ : A) :=
    numerator_equation_value_unique pb.gen u D U DActual hDActual hequation
  have hinverse : e (↑DUnit⁻¹ : AdjoinRoot F) = (↑DActual⁻¹ : A) := by
    change (↑(Units.map e.toMonoidHom DUnit⁻¹) : A) = _
    rw [map_inv]
  refine ⟨phiActual, DActual, hphiActual, hDActual, ?_⟩
  have h := actual_trace_translation_transport F U e phiUnit DUnit houtcome
  rw [powerBasisRawQuotientEquiv_root, map_mul, powerBasisRawQuotientEquiv_mk,
    hinverse, ← hu] at h
  exact h

end Litt3.CartierAndSpin
