import Solutions.CartierAndSpin.ActualUnitTorsionLogarithms
import Solutions.CartierAndSpin.SharedCartierFixedLogarithms

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k F G E : Type*} [Field k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]
  [Algebra.IsSeparable F E] [Algebra.IsSeparable G E]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [PerfectField k]

/-- Canonical actual quotient p-torsion/shared Cartier-fixed-form
isomorphism for a true two-leg function-field configuration. Both actual
field inclusions and both ORIGINAL universal differential images are
retained. No scalar extension of endpoint forms, logarithmic converse,
torsion identification or simultaneous closure is assumed. -/
noncomputable def actual_unit_quotient_p_torsion_cartier_equiv
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
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p ≃+
      sharedIntrinsicCartierFixedForms k F G E CE := by
  rw [← actual_shared_logarithmic_image_eq_cartier_fixed hfgF htrdegF hfgG htrdegG CE]
  exact actual_unit_quotient_p_torsion_logarithmic_equiv
    hfgF htrdegF hfgG htrdegG hfgE htrdegE hintersection

end Litt3.CartierAndSpin
