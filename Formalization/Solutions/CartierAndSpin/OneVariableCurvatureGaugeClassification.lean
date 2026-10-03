import Solutions.CartierAndSpin.RestrictedCurvatureGaugeClassification
import Solutions.CartierAndSpin.OneVariableConnectionAlternatives

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k R K : Type*} [Field k] [PerfectField k] [CommRing R] [Field K]
  [Algebra k K] [Algebra R K] {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p]

/-- Actual one-variable fields derive the entire unit-gauge criterion
from FG/trdeg one, without any p-basis or scalar-extension solution input. -/
theorem actual_one_variable_curvature_eq_iff_connection_unit_intertwiner
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) (D : Derivation R K K)
    (t : K) (hDt : D t = 1) (f g : K) :
    D^[p - 1] f + f ^ p = D^[p - 1] g + g ^ p ↔
      ∃ u : Kˣ, ∀ a : K,
        scalarDerivationConnection D f ((u : K) * a) =
          (u : K) * scalarDerivationConnection D g a := by
  obtain ⟨b, hb⟩ := actual_one_variable_normalized_power_basis_exists hfg htrdeg D t hDt
  exact actual_normalized_curvature_eq_iff_connection_unit_intertwiner b D
    (by simpa only [hb] using hDt) f g

end Litt3.CartierAndSpin
