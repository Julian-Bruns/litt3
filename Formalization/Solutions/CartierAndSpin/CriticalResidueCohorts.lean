import Solutions.CartierAndSpin.FiniteRootPolynomial
import Mathlib.Algebra.Polynomial.FieldDivision

namespace Litt3.CartierAndSpin

open Finset Polynomial Classical

variable {K ι : Type*} [Field K] [Fintype ι]

theorem finiteRootPolynomial_roots (w : ι → K) :
    (finiteRootPolynomial w).roots = univ.val.map w := by
  rw [finiteRootPolynomial, roots_prod _ _ (finiteRootPolynomial_monic w).ne_zero]
  simp

/-- The actual fiber cardinal of a reduced root family is the actual root
multiplicity, including repeated values. No separability is assumed here. -/
theorem finiteRootPolynomial_rootMultiplicity (w : ι → K) (c : K) :
    (finiteRootPolynomial w).rootMultiplicity c = (univ.filter fun i => w i = c).card := by
  rw [← count_roots, finiteRootPolynomial_roots, Multiset.count_map]
  simp only [eq_comm, ← Finset.filter_val, Finset.card_def]

theorem scalar_finiteRootPolynomial_rootMultiplicity (w : ι → K) (v c : K) (hv : v ≠ 0) :
    (C v * finiteRootPolynomial w).rootMultiplicity c =
      (univ.filter fun i => w i = c).card := by
  rw [← count_roots, roots_C_mul _ hv, count_roots, finiteRootPolynomial_rootMultiplicity]

/-- Derivative multiplicity bounds the actual residue fiber by deg(D)+1
when F'=phi*D and phi does not vanish there. This permits repeated critical
roots and does not require the leading coefficient of D to be a unit. -/
theorem critical_residue_cohort_card_le (w : ι → K) (v c : K) (F phi D : K[X])
    (hv : v ≠ 0) (hF : F = C v * finiteRootPolynomial w)
    (hderivative : F.derivative = phi * D) (hD : D ≠ 0) (hphi : phi.eval c ≠ 0) :
    (univ.filter fun i => w i = c).card ≤ D.natDegree + 1 := by
  have hphi_ne : phi ≠ 0 := by intro h; simp [h] at hphi
  have hderivative_ne : F.derivative ≠ 0 := by rw [hderivative]; exact mul_ne_zero hphi_ne hD
  have hphi_multiplicity : phi.rootMultiplicity c = 0 :=
    rootMultiplicity_eq_zero hphi
  have hderivative_multiplicity : F.derivative.rootMultiplicity c = D.rootMultiplicity c := by
    rw [hderivative, rootMultiplicity_mul (mul_ne_zero hphi_ne hD), hphi_multiplicity, zero_add]
  have hbound := rootMultiplicity_sub_one_le_derivative_rootMultiplicity_of_ne_zero
    F c hderivative_ne
  rw [hderivative_multiplicity, hF, scalar_finiteRootPolynomial_rootMultiplicity w v c hv] at hbound
  have hDdegree : D.rootMultiplicity c ≤ D.natDegree := by
    rw [← count_roots]
    exact (Multiset.count_le_card _ _).trans (card_roots' D)
  omega

end Litt3.CartierAndSpin
