import Theorems.Deformations.PGroupEssentialSocle
import Solutions.Deformations.ActualPGroupInvariants

namespace Litt3.Deformations

variable {p : ℕ} [Fact p.Prime] {k G V W : Type*} [CommRing k] [CharP k p]
    [Group G] [Finite G] [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

/-- An actual equivariant map of finite-p-group representations is
injective as soon as its restriction to the full invariant space is.
Neither module needs to be finite-dimensional. -/
theorem p_group_equivariant_injective_of_invariant_injective (group : IsPGroup p G)
    (ρ : Representation k G V) (σ : Representation k G W) (f : V →ₗ[k] W) :
    Specifications.PGroupEquivariantInjectivity ρ σ f := by
  intro equivariant invariant_injective
  apply LinearMap.ker_eq_bot.mp
  apply le_antisymm ?_ bot_le
  intro v hv
  change v = 0
  by_contra vn
  let K := LinearMap.ker f
  have stable : ∀ g, K ≤ K.comap (ρ g) := by
    intro g x hx
    change f (ρ g x) = 0
    rw [equivariant, show f x = 0 from hx, map_zero]
  let τ := ρ.subrepresentation K stable
  obtain ⟨w, wn, fixed⟩ := nonzero_characteristic_p_group_invariants group τ
    ⟨⟨v, hv⟩, by intro h; exact vn (congrArg Subtype.val h)⟩
  have fixedV : ∀ g, ρ g w.1 = w.1 := fun g => congrArg Subtype.val (fixed g)
  have wz := invariant_injective w.1 fixedV w.2
  exact wn (Subtype.ext wz)

end Litt3.Deformations
