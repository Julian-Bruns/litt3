import Solutions.QuotientGeometry.FixedEmbeddingAutomorphisms
import Solutions.QuotientGeometry.CompletedLowerRamification

namespace Litt3.QuotientGeometry

/-- An actual full-base field identification transports the entire
automorphism group, retaining every element of the specified base map. -/
noncomputable def fixedEmbeddingConjugation
    {K L M : Type*} [Field K] [Field L] [Field M]
    (Φ : K →+* L) (Ψ : K →+* M) (E : L ≃+* M)
    (hE : ∀ r : K, E (Φ r) = Ψ r) :
    fixedEmbeddingAutomorphisms Φ ≃* fixedEmbeddingAutomorphisms Ψ where
  toFun σ := ⟨E.symm.trans (σ.val.trans E), by
    intro r
    change E (σ.val (E.symm (Ψ r))) = Ψ r
    rw [← hE, E.symm_apply_apply, σ.property, hE]⟩
  invFun τ := ⟨E.trans (τ.val.trans E.symm), by
    intro r
    change E.symm (τ.val (E (Φ r))) = Φ r
    rw [hE, τ.property, ← hE, E.symm_apply_apply]⟩
  left_inv σ := by
    apply Subtype.ext
    apply RingEquiv.ext
    intro x
    change E.symm (E (σ.val (E.symm (E x)))) = σ.val x
    simp
  right_inv τ := by
    apply Subtype.ext
    apply RingEquiv.ext
    intro x
    change E (E.symm (τ.val (E (E.symm x)))) = τ.val x
    simp
  map_mul' σ τ := by
    apply Subtype.ext
    apply RingEquiv.ext
    intro x
    change E (σ.val (τ.val (E.symm x))) =
      E (σ.val (E.symm (E (τ.val (E.symm x)))))
    simp

noncomputable def completedPowerSeriesConjugation
    {k : Type*} [Field k] (e : PowerSeries k ≃ₐ[k] PowerSeries k) :
    (PowerSeries k ≃ₐ[k] PowerSeries k) ≃* (PowerSeries k ≃ₐ[k] PowerSeries k) where
  toFun σ := e.symm.trans (σ.trans e)
  invFun τ := e.trans (τ.trans e.symm)
  left_inv σ := by ext f; simp
  right_inv τ := by ext f; simp
  map_mul' σ τ := by ext f; simp [AlgEquiv.mul_apply]

/-- Lower ramification groups are invariant under actual completed
coordinate changes, using their condition on every integral element. -/
theorem completed_lower_ramification_conjugation_iff
    {k : Type*} [Field k] (e σ : PowerSeries k ≃ₐ[k] PowerSeries k) (n : ℕ) :
    completedPowerSeriesConjugation e σ ∈ completedLowerRamificationGroup k n ↔
      σ ∈ completedLowerRamificationGroup k n := by
  have hord (f : PowerSeries k) :
      PowerSeries.order (completedPowerSeriesConjugation e σ f - f) =
        PowerSeries.order (σ (e.symm f) - e.symm f) := by
    change PowerSeries.order (e (σ (e.symm f)) - f) = _
    have heq : e (σ (e.symm f)) - f = e.toRingEquiv (σ (e.symm f) - e.symm f) := by
      simp
    rw [heq, power_series_ring_equiv_order]
  constructor
  · intro hσ f
    have hbound := hσ (e f)
    rw [hord, e.symm_apply_apply] at hbound
    exact hbound
  · intro hσ f
    rw [hord]
    exact hσ (e.symm f)

end Litt3.QuotientGeometry
