import Solutions.Deformations.ElementaryPrimeWittAssociatedMap
import Solutions.Deformations.WittWeightedCoordinatesScalar

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

noncomputable def elementaryPrimeAssociatedScalar (r : ℕ) : k →+*
    weightedRootProduct (TruncatedCoefficientRing k N) p (truncatedParameter k N) r :=
  (weightedRootTruncation k p N (Fact.out : 0 < N) r).comp
    (algebraMap k (weightedRootProduct (Polynomial k) p Polynomial.X r))

/-- Actual source coefficient scalars pass to precisely their genuine
Witt residue in the constructed parameter comparison. -/
theorem elementary_prime_witt_associated_map_scalar (r d : ℕ)
    (t : TruncatedWittVector p N k)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    elementaryPrimeWittAssociatedMap p N k r d (t • x) =
      elementaryPrimeAssociatedScalar p N k r (truncatedWittResidue p N (Fact.out : 0 < N) k t) *
        elementaryPrimeWittAssociatedMap p N k r d x := by
  have coordinates := witt_weighted_coordinates_scalar p N (Fact.out : 0 < N) k
    (elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r) (p - 1) d (by have := (Fact.out : p.Prime).two_le; omega)
    (fun alpha => ∑ i, (alpha i).val) t x
  change elementaryPrimeWittInitialCoordinates p N k r d (t • x) =
    truncatedWittResidue p N (Fact.out : 0 < N) k t • elementaryPrimeWittInitialCoordinates p N k r d x at coordinates
  change weightedRootTruncation k p N (Fact.out : 0 < N) r
      (weightedInitialPolynomial k p (by have := (Fact.out : p.Prime).two_le; omega) r d (elementaryPrimeWittInitialCoordinates p N k r d (t • x))) = _
  rw [coordinates]
  have polynomialScalar := (weightedInitialPolynomialLinear k p (by have := (Fact.out : p.Prime).two_le; omega) r d).map_smul
    (truncatedWittResidue p N (Fact.out : 0 < N) k t) (elementaryPrimeWittInitialCoordinates p N k r d x)
  change weightedInitialPolynomial k p (by have := (Fact.out : p.Prime).two_le; omega) r d
      (truncatedWittResidue p N (Fact.out : 0 < N) k t • elementaryPrimeWittInitialCoordinates p N k r d x) =
    truncatedWittResidue p N (Fact.out : 0 < N) k t •
      weightedInitialPolynomial k p (by have := (Fact.out : p.Prime).two_le; omega) r d (elementaryPrimeWittInitialCoordinates p N k r d x) at polynomialScalar
  rw [polynomialScalar, Algebra.smul_def, map_mul]
  rfl

theorem elementary_prime_witt_associated_map_equal_iff (r d : ℕ)
    (x y : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    elementaryPrimeWittAssociatedMap p N k r d x = elementaryPrimeWittAssociatedMap p N k r d y ↔
      (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p)) - y ∈
        elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r (d + 1) := by
  rw [← sub_eq_zero, ← map_sub, elementary_prime_witt_associated_map_kernel]
  rfl

end Litt3.Deformations
