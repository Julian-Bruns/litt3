import Solutions.CartierAndSpin.ActualSourceMomentEvaluation
import Solutions.CartierAndSpin.SubringSourceIntegrality

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K] [Fintype ι]

/-- The original actual trace moments belong to the actual preserved
local subring in every order. The denominator inverse is supplied by the
source equation and tau, not a separate root-unit assumption. -/
theorem actual_source_derivative_moment_mem_subring (S : Subring K) (D : Derivation R K K)
    (F H : K[X]) (p : ℕ) (q tau leading : K) (node : ι → K)
    (hsep : F.Separable) (hinj : Function.Injective node)
    (hleading : leading ≠ 0) (htau : tau ≠ 0)
    (hfactor : F = C leading * Lagrange.nodal univ node)
    (hsource : F = (X ^ p + C q) * H + C tau)
    (hD : ∀ x ∈ S, D x ∈ S) (hH : ∀ j, H.coeff j ∈ S)
    (htauInv : tau⁻¹ ∈ S) (hnodes : ∀ i, node i ∈ S)
    (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F))
    (hunit : (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q))
    (compatible : ∀ a : K, E (algebraMap K (AdjoinRoot F) a) =
      algebraMap K (AdjoinRoot F) (D a)) (n : ℕ) :
    functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
      (E (AdjoinRoot.root F)) n ∈ S := by
  classical
  rw [split_actual_source_derivative_moment D F hsep node hinj leading hleading
    hfactor E compatible (X ^ p + C q) unit hunit n]
  apply S.sum_mem
  intro i _
  have hroot : F.eval (node i) = 0 := by
    rw [hfactor, eval_mul, Lagrange.eval_nodal_at_node (mem_univ i), mul_zero]
  have hInv := source_factor_inverse_mem_subring S F H p q tau (node i) hsource hroot
    htau htauInv hH (hnodes i)
  simp only [eval_add, eval_pow, eval_X, eval_C, div_eq_mul_inv]
  exact S.mul_mem (S.pow_mem (hD _ (hnodes i)) n) hInv

end Litt3.CartierAndSpin
