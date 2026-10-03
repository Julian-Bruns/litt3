import Theorems.CurveArithmetic.PolynomialSpecialization
import Mathlib.Algebra.Polynomial.Degree.Domain
import Mathlib.Tactic

namespace Litt3.CurveArithmetic

theorem large_degree_parameter_avoids_polynomial
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (parameter : L) (exceptional : Polynomial K)
    (hnonzero : exceptional ≠ 0)
    (hdegree : exceptional.natDegree < (minpoly K parameter).natDegree) :
    Polynomial.aeval parameter exceptional ≠ 0 := by
  intro hroot
  exact hdegree.not_ge (Polynomial.natDegree_le_of_dvd
    (minpoly.dvd K parameter hroot) hnonzero)

theorem large_degree_parameter_target : Targets.LargeDegreeParameterAvoidsPolynomial := by
  intro K L instK instL instAlgebra parameter exceptional hn hd
  exact large_degree_parameter_avoids_polynomial parameter exceptional hn hd

/-- An incidence implication plus a nonzero bounded-degree eliminant
excludes the incidence at every higher-degree parameter. This exposes
both certificate obligations instead of hiding them in a finite census. -/
theorem bounded_eliminant_excludes_incidence
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (parameter : L) (exceptional : Polynomial K) (bound : ℕ)
    (incidence : L → Prop) (hnonzero : exceptional ≠ 0)
    (hbound : exceptional.natDegree ≤ bound)
    (hincidence : ∀ t, incidence t → Polynomial.aeval t exceptional = 0)
    (hdegree : bound < (minpoly K parameter).natDegree) : ¬ incidence parameter := by
  intro h
  exact large_degree_parameter_avoids_polynomial parameter exceptional hnonzero
    (hbound.trans_lt hdegree) (hincidence parameter h)

end Litt3.CurveArithmetic
