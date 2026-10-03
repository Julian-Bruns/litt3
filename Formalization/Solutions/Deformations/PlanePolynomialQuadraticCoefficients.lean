import Solutions.Deformations.PlanePolynomialCoordinates
import Mathlib.RingTheory.MvPolynomial.Homogeneous
import Mathlib.Data.Finsupp.Fin

namespace Litt3.Deformations

open MvPolynomial

variable {R : Type*} [CommRing R]

/-- The genuine restriction to the first two original variables;
all remaining original variables are set to zero. -/
noncomputable def planePolynomialRestriction (d : ℕ) :
    MvPolynomial (Fin (d + 2)) R →ₐ[R] MvPolynomial (Fin 2) R :=
  aeval (Fin.cases (X 0) (Fin.cases (X 1) (fun _ => 0)))

@[simp] theorem planePolynomialRestriction_X_zero (d : ℕ) :
    planePolynomialRestriction (R := R) d (X 0) = X 0 := by
  simp [planePolynomialRestriction]

@[simp] theorem planePolynomialRestriction_X_one (d : ℕ) :
    planePolynomialRestriction (R := R) d (X 1) = X 1 := by
  rw [planePolynomialRestriction, aeval_X]
  change Fin.cases (X 0) (Fin.cases (X 1) (fun _ : Fin d => 0))
    ((0 : Fin (d + 1)).succ) = X 1
  rw [Fin.cases_succ, Fin.cases_zero]

@[simp] theorem planePolynomialRestriction_X_lower (d : ℕ) (i : Fin d) :
    planePolynomialRestriction (R := R) d (X i.succ.succ) = 0 := by
  simp [planePolynomialRestriction]

noncomputable def planeOriginalExponent (d : ℕ) (a : Fin 2 →₀ ℕ) : Fin (d + 2) →₀ ℕ :=
  ((0 : Fin d →₀ ℕ).cons (a 1)).cons (a 0)

private theorem plane_restriction_monomial (d : ℕ) (s : Fin (d + 2) →₀ ℕ) (r : R) :
    planePolynomialRestriction d (monomial s r) =
      if (∀ i : Fin d, s i.succ.succ = 0) then
        monomial (Finsupp.single 0 (s 0) + Finsupp.single 1 (s 1)) r else 0 := by
  classical
  rw [planePolynomialRestriction, aeval_monomial,
    Finsupp.prod_fintype _ _ (fun _ => pow_zero _), Fin.prod_univ_succ, Fin.prod_univ_succ]
  simp only [Fin.cases_zero, Fin.cases_succ]
  by_cases h : ∀ i : Fin d, s i.succ.succ = 0
  · rw [if_pos h]
    simp only [h, pow_zero, Finset.prod_const_one, mul_one]
    change C r * (X 0 ^ s 0 * X 1 ^ s 1) = _
    rw [X_pow_eq_monomial, X_pow_eq_monomial, monomial_mul]
    simp only [mul_one, C_mul_monomial]
  · rw [if_neg h]
    obtain ⟨i, hi⟩ := not_forall.mp h
    have hp : (∏ j : Fin d, (0 : MvPolynomial (Fin 2) R) ^ s j.succ.succ) = 0 :=
      Finset.prod_eq_zero (Finset.mem_univ i) (zero_pow hi)
    simp only [hp, mul_zero]

/-- Restriction retains precisely the original coefficients supported
on the first two coordinates, with no degree or normal-form premise. -/
theorem plane_polynomial_restriction_coeff (d : ℕ) (P : MvPolynomial (Fin (d + 2)) R)
    (a : Fin 2 →₀ ℕ) :
    (planePolynomialRestriction d P).coeff a = P.coeff (planeOriginalExponent d a) := by
  classical
  induction P using MvPolynomial.induction_on' with
  | add P Q hP hQ => simp only [map_add, coeff_add, hP, hQ]
  | monomial s r =>
    rw [plane_restriction_monomial]
    by_cases h : ∀ i : Fin d, s i.succ.succ = 0
    · rw [if_pos h, coeff_monomial, coeff_monomial]
      have he : a = Finsupp.single 0 (s 0) + Finsupp.single 1 (s 1) ↔
          planeOriginalExponent d a = s := by
        constructor
        · intro ha
          subst a
          ext i
          induction i using Fin.cases with
          | zero => simp [planeOriginalExponent]
          | succ i =>
            induction i using Fin.cases with
            | zero =>
                rw [planeOriginalExponent, Finsupp.cons_succ, Finsupp.cons_zero]
                simp
            | succ j => simp [planeOriginalExponent, h]
        · intro ha
          ext i
          fin_cases i
          · have hc := congrArg (fun b : Fin (d + 2) →₀ ℕ => b 0) ha
            simpa [planeOriginalExponent] using hc
          · have hc := congrArg (fun b : Fin (d + 2) →₀ ℕ => b 1) ha
            simpa [planeOriginalExponent] using hc
      have he' : (Finsupp.single 0 (s 0) + Finsupp.single 1 (s 1) = a) ↔
          s = planeOriginalExponent d a := by
        simpa only [eq_comm] using he
      simp only [he']
    · rw [if_neg h, coeff_zero, coeff_monomial]
      have he : planeOriginalExponent d a ≠ s := by
        intro hs
        apply h
        intro i
        simpa [planeOriginalExponent] using
          congrArg (fun b : Fin (d + 2) →₀ ℕ => b i.succ.succ) hs.symm
      simp [Ne.symm he]

/-- Every linear homogeneous substitution preserves every homogeneous
component of the full arbitrary polynomial. -/
theorem plane_polynomial_homogeneous_substitution {I J : Type*}
    (v : I → MvPolynomial J R) (linear : ∀ i, (v i).IsHomogeneous 1)
    (P : MvPolynomial I R) (n : ℕ) :
    homogeneousComponent n (aeval v P) = aeval v (homogeneousComponent n P) := by
  classical
  have term (m : ℕ) : homogeneousComponent n (aeval v (homogeneousComponent m P)) =
      aeval v (homogeneousComponent n (homogeneousComponent m P)) := by
    have hm := (homogeneousComponent_isHomogeneous m P).aeval v linear
    simp only [one_mul] at hm
    rw [homogeneousComponent_of_mem hm,
      homogeneousComponent_of_mem (homogeneousComponent_mem m P)]
    split_ifs <;> simp
  have hsum := sum_homogeneousComponent P
  conv_lhs => rw [← hsum]
  rw [map_sum, map_sum]
  simp_rw [term]
  rw [← map_sum, ← map_sum, hsum]

noncomputable def planePolynomialQuadraticA (d : ℕ) (P : MvPolynomial (Fin (d + 2)) R) : R :=
  (planePolynomialRestriction d P).coeff (Finsupp.single 0 2)

noncomputable def planePolynomialQuadraticB (d : ℕ) (P : MvPolynomial (Fin (d + 2)) R) : R :=
  (planePolynomialRestriction d P).coeff (Finsupp.single 0 1 + Finsupp.single 1 1)

noncomputable def planePolynomialQuadraticC (d : ℕ) (P : MvPolynomial (Fin (d + 2)) R) : R :=
  (planePolynomialRestriction d P).coeff (Finsupp.single 1 2)

/-- The xy coefficient is b, without a hidden factor of two. -/
noncomputable def planePolynomialDiscriminant (d : ℕ) (P : MvPolynomial (Fin (d + 2)) R) : R :=
  planePolynomialQuadraticB d P ^ 2 -
    4 * planePolynomialQuadraticA d P * planePolynomialQuadraticC d P

noncomputable def planePolynomialQuadraticForm (a b c : R) : MvPolynomial (Fin 2) R :=
  C a * X 0 ^ 2 + C b * X 0 * X 1 + C c * X 1 ^ 2

private theorem plane_xx_ne_yy :
    Finsupp.single (0 : Fin 2) 2 ≠ Finsupp.single 1 2 := by
  intro h
  have hx := congrArg (fun a : Fin 2 →₀ ℕ => a 0) h
  norm_num at hx

private theorem plane_xx_ne_xy :
    Finsupp.single (0 : Fin 2) 2 ≠ Finsupp.single 0 1 + Finsupp.single 1 1 := by
  intro h
  have hx := congrArg (fun a : Fin 2 →₀ ℕ => a 0) h
  norm_num at hx

private theorem plane_xy_ne_yy :
    Finsupp.single (0 : Fin 2) 1 + Finsupp.single 1 1 ≠ Finsupp.single 1 2 := by
  intro h
  have hx := congrArg (fun a : Fin 2 →₀ ℕ => a 0) h
  norm_num at hx

private theorem plane_quadratic_form_monomials (a b c : R) :
    planePolynomialQuadraticForm a b c =
      monomial (Finsupp.single 0 2) a +
      monomial (Finsupp.single 0 1 + Finsupp.single 1 1) b +
      monomial (Finsupp.single 1 2) c := by
  simp only [planePolynomialQuadraticForm, C_mul_X_pow_eq_monomial,
    C_mul_X_eq_monomial]
  rw [X, monomial_mul, mul_one]

/-- The whole quadratic component of an arbitrary binary polynomial. -/
theorem plane_binary_quadratic_component (P : MvPolynomial (Fin 2) R) :
    homogeneousComponent 2 P = planePolynomialQuadraticForm
      (P.coeff (Finsupp.single 0 2))
      (P.coeff (Finsupp.single 0 1 + Finsupp.single 1 1))
      (P.coeff (Finsupp.single 1 2)) := by
  classical
  rw [plane_quadratic_form_monomials]
  ext a
  rw [coeff_homogeneousComponent]
  simp only [coeff_add, coeff_monomial]
  have hd : a.degree = a 0 + a 1 := by
    rw [Finsupp.degree_eq_sum, Fin.sum_univ_two]
  by_cases h : a.degree = 2
  · rw [if_pos h]
    have hb : a 0 ≤ 2 := by omega
    interval_cases h0 : a 0
    · have h1 : a 1 = 2 := by omega
      have ha : a = Finsupp.single 1 2 := by
        ext i
        fin_cases i <;> simp [h0, h1]
      subst a
      simp [plane_xx_ne_yy, plane_xy_ne_yy]
    · have h1 : a 1 = 1 := by omega
      have ha : a = Finsupp.single 0 1 + Finsupp.single 1 1 := by
        ext i
        fin_cases i <;> simp [h0, h1]
      subst a
      simp [plane_xx_ne_xy, Ne.symm plane_xy_ne_yy]
    · have h1 : a 1 = 0 := by omega
      have ha : a = Finsupp.single 0 2 := by
        ext i
        fin_cases i <;> simp [h0, h1]
      subst a
      simp [Ne.symm plane_xx_ne_xy, Ne.symm plane_xx_ne_yy]
  · rw [if_neg h]
    have hx : Finsupp.single (0 : Fin 2) 2 ≠ a := by
      intro ha
      subst a
      simp [Finsupp.degree_eq_sum] at h
    have hy : Finsupp.single (1 : Fin 2) 2 ≠ a := by
      intro ha
      subst a
      simp [Finsupp.degree_eq_sum] at h
    have hxy : Finsupp.single (0 : Fin 2) 1 + Finsupp.single 1 1 ≠ a := by
      intro ha
      subst a
      simp [Finsupp.degree_eq_sum, Fin.sum_univ_two] at h
    simp [hx, hy, hxy]

@[simp] theorem plane_polynomial_quadratic_a_original (d : ℕ)
    (P : MvPolynomial (Fin (d + 2)) R) :
    planePolynomialQuadraticA d P = P.coeff (Finsupp.single 0 2) := by
  rw [planePolynomialQuadraticA, plane_polynomial_restriction_coeff]
  congr 1
  ext i
  induction i using Fin.cases with
  | zero => simp [planeOriginalExponent]
  | succ i =>
    induction i using Fin.cases with
    | zero => rw [planeOriginalExponent, Finsupp.cons_succ, Finsupp.cons_zero]; simp
    | succ j => simp [planeOriginalExponent]

@[simp] theorem plane_polynomial_quadratic_b_original (d : ℕ)
    (P : MvPolynomial (Fin (d + 2)) R) :
    planePolynomialQuadraticB d P = P.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) := by
  rw [planePolynomialQuadraticB, plane_polynomial_restriction_coeff]
  congr 1
  ext i
  induction i using Fin.cases with
  | zero => simp [planeOriginalExponent]
  | succ i =>
    induction i using Fin.cases with
    | zero => rw [planeOriginalExponent, Finsupp.cons_succ, Finsupp.cons_zero]; simp
    | succ j => simp [planeOriginalExponent, Fin.ext_iff]

@[simp] theorem plane_polynomial_quadratic_c_original (d : ℕ)
    (P : MvPolynomial (Fin (d + 2)) R) :
    planePolynomialQuadraticC d P = P.coeff (Finsupp.single 1 2) := by
  rw [planePolynomialQuadraticC, plane_polynomial_restriction_coeff]
  congr 1
  ext i
  induction i using Fin.cases with
  | zero => simp [planeOriginalExponent]
  | succ i =>
    induction i using Fin.cases with
    | zero => rw [planeOriginalExponent, Finsupp.cons_succ, Finsupp.cons_zero]; simp
    | succ j => simp [planeOriginalExponent, Fin.ext_iff]

end Litt3.Deformations
