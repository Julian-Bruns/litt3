import Solutions.QuotientGeometry.DVRCompletedAlgEquiv
import Solutions.QuotientGeometry.ParameterFieldBaseTransport

namespace Litt3.QuotientGeometry

variable {k B B' R₁ R₂ S₁ S₂ : Type*} [Field k]
  [CommRing B] [IsDomain B] [IsDiscreteValuationRing B] [Algebra k B]
  [CommRing B'] [IsDomain B'] [IsDiscreteValuationRing B'] [Algebra k B']
  [CommRing R₁] [IsDomain R₁] [IsDiscreteValuationRing R₁] [Algebra k R₁]
  [CommRing R₂] [IsDomain R₂] [IsDiscreteValuationRing R₂] [Algebra k R₂]
  [CommRing S₁] [IsDomain S₁] [IsDiscreteValuationRing S₁] [Algebra k S₁]
  [CommRing S₂] [IsDomain S₂] [IsDiscreteValuationRing S₂] [Algebra k S₂]

local instance diagramTransportLocalComp {U V W : Type*}
    [CommRing U] [CommRing V] [CommRing W]
    [Algebra k U] [Algebra k V] [Algebra k W]
    (φ : U →ₐ[k] V) (ψ : V →ₐ[k] W)
    [IsLocalHom φ.toRingHom] [IsLocalHom ψ.toRingHom] :
    IsLocalHom (ψ.comp φ).toRingHom :=
  RingHom.isLocalHom_comp ψ.toRingHom φ.toRingHom

/-- An original commuting diagram of genuine coefficient local-ring
equivalences transports a full completed-field comparison. Neither
the completed coordinate changes nor completed-map commutation are
supplied as hypotheses. -/
theorem actual_dvr_completed_field_comparison_transport
    (dB : DVRCompletionParameters k B) (dB' : DVRCompletionParameters k B')
    (dR₁ : DVRCompletionParameters k R₁) (dR₂ : DVRCompletionParameters k R₂)
    (dS₁ : DVRCompletionParameters k S₁) (dS₂ : DVRCompletionParameters k S₂)
    (χ₁ : B →ₐ[k] R₁) (χ₂ : B →ₐ[k] R₂)
    (θ₁ : B' →ₐ[k] S₁) (θ₂ : B' →ₐ[k] S₂)
    [IsLocalHom χ₁.toRingHom] [IsLocalHom χ₂.toRingHom]
    [IsLocalHom θ₁.toRingHom] [IsLocalHom θ₂.toRingHom]
    (hiχ₁ : Function.Injective χ₁) (hiχ₂ : Function.Injective χ₂)
    (hiθ₁ : Function.Injective θ₁) (hiθ₂ : Function.Injective θ₂)
    (eB : B ≃ₐ[k] B') (e₁ : R₁ ≃ₐ[k] S₁) (e₂ : R₂ ≃ₐ[k] S₂)
    (h₁ : e₁.toAlgHom.comp χ₁ = θ₁.comp eB.toAlgHom)
    (h₂ : e₂.toAlgHom.comp χ₂ = θ₂.comp eB.toAlgHom)
    (hfields : ParameterFieldsEquivalent
      (completedDVRLaurentMap dB' dS₁ θ₁ hiθ₁)
      (completedDVRLaurentMap dB' dS₂ θ₂ hiθ₂)) :
    ParameterFieldsEquivalent (completedDVRLaurentMap dB dR₁ χ₁ hiχ₁)
      (completedDVRLaurentMap dB dR₂ χ₂ hiχ₂) := by
  letI : IsLocalHom eB.toAlgHom.toRingHom :=
    ⟨fun r hr => (MulEquiv.isUnit_map eB).mp hr⟩
  letI : IsLocalHom e₁.toAlgHom.toRingHom :=
    ⟨fun r hr => (MulEquiv.isUnit_map e₁).mp hr⟩
  letI : IsLocalHom e₂.toAlgHom.toRingHom :=
    ⟨fun r hr => (MulEquiv.isUnit_map e₂).mp hr⟩
  let EB := actualDVRCompletedRingEquiv dB dB' eB
  let E₁ := actualDVRCompletedRingEquiv dR₁ dS₁ e₁
  let E₂ := actualDVRCompletedRingEquiv dR₂ dS₂ e₂
  have hc₁ : E₁.toRingHom.comp (completedDVRLaurentMap dB dR₁ χ₁ hiχ₁) =
      (completedDVRLaurentMap dB' dS₁ θ₁ hiθ₁).comp EB.toRingHom := by
    rw [show E₁.toRingHom = completedDVRLaurentMap dR₁ dS₁ e₁.toAlgHom e₁.injective
      from actualDVRCompletedRingEquiv_toRingHom dR₁ dS₁ e₁,
      show EB.toRingHom = completedDVRLaurentMap dB dB' eB.toAlgHom eB.injective
        from actualDVRCompletedRingEquiv_toRingHom dB dB' eB,
      completedDVRLaurentMap_comp, completedDVRLaurentMap_comp]
    congr 1
  have hc₂ : E₂.toRingHom.comp (completedDVRLaurentMap dB dR₂ χ₂ hiχ₂) =
      (completedDVRLaurentMap dB' dS₂ θ₂ hiθ₂).comp EB.toRingHom := by
    rw [show E₂.toRingHom = completedDVRLaurentMap dR₂ dS₂ e₂.toAlgHom e₂.injective
      from actualDVRCompletedRingEquiv_toRingHom dR₂ dS₂ e₂,
      show EB.toRingHom = completedDVRLaurentMap dB dB' eB.toAlgHom eB.injective
        from actualDVRCompletedRingEquiv_toRingHom dB dB' eB,
      completedDVRLaurentMap_comp, completedDVRLaurentMap_comp]
    congr 1
  have h := hfields.precomp EB.toRingHom
  rw [← hc₁, ← hc₂] at h
  exact h.of_postcomp_equiv E₁ E₂

end Litt3.QuotientGeometry
