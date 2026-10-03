import Solutions.Deformations.WeightedRootPolynomialEvaluation
import Solutions.Deformations.WeightedRootProductLift

namespace Litt3.Deformations

open scoped BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Actual evaluation at the original augmentation origin, retaining
the original parameter and coefficient ring. -/
noncomputable def weightedRootOrigin (q : ℕ) (positive : 0 < q) (tau : R) (r : ℕ) :
    weightedRootProduct R q tau r →ₐ[R] R :=
  weightedRootProductLift q tau r (fun _ => 0)
    (fun _ => by simp only [zero_pow (Nat.ne_of_gt positive), mul_zero])

@[simp] theorem weighted_root_origin_parameter (q : ℕ) (positive : 0 < q) (tau : R)
    (r : ℕ) (i : Fin r) :
    weightedRootOrigin q positive tau r (weightedRootProductParameter R q tau r i) = 0 :=
  weighted_root_product_lift_parameter _ _ _ _ _ _

theorem weighted_root_origin_polynomial (q : ℕ) (positive : 0 < q) (tau : R) (r : ℕ)
    (p : MvPolynomial (Fin r) R) :
    weightedRootOrigin q positive tau r (weightedRootPolynomialEvaluation q tau r p) =
      p.eval (0 : Fin r → R) := by
  rw [weightedRootPolynomialEvaluation]
  change (weightedRootOrigin q positive tau r).toRingHom (MvPolynomial.eval₂Hom _ _ p) = _
  rw [MvPolynomial.map_eval₂Hom]
  change MvPolynomial.eval₂Hom _ _ p = MvPolynomial.eval₂Hom (RingHom.id R) (0 : Fin r → R) p
  apply congrArg (fun f : MvPolynomial (Fin r) R →+* R => f p)
  apply congrArg₂ MvPolynomial.eval₂Hom
  · ext a
    exact AlgHom.commutes _ a
  · funext i
    exact weighted_root_origin_parameter _ _ _ _ _

theorem weighted_root_origin_norm (q : ℕ) (large : 1 < q) (tau : R) (r : ℕ) :
    weightedRootOrigin q (by omega) tau r (weightedRootProductNorm q tau r) = tau ^ r := by
  rw [weightedRootProductNorm, map_prod]
  simp only [map_add, map_pow, weighted_root_origin_parameter, AlgHom.commutes,
    zero_pow (show q - 1 ≠ 0 by omega), zero_add, Algebra.algebraMap_self,
    Finset.prod_const, Finset.card_univ, Fintype.card_fin]
  rfl

end Litt3.Deformations
