import Definitions.Deformations.RegularFunctionNorm
import Solutions.Deformations.RegularFunctionRepresentation

namespace Litt3.Deformations

variable {k G V W : Type*} [CommRing k] [Group G]
    [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

omit [Group G] in
@[simp] theorem regular_function_delta_map_apply [DecidableEq G] (g : G) (v : V) (x : G) :
    regularFunctionDeltaMap (k := k) g v x = if x = g then v else 0 := by
  classical
  simp [regularFunctionDeltaMap, Pi.single_apply, eq_comm]

theorem regular_function_delta_translate (g : G) (v : V) :
    regularFunctionRepresentation (k := k) g⁻¹ (regularFunctionDeltaMap (k := k) 1 v) =
      regularFunctionDeltaMap (k := k) g v := by
  classical
  ext x
  simp [mul_inv_eq_one]

variable [Fintype G]

theorem regular_function_norm_apply (f : G → V) (x : G) :
    (regularFunctionRepresentation (k := k) (G := G) (W := V)).norm f x = ∑ g : G, f g := by
  simp only [Representation.norm, LinearMap.sum_apply, Finset.sum_apply,
    regular_function_representation_apply]
  exact Fintype.sum_bijective (x * ·) (Group.mulLeft_bijective x) _ _ (by simp)

theorem regular_function_norm_delta (v : V) :
    (regularFunctionRepresentation (k := k) (G := G) (W := V)).norm
      (regularFunctionDeltaMap (k := k) 1 v) = fun _ => v := by
  classical
  ext x
  rw [regular_function_norm_apply]
  simp

/-- The actual group norm is onto the full invariant subspace of the
function representation, without inverting the group order. -/
theorem regular_function_norm_surjective_invariants (f : G → V)
    (fixed : f ∈ (regularFunctionRepresentation (k := k) (G := G) (W := V)).invariants) :
    ∃ y, (regularFunctionRepresentation (k := k) (G := G) (W := V)).norm y = f := by
  refine ⟨regularFunctionDeltaMap (k := k) 1 (f 1), ?_⟩
  rw [regular_function_norm_delta]
  ext x
  exact ((regular_function_invariant_iff_constant f).mp fixed x).symm

/-- Every actual invariant linear functional on the full function
representation factors through its actual norm, with the factor
evaluated on the single-supported coefficient. -/
theorem invariant_functional_regular_norm_factorization (ℓ : (G → V) →ₗ[k] W)
    (invariant : ∀ g f, ℓ (regularFunctionRepresentation (k := k) g f) = ℓ f)
    (f : G → V) :
    ℓ f = ℓ (regularFunctionDeltaMap (k := k) 1
      ((regularFunctionRepresentation (k := k) (G := G) (W := V)).norm f 1)) := by
  classical
  have δ : ∀ g v, ℓ (regularFunctionDeltaMap (k := k) g v) =
      ℓ (regularFunctionDeltaMap (k := k) 1 v) := by
    intro g v
    rw [← regular_function_delta_translate]
    exact invariant g⁻¹ _
  have split : f = ∑ g : G, regularFunctionDeltaMap (k := k) g (f g) := by
    ext x
    simp
  rw [regular_function_norm_apply]
  calc
    ℓ f = ∑ g : G, ℓ (regularFunctionDeltaMap (k := k) g (f g)) := by
      rw [← map_sum]
      exact congrArg ℓ split
    _ = ∑ g : G, ℓ (regularFunctionDeltaMap (k := k) 1 (f g)) :=
      Finset.sum_congr rfl (by intro g _; exact δ g _)
    _ = ℓ (regularFunctionDeltaMap (k := k) 1 (∑ g : G, f g)) := by rw [map_sum, map_sum]

end Litt3.Deformations
