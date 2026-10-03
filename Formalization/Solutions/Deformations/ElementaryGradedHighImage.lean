import Solutions.Deformations.ElementaryHighHomogeneousDivision
import Solutions.Deformations.WeightedRootHomogeneousOriginDivisibility

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (k : Type*) [Field k] [CharP k 5] [Fact (Nat.Prime 5)]

/-- Actual high-weight quadratic surjectivity at source precision
r+1, obtained by removing the literal augmentation scalar killed by
that actual truncation. No high-weight image conclusion is an input. -/
theorem elementary_graded_high_image (r d : ℕ) (high : 4 * r + 2 ≤ d)
    (q : MvPolynomial (Fin r) k) (quadratic : q.IsHomogeneous 2)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k 5 (by omega) r d) :
    ∃ x : weightedRootProduct (Polynomial k) 5 Polynomial.X r,
      x ∈ weightedRootHomogeneousComponent k 5 (by omega) r (d - 2) ∧
      weightedRootTruncation k 5 (r + 1) (by omega) r
        (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * x) =
        weightedRootTruncation k 5 (r + 1) (by omega) r Z := by
  let projection := weightedRootOriginProjection k 5 (by omega) r Z
  have homogeneousProjection : projection ∈ weightedRootHomogeneousComponent k 5 (by omega) r d :=
    weighted_root_origin_projection_homogeneous k 5 (by omega) r d Z homogeneous
  have zeroOrigin : weightedRootOrigin 5 (by omega) (Polynomial.X : Polynomial k) r
      (Z - projection) = 0 := by
    rw [map_sub, weighted_root_origin_projection_origin, sub_self]
  obtain ⟨x, member, division⟩ := elementary_high_homogeneous_division k r d high q quadratic
    anisotropic (Z - projection) (Submodule.sub_mem _ homogeneous homogeneousProjection) zeroOrigin
  refine ⟨x, member, ?_⟩
  have exactImage := congrArg (weightedRootTruncation k 5 (r + 1) (by omega) r) division
  have zeroProjection : weightedRootTruncation k 5 (r + 1) (by omega) r projection = 0 :=
    weighted_root_homogeneous_origin_projection_truncates k 5 (by omega) r d (r + 1)
      (by omega) (by norm_num; omega) Z homogeneous
  simpa only [map_sub, zeroProjection, sub_zero] using exactImage

end Litt3.Deformations
