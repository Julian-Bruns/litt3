import Solutions.CartierAndSpin.ActualPrimaryUnitTorsion
import Solutions.CartierAndSpin.PrimaryAmbientKernelProfile

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

/-- The literal entire primary quotient vanishes EXACTLY when the
actual restricted shared Cartier operator vanishes. No finiteness
premise on the entire primary subgroup is needed. -/
theorem actual_unit_quotient_primary_vanishes_iff_shared_cartier_zero
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (CE : RationalCartierOperator k E p) :
    AddCommGroup.primaryComponent
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p = ⊥ ↔
      actualSharedRationalCartier hfgF htrdegF hfgG htrdegG CE = 0 := by
  rw [actual_primary_zero_iff_prime_kernel_zero,
    ← AddSubgroup.card_eq_one,
    actual_unit_quotient_prime_torsion_cardinality
      hfgF htrdegF hfgG htrdegG hfgE htrdegE hinter CE]
  by_cases h : actualSharedRationalCartier hfgF htrdegF hfgG htrdegG CE = 0
  · simp only [h, if_pos, true_iff]
  · simp only [h, if_neg, iff_false]
    exact (Fact.out : p.Prime).ne_one

/-- Every finite ACTUAL primary quotient has one height, and its
ambient Q[p^n] cardinality is exactly p^min(height,n), at ALL heights.
The finite-primary premise remains the separate geometric input. -/
theorem actual_unit_quotient_finite_primary_height_profile
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (CE : RationalCartierOperator k E p)
    [Finite (AddCommGroup.primaryComponent
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p)] :
    ∃ height : ℕ,
      Nat.card (AddCommGroup.primaryComponent
        (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p) = p ^ height ∧
      ∀ n : ℕ, Nat.card (powerTorsionSubgroup
        (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) (p ^ n)) =
          p ^ min height n := by
  apply actual_finite_primary_ambient_kernel_profile p
  rw [actual_unit_quotient_prime_torsion_cardinality
    hfgF htrdegF hfgG htrdegG hfgE htrdegE hinter CE]
  split_ifs
  · exact (Fact.out : p.Prime).one_lt.le
  · exact le_refl p

end Litt3.CartierAndSpin
