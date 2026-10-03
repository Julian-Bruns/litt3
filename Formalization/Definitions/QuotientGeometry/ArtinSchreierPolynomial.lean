import Mathlib.RingTheory.AdjoinRoot

namespace Litt3.QuotientGeometry

noncomputable def artinSchreierPolynomial
    {R : Type*} [CommRing R] (p : ℕ) (a : R) : Polynomial R :=
  Polynomial.X ^ p - Polynomial.X - Polynomial.C a

abbrev ArtinSchreierAlgebra
    (R : Type*) [CommRing R] (p : ℕ) (a : R) := AdjoinRoot (artinSchreierPolynomial p a)

end Litt3.QuotientGeometry
