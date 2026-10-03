import Mathlib.LinearAlgebra.Prod

namespace Litt3.Jacobians

/-- A jet map after separating its polynomial columns. Its identity block
eliminates the low-order rows; `B` contains precisely the remaining rows. -/
def blockJetMap {K P Q R : Type*} [Semiring K]
    [AddCommMonoid P] [AddCommMonoid Q] [AddCommMonoid R]
    [Module K P] [Module K Q] [Module K R]
    (T : Q →ₗ[K] P) (B : Q →ₗ[K] R) : P × Q →ₗ[K] P × R where
  toFun v := (v.1 + T v.2, B v.2)
  map_add' := by intros; simp [add_assoc, add_left_comm, add_comm]
  map_smul' := by intros; simp [smul_add]

end Litt3.Jacobians
