import Theorems.Deformations.InvariantOrbitEmbedding
import Solutions.Deformations.RegularFunctionRepresentation
import Solutions.Deformations.PGroupEssentialSocle
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import Mathlib.LinearAlgebra.Dimension.Constructions

namespace Litt3.Deformations

variable {k G V : Type*} [Field k] [Group G] [AddCommGroup V] [Module k V]

@[simp] theorem invariant_retraction_apply (ρ : Representation k G V) (v : ρ.invariants) :
    invariantRetraction ρ v = v :=
  Submodule.linearProjOfIsCompl_apply_left _ v

theorem invariant_orbit_map_equivariant (ρ : Representation k G V) (g : G) (v : V) :
    invariantOrbitMap ρ (ρ g v) = regularFunctionRepresentation (k := k) g
      (invariantOrbitMap ρ v) := projected_orbit_map_equivariant _ _ _ _

theorem invariant_orbit_map_on_invariants (ρ : Representation k G V) (v : ρ.invariants) :
    invariantOrbitMap ρ v = fun _ => v := by
  apply funext
  intro g
  change invariantRetraction ρ (ρ g v.1) = v
  rw [(Representation.mem_invariants ρ v.1).mp v.2 g, invariant_retraction_apply]

/-- Every actual invariant of the function representation is already
the image of an actual invariant of the original representation. -/
theorem invariant_orbit_map_covers_invariants (ρ : Representation k G V)
    (f : G → ρ.invariants)
    (fixed : f ∈ (regularFunctionRepresentation (k := k) (G := G)
      (W := ρ.invariants)).invariants) :
    f ∈ LinearMap.range (invariantOrbitMap ρ) := by
  refine ⟨(f 1).1, ?_⟩
  rw [invariant_orbit_map_on_invariants ρ (f 1)]
  apply funext
  intro g
  exact ((regular_function_invariant_iff_constant f).mp fixed g).symm

variable {p : ℕ} [Fact p.Prime] [CharP k p] [Finite G]

/-- A genuine essential-socle embedding into the full regular function
module on the actual invariant coefficients. No duality, Nakayama,
nilpotence table or supplied embedding is assumed. -/
theorem invariant_orbit_map_injective (group : IsPGroup p G) (ρ : Representation k G V) :
    Function.Injective (invariantOrbitMap ρ) := by
  apply p_group_equivariant_injective_of_invariant_injective group ρ
    (regularFunctionRepresentation (k := k)) (invariantOrbitMap ρ)
  · exact invariant_orbit_map_equivariant ρ
  · intro v fixed zero
    have hv : v ∈ ρ.invariants := (Representation.mem_invariants ρ v).mpr fixed
    have h := congrFun zero 1
    have hret : invariantRetraction ρ v = 0 := by
      simpa only [invariantOrbitMap, projectedOrbitMap, map_one,
        Module.End.one_apply, LinearMap.coe_mk, AddHom.coe_mk, Pi.zero_apply] using h
    have vz := (invariant_retraction_apply ρ ⟨v, hv⟩).symm.trans hret
    exact congrArg Subtype.val vz

variable [FiniteDimensional k V]

/-- The full two-sided defect-growth bound follows from the constructed
actual regular embedding, over every characteristic-p field. -/
theorem p_group_representation_growth (group : IsPGroup p G) (ρ : Representation k G V) :
    Specifications.PGroupRepresentationGrowth ρ := by
  classical
  letI : Fintype G := Fintype.ofFinite G
  refine ⟨Submodule.finrank_le _, ?_⟩
  have h := LinearMap.finrank_le_finrank_of_injective (invariant_orbit_map_injective group ρ)
  simpa [Module.finrank_pi_fintype, Nat.card_eq_fintype_card] using h

end Litt3.Deformations
