import Theorems.Deformations.EquivariantCocycleDescent
import Solutions.Deformations.ActualPGroupInvariants

namespace Litt3.Deformations

variable {p : ℕ} [Fact p.Prime] {k G V W : Type*} [CommRing k] [CharP k p]
    [Group G] [Finite G] [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

/-- A full actual equivariant embedding that covers every target
invariant is onto if every source cocycle has a primitive. Its actual
quotient, actual invariant lifts and actual correcting cocycles are
constructed; neither module needs finite dimension. -/
theorem p_group_equivariant_surjective_of_cocycle_primitives (group : IsPGroup p G)
    (ρ : Representation k G V) (σ : Representation k G W) (f : V →ₗ[k] W) :
    Specifications.EquivariantSurjectivityFromPrimitives ρ σ f := by
  intro equivariant injective invariants_covered primitives
  let S := LinearMap.range f
  have stable : ∀ g, S ≤ S.comap (σ g) := by
    intro g w hw
    obtain ⟨v, rfl⟩ := hw
    exact ⟨ρ g v, equivariant g v⟩
  let τ := σ.quotient S stable
  have equivariantQ : ∀ g w, τ g (S.mkQ w) = S.mkQ (σ g w) := by intro g w; rfl
  have fixed_zero : ∀ q : W ⧸ S, (∀ g, τ g q = q) → q = 0 := by
    intro q fixed
    obtain ⟨w, rfl⟩ := S.mkQ_surjective q
    have difference : ∀ g, σ g w - w ∈ S := by
      intro g
      apply (Submodule.Quotient.mk_eq_zero S).mp
      change S.mkQ (σ g w - w) = 0
      rw [map_sub, ← equivariantQ, fixed, sub_self]
    choose c hc using difference
    have cocycle : ∀ g h, c (g * h) = ρ g (c h) + c g := by
      intro g h
      apply injective
      rw [hc, map_add, equivariant, hc, hc, map_mul, Module.End.mul_apply, map_sub]
      abel
    obtain ⟨v, hv⟩ := primitives c cocycle
    have corrected_fixed : ∀ g, σ g (w - f v) = w - f v := by
      intro g
      have h := congrArg f (hv g)
      rw [map_sub, hc] at h
      rw [map_sub, ← equivariant]
      exact sub_eq_sub_iff_add_eq_add.mpr
        ((sub_eq_sub_iff_add_eq_add.mp h).symm.trans (add_comm _ _))
    have corrected_mem : w - f v ∈ S := invariants_covered _ corrected_fixed
    have wmem : w ∈ S := by
      have h := S.add_mem corrected_mem (show f v ∈ S from ⟨v, rfl⟩)
      simpa only [sub_add_cancel] using h
    exact (Submodule.Quotient.mk_eq_zero S).mpr wmem
  have all_zero : ∀ q : W ⧸ S, q = 0 := by
    intro q
    by_contra nonzero
    obtain ⟨u, un, fixed⟩ := nonzero_characteristic_p_group_invariants group τ ⟨q, nonzero⟩
    exact un (fixed_zero u fixed)
  intro w
  have wmem : w ∈ S := (Submodule.Quotient.mk_eq_zero S).mp (all_zero (S.mkQ w))
  exact wmem

end Litt3.Deformations
