import Solutions.QuotientGeometry.BinarySquarefree

namespace Litt3.QuotientGeometry

open scoped Classical

theorem squarefree_homogenize_padding_le_one
    {R : Type*} [CommSemiring R] [Nontrivial R]
    (p : Polynomial R) (n : ℕ) (hn : p.natDegree ≤ n) (hs : Squarefree (p.homogenize n)) :
    n ≤ p.natDegree + 1 := by
  have hpow : MvPolynomial.X (1 : Fin 2) ^ (n - p.natDegree) ∣ p.homogenize n := by
    rw [polynomial_homogenize_padding p n hn]
    exact dvd_mul_left _ _
  have hX : ¬IsUnit (MvPolynomial.X (1 : Fin 2) : MvPolynomial (Fin 2) R) := by
    intro hX
    have hunit := hX.map (MvPolynomial.eval (fun _ => (0 : R)))
    simpa only [MvPolynomial.eval_X, not_isUnit_zero] using hunit
  have hsmall := (hs.squarefree_of_dvd hpow).eq_zero_or_one_of_pow_of_not_isUnit hX
  omega

theorem homogeneous_binary_dehomogenization_degree_bounds_X_one
    {R : Type*} [CommSemiring R] [Nontrivial R]
    (H : MvPolynomial (Fin 2) R) (n : ℕ) (hH : H.IsHomogeneous n) (hs : Squarefree H) :
    n ≤ (MvPolynomial.aeval ![Polynomial.X, (1 : Polynomial R)] H).natDegree + 1 ∧
      (MvPolynomial.aeval ![Polynomial.X, (1 : Polynomial R)] H).natDegree ≤ n := by
  let p := MvPolynomial.aeval ![Polynomial.X, (1 : Polynomial R)] H
  have hdegree : p.natDegree ≤ n := by
    simpa only [mul_one] using MvPolynomial.aeval_natDegree_le H hH.totalDegree_le
      ![Polynomial.X, (1 : Polynomial R)] (n := 1) (by
        intro i
        fin_cases i <;> simp)
  have hhom : p.homogenize n = H :=
    Polynomial.homogenize_eq_of_isHomogeneous hH rfl
  exact ⟨squarefree_homogenize_padding_le_one p n hdegree (hhom.symm ▸ hs), hdegree⟩

/-- A squarefree homogeneous binary form loses at most one degree on
dehomogenization: its possible zero at infinity has multiplicity at most one. -/
theorem binary_dehomogenization_degree_bounds
    {R : Type*} [CommSemiring R] [Nontrivial R]
    (H : MvPolynomial (Fin 2) R) (n : ℕ) (hH : H.IsHomogeneous n) (hs : Squarefree H) :
    n ≤ (binaryDehomogenization H).natDegree + 1 ∧ (binaryDehomogenization H).natDegree ≤ n := by
  let e : Fin 2 ≃ Fin 2 := Equiv.swap 0 1
  have hs' := squarefree_of_mulEquiv (MvPolynomial.renameEquiv R e).toMulEquiv hs
  have hH' := hH.rename_isHomogeneous (f := e)
  have hb := homogeneous_binary_dehomogenization_degree_bounds_X_one
    (MvPolynomial.rename e H) n hH' hs'
  rw [MvPolynomial.aeval_rename] at hb
  have he : (![Polynomial.X, (1 : Polynomial R)] : Fin 2 → Polynomial R) ∘ e =
      ![1, Polynomial.X] := by
    funext i
    fin_cases i <;> simp [e]
  rw [he] at hb
  exact hb

theorem binary_dehomogenization_natDegree_pos
    {R : Type*} [CommSemiring R] [Nontrivial R]
    (H : MvPolynomial (Fin 2) R) (n : ℕ) (hn : 2 ≤ n)
    (hH : H.IsHomogeneous n) (hs : Squarefree H) :
    0 < (binaryDehomogenization H).natDegree := by
  have hb := binary_dehomogenization_degree_bounds H n hH hs
  omega

end Litt3.QuotientGeometry
