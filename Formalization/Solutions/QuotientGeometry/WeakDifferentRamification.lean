import Solutions.QuotientGeometry.WeakOriginalDifferent
import Solutions.QuotientGeometry.WeakTameOriginalRamification
import Solutions.QuotientGeometry.ParameterLaurentImages

namespace Litt3.QuotientGeometry

attribute [local instance] FractionRing.liftAlgebra FractionRing.isScalarTower_liftAlgebra

/-- The genuine original trace-defined different derives the ENTIRE
original automorphism group and ALL-integral lower ramification filtration.
No normalized model, weak root, root order, group action or filtration
conclusion is an assumption. -/
theorem weak_different_parameter_full_ramification
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [CharP k p] [Fact p.Prime]
    (hp : 1 < p) (hh : 0 < h) (hdiv : h ∣ p - 1) (hchar : (h : k) ≠ 0)
    (b c : PowerSeries k) (hb : b = PowerSeries.X ^ (p * h) * c)
    (hc : PowerSeries.constantCoeff c ≠ 0) (hb0 : PowerSeries.constantCoeff b = 0) :
    letI : IsDomain (CompletedPowerSeriesBase k) := completed_power_series_base_isDomain
    letI : Algebra (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding b hb0).toAlgebra
    letI : SMul (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding b hb0).toAlgebra.toSMul
    letI : Module (CompletedPowerSeriesBase k) (PowerSeries k) := Algebra.toModule
    letI : NoZeroSMulDivisors (CompletedPowerSeriesBase k) (PowerSeries k) :=
      NoZeroSMulDivisors.iff_algebraMap_injective.mpr
        (lifted_finite_parameter_embedding_injective (p * h) (Nat.mul_pos (by omega) hh) b c hb hc hb0)
    letI : IsIntegrallyClosed (CompletedPowerSeriesBase k) :=
      completed_power_series_base_integrally_closed
    letI : Algebra (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) :=
      (liftedCompletedFractionCoefficientEmbedding b hb0).toAlgebra
    letI : SMul (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) :=
      (liftedCompletedFractionCoefficientEmbedding b hb0).toAlgebra.toSMul
    letI : Module (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) := Algebra.toModule
    letI : FaithfulSMul (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) :=
      (faithfulSMul_iff_algebraMap_injective _ _).mpr
        (lifted_finite_parameter_fraction_embedding_injective (p * h) (Nat.mul_pos (by omega) hh) b c hb hc hb0)
    letI : Algebra (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) :=
      FractionRing.liftAlgebra _ _
    letI : SMul (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) :=
      (FractionRing.liftAlgebra _ _).toSMul
    letI : Module (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) :=
      Algebra.toModule
    Algebra.IsSeparable (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) →
      differentIdeal (CompletedPowerSeriesBase k) (PowerSeries k) =
        Ideal.span {(PowerSeries.X : PowerSeries k) ^ (p * h + p - 2)} →
      let hi := finite_parameter_substitution_injective (p * h)
        (Nat.mul_pos (by omega) hh) b c hb hc;
      let Ψ := parameterLaurentMap b hb0 hi;
      letI := Ψ.toAlgebra;
      letI : SMul (LaurentSeries k) (LaurentSeries k) := Ψ.toAlgebra.toSMul;
      letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule;
      ∃ (α γ : k), α ≠ 0 ∧ γ ≠ 0 ∧
        Nonempty (WeakAffineSemidirect p h hdiv α γ ≃* fixedEmbeddingAutomorphisms Ψ) ∧
        ∃ A : fixedEmbeddingAutomorphisms Ψ →* (PowerSeries k ≃ₐ[k] PowerSeries k),
          (∀ (σ : fixedEmbeddingAutomorphisms Ψ) (f : PowerSeries k),
            σ.val (f : LaurentSeries k) = (A σ f : PowerSeries k)) ∧
          (completedLowerRamificationGroup k 0).comap A = ⊤ ∧
          IsCyclic ((completedLowerRamificationGroup k 1).comap A) ∧
          Nat.card ((completedLowerRamificationGroup k 1).comap A) = p ∧
          (∀ n : ℕ, 2 ≤ n → (completedLowerRamificationGroup k n).comap A = ⊥) ∧
          (∀ (σ : fixedEmbeddingAutomorphisms Ψ) (f : LaurentSeries k),
            (σ.val f).order = f.order) := by
  let A := CompletedPowerSeriesBase k
  let B := PowerSeries k
  letI : IsDomain A := completed_power_series_base_isDomain
  let φ := liftedCompletedEmbedding b hb0
  letI : Algebra A B := φ.toAlgebra
  letI : SMul A B := φ.toAlgebra.toSMul
  letI : Module A B := Algebra.toModule
  letI : NoZeroSMulDivisors A B := NoZeroSMulDivisors.iff_algebraMap_injective.mpr
    (lifted_finite_parameter_embedding_injective (p * h) (Nat.mul_pos (by omega) hh) b c hb hc hb0)
  letI : IsIntegrallyClosed A := completed_power_series_base_integrally_closed
  letI : Algebra A (FractionRing B) :=
    (liftedCompletedFractionCoefficientEmbedding b hb0).toAlgebra
  letI : SMul A (FractionRing B) :=
    (liftedCompletedFractionCoefficientEmbedding b hb0).toAlgebra.toSMul
  letI : Module A (FractionRing B) := Algebra.toModule
  letI : FaithfulSMul A (FractionRing B) :=
    (faithfulSMul_iff_algebraMap_injective _ _).mpr
      (lifted_finite_parameter_fraction_embedding_injective (p * h) (Nat.mul_pos (by omega) hh) b c hb hc hb0)
  letI : Algebra (FractionRing A) (FractionRing B) := FractionRing.liftAlgebra _ _
  letI : SMul (FractionRing A) (FractionRing B) := (FractionRing.liftAlgebra _ _).toSMul
  letI : Module (FractionRing A) (FractionRing B) := Algebra.toModule
  intro hsep hdiff
  obtain ⟨ψ, hroot, horder, hderiv, _⟩ :=
    weak_original_root_normal_form_from_different p h hp hh hchar b c hb hc hb0 hsep hdiff
  let hi := finite_parameter_substitution_injective (p * h) (Nat.mul_pos (by omega) hh) b c hb hc
  let Ψ := parameterLaurentMap b hb0 hi
  let φ : PowerSeries k →ₐ[k] PowerSeries k :=
    PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb0)
  have hΨ : ∀ f : PowerSeries k, Ψ (f : LaurentSeries k) = (φ f : PowerSeries k) := by
    intro f
    rw [parameter_laurent_map_power_series]
    exact congrArg (fun g : PowerSeries k => (g : LaurentSeries k))
      (congr_fun (PowerSeries.coe_substAlgHom
        (PowerSeries.HasSubst.of_constantCoeff_zero' hb0)) f).symm
  have hβ : ψ ^ h = Ψ (HahnSeries.single (-1) 1) := by
    rw [parameter_laurent_map_pole]
    simpa using hroot
  exact weak_tame_original_completed_ramification p h hh hdiv φ Ψ hΨ ψ hβ horder hderiv

end Litt3.QuotientGeometry
