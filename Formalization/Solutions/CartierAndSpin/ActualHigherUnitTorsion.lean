import Solutions.CartierAndSpin.ActualPrimaryUnitTorsion
import Solutions.CartierAndSpin.HigherPrimeKernelCyclicity

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors
open scoped Classical

variable {k F G E : Type*} [Field k] [IsAlgClosed k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]
  [Algebra.IsSeparable F E] [Algebra.IsSeparable G E]
variable {p : ℕ} [Fact p.Prime] [CharP k p]

/-- Every actual Q[p^n] is finite and cyclic of cardinality at most
p^n. The original quotient may be infinite. Intrinsic Cartier, the
shared rank, literal Q[p] finiteness and all higher-kernel extensions
are constructed from the actual field hypotheses, not supplied. -/
theorem actual_unit_quotient_all_primary_heights_finite_cyclic
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E)) (n : ℕ) :
    Finite (powerTorsionSubgroup
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) (p ^ n)) ∧
    IsAddCyclic (powerTorsionSubgroup
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) (p ^ n)) ∧
    Nat.card (powerTorsionSubgroup
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) (p ^ n)) ≤ p ^ n := by
  letI : CharP E p := charP_of_injective_algebraMap (algebraMap k E).injective p
  let CE := oneVariableRationalCartier (p := p) hfgE htrdegE
  obtain ⟨hfinite, _, _, _⟩ := actual_unit_quotient_prime_torsion_small
    hfgF htrdegF hfgG htrdegG hfgE htrdegE hinter CE
  letI := hfinite
  apply actual_higher_prime_kernel_finite_cyclic p _ n
  rw [actual_unit_quotient_prime_torsion_cardinality
    hfgF htrdegF hfgG htrdegG hfgE htrdegE hinter CE]
  split_ifs
  · exact (Fact.out : p.Prime).one_lt.le
  · exact le_refl p

/-- Vanishing of the literal shared rational space eliminates the
ENTIRE actual primary quotient subgroup. No operator, primitive,
primary cardinality or primary finiteness is an input. -/
theorem actual_unit_quotient_all_primary_torsion_zero
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (hz : sharedRationalDifferentialSubspace k F G E = ⊥) :
    AddCommGroup.primaryComponent
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p = ⊥ := by
  letI : CharP E p := charP_of_injective_algebraMap (algebraMap k E).injective p
  let CE := oneVariableRationalCartier (p := p) hfgE htrdegE
  exact actual_unit_quotient_primary_torsion_zero_of_shared_zero
    hfgF htrdegF hfgG htrdegG hfgE htrdegE hinter CE hz

end Litt3.CartierAndSpin
