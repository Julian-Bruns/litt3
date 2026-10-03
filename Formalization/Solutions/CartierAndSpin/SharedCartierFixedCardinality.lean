import Solutions.CartierAndSpin.SharedRationalCartier
import Solutions.CartierAndSpin.ActualSharedDifferentialRank
import Solutions.SharedTensors.PrimeCartierFixedLine

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors
open scoped Classical

variable {k F G E : Type*} [Field k] [IsAlgClosed k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]
  [Algebra.IsSeparable F E] [Algebra.IsSeparable G E]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP E p]

/-- The fixed kernel on the actual shared k-space is exactly the
literal shared Cartier-fixed subgroup of the original source module. -/
noncomputable def actualSharedCartierFixedEquiv
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (CE : RationalCartierOperator k E p) :
    (actualSharedRationalCartier hfgF htrdegF hfgG htrdegG CE -
      AddMonoidHom.id ↥(sharedRationalDifferentialSubspace k F G E)).ker ≃+
        sharedIntrinsicCartierFixedForms k F G E CE where
  toFun omega := ⟨omega.val.val, by
    refine ⟨omega.val.property, ?_⟩
    change omega.val.val ∈ intrinsicCartierFixedSubgroup CE
    rw [mem_intrinsicCartierFixedSubgroup]
    exact congrArg Subtype.val (sub_eq_zero.mp omega.property)⟩
  invFun omega := ⟨⟨omega.val, omega.property.1⟩, by
    apply sub_eq_zero.mpr
    apply Subtype.ext
    exact (mem_intrinsicCartierFixedSubgroup CE omega.val).mp omega.property.2⟩
  left_inv omega := rfl
  right_inv omega := rfl
  map_add' omega eta := rfl

/-- In the ORIGINAL two-field configuration the shared fixed forms
have exactly one or p elements. The finite/shared-rank facts are derived
from actual one-variable endpoints and their literal constant
intersection. Zero source or endpoint forms are retained. -/
theorem actual_shared_cartier_fixed_cardinality
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (CE : RationalCartierOperator k E p) :
    Nat.card (sharedIntrinsicCartierFixedForms k F G E CE) =
      if actualSharedRationalCartier hfgF htrdegF hfgG htrdegG CE = 0 then 1 else p := by
  obtain ⟨hfinite, hdim⟩ := actual_one_variable_shared_space_finite_and_small
    hfgF htrdegF hfgG htrdegG hinter
  letI := hfinite
  rw [← Nat.card_congr (actualSharedCartierFixedEquiv hfgF htrdegF hfgG htrdegG CE).toEquiv]
  exact actual_rank_le_one_cartier_fixed_card hdim
    (actualSharedRationalCartier hfgF htrdegF hfgG htrdegG CE)
    (actual_shared_rational_cartier_inverse_power_semilinear hfgF htrdegF hfgG htrdegG CE)

theorem actual_shared_cartier_fixed_cardinality_one_or_prime
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (CE : RationalCartierOperator k E p) :
    Nat.card (sharedIntrinsicCartierFixedForms k F G E CE) = 1 ∨
      Nat.card (sharedIntrinsicCartierFixedForms k F G E CE) = p := by
  rw [actual_shared_cartier_fixed_cardinality hfgF htrdegF hfgG htrdegG hinter CE]
  split_ifs <;> simp

end Litt3.CartierAndSpin
