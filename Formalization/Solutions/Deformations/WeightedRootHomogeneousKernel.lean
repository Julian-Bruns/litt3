import Solutions.Deformations.WeightedRootPolynomialEvaluation

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [Nontrivial R] [Field K]

/-- The source anisotropy condition is imposed only on the original
finite-field directions. It implies the entire integral kernel statement
for any positive-degree homogeneous polynomial. -/
theorem weighted_root_homogeneous_integral_kernel
    (F : Type*) [Field F] [Fintype F] [DecidableEq F]
    (φ : R →+* K) (injective : Function.Injective φ) (ψ : F →+* K)
    (tau : R) (c : K) (root : c ^ (Fintype.card F - 1) = -(φ tau))
    (nonzero : c ≠ 0) (r n : ℕ) (positive : 0 < n)
    (p : MvPolynomial (Fin r) R) (homogeneous : p.IsHomogeneous n)
    (anisotropic : ∀ a : Fin r → F, a ≠ 0 → p.eval₂ φ (fun i => ψ (a i)) ≠ 0)
    (x : weightedRootProduct R (Fintype.card F) tau r) :
    weightedRootPolynomialEvaluation (Fintype.card F) tau r p * x = 0 ↔
      ∃ a : R, x = a • weightedRootProductNorm (Fintype.card F) tau r := by
  apply weighted_root_integral_direction_kernel F φ injective ψ tau c root nonzero r
  · rw [weighted_root_polynomial_direction_evaluation]
    simpa only [Pi.zero_apply, map_zero, mul_zero] using
      homogeneous_positive_polynomial_origin φ p n homogeneous positive
  · intro a nonzeroDirection
    rw [weighted_root_polynomial_direction_evaluation,
      homogeneous_polynomial_evaluation_scale φ p n homogeneous]
    exact mul_ne_zero (pow_ne_zero n nonzero) (anisotropic a nonzeroDirection)

end Litt3.Deformations
