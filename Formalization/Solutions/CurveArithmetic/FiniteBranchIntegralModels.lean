import Solutions.QuotientGeometry.QuadraticPlaneModels
import Solutions.CurveArithmetic.FiniteBranchPolynomial
import Definitions.CurveArithmetic.HyperellipticAffineSchemes
import Mathlib.AlgebraicGeometry.Properties

namespace Litt3.CurveArithmetic

theorem finite_branch_quadratic_plane_equation
    {K L : Type*} [Field K] [Fintype K] [Field L] (a : L) :
    Litt3.QuotientGeometry.quadraticPlaneEquation (finiteBranchPolynomial K a) =
      finiteBranchEquation K a := by
  simp [Litt3.QuotientGeometry.quadraticPlaneEquation, finiteBranchPolynomial,
    finiteBranchEquation]

theorem finite_branch_coordinate_ring_isDomain
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (a : L) (ha : a ∉ Set.range (algebraMap K L)) :
    IsDomain (FiniteBranchCoordinateRing K a) := by
  have hdegree : 0 < (finiteBranchPolynomial K a).natDegree := by
    rw [finite_branch_polynomial_degree]
    exact Nat.succ_pos _
  have hdomain := Litt3.QuotientGeometry.quadratic_plane_coordinate_ring_isDomain
    (finiteBranchPolynomial K a) (finite_branch_polynomial_squarefree a ha) hdegree
  change IsDomain (MvPolynomial (Fin 2) L ⧸ Ideal.span
    {Litt3.QuotientGeometry.quadraticPlaneEquation (finiteBranchPolynomial K a)}) at hdomain
  rw [finite_branch_quadratic_plane_equation (K := K) a] at hdomain
  exact hdomain

theorem finite_branch_affine_scheme_isIntegral
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (a : L) (ha : a ∉ Set.range (algebraMap K L)) :
    AlgebraicGeometry.IsIntegral (finiteBranchAffineScheme K a) := by
  haveI := finite_branch_coordinate_ring_isDomain a ha
  exact inferInstanceAs
    (AlgebraicGeometry.IsIntegral
      (AlgebraicGeometry.Spec (CommRingCat.of (FiniteBranchCoordinateRing K a))))

end Litt3.CurveArithmetic
