import Solutions.Deformations.ElementaryWittAssociatedScalar
import Solutions.Deformations.WittWeightedCoordinateAtom
import Solutions.Deformations.WeightedInitialPolynomialSingle
import Solutions.Deformations.WeightedRootBasisTruncation

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

/-- The actual graded comparison sends every original prime-power
normal generator to its literal parameter monomial, at every precision,
including the genuinely vanished terminal powers. -/
theorem elementary_witt_associated_atom (r j : ℕ) (alpha : Fin r → Fin 5) :
    ∃ member : (5 : TruncatedWittVector 5 N k) ^ j •
        elementaryAugmentationBasis 5 (by omega) r alpha ∈
        elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r
          (4 * j + ∑ i, (alpha i).val),
      elementaryWittAssociatedMap N k r (4 * j + ∑ i, (alpha i).val) ⟨_, member⟩ =
        weightedRootTruncation k 5 N (Fact.out : 0 < N) r
          (weightedRootPolynomialBasis k 5 (by omega) r (j, alpha)) := by
  classical
  have member : (5 : TruncatedWittVector 5 N k) ^ j •
      elementaryAugmentationBasis 5 (by omega) r alpha ∈
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r
        (4 * j + ∑ i, (alpha i).val) := Submodule.subset_span ⟨j, alpha, le_rfl, rfl⟩
  refine ⟨member, ?_⟩
  by_cases nonterminal : j < N
  · obtain ⟨actualMember, coordinates⟩ := witt_weighted_coordinate_atom 5 N (Fact.out : 0 < N) k
      (elementaryAugmentationBasis 5 (by omega) r) 4 (4 * j + ∑ i, (alpha i).val)
      (by omega) (fun beta => ∑ i, (beta i).val) j nonterminal alpha rfl (1 : k)
    simp only [map_one, mul_one] at coordinates
    change elementaryWittInitialCoordinates N k r (4 * j + ∑ i, (alpha i).val)
      ⟨_, member⟩ = Pi.single alpha 1 at coordinates
    change weightedRootTruncation k 5 N (Fact.out : 0 < N) r
      (weightedInitialPolynomial k 5 (by omega) r (4 * j + ∑ i, (alpha i).val)
        (elementaryWittInitialCoordinates N k r (4 * j + ∑ i, (alpha i).val) ⟨_, member⟩)) = _
    rw [coordinates, weighted_initial_polynomial_single, one_smul,
      basis_weight_exact_exponent 4 (4 * j + ∑ i, (alpha i).val)
        (∑ i, (alpha i).val) j (by omega) rfl]
  · have terminal : N ≤ j := by omega
    have sourceZero : (5 : TruncatedWittVector 5 N k) ^ j •
        elementaryAugmentationBasis (R := TruncatedWittVector 5 N k) 5 (by omega) r alpha = 0 := by
      have primeZero : (5 : TruncatedWittVector 5 N k) ^ j = 0 := by
        simpa using truncated_witt_power_zero_above 5 N k j terminal
      rw [primeZero, zero_smul]
    have zeroSubtype : (⟨_, member⟩ : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k)
        5 (by omega) r (4 * j + ∑ i, (alpha i).val)) = 0 := Subtype.ext sourceZero
    rw [zeroSubtype, map_zero, weighted_root_polynomial_basis_truncation_zero k 5 (by omega)
      N (Fact.out : 0 < N) r j terminal alpha]

end Litt3.Deformations
