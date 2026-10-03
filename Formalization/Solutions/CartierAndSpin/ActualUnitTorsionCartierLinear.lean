import Solutions.CartierAndSpin.ActualUnitTorsionCartier
import Definitions.CartierAndSpin.PrimeTorsionModules

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k F G E : Type*} [Field k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]
  [Algebra.IsSeparable F E] [Algebra.IsSeparable G E]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [PerfectField k]

/-- The original multiplicative quotient p-torsion/shared Cartier-fixed
form identification is literally F_p-linear for the canonical module
structures. Additivity forces linearity over the actual prime subfield. -/
noncomputable def actual_unit_quotient_p_torsion_cartier_linear_equiv
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    (hintersection : EndpointFieldIntersectionConstants
      (algebraMap k F) (algebraMap k G) (algebraMap F E) (algebraMap G E))
    (CE : RationalCartierOperator k E p) :
    powerTorsionSubgroup
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p ≃ₗ[ZMod p]
      sharedIntrinsicCartierFixedForms k F G E CE :=
  { actual_unit_quotient_p_torsion_cartier_equiv
      hfgF htrdegF hfgG htrdegG hfgE htrdegE hintersection CE with
    map_smul' := by
      intro c x
      exact ZMod.map_smul (actual_unit_quotient_p_torsion_cartier_equiv
        hfgF htrdegF hfgG htrdegG hfgE htrdegE hintersection CE) c x }

end Litt3.CartierAndSpin
