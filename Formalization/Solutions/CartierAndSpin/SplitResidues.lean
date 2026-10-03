import Theorems.CartierAndSpin.SplitResidues
import Mathlib.Tactic.Ring
import Mathlib.Algebra.CharP.Defs

/-!
# Low-degree split trace interpolation

The residue-weight identity is derived from Lagrange interpolation, rather than
accepted as a residue theorem. It works in every characteristic and for every
degree. Source-algebra identification and base-field descent remain separate
bridges to the canonical source trace statements.
-/

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {K ι : Type*} [Field K]

open scoped Classical in
theorem coefficient_eq_sum_eval_mul_nodalWeight (s : Finset ι) (node : ι → K)
    (P : K[X]) (hinj : Set.InjOn node s) (hdegree : P.degree < s.card) :
    P.coeff (s.card - 1) =
      ∑ i ∈ s, P.eval (node i) * Lagrange.nodalWeight s node i := by
  classical
  rw (occs := [1]) [← Lagrange.interpolate_poly_eq_self hinj hdegree]
  rw [Lagrange.interpolate_apply, Polynomial.finset_sum_coeff]
  apply sum_congr rfl
  intro i hi
  rw [Polynomial.coeff_C_mul, ← Lagrange.natDegree_basis hinj hi,
    ← Polynomial.leadingCoeff, Lagrange.leadingCoeff_basis hinj hi]
  simp [Lagrange.nodalWeight, prod_inv_distrib]

theorem splitPolynomialResidueSum_nodal_eq_coefficient
    (s : Finset ι) (node : ι → K) (P : K[X])
    (hinj : Set.InjOn node s) (hdegree : P.degree < s.card) :
    splitPolynomialResidueSum s node P (Lagrange.nodal s node) =
      P.coeff (s.card - 1) := by
  classical
  rw [coefficient_eq_sum_eval_mul_nodalWeight s node P hinj hdegree]
  unfold splitPolynomialResidueSum
  apply sum_congr rfl
  intro i hi
  rw [Lagrange.nodalWeight_eq_eval_derivative_nodal hi]
  exact div_eq_mul_inv _ _

theorem splitPolynomialResidueSum_scale (s : Finset ι) (node : ι → K)
    (P F : K[X]) (c : K) :
    splitPolynomialResidueSum s node P (C c * F) =
      c⁻¹ * splitPolynomialResidueSum s node P F := by
  classical
  unfold splitPolynomialResidueSum
  rw [mul_sum]
  apply sum_congr rfl
  intro i hi
  simp only [Polynomial.derivative_mul, Polynomial.derivative_C, zero_mul, zero_add,
    Polynomial.eval_mul, Polynomial.eval_C, div_eq_mul_inv, mul_inv_rev]
  ring

theorem splitPolynomialLowResidueVanishing (s : Finset ι) (node : ι → K)
    (P : K[X]) (c : K) :
    Specifications.SplitPolynomialLowResidueVanishing s node P c := by
  intro hinj hdegree
  have hdegree' : P.degree < (s.card : WithBot ℕ) := hdegree.trans_le (by
    simp only [Nat.cast_le]
    exact Nat.sub_le s.card 1)
  rw [splitPolynomialResidueSum_scale,
    splitPolynomialResidueSum_nodal_eq_coefficient s node P hinj hdegree',
    Polynomial.coeff_eq_zero_of_degree_lt hdegree, mul_zero]

theorem derivative_nodal_eval_ne_zero (s : Finset ι) (node : ι → K)
    (hinj : Set.InjOn node s) (i : ι) (hi : i ∈ s) :
    (Lagrange.nodal s node).derivative.eval (node i) ≠ 0 := by
  classical
  have h := Lagrange.nodalWeight_ne_zero hinj hi
  rw [Lagrange.nodalWeight_eq_eval_derivative_nodal hi] at h
  exact fun hz => h (by rw [hz, inv_zero])

/-- Low weighted source-root moments are zero without a residue-reciprocity
assumption. The polynomial numerator bound is kept explicit, permitting an
arbitrary inseparable factor `phi`, arbitrary degree and disconnected sources. -/
theorem split_source_weighted_moment_zero (s : Finset ι) (node : ι → K)
    (hinj : Set.InjOn node s) (F phi H : K[X]) (c tau : K) (hc : c ≠ 0)
    (hFsplit : F = C c * Lagrange.nodal s node)
    (hFsource : F = phi * H + C tau) (hphi : phi.derivative = 0)
    (j : ℕ) (hdegree : (X ^ j * H.derivative).degree < ↑(s.card - 1)) :
    (∑ i ∈ s, (node i) ^ j / phi.eval (node i)) = 0 := by
  classical
  have hderivative : F.derivative = phi * H.derivative := by
    rw [hFsource, Polynomial.derivative_add, Polynomial.derivative_mul,
      Polynomial.derivative_C, hphi, zero_mul, zero_add, add_zero]
  have hsum : (∑ i ∈ s, (node i) ^ j / phi.eval (node i)) =
      splitPolynomialResidueSum s node (X ^ j * H.derivative) F := by
    unfold splitPolynomialResidueSum
    apply sum_congr rfl
    intro i hi
    have hnonzero : F.derivative.eval (node i) ≠ 0 := by
      rw [hFsplit]
      simp only [Polynomial.derivative_mul, Polynomial.derivative_C, zero_mul,
        zero_add, Polynomial.eval_mul, Polynomial.eval_C]
      exact mul_ne_zero hc (derivative_nodal_eval_ne_zero s node hinj i hi)
    have hH : H.derivative.eval (node i) ≠ 0 := by
      rw [hderivative, Polynomial.eval_mul] at hnonzero
      exact (mul_ne_zero_iff.mp hnonzero).2
    rw [hderivative]
    simp only [Polynomial.eval_mul, Polynomial.eval_pow, Polynomial.eval_X]
    exact (mul_div_mul_right _ _ hH).symm
  rw [hsum, hFsplit]
  exact splitPolynomialLowResidueVanishing s node (X ^ j * H.derivative) c hinj hdegree

theorem inseparableSourceFactor_derivative (p : ℕ) [CharP K p] (q : K) :
    (X ^ p + C q : K[X]).derivative = 0 := by
  simp [Polynomial.derivative_X_pow, CharP.cast_eq_zero]

/-- The source presentation supplies the low residue numerator degree
automatically, independently of the source degree and characteristic. -/
theorem source_low_moment_numerator_degree (F H : K[X]) (p : ℕ) (q tau : K)
    (hp : 0 < p) (hH : H ≠ 0) (hsource : F = (X ^ p + C q) * H + C tau)
    (j : ℕ) (hj : j < p) :
    (X ^ j * H.derivative).degree < ↑(F.natDegree - 1) := by
  have hproduct : 0 < ((X ^ p + C q) * H).degree := by
    rw [Polynomial.degree_mul, Polynomial.degree_X_pow_add_C hp,
      Polynomial.degree_eq_natDegree hH]
    exact_mod_cast (show 0 < p + H.natDegree by omega)
  have hdegree : F.degree = ↑(p + H.natDegree) := by
    rw [hsource, Polynomial.degree_add_C hproduct, Polynomial.degree_mul,
      Polynomial.degree_X_pow_add_C hp, Polynomial.degree_eq_natDegree hH]
    exact_mod_cast rfl
  have hnat : F.natDegree = p + H.natDegree :=
    Polynomial.natDegree_eq_of_degree_eq_some hdegree
  by_cases hderivative : H.derivative = 0
  · simp [hderivative]
  · have hpositive : H.natDegree ≠ 0 := by
      intro hz
      exact hderivative (Polynomial.derivative_of_natDegree_zero hz)
    have hlower := Polynomial.natDegree_derivative_lt hpositive
    have hnumdegree : (X ^ j * H.derivative).degree = ↑(j + H.derivative.natDegree) := by
      rw [Polynomial.degree_mul, Polynomial.degree_X_pow,
        Polynomial.degree_eq_natDegree hderivative]
      exact_mod_cast rfl
    rw [hnumdegree, hnat]
    exact_mod_cast (show j + H.derivative.natDegree < p + H.natDegree - 1 by omega)

/-- First coefficient-moment family for the full characteristic-p source
presentation, proved for its actual split roots in every source degree. -/
theorem split_inseparable_source_moment_zero (s : Finset ι) (node : ι → K)
    (hinj : Set.InjOn node s) (F H : K[X]) (p : ℕ) [CharP K p]
    (q tau c : K) (hp : 0 < p) (hH : H ≠ 0) (hc : c ≠ 0)
    (hFsplit : F = C c * Lagrange.nodal s node)
    (hFsource : F = (X ^ p + C q) * H + C tau) (j : ℕ) (hj : j < p) :
    (∑ i ∈ s, (node i) ^ j / ((node i) ^ p + q)) = 0 := by
  have hdegree := source_low_moment_numerator_degree F H p q tau hp hH hFsource j hj
  have hnat : F.natDegree = s.card := by
    rw [hFsplit, Polynomial.natDegree_C_mul hc, Lagrange.natDegree_nodal]
  rw [hnat] at hdegree
  have hsum := split_source_weighted_moment_zero s node hinj F (X ^ p + C q) H c tau hc
    hFsplit hFsource (inseparableSourceFactor_derivative p q) j hdegree
  simpa only [Polynomial.eval_add, Polynomial.eval_pow, Polynomial.eval_X,
    Polynomial.eval_C] using hsum

end Litt3.CartierAndSpin
