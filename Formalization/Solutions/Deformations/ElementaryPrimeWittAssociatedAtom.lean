import Solutions.Deformations.ElementaryPrimeWittAssociatedScalar
import Solutions.Deformations.WittWeightedCoordinateAtom
import Solutions.Deformations.WeightedInitialPolynomialSingle
import Solutions.Deformations.WeightedRootBasisTruncation

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- The actual graded comparison sends every original prime-power
normal generator to its literal parameter monomial, at every precision,
including the genuinely vanished terminal powers. -/
theorem elementary_prime_witt_associated_atom (r j : ℕ) (alpha : Fin r → Fin p) :
    ∃ member : (p : TruncatedWittVector p N k) ^ j •
        elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r alpha ∈
        elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r
          ((p - 1) * j + ∑ i, (alpha i).val),
      elementaryPrimeWittAssociatedMap p N k r ((p - 1) * j + ∑ i, (alpha i).val) ⟨_, member⟩ =
        weightedRootTruncation k p N (Fact.out : 0 < N) r
          (weightedRootPolynomialBasis k p (by have := (Fact.out : p.Prime).two_le; omega) r (j, alpha)) := by
  classical
  have member : (p : TruncatedWittVector p N k) ^ j •
      elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r alpha ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r
        ((p - 1) * j + ∑ i, (alpha i).val) := Submodule.subset_span ⟨j, alpha, le_rfl, rfl⟩
  refine ⟨member, ?_⟩
  by_cases nonterminal : j < N
  · obtain ⟨actualMember, coordinates⟩ := witt_weighted_coordinate_atom p N (Fact.out : 0 < N) k
      (elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r) (p - 1) ((p - 1) * j + ∑ i, (alpha i).val)
      (by have := (Fact.out : p.Prime).two_le; omega) (fun beta => ∑ i, (beta i).val) j nonterminal alpha rfl (1 : k)
    simp only [map_one, mul_one] at coordinates
    change elementaryPrimeWittInitialCoordinates p N k r ((p - 1) * j + ∑ i, (alpha i).val)
      ⟨_, member⟩ = Pi.single alpha 1 at coordinates
    change weightedRootTruncation k p N (Fact.out : 0 < N) r
      (weightedInitialPolynomial k p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * j + ∑ i, (alpha i).val)
        (elementaryPrimeWittInitialCoordinates p N k r ((p - 1) * j + ∑ i, (alpha i).val) ⟨_, member⟩)) = _
    rw [coordinates, weighted_initial_polynomial_single, one_smul,
      basis_weight_exact_exponent (p - 1) ((p - 1) * j + ∑ i, (alpha i).val)
        (∑ i, (alpha i).val) j (by have := (Fact.out : p.Prime).two_le; omega) rfl]
  · have terminal : N ≤ j := by omega
    have sourceZero : (p : TruncatedWittVector p N k) ^ j •
        elementaryAugmentationBasis (R := TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r alpha = 0 := by
      have primeZero : (p : TruncatedWittVector p N k) ^ j = 0 := by
        simpa using truncated_witt_power_zero_above p N k j terminal
      rw [primeZero, zero_smul]
    have zeroSubtype : (⟨_, member⟩ : elementaryNormalWeightFiltration (TruncatedWittVector p N k)
        p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * j + ∑ i, (alpha i).val)) = 0 := Subtype.ext sourceZero
    rw [zeroSubtype, map_zero, weighted_root_polynomial_basis_truncation_zero k p (by have := (Fact.out : p.Prime).two_le; omega)
      N (Fact.out : 0 < N) r j terminal alpha]

end Litt3.Deformations
