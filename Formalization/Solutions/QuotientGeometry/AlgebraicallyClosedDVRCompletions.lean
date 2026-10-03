import Solutions.QuotientGeometry.UnramifiedDVRCompletions
import Mathlib.FieldTheory.IsAlgClosed.Basic

namespace Litt3.QuotientGeometry

open IsLocalRing

variable {k R S : Type*} [Field k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra k S]

/-- At a point with residue field finite over the algebraically closed
coefficient field, the actual induced residue map is surjective. -/
theorem residue_map_surjective_over_algebraically_closed
    [IsAlgClosed k]
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom]
    [Module.Finite k (ResidueField S)] :
    Function.Surjective (ResidueField.map φ.toRingHom) := by
  intro b
  obtain ⟨c, hc⟩ :=
    (IsAlgClosed.algebraMap_bijective_of_isIntegral (k := k) (K := ResidueField S)).2 b
  refine ⟨residue R (algebraMap k R c), ?_⟩
  rw [ResidueField.map_residue]
  change residue S (φ (algebraMap k R c)) = b
  rw [φ.commutes]
  exact hc

/-- The completion isomorphism preserves the actual coefficient field. -/
noncomputable def localDVRCompletionAlgEquiv
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] (t : R) (ht : Irreducible t)
    (hmax : (maximalIdeal R).map φ.toRingHom = maximalIdeal S)
    (hres : Function.Surjective (ResidueField.map φ.toRingHom)) :
    AdicCompletion (maximalIdeal R) R ≃ₐ[k] AdicCompletion (maximalIdeal S) S :=
  { localDVRCompletionEquiv φ.toRingHom t ht hmax hres with
    commutes' := by
      intro c
      apply AdicCompletion.ext
      intro n
      change Ideal.Quotient.mk _ (φ (algebraMap k R c)) =
        Ideal.Quotient.mk _ (algebraMap k S c)
      rw [φ.commutes] }

@[simp] theorem localDVRCompletionAlgEquiv_of
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] (t : R) (ht : Irreducible t)
    (hmax : (maximalIdeal R).map φ.toRingHom = maximalIdeal S)
    (hres : Function.Surjective (ResidueField.map φ.toRingHom)) (r : R) :
    localDVRCompletionAlgEquiv φ t ht hmax hres (AdicCompletion.of _ R r) =
      AdicCompletion.of _ S (φ r) :=
  localDVRCompletionEquiv_of φ.toRingHom t ht hmax hres r

/-- Actual unramified local DVR maps over an algebraically closed field,
with finite target residue field, yield actual completion isomorphisms.
The source parameter and residue-field bijection are derived. -/
theorem unramified_dvr_completion_alg_isomorphism
    [IsAlgClosed k]
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom]
    (hunram : φ.toRingHom.FormallyUnramified) (hfinite : φ.toRingHom.EssFiniteType)
    [Module.Finite k (ResidueField S)] :
    ∃ e : AdicCompletion (maximalIdeal R) R ≃ₐ[k] AdicCompletion (maximalIdeal S) S,
      e.toRingHom = adicRingMap (maximalIdeal R) (maximalIdeal S) φ.toRingHom
        (formally_unramified_local_map_maximal_ideal φ.toRingHom hunram hfinite).le ∧
      ∀ r : R, e (AdicCompletion.of _ R r) = AdicCompletion.of _ S (φ r) := by
  obtain ⟨t, ht⟩ := IsDiscreteValuationRing.exists_irreducible R
  let hmax := formally_unramified_local_map_maximal_ideal φ.toRingHom hunram hfinite
  let hres := residue_map_surjective_over_algebraically_closed φ
  exact ⟨localDVRCompletionAlgEquiv φ t ht hmax hres, rfl,
    localDVRCompletionAlgEquiv_of φ t ht hmax hres⟩

end Litt3.QuotientGeometry
