import Solutions.CartierAndSpin.EndpointDecompositionTorsor
import Solutions.CartierAndSpin.ActualSharedDifferentialRank
import Solutions.CartierAndSpin.LogarithmicDifferentialPullbacks

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 1000000

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k F G E : Type*} [Field k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]
  [Algebra.IsSeparable F E] [Algebra.IsSeparable G E]

/-- The original rational decomposition fiber is an ACTUAL torsor
under the literal shared k-subspace, retaining simultaneous endpoint
shifts. No characteristic or shared-dimension premise is required. -/
noncomputable def actualEndpointDecompositionSharedTorsor
    (eF : KaehlerDifferential k F ≃ₗ[F] F)
    (eG : KaehlerDifferential k G ≃ₗ[G] G)
    (omega : KaehlerDifferential k E)
    (alpha0 : KaehlerDifferential k F) (beta0 : KaehlerDifferential k G)
    (h0 : actualRationalDifferentialPullback k G E beta0 -
      actualRationalDifferentialPullback k F E alpha0 = omega) :
    AddTorsor ↥(sharedRationalDifferentialSubspace k F G E)
      (endpointDecompositionFiber
        (actualRationalDifferentialPullback k F E).toAddMonoidHom
        (actualRationalDifferentialPullback k G E).toAddMonoidHom omega) := by
  have hF : Function.Injective (actualRationalDifferentialPullback k F E) := by
    simpa only [actualRationalDifferentialPullback, LinearMap.coe_restrictScalars] using
      separable_universal_differential_map_injective (E := E) eF
  have hG : Function.Injective (actualRationalDifferentialPullback k G E) := by
    simpa only [actualRationalDifferentialPullback, LinearMap.coe_restrictScalars] using
      separable_universal_differential_map_injective (E := E) eG
  exact endpointDecompositionSharedTorsor
    (actualRationalDifferentialPullback k F E).toAddMonoidHom
    (actualRationalDifferentialPullback k G E).toAddMonoidHom
    hF hG omega alpha0 beta0 h0

/-- Actual one-variable hypotheses construct the endpoint universal
coordinates needed for original-map injectivity. The decomposition
fiber remains a torsor rather than an asserted nonempty set. -/
noncomputable def actualOneVariableEndpointDecompositionTorsor [PerfectField k]
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (omega : KaehlerDifferential k E)
    (alpha0 : KaehlerDifferential k F) (beta0 : KaehlerDifferential k G)
    (h0 : actualRationalDifferentialPullback k G E beta0 -
      actualRationalDifferentialPullback k F E alpha0 = omega) :
    AddTorsor ↥(sharedRationalDifferentialSubspace k F G E)
      (endpointDecompositionFiber
        (actualRationalDifferentialPullback k F E).toAddMonoidHom
        (actualRationalDifferentialPullback k G E).toAddMonoidHom omega) := by
  let eF := Classical.choice (one_variable_kaehler_coordinate_exists hfgF htrdegF)
  let eG := Classical.choice (one_variable_kaehler_coordinate_exists hfgG htrdegG)
  exact actualEndpointDecompositionSharedTorsor eF eG omega alpha0 beta0 h0

/-- If the literal shared space vanishes, any two original endpoint
decompositions agree. This is a uniqueness implication and presumes
neither existence of a decomposition nor a canonical root. -/
theorem actual_endpoint_decomposition_unique_of_shared_zero
    (eF : KaehlerDifferential k F ≃ₗ[F] F)
    (eG : KaehlerDifferential k G ≃ₗ[G] G)
    (hz : sharedRationalDifferentialSubspace k F G E = ⊥)
    (alpha alpha' : KaehlerDifferential k F)
    (beta beta' : KaehlerDifferential k G)
    (heq : actualRationalDifferentialPullback k G E beta -
        actualRationalDifferentialPullback k F E alpha =
      actualRationalDifferentialPullback k G E beta' -
        actualRationalDifferentialPullback k F E alpha') :
    alpha = alpha' ∧ beta = beta' := by
  have hshared : actualRationalDifferentialPullback k F E (alpha - alpha') ∈
      sharedRationalDifferentialSubspace k F G E := by
    refine ⟨⟨alpha - alpha', rfl⟩, ⟨beta - beta', ?_⟩⟩
    simp only [map_sub]
    calc
      _ = (actualRationalDifferentialPullback k G E beta -
          actualRationalDifferentialPullback k F E alpha) -
        (actualRationalDifferentialPullback k G E beta' -
          actualRationalDifferentialPullback k F E alpha') +
        (actualRationalDifferentialPullback k F E alpha -
          actualRationalDifferentialPullback k F E alpha') := by abel
      _ = _ := by rw [heq, sub_self, zero_add]
  rw [hz] at hshared
  have hF : Function.Injective (actualRationalDifferentialPullback k F E) := by
    simpa only [actualRationalDifferentialPullback, LinearMap.coe_restrictScalars] using
      separable_universal_differential_map_injective (E := E) eF
  have hG : Function.Injective (actualRationalDifferentialPullback k G E) := by
    simpa only [actualRationalDifferentialPullback, LinearMap.coe_restrictScalars] using
      separable_universal_differential_map_injective (E := E) eG
  have ha : alpha = alpha' := sub_eq_zero.mp (hF (hshared.trans (map_zero _).symm))
  refine ⟨ha, hG ?_⟩
  rw [ha] at heq
  exact sub_left_injective heq

end Litt3.CartierAndSpin
