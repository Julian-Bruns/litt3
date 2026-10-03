import Solutions.QuotientGeometry.SameSourceDVRWeakScalars

namespace Litt3.QuotientGeometry

theorem actual_algEquiv_formallyUnramified
    {k R S : Type*} [CommRing k] [CommRing R] [CommRing S]
    [Algebra k R] [Algebra k S] (e : R ≃ₐ[k] S) :
    e.toAlgHom.toRingHom.FormallyUnramified := by
  letI : Algebra R S := e.toAlgHom.toRingHom.toAlgebra
  change Algebra.FormallyUnramified R S
  exact Algebra.FormallyUnramified.of_surjective (Algebra.ofId R S) e.surjective

variable {k B R₁ R₂ : Type*} [Field k]
  [CommRing B] [IsDomain B] [IsDiscreteValuationRing B] [Algebra k B]
  [CommRing R₁] [IsDomain R₁] [IsDiscreteValuationRing R₁] [Algebra k R₁]
  [CommRing R₂] [IsDomain R₂] [IsDiscreteValuationRing R₂] [Algebra k R₂]

/-- An actual coefficient-preserving local-ring equivalence fixing the
ENTIRE actual downstairs local ring constructs the full completed-field
equivalence. No completed maps or completed equivalence are inputs. -/
theorem dvr_base_equiv_completed_fields
    (dB : DVRCompletionParameters k B) (d₁ : DVRCompletionParameters k R₁)
    (d₂ : DVRCompletionParameters k R₂)
    (χ₁ : B →ₐ[k] R₁) (χ₂ : B →ₐ[k] R₂)
    [IsLocalHom χ₁.toRingHom] [IsLocalHom χ₂.toRingHom]
    (hi₁ : Function.Injective χ₁) (hi₂ : Function.Injective χ₂)
    (e : R₁ ≃ₐ[k] R₂) (he : e.toAlgHom.comp χ₁ = χ₂) :
    ParameterFieldsEquivalent (completedDVRLaurentMap dB d₁ χ₁ hi₁)
      (completedDVRLaurentMap dB d₂ χ₂ hi₂) := by
  let φ₁ := e.toAlgHom
  let φ₂ := AlgHom.id k R₂
  letI : IsLocalHom φ₁.toRingHom :=
    ⟨fun r hr => (MulEquiv.isUnit_map e).mp hr⟩
  letI : IsLocalHom φ₂.toRingHom := inferInstanceAs (IsLocalHom (RingHom.id R₂))
  have hbase : φ₁.comp χ₁ = φ₂.comp χ₂ := by
    simpa only [φ₁, φ₂, AlgHom.id_comp] using he
  exact same_source_unramified_dvr_laurent_fields_equivalent dB d₁ d₂ d₂ χ₁ χ₂ φ₁ φ₂
    hi₁ hi₂ (actual_algEquiv_formallyUnramified e)
    (RingHom.FiniteType.of_surjective _ e.surjective).essFiniteType
    (actual_algEquiv_formallyUnramified (AlgEquiv.refl : R₂ ≃ₐ[k] R₂))
    (RingHom.FiniteType.of_surjective _ (Function.surjective_id)).essFiniteType hbase

end Litt3.QuotientGeometry
