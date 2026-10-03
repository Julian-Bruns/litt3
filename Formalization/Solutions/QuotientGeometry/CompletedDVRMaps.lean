import Definitions.QuotientGeometry.DVRCompletionParameters
import Solutions.QuotientGeometry.AdicAlgebraMaps
import Solutions.QuotientGeometry.DVRPowerSeriesChart
import Solutions.QuotientGeometry.AlgebraicallyClosedDVRCompletions

namespace Litt3.QuotientGeometry

open IsLocalRing

variable {k R S T : Type*} [Field k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra k S]
  [CommRing T] [IsDomain T] [IsDiscreteValuationRing T] [Algebra k T]

local instance (φ : R →ₐ[k] S) (ψ : S →ₐ[k] T)
    [IsLocalHom φ.toRingHom] [IsLocalHom ψ.toRingHom] :
    IsLocalHom (ψ.comp φ).toRingHom :=
  RingHom.isLocalHom_comp ψ.toRingHom φ.toRingHom

noncomputable def DVRCompletionParameters.chart (d : DVRCompletionParameters k R) :
    PowerSeries k ≃ₐ[k] AdicCompletion (maximalIdeal R) R :=
  dvrPowerSeriesAlgChart d.parameter d.irreducible d.residue_surjective

noncomputable def dvrCompletionParametersOverClosed
    [IsAlgClosed k] [Module.Finite k (ResidueField R)] : DVRCompletionParameters k R := by
  exact ⟨Classical.choose (IsDiscreteValuationRing.exists_irreducible R),
    Classical.choose_spec (IsDiscreteValuationRing.exists_irreducible R),
    IsAlgClosed.algebraMap_bijective_of_isIntegral.2⟩

theorem local_map_maximal_ideal_le
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] :
    (maximalIdeal R).map φ.toRingHom ≤ maximalIdeal S :=
  ((local_hom_TFAE φ.toRingHom).out 0 2 rfl rfl).mp inferInstance

noncomputable def completedDVRPowerSeriesMap
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] : PowerSeries k →ₐ[k] PowerSeries k :=
  dS.chart.symm.toAlgHom.comp
    ((adicAlgMap (maximalIdeal R) (maximalIdeal S) φ
      (local_map_maximal_ideal_le φ)).comp dR.chart.toAlgHom)

theorem completedDVRPowerSeriesMap_stalk
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] (r : R) :
    completedDVRPowerSeriesMap dR dS φ (dR.chart.symm (AdicCompletion.of _ R r)) =
      dS.chart.symm (AdicCompletion.of _ S (φ r)) := by
  change dS.chart.symm
      (adicAlgMap _ _ φ (local_map_maximal_ideal_le φ)
        (dR.chart (dR.chart.symm (AdicCompletion.of _ R r)))) = _
  rw [dR.chart.apply_symm_apply, adicAlgMap_of]

theorem completedDVRPowerSeriesMap_comp
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (dT : DVRCompletionParameters k T)
    (φ : R →ₐ[k] S) (ψ : S →ₐ[k] T)
    [IsLocalHom φ.toRingHom] [IsLocalHom ψ.toRingHom] :
    (completedDVRPowerSeriesMap dS dT ψ).comp (completedDVRPowerSeriesMap dR dS φ) =
      completedDVRPowerSeriesMap dR dT (ψ.comp φ) := by
  apply AlgHom.ext
  intro f
  change dT.chart.symm (adicAlgMap _ _ ψ (local_map_maximal_ideal_le ψ)
      (dS.chart (dS.chart.symm
        (adicAlgMap _ _ φ (local_map_maximal_ideal_le φ) (dR.chart f))))) =
    dT.chart.symm (adicAlgMap _ _ (ψ.comp φ)
      (local_map_maximal_ideal_le (ψ.comp φ)) (dR.chart f))
  rw [dS.chart.apply_symm_apply]
  apply congrArg dT.chart.symm
  exact AlgHom.congr_fun (adicAlgMap_comp (maximalIdeal R) (maximalIdeal S)
    (maximalIdeal T) φ ψ (local_map_maximal_ideal_le φ)
      (local_map_maximal_ideal_le ψ)) (dR.chart f)

theorem local_residue_map_surjective_of_coefficient_residue
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom]
    (hres : Function.Surjective (algebraMap k (ResidueField S))) :
    Function.Surjective (ResidueField.map φ.toRingHom) := by
  intro b
  obtain ⟨c, hc⟩ := hres b
  refine ⟨residue R (algebraMap k R c), ?_⟩
  rw [ResidueField.map_residue]
  change residue S (φ (algebraMap k R c)) = b
  rw [φ.commutes]
  exact hc

noncomputable def unramifiedCompletedDVRPowerSeriesEquiv
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom]
    (hunram : φ.toRingHom.FormallyUnramified) (hfinite : φ.toRingHom.EssFiniteType) :
    PowerSeries k ≃ₐ[k] PowerSeries k :=
  dR.chart.trans
    ((localDVRCompletionAlgEquiv φ dR.parameter dR.irreducible
      (formally_unramified_local_map_maximal_ideal φ.toRingHom hunram hfinite)
      (local_residue_map_surjective_of_coefficient_residue φ dS.residue_surjective)).trans
        dS.chart.symm)

theorem unramifiedCompletedDVRPowerSeriesEquiv_toAlgHom
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom]
    (hunram : φ.toRingHom.FormallyUnramified) (hfinite : φ.toRingHom.EssFiniteType) :
    (unramifiedCompletedDVRPowerSeriesEquiv dR dS φ hunram hfinite).toAlgHom =
      completedDVRPowerSeriesMap dR dS φ := by
  ext f
  rfl

end Litt3.QuotientGeometry
