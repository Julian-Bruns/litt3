import Theorems.QuotientGeometry.WeakValuativeDifferentProfile
import Solutions.QuotientGeometry.WeakDifferentGalois
import Solutions.QuotientGeometry.WeakDifferentRamification

namespace Litt3.QuotientGeometry

/-- Galoisness of the ENTIRE original extension follows from its actual
positive valuation and genuine separating trace-different profile. -/
theorem weak_valuative_different_extension_galois
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [CharP k p] [Fact p.Prime]
    (hp : 1 < p) (hh : 0 < h) (hdiv : h ∣ p - 1)
    (b : PowerSeries k) (hb : b.order = p * h)
    (hprofile : weakValuativeDifferentProfile p h hp hh b hb) :
    let hc := positive_parameter_canonical_factor (p * h) b hb;
    let hb0 := positive_parameter_constant_zero (p * h) (Nat.mul_pos (by omega) hh) b hb;
    let hi := finite_parameter_substitution_injective (p * h)
      (Nat.mul_pos (by omega) hh) b (PowerSeries.divXPowOrder b) hc.1 hc.2;
    let Ψ := parameterLaurentMap b hb0 hi;
    letI := Ψ.toAlgebra;
    letI : SMul (LaurentSeries k) (LaurentSeries k) := Ψ.toAlgebra.toSMul;
    letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule;
    IsGalois (LaurentSeries k) (LaurentSeries k) := by
  have hc := positive_parameter_canonical_factor (p * h) b hb
  exact weak_different_parameter_extension_galois p h hp hh hdiv
    (tame_degree_cast_ne_zero p h hh hdiv) b (PowerSeries.divXPowOrder b) hc.1 hc.2
    (positive_parameter_constant_zero (p * h) (Nat.mul_pos (by omega) hh) b hb)
    hprofile.1 hprofile.2

/-- The ENTIRE original automorphism group and full lower ramification
filtration are derived from the valuation/different profile. The
conditions quantify over ALL actual integral and Laurent series. -/
theorem weak_valuative_different_full_ramification
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [CharP k p] [Fact p.Prime]
    (hp : 1 < p) (hh : 0 < h) (hdiv : h ∣ p - 1)
    (b : PowerSeries k) (hb : b.order = p * h)
    (hprofile : weakValuativeDifferentProfile p h hp hh b hb) :
    let hc := positive_parameter_canonical_factor (p * h) b hb;
    let hb0 := positive_parameter_constant_zero (p * h) (Nat.mul_pos (by omega) hh) b hb;
    let hi := finite_parameter_substitution_injective (p * h)
      (Nat.mul_pos (by omega) hh) b (PowerSeries.divXPowOrder b) hc.1 hc.2;
    let Ψ := parameterLaurentMap b hb0 hi;
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
  have hc := positive_parameter_canonical_factor (p * h) b hb
  exact weak_different_parameter_full_ramification p h hp hh hdiv
    (tame_degree_cast_ne_zero p h hh hdiv) b (PowerSeries.divXPowOrder b) hc.1 hc.2
    (positive_parameter_constant_zero (p * h) (Nat.mul_pos (by omega) hh) b hb)
    hprofile.1 hprofile.2

end Litt3.QuotientGeometry
