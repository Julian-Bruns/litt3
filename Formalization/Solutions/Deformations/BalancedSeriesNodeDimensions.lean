import Solutions.Deformations.BalancedSeriesNodeEquivalence
import Solutions.Deformations.BalancedNodeDimensions

namespace Litt3.Deformations

variable (R : Type*) [CommRing R] [Nontrivial R]

/-- The actual formal-series quotient by xy,x^Q,y^Q has exact length
2Q−1, constructed from the original coefficients and literal relations. -/
theorem balanced_series_node_finrank (Q : ℕ) (positive : 0 < Q) :
    Module.finrank R (BalancedSeriesNodeAlgebra R Q) = 2 * Q - 1 := by
  rw [(balancedSeriesNodePolynomialEquiv R Q positive).toLinearEquiv.finrank_eq]
  exact balanced_node_finrank R Q positive

end Litt3.Deformations
