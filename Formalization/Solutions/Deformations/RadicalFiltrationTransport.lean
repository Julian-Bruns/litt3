import Theorems.Deformations.RadicalFiltrationTransport
import Solutions.Deformations.FilteredQuotients

namespace Litt3.Deformations

variable {k A B : Type*} [Field k] [Ring A] [Ring B] [Algebra k A] [Algebra k B]

theorem algebra_equiv_radical_subspace_image (e : A ≃ₐ[k] B) :
    (jacobsonRadicalSubspace (k := k) (A := A)).map e.toLinearMap =
      jacobsonRadicalSubspace (k := k) (A := B) := by
  letI : RingHomSurjective e.toRingEquiv.toRingHom := ⟨e.surjective⟩
  letI : RingHomSurjective e.symm.toRingEquiv.toRingHom := ⟨e.symm.surjective⟩
  ext y
  constructor
  · rintro ⟨x, hx, rfl⟩
    exact Ring.le_comap_jacobson e.toRingEquiv.toRingHom hx
  · intro hy
    refine ⟨e.symm y, ?_, e.apply_symm_apply y⟩
    exact Ring.le_comap_jacobson e.symm.toRingEquiv.toRingHom hy

/-- Genuine Jacobson-radical powers are transported by every
actual algebra equivalence, including noncommutative algebras. -/
theorem algebra_equiv_radical_filtration_image (e : A ≃ₐ[k] B) (i : ℕ) :
    (jacobsonRadicalFiltration (k := k) (A := A) i).map e.toLinearMap =
      jacobsonRadicalFiltration (k := k) (A := B) i := by
  cases i with
  | zero =>
      change (⊤ : Submodule k A).map e.toLinearMap = ⊤
      rw [Submodule.map_top]
      exact LinearMap.range_eq_top.mpr e.surjective
  | succ i =>
      change (jacobsonRadicalSubspace (k := k) (A := A) ^ (i + 1)).map e.toAlgHom.toLinearMap =
        jacobsonRadicalSubspace (k := k) (A := B) ^ (i + 1)
      rw [Submodule.map_pow]
      exact congrArg (fun J : Submodule k B => J ^ (i + 1))
        (algebra_equiv_radical_subspace_image e)

noncomputable def algebraEquivRadicalFilteredMap (e : A ≃ₐ[k] B) :
    FilteredLinearMap (jacobsonRadicalFiltration (k := k) (A := A))
      (jacobsonRadicalFiltration (k := k) (A := B)) where
  toLinearMap := e.toLinearMap
  respects := by
    intro i x hx
    rw [← algebra_equiv_radical_filtration_image e i]
    exact Submodule.mem_map.mpr ⟨x, hx, rfl⟩

theorem algebra_equiv_radical_layer_finrank [FiniteDimensional k A] (e : A ≃ₐ[k] B) :
    Specifications.RadicalLayerTransport e := by
  letI : FiniteDimensional k B := Module.Finite.of_surjective e.toLinearMap e.surjective
  intro i
  apply le_antisymm
  · exact filtration_hilbert_dimension_monotone (algebraEquivRadicalFilteredMap e.symm)
      (algebra_equiv_radical_filtration_image e.symm) i
  · exact filtration_hilbert_dimension_monotone (algebraEquivRadicalFilteredMap e)
      (algebra_equiv_radical_filtration_image e) i

theorem algebra_equiv_radical_window_finrank [FiniteDimensional k A]
    (e : A ≃ₐ[k] B) (lag i : ℕ) :
    (∑ j ∈ Finset.range lag, Module.finrank k
      (FiltrationLayer (jacobsonRadicalFiltration (k := k) (A := A)) (i + j))) =
      ∑ j ∈ Finset.range lag, Module.finrank k
        (FiltrationLayer (jacobsonRadicalFiltration (k := k) (A := B)) (i + j)) := by
  apply Finset.sum_congr rfl
  intro j _
  exact algebra_equiv_radical_layer_finrank e (i + j)

end Litt3.Deformations
