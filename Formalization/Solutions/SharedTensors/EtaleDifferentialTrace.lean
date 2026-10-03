import Solutions.SharedTensors.SourceUniversalDifferentials

namespace Litt3.SharedTensors

variable {k K B : Type*} [CommRing k] [CommRing K] [CommRing B]
  [Algebra k K] [Algebra k B] [Algebra K B] [IsScalarTower k K B]
  [Algebra.FormallyEtale K B]

/-- Trace on actual rational universal differentials through the genuine
formally étale base-change equivalence. -/
noncomputable def etaleDifferentialTrace
    (e : KaehlerDifferential k K ≃ₗ[K] K) (omega : KaehlerDifferential k B) :
    KaehlerDifferential k K :=
  e.symm (Algebra.trace K B (etaleDifferentialCoordinate e omega))

theorem etaleDifferentialTrace_coordinate
    (e : KaehlerDifferential k K ≃ₗ[K] K) (omega : KaehlerDifferential k B) :
    e (etaleDifferentialTrace e omega) =
      Algebra.trace K B (etaleDifferentialCoordinate e omega) :=
  e.apply_symm_apply _

theorem etale_differential_coordinate_change
    (e e' : KaehlerDifferential k K ≃ₗ[K] K) (omega : KaehlerDifferential k B) :
    etaleDifferentialCoordinate e' omega =
      algebraMap K B (e' (e.symm 1)) * etaleDifferentialCoordinate e omega := by
  rw [rank_one_coordinate_change (etaleDifferentialCoordinate e)
    (etaleDifferentialCoordinate e') omega, etale_differential_coordinate_change_scalar]

/-- The literal differential trace is independent of the differential frame. -/
theorem etaleDifferentialTrace_independent
    (e e' : KaehlerDifferential k K ≃ₗ[K] K) (omega : KaehlerDifferential k B) :
    etaleDifferentialTrace e omega = etaleDifferentialTrace e' omega := by
  apply e'.injective
  rw [rank_one_coordinate_change e e' (etaleDifferentialTrace e omega),
    etaleDifferentialTrace_coordinate e omega,
    etaleDifferentialTrace_coordinate e' omega, etale_differential_coordinate_change e e' omega,
    ← Algebra.smul_def, map_smul, smul_eq_mul]

theorem etale_weighted_universal_differential_trace
    (e : KaehlerDifferential k K ≃ₗ[K] K) (a weight : B) :
    e (etaleDifferentialTrace e (weight • KaehlerDifferential.D k B a)) =
      Algebra.trace K B (weight *
        universalCoordinateDerivation (etaleDifferentialCoordinate e) a) := by
  rw [etaleDifferentialTrace_coordinate, map_smul, smul_eq_mul,
    universalCoordinateDerivation_apply]

theorem etale_differential_trace_zero (e : KaehlerDifferential k K ≃ₗ[K] K) :
    etaleDifferentialTrace (B := B) e 0 = 0 := by
  apply e.injective
  simp only [etaleDifferentialTrace_coordinate, map_zero]

theorem etale_differential_trace_add
    (e : KaehlerDifferential k K ≃ₗ[K] K) (omega psi : KaehlerDifferential k B) :
    etaleDifferentialTrace e (omega + psi) =
      etaleDifferentialTrace e omega + etaleDifferentialTrace e psi := by
  apply e.injective
  simp only [etaleDifferentialTrace_coordinate, map_add]

/-- Literal linearity uses the actual base-field embedding, so it does
not need to identify the base and source scalar actions. -/
theorem etale_differential_trace_base_smul
    (e : KaehlerDifferential k K ≃ₗ[K] K) (c : K) (omega : KaehlerDifferential k B) :
    etaleDifferentialTrace e (algebraMap K B c • omega) = c • etaleDifferentialTrace e omega := by
  apply e.injective
  rw [etaleDifferentialTrace_coordinate, map_smul, smul_eq_mul,
    ← Algebra.smul_def, map_smul, map_smul, etaleDifferentialTrace_coordinate]

end Litt3.SharedTensors
