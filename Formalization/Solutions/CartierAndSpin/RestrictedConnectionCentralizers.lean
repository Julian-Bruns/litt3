import Solutions.CartierAndSpin.RestrictedConnectionCyclicBasis
import Solutions.CartierAndSpin.CyclicCentralizers

namespace Litt3.CartierAndSpin

open Polynomial Module Litt3.SharedTensors

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The ENTIRE genuine normalized-connection commutant is its actual
polynomial-evaluation subalgebra. The original cyclic vector and basis
are constructed, so no centralizer or cyclicity premise is assumed. -/
theorem actual_normalized_connection_centralizer
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    Subalgebra.centralizer (frobeniusSubfield K p)
      ({scalarDerivationConnection D f} : Set (Module.End (frobeniusSubfield K p) K)) =
        (aeval (scalarDerivationConnection D f)).range := by
  obtain ⟨v, _, B, hB⟩ := actual_normalized_connection_cyclic_basis_exists b D hDt f
  exact cyclic_basis_centralizer_eq_polynomial_range
    (scalarDerivationConnection D f) v B hB

end Litt3.CartierAndSpin
