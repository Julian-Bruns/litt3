import Solutions.QuotientGeometry.DVRCompletedDiagramTransport

namespace Litt3.QuotientGeometry

variable {k B R S : Type*} [Field k]
  [CommRing B] [IsDomain B] [IsDiscreteValuationRing B] [Algebra k B]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra k S]

/-- A full fixed-base comparison is independent of every original
uniformizer choice on the three actual DVRs. All coordinate changes
and their whole-field commutation are constructed. -/
theorem actual_dvr_completed_comparison_change_parameters
    (dB dB' : DVRCompletionParameters k B)
    (dR dR' : DVRCompletionParameters k R)
    (dS dS' : DVRCompletionParameters k S)
    (χ : B →ₐ[k] R) (θ : B →ₐ[k] S)
    [IsLocalHom χ.toRingHom] [IsLocalHom θ.toRingHom]
    (hiχ : Function.Injective χ) (hiθ : Function.Injective θ)
    (hfields : ParameterFieldsEquivalent
      (completedDVRLaurentMap dB' dR' χ hiχ)
      (completedDVRLaurentMap dB' dS' θ hiθ)) :
    ParameterFieldsEquivalent
      (completedDVRLaurentMap dB dR χ hiχ)
      (completedDVRLaurentMap dB dS θ hiθ) := by
  exact actual_dvr_completed_field_comparison_transport dB dB' dR dS dR' dS'
    χ θ χ θ hiχ hiθ hiχ hiθ (AlgEquiv.refl : B ≃ₐ[k] B)
    (AlgEquiv.refl : R ≃ₐ[k] R) (AlgEquiv.refl : S ≃ₐ[k] S)
    (by simp) (by simp) hfields

end Litt3.QuotientGeometry
