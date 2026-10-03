import Solutions.SharedTensors.RationalCartierBaseChange
import Solutions.SharedTensors.DifferentialRatios
import Solutions.CurveArithmetic.EmbeddedFields

namespace Litt3.SharedTensors

variable {k K L : Type*} [Field k] [Field K] [Field L]
  [Algebra k K] [Algebra k L] [Algebra K L] [IsScalarTower k K L]
  [Algebra.IsSeparable K L]
variable {p : ℕ} [Fact p.Prime] [CharP K p] [CharP L p]

theorem rationalCartierRatio_map
    (CK : RationalCartierOperator k K p) (CL : RationalCartierOperator k L p)
    (bK : PowerPBasis K p) (bL : PowerPBasis L p)
    (hparameter : bL.parameter = algebraMap K L bK.parameter)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hnormalized : e (KaehlerDifferential.D k K bK.parameter) = 1)
    (theta : KaehlerDifferential k K) :
    rationalCartierRatio (separableKaehlerCoordinate (L := L) e) CL
      (KaehlerDifferential.map k k K L theta) =
      algebraMap K L (rationalCartierRatio e CK theta) := by
  unfold rationalCartierRatio
  rw [rational_cartier_separable_base_change CK CL bK bL hparameter e hnormalized]
  exact rationalDifferentialRatio_map e _ theta

theorem rationalCartierRecoveryDerivative_map
    (CK : RationalCartierOperator k K p) (CL : RationalCartierOperator k L p)
    (bK : PowerPBasis K p) (bL : PowerPBasis L p)
    (hparameter : bL.parameter = algebraMap K L bK.parameter)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hnormalized : e (KaehlerDifferential.D k K bK.parameter) = 1)
    (theta : KaehlerDifferential k K) :
    rationalCartierRecoveryDerivative (separableKaehlerCoordinate (L := L) e) CL
      (KaehlerDifferential.map k k K L theta) =
      algebraMap K L (rationalCartierRecoveryDerivative e CK theta) := by
  unfold rationalCartierRecoveryDerivative
  rw [rationalCartierRatio_map CK CL bK bL hparameter e hnormalized,
    ← KaehlerDifferential.map_D k k K L]
  exact rationalDifferentialRatio_map e _ theta

/-- If an actual rational differential descends through an actual
separable subfield and its two actual recovery functions have coprime
function degrees, that subfield is the whole field. Both recovery
functions are derived from universal differentials and intrinsic Cartier;
no field-generation conclusion is an input. -/
theorem actual_cartier_differential_field_recovery
    (CK : RationalCartierOperator k K p) (CL : RationalCartierOperator k L p)
    (bK : PowerPBasis K p) (bL : PowerPBasis L p)
    (hparameter : bL.parameter = algebraMap K L bK.parameter)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hnormalized : e (KaehlerDifferential.D k K bK.parameter) = 1)
    (theta : KaehlerDifferential k K)
    (hcoprime : Nat.Coprime
      (Module.finrank (IntermediateField.adjoin k
        {rationalCartierRatio (separableKaehlerCoordinate (L := L) e) CL
          (KaehlerDifferential.map k k K L theta)}) L)
      (Module.finrank (IntermediateField.adjoin k
        {rationalCartierRecoveryDerivative (separableKaehlerCoordinate (L := L) e) CL
          (KaehlerDifferential.map k k K L theta)}) L)) :
    Function.Surjective (algebraMap K L) := by
  let f : K →ₐ[k] L := IsScalarTower.toAlgHom k K L
  let q := rationalCartierRatio (separableKaehlerCoordinate (L := L) e) CL
    (KaehlerDifferential.map k k K L theta)
  let r := rationalCartierRecoveryDerivative (separableKaehlerCoordinate (L := L) e) CL
    (KaehlerDifferential.map k k K L theta)
  have hq : q ∈ f.fieldRange := by
    rw [AlgHom.mem_fieldRange]
    exact ⟨rationalCartierRatio e CK theta,
      (rationalCartierRatio_map CK CL bK bL hparameter e hnormalized theta).symm⟩
  have hr : r ∈ f.fieldRange := by
    rw [AlgHom.mem_fieldRange]
    exact ⟨rationalCartierRecoveryDerivative e CK theta,
      (rationalCartierRecoveryDerivative_map CK CL bK bL hparameter e hnormalized theta).symm⟩
  have hqadjoin : IntermediateField.adjoin k {q} ≤ f.fieldRange := by
    rw [IntermediateField.adjoin_le_iff]
    intro x hx
    exact Set.mem_singleton_iff.mp hx ▸ hq
  have hradjoin : IntermediateField.adjoin k {r} ≤ f.fieldRange := by
    rw [IntermediateField.adjoin_le_iff]
    intro x hx
    exact Set.mem_singleton_iff.mp hx ▸ hr
  have hgenerate : IntermediateField.adjoin k {q} ⊔ IntermediateField.adjoin k {r} = ⊤ :=
    Litt3.CurveArithmetic.coprime_embedded_fields_generate _ _ hcoprime
  have hfull : f.fieldRange = ⊤ := by
    apply top_unique
    rw [← hgenerate]
    exact sup_le hqadjoin hradjoin
  exact AlgHom.fieldRange_eq_top.mp hfull

end Litt3.SharedTensors
