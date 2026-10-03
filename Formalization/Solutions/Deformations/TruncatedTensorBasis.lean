import Theorems.Deformations.TruncatedTensorBasis
import Solutions.Deformations.TruncatedCoefficientRing
import Solutions.Deformations.WeightedBasisFiltration

namespace Litt3.Deformations

open scoped TensorProduct

variable {k : Type*} [CommRing k] [Nontrivial k]

@[simp] theorem truncated_monomial_basis_apply (N : ℕ) (i : Fin N) :
    truncatedMonomialBasis k N i = truncatedParameter k N ^ i.val := by
  unfold truncatedMonomialBasis
  rw [Module.Basis.reindex_apply, PowerBasis.basis_eq_pow]
  rfl

@[simp] theorem truncated_tensor_monomial_basis_apply (N M : ℕ) (ij : Fin N × Fin M) :
    truncatedTensorMonomialBasis k N M ij =
      (truncatedParameter k N ^ ij.1.val) ⊗ₜ[k] (truncatedParameter k M ^ ij.2.val) := by
  rw [truncatedTensorMonomialBasis, Module.Basis.tensorProduct_apply',
    truncated_monomial_basis_apply, truncated_monomial_basis_apply]

theorem truncated_tensor_monomial_formula (N M : ℕ) :
    Specifications.TruncatedTensorMonomialFormula (k := k) N M := by
  intro ij
  rw [truncated_tensor_monomial_basis_apply, ← map_pow, ← map_pow]
  change _ = ((truncatedParameter k N ^ ij.1.val) ⊗ₜ[k] (1 : TruncatedCoefficientRing k M)) *
    ((1 : TruncatedCoefficientRing k N) ⊗ₜ[k] (truncatedParameter k M ^ ij.2.val))
  rw [Algebra.TensorProduct.tmul_mul_tmul, mul_one, one_mul]

end Litt3.Deformations
