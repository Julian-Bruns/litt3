import Theorems.Deformations.BlockDiagonalKernels
import Solutions.Deformations.KernelTransport

namespace Litt3.Deformations

section Product

variable {R V W Z Z' : Type*} [Ring R]
variable [AddCommGroup V] [Module R V] [AddCommGroup W] [Module R W]
variable [AddCommGroup Z] [Module R Z] [AddCommGroup Z'] [Module R Z']

def productKernelEquiv (T : V →ₗ[R] Z) (U : W →ₗ[R] Z') :
    LinearMap.ker (LinearMap.prodMap T U) ≃ₗ[R] (LinearMap.ker T × LinearMap.ker U) where
  toFun x := (⟨x.val.1, congrArg Prod.fst (LinearMap.mem_ker.mp x.property)⟩,
    ⟨x.val.2, congrArg Prod.snd (LinearMap.mem_ker.mp x.property)⟩)
  invFun y := ⟨(y.1.val, y.2.val), by
    apply LinearMap.mem_ker.mpr
    exact Prod.ext (LinearMap.mem_ker.mp y.1.property) (LinearMap.mem_ker.mp y.2.property)⟩
  left_inv _ := rfl
  right_inv _ := rfl
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

end Product

variable {R m n : Type*} [CommRing R]
variable [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n]

/-- The actual complete kernel of a block diagonal matrix is
the product of the actual complete block kernels, with the full
ring-module action preserved. -/
noncomputable def blockDiagonalKernelEquiv (A : Matrix m m R) (B : Matrix n n R) :
    LinearMap.ker (Matrix.toLin' (blockDiagonalMatrix A B)) ≃ₗ[R]
      (LinearMap.ker (Matrix.toLin' A) × LinearMap.ker (Matrix.toLin' B)) := by
  let split := LinearEquiv.sumArrowLequivProdArrow m n R R
  let product := LinearMap.prodMap (Matrix.toLin' A) (Matrix.toLin' B)
  have hmap : Matrix.toLin' (blockDiagonalMatrix A B) =
      transportedLinearMap product split split.symm := by
    apply LinearMap.ext
    intro x
    change (Matrix.fromBlocks A 0 0 B).mulVec x =
      Sum.elim (A.mulVec (x ∘ Sum.inl)) (B.mulVec (x ∘ Sum.inr))
    rw [Matrix.fromBlocks_mulVec, Matrix.zero_mulVec, Matrix.zero_mulVec, add_zero, zero_add]
  exact (LinearEquiv.ofEq _ _ (congrArg LinearMap.ker hmap)).trans
    ((transportedKernelEquiv product split split.symm).trans
      (productKernelEquiv (Matrix.toLin' A) (Matrix.toLin' B)))

theorem block_diagonal_kernel_equivalent (A : Matrix m m R) (B : Matrix n n R) :
    Specifications.BlockDiagonalKernelEquivalent A B :=
  ⟨blockDiagonalKernelEquiv A B⟩

end Litt3.Deformations
