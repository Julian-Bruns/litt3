import Solutions.Deformations.ElementaryPrimeWittRepairCoordinates
import Solutions.Deformations.ElementaryPrimeWittInitialPolynomial
import Solutions.Deformations.ElementaryPrimeCriticalParameterDivisibility
import Solutions.Deformations.ElementaryPrimeWittFrobeniusCoordinates

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- The actual critical repair condition is exactly literal parameter
divisibility of the actual unchanged-coordinate initial polynomial. -/
theorem elementary_prime_witt_critical_repair_polynomial (large : 2 < p) (r : ℕ) (positive : 0 < r)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * r - 1)) :
    x.val ∈ elementaryPrimeWittRepairSpace p N k r ↔
      ∃ y : weightedRootProduct (Polynomial k) p Polynomial.X r,
        elementaryPrimeWittInitialPolynomial p N k r ((p - 1) * r - 1) x = (Polynomial.X : Polynomial k) • y := by
  rw [elementary_prime_witt_critical_repair_coordinates p N k large r positive x,
    elementary_prime_critical_parameter_divisibility p k large r positive _
      (elementary_prime_witt_initial_polynomial_homogeneous p N k r ((p - 1) * r - 1) x)]
  apply forall_congr'
  intro i
  rw [elementary_prime_witt_initial_polynomial_own_degree p N k r ((p - 1) * r - 1) x _
    (elementary_prime_detector_exponent_degree p large r i)]

/-- Genuine coefficient Frobenius preserves exactly the actual
critical permitted repair condition, retaining its coefficient twist. -/
theorem elementary_prime_witt_critical_frobenius_repair (large : 2 < p) (r : ℕ) (positive : 0 < r)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * r - 1)) :
    (elementaryPrimeWittFrobeniusWeight p N k r ((p - 1) * r - 1) x).val ∈ elementaryPrimeWittRepairSpace p N k r ↔
      x.val ∈ elementaryPrimeWittRepairSpace p N k r := by
  rw [elementary_prime_witt_critical_repair_coordinates p N k large r positive,
    elementary_prime_witt_critical_repair_coordinates p N k large r positive,
    elementary_prime_witt_frobenius_initial_coordinates]
  apply forall_congr'
  intro i
  exact (_root_.frobeniusEquiv k p).map_eq_zero_iff

end Litt3.Deformations
