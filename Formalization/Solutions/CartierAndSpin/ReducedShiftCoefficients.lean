import Solutions.CartierAndSpin.ReducedSourcePolynomials

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- One multiplication by the actual quotient parameter has a single
leading-coefficient correction, valid for every nonmonic polynomial. -/
theorem reduced_parameter_shift (F P : K[X]) (hF : F ≠ 0)
    (hpositive : 0 < F.natDegree) (hP : P.degree < F.degree) :
    (X * P) % F =
      X * P - C (P.coeff (F.natDegree - 1) / F.leadingCoeff) * F := by
  let candidate := X * P - C (P.coeff (F.natDegree - 1) / F.leadingCoeff) * F
  have hPbound : P.natDegree ≤ F.natDegree - 1 := by
    by_cases hzero : P = 0
    · simp [hzero]
    · have hlt := natDegree_lt_natDegree hzero hP
      omega
  have hbound : candidate.natDegree ≤ F.natDegree := by
    apply (natDegree_sub_le _ _).trans
    apply max_le
    · have hm := natDegree_mul_le (p := (X : K[X])) (q := P)
      simp only [natDegree_X] at hm
      omega
    · exact natDegree_C_mul_le _ _
  have hsmall : candidate.degree < F.degree := by
    rw [degree_eq_natDegree hF, degree_lt_iff_coeff_zero]
    intro j hj
    by_cases heq : j = F.natDegree
    · subst j
      dsimp only [candidate]
      rw [coeff_sub, ← pow_one (X : K[X]), coeff_X_pow_mul',
        if_pos (show 1 ≤ F.natDegree by omega), coeff_C_mul, coeff_natDegree,
        div_mul_cancel₀ _ (leadingCoeff_ne_zero.mpr hF), sub_self]
    · exact coeff_eq_zero_of_natDegree_lt (by omega)
  have hmk : AdjoinRoot.mk F candidate = AdjoinRoot.mk F (X * P) := by
    dsimp only [candidate]
    simp only [map_sub, map_mul, AdjoinRoot.mk_self, mul_zero, sub_zero]
  obtain ⟨R, hR, hunique⟩ :=
    source_quotient_reduced_polynomial F hF (AdjoinRoot.mk F (X * P))
  exact (hunique ((X * P) % F)
    ⟨degree_mod_lt _ hF, source_quotient_mk_remainder F _⟩).trans
    (hunique candidate ⟨hsmall, hmk⟩).symm

/-- All coefficients of the actual shifted remainder, with its precise
leading-source correction. The source need not be separable. -/
theorem reduced_parameter_shift_coefficient (F P : K[X]) (hF : F ≠ 0)
    (hpositive : 0 < F.natDegree) (hP : P.degree < F.degree) (j : ℕ) :
    ((X * P) % F).coeff j =
      (if 1 ≤ j then P.coeff (j - 1) else 0) -
        (P.coeff (F.natDegree - 1) / F.leadingCoeff) * F.coeff j := by
  rw [reduced_parameter_shift F P hF hpositive hP,
    coeff_sub, coeff_C_mul, ← pow_one (X : K[X]), coeff_X_pow_mul']

end Litt3.CartierAndSpin
