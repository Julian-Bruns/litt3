import Theorems.Deformations.CyclicKernelProfile
import Solutions.Deformations.TruncatedBlockDimensions

namespace Litt3.Deformations

variable {k : Type*} [CommRing k]

theorem truncated_power_kernel_mono (N a b : ℕ) (bound : a ≤ b) :
    LinearMap.ker (truncatedPowerMultiplication k N a) ≤
      LinearMap.ker (truncatedPowerMultiplication k N b) := by
  intro x hx
  change truncatedParameter k N ^ a * x = 0 at hx
  change truncatedParameter k N ^ b * x = 0
  rw [← Nat.sub_add_cancel bound, pow_add, mul_assoc, hx, mul_zero]

/-- The complete power-action kernel on an actual cyclic
quotient is the actual smaller power kernel in the regular
module, retaining the full truncated scalar action. -/
noncomputable def truncatedCyclicPowerKernelEquiv (N j s : ℕ) (bound : j ≤ N) :
    LinearMap.ker (truncatedModulePowerMap k N s (TruncatedCyclicModule (k := k) N j))
      ≃ₗ[TruncatedCoefficientRing k N]
        LinearMap.ker (truncatedPowerMultiplication k N (min s j)) := by
  let E := truncatedKernelQuotientEquiv (k := k) N j bound
  have mapZero (x : TruncatedCyclicModule (k := k) N j) :
      truncatedParameter k N ^ s • x = 0 ↔
        truncatedParameter k N ^ s * (E x).val = 0 := by
    constructor
    · intro h
      have he := congrArg E h
      rw [E.map_smul, E.map_zero] at he
      exact congrArg Subtype.val he
    · intro h
      apply E.injective
      rw [E.map_smul, E.map_zero]
      apply Subtype.ext
      exact h
  exact {
    toFun := fun x => ⟨(E x.val).val, by
      rcases le_total s j with hs | hj
      · rw [min_eq_left hs]
        exact (mapZero x.val).mp x.property
      · rw [min_eq_right hj]
        exact (E x.val).property⟩
    invFun := fun y => ⟨E.symm ⟨y.val,
      truncated_power_kernel_mono N (min s j) j (Nat.min_le_right _ _) y.property⟩, by
        apply (mapZero _).mpr
        simp only [LinearEquiv.apply_symm_apply]
        exact truncated_power_kernel_mono N (min s j) s (Nat.min_le_left _ _) y.property⟩
    left_inv := fun x => by
      apply Subtype.ext
      exact E.symm_apply_apply x.val
    right_inv := fun y => by
      apply Subtype.ext
      change (E (E.symm ⟨y.val, _⟩)).val = y.val
      exact congrArg (fun t : LinearMap.ker (truncatedPowerMultiplication k N j) => t.val)
        (E.apply_symm_apply _)
    map_add' := fun x y => by
      apply Subtype.ext
      change (E (x.val + y.val)).val = (E x.val).val + (E y.val).val
      exact congrArg (fun t : LinearMap.ker (truncatedPowerMultiplication k N j) => t.val)
        (E.map_add x.val y.val)
    map_smul' := fun a x => by
      apply Subtype.ext
      change (E (a • x.val)).val = a * (E x.val).val
      exact congrArg (fun t : LinearMap.ker (truncatedPowerMultiplication k N j) => t.val)
        (E.map_smul a x.val) }

section Field

variable {K : Type*} [Field K]

/-- The intrinsic power-action profile of a cyclic block is
min(s,j), over every coefficient field and at every length. -/
theorem truncated_cyclic_power_kernel_dimension (N j s : ℕ) (bound : j ≤ N) :
    Specifications.CyclicPowerKernelDimension (k := K) N j s := by
  change Module.finrank K (LinearMap.ker
    (truncatedModulePowerMap K N s (TruncatedCyclicModule (k := K) N j))) = min s j
  rw [((truncatedCyclicPowerKernelEquiv (k := K) N j s bound).restrictScalars K).finrank_eq,
    (truncatedCoefficientKernelEquiv (k := K) N (min s j)).finrank_eq]
  exact truncated_power_kernel_finrank N (min s j) ((Nat.min_le_right _ _).trans bound)

end Field

end Litt3.Deformations
