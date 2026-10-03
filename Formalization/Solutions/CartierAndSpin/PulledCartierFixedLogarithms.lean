import Definitions.CartierAndSpin.SharedCartierFixedForms
import Solutions.CartierAndSpin.RationalCartierLogarithmicConverse
import Solutions.CartierAndSpin.LogarithmicDifferentialPullbacks
import Solutions.SharedTensors.OneVariableCartierBaseChange

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.Jacobians

variable {k F E : Type*} [Field k] [Field F] [Field E]
  [Algebra k F] [Algebra k E] [Algebra F E] [IsScalarTower k F E]
  [Algebra.IsSeparable F E] [PerfectField k]
variable {p : ℕ} [Fact p.Prime] [CharP k p]

/-- A Cartier-fixed original source form lying in an actual separable
endpoint differential image is the pullback of an actual endpoint
logarithmic differential. The endpoint fixedness and primitive are both
derived, using genuine differential injectivity and Cartier transport. -/
theorem pulled_cartier_fixed_form_is_endpoint_logarithmic
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (CE : RationalCartierOperator k E p) (omega : KaehlerDifferential k E)
    (himage : omega ∈ (KaehlerDifferential.map k k F E).toAddMonoidHom.range)
    (hfixed : CE.toAddHom omega = omega) :
    omega ∈ ((rationalLogarithmicDifferential k E).comp
      (rationalUnitPullback (algebraMap F E))).range := by
  letI : CharP F p := charP_of_injective_algebraMap (algebraMap k F).injective p
  letI : CharP E p := charP_of_injective_algebraMap (algebraMap k E).injective p
  let CF := oneVariableRationalCartier (p := p) hfgF htrdegF
  obtain ⟨alpha, halpha⟩ := himage
  change KaehlerDifferential.map k k F E alpha = omega at halpha
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfgF htrdegF
  obtain ⟨e, he⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) b
  have hfixalpha : CF.toAddHom alpha = alpha := by
    apply separable_universal_differential_map_injective (E := E) e
    rw [← one_variable_rational_cartier_separable_base_change hfgF htrdegF CF CE,
      halpha, hfixed]
  have hmem : alpha ∈ (rationalLogarithmicDifferential k F).range := by
    rw [one_variable_rational_logarithmic_range hfgF htrdegF CF,
      mem_intrinsicCartierFixedSubgroup]
    exact hfixalpha
  obtain ⟨u, hu⟩ := hmem
  refine ⟨u, ?_⟩
  change rationalLogarithmicDifferential k E
    (rationalUnitPullback (algebraMap F E) u) = omega
  rw [rational_logarithmic_differential_pullback, hu, halpha]

end Litt3.CartierAndSpin
