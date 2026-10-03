import Solutions.CartierAndSpin.CyclicPolynomialOperators
import Solutions.CartierAndSpin.RestrictedConnectionMinimalPolynomial

namespace Litt3.CartierAndSpin

open Polynomial Module Litt3.SharedTensors

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- Construct an ACTUAL original cyclic vector and its full power basis
for every normalized scalar connection. No vector, Jordan matrix or
cyclicity conclusion is supplied as a premise. -/
theorem actual_normalized_connection_cyclic_basis_exists
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    ∃ v : K, v ≠ 0 ∧ ∃ B : Basis (Fin p) (frobeniusSubfield K p) K,
      ∀ i, B i = ((scalarDerivationConnection D f) ^ (i : ℕ)) v := by
  letI : Module.Finite (frobeniusSubfield K p) K := Module.Finite.of_basis b.basis
  have hdegree : (minpoly (frobeniusSubfield K p)
      (scalarDerivationConnection D f)).natDegree = Module.finrank (frobeniusSubfield K p) K := by
    rw [actual_normalized_connection_minpoly_degree b D hDt f,
      actual_power_p_basis_field_finrank b]
  have h := actual_endomorphism_exists_cyclic_basis (scalarDerivationConnection D f) hdegree
  rw [actual_normalized_connection_minpoly_degree b D hDt f] at h
  obtain ⟨v, B, hB⟩ := h
  refine ⟨v, ?_, B, hB⟩
  have hne := B.ne_zero (⟨0, (Fact.out : p.Prime).pos⟩ : Fin p)
  simpa only [hB, pow_zero, Module.End.one_apply] using hne

end Litt3.CartierAndSpin
