import Solutions.Deformations.WeightedRootProduct

namespace Litt3.Deformations

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- In the actual unchanged original normal basis, divisibility of
an element by one coefficient scalar is exactly coordinatewise
divisibility. All coordinate witnesses construct an actual element. -/
theorem weighted_root_scalar_divisibility (q : ℕ) (large : 1 < q) (tau : R) (r : ℕ)
    (a : R) (x : weightedRootProduct R q tau r) :
    (∃ y : weightedRootProduct R q tau r, x = a • y) ↔
      ∀ alpha : Fin r → Fin q, a ∣ (weightedRootProductBasis q large tau r).repr x alpha := by
  classical
  let basis := weightedRootProductBasis q large tau r
  constructor
  · rintro ⟨y, rfl⟩ alpha
    refine ⟨basis.repr y alpha, ?_⟩
    simp only [map_smul, Finsupp.smul_apply, smul_eq_mul]
    rfl
  · intro divisible
    choose coefficients exactCoordinates using divisible
    let y := basis.equivFun.symm coefficients
    refine ⟨y, ?_⟩
    apply basis.equivFun.injective
    funext alpha
    change basis.repr x alpha = basis.repr (a • y) alpha
    rw [map_smul, Finsupp.smul_apply, smul_eq_mul]
    have coordinate : basis.repr y alpha = coefficients alpha := by
      exact congrFun (basis.equivFun.apply_symm_apply coefficients) alpha
    rw [coordinate]
    exact exactCoordinates alpha

end Litt3.Deformations
