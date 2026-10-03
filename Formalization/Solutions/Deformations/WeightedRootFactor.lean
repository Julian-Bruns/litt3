import Mathlib.RingTheory.AdjoinRoot
import Mathlib.Algebra.Polynomial.Monic
import Mathlib.LinearAlgebra.Basis.Basic
import Mathlib.Tactic

namespace Litt3.Deformations

open Polynomial

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- A literal one-coordinate factor of the untruncated graded algebra. -/
noncomputable def weightedRootRelation (q : ℕ) (tau : R) : R[X] := X ^ q + C tau * X

abbrev WeightedRootFactor (R : Type*) [CommRing R] (q : ℕ) (tau : R) :=
  AdjoinRoot (weightedRootRelation q tau)

theorem weighted_root_relation_degree (q : ℕ) (large : 1 < q) (tau : R) :
    (weightedRootRelation q tau).natDegree = q := by
  have low : (C tau * (X : R[X])).natDegree ≤ 1 := by
    simpa using (natDegree_mul_le (p := C tau) (q := (X : R[X])))
  rw [weightedRootRelation, natDegree_add_eq_left_of_natDegree_lt, natDegree_X_pow]
  rw [natDegree_X_pow]
  exact low.trans_lt large

theorem weighted_root_relation_monic (q : ℕ) (large : 1 < q) (tau : R) :
    (weightedRootRelation q tau).Monic := by
  apply (monic_X_pow q).add_of_left
  apply degree_lt_degree
  have low : (C tau * (X : R[X])).natDegree ≤ 1 := by
    simpa using (natDegree_mul_le (p := C tau) (q := (X : R[X])))
  rw [natDegree_X_pow]
  exact low.trans_lt large

/-- Actual normal powers form a basis of the actual one-coordinate
graded quotient over an arbitrary nontrivial commutative base ring. -/
noncomputable def weightedRootFactorBasis (q : ℕ) (large : 1 < q) (tau : R) :
    Module.Basis (Fin q) R (WeightedRootFactor R q tau) :=
  (AdjoinRoot.powerBasis' (weighted_root_relation_monic q large tau)).basis.reindex
    (finCongr (weighted_root_relation_degree q large tau))

@[simp] theorem weighted_root_factor_basis_apply (q : ℕ) (large : 1 < q) (tau : R) (i : Fin q) :
    weightedRootFactorBasis q large tau i =
      AdjoinRoot.root (weightedRootRelation q tau) ^ i.val := by
  rw [weightedRootFactorBasis, Module.Basis.reindex_apply,
    (AdjoinRoot.powerBasis' (weighted_root_relation_monic q large tau)).basis_eq_pow]
  rfl

theorem weighted_root_factor_relation (q : ℕ) (tau : R) :
    AdjoinRoot.root (weightedRootRelation q tau) ^ q =
      -algebraMap R (WeightedRootFactor R q tau) tau * AdjoinRoot.root (weightedRootRelation q tau) := by
  have root := AdjoinRoot.eval₂_root (weightedRootRelation q tau)
  simp only [weightedRootRelation, eval₂_add, eval₂_pow, eval₂_X, eval₂_mul, eval₂_C] at root
  change _ + algebraMap R (WeightedRootFactor R q tau) tau * _ = 0 at root
  simpa only [weightedRootRelation, neg_mul] using eq_neg_of_add_eq_zero_left root

end Litt3.Deformations
