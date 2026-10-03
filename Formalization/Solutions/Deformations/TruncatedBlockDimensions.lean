import Theorems.Deformations.TruncatedBlockDimensions
import Solutions.Deformations.TruncatedBlockKernels
import Solutions.Deformations.TruncatedRestriction

namespace Litt3.Deformations

variable {k : Type*} [Field k]

noncomputable def truncatedCoefficientKernelEquiv (N j : ℕ) :
    LinearMap.ker (truncatedPowerMultiplication k N j) ≃ₗ[k]
      LinearMap.ker (truncatedPowerCoefficientMap k N j) where
  toFun x := ⟨x.val, x.property⟩
  invFun x := ⟨x.val, x.property⟩
  left_inv _ := rfl
  right_inv _ := rfl
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

noncomputable def truncatedCyclicCoefficientKernelEquiv (N j : ℕ) (bound : j ≤ N) :
    TruncatedCyclicModule (k := k) N j ≃ₗ[k]
      LinearMap.ker (truncatedPowerCoefficientMap k N j) :=
  ((truncatedKernelQuotientEquiv N j bound).restrictScalars k).trans
    (truncatedCoefficientKernelEquiv N j)

theorem truncated_cyclic_module_finrank (N j : ℕ) (bound : j ≤ N) :
    Module.finrank k (TruncatedCyclicModule (k := k) N j) = j := by
  rw [(truncatedCyclicCoefficientKernelEquiv (k := k) N j bound).finrank_eq]
  exact truncated_power_kernel_finrank N j bound

/-- The genuine full cyclic kernel block has its exact
coefficient-field dimension at every order, size and valuation. -/
theorem truncated_unit_block_dimension {ι : Type*} [Fintype ι] [DecidableEq ι]
    (N j : ℕ) (bound : j ≤ N) (C : Matrix ι ι (TruncatedCoefficientRing k N))
    (unit : IsUnit C) : Specifications.TruncatedUnitBlockDimension N j C := by
  let equiv := (truncatedCyclicCoefficientKernelEquiv (k := k) N j bound)
  haveI : Module.Finite k (TruncatedCyclicModule (k := k) N j) :=
    Module.Finite.of_injective equiv.toLinearMap equiv.injective
  have h := ((truncatedUnitBlockKernelEquiv N j bound C unit).restrictScalars k).finrank_eq
  change Module.finrank k (LinearMap.ker (Matrix.toLin' (truncatedParameter k N ^ j • C))) = _
  rw [h, Module.finrank_pi_fintype]
  simp only [truncated_cyclic_module_finrank N j bound, Finset.sum_const,
    Finset.card_univ, smul_eq_mul, Nat.mul_comm]

end Litt3.Deformations
