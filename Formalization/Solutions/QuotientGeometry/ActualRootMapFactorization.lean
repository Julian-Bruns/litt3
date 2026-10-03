import Solutions.QuotientGeometry.PowerParameterMaps
import Solutions.QuotientGeometry.LaurentParameterRecovery
import Solutions.QuotientGeometry.LaurentUnitOrders

namespace Litt3.QuotientGeometry

theorem completed_map_factor_of_actual_root_maps
    {k : Type*} [Field k] (n h : ℕ) (hn : 0 < n) (hh : 0 < h)
    (φβ φψ : PowerSeries k →ₐ[k] PowerSeries k)
    (Ψβ Ψψ : LaurentSeries k →+* LaurentSeries k)
    (hΨβ : ∀ r : PowerSeries k, Ψβ (r : LaurentSeries k) = (φβ r : PowerSeries k))
    (hΨψ : ∀ r : PowerSeries k, Ψψ (r : LaurentSeries k) = (φψ r : PowerSeries k))
    (ψ : LaurentSeries k) (hpoleψ : Ψψ (HahnSeries.single (-1) 1) = ψ)
    (hroot : ψ ^ h = Ψβ (HahnSeries.single (-1) 1)) (hψorder : ψ.order = -(n : ℤ)) :
    Ψβ = Ψψ.comp (powerLaurentMap h hh) := by
  obtain ⟨φη, hη, _⟩ := power_parameter_power_series_compatibility (k := k) h hh
  have hnegative : (Ψβ (HahnSeries.single (-1) 1)).order < 0 := by
    rw [← hroot, HahnSeries.order_pow, hψorder]
    simp only [nsmul_eq_mul]
    have hn' : (0 : ℤ) < n := by exact_mod_cast hn
    have hh' : (0 : ℤ) < h := by exact_mod_cast hh
    nlinarith
  have hcomp : ∀ r : PowerSeries k,
      (Ψψ.comp (powerLaurentMap h hh)) (r : LaurentSeries k) = ((φψ.comp φη) r : PowerSeries k) := by
    intro r
    change Ψψ (powerLaurentMap h hh (r : LaurentSeries k)) = (φψ (φη r) : PowerSeries k)
    rw [hη, hΨψ]
  apply laurent_field_maps_eq_of_pole_image φβ (φψ.comp φη) Ψβ
    (Ψψ.comp (powerLaurentMap h hh)) hΨβ hcomp
    (completed_map_parameter_zero_constant φβ Ψβ hΨβ hnegative)
  change Ψβ (HahnSeries.single (-1) 1) = Ψψ (powerLaurentMap h hh (HahnSeries.single (-1) 1))
  rw [power_parameter_pole_image, map_pow, hpoleψ, hroot]

end Litt3.QuotientGeometry
