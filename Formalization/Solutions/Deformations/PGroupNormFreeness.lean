import Definitions.Deformations.PGroupNormFreeness
import Solutions.Deformations.InvariantOrbitEmbedding
import Solutions.Deformations.RegularFunctionNorm
import Solutions.Deformations.RegularFunctionTensor
import Solutions.Deformations.RepresentationModuleEquivalences
import Solutions.Deformations.RepresentationNormMaps
import Mathlib.LinearAlgebra.Dual.Lemmas

namespace Litt3.Deformations

open scoped MonoidAlgebra TensorProduct

section Ring

variable {k G V : Type*} [CommRing k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V]

theorem free_group_module_norm_covers_invariants (ρ : Representation k G V)
    [Module.Free k[G] ρ.asModule] : RepresentationNormCoversInvariants ρ := by
  classical
  let I := Module.Free.ChooseBasisIndex k[G] ρ.asModule
  let C := I →₀ k
  let b : Module.Basis I k C := Finsupp.basisSingleOne
  let σ := regularFunctionRepresentation (k := k) (G := G) (W := C)
  let eR : ρ.asModule ≃ₗ[k[G]] σ.asModule :=
    ((Module.Free.chooseBasis k[G] ρ.asModule).equiv
      (b.baseChange k[G]) (Equiv.refl I)).trans regularFunctionTensorModuleEquiv
  let e := representationEquivOfModuleEquiv ρ σ eR
  have equivariant : ∀ g v, e (ρ g v) = σ g (e v) :=
    representation_equiv_of_module_equiv_commutes ρ σ eR
  intro v fixed
  have ev_fixed : e v ∈ σ.invariants := by
    apply (Representation.mem_invariants σ _).mpr
    intro g
    rw [← equivariant, (Representation.mem_invariants ρ v).mp fixed g]
  obtain ⟨w, hw⟩ := regular_function_norm_surjective_invariants (e v) ev_fixed
  refine ⟨e.symm w, ?_⟩
  apply e.injective
  calc
    e (ρ.norm (e.symm w)) = σ.norm (e (e.symm w)) :=
      equivariant_map_norm ρ σ e.toLinearMap equivariant _
    _ = e v := by simpa only [e.apply_symm_apply] using hw

end Ring

section Field

variable {p : ℕ} [Fact p.Prime] {k G V C : Type*} [Field k] [CharP k p]
    [Group G] [Fintype G] [AddCommGroup V] [Module k V] [AddCommGroup C] [Module k C]

/-- A specified genuine equivariant map onto enough regular-function
norm coefficients is onto the full function module. The proof uses
actual invariant dual vectors of its actual quotient, with no finite
dimension, nilpotence table or commutative Nakayama assumption. -/
theorem p_group_regular_function_surjective_of_norm_cover (group : IsPGroup p G)
    (ρ : Representation k G V) (f : V →ₗ[k] (G → C))
    (equivariant : ∀ g v, f (ρ g v) = regularFunctionRepresentation (k := k) g (f v))
    (cover : ∀ c : C, ∃ v, (regularFunctionRepresentation (k := k) (G := G) (W := C)).norm
      (f v) = fun _ => c) : Function.Surjective f := by
  classical
  let σ := regularFunctionRepresentation (k := k) (G := G) (W := C)
  let S := LinearMap.range f
  have stable : ∀ g, S ≤ S.comap (σ g) := by
    intro g w hw
    obtain ⟨v, rfl⟩ := hw
    exact ⟨ρ g v, equivariant g v⟩
  let τ := σ.quotient S stable
  have equivariantQ : ∀ g w, τ g (S.mkQ w) = S.mkQ (σ g w) := by intro g w; rfl
  have all_zero : ∀ q : (G → C) ⧸ S, q = 0 := by
    intro q
    by_contra nonzero
    letI : Nontrivial ((G → C) ⧸ S) := ⟨q, 0, nonzero⟩
    obtain ⟨φ, φne⟩ := exists_ne (0 : Module.Dual k ((G → C) ⧸ S))
    obtain ⟨functional, functional_ne, fixed⟩ :=
      nonzero_characteristic_p_group_invariants group τ.dual ⟨φ, φne⟩
    let ℓ : (G → C) →ₗ[k] k := functional.comp S.mkQ
    have ℓfixed : ∀ g w, ℓ (σ g w) = ℓ w := by
      intro g w
      have h := congrArg (fun z : Module.Dual k ((G → C) ⧸ S) => z (S.mkQ w)) (fixed g⁻¹)
      change functional (τ (g⁻¹)⁻¹ (S.mkQ w)) = functional (S.mkQ w) at h
      simpa only [inv_inv, equivariantQ] using h
    have ℓimage : ∀ v, ℓ (f v) = 0 := by
      intro v
      change functional (S.mkQ (f v)) = 0
      have zero : S.mkQ (f v) = 0 :=
        (Submodule.Quotient.mk_eq_zero S).mpr (show f v ∈ S from ⟨v, rfl⟩)
      rw [zero, map_zero]
    have ℓdelta : ∀ c : C, ℓ (regularFunctionDeltaMap (k := k) 1 c) = 0 := by
      intro c
      obtain ⟨v, hv⟩ := cover c
      have h := invariant_functional_regular_norm_factorization ℓ ℓfixed (f v)
      rw [hv] at h
      exact h.symm.trans (ℓimage v)
    have ℓzero : ∀ w : G → C, ℓ w = 0 := by
      intro w
      rw [invariant_functional_regular_norm_factorization ℓ ℓfixed w]
      exact ℓdelta _
    apply functional_ne
    apply LinearMap.ext
    intro u
    obtain ⟨w, rfl⟩ := S.mkQ_surjective u
    exact ℓzero w
  intro w
  exact (Submodule.Quotient.mk_eq_zero S).mp (all_zero (S.mkQ w))

/-- Surjective actual norm forces the essential-socle orbit map
to be bijective, without importing Nakayama's lemma. -/
theorem invariant_orbit_map_bijective_of_norm_cover (group : IsPGroup p G)
    (ρ : Representation k G V) (cover : RepresentationNormCoversInvariants ρ) :
    Function.Bijective (invariantOrbitMap ρ) := by
  refine ⟨invariant_orbit_map_injective group ρ, ?_⟩
  apply p_group_regular_function_surjective_of_norm_cover group ρ (invariantOrbitMap ρ)
    (invariant_orbit_map_equivariant ρ)
  intro c
  obtain ⟨v, hv⟩ := cover c.1 c.2
  refine ⟨v, ?_⟩
  rw [← equivariant_map_norm ρ _ (invariantOrbitMap ρ) (invariant_orbit_map_equivariant ρ), hv]
  exact invariant_orbit_map_on_invariants ρ c

theorem p_group_norm_freeness (group : IsPGroup p G) (ρ : Representation k G V) :
    Specifications.PGroupNormFreeness ρ := by
  constructor
  · intro free
    letI := free
    exact free_group_module_norm_covers_invariants ρ
  · intro cover
    let σ := regularFunctionRepresentation (k := k) (G := G) (W := ρ.invariants)
    let e := LinearEquiv.ofBijective (invariantOrbitMap ρ)
      (invariant_orbit_map_bijective_of_norm_cover group ρ cover)
    let eR := representationModuleEquivOfEquivariant ρ σ e (invariant_orbit_map_equivariant ρ)
    exact Module.Free.of_basis
      ((regularFunctionModuleBasis (Module.Free.chooseBasis k ρ.invariants)).map eR.symm)

end Field

end Litt3.Deformations
