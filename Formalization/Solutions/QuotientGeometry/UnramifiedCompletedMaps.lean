import Solutions.QuotientGeometry.ParameterCoordinates
import Solutions.QuotientGeometry.ParameterFieldMapUniqueness
import Solutions.QuotientGeometry.CompletedAutomorphismOrders
import Mathlib.RingTheory.Unramified.LocalRing
import Mathlib.RingTheory.RingHom.Unramified

namespace Litt3.QuotientGeometry

theorem completed_map_parameter_order_one_of_maximal_ideal
    {k : Type*} [Field k] (φ : PowerSeries k →ₐ[k] PowerSeries k)
    (hmax : (IsLocalRing.maximalIdeal (PowerSeries k)).map φ.toRingHom =
      IsLocalRing.maximalIdeal (PowerSeries k)) :
    PowerSeries.order (φ PowerSeries.X) = 1 := by
  have hX := (PowerSeries.X_irreducible (R := k)).maximalIdeal_eq
  rw [hX, Ideal.map_span, Set.image_singleton] at hmax
  obtain ⟨u, hu⟩ := Ideal.span_singleton_eq_span_singleton.mp hmax
  have hord := congrArg PowerSeries.order hu
  rw [PowerSeries.order_mul, PowerSeries.order_zero_of_unit u.isUnit, add_zero,
    PowerSeries.order_X] at hord
  exact hord

/-- An actual unramified completed map with its literal maximal-ideal
extension equality is an isomorphism of the whole completed ring and
field. Neither bijectivity nor a field identification is an input. -/
theorem unramified_completed_map_equivalences
    {k : Type*} [Field k] (φ : PowerSeries k →ₐ[k] PowerSeries k)
    (Φ : LaurentSeries k →+* LaurentSeries k)
    (hΦ : ∀ f : PowerSeries k, Φ (f : LaurentSeries k) = (φ f : PowerSeries k))
    (hmax : (IsLocalRing.maximalIdeal (PowerSeries k)).map φ.toRingHom =
      IsLocalRing.maximalIdeal (PowerSeries k)) :
    ∃ (e : PowerSeries k ≃ₐ[k] PowerSeries k) (E : LaurentSeries k ≃ₐ[k] LaurentSeries k),
      (∀ f : PowerSeries k, e f = φ f) ∧ E.toRingHom = Φ ∧
      (∀ f : PowerSeries k, E (f : LaurentSeries k) = (e f : PowerSeries k)) := by
  have hord := completed_map_parameter_order_one_of_maximal_ideal φ hmax
  have hc := PowerSeries.order_eq_nat.mp hord
  have hb0 : PowerSeries.constantCoeff (φ PowerSeries.X) = 0 := by
    simpa using hc.2 0 (by omega)
  obtain ⟨e, he⟩ := parameter_power_series_automorphism (φ PowerSeries.X) hb0 hc.1
  obtain ⟨E, hE⟩ := parameter_laurent_automorphism (φ PowerSeries.X) hb0 hc.1
  have hφ := power_series_algHom_eq_substitution (φ PowerSeries.X) hb0 φ rfl
  have hφf : ∀ f : PowerSeries k, φ f = PowerSeries.subst (φ PowerSeries.X) f := by
    intro f
    simpa only [PowerSeries.coe_substAlgHom] using AlgHom.congr_fun hφ f
  have heφ : ∀ f : PowerSeries k, e f = φ f := by
    intro f
    exact (he f).trans (hφf f).symm
  have hEL : E.toRingHom = Φ := by
    apply IsFractionRing.ringHom_ext (A := PowerSeries k)
    intro f
    change E (f : LaurentSeries k) = Φ (f : LaurentSeries k)
    rw [hE, hΦ]
    exact congrArg (fun g : PowerSeries k => (g : LaurentSeries k)) (hφf f).symm
  refine ⟨e, E, heφ, hEL, ?_⟩
  intro f
  rw [hE, he]

/-- The maximal-ideal condition used above follows from the genuine
local formally unramified algebra structure, as in the standard local
unramified criterion. -/
theorem formally_unramified_completed_map_maximal_ideal
    {k : Type*} [Field k] (φ : PowerSeries k →ₐ[k] PowerSeries k)
    (hunram : φ.toRingHom.FormallyUnramified)
    (hfinite : φ.toRingHom.EssFiniteType) (hlocal : IsLocalHom φ.toRingHom) :
    (IsLocalRing.maximalIdeal (PowerSeries k)).map φ.toRingHom =
      IsLocalRing.maximalIdeal (PowerSeries k) := by
  letI : Algebra (PowerSeries k) (PowerSeries k) := φ.toRingHom.toAlgebra
  letI : Algebra.FormallyUnramified (PowerSeries k) (PowerSeries k) := hunram
  letI : Algebra.EssFiniteType (PowerSeries k) (PowerSeries k) := hfinite
  letI : IsLocalHom (algebraMap (PowerSeries k) (PowerSeries k)) := hlocal
  exact Algebra.FormallyUnramified.map_maximalIdeal

end Litt3.QuotientGeometry
