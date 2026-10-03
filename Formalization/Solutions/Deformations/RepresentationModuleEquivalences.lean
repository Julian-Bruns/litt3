import Definitions.Deformations.RegularFunctionRepresentation

namespace Litt3.Deformations

open scoped MonoidAlgebra

variable {k G V W : Type*} [CommRing k] [Group G]
    [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

/-- The full actual group-algebra module equivalence gives a coefficient
linear equivalence of its original representation spaces. -/
noncomputable def representationEquivOfModuleEquiv
    (ρ : Representation k G V) (σ : Representation k G W)
    (e : ρ.asModule ≃ₗ[k[G]] σ.asModule) : V ≃ₗ[k] W :=
  ρ.asModuleEquiv.symm.trans ((e.restrictScalars k).trans σ.asModuleEquiv)

theorem representation_equiv_of_module_equiv_commutes
    (ρ : Representation k G V) (σ : Representation k G W)
    (e : ρ.asModule ≃ₗ[k[G]] σ.asModule) (g : G) (v : V) :
    representationEquivOfModuleEquiv ρ σ e (ρ g v) =
      σ g (representationEquivOfModuleEquiv ρ σ e v) := by
  change σ.asModuleEquiv (e (ρ.asModuleEquiv.symm (ρ g v))) =
    σ g (σ.asModuleEquiv (e (ρ.asModuleEquiv.symm v)))
  rw [Representation.asModuleEquiv_symm_map_rho, e.map_smul,
    Representation.asModuleEquiv_map_smul, Representation.asAlgebraHom_of]

theorem equivariant_linear_equiv_algebra_action
    (ρ : Representation k G V) (σ : Representation k G W) (e : V ≃ₗ[k] W)
    (equivariant : ∀ g v, e (ρ g v) = σ g (e v)) (r : k[G]) (v : V) :
    e (ρ.asAlgebraHom r v) = σ.asAlgebraHom r (e v) := by
  induction r using MonoidAlgebra.induction_on with
  | hM g => simpa only [Representation.asAlgebraHom_of] using equivariant g v
  | hadd r s hr hs =>
    simpa only [map_add, LinearMap.add_apply] using congrArg₂ (· + ·) hr hs
  | hsmul c r hr =>
    simpa only [map_smul, LinearMap.smul_apply] using congrArg (c • ·) hr

/-- A genuine equivariant equivalence preserves the entire actual
group-algebra module structure, not merely the selected generator actions. -/
noncomputable def representationModuleEquivOfEquivariant
    (ρ : Representation k G V) (σ : Representation k G W) (e : V ≃ₗ[k] W)
    (equivariant : ∀ g v, e (ρ g v) = σ g (e v)) :
    ρ.asModule ≃ₗ[k[G]] σ.asModule where
  toFun v := σ.asModuleEquiv.symm (e (ρ.asModuleEquiv v))
  invFun w := ρ.asModuleEquiv.symm (e.symm (σ.asModuleEquiv w))
  left_inv _ := by simp
  right_inv _ := by simp
  map_add' _ _ := by simp
  map_smul' r v := by
    apply σ.asModuleEquiv.injective
    simpa using equivariant_linear_equiv_algebra_action ρ σ e equivariant r (ρ.asModuleEquiv v)

end Litt3.Deformations
