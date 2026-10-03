import Solutions.SharedTensors.OneVariableCartierBaseChange
import Solutions.SharedTensors.CartierFieldRecovery

namespace Litt3.SharedTensors

variable {k K L : Type*} [Field k] [Field K] [Field L] [PerfectField k]
  [Algebra k K] [Algebra k L] [Algebra K L] [IsScalarTower k K L]
  [Algebra.IsSeparable K L]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p] [CharP L p]

theorem one_variable_rationalCartierRatio_map
    (hfgK : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdegK : Algebra.trdeg k K = 1)
    (CK : RationalCartierOperator k K p) (CL : RationalCartierOperator k L p)
    (e : KaehlerDifferential k K ≃ₗ[K] K) (theta : KaehlerDifferential k K) :
    rationalCartierRatio (separableKaehlerCoordinate (L := L) e) CL
      (KaehlerDifferential.map k k K L theta) =
      algebraMap K L (rationalCartierRatio e CK theta) := by
  unfold rationalCartierRatio
  rw [one_variable_rational_cartier_separable_base_change
    hfgK htrdegK CK CL]
  exact rationalDifferentialRatio_map e _ theta

theorem one_variable_rationalCartierRecoveryDerivative_map
    (hfgK : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdegK : Algebra.trdeg k K = 1)
    (CK : RationalCartierOperator k K p) (CL : RationalCartierOperator k L p)
    (e : KaehlerDifferential k K ≃ₗ[K] K) (theta : KaehlerDifferential k K) :
    rationalCartierRecoveryDerivative (separableKaehlerCoordinate (L := L) e) CL
      (KaehlerDifferential.map k k K L theta) =
      algebraMap K L (rationalCartierRecoveryDerivative e CK theta) := by
  unfold rationalCartierRecoveryDerivative
  rw [one_variable_rationalCartierRatio_map hfgK htrdegK CK CL e theta,
    ← KaehlerDifferential.map_D k k K L]
  exact rationalDifferentialRatio_map e _ theta

/-- Actual Cartier field recovery from a genuine one-variable field,
without supplied p-bases or normalized parameter coordinates. Standard
intrinsic operators exist and are unique by the preceding construction. -/
theorem one_variable_cartier_differential_field_recovery
    (hfgK : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdegK : Algebra.trdeg k K = 1)
    (CK : RationalCartierOperator k K p) (CL : RationalCartierOperator k L p)
    (e : KaehlerDifferential k K ≃ₗ[K] K) (theta : KaehlerDifferential k K)
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
      (one_variable_rationalCartierRatio_map
        hfgK htrdegK CK CL e theta).symm⟩
  have hr : r ∈ f.fieldRange := by
    rw [AlgHom.mem_fieldRange]
    exact ⟨rationalCartierRecoveryDerivative e CK theta,
      (one_variable_rationalCartierRecoveryDerivative_map
        hfgK htrdegK CK CL e theta).symm⟩
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
