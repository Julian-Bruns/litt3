import Definitions.Deformations.WittWeightedBasisInitial
import Solutions.Deformations.WittWeightedInitial

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators

variable (p N : ℕ) [Fact p.Prime] (positive : 0 < N)
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]
variable {M I : Type*} [AddCommGroup M] [Module (TruncatedWittVector p N k) M] [Fintype I]

theorem witt_weighted_basis_representative_coordinate
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (degree : I → ℕ) (c : I → k) (i : I) :
    B.repr (wittWeightedBasisRepresentative p N B w d degree c) i =
      wittWeightedInitialCoefficient p N w d (degree i) (c i) := by
  classical
  simp [wittWeightedBasisRepresentative, map_sum, map_smul, Finsupp.sum_apply,
    Finsupp.smul_apply, B.repr_self, Finsupp.single_apply]

theorem witt_weighted_basis_initial_iff
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (weightPositive : 0 < w) (degree : I → ℕ) (x : M) (c : I → k) :
    WittWeightedBasisInitial p N B w d degree x c ↔
      ∀ i, WittWeightedCoefficientInitial p N w d (degree i) (B.repr x i) (c i) := by
  unfold WittWeightedBasisInitial WittWeightedCoefficientInitial
  rw [basis_weighted_power_mem_iff B _ w weightPositive]
  simp only [map_sub, Finsupp.sub_apply, witt_weighted_basis_representative_coordinate]
  exact forall_and.symm

include positive in
/-- Actual weighted initial coordinates exist uniquely in every finite
fixed basis of an actual Witt module, at every positive precision. -/
theorem witt_weighted_basis_initial_exists_unique
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (weightPositive : 0 < w) (degree : I → ℕ) (x : M)
    (member : x ∈ basisWeightedPowerFiltration B (p : TruncatedWittVector p N k) w degree d) :
    ∃! c : I → k, WittWeightedBasisInitial p N B w d degree x c := by
  classical
  have coordinates := (basis_weighted_power_mem_iff B _ w weightPositive degree d x).mp member
  have initial : ∀ i, ∃! c : k,
      WittWeightedCoefficientInitial p N w d (degree i) (B.repr x i) c := by
    intro i
    exact witt_weighted_coefficient_initial_exists_unique p N positive k w d (degree i)
      weightPositive (B.repr x i) (coordinates i)
  choose c hc unique using initial
  refine ⟨c, (witt_weighted_basis_initial_iff p N k B w d weightPositive degree x c).mpr hc, ?_⟩
  intro other otherInitial
  funext i
  exact unique i (other i)
    ((witt_weighted_basis_initial_iff p N k B w d weightPositive degree x other).mp otherInitial i)

end Litt3.Deformations
