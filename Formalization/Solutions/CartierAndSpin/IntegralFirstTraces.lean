import Solutions.CartierAndSpin.FiniteRootPolynomial
import Solutions.CartierAndSpin.ValuationLeadingMoments
import Solutions.CartierAndSpin.SplitResidues
import Mathlib.FieldTheory.Separable

namespace Litt3.CartierAndSpin

open Finset Polynomial Classical

variable {R K ι : Type*} [CommRing R] [Nontrivial R] [Field K] [Algebra R K] [Fintype ι]

theorem finiteRootPolynomial_map (f : R →+* K) (w : ι → R) :
    (finiteRootPolynomial w).map f = finiteRootPolynomial (fun i => f (w i)) := by
  classical
  simp only [finiteRootPolynomial, Polynomial.map_prod, Polynomial.map_sub,
    Polynomial.map_X, Polynomial.map_C]

/-- General integral trace-dual formula. Monic division is performed in R;
the numerator has arbitrary degree. Separability supplies all actual
nonzero derivative denominators, and repeated reduced roots are permitted. -/
theorem integral_first_power_trace_formula (w : ι → R) (r : R) (phi D U : R[X])
    (hseparable : ((finiteRootPolynomial w).map (algebraMap R K)).Separable)
    (hderivative : (finiteRootPolynomial w).derivative = C r * phi * D) (j : ℕ) :
    finiteWeightedPowerSum (fun i => algebraMap R K (w i))
      (fun i => U.eval₂ (algebraMap R K) (algebraMap R K (w i)) /
        D.eval₂ (algebraMap R K) (algebraMap R K (w i))) j 1 =
      algebraMap R K (r * ((X ^ j * phi * U) %ₘ finiteRootPolynomial w).coeff
        (Fintype.card ι - 1)) := by
  let f := algebraMap R K
  let node := fun i => f (w i)
  let P := finiteRootPolynomial w
  let Q := (X ^ j * phi * U) %ₘ P
  have hPmonic : P.Monic := finiteRootPolynomial_monic w
  have hnode_injective : Function.Injective node := by
    apply Separable.injective_of_prod_X_sub_C
    rw [finiteRootPolynomial_map] at hseparable
    exact hseparable
  have hnodal : Lagrange.nodal univ node = P.map f := by
    rw [Lagrange.nodal_eq, finiteRootPolynomial_map]
    rfl
  have hQdegree : (Q.map f).degree < (Fintype.card ι : WithBot ℕ) := by
    apply lt_of_le_of_lt degree_map_le
    have h := degree_modByMonic_lt (X ^ j * phi * U) hPmonic
    have hPdegree : P.degree = (Fintype.card ι : WithBot ℕ) := by
      rw [degree_eq_natDegree hPmonic.ne_zero]
      simp only [P, finiteRootPolynomial_natDegree]
    rw [hPdegree] at h
    exact h
  have hcoefficient := coefficient_eq_sum_eval_mul_nodalWeight univ node (Q.map f)
    hnode_injective.injOn (by simpa only [card_univ] using hQdegree)
  rw [card_univ, coeff_map] at hcoefficient
  have hroot : ∀ i, P.eval₂ f (node i) = 0 := by
    intro i
    rw [← eval_map, finiteRootPolynomial_map]
    exact finiteRootPolynomial_eval_at_member node i
  have hQeval : ∀ i, (Q.map f).eval (node i) =
      node i ^ j * phi.eval₂ f (node i) * U.eval₂ f (node i) := by
    intro i
    rw [eval_map, eval₂_modByMonic_eq_self_of_root hPmonic (hroot i)]
    simp only [eval₂_mul, eval₂_pow, eval₂_X]
  have hPderivative : ∀ i, (Lagrange.nodal univ node).derivative.eval (node i) =
      f r * phi.eval₂ f (node i) * D.eval₂ f (node i) := by
    intro i
    rw [hnodal, derivative_map, eval_map]
    change P.derivative.eval₂ f (node i) = _
    rw [hderivative]
    simp only [eval₂_mul, eval₂_C]
  have hsum : finiteWeightedPowerSum node
      (fun i => U.eval₂ f (node i) / D.eval₂ f (node i)) j 1 =
      f r * ∑ i, (Q.map f).eval (node i) * Lagrange.nodalWeight univ node i := by
    unfold finiteWeightedPowerSum
    rw [mul_sum]
    apply sum_congr rfl
    intro i _
    have hderiv_nonzero := derivative_nodal_eval_ne_zero univ node hnode_injective.injOn i (mem_univ _)
    rw [hPderivative] at hderiv_nonzero
    have hphi_nonzero : phi.eval₂ f (node i) ≠ 0 :=
      (mul_ne_zero_iff.mp (mul_ne_zero_iff.mp hderiv_nonzero).1).2
    have hr_nonzero : f r ≠ 0 :=
      (mul_ne_zero_iff.mp (mul_ne_zero_iff.mp hderiv_nonzero).1).1
    have hD_nonzero : D.eval₂ f (node i) ≠ 0 := (mul_ne_zero_iff.mp hderiv_nonzero).2
    rw [pow_one, hQeval, Lagrange.nodalWeight_eq_eval_derivative_nodal (mem_univ _), hPderivative]
    field_simp
  rw [hsum, ← hcoefficient, ← map_mul]

theorem integral_first_power_trace_regular (w : ι → R) (r : R) (phi D U : R[X])
    (hseparable : ((finiteRootPolynomial w).map (algebraMap R K)).Separable)
    (hderivative : (finiteRootPolynomial w).derivative = C r * phi * D) (j : ℕ) :
    finiteWeightedPowerSum (fun i => algebraMap R K (w i))
      (fun i => U.eval₂ (algebraMap R K) (algebraMap R K (w i)) /
        D.eval₂ (algebraMap R K) (algebraMap R K (w i))) j 1 ∈ (algebraMap R K).range :=
  ⟨_, (integral_first_power_trace_formula w r phi D U hseparable hderivative j).symm⟩

end Litt3.CartierAndSpin
