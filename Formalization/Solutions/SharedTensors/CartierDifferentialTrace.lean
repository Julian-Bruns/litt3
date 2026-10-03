import Solutions.SharedTensors.CartierFieldTrace
import Solutions.SharedTensors.OneVariableCartierBaseChange
import Solutions.SharedTensors.EtaleDifferentialTrace

namespace Litt3.SharedTensors

variable {k K L : Type*} [Field k] [Field K] [Field L]
  [Algebra k K] [Algebra k L] [Algebra K L] [IsScalarTower k K L]
  [FiniteDimensional K L] [Algebra.IsSeparable K L]

/-- Actual trace on universal differentials through the genuine
separable base-change equivalence. -/
noncomputable def separableDifferentialTrace
    (e : KaehlerDifferential k K ≃ₗ[K] K) (omega : KaehlerDifferential k L) :
    KaehlerDifferential k K :=
  e.symm (Algebra.trace K L (separableKaehlerCoordinate e omega))

theorem separableDifferentialTrace_coordinate
    (e : KaehlerDifferential k K ≃ₗ[K] K) (omega : KaehlerDifferential k L) :
    e (separableDifferentialTrace e omega) =
      Algebra.trace K L (separableKaehlerCoordinate e omega) :=
  e.apply_symm_apply _

theorem separableDifferentialTrace_independent
    (e e' : KaehlerDifferential k K ≃ₗ[K] K) (omega : KaehlerDifferential k L) :
    separableDifferentialTrace e omega = separableDifferentialTrace e' omega := by
  letI : Algebra.FormallyEtale K L := Algebra.FormallyEtale.of_isSeparable K L
  change etaleDifferentialTrace e omega = etaleDifferentialTrace e' omega
  exact etaleDifferentialTrace_independent e e' omega

variable {p : ℕ} [Fact p.Prime] [CharP K p] [CharP L p]

/-- Intrinsic Cartier commutes with the actual full differential trace
of a finite separable field extension, using the full p-basis expansions. -/
theorem rational_cartier_finite_separable_differential_trace
    (CK : RationalCartierOperator k K p) (CL : RationalCartierOperator k L p)
    (bK : PowerPBasis K p) (bL : PowerPBasis L p)
    (hparameter : bL.parameter = algebraMap K L bK.parameter)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hnormalized : e (KaehlerDifferential.D k K bK.parameter) = 1)
    (omega : KaehlerDifferential k L) :
    CK.toAddHom (separableDifferentialTrace e omega) =
      separableDifferentialTrace e (CL.toAddHom omega) := by
  let eL := separableKaehlerCoordinate (L := L) e
  have hL : eL (KaehlerDifferential.D k L bL.parameter) = 1 := by
    rw [hparameter, ← KaehlerDifferential.map_D k k K L]
    change separableKaehlerCoordinate e
      (KaehlerDifferential.map k k K L (KaehlerDifferential.D k K bK.parameter)) = 1
    rw [separableKaehlerCoordinate_map, hnormalized, map_one]
  apply e.injective
  rw [CK.coordinate_formula bK e hnormalized,
    separableDifferentialTrace_coordinate,
    separableDifferentialTrace_coordinate]
  change rationalCartierCoefficient K p bK (Algebra.trace K L (eL omega)) =
    Algebra.trace K L (eL (CL.toAddHom omega))
  rw [CL.coordinate_formula bL eL hL]
  exact rationalCartierCoefficient_finite_separable_trace bK bL hparameter (eL omega)

variable [CharP k p] [PerfectField k]

/-- The genuine one-variable field version constructs every compatible
p-basis and normalized coordinate, and accepts any actual frame used to
write the differential trace. -/
theorem one_variable_cartier_differential_trace
    (hfgK : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdegK : Algebra.trdeg k K = 1)
    (CK : RationalCartierOperator k K p) (CL : RationalCartierOperator k L p)
    (e : KaehlerDifferential k K ≃ₗ[K] K) (omega : KaehlerDifferential k L) :
    CK.toAddHom (separableDifferentialTrace e omega) =
      separableDifferentialTrace e (CL.toAddHom omega) := by
  obtain ⟨bK⟩ := one_variable_power_p_basis_exists (p := p) hfgK htrdegK
  obtain ⟨e0, he0⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) bK
  obtain ⟨bL, hbL⟩ := separable_power_p_basis_exists (L := L) bK
  rw [separableDifferentialTrace_independent e e0 omega,
    separableDifferentialTrace_independent e e0 (CL.toAddHom omega)]
  exact rational_cartier_finite_separable_differential_trace CK CL bK bL hbL e0 he0 omega

end Litt3.SharedTensors
