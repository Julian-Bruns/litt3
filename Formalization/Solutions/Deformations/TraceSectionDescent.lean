import Theorems.Deformations.TraceSectionDescent
import Solutions.Deformations.PGroupNormFreeness

namespace Litt3.Deformations.TraceSectionDescentData

open scoped MonoidAlgebra

section Ring

variable {k G V D : Type*} [CommRing k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V] [AddCommGroup D] [Module k D]
    (data : TraceSectionDescentData k G V D)

theorem pullback_invariant (d : D) : data.pullback d ∈ data.action.invariants := by
  rw [← data.invariantImage]
  exact ⟨d, rfl⟩

theorem pullback_trace (v : V) : data.pullback (data.trace v) = data.action.norm v :=
  LinearMap.congr_fun data.fullNormIdentity v

/-- The actual full section trace is onto precisely when the literal
full group norm covers the whole invariant space. -/
theorem trace_surjective_iff_norm_cover :
    Function.Surjective data.trace ↔ RepresentationNormCoversInvariants data.action := by
  constructor
  · intro surjective v fixed
    rw [← data.invariantImage] at fixed
    obtain ⟨d, rfl⟩ := fixed
    obtain ⟨w, hw⟩ := surjective d
    exact ⟨w, (data.pullback_trace w).symm.trans (congrArg data.pullback hw)⟩
  · intro cover d
    obtain ⟨v, hv⟩ := cover (data.pullback d) (data.pullback_invariant d)
    exact ⟨v, data.pullbackInjective ((data.pullback_trace v).trans hv)⟩

/-- The literal full trace also has the expected degree identity on
actual descended sections, including characteristic dividing the degree. -/
theorem trace_pullback (d : D) : data.trace (data.pullback d) = Fintype.card G • d := by
  apply data.pullbackInjective
  rw [data.pullback_trace, map_nsmul]
  simp only [Representation.norm, LinearMap.sum_apply]
  simp only [(Representation.mem_invariants data.action _).mp (data.pullback_invariant d)]
  simp

end Ring

section Field

variable {p : ℕ} [Fact p.Prime] {k G V D : Type*} [Field k] [CharP k p]
    [Group G] [Fintype G] [AddCommGroup V] [Module k V] [AddCommGroup D] [Module k D]
    (data : TraceSectionDescentData k G V D)

/-- The complete actual trace/freeness bridge for every finite p-group,
with arbitrary coefficient-module dimension. -/
theorem p_group_trace_section_freeness (group : IsPGroup p G) :
    Specifications.TraceSectionFreeness data :=
  (p_group_norm_freeness group data.action).trans data.trace_surjective_iff_norm_cover.symm

end Field

end Litt3.Deformations.TraceSectionDescentData
