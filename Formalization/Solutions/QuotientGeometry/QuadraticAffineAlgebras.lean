import Definitions.QuotientGeometry.QuadraticAffineAlgebras
import Solutions.QuotientGeometry.QuadraticFunctionFields

namespace Litt3.QuotientGeometry

theorem quadratic_affine_polynomial_monic
    {k : Type*} [Field k] (p : Polynomial k) :
    (quadraticAffinePolynomial p).Monic :=
  Polynomial.monic_X_pow_sub_C p (by decide)

theorem quadratic_affine_polynomial_irreducible
    {k : Type*} [Field k] (p : Polynomial k)
    (hsquarefree : Squarefree p) (hnonconstant : 0 < p.natDegree) :
    Irreducible (quadraticAffinePolynomial p) := by
  apply ((quadratic_affine_polynomial_monic p).irreducible_iff_irreducible_map_fraction_map
    (K := RatFunc k)).mpr
  simpa [quadraticAffinePolynomial, quadraticFunctionPolynomial] using
    quadratic_function_polynomial_irreducible p hsquarefree hnonconstant

/-- The actual quadratic affine coordinate algebra is an integral
domain whenever the branch polynomial is nonconstant and squarefree,
in arbitrary characteristic. -/
theorem quadratic_affine_algebra_isDomain
    {k : Type*} [Field k] (p : Polynomial k)
    (hsquarefree : Squarefree p) (hnonconstant : 0 < p.natDegree) :
    IsDomain (QuadraticAffineAlgebra p) :=
  AdjoinRoot.isDomain_of_prime
    (quadratic_affine_polynomial_irreducible p hsquarefree hnonconstant).prime

theorem quadratic_affine_algebra_free
    {k : Type*} [Field k] (p : Polynomial k) :
    Module.Free (Polynomial k) (QuadraticAffineAlgebra p) :=
  (quadratic_affine_polynomial_monic p).free_adjoinRoot

theorem quadratic_affine_algebra_finite
    {k : Type*} [Field k] (p : Polynomial k) :
    Module.Finite (Polynomial k) (QuadraticAffineAlgebra p) :=
  (quadratic_affine_polynomial_monic p).finite_adjoinRoot

theorem quadratic_affine_algebra_rank
    {k : Type*} [Field k] (p : Polynomial k) :
    Module.finrank (Polynomial k) (QuadraticAffineAlgebra p) = 2 := by
  rw [(AdjoinRoot.powerBasis' (quadratic_affine_polynomial_monic p)).finrank]
  exact Polynomial.natDegree_X_pow_sub_C

end Litt3.QuotientGeometry
