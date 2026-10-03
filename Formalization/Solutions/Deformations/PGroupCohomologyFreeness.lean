import Theorems.Deformations.PGroupCohomologyFreeness
import Solutions.Deformations.InvariantOrbitEmbedding
import Solutions.Deformations.EquivariantCocycleDescent
import Solutions.Deformations.RegularFunctionTensor
import Solutions.Deformations.RepresentationCocycles
import Solutions.Deformations.RepresentationModuleEquivalences

namespace Litt3.Deformations

open scoped MonoidAlgebra TensorProduct

universe u

section Ring

variable {k G V : Type u} [CommRing k] [Group G] [Finite G]
    [AddCommGroup V] [Module k V]

/-- Every actual free module over any finite group algebra has the
full cocycle-primitive property. The basis may be infinite. -/
theorem free_group_module_cocycle_primitives (ρ : Representation k G V)
    [Module.Free k[G] ρ.asModule] : RepresentationCocyclePrimitives ρ := by
  classical
  let I := Module.Free.ChooseBasisIndex k[G] ρ.asModule
  let C := I →₀ k
  let b : Module.Basis I k C := Finsupp.basisSingleOne
  let σ := regularFunctionRepresentation (k := k) (G := G) (W := C)
  let e : ρ.asModule ≃ₗ[k[G]] σ.asModule :=
    ((Module.Free.chooseBasis k[G] ρ.asModule).equiv
      (b.baseChange k[G]) (Equiv.refl I)).trans regularFunctionTensorModuleEquiv
  exact cocycle_primitives_transport ρ σ (representationEquivOfModuleEquiv ρ σ e)
    (representation_equiv_of_module_equiv_commutes ρ σ e) regular_function_cocycle_primitives

end Ring

section Field

variable {p : ℕ} [Fact p.Prime] {k G V : Type u} [Field k] [CharP k p]
    [Group G] [Finite G] [AddCommGroup V] [Module k V]

/-- Vanishing degree-one cocycles forces the constructed actual
essential-socle embedding to be a full equivariant equivalence. -/
theorem invariant_orbit_map_bijective_of_cocycle_primitives
    (group : IsPGroup p G) (ρ : Representation k G V)
    (primitives : RepresentationCocyclePrimitives ρ) :
    Function.Bijective (invariantOrbitMap ρ) := by
  have injective := invariant_orbit_map_injective group ρ
  refine ⟨injective, ?_⟩
  apply p_group_equivariant_surjective_of_cocycle_primitives group ρ
    (regularFunctionRepresentation (k := k)) (invariantOrbitMap ρ)
    (invariant_orbit_map_equivariant ρ) injective ?_ primitives
  intro w fixed
  exact invariant_orbit_map_covers_invariants ρ w
    ((Representation.mem_invariants _ w).mpr fixed)

theorem p_group_module_free_of_cocycle_primitives (group : IsPGroup p G)
    (ρ : Representation k G V) (primitives : RepresentationCocyclePrimitives ρ) :
    Module.Free k[G] ρ.asModule := by
  let σ := regularFunctionRepresentation (k := k) (G := G) (W := ρ.invariants)
  let e : V ≃ₗ[k] (G → ρ.invariants) :=
    LinearEquiv.ofBijective (invariantOrbitMap ρ)
      (invariant_orbit_map_bijective_of_cocycle_primitives group ρ primitives)
  let eR : ρ.asModule ≃ₗ[k[G]] σ.asModule :=
    representationModuleEquivOfEquivariant ρ σ e (invariant_orbit_map_equivariant ρ)
  exact Module.Free.of_basis
    ((regularFunctionModuleBasis (Module.Free.chooseBasis k ρ.invariants)).map eR.symm)

/-- The genuine actual H¹ vanishes exactly for actual free modules
of a finite p-group over every characteristic-p field. No finite-dimension
assumption, Nakayama input or supplied cohomology model is needed. -/
theorem p_group_cohomology_freeness (group : IsPGroup p G) (ρ : Representation k G V) :
    Specifications.PGroupCohomologyFreeness ρ := by
  constructor
  · intro free
    letI := free
    exact (group_cohomology_one_vanishes_iff_cocycle_primitives ρ).mpr
      (free_group_module_cocycle_primitives ρ)
  · intro zero
    exact p_group_module_free_of_cocycle_primitives group ρ
      ((group_cohomology_one_vanishes_iff_cocycle_primitives ρ).mp zero)

variable [FiniteDimensional k V]

/-- In finite dimension, maximal invariant-normalized growth is
equivalent to actual group-algebra freeness. The full target embedding
is constructed rather than included among the hypotheses. -/
theorem p_group_maximal_growth_freeness (group : IsPGroup p G) (ρ : Representation k G V) :
    Specifications.PGroupMaximalGrowthFreeness ρ := by
  classical
  letI : Fintype G := Fintype.ofFinite G
  have target_dimension : Module.finrank k (G → ρ.invariants) =
      Nat.card G * Module.finrank k ρ.invariants := by
    simp [Module.finrank_pi_fintype, Nat.card_eq_fintype_card]
  constructor
  · intro maximal
    have same_dimension : Module.finrank k V = Module.finrank k (G → ρ.invariants) :=
      maximal.trans target_dimension.symm
    have bijective : Function.Bijective (invariantOrbitMap ρ) :=
      ⟨invariant_orbit_map_injective group ρ,
        (LinearMap.injective_iff_surjective_of_finrank_eq_finrank same_dimension).mp
          (invariant_orbit_map_injective group ρ)⟩
    let e := LinearEquiv.ofBijective (invariantOrbitMap ρ) bijective
    have primitives : RepresentationCocyclePrimitives ρ :=
      cocycle_primitives_transport ρ _ e (invariant_orbit_map_equivariant ρ)
        regular_function_cocycle_primitives
    exact p_group_module_free_of_cocycle_primitives group ρ primitives
  · intro free
    letI := free
    let e := LinearEquiv.ofBijective (invariantOrbitMap ρ)
      (invariant_orbit_map_bijective_of_cocycle_primitives group ρ
        (free_group_module_cocycle_primitives ρ))
    exact e.finrank_eq.trans target_dimension

end Field

end Litt3.Deformations
