import Solutions.CartierAndSpin.IntrinsicCartierRestrictedConnections
import Solutions.SharedTensors.OneVariableCartier

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K]
  {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p] [PerfectField k]

/-- The entire original one-variable connection criterion, with actual
Cartier, parameter, universal coordinate and derivative nilpotence ALL
constructed from finite generation and transcendence degree one.
No p-basis, coordinate, separating subfield, restricted formula,
logarithmic solution or Cartier-existence premise is supplied. -/
theorem actual_one_variable_intrinsic_connection_criteria_exists
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) :
    ∃ (t : K) (e : KaehlerDifferential k K ≃ₗ[K] K),
      e (KaehlerDifferential.D k K t) = 1 ∧
      (∀ a : K, (universalCoordinateDerivation e)^[p] a = 0) ∧
      ∀ omega : KaehlerDifferential k K,
        let C := oneVariableRationalCartier (p := p) hfg htrdeg
        let D := universalCoordinateDerivation e
        let L := scalarDerivationConnection D (e omega)
        (C.toAddHom omega = omega ↔ D^[p - 1] (e omega) + (e omega) ^ p = 0) ∧
        (C.toAddHom omega = omega ↔ ∀ a : K, L^[p] a = 0) ∧
        (C.toAddHom omega = omega ↔
          ∃ u : K, u ≠ 0 ∧ D u = e omega * u) ∧
        (Function.Bijective L ↔ C.toAddHom omega ≠ omega) := by
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨e, he⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) b
  refine ⟨b.parameter, e, he,
    fun a => actual_normalized_derivation_prime_iterate_zero b
      (universalCoordinateDerivation e) he a, ?_⟩
  intro omega
  let C := oneVariableRationalCartier (p := p) hfg htrdeg
  exact ⟨p_basis_intrinsic_cartier_fixed_iff_restricted_curvature_zero C b e he omega,
    p_basis_intrinsic_cartier_fixed_iff_connection_nilpotent C b e he omega,
    p_basis_intrinsic_cartier_fixed_iff_connection_solution C b e he omega,
    p_basis_intrinsic_cartier_connection_bijective_iff C b e he omega⟩

end Litt3.CartierAndSpin
