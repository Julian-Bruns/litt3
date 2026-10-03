import Solutions.Deformations.WittWeightedBasisInitial
import Solutions.Deformations.WittWeightedInitialAdd

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators

variable (p N : ℕ) [Fact p.Prime] (positive : 0 < N)
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]
variable {M I : Type*} [AddCommGroup M] [Module (TruncatedWittVector p N k) M] [Fintype I]

theorem witt_weighted_basis_representative_zero
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (degree : I → ℕ) :
    wittWeightedBasisRepresentative p N B w d degree (0 : I → k) = 0 := by
  simp only [wittWeightedBasisRepresentative, Pi.zero_apply,
    witt_weighted_initial_coefficient_zero, zero_smul, Finset.sum_const_zero]

theorem witt_weighted_basis_representative_member
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (weightPositive : 0 < w) (degree : I → ℕ) (c : I → k) :
    wittWeightedBasisRepresentative p N B w d degree c ∈
      basisWeightedPowerFiltration B (p : TruncatedWittVector p N k) w degree d := by
  classical
  rw [basis_weighted_power_mem_iff B _ w weightPositive]
  intro i
  rw [witt_weighted_basis_representative_coordinate, wittWeightedInitialCoefficient]
  split_ifs
  · exact dvd_mul_right _ _
  · exact dvd_zero _

include positive in
theorem witt_weighted_basis_initial_zero_iff
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (weightPositive : 0 < w) (degree : I → ℕ) (x : M) (c : I → k)
    (initial : WittWeightedBasisInitial p N B w d degree x c) :
    c = 0 ↔ x ∈ basisWeightedPowerFiltration B (p : TruncatedWittVector p N k) w degree (d + 1) := by
  rw [basis_weighted_power_mem_iff B _ w weightPositive]
  have coefficients := (witt_weighted_basis_initial_iff p N k B w d weightPositive degree x c).mp initial
  constructor
  · intro zero i
    exact (witt_weighted_coefficient_initial_zero_iff p N positive k w d (degree i)
      weightPositive (B.repr x i) (c i) (coefficients i)).mp (by rw [zero, Pi.zero_apply])
  · intro higher
    funext i
    exact (witt_weighted_coefficient_initial_zero_iff p N positive k w d (degree i)
      weightPositive (B.repr x i) (c i) (coefficients i)).mpr (higher i)

include positive in
theorem witt_weighted_basis_initial_add
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (weightPositive : 0 < w) (degree : I → ℕ) (x y : M) (c e : I → k)
    (initial : WittWeightedBasisInitial p N B w d degree x c)
    (initial' : WittWeightedBasisInitial p N B w d degree y e) :
    WittWeightedBasisInitial p N B w d degree (x + y) (c + e) := by
  rw [witt_weighted_basis_initial_iff p N k B w d weightPositive]
  intro i
  rw [map_add, Finsupp.add_apply]
  exact witt_weighted_coefficient_initial_add p N positive k w d (degree i) weightPositive _ _ _ _
    ((witt_weighted_basis_initial_iff p N k B w d weightPositive degree x c).mp initial i)
    ((witt_weighted_basis_initial_iff p N k B w d weightPositive degree y e).mp initial' i)

end Litt3.Deformations
