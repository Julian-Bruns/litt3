import Solutions.Deformations.WeightedRootOrigin

namespace Litt3.Deformations

open scoped BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]

theorem weighted_root_origin_basis (q : ℕ) (large : 1 < q) (tau : R) (r : ℕ)
    (alpha : Fin r → Fin q) :
    weightedRootOrigin q (by omega) tau r (weightedRootProductBasis q large tau r alpha) =
      if alpha = (fun _ => ⟨0, by omega⟩) then 1 else 0 := by
  classical
  rw [weighted_root_product_basis_apply, map_prod]
  simp only [map_pow, weighted_root_origin_parameter]
  split_ifs with zero
  · subst alpha
    simp
  · have nonzero : ∃ i, (alpha i).val ≠ 0 := by
      by_contra all
      apply zero
      funext i
      apply Fin.ext
      exact not_not.mp (not_exists.mp all i)
    obtain ⟨i, positive⟩ := nonzero
    apply Finset.prod_eq_zero (Finset.mem_univ i)
    exact zero_pow positive

/-- The unchanged original constant normal coordinate is exactly
the actual augmentation-origin value over the original parameter ring. -/
theorem weighted_root_origin_normal_coordinate (q : ℕ) (large : 1 < q) (tau : R) (r : ℕ)
    (x : weightedRootProduct R q tau r) :
    (weightedRootProductBasis q large tau r).repr x (fun _ => ⟨0, by omega⟩) =
      weightedRootOrigin q (by omega) tau r x := by
  classical
  conv_rhs => rw [← (weightedRootProductBasis q large tau r).sum_repr x]
  rw [map_sum]
  simp only [map_smul, weighted_root_origin_basis, smul_eq_mul, mul_ite, mul_one, mul_zero]
  rw [Finset.sum_ite_eq', if_pos (Finset.mem_univ _)]

end Litt3.Deformations
