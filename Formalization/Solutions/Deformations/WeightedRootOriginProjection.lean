import Solutions.Deformations.WeightedRootHomogeneousComponents
import Solutions.Deformations.WeightedRootOriginCoordinates

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k]

/-- The actual unchanged augmentation-origin scalar, embedded back
into the actual parameter algebra. -/
noncomputable def weightedRootOriginProjection (q : ℕ) (positive : 0 < q) (r : ℕ) :
    weightedRootProduct (Polynomial k) q Polynomial.X r →ₐ[Polynomial k]
      weightedRootProduct (Polynomial k) q Polynomial.X r :=
  (Algebra.ofId (Polynomial k) _).comp
    (weightedRootOrigin q positive (Polynomial.X : Polynomial k) r)

theorem weighted_root_origin_projection_basis (q : ℕ) (large : 1 < q) (r : ℕ)
    (j : ℕ) (alpha : Fin r → Fin q) :
    weightedRootOriginProjection k q (by omega) r
      (weightedRootPolynomialBasis k q large r (j, alpha)) =
      if alpha = (fun _ => ⟨0, by omega⟩)
        then weightedRootPolynomialBasis k q large r (j, alpha) else 0 := by
  classical
  change algebraMap (Polynomial k) _
    (weightedRootOrigin q (by omega) Polynomial.X r
      (weightedRootPolynomialBasis k q large r (j, alpha))) = _
  rw [weighted_root_polynomial_basis_apply, map_smul, weighted_root_origin_basis]
  by_cases origin : alpha = (fun _ => ⟨0, by omega⟩)
  · simp only [if_pos origin, smul_eq_mul, mul_one]
    have basisOne : weightedRootProductBasis (R := Polynomial k) q large Polynomial.X r alpha = 1 := by
      rw [weighted_root_product_basis_apply, origin]
      simp
    rw [basisOne, Algebra.smul_def, mul_one]
  · simp [origin]

/-- The literal origin-scalar projection preserves every genuine
homogeneous component. -/
theorem weighted_root_origin_projection_homogeneous (q : ℕ) (large : 1 < q) (r d : ℕ)
    (x : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k q large r d) :
    weightedRootOriginProjection k q (by omega) r x ∈
      weightedRootHomogeneousComponent k q large r d := by
  classical
  let projection := (weightedRootOriginProjection k q (by omega) r).restrictScalars k
  change projection x ∈ weightedRootHomogeneousComponent k q large r d
  refine Submodule.span_induction (p := fun x _ =>
    projection x ∈ weightedRootHomogeneousComponent k q large r d) ?_ ?_ ?_ ?_ homogeneous
  · rintro _ ⟨⟨j, alpha⟩, degree, rfl⟩
    change weightedRootOriginProjection k q (by omega) r
      (weightedRootPolynomialBasis k q large r (j, alpha)) ∈ _
    rw [weighted_root_origin_projection_basis]
    split_ifs
    · exact Submodule.subset_span ⟨(j, alpha), degree, rfl⟩
    · exact Submodule.zero_mem _
  · change projection (0 : weightedRootProduct (Polynomial k) q Polynomial.X r) ∈
      weightedRootHomogeneousComponent k q large r d
    rw [map_zero]
    exact Submodule.zero_mem _
  · intro x y _ _ hx hy
    rw [map_add]
    exact Submodule.add_mem _ hx hy
  · intro a x _ hx
    rw [map_smul]
    exact Submodule.smul_mem _ a hx

@[simp] theorem weighted_root_origin_projection_origin (q : ℕ) (positive : 0 < q) (r : ℕ)
    (x : weightedRootProduct (Polynomial k) q Polynomial.X r) :
    weightedRootOrigin q positive (Polynomial.X : Polynomial k) r
      (weightedRootOriginProjection k q positive r x) =
      weightedRootOrigin q positive (Polynomial.X : Polynomial k) r x := by
  change weightedRootOrigin q positive Polynomial.X r (algebraMap (Polynomial k) _ _) = _
  rw [AlgHom.commutes, Algebra.algebraMap_self, RingHom.id_apply]
  rfl

end Litt3.Deformations
