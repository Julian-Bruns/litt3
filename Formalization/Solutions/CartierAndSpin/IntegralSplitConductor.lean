import Solutions.CartierAndSpin.IntegralSplitOrder
import Solutions.CartierAndSpin.IntegralFirstTraces
import Mathlib.Algebra.BigOperators.Pi

namespace Litt3.CartierAndSpin

open Finset Polynomial Classical

variable {R K ι : Type*} [CommRing R] [Nontrivial R] [Field K]
  [Algebra R K] [Fintype ι]

/-- Coordinate membership in the actual integral order is detected by the
actual derivative denominator. Monic division occurs over R, and the only
field step is the already proved interpolation coefficient identity. -/
theorem integral_coordinate_tuple_mem_order_iff (w z : ι → R)
    (hinjective : Function.Injective (algebraMap R K))
    (hseparable : ((finiteRootPolynomial w).map (algebraMap R K)).Separable) (i : ι) :
    (fun j => if j = i then z i else 0) ∈ Algebra.adjoin R {w} ↔
      algebraMap R K (z i) /
        ((finiteRootPolynomial w).map (algebraMap R K)).derivative.eval
          (algebraMap R K (w i)) ∈ (algebraMap R K).range := by
  let f := algebraMap R K
  let node := fun j => f (w j)
  let P := finiteRootPolynomial w
  have hnode : Function.Injective node := by
    apply Separable.injective_of_prod_X_sub_C
    rw [finiteRootPolynomial_map] at hseparable
    exact hseparable
  have hnodal : Lagrange.nodal univ node = P.map f := by
    rw [Lagrange.nodal_eq, finiteRootPolynomial_map]
    rfl
  have hdenominator : (P.map f).derivative.eval (node i) ≠ 0 := by
    rw [← hnodal]
    exact derivative_nodal_eval_ne_zero univ node hnode.injOn i (mem_univ _)
  have hdenominator_map : (P.map f).derivative.eval (node i) = f (P.derivative.eval (w i)) := by
    rw [derivative_map, eval_map, eval₂_at_apply]
  constructor
  · intro hz
    obtain ⟨Q, hQ⟩ := Algebra.adjoin_mem_exists_aeval R w hz
    let H := Q %ₘ P
    have hPmonic : P.Monic := finiteRootPolynomial_monic w
    have hHdegree : (H.map f).degree < (Fintype.card ι : WithBot ℕ) := by
      apply lt_of_le_of_lt degree_map_le
      have hdegree := degree_modByMonic_lt Q hPmonic
      have hPdegree : P.degree = (Fintype.card ι : WithBot ℕ) := by
        rw [degree_eq_natDegree hPmonic.ne_zero]
        simp only [P, finiteRootPolynomial_natDegree]
      rw [hPdegree] at hdegree
      exact hdegree
    have hHeval : ∀ j, (H.map f).eval (node j) = f (if j = i then z i else 0) := by
      intro j
      rw [eval_map, eval₂_at_apply]
      have hroot : P.eval₂ (RingHom.id R) (w j) = 0 := by
        simpa only [eval₂_id] using finiteRootPolynomial_eval_at_member w j
      have hmod := eval₂_modByMonic_eq_self_of_root (p := Q) hPmonic hroot
      have hmod' : H.eval (w j) = Q.eval (w j) := by simpa only [eval₂_id] using hmod
      rw [hmod']
      have heval := congrFun hQ j
      simp only [aeval_fn_apply, aeval_def, Algebra.algebraMap_self, eval₂_id] at heval
      rw [heval]
    have hcoefficient := coefficient_eq_sum_eval_mul_nodalWeight univ node (H.map f)
      hnode.injOn (by simpa only [card_univ] using hHdegree)
    rw [card_univ, coeff_map] at hcoefficient
    refine ⟨H.coeff (Fintype.card ι - 1), ?_⟩
    simpa only [hHeval, apply_ite f, map_zero, ite_mul, zero_mul,
      sum_ite_eq', mem_univ, if_true,
      Lagrange.nodalWeight_eq_eval_derivative_nodal (mem_univ i), hnodal,
      div_eq_mul_inv] using hcoefficient
  · rintro ⟨a, ha⟩
    have hscalar : a * P.derivative.eval (w i) = z i := by
      apply hinjective
      rw [map_mul, ← hdenominator_map]
      exact (eq_div_iff hdenominator).mp ha
    let Q := Lagrange.nodal (univ.erase i) w
    have hQself : Q.eval (w i) = P.derivative.eval (w i) := by
      exact (Lagrange.eval_nodal_derivative_eval_node_eq (s := univ) (v := w)
        (mem_univ i)).symm
    have hQother : ∀ j, j ≠ i → Q.eval (w j) = 0 := by
      intro j hji
      exact Lagrange.eval_nodal_at_node (mem_erase.mpr ⟨hji, mem_univ j⟩)
    have heval : aeval w (C a * Q) = fun j => if j = i then z i else 0 := by
      ext j
      simp only [aeval_fn_apply, aeval_def, Algebra.algebraMap_self, eval₂_id,
        eval_mul, eval_C]
      by_cases hji : j = i
      · subst j
        rw [hQself, hscalar, if_pos rfl]
      · rw [hQother j hji, mul_zero, if_neg hji]
    rw [← heval]
    exact aeval_mem_adjoin_singleton R w

/-- Actual conductor membership in the actual product normalization. There
is no assumed trace-dual formula and no critical-discriminant inverse. -/
theorem integral_split_conductor_iff (w z : ι → R)
    (hinjective : Function.Injective (algebraMap R K))
    (hseparable : ((finiteRootPolynomial w).map (algebraMap R K)).Separable) :
    z ∈ conductor R w ↔ ∀ i,
      algebraMap R K (z i) /
        ((finiteRootPolynomial w).map (algebraMap R K)).derivative.eval
          (algebraMap R K (w i)) ∈ (algebraMap R K).range := by
  rw [mem_conductor_iff]
  constructor
  · intro hconductor i
    apply (integral_coordinate_tuple_mem_order_iff w z hinjective hseparable i).mp
    have h := hconductor (fun j => if j = i then 1 else 0)
    have hequality : z * (fun j => if j = i then 1 else 0) =
        (fun j => if j = i then z i else 0) := by
      ext j
      by_cases hji : j = i
      · subst j
        simp
      · simp [hji]
    rw [hequality] at h
    exact h
  · intro hintegral b
    have hcoordinates : ∀ i,
        (fun j => if j = i then z i else 0) ∈ Algebra.adjoin R {w} :=
      fun i => (integral_coordinate_tuple_mem_order_iff w z hinjective hseparable i).mpr
        (hintegral i)
    have hsum : z * b = ∑ i, b i • (fun j => if j = i then z i else 0) := by
      ext j
      simp only [sum_apply, Pi.smul_apply, smul_eq_mul, mul_ite, mul_zero,
        sum_ite_eq, mem_univ, if_true, Pi.mul_apply]
      exact mul_comm _ _
    rw [hsum]
    exact Subalgebra.sum_mem _ (fun i hi => Subalgebra.smul_mem _ (hcoordinates i) (b i))

end Litt3.CartierAndSpin
