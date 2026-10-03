import Solutions.CartierAndSpin.SmoothEtaleSpanH0UnitTorsion
import Solutions.CartierAndSpin.PrimePrimaryVanishingEquivalence

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k] [PerfectField k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [IsProper sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY] [IsProper sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)
  {p : ℕ} [Fact p.Prime] [CharP k p]

/-- Actual p-kernel vanishing is EXACTLY zero Cartier on the literal
shared ORIGINAL H0 intersection. All operators and identifications are
constructed. Literal clump uniqueness and ONE genuine H0 rank≥2 are
the explicit geometric regularity hypotheses. -/
theorem actual_unit_prime_kernel_zero_iff_shared_H0_cartier_zero
    (hinter : EndpointFieldIntersectionConstants
      (genericBaseFieldHom sX) (genericBaseFieldHom sY)
      (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right))
    (hunique : ∀ c d : s.fiberClump, c.left = d.left)
    (hdimension : 2 ≤ Module.rank k (schemeDifferentialGlobalSections sX)) :
    powerTorsionSubgroup s.unitRelationQuotient p = ⊥ ↔
      actualSharedGlobalCartier (p := p) s sX sY hbase = 0 := by
  classical
  let e := actual_at_most_one_clump_unit_torsion_shared_H0_equiv
    s sX sY hbase hinter hunique hdimension
  constructor
  · intro hz
    have hqzero : ∀ q : powerTorsionSubgroup s.unitRelationQuotient p, q = 0 := by
      intro q
      apply Subtype.ext
      have hm : (q.val : s.unitRelationQuotient) ∈
          (⊥ : AddSubgroup s.unitRelationQuotient) := hz.le q.property
      simpa only [AddSubgroup.mem_bot] using hm
    have hfixedzero : ∀ a : actualSharedGlobalCartierFixed (p := p) s sX sY hbase, a = 0 := by
      intro a
      apply e.symm.injective
      exact (hqzero _).trans e.symm.map_zero.symm
    letI : Subsingleton (actualSharedGlobalCartierFixed (p := p) s sX sY hbase) :=
      ⟨fun a b => (hfixedzero a).trans (hfixedzero b).symm⟩
    have hcardone : Nat.card (actualSharedGlobalCartierFixed (p := p) s sX sY hbase) = 1 := by
      simp
    by_contra hne
    have hcard := actual_shared_H0_cartier_fixed_cardinality s sX sY hbase hinter
    rw [if_neg hne] at hcard
    exact (Fact.out : p.Prime).ne_one (hcard.symm.trans hcardone)
  · intro hC
    have hfixedzero : ∀ a : actualSharedGlobalCartierFixed (p := p) s sX sY hbase, a = 0 := by
      intro a
      apply Subtype.ext
      have ha : actualSharedGlobalCartier (p := p) s sX sY hbase a.val = a.val :=
        sub_eq_zero.mp a.property
      rw [hC] at ha
      exact ha.symm
    apply le_antisymm
    · intro q hq
      have hzero : (⟨q, hq⟩ : powerTorsionSubgroup s.unitRelationQuotient p) = 0 := by
        apply e.injective
        exact (hfixedzero _).trans e.map_zero.symm
      exact congrArg Subtype.val hzero
    · exact bot_le

/-- The ENTIRE actual characteristic-primary unit quotient vanishes
iff Cartier is zero on true shared H0. No finiteness, bounded height,
cyclicity, supplied operator or group-scheme classification is assumed. -/
theorem actual_entire_unit_primary_zero_iff_shared_H0_cartier_zero
    (hinter : EndpointFieldIntersectionConstants
      (genericBaseFieldHom sX) (genericBaseFieldHom sY)
      (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right))
    (hunique : ∀ c d : s.fiberClump, c.left = d.left)
    (hdimension : 2 ≤ Module.rank k (schemeDifferentialGlobalSections sX)) :
    AddCommGroup.primaryComponent s.unitRelationQuotient p = ⊥ ↔
      actualSharedGlobalCartier (p := p) s sX sY hbase = 0 :=
  (actual_primary_zero_iff_prime_kernel_zero p).trans
    (actual_unit_prime_kernel_zero_iff_shared_H0_cartier_zero
      s sX sY hbase hinter hunique hdimension)

end Litt3.CartierAndSpin
