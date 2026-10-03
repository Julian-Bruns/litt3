import Solutions.CartierAndSpin.IntrinsicConnectionNilpotency
import Solutions.CartierAndSpin.OneVariableIntrinsicConnections
import Solutions.CartierAndSpin.OneVariableConnectionAlternatives

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K]
  {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p] [PerfectField k]

/-- Genuine one-variable fields construct the ORIGINAL universal
coordinate and actual Cartier operator, whose fixed forms have exact
original-connection nilpotency exponent p. No p-basis, coordinate or
nilpotency conclusion is supplied. -/
theorem actual_one_variable_intrinsic_exact_connection_nilpotency_exists
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) :
    ∃ (t : K) (e : KaehlerDifferential k K ≃ₗ[K] K),
      e (KaehlerDifferential.D k K t) = 1 ∧
      ∀ omega : KaehlerDifferential k K,
        let C := oneVariableRationalCartier (p := p) hfg htrdeg
        let L := scalarDerivationConnection (universalCoordinateDerivation e) (e omega)
        C.toAddHom omega = omega ↔
          L ^ p = 0 ∧ ∀ n : ℕ, n < p → L ^ n ≠ 0 := by
  obtain ⟨t, e, he, _, _⟩ := actual_one_variable_intrinsic_connection_criteria_exists hfg htrdeg
  have hDt : universalCoordinateDerivation e t = 1 := he
  obtain ⟨b, hb⟩ := actual_one_variable_normalized_power_basis_exists
    hfg htrdeg (universalCoordinateDerivation e) t hDt
  refine ⟨t, e, he, ?_⟩
  intro omega
  exact p_basis_intrinsic_cartier_fixed_iff_exact_connection_nilpotency
    (oneVariableRationalCartier (p := p) hfg htrdeg) b e
    (by simpa only [hb] using he) omega

end Litt3.CartierAndSpin
