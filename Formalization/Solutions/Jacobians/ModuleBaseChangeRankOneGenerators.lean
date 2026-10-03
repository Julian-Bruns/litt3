import Solutions.Jacobians.ModuleBaseChangeRankOneIsomorphisms

open CategoryTheory
open scoped TensorProduct ChangeOfRings

namespace Litt3.Jacobians

universe u
variable {R S : Type u} [CommRing R] [CommRing S] (φ : R →+* S)
  (M : ModuleCat R) (e : M ≅ ModuleCat.of R R)

/-- An actual original rank-one frame gives the literal generator
decomposition of EVERY original module element. -/
theorem actualModuleRankOneFrame_generator (m : M) :
    m = e.hom m • (show M from e.inv (1 : R)) := by
  apply e.toLinearEquiv.injective
  change e.toLinearEquiv m = e.toLinearEquiv
    (e.hom m • e.toLinearEquiv.symm (1 : R))
  rw [e.toLinearEquiv.map_smul, e.toLinearEquiv.apply_symm_apply]
  change e.hom m = e.hom m * 1
  rw [mul_one]

/-- Checking one genuine original generator suffices to identify
ANY TWO maps out of the FULL scalar-extension tensor of a truly framed
rank-one module. No basis computation or tensor-surjectivity premise is used. -/
theorem actualModuleBaseChangeRankOneHom_ext (N : ModuleCat S)
    {a b : (ModuleCat.extendScalars φ).obj M ⟶ N}
    (h : a ((1 : S) ⊗ₜ[R,φ] (show M from e.inv (1 : R))) =
      b ((1 : S) ⊗ₜ[R,φ] (show M from e.inv (1 : R)))) : a = b := by
  letI := φ.toAlgebra
  apply ModuleCat.ExtendScalars.hom_ext
  intro m
  have ht : (1 : S) ⊗ₜ[R,φ] m =
      φ (e.hom m) • ((1 : S) ⊗ₜ[R,φ] (show M from e.inv (1 : R))) := by
    conv_lhs => rw [actualModuleRankOneFrame_generator M e m]
    rw [TensorProduct.tmul_smul]
    rfl
  rw [ht, a.hom.map_smul, b.hom.map_smul, h]

end Litt3.Jacobians
