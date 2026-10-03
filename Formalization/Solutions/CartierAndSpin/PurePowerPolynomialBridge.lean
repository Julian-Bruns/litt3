import Solutions.CartierAndSpin.PurePowerReduction
import Mathlib.Algebra.MvPolynomial.Degrees
import Mathlib.Algebra.MvPolynomial.Eval
import Mathlib.Data.Fin.VecNotation

/-!
# Bivariate polynomial bridge for pure-power reductions

The lower-total-degree hypotheses are actual multivariate polynomial degrees.
Independent leading forms supply the reduction relations by a symbolic
two-by-two elimination, with no finite-field coefficient census.
-/

namespace Litt3.CartierAndSpin

section Semiring

variable {K A : Type*} [CommSemiring K] [CommSemiring A] [Algebra K A]

theorem aeval_mem_lowerMonomialSpan (x y : A) (m : ℕ)
    (P : MvPolynomial (Fin 2) K) (hdeg : P.totalDegree < m) :
    MvPolynomial.aeval ![x, y] P ∈ lowerMonomialSpan (K := K) x y m := by
  classical
  rw [P.as_sum, map_sum]
  apply Submodule.sum_mem
  intro d hd
  rw [MvPolynomial.aeval_monomial]
  have hsum : d.sum (fun _ n => n) = d 0 + d 1 := by
    rw [Finsupp.sum_fintype _ _ (by intro i; rfl)]
    simp only [Fin.sum_univ_succ,
      Fin.succ_zero_eq_one, Fin.sum_univ_zero, add_zero]
  have htotal : d 0 + d 1 < m := by
    have h := (MvPolynomial.le_totalDegree hd).trans_lt hdeg
    rwa [hsum] at h
  have hprod : d.prod (fun i n => (![x, y] i) ^ n) = x ^ d 0 * y ^ d 1 := by
    rw [Finsupp.prod_fintype _ _ (by intro i; exact pow_zero _)]
    simp [Fin.prod_univ_succ]
  rw [hprod, ← Algebra.smul_def]
  apply Submodule.smul_mem
  exact Submodule.subset_span ⟨d 0, d 1, htotal, rfl⟩

end Semiring

section Field

variable {K A : Type*} [Field K] [CommRing A] [Algebra K A]

theorem purePowerReductions_of_independent_leading_forms
    (x y : A) (m : ℕ) (a b c d : K)
    (R S : MvPolynomial (Fin 2) K)
    (hR : R.totalDegree < m) (hS : S.totalDegree < m)
    (hdet : a * d - b * c ≠ 0)
    (hF : a • x ^ m + b • y ^ m + MvPolynomial.aeval ![x, y] R = 0)
    (hG : c • x ^ m + d • y ^ m + MvPolynomial.aeval ![x, y] S = 0) :
    PurePowerReductions (K := K) x y m := by
  let r : A := MvPolynomial.aeval ![x, y] R
  let s : A := MvPolynomial.aeval ![x, y] S
  have hr : r ∈ lowerMonomialSpan (K := K) x y m :=
    aeval_mem_lowerMonomialSpan x y m R hR
  have hs : s ∈ lowerMonomialSpan (K := K) x y m :=
    aeval_mem_lowerMonomialSpan x y m S hS
  have hx : (a * d - b * c) • x ^ m = b • s - d • r := by
    calc
      _ = d • (a • x ^ m + b • y ^ m + r) -
          b • (c • x ^ m + d • y ^ m + s) + b • s - d • r := by
        simp only [Algebra.smul_def, map_sub, map_mul]
        ring
      _ = _ := by rw [hF, hG]; simp
  have hy : (a * d - b * c) • y ^ m = c • r - a • s := by
    calc
      _ = a • (c • x ^ m + d • y ^ m + s) -
          c • (a • x ^ m + b • y ^ m + r) + c • r - a • s := by
        simp only [Algebra.smul_def, map_sub, map_mul]
        ring
      _ = _ := by rw [hF, hG]; simp
  constructor
  · have hmem : (a * d - b * c) • x ^ m ∈ lowerMonomialSpan (K := K) x y m := by
      rw [hx]
      exact Submodule.sub_mem _ (Submodule.smul_mem _ b hs) (Submodule.smul_mem _ d hr)
    have h := Submodule.smul_mem (lowerMonomialSpan (K := K) x y m)
      (a * d - b * c)⁻¹ hmem
    simpa only [smul_smul, inv_mul_cancel₀ hdet, one_smul] using h
  · have hmem : (a * d - b * c) • y ^ m ∈ lowerMonomialSpan (K := K) x y m := by
      rw [hy]
      exact Submodule.sub_mem _ (Submodule.smul_mem _ c hr) (Submodule.smul_mem _ a hs)
    have h := Submodule.smul_mem (lowerMonomialSpan (K := K) x y m)
      (a * d - b * c)⁻¹ hmem
    simpa only [smul_smul, inv_mul_cancel₀ hdet, one_smul] using h

theorem finrank_le_square_of_independent_leading_forms
    (x y : A) (m : ℕ) (a b c d : K)
    (R S : MvPolynomial (Fin 2) K)
    (hR : R.totalDegree < m) (hS : S.totalDegree < m)
    (hdet : a * d - b * c ≠ 0)
    (hF : a • x ^ m + b • y ^ m + MvPolynomial.aeval ![x, y] R = 0)
    (hG : c • x ^ m + d • y ^ m + MvPolynomial.aeval ![x, y] S = 0)
    (hgen : Algebra.adjoin K ({x, y} : Set A) = ⊤) :
    Module.finrank K A ≤ m ^ 2 := by
  exact finrank_le_square_of_purePowerReductions x y m
    (purePowerReductions_of_independent_leading_forms x y m a b c d R S hR hS hdet hF hG)
    hgen

end Field

end Litt3.CartierAndSpin
