import Mathlib.Algebra.QuadraticAlgebra.Basic
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

variable {K : Type*} [Field K]

/-- The exact kernel of square-class extension through an actual
quadratic algebra, in every characteristic other than two. The algebra
need not be a field for this stronger coefficient identity. -/
theorem quadratic_algebra_base_square_iff (a b : K) (ha : a ≠ 0) (htwo : (2 : K) ≠ 0) :
    IsSquare (algebraMap K (QuadraticAlgebra K a 0) b) ↔ IsSquare b ∨ IsSquare (b / a) := by
  constructor
  · rintro ⟨z, hz⟩
    have hreal := congrArg QuadraticAlgebra.re hz
    have himag := congrArg QuadraticAlgebra.im hz
    simp only [QuadraticAlgebra.re_mul, QuadraticAlgebra.im_mul,
      QuadraticAlgebra.coe_algebraMap, QuadraticAlgebra.re_coe, QuadraticAlgebra.im_coe,
      zero_mul, add_zero] at hreal himag
    have hcross : 2 * z.re * z.im = 0 := by linear_combination -himag
    have hzparts : z.re = 0 ∨ z.im = 0 := by
      rw [mul_assoc] at hcross
      exact mul_eq_zero.mp ((mul_eq_zero.mp hcross).resolve_left htwo)
    rcases hzparts with hRe | hIm
    · right
      refine ⟨z.im, ?_⟩
      rw [hRe, zero_mul, zero_add] at hreal
      apply (div_eq_iff ha).mpr
      linear_combination hreal
    · left
      refine ⟨z.re, ?_⟩
      simpa only [hIm, mul_zero, add_zero] using hreal
  · rintro (⟨r, hr⟩ | ⟨r, hr⟩)
    · refine ⟨algebraMap K (QuadraticAlgebra K a 0) r, ?_⟩
      rw [← map_mul, hr]
    · refine ⟨(⟨0, r⟩ : QuadraticAlgebra K a 0), ?_⟩
      have hbr : b = a * (r * r) := by
        have h := (div_eq_iff ha).mp hr
        linear_combination h
      ext <;> simp [QuadraticAlgebra.coe_algebraMap, hbr]
      ring

/-- Multiplying a square-class representative by a square changes no
square-class test, even when the representative itself is zero. -/
theorem isSquare_mul_square_iff (x y : K) (hy : y ≠ 0) :
    IsSquare (x * y ^ 2) ↔ IsSquare x := by
  constructor
  · rintro ⟨r, hr⟩
    refine ⟨r / y, ?_⟩
    field_simp
    linear_combination hr
  · rintro ⟨r, hr⟩
    refine ⟨r * y, ?_⟩
    rw [hr]
    ring

end Litt3.CartierAndSpin
