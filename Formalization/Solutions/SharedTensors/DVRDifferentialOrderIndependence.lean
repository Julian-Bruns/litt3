import Solutions.SharedTensors.DVRRationalDifferentialOrders
import Solutions.SharedTensors.FormallyEtaleDifferentialFrameChanges

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.CartierAndSpin

variable {k R F : Type*} [CommRing k] [CommRing R] [IsDomain R]
  [IsDiscreteValuationRing R] [Field F] [Algebra k R] [Algebra k F]
  [Algebra R F] [IsFractionRing R F] [IsScalarTower k R F]

local instance differentialFrameFractionFormallyEtale : Algebra.FormallyEtale R F :=
  Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors R)

/-- Original ring units have normalized valuation ONE in the actual
fraction field. Both integral bounds and the inverse identity are derived. -/
theorem actual_dvr_integral_unit_valuation_one (u : Rˣ) :
    (discreteValuationPlace R).valuation F (algebraMap R F (u : R)) = 1 := by
  let v := (discreteValuationPlace R).valuation F
  have hv := dvr_height_one_valuation_integers (R := R) (K := F)
  have hle : v (algebraMap R F (u : R)) ≤ 1 := hv.map_le_one _
  have hinv : v (algebraMap R F ((u⁻¹ : Rˣ) : R)) ≤ 1 := hv.map_le_one _
  have hmul : v (algebraMap R F (u : R)) *
      v (algebraMap R F ((u⁻¹ : Rˣ) : R)) = 1 := by
    rw [← map_mul, ← map_mul, Units.mul_inv, map_one, map_one]
  apply le_antisymm hle
  calc
    1 = v (algebraMap R F (u : R)) *
        v (algebraMap R F ((u⁻¹ : Rˣ) : R)) := hmul.symm
    _ ≤ v (algebraMap R F (u : R)) * 1 := mul_le_mul_right hinv _
    _ = v (algebraMap R F (u : R)) := mul_one _

/-- The normalized order of the ORIGINAL rational differential is
independent of EVERY original integral local frame. Arbitrary field
coordinates are deliberately not asserted to preserve order. -/
theorem actual_dvr_differential_order_independent
    (e e' : KaehlerDifferential k R ≃ₗ[R] R)
    (omega : KaehlerDifferential k F) (h : omega ≠ 0) :
    actualDVRDifferentialOrder e' omega h = actualDVRDifferentialOrder e omega h := by
  let u := integralLineCoordinateChange e e'
  let a : Fˣ := Units.map (algebraMap R F).toMonoidHom u
  let eF := formallyEtaleDifferentialCoordinate (S := F) e
  let eF' := formallyEtaleDifferentialCoordinate (S := F) e'
  have hu : nonzeroLineCoordinateUnit eF' omega h = a * nonzeroLineCoordinateUnit eF omega h := by
    apply Units.ext
    exact actual_formally_etale_differential_coordinate_change e e' omega
  have ha : valuationOrder ((discreteValuationPlace R).valuation F) (Additive.ofMul a) = 0 := by
    have hv := actual_dvr_integral_unit_valuation_one (F := F) u
    have ho := valuation_order_of_value_exp ((discreteValuationPlace R).valuation F)
      (Additive.ofMul a) (0 : ℤ) (by simpa only [WithZero.exp_zero] using hv)
    simpa only [neg_zero] using ho
  change valuationOrder ((discreteValuationPlace R).valuation F)
      (Additive.ofMul (nonzeroLineCoordinateUnit eF' omega h)) = _
  rw [hu]
  change valuationOrder ((discreteValuationPlace R).valuation F)
      (Additive.ofMul a + Additive.ofMul (nonzeroLineCoordinateUnit eF omega h)) = _
  rw [map_add, ha, zero_add]
  rfl

end Litt3.SharedTensors
