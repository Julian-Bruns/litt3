import Solutions.QuotientGeometry.FixedEmbeddingConjugation

namespace Litt3.QuotientGeometry

theorem compatible_completed_inverse
    {k : Type*} [Field k] (e : PowerSeries k ≃ₐ[k] PowerSeries k)
    (E : LaurentSeries k ≃+* LaurentSeries k)
    (hE : ∀ f : PowerSeries k, E (f : LaurentSeries k) = (e f : PowerSeries k))
    (f : PowerSeries k) : E.symm (f : LaurentSeries k) = (e.symm f : PowerSeries k) := by
  apply E.injective
  rw [E.apply_symm_apply, hE, e.apply_symm_apply]

noncomputable def transportedCompletedAction
    {k : Type*} [Field k] (Φ Ψ : LaurentSeries k →+* LaurentSeries k)
    (e : PowerSeries k ≃ₐ[k] PowerSeries k) (E : LaurentSeries k ≃+* LaurentSeries k)
    (hbase : ∀ r : LaurentSeries k, E (Φ r) = Ψ r)
    (A : fixedEmbeddingAutomorphisms Φ →* (PowerSeries k ≃ₐ[k] PowerSeries k)) :
    fixedEmbeddingAutomorphisms Ψ →* (PowerSeries k ≃ₐ[k] PowerSeries k) :=
  (completedPowerSeriesConjugation e).toMonoidHom.comp
    (A.comp (fixedEmbeddingConjugation Φ Ψ E hbase).symm.toMonoidHom)

/-- The transported action is the literal action on the original
entire integral ring, rather than an abstract chosen group action. -/
theorem transported_completed_action_compatible
    {k : Type*} [Field k] (Φ Ψ : LaurentSeries k →+* LaurentSeries k)
    (e : PowerSeries k ≃ₐ[k] PowerSeries k) (E : LaurentSeries k ≃+* LaurentSeries k)
    (hE : ∀ f : PowerSeries k, E (f : LaurentSeries k) = (e f : PowerSeries k))
    (hbase : ∀ r : LaurentSeries k, E (Φ r) = Ψ r)
    (A : fixedEmbeddingAutomorphisms Φ →* (PowerSeries k ≃ₐ[k] PowerSeries k))
    (hA : ∀ (σ : fixedEmbeddingAutomorphisms Φ) (f : PowerSeries k),
      σ.val (f : LaurentSeries k) = (A σ f : PowerSeries k))
    (τ : fixedEmbeddingAutomorphisms Ψ) (f : PowerSeries k) :
    τ.val (f : LaurentSeries k) =
      (transportedCompletedAction Φ Ψ e E hbase A τ f : PowerSeries k) := by
  let σ := (fixedEmbeddingConjugation Φ Ψ E hbase).symm τ
  change τ.val (f : LaurentSeries k) = (e (A σ (e.symm f)) : PowerSeries k)
  rw [← hE, ← hA]
  change τ.val (f : LaurentSeries k) = E (E.symm (τ.val (E (e.symm f : PowerSeries k))))
  rw [hE, e.apply_symm_apply, E.apply_symm_apply]

theorem transported_completed_lower_group_conjugation_iff
    {k : Type*} [Field k] (Φ Ψ : LaurentSeries k →+* LaurentSeries k)
    (e : PowerSeries k ≃ₐ[k] PowerSeries k) (E : LaurentSeries k ≃+* LaurentSeries k)
    (hbase : ∀ r : LaurentSeries k, E (Φ r) = Ψ r)
    (A : fixedEmbeddingAutomorphisms Φ →* (PowerSeries k ≃ₐ[k] PowerSeries k))
    (σ : fixedEmbeddingAutomorphisms Φ) (n : ℕ) :
    fixedEmbeddingConjugation Φ Ψ E hbase σ ∈
      (completedLowerRamificationGroup k n).comap (transportedCompletedAction Φ Ψ e E hbase A) ↔
      σ ∈ (completedLowerRamificationGroup k n).comap A := by
  change completedPowerSeriesConjugation e
    (A ((fixedEmbeddingConjugation Φ Ψ E hbase).symm
      (fixedEmbeddingConjugation Φ Ψ E hbase σ))) ∈ completedLowerRamificationGroup k n ↔ _
  rw [MulEquiv.symm_apply_apply]
  exact completed_lower_ramification_conjugation_iff e (A σ) n

noncomputable def transportedCompletedLowerGroupEquiv
    {k : Type*} [Field k] (Φ Ψ : LaurentSeries k →+* LaurentSeries k)
    (e : PowerSeries k ≃ₐ[k] PowerSeries k) (E : LaurentSeries k ≃+* LaurentSeries k)
    (hbase : ∀ r : LaurentSeries k, E (Φ r) = Ψ r)
    (A : fixedEmbeddingAutomorphisms Φ →* (PowerSeries k ≃ₐ[k] PowerSeries k)) (n : ℕ) :
    (completedLowerRamificationGroup k n).comap A ≃*
      (completedLowerRamificationGroup k n).comap (transportedCompletedAction Φ Ψ e E hbase A) where
  toFun σ := ⟨fixedEmbeddingConjugation Φ Ψ E hbase σ.val,
    (transported_completed_lower_group_conjugation_iff Φ Ψ e E hbase A σ.val n).mpr σ.property⟩
  invFun τ := ⟨(fixedEmbeddingConjugation Φ Ψ E hbase).symm τ.val, by
    apply (transported_completed_lower_group_conjugation_iff Φ Ψ e E hbase A _ n).mp
    simpa using τ.property⟩
  left_inv σ := by apply Subtype.ext; simp
  right_inv τ := by apply Subtype.ext; simp
  map_mul' σ τ := by apply Subtype.ext; exact map_mul (fixedEmbeddingConjugation Φ Ψ E hbase) _ _

theorem transported_completed_lower_top
    {k : Type*} [Field k] (Φ Ψ : LaurentSeries k →+* LaurentSeries k)
    (e : PowerSeries k ≃ₐ[k] PowerSeries k) (E : LaurentSeries k ≃+* LaurentSeries k)
    (hbase : ∀ r : LaurentSeries k, E (Φ r) = Ψ r)
    (A : fixedEmbeddingAutomorphisms Φ →* (PowerSeries k ≃ₐ[k] PowerSeries k)) (n : ℕ)
    (htop : (completedLowerRamificationGroup k n).comap A = ⊤) :
    (completedLowerRamificationGroup k n).comap (transportedCompletedAction Φ Ψ e E hbase A) = ⊤ := by
  apply le_antisymm le_top
  intro τ _
  obtain ⟨σ, rfl⟩ := (fixedEmbeddingConjugation Φ Ψ E hbase).surjective τ
  apply (transported_completed_lower_group_conjugation_iff Φ Ψ e E hbase A σ n).mpr
  rw [htop]
  trivial

theorem transported_completed_lower_bot
    {k : Type*} [Field k] (Φ Ψ : LaurentSeries k →+* LaurentSeries k)
    (e : PowerSeries k ≃ₐ[k] PowerSeries k) (E : LaurentSeries k ≃+* LaurentSeries k)
    (hbase : ∀ r : LaurentSeries k, E (Φ r) = Ψ r)
    (A : fixedEmbeddingAutomorphisms Φ →* (PowerSeries k ≃ₐ[k] PowerSeries k)) (n : ℕ)
    (hbot : (completedLowerRamificationGroup k n).comap A = ⊥) :
    (completedLowerRamificationGroup k n).comap (transportedCompletedAction Φ Ψ e E hbase A) = ⊥ := by
  apply le_antisymm _ bot_le
  intro τ hτ
  obtain ⟨σ, rfl⟩ := (fixedEmbeddingConjugation Φ Ψ E hbase).surjective τ
  have hσ := (transported_completed_lower_group_conjugation_iff Φ Ψ e E hbase A σ n).mp hτ
  rw [hbot, Subgroup.mem_bot] at hσ
  rw [Subgroup.mem_bot, hσ, map_one]

end Litt3.QuotientGeometry
