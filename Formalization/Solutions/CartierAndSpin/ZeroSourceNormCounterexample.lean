import Mathlib.RingTheory.Norm.Basic
import Mathlib.RingTheory.AdjoinRoot
import Mathlib.FieldTheory.Separable
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The literal degree-zero source polynomial gives the zero quotient. -/
theorem constant_one_source_zero_eq_one :
    (0 : AdjoinRoot (1 : K[X])) = 1 := by
  have h : AdjoinRoot.mk (1 : K[X]) 1 = 0 :=
    AdjoinRoot.mk_eq_zero.mpr (dvd_refl _)
  simpa only [map_one] using h.symm

/-- Its determinant norm is one, including for the element f + W^p. -/
theorem constant_one_source_norm (f : K) (p : ℕ) :
    Algebra.norm K
      ((AdjoinRoot.root (1 : K[X])) ^ p +
        algebraMap K (AdjoinRoot (1 : K[X])) f) = 1 := by
  haveI : Subsingleton (AdjoinRoot (1 : K[X])) :=
    subsingleton_of_zero_eq_one constant_one_source_zero_eq_one
  rw [Subsingleton.elim
    ((AdjoinRoot.root (1 : K[X])) ^ p +
      algebraMap K (AdjoinRoot (1 : K[X])) f) 1, map_one]

/-- The nonzero p-th-power norm does not force degree at least p for
a separable finite source algebra unless positive degree is required. -/
theorem zero_source_norm_degree_counterexample (f : K) (p : ℕ) (hp : 0 < p) :
    (1 : K[X]).Monic ∧ (1 : K[X]).Separable ∧
      (∃ a : K, a ≠ 0 ∧ Algebra.norm K
        ((AdjoinRoot.root (1 : K[X])) ^ p +
          algebraMap K (AdjoinRoot (1 : K[X])) f) = a ^ p) ∧
      ¬p ≤ (1 : K[X]).natDegree := by
  refine ⟨monic_one, separable_one, ⟨1, one_ne_zero, ?_⟩, ?_⟩
  · rw [constant_one_source_norm, one_pow]
  · simpa using (not_le_of_gt hp)

end Litt3.CartierAndSpin
