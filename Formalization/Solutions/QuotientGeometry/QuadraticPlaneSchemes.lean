import Definitions.QuotientGeometry.QuadraticPlaneSchemes
import Solutions.QuotientGeometry.QuadraticPlaneModels
import Solutions.QuotientGeometry.BinarySquarefree
import Solutions.QuotientGeometry.BinaryDegreeBounds
import Mathlib.AlgebraicGeometry.Properties

namespace Litt3.QuotientGeometry

theorem quadratic_plane_affine_scheme_isIntegral
    {k : Type*} [Field k] (p : Polynomial k)
    (hsquarefree : Squarefree p) (hnonconstant : 0 < p.natDegree) :
    AlgebraicGeometry.IsIntegral (quadraticPlaneAffineScheme p) := by
  haveI := quadratic_plane_coordinate_ring_isDomain p hsquarefree hnonconstant
  exact inferInstanceAs
    (AlgebraicGeometry.IsIntegral (AlgebraicGeometry.Spec
      (CommRingCat.of (QuadraticPlaneCoordinateRing p))))

/-- The original binary-sextic hypotheses prove that the actual
quadratic affine Scheme is integral; no dehomogenized irreducibility
hypothesis is added. This does not assert smoothness or genus. -/
theorem squarefree_binary_sextic_affine_scheme_isIntegral
    {k : Type*} [Field k] (H : MvPolynomial (Fin 2) k)
    (hH : H.IsHomogeneous 6) (hHsq : Squarefree H) :
    AlgebraicGeometry.IsIntegral (quadraticPlaneAffineScheme (binaryDehomogenization H)) :=
  quadratic_plane_affine_scheme_isIntegral _
    (binary_dehomogenization_squarefree H 6 hH hHsq)
    (binary_dehomogenization_natDegree_pos H 6 (by decide) hH hHsq)

end Litt3.QuotientGeometry
