import Solutions.Deformations.PlanePolynomialQuadraticCoefficients

namespace Litt3.Deformations

open MvPolynomial

variable {R : Type*} [CommRing R]

/-- A literal linear change of the first two original variables,
fixing all original lower variables. No invertibility is assumed here. -/
noncomputable def planePolynomialLinearVariables (d : ℕ) (u v w z : R)
    (i : Fin (d + 2)) : MvPolynomial (Fin (d + 2)) R :=
  if i = 0 then C u * X 0 + C v * X 1 else
    if i = 1 then C w * X 0 + C z * X 1 else X i

noncomputable def planePolynomialLinearHom (d : ℕ) (u v w z : R) :
    MvPolynomial (Fin (d + 2)) R →ₐ[R] MvPolynomial (Fin (d + 2)) R :=
  aeval (planePolynomialLinearVariables d u v w z)

theorem plane_polynomial_linear_variables_homogeneous (d : ℕ) (u v w z : R) :
    ∀ i : Fin (d + 2),
      (planePolynomialLinearVariables d u v w z i).IsHomogeneous 1 := by
  intro i
  unfold planePolynomialLinearVariables
  split_ifs
  · exact (isHomogeneous_C_mul_X u 0).add (isHomogeneous_C_mul_X v 1)
  · exact (isHomogeneous_C_mul_X w 0).add (isHomogeneous_C_mul_X z 1)
  · exact isHomogeneous_X _ _

theorem plane_polynomial_linear_restriction (d : ℕ) (u v w z : R)
    (P : MvPolynomial (Fin (d + 2)) R) :
    planePolynomialRestriction d (planePolynomialLinearHom d u v w z P) =
      planePolynomialLinearHom 0 u v w z (planePolynomialRestriction d P) := by
  have h : (planePolynomialRestriction d).comp (planePolynomialLinearHom d u v w z) =
      (planePolynomialLinearHom 0 u v w z).comp (planePolynomialRestriction d) := by
    ext i
    induction i using Fin.cases with
    | zero => simp [AlgHom.comp_apply, planePolynomialLinearHom, planePolynomialLinearVariables]
    | succ i =>
      induction i using Fin.cases with
      | zero => simp [AlgHom.comp_apply, planePolynomialLinearHom, planePolynomialLinearVariables]
      | succ j => simp [AlgHom.comp_apply, planePolynomialLinearHom,
          planePolynomialLinearVariables, Fin.ext_iff]
  exact AlgHom.congr_fun h P

theorem plane_polynomial_linear_quadratic_form (u v w z a b c : R) :
    planePolynomialLinearHom 0 u v w z (planePolynomialQuadraticForm a b c) =
      planePolynomialQuadraticForm (a * u ^ 2 + b * u * w + c * w ^ 2)
        (2 * a * u * v + b * (u * z + v * w) + 2 * c * w * z)
        (a * v ^ 2 + b * v * z + c * z ^ 2) := by
  simp only [planePolynomialQuadraticForm, map_add, map_mul, map_pow]
  simp [planePolynomialLinearHom, planePolynomialLinearVariables, map_ofNat]
  ring

private theorem plane_form_coefficients (a b c : R) :
    (planePolynomialQuadraticForm a b c).coeff (Finsupp.single 0 2) = a ∧
    (planePolynomialQuadraticForm a b c).coeff (Finsupp.single 0 1 + Finsupp.single 1 1) = b ∧
    (planePolynomialQuadraticForm a b c).coeff (Finsupp.single 1 2) = c := by
  have hxx : Finsupp.single (0 : Fin 2) 2 ≠ Finsupp.single 1 2 := by
    intro h
    have hx := congrArg (fun a : Fin 2 →₀ ℕ => a 0) h
    norm_num at hx
  have hxy : Finsupp.single (0 : Fin 2) 2 ≠ Finsupp.single 0 1 + Finsupp.single 1 1 := by
    intro h
    have hx := congrArg (fun a : Fin 2 →₀ ℕ => a 0) h
    norm_num at hx
  have hy : Finsupp.single (0 : Fin 2) 1 + Finsupp.single 1 1 ≠ Finsupp.single 1 2 := by
    intro h
    have hx := congrArg (fun a : Fin 2 →₀ ℕ => a 0) h
    norm_num at hx
  simp only [planePolynomialQuadraticForm, C_mul_X_pow_eq_monomial, C_mul_X_eq_monomial]
  simp only [X, monomial_mul, mul_one, coeff_add, coeff_monomial]
  simp [hxx, hxy, hy, Ne.symm hxx, Ne.symm hxy, Ne.symm hy]

/-- Exact original quadratic-coefficient transport for a full arbitrary
polynomial. Terms of every other degree remain in the equation. -/
theorem plane_polynomial_linear_quadratic_coefficients (d : ℕ) (u v w z : R)
    (P : MvPolynomial (Fin (d + 2)) R) :
    planePolynomialQuadraticA d (planePolynomialLinearHom d u v w z P) =
      planePolynomialQuadraticA d P * u ^ 2 + planePolynomialQuadraticB d P * u * w +
        planePolynomialQuadraticC d P * w ^ 2 ∧
    planePolynomialQuadraticB d (planePolynomialLinearHom d u v w z P) =
      2 * planePolynomialQuadraticA d P * u * v +
        planePolynomialQuadraticB d P * (u * z + v * w) +
        2 * planePolynomialQuadraticC d P * w * z ∧
    planePolynomialQuadraticC d (planePolynomialLinearHom d u v w z P) =
      planePolynomialQuadraticA d P * v ^ 2 + planePolynomialQuadraticB d P * v * z +
        planePolynomialQuadraticC d P * z ^ 2 := by
  let a := planePolynomialQuadraticA d P
  let b := planePolynomialQuadraticB d P
  let c := planePolynomialQuadraticC d P
  have hc : homogeneousComponent 2
      (planePolynomialRestriction d (planePolynomialLinearHom d u v w z P)) =
      planePolynomialQuadraticForm (a * u ^ 2 + b * u * w + c * w ^ 2)
        (2 * a * u * v + b * (u * z + v * w) + 2 * c * w * z)
        (a * v ^ 2 + b * v * z + c * z ^ 2) := by
    rw [plane_polynomial_linear_restriction]
    rw [planePolynomialLinearHom, plane_polynomial_homogeneous_substitution _
      (plane_polynomial_linear_variables_homogeneous 0 u v w z)]
    rw [plane_binary_quadratic_component]
    exact plane_polynomial_linear_quadratic_form u v w z a b c
  have h := plane_form_coefficients
    (a * u ^ 2 + b * u * w + c * w ^ 2)
    (2 * a * u * v + b * (u * z + v * w) + 2 * c * w * z)
    (a * v ^ 2 + b * v * z + c * z ^ 2)
  rw [← hc] at h
  simpa only [coeff_homogeneousComponent, Finsupp.degree_single,
    Finsupp.degree_eq_sum, Fin.sum_univ_two, Finsupp.coe_add, Pi.add_apply,
    Finsupp.single_apply, Fin.zero_eta, Fin.isValue, ↓reduceIte, zero_add, add_zero,
    planePolynomialQuadraticA, planePolynomialQuadraticB, planePolynomialQuadraticC] using h

/-- Every genuine linear homogeneous substitution preserves a lower
bound on the support's total degrees, including the original maximal square. -/
theorem plane_polynomial_linear_support_bound (d : ℕ) (u v w z : R)
    (P : MvPolynomial (Fin (d + 2)) R) (m : ℕ)
    (bound : ∀ a ∈ P.support, m ≤ a.degree) :
    ∀ a ∈ (planePolynomialLinearHom d u v w z P).support, m ≤ a.degree := by
  classical
  intro a ha
  by_contra hn
  have hc : homogeneousComponent a.degree P = 0 := by
    apply homogeneousComponent_eq_zero'
    intro b hb he
    have hm := bound b hb
    omega
  have hm : homogeneousComponent a.degree (planePolynomialLinearHom d u v w z P) = 0 := by
    rw [planePolynomialLinearHom, plane_polynomial_homogeneous_substitution _
      (plane_polynomial_linear_variables_homogeneous d u v w z), hc, map_zero]
  have hz := congrArg (fun Q : MvPolynomial (Fin (d + 2)) R => Q.coeff a) hm
  simp only [coeff_homogeneousComponent, coeff_zero] at hz
  exact (mem_support_iff.mp ha) hz

/-- The original discriminant has the usual square-determinant
transformation law, derived from the actual arbitrary-polynomial coefficients. -/
theorem plane_polynomial_linear_discriminant (d : ℕ) (u v w z : R)
    (P : MvPolynomial (Fin (d + 2)) R) :
    planePolynomialDiscriminant d (planePolynomialLinearHom d u v w z P) =
      (u * z - v * w) ^ 2 * planePolynomialDiscriminant d P := by
  have h := plane_polynomial_linear_quadratic_coefficients d u v w z P
  unfold planePolynomialDiscriminant
  rw [h.1, h.2.1, h.2.2]
  ring

theorem plane_polynomial_x_shear_linear (d : ℕ) (t : R) :
    (planePolynomialShear (0 : Fin (d + 2)) 1 (by simp) t).toAlgHom =
      planePolynomialLinearHom d 1 t 0 1 := by
  ext i
  by_cases hi : i = 0
  · subst i
    simp [planePolynomialLinearHom, planePolynomialLinearVariables]
  · by_cases hj : i = 1
    · subst i
      simp [planePolynomialLinearHom, planePolynomialLinearVariables]
    · simp [planePolynomialLinearHom, planePolynomialLinearVariables, hi, hj]

theorem plane_polynomial_y_shear_linear (d : ℕ) (t : R) :
    (planePolynomialShear (1 : Fin (d + 2)) 0 (by simp) t).toAlgHom =
      planePolynomialLinearHom d 1 0 t 1 := by
  ext i
  by_cases hi : i = 0
  · subst i
    simp [planePolynomialLinearHom, planePolynomialLinearVariables]
  · by_cases hj : i = 1
    · subst i
      simp [planePolynomialLinearHom, planePolynomialLinearVariables]
      ring
    · simp [planePolynomialLinearHom, planePolynomialLinearVariables, hi, hj]

theorem plane_polynomial_swap_linear (d : ℕ) :
    (planePolynomialSwap (R := R) (0 : Fin (d + 2)) 1).toAlgHom =
      planePolynomialLinearHom d 0 1 1 0 := by
  ext i
  by_cases hi : i = 0
  · subst i
    simp [planePolynomialSwap, renameEquiv_apply, planePolynomialLinearHom,
      planePolynomialLinearVariables]
  · by_cases hj : i = 1
    · subst i
      simp [planePolynomialSwap, renameEquiv_apply, planePolynomialLinearHom,
        planePolynomialLinearVariables]
    · simp [planePolynomialSwap, renameEquiv_apply, Equiv.swap_apply_of_ne_of_ne hi hj,
        planePolynomialLinearHom, planePolynomialLinearVariables, hi, hj]

end Litt3.Deformations
