import Solutions.CartierAndSpin.RestrictedConnectionCentralizerBasis
import Solutions.CartierAndSpin.OneVariableConnectionAlternatives
import Solutions.CartierAndSpin.FrobeniusLinearDerivations

namespace Litt3.CartierAndSpin

open Polynomial Module Litt3.SharedTensors

variable {k R K : Type*} [Field k] [PerfectField k] [CommRing R] [Field K]
  [Algebra k K] [Algebra R K] {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p]

/-- Genuine one-variable fields construct the entire Kp-linear
commutant quotient and its power basis from actual FG/trdeg one.
Canonical rebasing retains the SAME original connection function;
no p-basis, scalar curvature membership or commuting normal form is
supplied. No claim about all R-linear commuting operators is made. -/
theorem actual_one_variable_connection_centralizer_algebra
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) (D : Derivation R K K)
    (t : K) (hDt : D t = 1) (f : K) :
    ∃ c : frobeniusSubfield K p,
      (c : K) = D^[p - 1] f + f ^ p ∧
      Nonempty (AdjoinRoot ((X : (frobeniusSubfield K p)[X]) ^ p + C c) ≃ₐ[frobeniusSubfield K p]
        Subalgebra.centralizer (frobeniusSubfield K p)
          ({scalarDerivationConnection (frobeniusLinearDerivation D) f} :
            Set (Module.End (frobeniusSubfield K p) K))) ∧
      ∃ B : Basis (Fin p) (frobeniusSubfield K p)
        (Subalgebra.centralizer (frobeniusSubfield K p)
          ({scalarDerivationConnection (frobeniusLinearDerivation D) f} :
            Set (Module.End (frobeniusSubfield K p) K))),
        ∀ i, (B i).val = (scalarDerivationConnection (frobeniusLinearDerivation D) f) ^ (i : ℕ) := by
  obtain ⟨b, hb⟩ := actual_one_variable_normalized_power_basis_exists hfg htrdeg D t hDt
  have hnormal : (frobeniusLinearDerivation D) b.parameter = 1 := by
    simpa only [hb] using hDt
  refine ⟨actualConnectionCurvature b (frobeniusLinearDerivation D) hnormal f, rfl,
    ⟨actualConnectionCentralizerAlgebraEquiv b (frobeniusLinearDerivation D) hnormal f⟩, ?_⟩
  exact actual_normalized_connection_centralizer_power_basis_exists b
    (frobeniusLinearDerivation D) hnormal f

end Litt3.CartierAndSpin
