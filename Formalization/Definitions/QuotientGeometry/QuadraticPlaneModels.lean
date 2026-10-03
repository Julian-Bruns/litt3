import Definitions.QuotientGeometry.QuadraticAffineAlgebras
import Mathlib.Algebra.MvPolynomial.Equiv

namespace Litt3.QuotientGeometry

noncomputable def planePolynomialEquiv
    (k : Type*) [Field k] : MvPolynomial (Fin 2) k ≃ₐ[k] Polynomial (Polynomial k) :=
  (MvPolynomial.renameEquiv k (Equiv.swap (0 : Fin 2) 1)).trans
    ((MvPolynomial.finSuccEquiv k 1).trans (Polynomial.mapAlgEquiv
      ((MvPolynomial.renameEquiv k (Equiv.equivPUnit (Fin 1) : Fin 1 ≃ PUnit.{1})).trans
        (MvPolynomial.pUnitAlgEquiv k))))

noncomputable def quadraticPlaneEquation
    {k : Type*} [Field k] (p : Polynomial k) : MvPolynomial (Fin 2) k :=
  MvPolynomial.X 1 ^ 2 - Polynomial.aeval (MvPolynomial.X 0) p

abbrev QuadraticPlaneCoordinateRing
    {k : Type*} [Field k] (p : Polynomial k) :=
  MvPolynomial (Fin 2) k ⧸ Ideal.span {quadraticPlaneEquation p}

end Litt3.QuotientGeometry
