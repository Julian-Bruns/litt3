import Solutions.CartierAndSpin.OriginalConnectionMinimalPolynomial
import Solutions.CartierAndSpin.OneVariableConnectionAlternatives

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {k R K : Type*} [Field k] [PerfectField k] [CommRing R] [Field K]
  [Algebra k K] [Algebra R K] {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p]

/-- Construct the full minimal polynomial for EVERY actual normalized
derivation on a genuine one-variable function field. Full p-basis,
degree p, Frobenius scalar membership and canonical rebasing are all
derived; no basis, minimal polynomial or curvature scalar is supplied. -/
theorem actual_one_variable_connection_minpoly
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) (D : Derivation R K K)
    (t : K) (hDt : D t = 1) (f : K) :
    ∃ c : frobeniusSubfield K p,
      (c : K) = D^[p - 1] f + f ^ p ∧
      minpoly (frobeniusSubfield K p) (scalarDerivationConnection
        (frobeniusLinearDerivation (p := p) D) f) =
          (X : (frobeniusSubfield K p)[X]) ^ p + C c ∧
      (minpoly (frobeniusSubfield K p) (scalarDerivationConnection
        (frobeniusLinearDerivation (p := p) D) f)).natDegree = p := by
  obtain ⟨b, hb⟩ := actual_one_variable_normalized_power_basis_exists hfg htrdeg D t hDt
  have hDb : D b.parameter = 1 := by simpa only [hb] using hDt
  refine ⟨actualConnectionCurvature b (frobeniusLinearDerivation D) hDb f, ?_,
    original_normalized_connection_minpoly b D hDb f,
    original_normalized_connection_minpoly_degree b D hDb f⟩
  rfl

end Litt3.CartierAndSpin
