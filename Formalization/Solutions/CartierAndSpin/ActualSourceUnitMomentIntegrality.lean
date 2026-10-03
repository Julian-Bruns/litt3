import Solutions.CartierAndSpin.ActualSourceMomentEvaluation
import Solutions.CartierAndSpin.SubringSourceIntegrality

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K] [Fintype ι]

/-- The canonical local-unit hypotheses suffice, without integrality of
H or tau: all root derivatives and weighted trace moments are integral. -/
theorem actual_source_unit_derivative_moment_mem_subring (S : Subring K) (D : Derivation R K K)
    (F : K[X]) (node : ι → K) (leading : K) (phi : K[X])
    (hsep : F.Separable) (hinj : Function.Injective node) (hleading : leading ≠ 0)
    (hfactor : F = C leading * Lagrange.nodal Finset.univ node)
    (hD : ∀ x ∈ S, D x ∈ S) (hnodes : ∀ i, node i ∈ S)
    (hInv : ∀ i, (phi.eval (node i))⁻¹ ∈ S)
    (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F))
    (hunit : (unit : AdjoinRoot F) = AdjoinRoot.mk F phi)
    (compatible : ∀ a : K, E (algebraMap K (AdjoinRoot F) a) =
      algebraMap K (AdjoinRoot F) (D a)) (n : ℕ) :
    functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
      (E (AdjoinRoot.root F)) n ∈ S := by
  classical
  rw [split_actual_source_derivative_moment D F hsep node hinj leading hleading
    hfactor E compatible phi unit hunit n]
  apply S.sum_mem
  intro i _
  rw [div_eq_mul_inv]
  exact S.mul_mem (S.pow_mem (hD _ (hnodes i)) n) (hInv i)

end Litt3.CartierAndSpin
