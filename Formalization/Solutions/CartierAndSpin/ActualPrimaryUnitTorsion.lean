import Solutions.CartierAndSpin.ActualUnitTorsionSize
import Solutions.CartierAndSpin.FinitePrimaryCyclicity
import Solutions.CartierAndSpin.PrimePowerKernelVanishing

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

theorem actual_unit_quotient_prime_torsion_cardinality
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (CE : RationalCartierOperator k E p) :
    Nat.card (powerTorsionSubgroup
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p) =
      if actualSharedRationalCartier hfgF htrdegF hfgG htrdegG CE = 0 then 1 else p := by
  letI : CharP E p := charP_of_injective_algebraMap (algebraMap k E).injective p
  rw [Nat.card_congr (actual_unit_quotient_p_torsion_cartier_linear_equiv
    hfgF htrdegF hfgG htrdegG hfgE htrdegE hinter CE).toEquiv]
  exact actual_shared_cartier_fixed_cardinality hfgF htrdegF hfgG htrdegG hinter CE

/-- Whenever the ACTUAL primary subgroup is finite, it is cyclic.
Finiteness is explicit; no supplied cyclic decomposition, Picard
classification or replacement of the original quotient is used. -/
theorem actual_unit_quotient_finite_primary_torsion_cyclic
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
    IsAddCyclic (AddCommGroup.primaryComponent
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p) := by
  obtain ⟨hfinite, _, _, _⟩ := actual_unit_quotient_prime_torsion_small
    hfgF htrdegF hfgG htrdegG hfgE htrdegE hinter CE
  letI := hfinite
  apply actual_primary_subgroup_is_cyclic p
  rw [actual_unit_quotient_prime_torsion_cardinality
    hfgF htrdegF hfgG htrdegG hfgE htrdegE hinter CE]
  split_ifs
  · exact (Fact.out : p.Prime).one_lt.le
  · exact le_refl p

/-- Vanishing of the ORIGINAL shared rational space implies actual
Q[p]=0, through the constructed two-leg quotient boundary. -/
theorem actual_unit_quotient_prime_kernel_zero_of_shared_zero
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (CE : RationalCartierOperator k E p)
    (hz : sharedRationalDifferentialSubspace k F G E = ⊥) :
    powerTorsionSubgroup
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p = ⊥ := by
  let e := actual_unit_quotient_p_torsion_cartier_linear_equiv
    hfgF htrdegF hfgG htrdegG hfgE htrdegE hinter CE
  have hfixedzero : ∀ omega : sharedIntrinsicCartierFixedForms k F G E CE, omega = 0 := by
    intro omega
    apply Subtype.ext
    have hm : omega.val ∈ sharedRationalDifferentialSubspace k F G E := omega.property.1
    rwa [hz] at hm
  apply le_antisymm
  · intro q hq
    have hzero : (⟨q, hq⟩ : powerTorsionSubgroup
        (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p) = 0 := by
      apply e.injective
      exact (hfixedzero _).trans e.map_zero.symm
    exact congrArg Subtype.val hzero
  · exact bot_le

/-- No shared original rational form implies no primary torsion of
ANY height, with no finiteness premise on that actual primary subgroup. -/
theorem actual_unit_quotient_primary_torsion_zero_of_shared_zero
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (CE : RationalCartierOperator k E p)
    (hz : sharedRationalDifferentialSubspace k F G E = ⊥) :
    AddCommGroup.primaryComponent
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p = ⊥ :=
  actual_primary_subgroup_vanishes_of_prime_kernel_zero p
    (actual_unit_quotient_prime_kernel_zero_of_shared_zero
      hfgF htrdegF hfgG htrdegG hfgE htrdegE hinter CE hz)

end Litt3.CartierAndSpin
