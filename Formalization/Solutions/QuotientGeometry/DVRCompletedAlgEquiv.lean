import Solutions.QuotientGeometry.DVRBaseEquivCompletions
import Solutions.QuotientGeometry.DVRLaurentMapComposition

namespace Litt3.QuotientGeometry

variable {k R S : Type*} [Field k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra k S]

/-- The completed field equivalence induced by an actual original
coefficient-preserving local-ring equivalence. -/
noncomputable def actualDVRCompletedRingEquiv
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (e : R ≃ₐ[k] S) : LaurentSeries k ≃+* LaurentSeries k := by
  letI : IsLocalHom e.toAlgHom.toRingHom :=
    ⟨fun r hr => (MulEquiv.isUnit_map e).mp hr⟩
  let E := unramifiedCompletedDVRPowerSeriesEquiv dR dS e.toAlgHom
    (actual_algEquiv_formallyUnramified e)
    (RingHom.FiniteType.of_surjective _ e.surjective).essFiniteType
  letI : SMul k (LaurentSeries k) :=
    (inferInstance : Algebra k (LaurentSeries k)).toSMul
  letI : IsScalarTower k (PowerSeries k) (LaurentSeries k) :=
    IsScalarTower.of_algebraMap_eq' (R := k) (S := PowerSeries k)
      (A := LaurentSeries k) rfl
  exact (IsFractionRing.algEquivOfAlgEquiv E).toRingEquiv

/-- This equivalence is precisely the whole fraction-field map of
the original ring equivalence, on every Laurent series. -/
theorem actualDVRCompletedRingEquiv_toRingHom
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (e : R ≃ₐ[k] S) :
    letI : IsLocalHom e.toAlgHom.toRingHom :=
      ⟨fun r hr => (MulEquiv.isUnit_map e).mp hr⟩
    (actualDVRCompletedRingEquiv dR dS e).toRingHom =
      completedDVRLaurentMap dR dS e.toAlgHom e.injective := by
  letI : IsLocalHom e.toAlgHom.toRingHom :=
    ⟨fun r hr => (MulEquiv.isUnit_map e).mp hr⟩
  letI : SMul k (LaurentSeries k) :=
    (inferInstance : Algebra k (LaurentSeries k)).toSMul
  letI : IsScalarTower k (PowerSeries k) (LaurentSeries k) :=
    IsScalarTower.of_algebraMap_eq' (R := k) (S := PowerSeries k)
      (A := LaurentSeries k) rfl
  apply IsFractionRing.ringHom_ext (A := PowerSeries k)
  intro f
  change (actualDVRCompletedRingEquiv dR dS e) (f : LaurentSeries k) =
    completedDVRLaurentMap dR dS e.toAlgHom e.injective (f : LaurentSeries k)
  rw [completedDVRLaurentMap_power_series]
  change IsFractionRing.algEquivOfAlgEquiv
      (unramifiedCompletedDVRPowerSeriesEquiv dR dS e.toAlgHom
        (actual_algEquiv_formallyUnramified e)
        (RingHom.FiniteType.of_surjective _ e.surjective).essFiniteType)
      (algebraMap (PowerSeries k) (LaurentSeries k) f) = _
  rw [IsFractionRing.algEquivOfAlgEquiv_algebraMap]
  exact congrArg (fun p : PowerSeries k => (p : LaurentSeries k))
    (AlgHom.congr_fun (unramifiedCompletedDVRPowerSeriesEquiv_toAlgHom
      dR dS e.toAlgHom (actual_algEquiv_formallyUnramified e)
      (RingHom.FiniteType.of_surjective _ e.surjective).essFiniteType) f)

end Litt3.QuotientGeometry
