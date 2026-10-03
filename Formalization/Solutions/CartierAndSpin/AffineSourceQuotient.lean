import Definitions.CartierAndSpin.AffineSourceFrame
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {K A : Type*} [Field K] [CommRing A] [Algebra K A]

theorem affine_source_frame_aeval (F : K[X]) (a b : K) (N : ℕ) (w : A) :
    aeval w (affineSourceFramePolynomial F a b N) =
      algebraMap K A (a ^ N) *
        aeval (algebraMap K A a⁻¹ * (w - algebraMap K A b)) F := by
  simp only [affineSourceFramePolynomial, map_mul, aeval_C, aeval_comp,
    aeval_sub, aeval_X]

theorem affine_source_frame_root (F : K[X]) (a b : K) (N : ℕ) (ha : a ≠ 0) :
    aeval (algebraMap K (AdjoinRoot F) a * AdjoinRoot.root F +
      algebraMap K (AdjoinRoot F) b) (affineSourceFramePolynomial F a b N) = 0 := by
  rw [affine_source_frame_aeval]
  have hcoordinate : algebraMap K (AdjoinRoot F) a⁻¹ *
      (algebraMap K (AdjoinRoot F) a * AdjoinRoot.root F +
        algebraMap K (AdjoinRoot F) b - algebraMap K (AdjoinRoot F) b) =
      AdjoinRoot.root F := by
    rw [add_sub_cancel_right, ← mul_assoc, ← map_mul, inv_mul_cancel₀ ha, map_one, one_mul]
  rw [hcoordinate, AdjoinRoot.aeval_eq, AdjoinRoot.mk_self, mul_zero]

theorem affine_source_frame_inverse_root (F : K[X]) (a b : K) (N : ℕ) (ha : a ≠ 0) :
    aeval (algebraMap K (AdjoinRoot (affineSourceFramePolynomial F a b N)) a⁻¹ *
      (AdjoinRoot.root (affineSourceFramePolynomial F a b N) -
        algebraMap K (AdjoinRoot (affineSourceFramePolynomial F a b N)) b)) F = 0 := by
  have h : aeval (AdjoinRoot.root (affineSourceFramePolynomial F a b N))
      (affineSourceFramePolynomial F a b N) = 0 := by
    rw [AdjoinRoot.aeval_eq, AdjoinRoot.mk_self]
  rw [affine_source_frame_aeval] at h
  have hunit : IsUnit (algebraMap K (AdjoinRoot (affineSourceFramePolynomial F a b N))
      (a ^ N)) := (isUnit_iff_ne_zero.mpr (pow_ne_zero _ ha)).map _
  exact hunit.mul_right_eq_zero.mp h

/-- The transformed polynomial has an explicitly constructed actual
quotient-algebra equivalence, with the new root sent to aW+b. No
separability, degree equality or irreducibility is needed. -/
noncomputable def affineSourceQuotientEquiv (F : K[X]) (a b : K) (N : ℕ) (ha : a ≠ 0) :
    AdjoinRoot (affineSourceFramePolynomial F a b N) ≃ₐ[K] AdjoinRoot F := by
  let forward := AdjoinRoot.liftAlgHom (affineSourceFramePolynomial F a b N)
    (Algebra.ofId K (AdjoinRoot F))
    (algebraMap K (AdjoinRoot F) a * AdjoinRoot.root F + algebraMap K (AdjoinRoot F) b)
    (affine_source_frame_root F a b N ha)
  let backward := AdjoinRoot.liftAlgHom F
    (Algebra.ofId K (AdjoinRoot (affineSourceFramePolynomial F a b N)))
    (algebraMap K (AdjoinRoot (affineSourceFramePolynomial F a b N)) a⁻¹ *
      (AdjoinRoot.root (affineSourceFramePolynomial F a b N) -
        algebraMap K (AdjoinRoot (affineSourceFramePolynomial F a b N)) b))
    (affine_source_frame_inverse_root F a b N ha)
  refine AlgEquiv.ofAlgHom forward backward ?_ ?_
  · apply AdjoinRoot.algHom_ext
    change forward (backward (AdjoinRoot.root F)) = AdjoinRoot.root F
    simp only [backward, AdjoinRoot.liftAlgHom_root, map_mul, map_sub, forward.commutes,
      forward, AdjoinRoot.liftAlgHom_root]
    rw [add_sub_cancel_right, ← mul_assoc, ← map_mul, inv_mul_cancel₀ ha, map_one, one_mul]
  · apply AdjoinRoot.algHom_ext
    change backward (forward (AdjoinRoot.root _)) = AdjoinRoot.root _
    simp only [forward, AdjoinRoot.liftAlgHom_root, map_add, map_mul, backward.commutes,
      backward, AdjoinRoot.liftAlgHom_root]
    rw [← mul_assoc, ← map_mul, mul_inv_cancel₀ ha, map_one, one_mul,
      sub_add_cancel]

theorem affineSourceQuotientEquiv_root (F : K[X]) (a b : K) (N : ℕ) (ha : a ≠ 0) :
    affineSourceQuotientEquiv F a b N ha
      (AdjoinRoot.root (affineSourceFramePolynomial F a b N)) =
      algebraMap K (AdjoinRoot F) a * AdjoinRoot.root F + algebraMap K (AdjoinRoot F) b := by
  simp [affineSourceQuotientEquiv, AdjoinRoot.liftAlgHom_root]

end Litt3.CartierAndSpin
