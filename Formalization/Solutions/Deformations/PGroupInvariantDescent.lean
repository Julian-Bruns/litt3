import Theorems.Deformations.PGroupInvariantDescent
import Solutions.Deformations.ActualPGroupInvariants
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import Lean.Elab.Tactic.Omega

namespace Litt3.Deformations

section Ring

variable {p : ℕ} [Fact p.Prime] {k G U : Type*} [CommRing k] [CharP k p]
    [Group G] [Finite G] [AddCommGroup U] [Module k U]

/-- An actual finite p-group representation has zero invariant
submodule exactly when its entire actual section module is zero. -/
theorem p_group_invariants_eq_bot_iff (group : IsPGroup p G)
    (ρ : Representation k G U) : ρ.invariants = ⊥ ↔ ∀ u : U, u = 0 := by
  constructor
  · intro hz u
    by_contra hu
    obtain ⟨w, hw, hfix⟩ := nonzero_characteristic_p_group_invariants group ρ ⟨u, hu⟩
    have hmem : w ∈ ρ.invariants := (Representation.mem_invariants ρ w).mpr hfix
    rw [hz] at hmem
    exact hw (by simpa using hmem)
  · intro hz
    ext u
    simp only [Submodule.mem_bot]
    constructor
    · intro _
      exact hz u
    · intro hu
      rw [hu]
      exact Submodule.zero_mem _

end Ring

section Field

variable {p : ℕ} [Fact p.Prime] {k G U : Type*} [Field k] [CharP k p]
    [Group G] [Finite G] [AddCommGroup U] [Module k U] [FiniteDimensional k U]

theorem p_group_invariant_finrank_positive (group : IsPGroup p G)
    (ρ : Representation k G U) (positive : 0 < Module.finrank k U) :
    0 < Module.finrank k ρ.invariants := by
  obtain ⟨u, hu⟩ := Module.finrank_pos_iff_exists_ne_zero.mp positive
  obtain ⟨w, hw, hfix⟩ := nonzero_characteristic_p_group_invariants group ρ ⟨u, hu⟩
  apply Module.finrank_pos_iff_exists_ne_zero.mpr
  exact ⟨⟨w, (Representation.mem_invariants ρ w).mpr hfix⟩,
    by intro h; exact hw (congrArg Subtype.val h)⟩

theorem p_group_invariant_finrank_zero_iff (group : IsPGroup p G)
    (ρ : Representation k G U) :
    Module.finrank k ρ.invariants = 0 ↔ Module.finrank k U = 0 := by
  constructor
  · intro hz
    by_contra hu
    have positive : 0 < Module.finrank k U := by omega
    have hinv := p_group_invariant_finrank_positive group ρ positive
    omega
  · intro hz
    have hle := Submodule.finrank_le ρ.invariants
    omega

variable {D : Type*} [AddCommGroup D] [Module k D]

/-- An actual injective section pullback with full invariant
range preserves zero sections under an actual p-group action.
Neither geometric descent nor the full invariant range is assumed
from a numerical coincidence. -/
theorem p_group_zero_section_preservation (group : IsPGroup p G)
    (ρ : Representation k G U) (pullback : D →ₗ[k] U)
    (injective : Function.Injective pullback)
    (descent : LinearMap.range pullback = ρ.invariants) :
    Specifications.ZeroSectionPreservation (k := k) (D := D) (U := U) := by
  have hdim := LinearMap.finrank_range_of_inj injective
  rw [descent] at hdim
  unfold Specifications.ZeroSectionPreservation
  rw [← hdim]
  exact p_group_invariant_finrank_zero_iff group ρ

end Field

end Litt3.Deformations
