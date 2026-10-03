import Solutions.CartierAndSpin.NoClumpPrimaryTorsionVanishing

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [IsProper sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY] [IsProper sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)
  {p : ℕ} [Fact p.Prime] [CharP k p]

include sY hbase

/-- ALL characteristic-power roots in the actual original unit
quotient are unique in the no-clump branch with ONE endpoint's genuine
H0 rank at least two. Root existence is not presumed. -/
theorem actual_no_clump_unit_quotient_primary_roots_unique
    (hno : IsEmpty s.fiberClump)
    (hdimension : 2 ≤ Module.rank k (schemeDifferentialGlobalSections sX))
    (n : ℕ) (q r : s.unitRelationQuotient)
    (h : (p ^ n) • q = (p ^ n) • r) : q = r := by
  have hmem : q - r ∈ AddCommGroup.primaryComponent s.unitRelationQuotient p :=
    exists_addOrderOf_eq_prime_pow_iff.mpr ⟨n, by
      change (p ^ n) • (q - r) = 0
      exact (nsmul_sub q r (p ^ n)).trans (sub_eq_zero.mpr h)⟩
  rw [actual_no_clump_entire_unit_quotient_primary_zero s sX sY hbase hno hdimension] at hmem
  exact sub_eq_zero.mp hmem

end Litt3.CartierAndSpin
