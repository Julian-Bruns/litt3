import Theorems.Deformations.FinitePGroupModuleCriteria
import Solutions.Deformations.PGroupCohomologyFreeness
import Solutions.Deformations.PGroupNormFreeness

namespace Litt3.Deformations

universe u

variable {p : ℕ} [Fact p.Prime] {k G V : Type u} [Field k] [CharP k p]
    [Group G] [Fintype G] [AddCommGroup V] [Module k V] [FiniteDimensional k V]

/-- Both actual dimension inequalities, maximal-growth equivalence,
genuine H¹ equivalence and actual norm equivalence are proved together,
over every characteristic-p field and actual finite p-group. -/
theorem finite_p_group_module_criteria (group : IsPGroup p G) (ρ : Representation k G V) :
    Specifications.FinitePGroupModuleCriteria ρ :=
  ⟨p_group_representation_growth group ρ, p_group_maximal_growth_freeness group ρ,
    p_group_cohomology_freeness group ρ, p_group_norm_freeness group ρ⟩

end Litt3.Deformations
