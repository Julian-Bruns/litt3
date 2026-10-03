import Solutions.Deformations.WittWeightedCoordinateMap
import Solutions.Deformations.WittWeightActive

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] (positive : 0 < N)
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]
variable {M I : Type*} [AddCommGroup M] [Module (TruncatedWittVector p N k) M] [Fintype I] [DecidableEq I]

include positive in
/-- Every literal original normal prime-power Teichmüller term has
exactly its expected single initial residue coordinate. -/
theorem witt_weighted_coordinate_atom
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (weightPositive : 0 < w) (degree : I → ℕ)
    (j : ℕ) (nonterminal : j < N) (i : I) (exactWeight : d = w * j + degree i) (c : k) :
    ∃ member : ((p : TruncatedWittVector p N k) ^ j *
        WittVector.truncate N (WittVector.teichmuller p c)) • B i ∈
        basisWeightedPowerFiltration B (p : TruncatedWittVector p N k) w degree d,
      wittWeightedCoordinatesAdd p N positive k B w d weightPositive degree
        ⟨_, member⟩ = Pi.single i c := by
  classical
  have exponent : basisWeightExponent w d (degree i) = j :=
    basis_weight_exact_exponent w d (degree i) j weightPositive exactWeight
  have active : wittWeightActive w d (degree i) N :=
    (witt_weight_active_iff w d (degree i) N weightPositive).mpr ⟨j, nonterminal, exactWeight⟩
  have member : ((p : TruncatedWittVector p N k) ^ j *
      WittVector.truncate N (WittVector.teichmuller p c)) • B i ∈
      basisWeightedPowerFiltration B (p : TruncatedWittVector p N k) w degree d := by
    have generator : (p : TruncatedWittVector p N k) ^ j • B i ∈
        basisWeightedPowerFiltration B (p : TruncatedWittVector p N k) w degree d :=
      Submodule.subset_span ⟨j, i, exactWeight.le, rfl⟩
    have scaled := Submodule.smul_mem _ (WittVector.truncate N (WittVector.teichmuller p c)) generator
    simpa only [smul_smul, mul_comm] using scaled
  refine ⟨member, ?_⟩
  have initial : WittWeightedBasisInitial p N B w d degree
      (((p : TruncatedWittVector p N k) ^ j *
        WittVector.truncate N (WittVector.teichmuller p c)) • B i) (Pi.single i c) := by
    rw [witt_weighted_basis_initial_iff p N k B w d weightPositive]
    intro t
    by_cases same : t = i
    · subst t
      simp only [map_smul, Finsupp.smul_apply, smul_eq_mul, B.repr_self,
        Finsupp.single_eq_same, mul_one, Pi.single_eq_same]
      constructor
      · intro inactive
        exact (inactive active).elim
      · rw [wittWeightedInitialCoefficient, if_pos active, exponent, sub_self]
        exact dvd_zero _
    · simp only [map_smul, Finsupp.smul_apply, smul_eq_mul, B.repr_self,
        Finsupp.single_eq_of_ne same, mul_zero, Pi.single_eq_of_ne same]
      constructor
      · intro _
        rfl
      · rw [witt_weighted_initial_coefficient_zero, sub_zero]
        exact dvd_zero _
  exact ((Classical.choose_spec (witt_weighted_basis_initial_exists_unique p N positive k B w d
    weightPositive degree _ member)).2 _ initial).symm

end Litt3.Deformations
