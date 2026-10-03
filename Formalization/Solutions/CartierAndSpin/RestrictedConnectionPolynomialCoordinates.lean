import Solutions.CartierAndSpin.RestrictedConnectionCentralizers
import Solutions.CartierAndSpin.MinimalPolynomialRemainders

namespace Litt3.CartierAndSpin

open Polynomial Module Litt3.SharedTensors

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- Every actual commuting connection operator has a UNIQUE original
polynomial coordinate of degree below p. Cyclicity, minpoly and degree
are all derived from the literal p-basis and normalized derivation. -/
theorem actual_normalized_connection_commuting_operator_unique_polynomial
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K)
    (E : Module.End (frobeniusSubfield K p) K)
    (hcommute : Commute (scalarDerivationConnection D f) E) :
    ∃! P : (frobeniusSubfield K p)[X],
      P.natDegree < p ∧ E = aeval (scalarDerivationConnection D f) P := by
  letI : Module.Finite (frobeniusSubfield K p) K := Module.Finite.of_basis b.basis
  have hmember : E ∈ Subalgebra.centralizer (frobeniusSubfield K p)
      ({scalarDerivationConnection D f} : Set (Module.End (frobeniusSubfield K p) K)) := by
    rw [Subalgebra.mem_centralizer_iff]
    intro T hT
    have hTL : T = scalarDerivationConnection D f := Set.mem_singleton_iff.mp hT
    subst T
    exact hcommute.eq
  rw [actual_normalized_connection_centralizer b D hDt f, AlgHom.mem_range] at hmember
  obtain ⟨P, hP⟩ := hmember
  obtain ⟨Q, hQ, hunique⟩ := actual_integral_polynomial_value_unique_remainder
    (scalarDerivationConnection D f) (LinearMap.isIntegral _) P
  rw [actual_normalized_connection_minpoly_degree b D hDt f] at hQ hunique
  refine ⟨Q, ⟨hQ.1, hP.symm.trans hQ.2.symm⟩, ?_⟩
  intro S hS
  exact hunique S ⟨hS.1, hS.2.symm.trans hP.symm⟩

end Litt3.CartierAndSpin
