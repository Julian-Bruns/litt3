import Solutions.SharedTensors.SplitPolynomialPoleBounds
import Solutions.SharedTensors.DivisorSectionOrders

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.CartierAndSpin Polynomial Finset
open scoped WithZero

variable {K L ι : Type*} [Field K] [Field L] [Fintype ι]

/-- Genuine local-sheet values bound every coefficient after an actual
field embedding. This uses the actual complete factorization, retaining
all sheets; it does not posit a Galois closure. -/
theorem actual_local_sheet_coefficient_pole_bound
    (v : Valuation K ℤᵐ⁰) (w : Valuation L ℤᵐ⁰) (φ : K →+* L)
    (hw : ∀ a, w (φ a) = v a) (P : K[X]) (u : ι → L)
    (hfactor : P.map φ = finiteRootPolynomial u)
    (H : ι → ℤ) (hH : ∀ i, 0 ≤ H i)
    (hpoles : ∀ i, w (u i) ≤ WithZero.exp (H i)) (j : ℕ) :
    v (P.coeff j) ≤ WithZero.exp (∑ i, H i) := by
  classical
  have hcoeff := monic_split_polynomial_coeff_valuation_le_total_root_poles w
    (finiteRootPolynomial u) (finiteRootPolynomial_monic u)
    (by
      classical
      unfold finiteRootPolynomial
      exact Polynomial.Splits.prod (fun i _ => Polynomial.Splits.X_sub_C _)) j
  have hroot : (finiteRootPolynomial u).roots = univ.val.map u := by
    classical
    unfold finiteRootPolynomial
    rw [prod_eq_multiset_prod]
    simpa only [Multiset.map_map, Function.comp_def] using
      Polynomial.roots_multiset_prod_X_sub_C (univ.val.map u)
  rw [hroot, Multiset.map_map, ← prod_eq_multiset_prod] at hcoeff
  have hb : (∏ i, max 1 (w (u i))) ≤ ∏ i, WithZero.exp (H i) := by
    apply Finset.prod_le_prod'
    intro i _
    apply max_le
    · rw [← WithZero.exp_zero]
      exact WithZero.exp_le_exp.mpr (hH i)
    · exact hpoles i
  have hexp : (∏ i, WithZero.exp (H i)) = WithZero.exp (∑ i, H i) := by
    induction (univ : Finset ι) using Finset.induction_on with
    | empty => simp
    | @insert i s hi ih => rw [prod_insert hi, sum_insert hi, ih, WithZero.exp_add]
  have hmap : w ((P.map φ).coeff j) = v (P.coeff j) := by
    rw [coeff_map, hw]
  rw [← hmap, hfactor]
  exact hcoeff.trans (hb.trans_eq hexp)

end Litt3.SharedTensors
