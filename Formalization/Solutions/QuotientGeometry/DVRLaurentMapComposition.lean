import Solutions.QuotientGeometry.DVRCompletedFractionMaps

namespace Litt3.QuotientGeometry

variable {k R S T : Type*} [Field k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra k S]
  [CommRing T] [IsDomain T] [IsDiscreteValuationRing T] [Algebra k T]

local instance localCompDVRLaurentMap (φ : R →ₐ[k] S) (ψ : S →ₐ[k] T)
    [IsLocalHom φ.toRingHom] [IsLocalHom ψ.toRingHom] :
    IsLocalHom (ψ.comp φ).toRingHom :=
  RingHom.isLocalHom_comp ψ.toRingHom φ.toRingHom

/-- Composition of genuine injective local maps commutes with the
entire constructed completed fraction-field maps. -/
theorem completedDVRLaurentMap_comp
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (dT : DVRCompletionParameters k T)
    (φ : R →ₐ[k] S) (ψ : S →ₐ[k] T)
    [IsLocalHom φ.toRingHom] [IsLocalHom ψ.toRingHom]
    (hiφ : Function.Injective φ) (hiψ : Function.Injective ψ) :
    (completedDVRLaurentMap dS dT ψ hiψ).comp
        (completedDVRLaurentMap dR dS φ hiφ) =
      completedDVRLaurentMap dR dT (ψ.comp φ) (hiψ.comp hiφ) := by
  apply IsFractionRing.ringHom_ext (A := PowerSeries k)
  intro f
  change completedDVRLaurentMap dS dT ψ hiψ
      (completedDVRLaurentMap dR dS φ hiφ (f : LaurentSeries k)) =
    completedDVRLaurentMap dR dT (ψ.comp φ) (hiψ.comp hiφ) (f : LaurentSeries k)
  rw [completedDVRLaurentMap_power_series, completedDVRLaurentMap_power_series,
    completedDVRLaurentMap_power_series]
  exact congrArg (fun p : PowerSeries k => (p : LaurentSeries k))
    (AlgHom.congr_fun (completedDVRPowerSeriesMap_comp dR dS dT φ ψ) f)

end Litt3.QuotientGeometry
