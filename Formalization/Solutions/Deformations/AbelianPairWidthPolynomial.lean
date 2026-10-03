import Theorems.Deformations.AbelianPairWidthPolynomial
import Solutions.Deformations.HilbertCoefficients
import Lean.Elab.Tactic.Omega

namespace Litt3.Deformations

open Polynomial Finset

/-- Every coefficient is counted by an actual interval of
possible first exponents, uniformly including q=0. -/
theorem interval_squared_coefficient (q n : ℕ) :
    (intervalPolynomial q ^ 2).coeff n = min q (n + 1) - (n + 1 - q) := by
  rw [pow_two, coeff_mul, Finset.Nat.sum_antidiagonal_eq_sum_range_succ
    (fun i j => (intervalPolynomial q).coeff i * (intervalPolynomial q).coeff j) n]
  have terms : ∀ i ∈ range (n + 1),
      (intervalPolynomial q).coeff i * (intervalPolynomial q).coeff (n - i) =
        if n + 1 - q ≤ i ∧ i < q then 1 else 0 := by
    intro i hi
    have bound := mem_range.mp hi
    rw [intervalPolynomial_coeff, intervalPolynomial_coeff]
    split_ifs <;> omega
  have sum_eq : (∑ i ∈ range (n + 1),
      (intervalPolynomial q).coeff i * (intervalPolynomial q).coeff (n - i)) =
      ((range (n + 1)).filter (fun i => n + 1 - q ≤ i ∧ i < q)).card := by
    calc
      _ = ∑ i ∈ range (n + 1), if n + 1 - q ≤ i ∧ i < q then (1 : ℕ) else 0 :=
        Finset.sum_congr rfl terms
      _ = _ := by simp
  rw [sum_eq]
  have set_eq : (range (n + 1)).filter (fun i => n + 1 - q ≤ i ∧ i < q) =
      Ico (n + 1 - q) (min q (n + 1)) := by
    ext i
    simp only [mem_filter, mem_range, mem_Ico, lt_min_iff]
    omega
  rw [set_eq, Nat.card_Ico]

/-- Exact attained adjacent maximum for every positive q,
using symbolic coefficient formulas and no finite enumeration. -/
theorem abelian_pair_adjacent_hilbert_maximum (q : ℕ) (positive : 0 < q) :
    Specifications.AbelianPairAdjacentHilbertMaximum q := by
  constructor
  · intro n
    rw [interval_squared_coefficient, interval_squared_coefficient]
    omega
  · rw [interval_squared_coefficient, interval_squared_coefficient]
    omega

end Litt3.Deformations
