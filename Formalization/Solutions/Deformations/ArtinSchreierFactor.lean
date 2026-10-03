import Definitions.Deformations.ArtinSchreierChart
import Mathlib.Algebra.Polynomial.Monic
import Mathlib.Tactic

namespace Litt3.Deformations

open Polynomial

variable {R : Type*} [CommRing R] [Nontrivial R]

theorem artin_schreier_relation_low_degree (a b : R) :
    (C a * (X : R[X]) + C b).natDegree ≤ 1 := by
  apply (natDegree_add_le _ _).trans
  apply max_le
  · simpa using (natDegree_mul_le (p := C a) (q := (X : R[X])))
  · simp

theorem artin_schreier_relation_degree (p : ℕ) (large : 1 < p) (a b : R) :
    (artinSchreierRelation p a b).natDegree = p := by
  rw [artinSchreierRelation, natDegree_sub_eq_left_of_natDegree_lt, natDegree_X_pow]
  rw [natDegree_X_pow]
  exact (artin_schreier_relation_low_degree a b).trans_lt large

theorem artin_schreier_relation_monic (p : ℕ) (large : 1 < p) (a b : R) :
    (artinSchreierRelation p a b).Monic := by
  apply (monic_X_pow p).sub_of_left
  apply degree_lt_degree
  rw [natDegree_X_pow]
  exact (artin_schreier_relation_low_degree a b).trans_lt large

noncomputable def artinSchreierFactorBasis (p : ℕ) (large : 1 < p) (a b : R) :
    Module.Basis (Fin p) R (ArtinSchreierFactor R p a b) :=
  (AdjoinRoot.powerBasis' (artin_schreier_relation_monic p large a b)).basis.reindex
    (finCongr (artin_schreier_relation_degree p large a b))

@[simp] theorem artin_schreier_factor_basis_apply (p : ℕ) (large : 1 < p) (a b : R) (i : Fin p) :
    artinSchreierFactorBasis p large a b i =
      AdjoinRoot.root (artinSchreierRelation p a b) ^ i.val := by
  rw [artinSchreierFactorBasis, Module.Basis.reindex_apply,
    (AdjoinRoot.powerBasis' (artin_schreier_relation_monic p large a b)).basis_eq_pow]
  rfl

omit [Nontrivial R] in
theorem artin_schreier_factor_relation (p : ℕ) (a b : R) :
    AdjoinRoot.root (artinSchreierRelation p a b) ^ p =
      algebraMap R (ArtinSchreierFactor R p a b) a *
        AdjoinRoot.root (artinSchreierRelation p a b) +
      algebraMap R (ArtinSchreierFactor R p a b) b := by
  have root := AdjoinRoot.eval₂_root (artinSchreierRelation p a b)
  simp only [artinSchreierRelation, eval₂_sub, eval₂_add, eval₂_pow, eval₂_X,
    eval₂_mul, eval₂_C] at root
  exact sub_eq_zero.mp root

end Litt3.Deformations
