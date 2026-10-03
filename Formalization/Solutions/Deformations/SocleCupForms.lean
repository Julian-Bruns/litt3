import Theorems.Deformations.SocleCupForms
import Lean.Elab.Tactic.Omega

namespace Litt3.Deformations

variable {k V ι : Type*} [Field k] [AddCommGroup V] [Module k V] [Fintype ι]

theorem socle_cup_boundary_apply (B : ι → LinearMap.BilinForm k V) (x : ι → V)
    (v : V) : socleCupBoundary B x v = ∑ i, B i (x i) v := by
  simp only [socleCupBoundary, LinearMap.sum_apply, LinearMap.comp_apply,
    LinearMap.proj_apply]

theorem socle_cup_boundary_single [DecidableEq ι]
    (B : ι → LinearMap.BilinForm k V) (i : ι) (v : V) :
    socleCupBoundary B (Pi.single i v) = B i v := by
  classical
  apply LinearMap.ext
  intro w
  rw [socle_cup_boundary_apply]
  rw [Finset.sum_eq_single i]
  · simp
  · intro j _ hji
    simp [hji]
  · simp

/-- The coannihilator of the actual summed boundary is exactly
the common radical. Reflexivity suffices; alternation is not needed. -/
theorem socle_boundary_coannihilator (B : ι → LinearMap.BilinForm k V)
    (reflexive : ∀ i, (B i).IsRefl) :
    (LinearMap.range (socleCupBoundary B)).dualCoannihilator = commonCupRadical B := by
  classical
  ext v
  constructor
  · intro hv
    apply (Submodule.mem_iInf _).mpr
    intro i
    apply LinearMap.mem_ker.mpr
    apply LinearMap.ext
    intro w
    have hz := (Submodule.mem_dualCoannihilator v).mp hv (B i w)
      ⟨Pi.single i w, socle_cup_boundary_single B i w⟩
    exact reflexive i w v hz
  · intro hv
    apply (Submodule.mem_dualCoannihilator v).mpr
    rintro φ ⟨x, rfl⟩
    rw [socle_cup_boundary_apply]
    apply Finset.sum_eq_zero
    intro i _
    have hi := LinearMap.mem_ker.mp ((Submodule.mem_iInf _).mp hv i)
    apply reflexive i v (x i)
    exact congrArg (fun f : V →ₗ[k] k => f (x i)) hi

variable [FiniteDimensional k V]

theorem socle_boundary_kernel_dimension (B : ι → LinearMap.BilinForm k V)
    (reflexive : ∀ i, (B i).IsRefl) :
    Module.finrank k V + Module.finrank k (LinearMap.ker (socleCupBoundary B)) =
      Fintype.card ι * Module.finrank k V + Module.finrank k (commonCupRadical B) := by
  have hdual := Subspace.finrank_add_finrank_dualCoannihilator_eq
    (LinearMap.range (socleCupBoundary B))
  rw [socle_boundary_coannihilator B reflexive] at hdual
  have hrank := (socleCupBoundary B).finrank_range_add_finrank_ker
  rw [Module.finrank_pi_fintype] at hrank
  simp only [Finset.sum_const, Finset.card_univ, smul_eq_mul] at hrank
  omega

variable {W : Type*} [AddCommGroup W] [Module k W] [FiniteDimensional k W]

/-- Rank-nullity derives the complete first-socle count from
the actual section sequence and actual cup-boundary. -/
theorem first_socle_section_count (B : ι → LinearMap.BilinForm k V)
    (reflexive : ∀ i, (B i).IsRefl) (sequence : SocleSectionSequence B W) :
    Specifications.FirstSocleSectionCount B W := by
  have hinc := LinearMap.finrank_range_of_inj sequence.inclusion_injective
  rw [sequence.exact_at_sections] at hinc
  have hproj := sequence.projection.finrank_range_add_finrank_ker
  rw [sequence.exact_at_boundary, hinc] at hproj
  have hcup := socle_boundary_kernel_dimension B reflexive
  unfold Specifications.FirstSocleSectionCount
  omega

end Litt3.Deformations
