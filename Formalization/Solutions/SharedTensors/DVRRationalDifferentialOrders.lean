import Solutions.SharedTensors.RationalLineOrders
import Solutions.CartierAndSpin.DVRDifferentialZeroValuation

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.CartierAndSpin

variable {k R F : Type*} [CommRing k] [CommRing R] [IsDomain R]
  [IsDiscreteValuationRing R] [Field F] [Algebra k R] [Algebra k F]
  [Algebra R F] [IsFractionRing R F] [IsScalarTower k R F]

local instance differentialOrderFractionFormallyEtale : Algebra.FormallyEtale R F :=
  Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors R)

/-- The order of the ORIGINAL rational universal differential in an
original integral local frame. No completion or new field is introduced. -/
noncomputable def actualDVRDifferentialOrder
    (e : KaehlerDifferential k R ≃ₗ[R] R)
    (omega : KaehlerDifferential k F) (h : omega ≠ 0) : ℤ :=
  rationalLineOrder ((discreteValuationPlace R).valuation F)
    (formallyEtaleDifferentialCoordinate (S := F) e) omega h

/-- Positive order detects the genuine ORIGINAL residue-fiber zero m·Ω. -/
theorem actual_dvr_positive_differential_order_iff_zero
    (e : KaehlerDifferential k R ≃ₗ[R] R)
    (omega : KaehlerDifferential k F) (h : omega ≠ 0) :
    0 < actualDVRDifferentialOrder e omega h ↔
      differentialZeroLattice (R := R) omega := by
  unfold actualDVRDifferentialOrder
  rw [rational_line_positive_order_iff]
  exact (actual_dvr_differential_zero_iff_valuation_lt_one e omega).symm

/-- Nonnegative order is exactly membership in the ENTIRE original
universal differential module image. Regularity is a conclusion. -/
theorem actual_dvr_nonnegative_differential_order_iff_regular
    (e : KaehlerDifferential k R ≃ₗ[R] R)
    (omega : KaehlerDifferential k F) (h : omega ≠ 0) :
    0 ≤ actualDVRDifferentialOrder e omega h ↔
      ∃ omegaR : KaehlerDifferential k R,
        KaehlerDifferential.map k k R F omegaR = omega := by
  unfold actualDVRDifferentialOrder
  rw [rational_line_nonnegative_order_iff,
    ← actual_dvr_fraction_image_iff_valuation_le_one]
  exact (formally_etale_differential_image_iff_coordinate e omega).symm

/-- Negative order detects failure of the ORIGINAL stalk-image condition. -/
theorem actual_dvr_negative_differential_order_iff_pole
    (e : KaehlerDifferential k R ≃ₗ[R] R)
    (omega : KaehlerDifferential k F) (h : omega ≠ 0) :
    actualDVRDifferentialOrder e omega h < 0 ↔
      ¬ ∃ omegaR : KaehlerDifferential k R,
        KaehlerDifferential.map k k R F omegaR = omega := by
  rw [← actual_dvr_nonnegative_differential_order_iff_regular e omega h]
  omega

end Litt3.SharedTensors
