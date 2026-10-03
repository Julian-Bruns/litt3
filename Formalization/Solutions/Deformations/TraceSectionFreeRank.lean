import Solutions.Deformations.TraceSectionCohomology

namespace Litt3.Deformations.TraceSectionDescentData

open scoped MonoidAlgebra

variable {k G V D : Type*} [Field k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V] [AddCommGroup D] [Module k D]
    (data : TraceSectionDescentData k G V D)

/-- Literal section pullback identifies the full downstairs coefficient
space with the full invariant space. -/
noncomputable def traceSectionInvariantEquiv : D ≃ₗ[k] data.action.invariants :=
  LinearEquiv.ofBijective (data.pullback.codRestrict data.action.invariants data.pullback_invariant)
    ⟨fun _ _ same => data.pullbackInjective (congrArg Subtype.val same), by
      intro v
      have member : (v : V) ∈ LinearMap.range data.pullback := by
        simpa only [data.invariantImage] using v.2
      obtain ⟨d, hd⟩ := member
      exact ⟨d, Subtype.ext hd⟩⟩

variable {p : ℕ} [Fact p.Prime] [CharP k p]

/-- The actual coefficient module has a full group-algebra basis indexed
by the literal downstairs section dimension. It is constructed from the
actual trace, actual invariant pullback and full orbit embedding. -/
noncomputable def traceSectionGroupBasis [FiniteDimensional k D]
    (group : IsPGroup p G) (surjective : Function.Surjective data.trace) :
    Module.Basis (Fin (Module.finrank k D)) k[G] data.action.asModule := by
  let σ := regularFunctionRepresentation (k := k) (G := G) (W := data.action.invariants)
  let e := LinearEquiv.ofBijective (invariantOrbitMap data.action)
    (invariant_orbit_map_bijective_of_norm_cover group data.action
      (data.trace_surjective_iff_norm_cover.mp surjective))
  let eR := representationModuleEquivOfEquivariant data.action σ e
    (invariant_orbit_map_equivariant data.action)
  let b := (Module.finBasis k D).map data.traceSectionInvariantEquiv
  exact (regularFunctionModuleBasis b).map eR.symm

/-- The literal ambient section module is the full free module with
rank equal to the actual downstairs section dimension. -/
noncomputable def traceSectionFreeRankEquiv [FiniteDimensional k D]
    (group : IsPGroup p G) (surjective : Function.Surjective data.trace) :
    data.action.asModule ≃ₗ[k[G]] (Fin (Module.finrank k D) → k[G]) :=
  (data.traceSectionGroupBasis group surjective).equivFun

end Litt3.Deformations.TraceSectionDescentData
