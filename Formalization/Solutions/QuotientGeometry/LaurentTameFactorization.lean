import Solutions.QuotientGeometry.LaurentTameRoots
import Solutions.QuotientGeometry.LaurentPoleParameters
import Solutions.QuotientGeometry.LaurentParameterRecovery

namespace Litt3.QuotientGeometry

/-- Constructs a genuine prime-to-characteristic intermediate
completed field and factors the supplied original Laurent embedding
through its literal h-th-power downstairs map. -/
theorem laurent_completed_map_tame_factorization
    {k : Type*} [Field k] [IsAlgClosed k]
    (n h : ℕ) (hn : 0 < n) (hh : 0 < h) (hchar : (h : k) ≠ 0)
    (φ : PowerSeries k →ₐ[k] PowerSeries k)
    (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (horder : (Ψ (HahnSeries.single (-1) 1)).order = -((n * h : ℕ) : ℤ)) :
    ∃ (ψ : LaurentSeries k)
      (φψ φη : PowerSeries k →ₐ[k] PowerSeries k)
      (Ψψ η : LaurentSeries k →+* LaurentSeries k),
      ψ ^ h = Ψ (HahnSeries.single (-1) 1) ∧ ψ.order = -(n : ℤ) ∧
      Ψψ (HahnSeries.single (-1) 1) = ψ ∧
      η (HahnSeries.single (-1) 1) = (HahnSeries.single (-1) 1) ^ h ∧
      (∀ r : PowerSeries k, Ψψ (r : LaurentSeries k) = (φψ r : PowerSeries k)) ∧
      (∀ r : PowerSeries k, η (r : LaurentSeries k) = (φη r : PowerSeries k)) ∧
      PowerSeries.constantCoeff (φψ PowerSeries.X) = 0 ∧
      PowerSeries.constantCoeff (φη PowerSeries.X) = 0 ∧
      Ψ = Ψψ.comp η := by
  have hnegative : (Ψ (HahnSeries.single (-1) 1)).order < 0 := by
    rw [horder]
    have hnh := Nat.mul_pos hn hh
    omega
  have hβ : Ψ (HahnSeries.single (-1) 1) ≠ 0 := by
    intro hz
    simp only [hz, HahnSeries.order_zero] at hnegative
    omega
  obtain ⟨ψ, hroot, hψorder⟩ := laurent_prime_to_characteristic_root h hh hchar
    (Ψ (HahnSeries.single (-1) 1)) hβ (-(n : ℤ)) (by rw [horder]; push_cast; ring)
  obtain ⟨φψ, Ψψ, hΨψ, hzeroψ, hpoleψ⟩ := laurent_pole_parameter_maps n hn ψ hψorder
  have hηorder : ((HahnSeries.single (-1) (1 : k) : LaurentSeries k) ^ h).order = -(h : ℤ) := by
    rw [HahnSeries.order_pow, HahnSeries.order_single one_ne_zero]
    simp
  obtain ⟨φη, η, hη, hzeroη, hpoleη⟩ :=
    laurent_pole_parameter_maps h hh ((HahnSeries.single (-1) 1 : LaurentSeries k) ^ h) hηorder
  refine ⟨ψ, φψ, φη, Ψψ, η, hroot, hψorder, hpoleψ, hpoleη, hΨψ, hη,
    hzeroψ, hzeroη, ?_⟩
  have hcomp : ∀ r : PowerSeries k,
      (Ψψ.comp η) (r : LaurentSeries k) = ((φψ.comp φη) r : PowerSeries k) := by
    intro r
    change Ψψ (η (r : LaurentSeries k)) = (φψ (φη r) : PowerSeries k)
    rw [hη, hΨψ]
  apply laurent_field_maps_eq_of_pole_image φ (φψ.comp φη) Ψ (Ψψ.comp η)
    hΨ hcomp (completed_map_parameter_zero_constant φ Ψ hΨ hnegative)
  change Ψ (HahnSeries.single (-1) 1) = Ψψ (η (HahnSeries.single (-1) 1))
  rw [hpoleη, map_pow, hpoleψ, hroot]

end Litt3.QuotientGeometry
