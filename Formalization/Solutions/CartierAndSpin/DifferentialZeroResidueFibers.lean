import Definitions.CartierAndSpin.DifferentialZeroLattices
import Mathlib.LinearAlgebra.TensorProduct.Quotient

open scoped TensorProduct

namespace Litt3.CartierAndSpin

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

/-- Membership in I·M is exactly zero in the ENTIRE actual tensor
fiber over R/I, with no free-module or rank hypothesis. -/
theorem ideal_smul_top_iff_residue_tensor_zero (I : Ideal R) (m : M) :
    m ∈ I • (⊤ : Submodule R M) ↔
      (1 : R ⧸ I) ⊗ₜ[R] m = 0 := by
  have h := (TensorProduct.quotTensorEquivQuotSMul M I).symm.map_eq_zero_iff
    (x := (Submodule.Quotient.mk m : M ⧸ (I • (⊤ : Submodule R M))))
  simpa only [TensorProduct.quotTensorEquivQuotSMul_symm_mk,
    Submodule.Quotient.mk_eq_zero] using h.symm

variable {k R F : Type*} [CommRing k] [CommRing R] [Field F] [IsLocalRing R]
  [Algebra k R] [Algebra k F] [Algebra R F] [IsScalarTower k R F]

/-- The zero lattice definition is literally vanishing in the true
maximal-ideal residue tensor fiber of the original universal module.
No selected-coordinate or valuation interpretation is required. -/
theorem differential_zero_lattice_iff_residue_fiber
    (omega : KaehlerDifferential k F) :
    differentialZeroLattice (R := R) omega ↔
      ∃ omegaR : KaehlerDifferential k R,
        (1 : R ⧸ IsLocalRing.maximalIdeal R) ⊗ₜ[R] omegaR = 0 ∧
          KaehlerDifferential.map k k R F omegaR = omega := by
  simp only [differentialZeroLattice, ideal_smul_top_iff_residue_tensor_zero]

end Litt3.CartierAndSpin
