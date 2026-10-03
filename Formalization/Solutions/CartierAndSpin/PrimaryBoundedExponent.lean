import Solutions.CartierAndSpin.PrimaryAmbientKernelProfile
import Solutions.CartierAndSpin.HigherPrimeKernelCyclicity

namespace Litt3.CartierAndSpin

variable {A : Type*} [AddCommGroup A]

/-- An actual uniform annihilation height identifies the ENTIRE
primary component with the true ambient multiplication kernel. -/
theorem actual_primary_eq_power_kernel_of_bound
    (p height : ℕ) [Fact p.Prime]
    (hbound : ∀ a : AddCommGroup.primaryComponent A p, p ^ height • a = 0) :
    AddCommGroup.primaryComponent A p = powerTorsionSubgroup A (p ^ height) := by
  apply le_antisymm
  · intro a ha
    exact congrArg Subtype.val (hbound ⟨a, ha⟩)
  · intro a ha
    exact exists_addOrderOf_eq_prime_pow_iff.mpr ⟨height, ha⟩

/-- With finite FIRST kernel, finiteness of the literal primary
component is equivalent to one uniform actual annihilation height.
This isolates the precise missing geometric boundedness statement. -/
theorem actual_primary_finite_iff_bounded_power
    (p : ℕ) [Fact p.Prime] [Finite (powerTorsionSubgroup A p)] :
    Finite (AddCommGroup.primaryComponent A p) ↔
      ∃ height : ℕ, ∀ a : AddCommGroup.primaryComponent A p,
        p ^ height • a = 0 := by
  refine ⟨fun hfinite => ?_, fun ⟨height, hbound⟩ => ?_⟩
  · letI := hfinite
    obtain ⟨a, ha⟩ := AddMonoid.exists_addOrderOf_eq_exponent
      (AddMonoid.ExponentExists.of_finite (G := AddCommGroup.primaryComponent A p))
    obtain ⟨height, hheight⟩ := a.property
    have horder : addOrderOf a = p ^ height := by
      simpa only [AddSubgroup.addOrderOf_coe] using hheight
    have hexponent : AddMonoid.exponent (AddCommGroup.primaryComponent A p) =
        p ^ height := ha.symm.trans horder
    refine ⟨height, fun b => ?_⟩
    apply addOrderOf_dvd_iff_nsmul_eq_zero.mp
    rw [← hexponent]
    exact AddMonoid.addOrder_dvd_exponent b
  · rw [actual_primary_eq_power_kernel_of_bound p height hbound]
    exact actual_power_kernel_finite p height

/-- A concrete actual annihilation height gives finite cyclic primary
torsion and the literal cardinality bound p^height. No ambient-group
finiteness or primary decomposition is assumed. -/
theorem actual_bounded_primary_finite_cyclic
    (p height : ℕ) [Fact p.Prime] [Finite (powerTorsionSubgroup A p)]
    (hp : Nat.card (powerTorsionSubgroup A p) ≤ p)
    (hbound : ∀ a : AddCommGroup.primaryComponent A p, p ^ height • a = 0) :
    Finite (AddCommGroup.primaryComponent A p) ∧
      IsAddCyclic (AddCommGroup.primaryComponent A p) ∧
      Nat.card (AddCommGroup.primaryComponent A p) ≤ p ^ height := by
  rw [actual_primary_eq_power_kernel_of_bound p height hbound]
  exact actual_higher_prime_kernel_finite_cyclic p hp height

end Litt3.CartierAndSpin
