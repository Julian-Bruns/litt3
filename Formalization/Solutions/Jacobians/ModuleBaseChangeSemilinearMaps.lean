import Mathlib.Algebra.Category.ModuleCat.ChangeOfRings

open CategoryTheory
open scoped TensorProduct ChangeOfRings

namespace Litt3.Jacobians

universe u
variable {R S R' S' : Type u} [CommRing R] [CommRing S]
  [CommRing R'] [CommRing S']
  (φ : R →+* S) (ψ : R' →+* S')
  (α : R →+* R') (β : S →+* S')
  (h : β.comp φ = ψ.comp α)
  (M : ModuleCat R) (N : ModuleCat R') (ℓ : M →ₛₗ[α] N)

/-- Actual scalar extension is functorial under an arbitrary compatible
square of ORIGINAL commutative-ring maps and an actual semilinear module
map. The full tensor map is constructed, not postulated. -/
noncomputable def actualModuleBaseChangeSemilinearMap :
    (ModuleCat.extendScalars φ).obj M →ₛₗ[β]
      (ModuleCat.extendScalars ψ).obj N := by
  letI : Module R S := Module.compHom S φ
  letI : Module R' S' := Module.compHom S' ψ
  let b : S →ₛₗ[α] S' :=
    { toAddHom := β.toAddMonoidHom
      map_smul' := fun r s => by
        change β (φ r * s) = ψ (α r) * β s
        rw [map_mul]
        exact congrArg (fun z => z * β s) (RingHom.congr_fun h r) }
  let q := TensorProduct.map b ℓ
  exact
    { toFun := q
      map_add' := q.map_add
      map_smul' := fun s a => by
        induction a using TensorProduct.induction_on with
        | zero => simp only [smul_zero, map_zero]
        | tmul t m =>
            dsimp only [q]
            simp only [ModuleCat.ExtendScalars.smul_tmul, TensorProduct.map_tmul]
            change β (s * (show S from t)) ⊗ₜ[R',ψ] ℓ m =
              (β s * β (show S from t)) ⊗ₜ[R',ψ] ℓ m
            rw [map_mul]
        | add a b ha hb =>
            simp only [smul_add, map_add, ha, hb] }

/-- The actual full base-change map has the literal formula on pure
tensors under the original ring maps; no basis or finite dimension is used. -/
theorem actualModuleBaseChangeSemilinearMap_tmul (s : S) (m : M) :
    actualModuleBaseChangeSemilinearMap φ ψ α β h M N ℓ (s ⊗ₜ[R,φ] m) =
      β s ⊗ₜ[R',ψ] ℓ m := rfl

end Litt3.Jacobians
