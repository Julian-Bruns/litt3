import Definitions.CartierAndSpin.IntegralSplitOrder
import Mathlib.LinearAlgebra.Lagrange

namespace Litt3.CartierAndSpin

open Finset Polynomial Classical

variable {R ι : Type*} [CommRing R] [IsDomain R] [Fintype ι]

/-- Exact polynomial kernel of evaluation at an actual distinct integral
root family. Monic remainder division stays in the original ring. -/
theorem finiteRootPolynomial_dvd_iff_eval_zero (w : ι → R)
    (hinjective : Function.Injective w) (Q : R[X]) :
    finiteRootPolynomial w ∣ Q ↔ ∀ i, Q.eval (w i) = 0 := by
  constructor
  · rintro ⟨H, rfl⟩ i
    rw [eval_mul, finiteRootPolynomial_eval_at_member, zero_mul]
  · intro hzero
    apply (modByMonic_eq_zero_iff_dvd (finiteRootPolynomial_monic w)).mp
    apply eq_zero_of_degree_lt_of_eval_index_eq_zero univ hinjective.injOn
    · have hdegree := degree_modByMonic_lt Q (finiteRootPolynomial_monic w)
      simpa only [degree_eq_natDegree (finiteRootPolynomial_monic w).ne_zero,
        finiteRootPolynomial_natDegree, card_univ] using hdegree
    · intro i hi
      have hroot : (finiteRootPolynomial w).eval₂ (RingHom.id R) (w i) = 0 := by
        simpa only [eval₂_id] using finiteRootPolynomial_eval_at_member w i
      have h := eval₂_modByMonic_eq_self_of_root (p := Q)
        (finiteRootPolynomial_monic w) hroot
      simpa only [eval₂_id, hzero i] using h

omit [IsDomain R] in
@[simp]
theorem integralSplitQuotientMap_mk (w : ι → R) (Q : R[X]) :
    integralSplitQuotientMap w (AdjoinRoot.mk (finiteRootPolynomial w) Q) = aeval w Q := by
  rfl

/-- Faithful embedding of the genuine quotient order into R^iota. -/
theorem integralSplitQuotientMap_injective (w : ι → R)
    (hinjective : Function.Injective w) : Function.Injective (integralSplitQuotientMap w) := by
  intro x y hxy
  obtain ⟨Q, rfl⟩ := AdjoinRoot.mk_surjective x
  obtain ⟨H, rfl⟩ := AdjoinRoot.mk_surjective y
  apply AdjoinRoot.mk_eq_mk.mpr
  apply (finiteRootPolynomial_dvd_iff_eval_zero w hinjective (Q - H)).mpr
  intro i
  have heval := congrFun hxy i
  simp only [integralSplitQuotientMap_mk, aeval_fn_apply, aeval_def,
    Algebra.algebraMap_self, eval₂_id] at heval
  rw [eval_sub, heval, sub_self]

omit [IsDomain R] in
/-- The actual quotient embedding has exactly the singly generated order
as its image, the order used by Mathlib's actual conductor ideal. -/
theorem integralSplitQuotientMap_range (w : ι → R) :
    (integralSplitQuotientMap w).range = Algebra.adjoin R {w} := by
  ext z
  constructor
  · rintro ⟨x, rfl⟩
    obtain ⟨Q, rfl⟩ := AdjoinRoot.mk_surjective x
    change integralSplitQuotientMap w (AdjoinRoot.mk (finiteRootPolynomial w) Q) ∈ _
    rw [integralSplitQuotientMap_mk]
    exact aeval_mem_adjoin_singleton R w
  · intro hz
    obtain ⟨Q, hQ⟩ := Algebra.adjoin_mem_exists_aeval R w hz
    refine ⟨AdjoinRoot.mk (finiteRootPolynomial w) Q, ?_⟩
    change integralSplitQuotientMap w (AdjoinRoot.mk (finiteRootPolynomial w) Q) = z
    rw [integralSplitQuotientMap_mk, hQ]

end Litt3.CartierAndSpin
