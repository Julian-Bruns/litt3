import Definitions.QuotientGeometry.CompletedLowerRamification
import Solutions.QuotientGeometry.CompletedHomDisplacement
import Solutions.QuotientGeometry.CompletedAutomorphismOrders

namespace Litt3.QuotientGeometry

theorem power_series_algEquiv_parameter_constant_zero
    {k : Type*} [Field k] (e : PowerSeries k ≃ₐ[k] PowerSeries k) :
    PowerSeries.constantCoeff (e PowerSeries.X) = 0 := by
  have hord := power_series_ring_equiv_order_X e.toRingEquiv
  change PowerSeries.order (e PowerSeries.X) = 1 at hord
  have hc := PowerSeries.coeff_of_lt_order (φ := e PowerSeries.X) 0
    (by rw [hord]; norm_num)
  simpa using hc

/-- The condition quantifying over every integral element is exactly the
uniformizer condition, now proved for the literal completed DVR. -/
theorem completed_lower_ramification_uniformizer_iff
    {k : Type*} [Field k] (e : PowerSeries k ≃ₐ[k] PowerSeries k) (n : ℕ) :
    completedLowerRamificationCondition k n e ↔
      ((n + 1 : ℕ) : ℕ∞) ≤ PowerSeries.order (e PowerSeries.X - PowerSeries.X) :=
  power_series_algHom_all_displacement_iff e.toAlgHom
    (power_series_algEquiv_parameter_constant_zero e) (n + 1)

noncomputable def completedLowerRamificationGroup
    (k : Type*) [Field k] (n : ℕ) : Subgroup (PowerSeries k ≃ₐ[k] PowerSeries k) where
  carrier := completedLowerRamificationCondition k n
  one_mem' := by intro f; simp
  mul_mem' := by
    intro e d he hd f
    have hfirst : ((n + 1 : ℕ) : ℕ∞) ≤ PowerSeries.order (e (d f - f)) := by
      change ((n + 1 : ℕ) : ℕ∞) ≤ PowerSeries.order (e.toRingEquiv (d f - f))
      rw [power_series_ring_equiv_order e.toRingEquiv]
      exact hd f
    have hsecond := he f
    have hsum := PowerSeries.min_order_le_order_add (e (d f - f)) (e f - f)
    have hbound := (le_min hfirst hsecond).trans hsum
    simpa only [map_sub, sub_add_sub_cancel, AlgEquiv.mul_apply] using hbound
  inv_mem' := by
    intro e he f
    have hbound := he (e.symm f)
    simp only [AlgEquiv.apply_symm_apply] at hbound
    change ((n + 1 : ℕ) : ℕ∞) ≤ PowerSeries.order (e.symm f - f)
    rw [← neg_sub f (e.symm f), PowerSeries.order_neg]
    exact hbound

theorem completed_lower_ramification_antitone
    {k : Type*} [Field k] {m n : ℕ} (hmn : m ≤ n) :
    completedLowerRamificationGroup k n ≤ completedLowerRamificationGroup k m := by
  intro e he f
  have hcast : ((m + 1 : ℕ) : ℕ∞) ≤ ((n + 1 : ℕ) : ℕ∞) := by
    exact_mod_cast Nat.add_le_add_right hmn 1
  exact hcast.trans (he f)

end Litt3.QuotientGeometry
