import Definitions.Deformations.RegularFunctionRepresentation

namespace Litt3.Deformations

variable {k G V W : Type*} [CommRing k] [Group G]
    [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

@[simp] theorem regular_function_representation_apply (g : G) (f : G → W) (x : G) :
    regularFunctionRepresentation (k := k) g f x = f (x * g) := rfl

@[simp] theorem projected_orbit_map_apply (ρ : Representation k G V) (π : V →ₗ[k] W)
    (v : V) (g : G) : projectedOrbitMap ρ π v g = π (ρ g v) := rfl

theorem projected_orbit_map_equivariant (ρ : Representation k G V) (π : V →ₗ[k] W)
    (g : G) (v : V) :
    projectedOrbitMap ρ π (ρ g v) = regularFunctionRepresentation (k := k) g
      (projectedOrbitMap ρ π v) := by
  ext x
  change π (ρ x (ρ g v)) = π (ρ (x * g) v)
  rw [map_mul, Module.End.mul_apply]

theorem regular_function_invariant_iff_constant (f : G → W) :
    f ∈ (regularFunctionRepresentation (k := k) (G := G) (W := W)).invariants ↔
      ∀ x, f x = f 1 := by
  rw [Representation.mem_invariants]
  constructor
  · intro h x
    simpa using congrFun (h x) 1
  · intro h g
    ext x
    exact (h (x * g)).trans (h x).symm

/-- Actual invariant functions are exactly the full constant coefficient
module, over every commutative ring and every group. -/
def regularFunctionInvariantEquiv :
    (regularFunctionRepresentation (k := k) (G := G) (W := W)).invariants ≃ₗ[k] W where
  toFun f := f.1 1
  invFun w := ⟨fun _ => w, (regular_function_invariant_iff_constant _).mpr (by simp)⟩
  left_inv f := by
    apply Subtype.ext
    ext g
    exact ((regular_function_invariant_iff_constant f.1).mp f.2 g).symm
  right_inv _ := rfl
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

end Litt3.Deformations
