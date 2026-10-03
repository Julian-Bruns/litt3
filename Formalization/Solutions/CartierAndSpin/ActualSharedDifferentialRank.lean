import Solutions.CartierAndSpin.ActualSharedDifferentialSpan

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k F G E : Type*} [Field k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]

/-- The two actual rank-one endpoint differential modules and literal
constant intersection force the original shared space to be finite
of k-dimension at most one, including its zero boundary. -/
theorem actual_rank_one_endpoint_shared_space_finite_and_small
    (eF : KaehlerDifferential k F ≃ₗ[F] F)
    (eG : KaehlerDifferential k G ≃ₗ[G] G)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E)) :
    Module.Finite k ↥(sharedRationalDifferentialSubspace k F G E) ∧
      Module.finrank k ↥(sharedRationalDifferentialSubspace k F G E) ≤ 1 := by
  classical
  by_cases hz : sharedRationalDifferentialSubspace k F G E = ⊥
  · rw [hz]
    exact ⟨inferInstance, by simp⟩
  · obtain ⟨omega0, h0, h0ne⟩ := Submodule.exists_mem_ne_zero_of_ne_bot hz
    rw [actual_shared_differential_subspace_eq_span eF eG hinter omega0 h0 h0ne]
    exact ⟨inferInstance, by rw [finrank_span_singleton h0ne]⟩

/-- True one-variable endpoint fields over a perfect base supply their
universal rank-one modules. No source finite generation, source
transcendence degree, separability or characteristic premise is needed
for the resulting original shared-space bound. -/
theorem actual_one_variable_shared_space_finite_and_small [PerfectField k]
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E)) :
    Module.Finite k ↥(sharedRationalDifferentialSubspace k F G E) ∧
      Module.finrank k ↥(sharedRationalDifferentialSubspace k F G E) ≤ 1 := by
  obtain ⟨eF⟩ := one_variable_kaehler_coordinate_exists hfgF htrdegF
  obtain ⟨eG⟩ := one_variable_kaehler_coordinate_exists hfgG htrdegG
  exact actual_rank_one_endpoint_shared_space_finite_and_small eF eG hinter

/-- Every nonzero original shared space is exactly one dimensional;
the presence of a form is asserted separately rather than presumed. -/
theorem actual_rank_one_endpoint_shared_space_finrank_eq_one
    (eF : KaehlerDifferential k F ≃ₗ[F] F)
    (eG : KaehlerDifferential k G ≃ₗ[G] G)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (hne : sharedRationalDifferentialSubspace k F G E ≠ ⊥) :
    Module.finrank k ↥(sharedRationalDifferentialSubspace k F G E) = 1 := by
  obtain ⟨omega0, h0, h0ne⟩ := Submodule.exists_mem_ne_zero_of_ne_bot hne
  rw [actual_shared_differential_subspace_eq_span eF eG hinter omega0 h0 h0ne,
    finrank_span_singleton h0ne]

end Litt3.CartierAndSpin
