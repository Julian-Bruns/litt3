import Theorems.Deformations.AffineFrobenius
import Mathlib.Tactic.Abel
import Mathlib.Algebra.CharP.Basic

namespace Litt3.Deformations

open Polynomial

variable {k : Type*} [Field k]

theorem affineFrobeniusPolynomial_natDegree (q : ℕ) (hq : 1 < q)
    (translation : k) :
    (affineFrobeniusPolynomial q translation).natDegree = q := by
  have hfirst : (X ^ q - X : Polynomial k).natDegree = q := by
    have hlt : (X : Polynomial k).natDegree < (X ^ q : Polynomial k).natDegree :=
      by simpa using hq
    simpa using natDegree_sub_eq_left_of_natDegree_lt hlt
  unfold affineFrobeniusPolynomial
  rw [natDegree_sub_eq_left_of_natDegree_lt]
  · exact hfirst
  · rw [hfirst, natDegree_C]
    exact Nat.zero_lt_of_lt hq

theorem affineFrobeniusPolynomial_ne_zero (q : ℕ) (hq : 1 < q)
    (translation : k) : affineFrobeniusPolynomial q translation ≠ 0 := by
  intro h
  have H := affineFrobeniusPolynomial_natDegree q hq translation
  rw [h, natDegree_zero] at H
  exact (Nat.ne_of_gt (Nat.zero_lt_of_lt hq)) H.symm

theorem affineFrobeniusPolynomial_derivative (q : ℕ)
    (q_cast_zero : (q : k) = 0) (translation : k) :
    derivative (affineFrobeniusPolynomial q translation) = -1 := by
  simp [affineFrobeniusPolynomial, derivative_sub, derivative_X_pow, q_cast_zero]

theorem affineFrobeniusPolynomial_separable (q : ℕ)
    (q_cast_zero : (q : k) = 0) (translation : k) :
    (affineFrobeniusPolynomial q translation).Separable := by
  rw [separable_def', affineFrobeniusPolynomial_derivative q q_cast_zero]
  exact ⟨0, -1, by simp⟩

section AlgebraicallyClosed

variable [IsAlgClosed k]

/-- Every scalar affine Frobenius equation has exactly `q` distinct
solutions. This is a symbolic separable-polynomial argument. -/
theorem scalar_frobenius_solution_count (q : ℕ) (hq : 1 < q)
    (q_cast_zero : (q : k) = 0) (translation : k) :
    Nat.card (ScalarFrobeniusSolutions q translation) = q := by
  classical
  let polynomial := affineFrobeniusPolynomial q translation
  have hp : polynomial ≠ 0 := affineFrobeniusPolynomial_ne_zero q hq translation
  have hs : polynomial.Separable :=
    affineFrobeniusPolynomial_separable q q_cast_zero translation
  let e : ScalarFrobeniusSolutions q translation ≃
      {x : k // x ∈ polynomial.roots.toFinset} :=
    Equiv.subtypeEquivRight (fun x => by
      rw [Multiset.mem_toFinset, Polynomial.mem_roots hp]
      simp only [polynomial, Polynomial.IsRoot, affineFrobeniusPolynomial,
        eval_sub, eval_pow, eval_X, eval_C, sub_eq_zero])
  calc
    Nat.card (ScalarFrobeniusSolutions q translation) =
        Nat.card {x : k // x ∈ polynomial.roots.toFinset} := Nat.card_congr e
    _ = polynomial.roots.toFinset.card := Nat.card_eq_finsetCard _
    _ = polynomial.roots.card :=
      Multiset.toFinset_card_of_nodup (Polynomial.nodup_roots hs)
    _ = polynomial.natDegree := IsAlgClosed.card_roots_eq_natDegree
    _ = q := affineFrobeniusPolynomial_natDegree q hq translation

theorem scalar_frobenius_solvable (q : ℕ) (hq : 1 < q)
    (q_cast_zero : (q : k) = 0) (translation : k) :
    Nonempty (ScalarFrobeniusSolutions q translation) := by
  apply Nat.card_pos_iff.mp _ |>.1
  rw [scalar_frobenius_solution_count q hq q_cast_zero]
  exact Nat.zero_lt_of_lt hq

/-- The actual coordinate solution set is a product of the scalar
solution sets, at every affine translation. -/
def coordinateFrobeniusEquiv (q d : ℕ) (translation : Fin d → k) :
    CoordinateFrobeniusSolutions q d translation ≃
      ∀ i : Fin d, ScalarFrobeniusSolutions q (translation i) :=
  Equiv.subtypePiEquivPi (β := fun _ : Fin d => k)
    (p := fun i x => x ^ q - x = translation i)

theorem coordinate_frobenius_solution_count (q d : ℕ) (hq : 1 < q)
    (q_cast_zero : (q : k) = 0) (translation : Fin d → k) :
    Nat.card (CoordinateFrobeniusSolutions q d translation) = q ^ d := by
  rw [Nat.card_congr (coordinateFrobeniusEquiv q d translation), Nat.card_pi]
  simp_rw [scalar_frobenius_solution_count q hq q_cast_zero]
  simp

/-- Both existence and the exact `q^d` count hold in every dimension,
with no bounded-coordinate calculation or nonlinear rank surrogate. -/
theorem affine_frobenius_count (q d : ℕ) (hq : 1 < q)
    (q_cast_zero : (q : k) = 0) :
    Specifications.AffineFrobeniusCount (k := k) q d := by
  intro translation
  have hc := coordinate_frobenius_solution_count q d hq q_cast_zero translation
  refine ⟨?_, hc⟩
  apply Nat.card_pos_iff.mp _ |>.1
  rw [hc]
  exact Nat.pow_pos (Nat.zero_lt_of_lt hq)

/-- The sign in the source affine action is retained exactly. -/
def affineFrobeniusFixedPointEquiv (q d : ℕ) (translation : Fin d → k) :
    AffineFrobeniusFixedPoints q d translation ≃
      CoordinateFrobeniusSolutions q d (fun i => -translation i) :=
  Equiv.subtypeEquivRight (fun x => by
    constructor
    · intro h i
      have hi : x i ^ q = x i - translation i := by
        apply eq_sub_of_add_eq
        simpa only [add_comm] using h i
      rw [hi]
      abel_nf
    · intro h i
      have hi : x i ^ q = -translation i + x i :=
        sub_eq_iff_eq_add.mp (h i)
      rw [hi]
      abel_nf)

theorem affine_frobenius_fixed_point_count (q d : ℕ) (hq : 1 < q)
    (q_cast_zero : (q : k) = 0) (translation : Fin d → k) :
    Nonempty (AffineFrobeniusFixedPoints q d translation) ∧
      Nat.card (AffineFrobeniusFixedPoints q d translation) = q ^ d := by
  have hcoord := affine_frobenius_count (k := k) q d hq q_cast_zero
    (fun i => -translation i)
  refine ⟨?_, ?_⟩
  · obtain ⟨x⟩ := hcoord.1
    exact ⟨(affineFrobeniusFixedPointEquiv q d translation).symm x⟩
  · rw [Nat.card_congr (affineFrobeniusFixedPointEquiv q d translation)]
    exact hcoord.2

/-- Prime-power Frobenius specialization, with arbitrary positive
exponent and coordinate dimension. -/
theorem prime_power_affine_frobenius_count (p : ℕ) [Fact p.Prime]
    [CharP k p] (a d : ℕ) (ha : 0 < a) (translation : Fin d → k) :
    Nonempty (AffineFrobeniusFixedPoints (p ^ a) d translation) ∧
      Nat.card (AffineFrobeniusFixedPoints (p ^ a) d translation) = (p ^ a) ^ d := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  have hq : 1 < p ^ a := Nat.one_lt_pow ha.ne' hp
  have hqcast : ((p ^ a : ℕ) : k) = 0 := by
    rw [Nat.cast_pow, CharP.cast_eq_zero]
    exact zero_pow ha.ne'
  exact affine_frobenius_fixed_point_count (p ^ a) d hq hqcast translation

end AlgebraicallyClosed

end Litt3.Deformations
