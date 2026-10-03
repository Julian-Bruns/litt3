import Solutions.QuotientGeometry.WeakTameOriginalCoordinates
import Solutions.QuotientGeometry.WeakNormalizedWildInertia
import Solutions.QuotientGeometry.CompletedActionTransport

namespace Litt3.QuotientGeometry

/-- The entire actual original full-base-field group and its genuine
all-integral lower filtration, including every regular-tail coefficient,
are transported through proved compatible completed coordinates. -/
theorem weak_tame_original_completed_ramification
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1)
    (φ : PowerSeries k →ₐ[k] PowerSeries k) (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (ψ : LaurentSeries k) (hroot : ψ ^ h = Ψ (HahnSeries.single (-1) 1))
    (hψorder : ψ.order = -(p : ℤ)) (hψderiv : (LaurentSeries.derivative k ψ).order = -2) :
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
  obtain ⟨α, γ, hα, hγ, _, _, e, E, hE, hbase⟩ :=
    weak_tame_original_completed_coordinates p h hh φ Ψ hΨ ψ hroot hψorder hψderiv
  let Φ := weakNormalizedEmbedding p h hh α γ hα
  let C := fixedEmbeddingConjugation Φ Ψ E.toRingEquiv hbase
  let N := weakNormalizedIntegralAction p h hh hdiv α γ hα hγ
  let A := transportedCompletedAction Φ Ψ e E.toRingEquiv hbase N
  have hA : ∀ (σ : fixedEmbeddingAutomorphisms Ψ) (f : PowerSeries k),
      σ.val (f : LaurentSeries k) = (A σ f : PowerSeries k) :=
    transported_completed_action_compatible Φ Ψ e E.toRingEquiv hE hbase N
      (weak_normalized_integral_action_compatible p h hh hdiv α γ hα hγ)
  have hzero : (completedLowerRamificationGroup k 0).comap A = ⊤ :=
    transported_completed_lower_top Φ Ψ e E.toRingEquiv hbase N 0
      (weak_normalized_lower_ramification_zero p h hh hdiv α γ hα hγ)
  let Q := transportedCompletedLowerGroupEquiv Φ Ψ e E.toRingEquiv hbase N 1
  obtain ⟨hcyc, hcard⟩ := weak_normalized_wild_inertia_cyclic_and_card p h hh hdiv α γ hα hγ
  letI : IsCyclic ((completedLowerRamificationGroup k 1).comap N) := hcyc
  refine ⟨α, γ, hα, hγ, ⟨(weakNormalizedSemidirectEquiv p h hh hdiv α γ hα hγ).trans C⟩,
    A, hA, hzero, isCyclic_of_surjective Q Q.surjective,
    (Nat.card_congr Q.toEquiv).symm.trans hcard, ?_, ?_⟩
  · intro n hn
    exact transported_completed_lower_bot Φ Ψ e E.toRingEquiv hbase N n
      (weak_normalized_lower_ramification_ge_two p h hh hdiv α γ hα hγ n hn)
  · intro σ f
    exact compatible_laurent_equiv_order (A σ).toRingEquiv σ.val (hA σ) f

end Litt3.QuotientGeometry
