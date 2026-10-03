import Definitions.CartierAndSpin.SharedDifferentialSubspaces
import Solutions.CartierAndSpin.RationalCartierLogarithmicConverse
import Solutions.CartierAndSpin.LogarithmicDifferentialPullbacks
import Solutions.SharedTensors.OneVariableCartierBaseChange
import Solutions.SharedTensors.SharedCartierCorrection

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k F G E : Type*} [Field k] [IsAlgClosed k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]
  [Algebra.IsSeparable F E] [Algebra.IsSeparable G E]
variable {p : ℕ} [Fact p.Prime] [CharP k p]

include p

/-- Every actual additive endpoint decomposition of a logarithmic
source form has an actual logarithmic endpoint choice whenever the
LITERAL shared k-subspace is finite dimensional of dimension at most
one. The shared-rank premise remains explicit; no geometric rank claim
or already logarithmic endpoint decomposition is assumed. -/
theorem actual_logarithmic_decomposition_has_logarithmic_choice
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    [Module.Finite k ↥(sharedRationalDifferentialSubspace k F G E)]
    (hdim : Module.finrank k ↥(sharedRationalDifferentialSubspace k F G E) ≤ 1)
    (u : Additive Eˣ) (alpha : KaehlerDifferential k F) (beta : KaehlerDifferential k G)
    (hdecomp : rationalLogarithmicDifferential k E u =
      actualRationalDifferentialPullback k G E beta -
        actualRationalDifferentialPullback k F E alpha) :
    ∃ f : Additive Fˣ, ∃ g : Additive Gˣ,
      rationalLogarithmicDifferential k E u =
        actualRationalDifferentialPullback k G E (rationalLogarithmicDifferential k G g) -
          actualRationalDifferentialPullback k F E (rationalLogarithmicDifferential k F f) := by
  letI : CharP F p := charP_of_injective_algebraMap (algebraMap k F).injective p
  letI : CharP G p := charP_of_injective_algebraMap (algebraMap k G).injective p
  letI : CharP E p := charP_of_injective_algebraMap (algebraMap k E).injective p
  let CF := oneVariableRationalCartier (p := p) hfgF htrdegF
  let CG := oneVariableRationalCartier (p := p) hfgG htrdegG
  let CE := oneVariableRationalCartier (p := p) hfgE htrdegE
  let mF := actualRationalDifferentialPullback k F E
  let mG := actualRationalDifferentialPullback k G E
  obtain ⟨bF⟩ := one_variable_power_p_basis_exists (p := p) hfgF htrdegF
  obtain ⟨eF, _⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) bF
  obtain ⟨bG⟩ := one_variable_power_p_basis_exists (p := p) hfgG htrdegG
  obtain ⟨eG, _⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) bG
  have hmF : Function.Injective mF :=
    by simpa only [mF, actualRationalDifferentialPullback, LinearMap.coe_restrictScalars]
      using separable_universal_differential_map_injective (E := E) eF
  have hmG : Function.Injective mG :=
    by simpa only [mG, actualRationalDifferentialPullback, LinearMap.coe_restrictScalars]
      using separable_universal_differential_map_injective (E := E) eG
  have hF : ∀ a, CE.toAddHom (mF a) = mF (CF.toAddHom a) :=
    one_variable_rational_cartier_separable_base_change hfgF htrdegF CF CE
  have hG : ∀ b, CE.toAddHom (mG b) = mG (CG.toAddHom b) :=
    one_variable_rational_cartier_separable_base_change hfgG htrdegG CG CE
  have hsemi : ∀ (c : k) (w : KaehlerDifferential k E),
      CE.toAddHom (c ^ p • w) = c • CE.toAddHom w := by
    intro c w
    simpa only [← map_pow, IsScalarTower.algebraMap_smul] using
      CE.pth_semilinear (algebraMap k E c) w
  have hfixed : CE.toAddHom (mG beta - mF alpha) = mG beta - mF alpha := by
    rw [← hdecomp]
    exact rational_logarithmic_differential_cartier_fixed CE u
  letI : Module.Finite k ↥(LinearMap.range mF ⊓ LinearMap.range mG) :=
    (inferInstance : Module.Finite k ↥(sharedRationalDifferentialSubspace k F G E))
  obtain ⟨alpha', beta', hfixF, hfixG, heq⟩ :=
    actual_shared_rank_le_one_fixed_difference_correction mF mG hmF hmG
      CF.toAddHom CG.toAddHom CE.toAddHom hF hG
      (n := p) (by exact (Fact.out : p.Prime).one_lt) hsemi hdim alpha beta hfixed
  have hmemF : alpha' ∈ (rationalLogarithmicDifferential k F).range := by
    rw [one_variable_rational_logarithmic_range hfgF htrdegF CF,
      mem_intrinsicCartierFixedSubgroup]
    exact hfixF
  have hmemG : beta' ∈ (rationalLogarithmicDifferential k G).range := by
    rw [one_variable_rational_logarithmic_range hfgG htrdegG CG,
      mem_intrinsicCartierFixedSubgroup]
    exact hfixG
  obtain ⟨f, hf⟩ := hmemF
  obtain ⟨g, hg⟩ := hmemG
  refine ⟨f, g, ?_⟩
  rw [hf, hg]
  exact hdecomp.trans heq.symm

end Litt3.CartierAndSpin
