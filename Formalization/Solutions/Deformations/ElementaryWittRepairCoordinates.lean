import Definitions.Deformations.ElementaryWittRepairSpace
import Solutions.Deformations.ElementaryWittOwnDegree
import Solutions.Deformations.GroupNormalCoordinates
import Solutions.Deformations.GroupCoefficientKernel
import Solutions.Deformations.ElementaryCriticalExponents

set_option maxHeartbeats 1800000

namespace Litt3.Deformations

open scoped BigOperators

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

theorem elementary_witt_prime_space_residue (r : ℕ)
    (x : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5)) :
    x ∈ elementaryWittPrimeSpace N k r ↔
      AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5)
        (truncatedWittResidue 5 N (Fact.out : 0 < N) k) x = 0 := by
  change (∃ z, (5 : TruncatedWittVector 5 N k) • z = x) ↔ _
  simpa only [Algebra.smul_def, map_ofNat, Nat.cast_ofNat] using
    (truncated_witt_group_residue_kernel 5 N (Fact.out : 0 < N) k (Fin r → ZMod 5) x).symm

theorem elementary_witt_prime_space_coordinates (r : ℕ)
    (x : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5)) :
    x ∈ elementaryWittPrimeSpace N k r ↔
      ∀ alpha : Fin r → Fin 5, truncatedWittResidue 5 N (Fact.out : 0 < N) k
        ((elementaryAugmentationBasis 5 (by omega) r).repr x alpha) = 0 := by
  rw [elementary_witt_prime_space_residue]
  constructor
  · intro zero alpha
    have coordinate := congrArg (fun z => (elementaryAugmentationBasis (R := k)
      5 (by omega) r).repr z alpha) zero
    dsimp only at coordinate
    rwa [group_coefficient_map_normal_coordinate, map_zero, Finsupp.zero_apply] at coordinate
  · intro coordinates
    apply (elementaryAugmentationBasis (R := k) 5 (by omega) r).repr.injective
    ext alpha
    rw [group_coefficient_map_normal_coordinate, coordinates alpha, map_zero, Finsupp.zero_apply]

/-- The literal actual repair subgroup is detected by precisely the
original critical residue coordinates, with no assumed liftability. -/
theorem elementary_witt_critical_repair_coordinates (r : ℕ) (positive : 0 < r)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (4 * r - 1)) :
    x.val ∈ elementaryWittRepairSpace N k r ↔
      ∀ i : Fin r, elementaryWittInitialCoordinates N k r (4 * r - 1) x
        (finiteFieldDetectorExponent (ZMod 5) (by norm_num) i) = 0 := by
  classical
  let R := TruncatedWittVector 5 N k
  let B := elementaryAugmentationBasis (R := R) 5 (by omega) r
  let d := 4 * r - 1
  have index : d + 1 = 4 * r := by dsimp only [d]; omega
  constructor
  · intro repair i
    obtain ⟨u, prime, h, high, sum⟩ := Submodule.mem_sup.mp repair
    let alpha := finiteFieldDetectorExponent (ZMod 5) (by norm_num) i
    have degree : (∑ j, (alpha j).val) = d := elementary_detector_exponent_degree r i
    rw [elementary_witt_initial_own_degree N k r d x alpha degree]
    have uZero := (elementary_witt_prime_space_coordinates N k r u).mp prime alpha
    change truncatedWittResidue 5 N (Fact.out : 0 < N) k (B.repr u alpha) = 0 at uZero
    have coordinates := (elementary_normal_weight_coordinate_iff (R := R)
      5 (by omega) (by omega) r (4 * r) h).mp high alpha
    have zeroExponent : basisWeightExponent 4 d d = 0 :=
      Nat.eq_zero_of_le_zero ((basis_weight_exponent_le 4 d d 0 (by omega)).mpr (by omega))
    have nextExponent : basisWeightExponent 4 (4 * r) (∑ j, (alpha j).val) = 1 := by
      rw [degree, ← index, basis_weight_successor_exponent 4 d d (by omega), zeroExponent,
        if_pos (by omega)]
    change (5 : R) ^ basisWeightExponent 4 (4 * r) (∑ j, (alpha j).val) ∣ B.repr h alpha at coordinates
    rw [nextExponent, pow_one] at coordinates
    obtain ⟨z, relation⟩ := coordinates
    have hZero : truncatedWittResidue 5 N (Fact.out : 0 < N) k (B.repr h alpha) = 0 := by
      have residue := congrArg (truncatedWittResidue 5 N (Fact.out : 0 < N) k) relation
      have fiveZero : (5 : k) = 0 := by simpa using CharP.cast_eq_zero k 5
      rw [map_mul, map_ofNat, fiveZero, zero_mul] at residue
      exact residue
    have equality := congrArg (fun z => truncatedWittResidue 5 N (Fact.out : 0 < N) k
      (B.repr z alpha)) sum
    simp only [map_add, Finsupp.add_apply, uZero, hZero, zero_add] at equality
    exact equality.symm
  · intro zeroCoordinates
    let c := elementaryWittInitialCoordinates N k r d x
    let v := wittWeightedBasisRepresentative 5 N B 4 d (fun alpha => ∑ i, (alpha i).val) c
    have initial := witt_weighted_coordinates_initial 5 N (Fact.out : 0 < N) k
      B 4 d (by omega) (fun alpha => ∑ i, (alpha i).val) x
    have remainder : x.val - v ∈ elementaryNormalWeightFiltration R 5 (by omega) r (4 * r) := by
      simpa only [index] using initial.2
    have prime : v ∈ elementaryWittPrimeSpace N k r := by
      apply (elementary_witt_prime_space_coordinates N k r v).mpr
      intro alpha
      rw [witt_weighted_basis_representative_coordinate,
        witt_weighted_initial_coefficient_residue 5 N (Fact.out : 0 < N) k]
      by_cases active : wittWeightActive 4 d (∑ i, (alpha i).val) N ∧
          basisWeightExponent 4 d (∑ i, (alpha i).val) = 0
      · rw [if_pos active]
        have degree : (∑ i, (alpha i).val) = 4 * r - 1 := by
          have exactWeight := active.1.1
          rw [active.2, Nat.mul_zero, zero_add] at exactWeight
          exact exactWeight
        obtain ⟨i, same⟩ := elementary_critical_exponent_classification r positive alpha degree
        subst alpha
        exact zeroCoordinates i
      · rw [if_neg active]
    apply Submodule.mem_sup.mpr
    exact ⟨v, prime, x.val - v, remainder, by abel⟩

end Litt3.Deformations
