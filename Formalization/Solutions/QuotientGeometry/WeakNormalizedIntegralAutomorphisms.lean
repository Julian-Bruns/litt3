import Solutions.QuotientGeometry.WeakNormalizedAffineBijection

namespace Litt3.QuotientGeometry

/-- Every actual fixed-base automorphism preserves the entire completed
valuation ring. This is deduced from the exhausted affine family, rather
than imposed as an extra continuity or integral-preservation hypothesis. -/
theorem weak_normalized_automorphism_power_series
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0)
    (σ : WeakNormalizedAutomorphisms p h hh α γ hα) :
    ∃ e : PowerSeries k ≃ₐ[k] PowerSeries k,
      ∀ f : PowerSeries k, σ.val (f : LaurentSeries k) = (e f : PowerSeries k) := by
  obtain ⟨z, hz⟩ := (weak_normalized_affine_automorphism_bijective
    p h hh hdiv α γ hα hγ).2 σ
  let g := weakTamePolynomial p h α γ
  have hg : 0 < g.natDegree := by
    rw [weak_tame_polynomial_degree p h (Fact.out : p.Prime).one_lt α γ hα]
    exact Nat.mul_pos (Fact.out : p.Prime).pos hh
  have hζ : (z.1.val : k) ^ h = 1 := (mem_rootsOfUnity' h z.1.val).mp z.1.property
  have hfix := tame_scalar_frobenius_fixed p h (Fact.out : p.Prime).one_lt hdiv
    (z.1.val : k) hζ
  obtain ⟨e, E, hE, hbase, hpole⟩ :=
    constant_polynomial_affine_parameter_automorphism_with_power_series g hg
      (z.1.val : k) z.2.val z.1.val.ne_zero
      (weak_tame_polynomial_affine_symmetry p h α γ (z.1.val : k) z.2.val
        hfix hζ z.2.property)
  let τ : WeakNormalizedAutomorphisms p h hh α γ hα := ⟨E.toRingEquiv, hbase⟩
  have hτσ : τ = σ := by
    apply weak_normalized_automorphism_pole_injective p h hh hdiv α γ hα hγ
    change E (HahnSeries.single (-1) 1) = σ.val (HahnSeries.single (-1) 1)
    rw [← hz, weak_normalized_affine_automorphism_pole]
    exact hpole
  refine ⟨e, ?_⟩
  intro f
  rw [← hτσ]
  exact hE f

end Litt3.QuotientGeometry
