import Solutions.Deformations.RepresentationNormMaps
import Mathlib.RepresentationTheory.Homological.GroupCohomology.Functoriality

namespace Litt3.Deformations

open CategoryTheory

universe u

variable {k G V W : Type u} [CommRing k] [Group G]
    [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]
    (ρ : Representation k G V) (σ : Representation k G W)
    (e : V ≃ₗ[k] W) (equivariant : ∀ g v, e (ρ g v) = σ g (e v))

/-- A genuine equivariant coefficient equivalence is an actual
isomorphism in the category of representations. -/
def representationIsoOfEquivariant : Rep.of ρ ≅ Rep.of σ where
  hom := {
    hom := ModuleCat.ofHom e.toLinearMap
    comm g := by
      apply ModuleCat.hom_ext
      apply LinearMap.ext
      intro v
      exact equivariant g v }
  inv := {
    hom := ModuleCat.ofHom e.symm.toLinearMap
    comm g := by
      apply ModuleCat.hom_ext
      apply LinearMap.ext
      intro w
      apply e.injective
      change e (e.symm (σ g w)) = e (ρ g (e.symm w))
      rw [e.apply_symm_apply, equivariant, e.apply_symm_apply] }
  hom_inv_id := by ext v; exact e.symm_apply_apply v
  inv_hom_id := by ext w; exact e.apply_symm_apply w

/-- Actual representation equivalences transport the full genuine
group cohomology in every degree through its actual functor. -/
noncomputable def representationCohomologyEquiv (n : ℕ) :
    groupCohomology (Rep.of ρ) n ≃ₗ[k] groupCohomology (Rep.of σ) n :=
  ((groupCohomology.functor k G n).mapIso
    (representationIsoOfEquivariant ρ σ e equivariant)).toLinearEquiv

/-- The same actual isomorphism transports the full actual invariant
subspaces, independently of finite dimension and group order. -/
noncomputable def representationInvariantEquiv : ρ.invariants ≃ₗ[k] σ.invariants :=
  ((Rep.invariantsFunctor k G).mapIso
    (representationIsoOfEquivariant ρ σ e equivariant)).toLinearEquiv

variable [Fintype G]

/-- Actual equivariant equivalences identify the whole actual norm
images, not only their dimensions. -/
def representationNormRangeEquiv : LinearMap.range ρ.norm ≃ₗ[k] LinearMap.range σ.norm where
  toFun v := ⟨e v.1, by
    obtain ⟨x, hx⟩ := v.2
    exact ⟨e x, (equivariant_map_norm ρ σ e.toLinearMap equivariant x).symm.trans (congrArg e hx)⟩⟩
  invFun w := ⟨e.symm w.1, by
    obtain ⟨x, hx⟩ := w.2
    refine ⟨e.symm x, ?_⟩
    apply e.injective
    calc
      e (ρ.norm (e.symm x)) = σ.norm (e (e.symm x)) :=
        equivariant_map_norm ρ σ e.toLinearMap equivariant _
      _ = σ.norm x := congrArg σ.norm (e.apply_symm_apply x)
      _ = w.1 := hx
      _ = e (e.symm w.1) := (e.apply_symm_apply w.1).symm⟩
  left_inv v := Subtype.ext (e.symm_apply_apply v.1)
  right_inv w := Subtype.ext (e.apply_symm_apply w.1)
  map_add' v w := Subtype.ext (e.map_add v.1 w.1)
  map_smul' a v := Subtype.ext (e.map_smul a v.1)

end Litt3.Deformations
