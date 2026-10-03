import Definitions.CartierAndSpin.SharedDifferentialSubspaces
import Definitions.CartierAndSpin.SharedCartierFixedForms
import Solutions.SharedTensors.OneVariableCartierBaseChange

set_option synthInstance.maxHeartbeats 100000

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k F G E : Type*} [Field k] [PerfectField k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]
  [Algebra.IsSeparable F E] [Algebra.IsSeparable G E]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP E p]

/-- Actual intrinsic Cartier preserves the literal intersection of
both original universal-differential images, by genuine separable
transport from the separately constructed endpoint operators. -/
theorem actual_cartier_preserves_shared_rational_space
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (CE : RationalCartierOperator k E p)
    (omega : KaehlerDifferential k E)
    (hw : omega ∈ sharedRationalDifferentialSubspace k F G E) :
    CE.toAddHom omega ∈ sharedRationalDifferentialSubspace k F G E := by
  letI : CharP F p := charP_of_injective_algebraMap (algebraMap k F).injective p
  letI : CharP G p := charP_of_injective_algebraMap (algebraMap k G).injective p
  let CF := oneVariableRationalCartier (p := p) hfgF htrdegF
  let CG := oneVariableRationalCartier (p := p) hfgG htrdegG
  obtain ⟨alpha, ha⟩ := hw.1
  obtain ⟨beta, hb⟩ := hw.2
  have hF : CE.toAddHom (actualRationalDifferentialPullback k F E alpha) =
      actualRationalDifferentialPullback k F E (CF.toAddHom alpha) :=
    one_variable_rational_cartier_separable_base_change hfgF htrdegF CF CE alpha
  have hG : CE.toAddHom (actualRationalDifferentialPullback k G E beta) =
      actualRationalDifferentialPullback k G E (CG.toAddHom beta) :=
    one_variable_rational_cartier_separable_base_change hfgG htrdegG CG CE beta
  exact ⟨⟨CF.toAddHom alpha, hF.symm.trans (congrArg CE.toAddHom ha)⟩,
    ⟨CG.toAddHom beta, hG.symm.trans (congrArg CE.toAddHom hb)⟩⟩

/-- Restriction of the actual source Cartier map to the actual shared
k-space; preservation is a theorem, not a structure input. -/
noncomputable def actualSharedRationalCartier
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (CE : RationalCartierOperator k E p) :
    ↥(sharedRationalDifferentialSubspace k F G E) →+
      ↥(sharedRationalDifferentialSubspace k F G E) where
  toFun omega := ⟨CE.toAddHom omega.val,
    actual_cartier_preserves_shared_rational_space hfgF htrdegF hfgG htrdegG
      CE omega.val omega.property⟩
  map_zero' := by apply Subtype.ext; exact map_zero CE.toAddHom
  map_add' a b := by apply Subtype.ext; exact map_add CE.toAddHom _ _

theorem actual_shared_rational_cartier_inverse_power_semilinear
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (CE : RationalCartierOperator k E p)
    (a : k) (omega : ↥(sharedRationalDifferentialSubspace k F G E)) :
    actualSharedRationalCartier hfgF htrdegF hfgG htrdegG CE (a ^ p • omega) =
      a • actualSharedRationalCartier hfgF htrdegF hfgG htrdegG CE omega := by
  apply Subtype.ext
  simpa only [actualSharedRationalCartier, AddMonoidHom.coe_mk,
    Submodule.coe_smul, ← map_pow, IsScalarTower.algebraMap_smul] using
    CE.pth_semilinear (algebraMap k E a) omega.val

end Litt3.CartierAndSpin
