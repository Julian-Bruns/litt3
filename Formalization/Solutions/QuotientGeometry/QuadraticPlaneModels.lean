import Definitions.QuotientGeometry.QuadraticPlaneModels
import Solutions.QuotientGeometry.QuadraticAffineAlgebras
import Mathlib.RingTheory.Ideal.Quotient.Operations

namespace Litt3.QuotientGeometry

theorem plane_polynomial_equiv_first_variable
    (k : Type*) [Field k] :
    planePolynomialEquiv k (MvPolynomial.X 0) = Polynomial.C Polynomial.X := by
  have h : MvPolynomial.finSuccEquiv k 1 (MvPolynomial.X 1) =
      Polynomial.C (MvPolynomial.X 0) :=
    MvPolynomial.finSuccEquiv_X_succ (j := (0 : Fin 1))
  simp [planePolynomialEquiv, h,
    MvPolynomial.pUnitAlgEquiv_apply]

theorem plane_polynomial_equiv_second_variable
    (k : Type*) [Field k] :
    planePolynomialEquiv k (MvPolynomial.X 1) = Polynomial.X := by
  simp [planePolynomialEquiv, MvPolynomial.finSuccEquiv_X_zero]

theorem plane_polynomial_equiv_polynomial_eval
    (k : Type*) [Field k] (p : Polynomial k) :
    planePolynomialEquiv k (Polynomial.aeval (MvPolynomial.X 0) p) = Polynomial.C p := by
  rw [← Polynomial.aeval_algHom_apply, plane_polynomial_equiv_first_variable]
  simpa using (Polynomial.aeval_algHom_apply
    (Polynomial.CAlgHom : Polynomial k →ₐ[k] Polynomial (Polynomial k)) Polynomial.X p)

theorem plane_polynomial_equiv_quadratic_equation
    (k : Type*) [Field k] (p : Polynomial k) :
    planePolynomialEquiv k (quadraticPlaneEquation p) = quadraticAffinePolynomial p := by
  simp only [quadraticPlaneEquation, map_sub, map_pow, plane_polynomial_equiv_second_variable,
    plane_polynomial_equiv_polynomial_eval, quadraticAffinePolynomial]

theorem quadratic_plane_equation_irreducible
    {k : Type*} [Field k] (p : Polynomial k)
    (hsquarefree : Squarefree p) (hnonconstant : 0 < p.natDegree) :
    Irreducible (quadraticPlaneEquation p) := by
  apply (MulEquiv.irreducible_iff (planePolynomialEquiv k)).mp
  rw [plane_polynomial_equiv_quadratic_equation]
  exact quadratic_affine_polynomial_irreducible p hsquarefree hnonconstant

theorem quadratic_plane_coordinate_ring_isDomain
    {k : Type*} [Field k] (p : Polynomial k)
    (hsquarefree : Squarefree p) (hnonconstant : 0 < p.natDegree) :
    IsDomain (QuadraticPlaneCoordinateRing p) :=
  (Ideal.Quotient.isDomain_iff_prime _).mpr
    ((Ideal.span_singleton_prime
      (quadratic_plane_equation_irreducible p hsquarefree hnonconstant).ne_zero).mpr
        (quadratic_plane_equation_irreducible p hsquarefree hnonconstant).prime)

noncomputable def quadraticPlaneCoordinateRingEquiv
    {k : Type*} [Field k] (p : Polynomial k) :
    QuadraticPlaneCoordinateRing p ≃+* QuadraticAffineAlgebra p :=
  Ideal.quotientEquiv (Ideal.span {quadraticPlaneEquation p})
    (Ideal.span {quadraticAffinePolynomial p}) (planePolynomialEquiv k).toRingEquiv (by
      rw [Ideal.map_span, Set.image_singleton]
      exact congrArg (fun q => Ideal.span {q})
        (plane_polynomial_equiv_quadratic_equation k p).symm)

end Litt3.QuotientGeometry
