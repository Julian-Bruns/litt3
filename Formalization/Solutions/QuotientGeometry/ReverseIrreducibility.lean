import Mathlib.Algebra.Polynomial.Reverse
import Mathlib.Algebra.Polynomial.FieldDivision

namespace Litt3.QuotientGeometry

theorem polynomial_unit_of_reverse_unit
    {k : Type*} [Field k] (f : Polynomial k) (hf : f.coeff 0 ≠ 0)
    (hreverse : IsUnit f.reverse) : IsUnit f := by
  have hnonzero : f ≠ 0 := by intro h; simp [h] at hf
  have htrailing : f.natTrailingDegree = 0 :=
    Polynomial.natTrailingDegree_eq_zero.mpr (Or.inr hf)
  have hdegree := Polynomial.natDegree_eq_of_degree_eq_some
    (Polynomial.degree_eq_zero_of_isUnit hreverse)
  rw [Polynomial.reverse_natDegree, htrailing, Nat.sub_zero] at hdegree
  apply Polynomial.isUnit_iff_degree_eq_zero.mpr
  rw [Polynomial.degree_eq_natDegree hnonzero, hdegree]
  rfl

/-- Reversing preserves irreducibility when the actual constant is
nonzero. The proof handles arbitrary polynomial factorization. -/
theorem polynomial_irreducible_of_reverse
    {k : Type*} [Field k] (f : Polynomial k) (hf : f.coeff 0 ≠ 0)
    (hreverse : Irreducible f.reverse) : Irreducible f where
  not_isUnit := by
    intro hunit
    have hconstant := Polynomial.eq_C_of_degree_eq_zero
      (Polynomial.degree_eq_zero_of_isUnit hunit)
    apply hreverse.not_isUnit
    rw [hconstant, Polynomial.reverse_C]
    rwa [hconstant] at hunit
  isUnit_or_isUnit := by
    intro g h hfactor
    have hconst : g.coeff 0 * h.coeff 0 ≠ 0 := by
      simpa only [hfactor, Polynomial.mul_coeff_zero] using hf
    have hrevfactor : f.reverse = g.reverse * h.reverse := by
      rw [hfactor, Polynomial.reverse_mul_of_domain]
    exact (hreverse.isUnit_or_isUnit hrevfactor).imp
      (polynomial_unit_of_reverse_unit g (mul_ne_zero_iff.mp hconst).1)
      (polynomial_unit_of_reverse_unit h (mul_ne_zero_iff.mp hconst).2)

end Litt3.QuotientGeometry
