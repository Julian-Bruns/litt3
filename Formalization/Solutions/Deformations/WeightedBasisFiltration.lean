import Theorems.Deformations.WeightedBasisFiltration
import Solutions.Deformations.FiltrationWidth

namespace Litt3.Deformations

open Module

variable {k V ι : Type*} [DivisionRing k] [AddCommGroup V] [Module k V]

theorem weighted_basis_filtration_antitone (basis : Basis ι k V) (weight : ι → ℕ) :
    Antitone (weightedBasisFiltration basis weight) := by
  intro i j hij
  apply Submodule.span_mono
  rintro v ⟨a, ha, rfl⟩
  exact ⟨a, hij.trans ha, rfl⟩

theorem weighted_basis_filtration_finrank [Fintype ι]
    (basis : Basis ι k V) (weight : ι → ℕ) (n : ℕ) :
    Module.finrank k (weightedBasisFiltration basis weight n) =
      Fintype.card {j : ι // n ≤ weight j} := by
  classical
  have hset : basis '' {j | n ≤ weight j} =
      Set.range (fun j : {j : ι // n ≤ weight j} => basis j.val) := by
    apply Set.ext
    intro v
    constructor
    · rintro ⟨j, hj, rfl⟩
      exact ⟨⟨j, hj⟩, rfl⟩
    · rintro ⟨j, rfl⟩
      exact ⟨j.val, j.property, rfl⟩
  unfold weightedBasisFiltration
  rw [hset]
  exact finrank_span_eq_card (basis.linearIndependent.comp _ Subtype.val_injective)

/-- The weight-at-least-n indices split into weight-n indices and
weight-at-least-n+1 indices. -/
def weightedIndexSplit (weight : ι → ℕ) (n : ℕ) :
    {j : ι // n ≤ weight j} ≃
      {j : ι // weight j = n} ⊕ {j : ι // n + 1 ≤ weight j} where
  toFun j := if h : weight j.val = n then Sum.inl ⟨j.val, h⟩
    else Sum.inr ⟨j.val, by have := j.property; omega⟩
  invFun j := match j with
    | Sum.inl a => ⟨a.val, a.property.ge⟩
    | Sum.inr a => ⟨a.val, (Nat.le_succ _).trans a.property⟩
  left_inv j := by
    dsimp
    split_ifs <;> rfl
  right_inv j := by
    cases j with
    | inl a => simp [a.property]
    | inr a =>
      have h : weight a.val ≠ n := by have := a.property; omega
      simp [h]

@[simp] theorem weightedBasisHilbertPolynomial_coeff [Fintype ι]
    (weight : ι → ℕ) (n : ℕ) :
    (weightedBasisHilbertPolynomial weight).coeff n =
      Fintype.card {j : ι // weight j = n} := by
  classical
  simp [weightedBasisHilbertPolynomial, Polynomial.finset_sum_coeff,
    Polynomial.coeff_X_pow, Fintype.card_subtype, eq_comm]

/-- Actual quotient dimensions are exact coefficient counts. No
associated graded rank is inferred merely from a computed table. -/
theorem weighted_basis_hilbert_dimensions [Fintype ι] [FiniteDimensional k V]
    (basis : Basis ι k V) (weight : ι → ℕ) :
    Specifications.WeightedBasisHilbertDimensions basis weight := by
  intro n
  rw [filtration_layer_finrank _
    (fun i => weighted_basis_filtration_antitone basis weight (Nat.le_succ i)),
    weighted_basis_filtration_finrank, weighted_basis_filtration_finrank,
    weightedBasisHilbertPolynomial_coeff]
  have hcard := Fintype.card_congr (weightedIndexSplit weight n)
  rw [Fintype.card_sum] at hcard
  omega

end Litt3.Deformations
