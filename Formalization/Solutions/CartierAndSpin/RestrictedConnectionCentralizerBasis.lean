import Solutions.CartierAndSpin.RestrictedConnectionCentralizerAlgebra

namespace Litt3.CartierAndSpin

open Polynomial Module Litt3.SharedTensors

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The ENTIRE actual Kp-linear commutant has the actual power basis
1,L,...,L^(p-1), constructed from its literal monic quotient algebra. -/
theorem actual_normalized_connection_centralizer_power_basis_exists
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    ∃ B : Basis (Fin p) (frobeniusSubfield K p)
      (Subalgebra.centralizer (frobeniusSubfield K p)
        ({scalarDerivationConnection D f} : Set (Module.End (frobeniusSubfield K p) K))),
      ∀ i, (B i).val = (scalarDerivationConnection D f) ^ (i : ℕ) := by
  let P := (X : (frobeniusSubfield K p)[X]) ^ p + C (actualConnectionCurvature b D hDt f)
  let pb := AdjoinRoot.powerBasis' (Polynomial.monic_X_pow_add_C
    (actualConnectionCurvature b D hDt f) (Fact.out : p.Prime).ne_zero)
  have hdim : pb.dim = p := Polynomial.natDegree_X_pow_add_C
  let B := (pb.basis.reindex (finCongr hdim)).map
    (actualConnectionCentralizerAlgebraEquiv b D hDt f).toLinearEquiv
  refine ⟨B, ?_⟩
  intro i
  simp only [B, Basis.map_apply, Basis.reindex_apply]
  change ((actualConnectionCentralizerAlgebraEquiv b D hDt f)
    (pb.basis ((finCongr hdim).symm i))).val = _
  rw [pb.basis_eq_pow, map_pow]
  change (actualConnectionCentralizerAlgebraEquiv b D hDt f
    (AdjoinRoot.root ((X : (frobeniusSubfield K p)[X]) ^ p +
      C (actualConnectionCurvature b D hDt f)))).val ^ (i : ℕ) = _
  rw [actual_connection_centralizer_algebra_equiv_root]

/-- Any two actual Kp-linear operators commuting with the normalized
connection commute with each other, with no supplied normal form. -/
theorem actual_normalized_connection_commutant_commutes
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K)
    (E F : Module.End (frobeniusSubfield K p) K)
    (hE : Commute (scalarDerivationConnection D f) E)
    (hF : Commute (scalarDerivationConnection D f) F) : Commute E F := by
  obtain ⟨v, _, B, hB⟩ := actual_normalized_connection_cyclic_basis_exists b D hDt f
  obtain ⟨P, rfl⟩ := cyclic_basis_commuting_operator_is_polynomial
    (scalarDerivationConnection D f) E v B hB hE
  obtain ⟨Q, rfl⟩ := cyclic_basis_commuting_operator_is_polynomial
    (scalarDerivationConnection D f) F v B hB hF
  change aeval (scalarDerivationConnection D f) P * aeval (scalarDerivationConnection D f) Q =
    aeval (scalarDerivationConnection D f) Q * aeval (scalarDerivationConnection D f) P
  rw [← map_mul, ← map_mul, mul_comm P Q]

end Litt3.CartierAndSpin
