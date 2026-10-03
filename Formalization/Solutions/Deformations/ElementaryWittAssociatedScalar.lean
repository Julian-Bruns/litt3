import Solutions.Deformations.ElementaryWittAssociatedMap
import Solutions.Deformations.WittWeightedCoordinatesScalar

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

noncomputable def elementaryAssociatedScalar (r : ℕ) : k →+*
    weightedRootProduct (TruncatedCoefficientRing k N) 5 (truncatedParameter k N) r :=
  (weightedRootTruncation k 5 N (Fact.out : 0 < N) r).comp
    (algebraMap k (weightedRootProduct (Polynomial k) 5 Polynomial.X r))

/-- Actual source coefficient scalars pass to precisely their genuine
Witt residue in the constructed parameter comparison. -/
theorem elementary_witt_associated_map_scalar (r d : ℕ)
    (t : TruncatedWittVector 5 N k)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    elementaryWittAssociatedMap N k r d (t • x) =
      elementaryAssociatedScalar N k r (truncatedWittResidue 5 N (Fact.out : 0 < N) k t) *
        elementaryWittAssociatedMap N k r d x := by
  have coordinates := witt_weighted_coordinates_scalar 5 N (Fact.out : 0 < N) k
    (elementaryAugmentationBasis 5 (by omega) r) 4 d (by omega)
    (fun alpha => ∑ i, (alpha i).val) t x
  change elementaryWittInitialCoordinates N k r d (t • x) =
    truncatedWittResidue 5 N (Fact.out : 0 < N) k t • elementaryWittInitialCoordinates N k r d x at coordinates
  change weightedRootTruncation k 5 N (Fact.out : 0 < N) r
      (weightedInitialPolynomial k 5 (by omega) r d (elementaryWittInitialCoordinates N k r d (t • x))) = _
  rw [coordinates]
  have polynomialScalar := (weightedInitialPolynomialLinear k 5 (by omega) r d).map_smul
    (truncatedWittResidue 5 N (Fact.out : 0 < N) k t) (elementaryWittInitialCoordinates N k r d x)
  change weightedInitialPolynomial k 5 (by omega) r d
      (truncatedWittResidue 5 N (Fact.out : 0 < N) k t • elementaryWittInitialCoordinates N k r d x) =
    truncatedWittResidue 5 N (Fact.out : 0 < N) k t •
      weightedInitialPolynomial k 5 (by omega) r d (elementaryWittInitialCoordinates N k r d x) at polynomialScalar
  rw [polynomialScalar, Algebra.smul_def, map_mul]
  rfl

theorem elementary_witt_associated_map_equal_iff (r d : ℕ)
    (x y : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    elementaryWittAssociatedMap N k r d x = elementaryWittAssociatedMap N k r d y ↔
      (x : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5)) - y ∈
        elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (d + 1) := by
  rw [← sub_eq_zero, ← map_sub, elementary_witt_associated_map_kernel]
  rfl

end Litt3.Deformations
