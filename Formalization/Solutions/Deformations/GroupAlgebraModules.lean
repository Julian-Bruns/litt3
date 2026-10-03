import Theorems.Deformations.GroupAlgebraModules
import Solutions.Deformations.GroupAlgebraInvariants

namespace Litt3.Deformations

open scoped MonoidAlgebra

variable {k G : Type*} [CommRing k] [Group G]

/-- The actual group-algebra module reconstructed from its
representation is equivalent to the entire original module. -/
noncomputable def groupAlgebraOfModuleEquiv (M : Type*) [AddCommGroup M] [Module k[G] M] :
    (Representation.ofModule (k := k) (G := G) M).asModule ≃ₗ[k[G]] M where
  toFun x := RestrictScalars.addEquiv k k[G] M
    ((Representation.ofModule (k := k) (G := G) M).asModuleEquiv x)
  invFun x := (Representation.ofModule (k := k) (G := G) M).asModuleEquiv.symm
    ((RestrictScalars.addEquiv k k[G] M).symm x)
  left_inv x := by simp
  right_inv x := by simp
  map_add' x y := by simp
  map_smul' r x := Representation.smul_ofModule_asModule M r x

variable {p : ℕ} [Fact p.Prime] [CharP k p] [Finite G]
variable {M : Type*} [AddCommGroup M] [Module k[G] M] [IsSimpleModule k[G] M]

/-- Every actual simple module over the actual finite p-group
algebra has trivial action of all actual group elements. -/
theorem simple_p_group_module_trivial (group : IsPGroup p G) :
    Specifications.SimplePGroupModuleTrivial (k := k) (G := G) (M := M) := by
  let ρ := Representation.ofModule (k := k) (G := G) M
  letI : IsSimpleModule k[G] ρ.asModule :=
    IsSimpleModule.congr (groupAlgebraOfModuleEquiv (k := k) (G := G) M)
  have htriv := simple_p_group_representation_trivial group ρ
  intro g m
  have h := htriv g ((RestrictScalars.addEquiv k k[G] M).symm m)
  change (Representation.ofModule (k := k) (G := G) M) g
      ((RestrictScalars.addEquiv k k[G] M).symm m) =
    (RestrictScalars.addEquiv k k[G] M).symm m at h
  rw [← Representation.asAlgebraHom_of,
    Representation.ofModule_asAlgebraHom_apply_apply] at h
  have h' := congrArg (RestrictScalars.addEquiv k k[G] M) h
  simpa only [AddEquiv.apply_symm_apply] using h'

end Litt3.Deformations
