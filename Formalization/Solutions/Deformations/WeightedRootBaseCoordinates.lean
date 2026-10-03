import Solutions.Deformations.WeightedRootBaseMap

namespace Litt3.Deformations

open scoped BigOperators

variable {R S : Type*} [CommRing R] [Nontrivial R] [CommRing S] [Nontrivial S]

/-- Every literal original normal coefficient is transported by the
actual coefficient ring map, with no assumed basis compatibility. -/
theorem weighted_root_base_map_coordinates (φ : R →+* S) (q : ℕ) (large : 1 < q)
    (tau : R) (r : ℕ) (x : weightedRootProduct R q tau r) (alpha : Fin r → Fin q) :
    (weightedRootProductBasis q large (φ tau) r).repr (weightedRootProductBaseMap φ q tau r x) alpha =
      φ ((weightedRootProductBasis q large tau r).repr x alpha) := by
  classical
  let source := weightedRootProductBasis q large tau r
  let target := weightedRootProductBasis q large (φ tau) r
  let map := weightedRootProductBaseLinear φ q tau r
  have expansion : map x = ∑ beta : Fin r → Fin q, φ (source.repr x beta) • target beta := by
    conv_lhs => rw [← source.sum_repr x]
    rw [map_sum]
    apply Finset.sum_congr rfl
    intro beta _
    rw [map_smulₛₗ]
    change φ (source.repr x beta) • weightedRootProductBaseMap φ q tau r (source beta) = _
    rw [weighted_root_base_map_basis]
  change target.repr (map x) alpha = φ (source.repr x alpha)
  rw [expansion, map_sum]
  simp only [map_smul, Module.Basis.repr_self, Finsupp.smul_single, smul_eq_mul, mul_one]
  simp only [Finsupp.finset_sum_apply, Finsupp.single_apply]
  simp

/-- Injective coefficient extension is injective on the entire actual
graded tensor quotient, by its genuine original normal coefficients. -/
theorem weighted_root_base_map_injective (φ : R →+* S) (injective : Function.Injective φ)
    (q : ℕ) (large : 1 < q) (tau : R) (r : ℕ) :
    Function.Injective (weightedRootProductBaseMap φ q tau r) := by
  intro x y same
  apply (weightedRootProductBasis q large tau r).repr.injective
  ext alpha
  apply injective
  rw [← weighted_root_base_map_coordinates φ q large tau r x alpha,
    ← weighted_root_base_map_coordinates φ q large tau r y alpha, same]

end Litt3.Deformations
