import Solutions.CartierAndSpin.OriginalConnectionScalarRootGauge
import Solutions.CartierAndSpin.OneVariableConnectionAlternatives

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k R K : Type*} [Field k] [PerfectField k] [CommRing R] [Field K]
  [Algebra k K] [Algebra R K] {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p]

/-- Actual perfect-constant FG/trdeg-one fields derive the scalar-root
connection normal form without a supplied p-basis. The SAME original
R-linear connection is multiplication-gauged in K; no finite dimension
over R or compatibility between R and k is presumed. -/
theorem actual_one_variable_connection_scalar_root_unit_gauge
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) (D : Derivation R K K)
    (t : K) (hDt : D t = 1) (f : K) (a : frobeniusSubfield K p)
    (ha : (a : K) ^ p = -(D^[p - 1] f + f ^ p)) :
    ∃ u : Kˣ, ∀ x : K,
      scalarDerivationConnection D f ((u : K) * x) =
        (u : K) * (D x + (a : K) * x) := by
  obtain ⟨b, hb⟩ := actual_one_variable_normalized_power_basis_exists hfg htrdeg D t hDt
  have hDb : D b.parameter = 1 := by rw [hb]; exact hDt
  exact actual_original_connection_scalar_root_unit_gauge b D hDb f a ha

end Litt3.CartierAndSpin
