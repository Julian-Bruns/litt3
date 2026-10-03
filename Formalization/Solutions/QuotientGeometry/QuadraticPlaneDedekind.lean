import Solutions.QuotientGeometry.QuadraticAffineDedekind
import Solutions.QuotientGeometry.QuadraticPlaneSchemes
import Solutions.Jacobians.DedekindSpec

namespace Litt3.QuotientGeometry

theorem quadratic_plane_coordinate_ring_isDedekindDomain
    {k : Type*} [Field k] (p : Polynomial k)
    (hsquarefree : Squarefree p) (hnonconstant : 0 < p.natDegree) (htwo : (2 : k) ≠ 0) :
    IsDedekindDomain (QuadraticPlaneCoordinateRing p) := by
  haveI := quadratic_affine_algebra_isDedekindDomain p hsquarefree hnonconstant htwo
  exact Litt3.Jacobians.dedekind_domain_of_ring_equiv (quadraticPlaneCoordinateRingEquiv p).symm

theorem quadratic_plane_coordinate_ring_not_isField
    {k : Type*} [Field k] (p : Polynomial k) : ¬IsField (QuadraticPlaneCoordinateRing p) := by
  intro hfield
  exact quadratic_affine_algebra_not_isField p
    (MulEquiv.isField hfield (quadraticPlaneCoordinateRingEquiv p).symm.toMulEquiv)

/-- Squarefreeness supplies the actual closed-point DVR stalks of the
original quadratic affine Scheme. No local valuation or Dedekind-chart
hypothesis is supplied. -/
theorem quadratic_plane_affine_dvr_stalks
    {k : Type*} [Field k] (p : Polynomial k)
    (hsquarefree : Squarefree p) (hnonconstant : 0 < p.natDegree) (htwo : (2 : k) ≠ 0) :
    letI := quadratic_plane_affine_scheme_isIntegral p hsquarefree hnonconstant
    Litt3.Jacobians.ClosedPointDVRStalks (quadraticPlaneAffineScheme p) := by
  haveI := quadratic_plane_coordinate_ring_isDedekindDomain p hsquarefree hnonconstant htwo
  exact Litt3.Jacobians.dedekind_spec_dvr_stalks (QuadraticPlaneCoordinateRing p)
    (quadratic_plane_coordinate_ring_not_isField p)

/-- Every actual rational function has finite principal-divisor support
on the genuine squarefree quadratic affine Scheme. -/
theorem quadratic_plane_affine_finite_principal_support
    {k : Type*} [Field k] (p : Polynomial k)
    (hsquarefree : Squarefree p) (hnonconstant : 0 < p.natDegree) (htwo : (2 : k) ≠ 0) :
    letI := quadratic_plane_affine_scheme_isIntegral p hsquarefree hnonconstant
    letI := quadratic_plane_affine_dvr_stalks p hsquarefree hnonconstant htwo
    Litt3.Jacobians.FinitePrincipalSupport (quadraticPlaneAffineScheme p) := by
  haveI := quadratic_plane_coordinate_ring_isDedekindDomain p hsquarefree hnonconstant htwo
  haveI : Litt3.Jacobians.ClosedPointDVRStalks
      (AlgebraicGeometry.Spec (CommRingCat.of (QuadraticPlaneCoordinateRing p))) :=
    quadratic_plane_affine_dvr_stalks p hsquarefree hnonconstant htwo
  exact Litt3.Jacobians.dedekind_spec_finite_principal_support (QuadraticPlaneCoordinateRing p)
    (quadratic_plane_coordinate_ring_not_isField p)

end Litt3.QuotientGeometry
