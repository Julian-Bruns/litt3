import Definitions.QuotientGeometry.ConstantPolynomialParameter

namespace Litt3.QuotientGeometry

noncomputable def linearizedConstantPolynomial {k : Type*} [Field k]
    (p : ℕ) (α γ : k) : Polynomial k :=
  Polynomial.C α * Polynomial.X ^ p + Polynomial.C γ * Polynomial.X

noncomputable def weakTamePolynomial {k : Type*} [Field k]
    (p h : ℕ) (α γ : k) : Polynomial k := (linearizedConstantPolynomial p α γ) ^ h

end Litt3.QuotientGeometry
