import Solutions.Deformations.WeightedRootFunctionEvaluation

namespace Litt3.Deformations

open scoped BigOperators

variable (F K : Type*) [Field F] [Fintype F] [DecidableEq F] [Field K]

/-- The genuine algebra evaluation is bijective when the chosen scaling
root is nonzero. Actual quotient bases and uniform interpolation supply
the proof; a function-algebra model is not assumed. -/
theorem weighted_root_function_evaluation_bijective (φ : F →+* K) (c : K)
    (nonzero : c ≠ 0) (r : ℕ) :
    Function.Bijective (weightedRootFunctionEvaluation F K φ c r) := by
  classical
  have cardinal : Fintype.card F - 1 + 1 = Fintype.card F := Nat.sub_add_cancel Fintype.card_pos
  let indices : (Fin r → Fin (Fintype.card F)) ≃
      (Fin r → Fin (Fintype.card F - 1 + 1)) :=
    Equiv.piCongrRight (fun _ => finCongr cardinal.symm)
  let original := weightedRootProductBasis (Fintype.card F) Fintype.one_lt_card
    (-c ^ (Fintype.card F - 1)) r
  let basis := original.reindex indices
  let coordinates := basis.equivFun.trans (scaledFiniteFieldNormalCoordinates F K φ c nonzero)
  have value (alpha : Fin r → Fin (Fintype.card F - 1 + 1)) :
      weightedRootFunctionEvaluation F K φ c r (basis alpha) = coordinates (basis alpha) := by
    ext a
    have originalValue := original.reindex_apply indices alpha
    have left := congrArg (fun x => weightedRootFunctionEvaluation F K φ c r x a) originalValue
    have leftValue : weightedRootFunctionEvaluation F K φ c r (basis alpha) a =
        ∏ i : Fin r, (c * φ (a i)) ^ (alpha i).val := by
      apply left.trans
      simpa only [original, indices, Equiv.piCongrRight_symm_apply, finCongr_apply,
        Fin.val_cast] using weighted_root_function_evaluation_basis F K φ c r (indices.symm alpha) a
    rw [leftValue]
    change _ = scaledFiniteFieldNormalCoordinates F K φ c nonzero (basis.equivFun (basis alpha)) a
    rw [scaled_finite_field_normal_coordinates_apply]
    simp only [Module.Basis.equivFun_self]
    simp
  have equality : (weightedRootFunctionEvaluation F K φ c r).toLinearMap = coordinates.toLinearMap :=
    basis.ext value
  have pointwise (x) : weightedRootFunctionEvaluation F K φ c r x = coordinates x :=
    LinearMap.congr_fun equality x
  constructor
  · intro x y same
    apply coordinates.injective
    simpa only [← pointwise] using same
  · intro y
    obtain ⟨x, same⟩ := coordinates.surjective y
    exact ⟨x, (pointwise x).trans same⟩

/-- The actual localized graded coordinate quotient is the actual
function algebra on all original rational directions. -/
noncomputable def weightedRootFunctionEquiv (φ : F →+* K) (c : K) (nonzero : c ≠ 0) (r : ℕ) :
    weightedRootProduct K (Fintype.card F) (-c ^ (Fintype.card F - 1)) r ≃ₐ[K]
      ((Fin r → F) → K) :=
  AlgEquiv.ofBijective (weightedRootFunctionEvaluation F K φ c r)
    (weighted_root_function_evaluation_bijective F K φ c nonzero r)

end Litt3.Deformations
