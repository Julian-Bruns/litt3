import Solutions.Deformations.TraceSectionDescent

namespace Litt3.Deformations.TraceSectionDescentData

variable {R G V D H : Type*} [CommRing R] [Group G] [Fintype G]
    [AddCommGroup V] [Module R V] [AddCommGroup D] [Module R D]
    [AddCommGroup H] [Module R H] (data : TraceSectionDescentData R G V D)

/-- Actual exactness of the section-trace boundary sequence and
vanishing of its actual boundary target imply full trace surjectivity.
This is the precise cohomological input required by the freeness bridge. -/
theorem trace_surjective_of_exact_boundary [Subsingleton H]
    (boundary : D →ₗ[R] H)
    (exact : LinearMap.range data.trace = LinearMap.ker boundary) :
    Function.Surjective data.trace := by
  intro d
  have zero : boundary d = 0 := Subsingleton.elim _ _
  have member : d ∈ LinearMap.range data.trace := by
    rw [exact]
    exact zero
  exact member

end Litt3.Deformations.TraceSectionDescentData

namespace Litt3.Deformations

open scoped MonoidAlgebra

variable {p : ℕ} [Fact p.Prime] {k G V D H : Type*} [Field k] [CharP k p]
    [Group G] [Fintype G] [AddCommGroup V] [Module k V]
    [AddCommGroup D] [Module k D] [AddCommGroup H] [Module k H]

/-- Full group-algebra freeness of actual coefficient sections follows
from the actual trace exact sequence and its acyclic trace-kernel term.
The geometric exact sequence and actual vanishing are explicit inputs;
freeness, norm surjectivity and group H¹ vanishing are not assumed. -/
theorem p_group_sections_free_of_trace_boundary_vanishing
    (group : IsPGroup p G) (data : TraceSectionDescentData k G V D)
    [Subsingleton H] (boundary : D →ₗ[k] H)
    (exact : LinearMap.range data.trace = LinearMap.ker boundary) :
    Module.Free k[G] data.action.asModule :=
  (data.p_group_trace_section_freeness group).mpr
    (data.trace_surjective_of_exact_boundary boundary exact)

end Litt3.Deformations
