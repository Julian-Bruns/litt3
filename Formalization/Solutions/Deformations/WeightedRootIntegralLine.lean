import Solutions.Deformations.WeightedRootBaseCoordinates

namespace Litt3.Deformations

variable {R S : Type*} [CommRing R] [Nontrivial R] [CommRing S] [Nontrivial S]

/-- A literal normal coefficient equal to one forces a scalar found
after an injective coefficient extension to descend to the original
ring. This is actual vector equality, rather than dimension counting. -/
theorem weighted_root_integral_line_descent (φ : R →+* S) (injective : Function.Injective φ)
    (q : ℕ) (large : 1 < q) (tau : R) (r : ℕ)
    (v x : weightedRootProduct R q tau r) (alpha : Fin r → Fin q)
    (unitCoordinate : (weightedRootProductBasis q large tau r).repr v alpha = 1)
    (line : ∃ b : S, weightedRootProductBaseMap φ q tau r x =
      b • weightedRootProductBaseMap φ q tau r v) :
    ∃ a : R, x = a • v := by
  obtain ⟨b, equality⟩ := line
  let source := weightedRootProductBasis q large tau r
  let target := weightedRootProductBasis q large (φ tau) r
  let a := source.repr x alpha
  have coefficient := congrArg (fun z => target.repr z alpha) equality
  dsimp only at coefficient
  rw [map_smul, Finsupp.smul_apply, smul_eq_mul] at coefficient
  change target.repr (weightedRootProductBaseMap φ q tau r x) alpha =
    b * target.repr (weightedRootProductBaseMap φ q tau r v) alpha at coefficient
  rw [weighted_root_base_map_coordinates, weighted_root_base_map_coordinates,
    unitCoordinate, map_one, mul_one] at coefficient
  refine ⟨a, ?_⟩
  apply weighted_root_base_map_injective φ injective q large tau r
  change weightedRootProductBaseLinear φ q tau r x =
    weightedRootProductBaseLinear φ q tau r (a • v)
  rw [map_smulₛₗ]
  exact equality.trans (congrArg (fun c => c • weightedRootProductBaseMap φ q tau r v) coefficient.symm)

end Litt3.Deformations
