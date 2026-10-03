import Solutions.Deformations.WeightedRootCoefficientKernel

namespace Litt3.Deformations

variable (k : Type*) [Field k] [CharP k 5] [Fact (Nat.Prime 5)]

/-- The literal untruncated source algebra over k[tau], with all
original E_i^5+tau E_i relations, has exactly the source norm kernel. -/
theorem elementary_graded_integral_quadratic_kernel (r : ℕ)
    (q : MvPolynomial (Fin r) k) (homogeneous : q.IsHomogeneous 2)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (x : weightedRootProduct (Polynomial k) 5 Polynomial.X r) :
    weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * x = 0 ↔
      ∃ b : Polynomial k, x = b • weightedRootProductNorm 5 Polynomial.X r := by
  simpa only [ZMod.card] using weighted_root_original_homogeneous_kernel
    (ZMod 5) (Polynomial.C : k →+* Polynomial k) (ZMod.castHom (dvd_refl 5) k)
    Polynomial.X Polynomial.X_ne_zero r 2 (by omega) q homogeneous anisotropic x

end Litt3.Deformations
