import Theorems.Deformations.SocleGrowth
import Solutions.Deformations.SocleCupForms
import Solutions.Deformations.RadicalComplements
import Mathlib.Data.Fintype.EquivFin
import Lean.Elab.Tactic.Omega

namespace Litt3.Deformations

variable {k V ι : Type*} [Field k] [AddCommGroup V] [Module k V] [Fintype ι]
    [FiniteDimensional k V]

variable {W U : Type*} [AddCommGroup W] [Module k W] [FiniteDimensional k W]
    [AddCommGroup U] [Module k U] [FiniteDimensional k U]

theorem first_socle_section_lower_bound (B : ι → LinearMap.BilinForm k V)
    (reflexive : ∀ i, (B i).IsRefl) (sequence : SocleSectionSequence B W)
    (embedding : W →ₗ[k] U) (injective : Function.Injective embedding) :
    Specifications.SocleSectionLowerBound B U := by
  have hcount := first_socle_section_count B reflexive sequence
  change Module.finrank k W = _ at hcount
  unfold Specifications.SocleSectionLowerBound
  rw [← hcount]
  exact LinearMap.finrank_le_finrank_of_injective injective

/-- Preserving a positive section dimension forces exactly one
cup form and zero complete common radical. -/
theorem socle_bound_preservation (B : ι → LinearMap.BilinForm k V)
    (positive : 0 < Module.finrank k V) (nontrivial : 0 < Fintype.card ι)
    (bound : Fintype.card ι * Module.finrank k V +
      Module.finrank k (commonCupRadical B) ≤ Module.finrank k V) :
    Fintype.card ι = 1 ∧ commonCupRadical B = ⊥ := by
  have hcard : Fintype.card ι ≤ 1 := by
    by_contra h
    have htwo : 2 ≤ Fintype.card ι := by omega
    have hmul := Nat.mul_le_mul_right (Module.finrank k V) htwo
    omega
  have hone : Fintype.card ι = 1 := by omega
  have hzero : Module.finrank k (commonCupRadical B) = 0 := by
    rw [hone, one_mul] at bound
    omega
  exact ⟨hone, Submodule.finrank_eq_zero.mp hzero⟩

theorem socle_bound_preservation_even (two_ne_zero : (2 : k) ≠ 0)
    (B : ι → LinearMap.BilinForm k V) (alternating : ∀ i, (B i).IsAlt)
    (positive : 0 < Module.finrank k V) (nontrivial : 0 < Fintype.card ι)
    (bound : Fintype.card ι * Module.finrank k V +
      Module.finrank k (commonCupRadical B) ≤ Module.finrank k V) :
    Even (Module.finrank k V) := by
  obtain ⟨hone, hrad⟩ := socle_bound_preservation B positive nontrivial bound
  obtain ⟨i, hi⟩ := Fintype.card_eq_one_iff.mp hone
  have hkernel : LinearMap.ker (B i) = commonCupRadical B := by
    ext v
    simp only [commonCupRadical, Submodule.mem_iInf]
    constructor
    · intro hv j
      simpa only [hi j] using hv
    · intro hv
      exact hv i
  apply nondegenerate_alternating_finrank_even two_ne_zero (B i) (alternating i)
  apply LinearMap.BilinForm.nondegenerate_iff_ker_eq_bot.mpr
  exact hkernel.trans hrad

/-- Any actual embedding of the first socle sections forces
strict growth when the downstairs dimension is odd. -/
theorem odd_first_socle_strict_growth (two_ne_zero : (2 : k) ≠ 0)
    (B : ι → LinearMap.BilinForm k V) (alternating : ∀ i, (B i).IsAlt)
    (nontrivial : 0 < Fintype.card ι) (odd : Odd (Module.finrank k V))
    (sequence : SocleSectionSequence B W) (embedding : W →ₗ[k] U)
    (injective : Function.Injective embedding) :
    Module.finrank k V + 1 ≤ Module.finrank k U := by
  have lower := first_socle_section_lower_bound B (fun i => (alternating i).isRefl)
    sequence embedding injective
  change Fintype.card ι * Module.finrank k V +
    Module.finrank k (commonCupRadical B) ≤ Module.finrank k U at lower
  by_contra h
  have upper : Module.finrank k U ≤ Module.finrank k V := by omega
  have heven := socle_bound_preservation_even two_ne_zero B alternating odd.pos nontrivial
    (lower.trans upper)
  exact (Nat.not_even_iff_odd.mpr odd) heven

/-- Every alternating form on an actual one-dimensional
space vanishes, by the even rank of its nondegenerate part. -/
theorem alternating_one_dimensional_radical (two_ne_zero : (2 : k) ≠ 0)
    (B : LinearMap.BilinForm k V) (alternating : B.IsAlt)
    (one_dimensional : Module.finrank k V = 1) : BilinearRadical B = ⊤ := by
  obtain ⟨S, hS, _, heven⟩ := alternating_radical_complement_even_dimension
    two_ne_zero B alternating
  have hle := Submodule.finrank_le S
  rw [one_dimensional] at hle
  have hzero : Module.finrank k S = 0 := by
    obtain ⟨n, hn⟩ := heven
    omega
  have hbot := Submodule.finrank_eq_zero.mp hzero
  have htop := hS.sup_eq_top
  simpa only [hbot, bot_sup_eq] using htop

theorem one_dimensional_first_socle_lower_bound (two_ne_zero : (2 : k) ≠ 0)
    (B : ι → LinearMap.BilinForm k V) (alternating : ∀ i, (B i).IsAlt)
    (one_dimensional : Module.finrank k V = 1)
    (sequence : SocleSectionSequence B W) (embedding : W →ₗ[k] U)
    (injective : Function.Injective embedding) :
    1 + Fintype.card ι ≤ Module.finrank k U := by
  have hrad : commonCupRadical B = ⊤ := by
    simp only [commonCupRadical]
    have each : ∀ i, BilinearRadical (B i) = ⊤ := fun i =>
      alternating_one_dimensional_radical two_ne_zero (B i) (alternating i) one_dimensional
    simp only [each, iInf_top]
  have lower := first_socle_section_lower_bound B (fun i => (alternating i).isRefl)
    sequence embedding injective
  change Fintype.card ι * Module.finrank k V +
    Module.finrank k (commonCupRadical B) ≤ Module.finrank k U at lower
  rw [hrad, finrank_top, one_dimensional, mul_one] at lower
  omega

/-- The numerical deck-subgroup bound follows from the actual
socle sequence and positive invariant section dimension. -/
theorem first_socle_generator_dimension_bound (two_ne_zero : (2 : k) ≠ 0)
    (B : ι → LinearMap.BilinForm k V) (alternating : ∀ i, (B i).IsAlt)
    (positive : 0 < Module.finrank k V) (nontrivial : 0 < Fintype.card ι)
    (sequence : SocleSectionSequence B W) (embedding : W →ₗ[k] U)
    (injective : Function.Injective embedding) :
    Fintype.card ι + 1 ≤ Module.finrank k U := by
  by_cases hone : Module.finrank k V = 1
  · have h := one_dimensional_first_socle_lower_bound two_ne_zero B alternating hone
      sequence embedding injective
    omega
  · have htwo : 2 ≤ Module.finrank k V := by omega
    have lower := first_socle_section_lower_bound B (fun i => (alternating i).isRefl)
      sequence embedding injective
    change Fintype.card ι * Module.finrank k V +
      Module.finrank k (commonCupRadical B) ≤ Module.finrank k U at lower
    have hmul := Nat.mul_le_mul_left (Fintype.card ι) htwo
    omega

end Litt3.Deformations
