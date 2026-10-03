import Theorems.Deformations.TruncatedBlockKernels
import Solutions.Deformations.TruncatedPowerKernels
import Solutions.Deformations.KernelTransport

namespace Litt3.Deformations

variable {k : Type*} [CommRing k]

/-- The actual kernel of the actual free-module diagonal
operator is the product of its actual scalar kernels. -/
noncomputable def truncatedCoordinateKernelEquiv (N j : ℕ) (ι : Type*) :
    LinearMap.ker (truncatedCoordinatePowerMap k N j ι)
      ≃ₗ[TruncatedCoefficientRing k N]
        (ι → LinearMap.ker (truncatedPowerMultiplication k N j)) where
  toFun x i := ⟨x.val i, by
    have h := congrArg (fun v : ι → TruncatedCoefficientRing k N => v i)
      (LinearMap.mem_ker.mp x.property)
    exact h⟩
  invFun x := ⟨fun i => (x i).val, by
    apply LinearMap.mem_ker.mpr
    funext i
    exact (x i).property⟩
  left_inv x := by apply Subtype.ext; rfl
  right_inv x := by funext i; apply Subtype.ext; rfl
  map_add' x y := by funext i; apply Subtype.ext; rfl
  map_smul' c x := by funext i; apply Subtype.ext; rfl

/-- Each actual invertible valuation block has the expected
full cyclic kernel module. Its full truncated scalar action is
retained, including free blocks at j=N and zero kernels at j=0. -/
noncomputable def truncatedUnitBlockKernelEquiv {ι : Type*} [Fintype ι] [DecidableEq ι]
    (N j : ℕ) (bound : j ≤ N) (C : Matrix ι ι (TruncatedCoefficientRing k N))
    (unit : IsUnit C) :
    LinearMap.ker (Matrix.toLin' (truncatedParameter k N ^ j • C))
      ≃ₗ[TruncatedCoefficientRing k N]
        (ι → (TruncatedCoefficientRing k N ⧸
          LinearMap.range (truncatedPowerMultiplication k N j))) := by
  let u := unit.unit
  have hu : (u : Matrix ι ι (TruncatedCoefficientRing k N)) = C := unit.unit_spec
  letI : Invertible C := {
    invOf := (u⁻¹ : (Matrix ι ι (TruncatedCoefficientRing k N))ˣ)
    invOf_mul_self := by rw [← hu]; exact u.inv_val
    mul_invOf_self := by rw [← hu]; exact u.val_inv }
  let changeBasis := C.toLinearEquiv' (inferInstance : Invertible C)
  have hmap : Matrix.toLin' (truncatedParameter k N ^ j • C) =
      transportedLinearMap (truncatedCoordinatePowerMap k N j ι) changeBasis
        (LinearEquiv.refl (TruncatedCoefficientRing k N) (ι → TruncatedCoefficientRing k N)) := by
    apply LinearMap.ext
    intro x
    funext i
    change ((truncatedParameter k N ^ j • C).mulVec x) i =
      truncatedParameter k N ^ j * changeBasis x i
    have hcb : changeBasis x = C.mulVec x := by
      change C.toLinearEquiv' (inferInstance : Invertible C) x = C.mulVec x
      rw [← Matrix.toLin'_apply]
      exact congrArg (fun f => f x) (Matrix.toLinearEquiv'_apply C inferInstance)
    rw [hcb, Matrix.smul_mulVec]
    rfl
  exact (LinearEquiv.ofEq _ _ (congrArg LinearMap.ker hmap)).trans
    ((transportedKernelEquiv (truncatedCoordinatePowerMap k N j ι) changeBasis
      (LinearEquiv.refl _ _)).trans
        ((truncatedCoordinateKernelEquiv N j ι).trans
          (LinearEquiv.piCongrRight fun _ : ι =>
            (truncatedKernelQuotientEquiv N j bound).symm)))

theorem truncated_unit_block_kernel {ι : Type*} [Fintype ι] [DecidableEq ι]
    (N j : ℕ) (bound : j ≤ N) (C : Matrix ι ι (TruncatedCoefficientRing k N))
    (unit : IsUnit C) : Specifications.TruncatedUnitBlockKernel N j C :=
  ⟨truncatedUnitBlockKernelEquiv N j bound C unit⟩

end Litt3.Deformations
