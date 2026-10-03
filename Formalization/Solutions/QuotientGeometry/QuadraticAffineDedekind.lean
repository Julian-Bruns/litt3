import Solutions.QuotientGeometry.QuadraticAffineAlgebras
import Solutions.QuotientGeometry.QuadraticDedekindOrder
import Definitions.QuotientGeometry.QuadraticOrderEquiv
import Solutions.Jacobians.DedekindTransport
import Mathlib.RingTheory.Polynomial.Basic

namespace Litt3.QuotientGeometry

/-- The actual original monic quadratic ideal quotient is Dedekind:
squarefreeness and a nonconstant branch polynomial suffice in every
characteristic other than two. -/
theorem quadratic_affine_algebra_isDedekindDomain
    {k : Type*} [Field k] (p : Polynomial k)
    (hsquarefree : Squarefree p) (hnonconstant : 0 < p.natDegree) (htwo : (2 : k) ≠ 0) :
    IsDedekindDomain (QuadraticAffineAlgebra p) := by
  have hnonunit : ¬IsUnit p := by
    intro hunit
    exact hnonconstant.ne' (Polynomial.natDegree_eq_zero_of_isUnit hunit)
  have htwoPoly : IsUnit (2 : Polynomial k) := by
    have hunit : IsUnit (2 : k) := isUnit_iff_ne_zero.mpr htwo
    simpa only [map_ofNat] using hunit.map (Polynomial.C : k →+* Polynomial k)
  haveI : IsDedekindDomain (QuadraticAlgebra (Polynomial k) p 0) :=
    quadratic_order_isDedekindDomain (K := RatFunc k) p hsquarefree hnonunit htwoPoly
  exact Litt3.Jacobians.dedekind_domain_of_ring_equiv
    (quadraticMonicOrderEquiv (Polynomial k) p).symm.toRingEquiv

theorem quadratic_affine_algebra_not_isField
    {k : Type*} [Field k] (p : Polynomial k) : ¬IsField (QuadraticAffineAlgebra p) := by
  haveI : Module.Finite (Polynomial k) (QuadraticAffineAlgebra p) :=
    quadratic_affine_algebra_finite p
  have hinj : Function.Injective (algebraMap (Polynomial k) (QuadraticAffineAlgebra p)) := by
    rw [AdjoinRoot.algebraMap_eq]
    apply AdjoinRoot.of.injective_of_degree_ne_zero
    simp [quadraticAffinePolynomial, Polynomial.degree_X_pow_sub_C]
  intro hfield
  exact Ideal.polynomial_not_isField
    (isField_of_isIntegral_of_isField hinj hfield)

end Litt3.QuotientGeometry
