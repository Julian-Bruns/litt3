import Definitions.Deformations.RepresentationProducts
import Mathlib.LinearAlgebra.Dimension.Constructions

namespace Litt3.Deformations

universe u v w t

variable {k : Type u} {G : Type v} {ι : Type w} {V : ι → Type t}
    [CommRing k] [Group G] [∀ i, AddCommGroup (V i)] [∀ i, Module k (V i)]
    (ρ : ∀ i, Representation k G (V i))

@[simp] theorem representation_pi_apply (g : G) (x : ∀ i, V i) (i : ι) :
    representationPi ρ g x i = ρ i g (x i) := rfl

/-- Full invariants of the actual product representation are exactly
the product of the full actual component invariant spaces. -/
noncomputable def representationPiInvariantEquiv :
    (representationPi ρ).invariants ≃ₗ[k] (∀ i, (ρ i).invariants) where
  toFun x i := ⟨x.1 i, by
    apply (Representation.mem_invariants _ _).mpr
    intro g
    exact congrFun ((Representation.mem_invariants _ _).mp x.2 g) i⟩
  invFun x := ⟨fun i => (x i).1, by
    apply (Representation.mem_invariants _ _).mpr
    intro g
    funext i
    exact (Representation.mem_invariants _ _).mp (x i).2 g⟩
  left_inv _ := rfl
  right_inv _ := rfl
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

variable [Fintype G]

@[simp] theorem representation_pi_norm_apply (x : ∀ i, V i) (i : ι) :
    (representationPi ρ).norm x i = (ρ i).norm (x i) := by
  simp [Representation.norm, LinearMap.sum_apply]

/-- The full actual norm image of an arbitrary product is precisely
the product of its actual component norm images. No finite-product
or finite-dimensional hypothesis is needed for this equivalence. -/
noncomputable def representationPiNormRangeEquiv :
    LinearMap.range (representationPi ρ).norm ≃ₗ[k]
      (∀ i, LinearMap.range (ρ i).norm) where
  toFun x i := ⟨x.1 i, by
    obtain ⟨v, hv⟩ := x.2
    exact ⟨v i, by simpa only [representation_pi_norm_apply] using congrFun hv i⟩⟩
  invFun x := ⟨fun i => (x i).1, by
    classical
    choose v hv using fun i => (x i).2
    exact ⟨v, funext (fun i => (representation_pi_norm_apply ρ v i).trans (hv i))⟩⟩
  left_inv _ := rfl
  right_inv _ := rfl
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

end Litt3.Deformations
