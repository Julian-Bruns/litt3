import Solutions.QuotientGeometry.UnramifiedCompletedMaps
import Solutions.QuotientGeometry.WeakTameClassification

namespace Litt3.QuotientGeometry

/-- TWO actual completed maps enter the SAME completed source. Their
unramified maximal-ideal conditions and exact common-base square derive
an identification of the endpoint fields over the entire fixed base. -/
theorem same_source_unramified_completed_fields_equivalent
    {k : Type*} [Field k]
    (φ₁ φ₂ : PowerSeries k →ₐ[k] PowerSeries k)
    (Φ₁ Φ₂ Ψ₁ Ψ₂ : LaurentSeries k →+* LaurentSeries k)
    (hΦ₁ : ∀ f : PowerSeries k, Φ₁ (f : LaurentSeries k) = (φ₁ f : PowerSeries k))
    (hΦ₂ : ∀ f : PowerSeries k, Φ₂ (f : LaurentSeries k) = (φ₂ f : PowerSeries k))
    (hmax₁ : (IsLocalRing.maximalIdeal (PowerSeries k)).map φ₁.toRingHom =
      IsLocalRing.maximalIdeal (PowerSeries k))
    (hmax₂ : (IsLocalRing.maximalIdeal (PowerSeries k)).map φ₂.toRingHom =
      IsLocalRing.maximalIdeal (PowerSeries k))
    (hbase : Φ₁.comp Ψ₁ = Φ₂.comp Ψ₂) : ParameterFieldsEquivalent Ψ₁ Ψ₂ := by
  obtain ⟨_, E₁, _, hE₁, _⟩ := unramified_completed_map_equivalences φ₁ Φ₁ hΦ₁ hmax₁
  obtain ⟨_, E₂, _, hE₂, _⟩ := unramified_completed_map_equivalences φ₂ Φ₂ hΦ₂ hmax₂
  refine ⟨E₁.toRingEquiv.trans E₂.toRingEquiv.symm, ?_⟩
  intro r
  apply E₂.injective
  change E₂ (E₂.symm (E₁ (Ψ₁ r))) = E₂ (Ψ₂ r)
  rw [E₂.apply_symm_apply]
  have h := RingHom.congr_fun hbase r
  change E₁.toRingHom (Ψ₁ r) = E₂.toRingHom (Ψ₂ r)
  rw [hE₁, hE₂]
  exact h

/-- The common-source comparison forces equality of the actual weak
coefficient scalars. Equal numerical degrees or differents alone are
not the square hypothesis: both full source maps remain present. -/
theorem same_source_unramified_weak_scalars_equal
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1)
    (φ₁ φ₂ χ₁ χ₂ : PowerSeries k →ₐ[k] PowerSeries k)
    (Φ₁ Φ₂ Ψ₁ Ψ₂ : LaurentSeries k →+* LaurentSeries k)
    (hΦ₁ : ∀ f : PowerSeries k, Φ₁ (f : LaurentSeries k) = (φ₁ f : PowerSeries k))
    (hΦ₂ : ∀ f : PowerSeries k, Φ₂ (f : LaurentSeries k) = (φ₂ f : PowerSeries k))
    (hΨ₁ : ∀ f : PowerSeries k, Ψ₁ (f : LaurentSeries k) = (χ₁ f : PowerSeries k))
    (hΨ₂ : ∀ f : PowerSeries k, Ψ₂ (f : LaurentSeries k) = (χ₂ f : PowerSeries k))
    (hmax₁ : (IsLocalRing.maximalIdeal (PowerSeries k)).map φ₁.toRingHom =
      IsLocalRing.maximalIdeal (PowerSeries k))
    (hmax₂ : (IsLocalRing.maximalIdeal (PowerSeries k)).map φ₂.toRingHom =
      IsLocalRing.maximalIdeal (PowerSeries k))
    (hbase : Φ₁.comp Ψ₁ = Φ₂.comp Ψ₂)
    (ψ₁ ψ₂ : LaurentSeries k)
    (hroot₁ : ψ₁ ^ h = Ψ₁ (HahnSeries.single (-1) 1))
    (hroot₂ : ψ₂ ^ h = Ψ₂ (HahnSeries.single (-1) 1))
    (horder₁ : ψ₁.order = -(p : ℤ)) (horder₂ : ψ₂.order = -(p : ℤ))
    (hderiv₁ : (LaurentSeries.derivative k ψ₁).order = -2)
    (hderiv₂ : (LaurentSeries.derivative k ψ₂).order = -2) :
    weakPoleScalar p ψ₁ = weakPoleScalar p ψ₂ :=
  (weak_tame_completed_fields_equiv_iff p h hh hdiv χ₁ χ₂ Ψ₁ Ψ₂
    hΨ₁ hΨ₂ ψ₁ ψ₂ hroot₁ hroot₂ horder₁ horder₂ hderiv₁ hderiv₂).mp
    (same_source_unramified_completed_fields_equivalent φ₁ φ₂ Φ₁ Φ₂ Ψ₁ Ψ₂
      hΦ₁ hΦ₂ hmax₁ hmax₂ hbase)

end Litt3.QuotientGeometry
