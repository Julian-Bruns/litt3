import Definitions.Deformations.RepresentationCocycles
import Solutions.Deformations.RegularFunctionRepresentation

namespace Litt3.Deformations

universe u

variable {k G V : Type u} [CommRing k] [Group G] [AddCommGroup V] [Module k V]

/-- The primitive criterion is equivalent to vanishing of the genuine
group cohomology defined by mathlib's full inhomogeneous cochain complex. -/
theorem group_cohomology_one_vanishes_iff_cocycle_primitives (ρ : Representation k G V) :
    (∀ x : groupCohomology (Rep.of ρ) 1, x = 0) ↔ RepresentationCocyclePrimitives ρ := by
  constructor
  · intro zero c cocycle
    let z : groupCohomology.cocycles₁ (Rep.of ρ) :=
      ⟨c, (groupCohomology.mem_cocycles₁_iff (A := Rep.of ρ) c).mpr cocycle⟩
    have hz := (groupCohomology.H1π_eq_zero_iff z).mp (zero (groupCohomology.H1π _ z))
    obtain ⟨v, hv⟩ := hz
    exact ⟨v, fun g => congrFun hv g⟩
  · intro primitives x
    refine groupCohomology.H1_induction_on (A := Rep.of ρ) (C := fun z => z = 0) x ?_
    intro c
    apply (groupCohomology.H1π_eq_zero_iff c).mpr
    obtain ⟨v, hv⟩ := primitives c
      ((groupCohomology.mem_cocycles₁_iff (A := Rep.of ρ) c).mp c.2)
    exact ⟨v, funext hv⟩

/-- Every actual cocycle in the complete function representation has
an explicit primitive, over any commutative ring and any group. -/
theorem regular_function_cocycle_primitives :
    RepresentationCocyclePrimitives
      (regularFunctionRepresentation (k := k) (G := G) (W := V)) := by
  intro c cocycle
  refine ⟨fun x => c x 1, ?_⟩
  intro g
  ext x
  have h := congrFun (cocycle x g) 1
  change c (x * g) 1 - c x 1 = c g x
  simpa using sub_eq_iff_eq_add.mpr (by simpa using h)

theorem regular_function_group_cohomology_one_vanishes :
    ∀ x : groupCohomology (Rep.of
      (regularFunctionRepresentation (k := k) (G := G) (W := V))) 1, x = 0 :=
  (group_cohomology_one_vanishes_iff_cocycle_primitives _).mpr regular_function_cocycle_primitives

variable {W : Type u} [AddCommGroup W] [Module k W]

/-- Cocycle primitives transport through actual equivariant linear
equivalences; no cohomology representation is supplied as a hypothesis. -/
theorem cocycle_primitives_transport (ρ : Representation k G V) (σ : Representation k G W)
    (e : V ≃ₗ[k] W) (equivariant : ∀ g v, e (ρ g v) = σ g (e v))
    (primitives : RepresentationCocyclePrimitives σ) : RepresentationCocyclePrimitives ρ := by
  intro c cocycle
  obtain ⟨w, hw⟩ := primitives (fun g => e (c g)) (by
    intro g h
    change e (c (g * h)) = σ g (e (c h)) + e (c g)
    rw [cocycle, map_add, equivariant])
  refine ⟨e.symm w, ?_⟩
  intro g
  apply e.injective
  rw [map_sub, equivariant, e.apply_symm_apply]
  exact hw g

end Litt3.Deformations
