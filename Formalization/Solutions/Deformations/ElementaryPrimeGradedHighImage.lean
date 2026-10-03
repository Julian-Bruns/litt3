import Solutions.Deformations.ElementaryPrimeHighHomogeneousDivision
import Solutions.Deformations.WeightedRootHomogeneousOriginDivisibility

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p]

/-- Actual high-weight principal surjectivity at final precision, with the
actual augmentation scalar removed only because it vanishes under truncation. -/
theorem elementary_prime_graded_high_image (r d a : ℕ) (principalPositive : 0 < a)
    (high : (p - 1) * r + a ≤ d)
    (q : MvPolynomial (Fin r) k) (principal : q.IsHomogeneous a)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (Z : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d) :
    ∃ x : weightedRootProduct (Polynomial k) p Polynomial.X r,
      x ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r (d - a) ∧
      weightedRootTruncation k p (r + 1) (by omega) r
        (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q) * x) =
        weightedRootTruncation k p (r + 1) (by omega) r Z := by
  let projection := weightedRootOriginProjection k p (Fact.out : p.Prime).pos r Z
  have homogeneousProjection : projection ∈ weightedRootHomogeneousComponent k p
      (Fact.out : p.Prime).one_lt r d :=
    weighted_root_origin_projection_homogeneous k p (Fact.out : p.Prime).one_lt r d Z homogeneous
  have zeroOrigin : weightedRootOrigin p (Fact.out : p.Prime).pos (Polynomial.X : Polynomial k) r
      (Z - projection) = 0 := by
    rw [map_sub, weighted_root_origin_projection_origin, sub_self]
  obtain ⟨x, member, division⟩ := elementary_prime_high_homogeneous_division p k r d a high q principal
    anisotropic (Z - projection) (Submodule.sub_mem _ homogeneous homogeneousProjection) zeroOrigin
  refine ⟨x, member, ?_⟩
  have exactImage := congrArg (weightedRootTruncation k p (r + 1) (by omega) r) division
  have zeroProjection : weightedRootTruncation k p (r + 1) (by omega) r projection = 0 :=
    weighted_root_homogeneous_origin_projection_truncates k p (Fact.out : p.Prime).one_lt r d (r + 1)
      (by omega) (by simp only [Nat.add_sub_cancel]; omega) Z homogeneous
  simpa only [map_sub, zeroProjection, sub_zero] using exactImage

end Litt3.Deformations
