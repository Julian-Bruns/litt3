import Solutions.CartierAndSpin.ReducedSourcePolynomials

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- Every nonzero reduced polynomial has a nonzero top residue moment
against a power below the actual source degree. Thus the residue pairing
is nondegenerate even for inseparable or nonreduced source quotients. -/
theorem nonzero_reduced_polynomial_residue_moment (F P : K[X])
    (hF : F ≠ 0) (hP : P ≠ 0) (hdegree : P.degree < F.degree) :
    ∃ j : ℕ, j < F.natDegree ∧
      ((X ^ j * P) % F).coeff (F.natDegree - 1) ≠ 0 := by
  have hnat := natDegree_lt_natDegree hP hdegree
  let j := F.natDegree - 1 - P.natDegree
  have hj : j < F.natDegree := by dsimp only [j]; omega
  have hindex : P.natDegree + j = F.natDegree - 1 := by dsimp only [j]; omega
  have hsmall : (X ^ j * P).degree < F.degree := by
    rw [degree_mul, degree_X_pow, degree_eq_natDegree hP, degree_eq_natDegree hF]
    exact_mod_cast (show j + P.natDegree < F.natDegree by omega)
  refine ⟨j, hj, ?_⟩
  rw [(mod_eq_self_iff hF).mpr hsmall, ← hindex, coeff_X_pow_mul, coeff_natDegree]
  exact leadingCoeff_ne_zero.mpr hP

/-- The first N genuine residue moments recover the entire reduced
polynomial, with no separability or critical-root distinctness premise. -/
theorem reduced_polynomial_residue_moments_eq_iff (F P Q : K[X])
    (hF : F ≠ 0) (hP : P.degree < F.degree) (hQ : Q.degree < F.degree) :
    (∀ j : ℕ, j < F.natDegree →
      ((X ^ j * P) % F).coeff (F.natDegree - 1) =
        ((X ^ j * Q) % F).coeff (F.natDegree - 1)) ↔ P = Q := by
  constructor
  · intro hmoments
    by_contra hne
    have hdifference : P - Q ≠ 0 := sub_ne_zero.mpr hne
    have hsmall : (P - Q).degree < F.degree :=
      (degree_sub_le P Q).trans_lt (max_lt hP hQ)
    obtain ⟨j, hj, hnonzero⟩ :=
      nonzero_reduced_polynomial_residue_moment F (P - Q) hF hdifference hsmall
    apply hnonzero
    rw [mul_sub, Polynomial.sub_mod, coeff_sub, hmoments j hj, sub_self]
  · intro h
    subst Q
    intro j _
    rfl

end Litt3.CartierAndSpin
