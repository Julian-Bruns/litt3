import Mathlib.FieldTheory.RatFunc.Basic

namespace Litt3.CartierAndSpin

/-- The actual two-variable relation V^n-U, viewed as a polynomial in
V with coefficients in the literal polynomial ring k[U]. -/
noncomputable def monomialParameterPolynomial {k : Type*} [CommRing k] (n : ℕ) :
    Polynomial (Polynomial k) :=
  Polynomial.X ^ n - Polynomial.C (Polynomial.X : Polynomial k)

end Litt3.CartierAndSpin
