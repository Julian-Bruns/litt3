import Theorems.Jacobians.ValuationDivisorClasses
import Mathlib.Tactic

namespace Litt3.Jacobians

@[simp]
theorem principal_divisor_coefficient
    {K Points : Type*} [Field K] (system : ValuationDivisorSystem K Points)
    (f : Additive Kˣ) (point : Points) :
    principalDivisorMap system f point = valuationOrder (system.valuation point) f := rfl

theorem divisor_class_zero_iff_principal
    {K Points : Type*} [Field K] (system : ValuationDivisorSystem K Points)
    (D : Divisor Points) :
    divisorClassMap system D = 0 ↔
      ∃ f : Additive Kˣ, principalDivisorMap system f = D := by
  change (D : DivisorClassGroup system) = 0 ↔ _
  rw [QuotientAddGroup.eq_zero_iff]
  exact AddMonoidHom.mem_range

theorem divisor_class_torsion_iff_principal_multiple
    {K Points : Type*} [Field K] (system : ValuationDivisorSystem K Points)
    (D : Divisor Points) (N : ℕ) :
    N • divisorClassMap system D = 0 ↔
      ∃ f : Additive Kˣ, principalDivisorMap system f = N • D := by
  rw [← map_nsmul]
  exact divisor_class_zero_iff_principal system (N • D)

theorem single_point_divisor_class_torsion
    {K Points : Type*} [Field K] (system : ValuationDivisorSystem K Points)
    (point basepoint : Points) (N : ℕ) :
    N • divisorClassMap system (pointDivisor point - pointDivisor basepoint) = 0 ↔
      ∃ f : Additive Kˣ, principalDivisorMap system f =
        N • (pointDivisor point - pointDivisor basepoint) :=
  divisor_class_torsion_iff_principal_multiple system _ N

theorem single_point_divisor_class_torsion_target :
    Targets.SinglePointDivisorClassTorsion := by
  intro K Points instK system point basepoint N
  exact single_point_divisor_class_torsion system point basepoint N

/-- Torsion killed by a small order is killed by every multiple, without
projecting an effective divisor to its primary components. -/
theorem divisor_class_torsion_of_order_dvd
    {K Points : Type*} [Field K] (system : ValuationDivisorSystem K Points)
    (D : Divisor Points) (small large : ℕ) (hdivides : small ∣ large)
    (hsmall : small • divisorClassMap system D = 0) :
    large • divisorClassMap system D = 0 := by
  obtain ⟨factor, rfl⟩ := hdivides
  rw [mul_nsmul, hsmall, nsmul_zero]

/-- The point divisor is supported exactly at its point. -/
@[simp] theorem point_divisor_at_self
    {Points : Type*} (point : Points) : pointDivisor point point = 1 := by
  classical
  simp [pointDivisor]

theorem point_divisor_away
    {Points : Type*} (point atPoint : Points) (hne : atPoint ≠ point) :
    pointDivisor point atPoint = 0 := by
  classical
  simp [pointDivisor, Ne.symm hne]

@[simp] theorem point_divisor_degree
    {Points : Type*} (point : Points) : divisorDegree (pointDivisor point) = 1 := by
  classical
  simp [divisorDegree, pointDivisor]

theorem point_difference_degree_zero
    {Points : Type*} (point basepoint : Points) :
    divisorDegree (pointDivisor point - pointDivisor basepoint) = 0 := by simp

/-- The proper-curve product formula is the only input here; it is not
part of the definition of a valuation divisor system. -/
theorem principal_divisors_have_degree_zero
    {K Points : Type*} [Field K] (system : ValuationDivisorSystem K Points)
    (hproduct : ∀ f, divisorDegree (principalDivisorMap system f) = 0) :
    principalDivisors system ≤ divisorDegree.ker := by
  intro D hD
  obtain ⟨f, rfl⟩ := AddMonoidHom.mem_range.mp hD
  exact hproduct f

theorem effective_divisor_degree_nonnegative
    {Points : Type*} (D : Divisor Points) (heffective : EffectiveDivisor D) :
    0 ≤ divisorDegree D := by
  classical
  change 0 ≤ ∑ p ∈ D.support, D p
  exact Finset.sum_nonneg fun p _hp => heffective p

theorem effective_degree_zero_divisor_eq_zero
    {Points : Type*} (D : Divisor Points) (heffective : EffectiveDivisor D)
    (hdegree : divisorDegree D = 0) : D = 0 := by
  classical
  change ∑ p ∈ D.support, D p = 0 at hdegree
  have hsupport : ∀ p ∈ D.support, D p = 0 :=
    (Finset.sum_eq_zero_iff_of_nonneg fun p _hp => heffective p).mp hdegree
  ext p
  by_cases hp : p ∈ D.support
  · exact hsupport p hp
  · exact Finsupp.notMem_support_iff.mp hp

end Litt3.Jacobians
