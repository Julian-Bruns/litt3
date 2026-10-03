import Theorems.Deformations.GroupAlgebraQuotients
import Solutions.Deformations.LeftPrincipalWidth
import Solutions.Deformations.GroupAlgebraAugmentation
import Solutions.Deformations.FilteredQuotients

namespace Litt3.Deformations

section Algebras

variable {k A B : Type*} [Field k] [Ring A] [Ring B] [Algebra k A] [Algebra k B]

theorem right_multiplication_cokernel_map_compatible (φ : A →ₐ[k] B) (f : A) :
    LinearMap.range (LinearMap.mulRight k f) ≤
      (LinearMap.range (LinearMap.mulRight k (φ f))).comap φ.toLinearMap := by
  intro x hx
  obtain ⟨y, rfl⟩ := hx
  exact ⟨φ y, (φ.map_mul y f).symm⟩

/-- The actual induced map on full coefficient cokernels. -/
noncomputable def rightMultiplicationCokernelMap (φ : A →ₐ[k] B) (f : A) :
    EndomorphismCokernel (LinearMap.mulRight k f) →ₗ[k]
      EndomorphismCokernel (LinearMap.mulRight k (φ f)) :=
  Submodule.mapQ _ _ φ.toLinearMap (right_multiplication_cokernel_map_compatible φ f)

theorem right_multiplication_cokernel_map_surjective (φ : A →ₐ[k] B)
    (surjective : Function.Surjective φ) (f : A) :
    Function.Surjective (rightMultiplicationCokernelMap φ f) := by
  intro q
  obtain ⟨y, rfl⟩ := (LinearMap.range (LinearMap.mulRight k (φ f))).mkQ_surjective q
  obtain ⟨x, hx⟩ := surjective y
  refine ⟨(LinearMap.range (LinearMap.mulRight k f)).mkQ x, ?_⟩
  change (LinearMap.range (LinearMap.mulRight k (φ f))).mkQ (φ x) = _
  rw [hx]

/-- Full noncentral left one-relation quotients inherit the
actual quotient map; no two-sided ring quotient is required. -/
noncomputable def leftPrincipalQuotientMap (φ : A →ₐ[k] B) (f : A) :
    LeftPrincipalQuotient f →ₗ[k] LeftPrincipalQuotient (φ f) :=
  (leftPrincipalCokernelEquiv (k := k) (φ f)).toLinearMap.comp
    ((rightMultiplicationCokernelMap φ f).comp
      (leftPrincipalCokernelEquiv (k := k) f).symm.toLinearMap)

theorem left_principal_quotient_map_surjective (φ : A →ₐ[k] B)
    (surjective : Function.Surjective φ) (f : A) :
    Function.Surjective (leftPrincipalQuotientMap φ f) :=
  (leftPrincipalCokernelEquiv (k := k) (φ f)).surjective.comp
    ((right_multiplication_cokernel_map_surjective φ surjective f).comp
      (leftPrincipalCokernelEquiv (k := k) f).symm.surjective)

theorem left_principal_quotient_dimension_monotone [FiniteDimensional k A]
    (φ : A →ₐ[k] B) (surjective : Function.Surjective φ) (f : A) :
    Specifications.LeftPrincipalQuotientDimensionMonotone φ f := by
  have h := (leftPrincipalQuotientMap φ f).finrank_range_le
  rw [LinearMap.range_eq_top.mpr (left_principal_quotient_map_surjective φ surjective f),
    finrank_top] at h
  exact h

end Algebras

section Groups

open scoped MonoidAlgebra

variable {k G H : Type*} [CommRing k] [Group G] [Group H]

theorem group_algebra_quotient_map_of (φ : G →* H) (g : G) :
    groupAlgebraQuotientMap (k := k) φ (MonoidAlgebra.of k G g) =
      MonoidAlgebra.of k H (φ g) := by
  simp [groupAlgebraQuotientMap, MonoidAlgebra.of_apply,
    MonoidAlgebra.mapDomainAlgHom, MonoidAlgebra.mapDomainRingHom]

theorem group_algebra_quotient_map_surjective (φ : G →* H)
    (surjective : Function.Surjective φ) :
    Function.Surjective (groupAlgebraQuotientMap (k := k) φ) :=
  Finsupp.mapDomain_surjective surjective

/-- Actual coefficient sums commute with the actual quotient
map, including collisions of several group elements in one fiber. -/
theorem group_algebra_quotient_augmentation (φ : G →* H) (r : k[G]) :
    groupAlgebraAugmentation (k := k) (G := H) (groupAlgebraQuotientMap (k := k) φ r) =
      groupAlgebraAugmentation (k := k) (G := G) r := by
  apply MonoidAlgebra.induction_on r
  · intro g
    rw [group_algebra_quotient_map_of, group_algebra_augmentation_of,
      group_algebra_augmentation_of]
  · intro a b ha hb
    simp only [map_add, ha, hb]
  · intro c a ha
    simp only [map_smul, ha]

end Groups

section PGroups

open scoped MonoidAlgebra

variable {k G H : Type*} [Field k] [Group G] [Group H]

theorem group_algebra_quotient_augmentation_subspace_image (φ : G →* H)
    (surjective : Function.Surjective φ) :
    ((groupAlgebraAugmentationIdeal (k := k) (G := G)).restrictScalars k).map
      (groupAlgebraQuotientMap (k := k) φ).toLinearMap =
        (groupAlgebraAugmentationIdeal (k := k) (G := H)).restrictScalars k := by
  ext y
  constructor
  · rintro ⟨x, hx, rfl⟩
    change groupAlgebraAugmentation (k := k) (G := H)
      (groupAlgebraQuotientMap (k := k) φ x) = 0
    rw [group_algebra_quotient_augmentation]
    exact hx
  · intro hy
    obtain ⟨x, hx⟩ := group_algebra_quotient_map_surjective (k := k) φ surjective y
    refine ⟨x, ?_, hx⟩
    change groupAlgebraAugmentation (k := k) (G := G) x = 0
    rw [← group_algebra_quotient_augmentation φ x, hx]
    exact hy

variable {p : ℕ} [Fact p.Prime] [CharP k p] [Finite G]

theorem group_algebra_quotient_radical_subspace_image (group : IsPGroup p G)
    (φ : G →* H) (surjective : Function.Surjective φ) :
    (jacobsonRadicalSubspace (k := k) (A := k[G])).map
      (groupAlgebraQuotientMap (k := k) φ).toLinearMap =
        jacobsonRadicalSubspace (k := k) (A := k[H]) := by
  letI : Finite H := Finite.of_surjective φ surjective
  have hG : groupAlgebraAugmentationIdeal (k := k) (G := G) = Ring.jacobson k[G] :=
    p_group_augmentation_radical group
  have hH : groupAlgebraAugmentationIdeal (k := k) (G := H) = Ring.jacobson k[H] :=
    p_group_augmentation_radical (group.of_surjective φ surjective)
  change ((Ring.jacobson k[G]).restrictScalars k).map _ =
    (Ring.jacobson k[H]).restrictScalars k
  rw [← hG, ← hH]
  exact group_algebra_quotient_augmentation_subspace_image φ surjective

/-- Actual radical powers map onto the corresponding actual
radical powers of every genuine finite p-group quotient. -/
theorem group_algebra_quotient_radical_filtration_image (group : IsPGroup p G)
    (φ : G →* H) (surjective : Function.Surjective φ) (n : ℕ) :
    (jacobsonRadicalFiltration (k := k) (A := k[G]) n).map
      (groupAlgebraQuotientMap (k := k) φ).toLinearMap =
        jacobsonRadicalFiltration (k := k) (A := k[H]) n := by
  cases n with
  | zero =>
      change (⊤ : Submodule k k[G]).map _ = ⊤
      rw [Submodule.map_top]
      exact LinearMap.range_eq_top.mpr (group_algebra_quotient_map_surjective φ surjective)
  | succ n =>
      change (jacobsonRadicalSubspace (k := k) (A := k[G]) ^ (n + 1)).map _ =
        jacobsonRadicalSubspace (k := k) (A := k[H]) ^ (n + 1)
      rw [Submodule.map_pow, group_algebra_quotient_radical_subspace_image group φ surjective]

noncomputable def groupAlgebraRadicalFilteredMap (group : IsPGroup p G)
    (φ : G →* H) (surjective : Function.Surjective φ) :
    FilteredLinearMap (jacobsonRadicalFiltration (k := k) (A := k[G]))
      (jacobsonRadicalFiltration (k := k) (A := k[H])) where
  toLinearMap := (groupAlgebraQuotientMap (k := k) φ).toLinearMap
  respects := by
    intro i x hx
    rw [← group_algebra_quotient_radical_filtration_image group φ surjective i]
    exact Submodule.mem_map.mpr ⟨x, hx, rfl⟩

/-- Every genuine quotient-group radical Hilbert layer is a
quotient of the corresponding source layer. -/
theorem group_quotient_radical_hilbert_monotone (group : IsPGroup p G)
    (φ : G →* H) (surjective : Function.Surjective φ) (i : ℕ) :
    Module.finrank k (FiltrationLayer (jacobsonRadicalFiltration (k := k) (A := k[H])) i) ≤
      Module.finrank k (FiltrationLayer (jacobsonRadicalFiltration (k := k) (A := k[G])) i) :=
  filtration_hilbert_dimension_monotone (groupAlgebraRadicalFilteredMap group φ surjective)
    (group_algebra_quotient_radical_filtration_image group φ surjective) i

theorem group_quotient_radical_window_monotone (group : IsPGroup p G)
    (φ : G →* H) (surjective : Function.Surjective φ) (lag i : ℕ) :
    groupRadicalHilbertWindow (k := k) (G := H) lag i ≤
      groupRadicalHilbertWindow (k := k) (G := G) lag i :=
  filtration_windows_dimension_monotone (groupAlgebraRadicalFilteredMap group φ surjective)
    (group_algebra_quotient_radical_filtration_image group φ surjective) i lag

/-- Both actual all-index maxima exist, are attained, and the
quotient maximum is at most the source maximum, for every lag. -/
theorem group_quotient_radical_maxima_monotone (group : IsPGroup p G)
    (φ : G →* H) (surjective : Function.Surjective φ) (lag : ℕ) :
    Specifications.GroupQuotientRadicalMaximaMonotone (k := k) φ lag := by
  letI : Finite H := Finite.of_surjective φ surjective
  obtain ⟨wG, upperG, attainedG, _⟩ := left_principal_radical_maximum_width
    (k := k) (A := k[G]) lag 0 (Submodule.zero_mem _)
  obtain ⟨wH, upperH, attainedH, _⟩ := left_principal_radical_maximum_width
    (k := k) (A := k[H]) lag 0 (Submodule.zero_mem _)
  refine ⟨wG, wH, ⟨upperG, attainedG⟩, ⟨upperH, attainedH⟩, ?_⟩
  obtain ⟨i, hi⟩ := attainedH
  rw [← hi]
  exact (group_quotient_radical_window_monotone group φ surjective lag i).trans (upperG i)

/-- The full source relation quotient bounds the actual attained
window maximum of every actual p-group quotient. This supplies an
algebraic comparison, and asserts no geometric cover realization. -/
theorem group_quotient_radical_width (group : IsPGroup p G)
    (φ : G →* H) (surjective : Function.Surjective φ) (lag : ℕ) (f : k[G])
    (order : f ∈ jacobsonRadicalFiltration (k := k) (A := k[G]) lag) :
    Specifications.GroupQuotientRadicalWidth φ lag f := by
  letI : Finite H := Finite.of_surjective φ surjective
  let ψ := groupAlgebraQuotientMap (k := k) φ
  have order' : ψ f ∈ jacobsonRadicalFiltration (k := k) (A := k[H]) lag := by
    rw [← group_algebra_quotient_radical_filtration_image group φ surjective lag]
    exact Submodule.mem_map.mpr ⟨f, order, rfl⟩
  obtain ⟨w, upper, attained, bound⟩ := left_principal_radical_maximum_width lag (ψ f) order'
  refine ⟨w, upper, attained, bound.trans ?_⟩
  exact left_principal_quotient_dimension_monotone ψ
    (group_algebra_quotient_map_surjective φ surjective) f

end PGroups

end Litt3.Deformations
