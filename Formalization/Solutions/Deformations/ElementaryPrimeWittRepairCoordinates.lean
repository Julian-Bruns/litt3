import Definitions.Deformations.ElementaryPrimeWittRepairSpace
import Solutions.Deformations.ElementaryPrimeWittOwnDegree
import Solutions.Deformations.GroupNormalCoordinates
import Solutions.Deformations.GroupCoefficientKernel
import Solutions.Deformations.ElementaryPrimeCriticalExponents

set_option maxHeartbeats 1800000

namespace Litt3.Deformations

open scoped BigOperators

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

theorem elementary_prime_witt_prime_space_residue (r : ℕ)
    (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p)) :
    x ∈ elementaryPrimeWittPrimeSpace p N k r ↔
      AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
        (truncatedWittResidue p N (Fact.out : 0 < N) k) x = 0 := by
  change (∃ z, (p : TruncatedWittVector p N k) • z = x) ↔ _
  simpa only [Algebra.smul_def, map_natCast, Nat.cast_ofNat] using
    (truncated_witt_group_residue_kernel p N (Fact.out : 0 < N) k (Fin r → ZMod p) x).symm

theorem elementary_prime_witt_prime_space_coordinates (r : ℕ)
    (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p)) :
    x ∈ elementaryPrimeWittPrimeSpace p N k r ↔
      ∀ alpha : Fin r → Fin p, truncatedWittResidue p N (Fact.out : 0 < N) k
        ((elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r).repr x alpha) = 0 := by
  rw [elementary_prime_witt_prime_space_residue]
  constructor
  · intro zero alpha
    have coordinate := congrArg (fun z => (elementaryAugmentationBasis (R := k)
      p (by have := (Fact.out : p.Prime).two_le; omega) r).repr z alpha) zero
    dsimp only at coordinate
    rwa [group_coefficient_map_normal_coordinate, map_zero, Finsupp.zero_apply] at coordinate
  · intro coordinates
    apply (elementaryAugmentationBasis (R := k) p (by have := (Fact.out : p.Prime).two_le; omega) r).repr.injective
    ext alpha
    rw [group_coefficient_map_normal_coordinate, coordinates alpha, map_zero, Finsupp.zero_apply]

/-- The literal actual repair subgroup is detected by precisely the
original critical residue coordinates, with no assumed liftability. -/
theorem elementary_prime_witt_critical_repair_coordinates (large : 2 < p) (r : ℕ) (positive : 0 < r)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * r - 1)) :
    x.val ∈ elementaryPrimeWittRepairSpace p N k r ↔
      ∀ i : Fin r, elementaryPrimeWittInitialCoordinates p N k r ((p - 1) * r - 1) x
        (primeDetectorExponent p large i) = 0 := by
  classical
  let R := TruncatedWittVector p N k
  let B := elementaryAugmentationBasis (R := R) p (by have := (Fact.out : p.Prime).two_le; omega) r
  let d := (p - 1) * r - 1
  have weightPositive : 0 < p - 1 := by omega
  have topPositive : 0 < (p - 1) * r := Nat.mul_pos weightPositive positive
  have index : d + 1 = (p - 1) * r := by dsimp only [d]; omega
  constructor
  · intro repair i
    obtain ⟨u, prime, h, high, sum⟩ := Submodule.mem_sup.mp repair
    let alpha := primeDetectorExponent p large i
    have degree : (∑ j, (alpha j).val) = d := elementary_prime_detector_exponent_degree p large r i
    rw [elementary_prime_witt_initial_own_degree p N k r d x alpha degree]
    have uZero := (elementary_prime_witt_prime_space_coordinates p N k r u).mp prime alpha
    change truncatedWittResidue p N (Fact.out : 0 < N) k (B.repr u alpha) = 0 at uZero
    have coordinates := (elementary_normal_weight_coordinate_iff (R := R)
      p (by have := (Fact.out : p.Prime).two_le; omega) (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * r) h).mp high alpha
    have zeroExponent : basisWeightExponent (p - 1) d d = 0 :=
      Nat.eq_zero_of_le_zero ((basis_weight_exponent_le (p - 1) d d 0 (by have := (Fact.out : p.Prime).two_le; omega)).mpr (by have := (Fact.out : p.Prime).two_le; omega))
    have nextExponent : basisWeightExponent (p - 1) ((p - 1) * r) (∑ j, (alpha j).val) = 1 := by
      rw [degree, ← index, basis_weight_successor_exponent (p - 1) d d (by have := (Fact.out : p.Prime).two_le; omega), zeroExponent,
        if_pos (by have := (Fact.out : p.Prime).two_le; omega)]
    change (p : R) ^ basisWeightExponent (p - 1) ((p - 1) * r) (∑ j, (alpha j).val) ∣ B.repr h alpha at coordinates
    rw [nextExponent, pow_one] at coordinates
    obtain ⟨z, relation⟩ := coordinates
    have hZero : truncatedWittResidue p N (Fact.out : 0 < N) k (B.repr h alpha) = 0 := by
      have residue := congrArg (truncatedWittResidue p N (Fact.out : 0 < N) k) relation
      have fiveZero : (p : k) = 0 := by simpa using CharP.cast_eq_zero k p
      rw [map_mul, map_natCast, fiveZero, zero_mul] at residue
      exact residue
    have equality := congrArg (fun z => truncatedWittResidue p N (Fact.out : 0 < N) k
      (B.repr z alpha)) sum
    simp only [map_add, Finsupp.add_apply, uZero, hZero, zero_add] at equality
    exact equality.symm
  · intro zeroCoordinates
    let c := elementaryPrimeWittInitialCoordinates p N k r d x
    let v := wittWeightedBasisRepresentative p N B (p - 1) d (fun alpha => ∑ i, (alpha i).val) c
    have initial := witt_weighted_coordinates_initial p N (Fact.out : 0 < N) k
      B (p - 1) d (by have := (Fact.out : p.Prime).two_le; omega) (fun alpha => ∑ i, (alpha i).val) x
    have remainder : x.val - v ∈ elementaryNormalWeightFiltration R p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * r) := by
      simpa only [index] using initial.2
    have prime : v ∈ elementaryPrimeWittPrimeSpace p N k r := by
      apply (elementary_prime_witt_prime_space_coordinates p N k r v).mpr
      intro alpha
      rw [witt_weighted_basis_representative_coordinate,
        witt_weighted_initial_coefficient_residue p N (Fact.out : 0 < N) k]
      by_cases active : wittWeightActive (p - 1) d (∑ i, (alpha i).val) N ∧
          basisWeightExponent (p - 1) d (∑ i, (alpha i).val) = 0
      · rw [if_pos active]
        have degree : (∑ i, (alpha i).val) = (p - 1) * r - 1 := by
          have exactWeight := active.1.1
          rw [active.2, Nat.mul_zero, zero_add] at exactWeight
          exact exactWeight
        obtain ⟨i, same⟩ := elementary_prime_critical_exponent_classification p large r positive alpha degree
        subst alpha
        exact zeroCoordinates i
      · rw [if_neg active]
    apply Submodule.mem_sup.mpr
    exact ⟨v, prime, x.val - v, remainder, by abel⟩

end Litt3.Deformations
