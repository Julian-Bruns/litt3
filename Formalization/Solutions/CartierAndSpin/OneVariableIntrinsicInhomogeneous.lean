import Solutions.CartierAndSpin.IntrinsicConnectionInhomogeneous
import Solutions.SharedTensors.OneVariableCartier

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K]
  {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p] [PerfectField k]

/-- The true universal inhomogeneous differential criterion on ANY
actual one-variable field over perfect characteristic-p constants.
Finite generation and transcendence degree one derive every p-basis,
coordinate and Cartier-existence input; all solutions and gauges are
constructed in the ORIGINAL field. No regularity or H0 assertion occurs. -/
theorem actual_one_variable_intrinsic_inhomogeneous_criterion
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (omega : KaehlerDifferential k K)
    (hfixed : (oneVariableRationalCartier (p := p) hfg htrdeg).toAddHom omega = omega) :
    ∃ u : Kˣ,
      KaehlerDifferential.D k K (u : K) = (u : K) • omega ∧
      ∀ eta : KaehlerDifferential k K,
        (∃ v : K, KaehlerDifferential.D k K v - v • omega = eta) ↔
          (oneVariableRationalCartier (p := p) hfg htrdeg).toAddHom
            ((u : K)⁻¹ • eta) = 0 := by
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨e, he⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) b
  exact p_basis_intrinsic_inhomogeneous_connection_criterion
    (oneVariableRationalCartier (p := p) hfg htrdeg) b e he omega hfixed

end Litt3.CartierAndSpin
