import Solutions.CartierAndSpin.SharedCartierFixedCardinality
import Solutions.CartierAndSpin.ActualUnitTorsionCartierLinear
import Solutions.CartierAndSpin.PrimeCardinalityDimension

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k F G E : Type*} [Field k] [IsAlgClosed k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]
  [Algebra.IsSeparable F E] [Algebra.IsSeparable G E]
variable {p : ℕ} [Fact p.Prime] [CharP k p]

/-- The ORIGINAL quotient p-torsion is genuinely finite, cyclic and
of prime-field dimension at most one. All shared rank, exact
logarithmic kernels and quotient-boundary bijectivity are derived. -/
theorem actual_unit_quotient_prime_torsion_small
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (CE : RationalCartierOperator k E p) :
    Finite (powerTorsionSubgroup
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p) ∧
    Module.Finite (ZMod p) (powerTorsionSubgroup
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p) ∧
    Module.finrank (ZMod p) (powerTorsionSubgroup
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p) ≤ 1 ∧
    IsAddCyclic (powerTorsionSubgroup
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p) := by
  letI : CharP E p := charP_of_injective_algebraMap (algebraMap k E).injective p
  apply actual_prime_module_small_cardinality
  rw [Nat.card_congr (actual_unit_quotient_p_torsion_cartier_linear_equiv
    hfgF htrdegF hfgG htrdegG hfgE htrdegE hinter CE).toEquiv]
  exact actual_shared_cartier_fixed_cardinality_one_or_prime hfgF htrdegF hfgG htrdegG hinter CE

/-- The literal shared Cartier-fixed group is genuinely finite and
cyclic of F_p-dimension at most one, in the original source module. -/
theorem actual_shared_cartier_fixed_prime_module_small
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (CE : RationalCartierOperator k E p) :
    Finite (sharedIntrinsicCartierFixedForms k F G E CE) ∧
    Module.Finite (ZMod p) (sharedIntrinsicCartierFixedForms k F G E CE) ∧
    Module.finrank (ZMod p) (sharedIntrinsicCartierFixedForms k F G E CE) ≤ 1 ∧
    IsAddCyclic (sharedIntrinsicCartierFixedForms k F G E CE) := by
  letI : CharP E p := charP_of_injective_algebraMap (algebraMap k E).injective p
  exact actual_prime_module_small_cardinality
    (actual_shared_cartier_fixed_cardinality_one_or_prime hfgF htrdegF hfgG htrdegG hinter CE)

end Litt3.CartierAndSpin
