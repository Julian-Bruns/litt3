import Solutions.Deformations.ElementaryWittRepairCoordinates
import Solutions.Deformations.ElementaryWittInitialPolynomial
import Solutions.Deformations.ElementaryCriticalParameterDivisibility
import Solutions.Deformations.ElementaryWittFrobeniusCoordinates

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

/-- The actual critical repair condition is exactly literal parameter
divisibility of the actual unchanged-coordinate initial polynomial. -/
theorem elementary_witt_critical_repair_polynomial (r : ℕ) (positive : 0 < r)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (4 * r - 1)) :
    x.val ∈ elementaryWittRepairSpace N k r ↔
      ∃ y : weightedRootProduct (Polynomial k) 5 Polynomial.X r,
        elementaryWittInitialPolynomial N k r (4 * r - 1) x = (Polynomial.X : Polynomial k) • y := by
  rw [elementary_witt_critical_repair_coordinates N k r positive x,
    elementary_critical_parameter_divisibility k r positive _
      (elementary_witt_initial_polynomial_homogeneous N k r (4 * r - 1) x)]
  apply forall_congr'
  intro i
  rw [elementary_witt_initial_polynomial_own_degree N k r (4 * r - 1) x _
    (elementary_detector_exponent_degree r i)]

/-- Genuine coefficient Frobenius preserves exactly the actual
critical permitted repair condition, retaining its coefficient twist. -/
theorem elementary_witt_critical_frobenius_repair (r : ℕ) (positive : 0 < r)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (4 * r - 1)) :
    (elementaryWittFrobeniusWeight N k r (4 * r - 1) x).val ∈ elementaryWittRepairSpace N k r ↔
      x.val ∈ elementaryWittRepairSpace N k r := by
  rw [elementary_witt_critical_repair_coordinates N k r positive,
    elementary_witt_critical_repair_coordinates N k r positive,
    elementary_witt_frobenius_initial_coordinates]
  apply forall_congr'
  intro i
  exact (_root_.frobeniusEquiv k 5).map_eq_zero_iff

end Litt3.Deformations
