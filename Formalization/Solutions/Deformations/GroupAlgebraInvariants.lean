import Theorems.Deformations.GroupAlgebraInvariants
import Solutions.Deformations.ActualPGroupInvariants

namespace Litt3.Deformations

open scoped MonoidAlgebra

variable {k G V : Type*} [CommRing k] [Group G] [AddCommGroup V] [Module k V]

/-- The whole invariant space is an actual group-algebra submodule:
every group-algebra scalar preserves it, not merely every group element. -/
def groupAlgebraInvariantSubmodule (ρ : Representation k G V) : Submodule k[G] ρ.asModule where
  carrier := {x | groupAlgebraInvariantPredicate ρ x}
  zero_mem' := by intro g; simp
  add_mem' := by
    intro x y hx hy g
    simp only [map_add]
    rw [hx g, hy g]
  smul_mem' := by
    intro r x hx
    change ∀ g, ρ g (ρ.asAlgebraHom r (ρ.asModuleEquiv x)) =
      ρ.asAlgebraHom r (ρ.asModuleEquiv x)
    apply MonoidAlgebra.induction_on r
    · intro h
      simp only [MonoidAlgebra.of_apply, Representation.asAlgebraHom_single_one]
      rw [hx h]
      exact hx
    · intro a b ha hb
      simp only [map_add, LinearMap.add_apply]
      intro g
      rw [ha g, hb g]
    · intro c a ha
      simp only [map_smul, LinearMap.smul_apply]
      intro g
      rw [ha g]

variable {p : ℕ} [Fact p.Prime] [CharP k p] [Finite G]

/-- Every actual simple group-algebra representation of a finite
p-group is trivial on all actual group elements. The invariant
submodule and its nonzero vector are constructed. -/
theorem simple_p_group_representation_trivial (group : IsPGroup p G)
    (ρ : Representation k G V) [IsSimpleModule k[G] ρ.asModule] :
    Specifications.SimplePGroupRepresentationTrivial ρ := by
  classical
  letI : Nontrivial ρ.asModule := IsSimpleModule.nontrivial k[G] ρ.asModule
  obtain ⟨x, hx⟩ := exists_ne (0 : ρ.asModule)
  have hnonzero : ρ.asModuleEquiv x ≠ 0 := by
    intro h
    apply hx
    apply ρ.asModuleEquiv.injective
    simpa using h
  obtain ⟨w, hw, hfix⟩ := nonzero_characteristic_p_group_invariants group ρ
    ⟨ρ.asModuleEquiv x, hnonzero⟩
  let S := groupAlgebraInvariantSubmodule ρ
  have hwS : ρ.asModuleEquiv.symm w ∈ S := by
    change ∀ g, ρ g (ρ.asModuleEquiv (ρ.asModuleEquiv.symm w)) =
      ρ.asModuleEquiv (ρ.asModuleEquiv.symm w)
    simpa only [LinearEquiv.apply_symm_apply] using hfix
  have hne : S ≠ ⊥ := by
    intro hbot
    rw [hbot] at hwS
    have hz : ρ.asModuleEquiv.symm w = 0 := by simpa using hwS
    apply hw
    have h := congrArg ρ.asModuleEquiv hz
    simpa using h
  have htop : S = ⊤ := (eq_bot_or_eq_top S).resolve_left hne
  intro g v
  have hvS : ρ.asModuleEquiv.symm v ∈ S := by rw [htop]; exact Submodule.mem_top
  have hv := hvS g
  simpa only [LinearEquiv.apply_symm_apply] using hv

end Litt3.Deformations
