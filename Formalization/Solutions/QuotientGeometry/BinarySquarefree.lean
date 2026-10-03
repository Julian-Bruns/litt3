import Definitions.QuotientGeometry.QuadraticFunctionFields
import Mathlib.Algebra.Polynomial.Homogenize
import Mathlib.RingTheory.Polynomial.Basic
import Mathlib.Algebra.Squarefree.Basic
import Mathlib.Tactic

namespace Litt3.QuotientGeometry

open scoped Classical

theorem polynomial_homogenize_padding
    {R : Type*} [CommSemiring R] (p : Polynomial R) (n : ℕ) (hn : p.natDegree ≤ n) :
    p.homogenize n = p.homogenize p.natDegree * MvPolynomial.X 1 ^ (n - p.natDegree) := by
  apply Polynomial.homogenize_eq_of_isHomogeneous
  · have hh := (Polynomial.isHomogeneous_homogenize (n := p.natDegree) p).mul
      (MvPolynomial.isHomogeneous_X_pow (R := R) (1 : Fin 2) (n - p.natDegree))
    simpa only [Nat.add_sub_of_le hn] using hh
  · simp [Polynomial.aeval_homogenize_X_one p le_rfl]

theorem polynomial_squarefree_of_squarefree_homogenize
    {R : Type*} [CommSemiring R] [NoZeroDivisors R] [Nontrivial R]
    (p : Polynomial R) (n : ℕ) (hn : p.natDegree ≤ n) (hs : Squarefree (p.homogenize n)) :
    Squarefree p := by
  have hdvd : p.homogenize p.natDegree ∣ p.homogenize n := by
    rw [polynomial_homogenize_padding p n hn]
    exact dvd_mul_right _ _
  have hs' := hs.squarefree_of_dvd hdvd
  have hp : p ≠ 0 := by
    intro hp
    apply hs'.ne_zero
    simp [hp]
  intro q hq
  have hq0 : q ≠ 0 := by
    intro hq0
    simp only [hq0, zero_mul, zero_dvd_iff] at hq
    exact hp hq
  have hqhom := Polynomial.homogenize_dvd hq
  rw [Polynomial.natDegree_mul hq0 hq0,
    Polynomial.homogenize_mul q q le_rfl le_rfl] at hqhom
  have hunit := (hs' (q.homogenize q.natDegree) hqhom).map
    (MvPolynomial.aeval ![Polynomial.X, (1 : Polynomial R)]).toRingHom
  change IsUnit (MvPolynomial.aeval ![Polynomial.X, (1 : Polynomial R)]
    (q.homogenize q.natDegree)) at hunit
  simpa only [Polynomial.aeval_homogenize_X_one q le_rfl] using hunit

theorem homogeneous_binary_dehomogenization_squarefree_X_one
    {R : Type*} [CommSemiring R] [NoZeroDivisors R] [Nontrivial R]
    (H : MvPolynomial (Fin 2) R) (n : ℕ) (hH : H.IsHomogeneous n) (hs : Squarefree H) :
    Squarefree (MvPolynomial.aeval ![Polynomial.X, (1 : Polynomial R)] H) := by
  let p := MvPolynomial.aeval ![Polynomial.X, (1 : Polynomial R)] H
  have hdegree : p.natDegree ≤ n := by
    simpa only [mul_one] using MvPolynomial.aeval_natDegree_le H hH.totalDegree_le
      ![Polynomial.X, (1 : Polynomial R)] (n := 1) (by
        intro i
        fin_cases i <;> simp)
  have hhom : p.homogenize n = H :=
    Polynomial.homogenize_eq_of_isHomogeneous hH rfl
  exact polynomial_squarefree_of_squarefree_homogenize p n hdegree (hhom.symm ▸ hs)

theorem squarefree_of_mulEquiv
    {M N : Type*} [CommMonoid M] [CommMonoid N] (e : M ≃* N) {x : M} (hs : Squarefree x) :
    Squarefree (e x) := by
  intro y hy
  have hback : e.symm y * e.symm y ∣ x := by
    have hh := map_dvd e.symm.toMonoidHom hy
    change e.symm (y * y) ∣ e.symm (e x) at hh
    simpa only [map_mul, e.symm_apply_apply] using hh
  have hunit : IsUnit (e (e.symm y)) := (hs (e.symm y) hback).map e.toMonoidHom
  simpa only [e.apply_symm_apply] using hunit

/-- Binary homogeneous squarefreeness gives squarefreeness on the actual
affine chart H(1,t), over every nontrivial semiring without zero divisors. -/
theorem binary_dehomogenization_squarefree
    {R : Type*} [CommSemiring R] [NoZeroDivisors R] [Nontrivial R]
    (H : MvPolynomial (Fin 2) R) (n : ℕ) (hH : H.IsHomogeneous n) (hs : Squarefree H) :
    Squarefree (binaryDehomogenization H) := by
  let e : Fin 2 ≃ Fin 2 := Equiv.swap 0 1
  have hs' := squarefree_of_mulEquiv (MvPolynomial.renameEquiv R e).toMulEquiv hs
  have hH' := hH.rename_isHomogeneous (f := e)
  have hdehom := homogeneous_binary_dehomogenization_squarefree_X_one
    (MvPolynomial.rename e H) n hH' hs'
  rw [MvPolynomial.aeval_rename] at hdehom
  have he : (![Polynomial.X, (1 : Polynomial R)] : Fin 2 → Polynomial R) ∘ e =
      ![1, Polynomial.X] := by
    funext i
    fin_cases i <;> simp [e]
  rw [he] at hdehom
  exact hdehom

end Litt3.QuotientGeometry
