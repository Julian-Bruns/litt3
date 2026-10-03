import Theorems.Deformations.CyclicBlockProfile
import Solutions.Deformations.CyclicKernelProfile
import Solutions.Deformations.CyclicMultiplicityProfile

namespace Litt3.Deformations

section General

variable {k : Type*} [CommRing k]

/-- The actual power-action kernel of any product module
is the actual product of all its power-action kernels. -/
noncomputable def truncatedPiPowerKernelEquiv (N a : ℕ) (ι : Type*) (M : ι → Type*)
    [∀ i, AddCommGroup (M i)] [∀ i, Module (TruncatedCoefficientRing k N) (M i)] :
    LinearMap.ker (truncatedModulePowerMap k N a ((i : ι) → M i))
      ≃ₗ[TruncatedCoefficientRing k N]
        ((i : ι) → LinearMap.ker (truncatedModulePowerMap k N a (M i))) where
  toFun x i := ⟨x.val i, congrArg (fun y : (i : ι) → M i => y i)
    (LinearMap.mem_ker.mp x.property)⟩
  invFun x := ⟨fun i => (x i).val, by
    apply LinearMap.mem_ker.mpr
    funext i
    exact LinearMap.mem_ker.mp (x i).property⟩
  left_inv x := by apply Subtype.ext; rfl
  right_inv x := by funext i; apply Subtype.ext; rfl
  map_add' x y := by funext i; apply Subtype.ext; rfl
  map_smul' c x := by funext i; apply Subtype.ext; rfl

/-- An actual module equivalence preserves every actual
power-action kernel, with the full scalar action. -/
noncomputable def truncatedPowerKernelCongr (N a : ℕ) {M M' : Type*}
    [AddCommGroup M] [Module (TruncatedCoefficientRing k N) M]
    [AddCommGroup M'] [Module (TruncatedCoefficientRing k N) M']
    (E : M ≃ₗ[TruncatedCoefficientRing k N] M') :
    LinearMap.ker (truncatedModulePowerMap k N a M) ≃ₗ[TruncatedCoefficientRing k N]
      LinearMap.ker (truncatedModulePowerMap k N a M') where
  toFun x := ⟨E x.val, by
    change truncatedParameter k N ^ a • E x.val = 0
    rw [← E.map_smul]
    exact (congrArg E x.property).trans E.map_zero⟩
  invFun x := ⟨E.symm x.val, by
    change truncatedParameter k N ^ a • E.symm x.val = 0
    rw [← E.symm.map_smul]
    exact (congrArg E.symm x.property).trans E.symm.map_zero⟩
  left_inv x := by apply Subtype.ext; exact E.symm_apply_apply x.val
  right_inv x := by apply Subtype.ext; exact E.apply_symm_apply x.val
  map_add' x y := by apply Subtype.ext; exact E.map_add x.val y.val
  map_smul' c x := by apply Subtype.ext; exact E.map_smul c x.val

end General

variable {k : Type*} [Field k]

/-- The actual full cyclic product has the intrinsic
power-kernel profile given by its actual degrees and
multiplicities, uniformly over every coefficient field. -/
theorem truncated_cyclic_block_profile (N s : ℕ) (degree multiplicity : Fin s → ℕ)
    (bounded : ∀ i, degree i ≤ N) :
    Specifications.CyclicBlockProfile (k := k) N s degree multiplicity := by
  intro a
  let scalarEquiv i := truncatedCyclicPowerKernelEquiv (k := k) N (degree i) a (bounded i)
  let coordinateEquiv i := (truncatedPiPowerKernelEquiv (k := k) N a (Fin (multiplicity i))
    (fun _ => TruncatedCyclicModule (k := k) N (degree i))).trans
      (LinearEquiv.piCongrRight fun _ => scalarEquiv i)
  let E := (truncatedPiPowerKernelEquiv (k := k) N a (Fin s)
    (fun i => Fin (multiplicity i) → TruncatedCyclicModule (k := k) N (degree i))).trans
      (LinearEquiv.piCongrRight coordinateEquiv)
  change Module.finrank k (LinearMap.ker (truncatedModulePowerMap k N a
    (TruncatedCyclicBlocks k N s degree multiplicity))) = _
  rw [(E.restrictScalars k).finrank_eq]
  rw [Module.finrank_pi_fintype]
  unfold cyclicDimensionProfile
  apply Finset.sum_congr rfl
  intro i _
  rw [Module.finrank_pi_fintype]
  have dim := truncated_power_kernel_finrank (K := k) N (min a (degree i))
    ((Nat.min_le_right _ _).trans (bounded i))
  rw [← (truncatedCoefficientKernelEquiv (k := k) N (min a (degree i))).finrank_eq] at dim
  simp only [dim, Finset.sum_const, Finset.card_univ, Fintype.card_fin, smul_eq_mul]

end Litt3.Deformations
