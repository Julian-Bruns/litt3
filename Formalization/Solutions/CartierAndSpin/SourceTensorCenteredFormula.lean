import Solutions.CartierAndSpin.SourceTensorCorrections
import Solutions.CartierAndSpin.AffineDifferentialEnergy

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- The cleared actual tensor vanishes on the entire s=0 boundary,
without interpreting an undefined affine center. -/
theorem source_universal_cleared_zero
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (q tau c : K) :
    sourceUniversalClearedEnergy F hs e unit q tau 0 c = 0 := by
  apply (rationalSymmetricSquareCoordinate e).injective
  unfold sourceUniversalClearedEnergy
  simp only [zero_smul, map_zero, smul_zero, sub_zero, map_sub, map_smul,
    rationalSymmetricSquareCoordinate_product, mul_zero]

/-- The exact canonical center correction and its denominator clearing
hold as literal universal symmetric tensors in the original source.
There is no splitting or connectedness assumption. -/
theorem source_universal_centered_formula
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau)
    (hs : (H %ₘ (X ^ p + C q)).coeff (p - 1) ≠ 0) :
    let s := (H %ₘ (X ^ p + C q)).coeff (p - 1)
    let c := (H %ₘ (X ^ p + C q)).coeff (p - 2)
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      sourceUniversalCenteredEnergy F hsep e unit (c / s) =
        sourceUniversalSymmetricEnergy F hsep e unit - (2 / tau : K) •
          rationalSymmetricProduct K (KaehlerDifferential k K) (KaehlerDifferential.D k K q)
            (KaehlerDifferential.D k K c - (c / s) • KaehlerDifferential.D k K s) ∧
      sourceUniversalClearedEnergy F hsep e unit q tau s c =
        s • sourceUniversalCenteredEnergy F hsep e unit (c / s) := by
  dsimp only
  obtain ⟨unit, E, hunit, compatible, hdifferential, hsquare, hpower⟩ :=
    sourceQuotientDifferentialCalculus (universalCoordinateDerivation e)
      F H p q tau hp hdegree htau hsep hsource
  obtain ⟨unit0, hunit0, hmoments⟩ := source_coefficient_moments
    F H p q tau (by omega) hdegree htau hsep hsource
  have hunitEq : unit0 = unit := by apply Units.ext; rw [hunit0, hunit]
  subst unit0
  have hzero : Algebra.trace K (AdjoinRoot F) (↑unit⁻¹ : AdjoinRoot F) = 0 := by
    simpa only [pow_zero, one_mul] using (hmoments 0 (by omega)).1
  have hone : Algebra.trace K (AdjoinRoot F)
      (E (AdjoinRoot.root F) * (↑unit⁻¹ : AdjoinRoot F)) =
      (H %ₘ (X ^ p + C q)).coeff (p - 1) * universalCoordinateDerivation e q / tau := by
    simpa only [Nat.reduceSub, pow_zero, one_mul] using hdifferential 1 (by omega) (by omega)
  have hratio := functional_centered_energy_ratio (universalCoordinateDerivation e) E compatible
    (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F) (AdjoinRoot.root F)
    q tau ((H %ₘ (X ^ p + C q)).coeff (p - 1))
    ((H %ₘ (X ^ p + C q)).coeff (p - 2)) hs hzero hone
  refine ⟨unit, hunit, ?_, ?_⟩
  · apply (rationalSymmetricSquareCoordinate e).injective
    rw [source_universal_centered_energy_coordinate F hsep e unit E compatible, hratio,
      map_sub, source_universal_symmetric_energy_coordinate F hsep e unit E compatible,
      map_smul, rationalSymmetricSquareCoordinate_product, map_sub, map_smul]
    simp only [smul_eq_mul, ← universalCoordinateDerivation_apply]
    unfold sourceQuotientDifferentialEnergy
    ring
  · apply (rationalSymmetricSquareCoordinate e).injective
    rw [source_universal_cleared_energy_coordinate F hsep e unit E compatible, map_smul,
      source_universal_centered_energy_coordinate F hsep e unit E compatible, hratio]
    unfold clearedDifferentialExpression sourceQuotientDifferentialEnergy
    simp only [smul_eq_mul]
    field_simp

end Litt3.CartierAndSpin
