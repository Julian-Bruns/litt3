import Mathlib.Algebra.Category.ModuleCat.ChangeOfRings
import Mathlib.LinearAlgebra.TensorProduct.Tower

open CategoryTheory
open scoped TensorProduct ChangeOfRings

namespace Litt3.Jacobians

universe u
variable {R S : Type u} [CommRing R] [CommRing S] (φ : R →+* S)

/-- ANY actual commutative-ring scalar extension carries the genuine
rank-one structure module to the original target ring module, by literal
tensor multiplication. No flatness or finite-generation premise is used. -/
noncomputable def actualModuleBaseChangeUnitIso :
    (ModuleCat.extendScalars φ).obj (ModuleCat.of R R) ≅ ModuleCat.of S S := by
  letI := φ.toAlgebra
  exact (TensorProduct.AlgebraTensorModule.rid R S S).toModuleIso

/-- Literal original tensor multiplication under the genuine unit
scalar-extension isomorphism. -/
theorem actualModuleBaseChangeUnitIso_tmul (s : S) (r : R) :
    (actualModuleBaseChangeUnitIso φ).hom (s ⊗ₜ[R,φ] r) = φ r * s := rfl

/-- EVERY actual whole-module frame gives an actual rank-one frame
on the entire scalar-extension tensor module, over ANY original ring map. -/
noncomputable def actualModuleBaseChangeRankOneIso (M : ModuleCat R)
    (e : M ≅ ModuleCat.of R R) :
    (ModuleCat.extendScalars φ).obj M ≅ ModuleCat.of S S :=
  (ModuleCat.extendScalars φ).mapIso e ≪≫ actualModuleBaseChangeUnitIso φ

/-- Exact scalar-extension frame formula on all original tensors. -/
theorem actualModuleBaseChangeRankOneIso_tmul (M : ModuleCat R)
    (e : M ≅ ModuleCat.of R R) (s : S) (m : M) :
    (actualModuleBaseChangeRankOneIso φ M e).hom (s ⊗ₜ[R,φ] m) = φ (e.hom m) * s := rfl

end Litt3.Jacobians
