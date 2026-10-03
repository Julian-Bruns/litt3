import Solutions.CartierAndSpin.DVRDifferentialZeroValuation

namespace Litt3.CartierAndSpin

open Litt3.Jacobians

variable {k R F : Type*} [CommRing k] [CommRing R] [IsDomain R]
  [IsDiscreteValuationRing R] [Field F] [Algebra k R] [Algebra k F]
  [Algebra R F] [IsFractionRing R F] [IsScalarTower k R F]

/-- Dividing a true regular form by ANY nonzero rational form without
an original zero gives an ORIGINAL regular coefficient, including when
the denominator form has a pole. The actual DVR image criterion and
true m·Ω zero criterion prove this; denominator regularity is not assumed. -/
theorem actual_regular_differential_ratio_of_rational_no_zero
    (e : KaehlerDifferential k R ≃ₗ[R] R)
    (omega nu : KaehlerDifferential k F) (homega : omega ≠ 0)
    (hnu : ∃ w : KaehlerDifferential k R, KaehlerDifferential.map k k R F w = nu)
    (hnozero : ¬ differentialZeroLattice (R := R) omega) :
    ∃ r : R, algebraMap R F r • omega = nu := by
  letI : Algebra.FormallyEtale R F :=
    Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors R)
  let eF := formallyEtaleDifferentialCoordinate (S := F) e
  let v := (discreteValuationPlace R).valuation F
  have hcoef : eF omega ≠ 0 := by
    intro h
    exact homega (eF.injective (h.trans (map_zero eF).symm))
  have hden : 1 ≤ v (eF omega) := by
    exact le_of_not_gt fun h => hnozero
      ((actual_dvr_differential_zero_iff_valuation_lt_one e omega).mpr h)
  have hnum : v (eF nu) ≤ 1 := by
    obtain ⟨w, hw⟩ := hnu
    rw [← hw, formally_etale_differential_coordinate_map]
    exact (discreteValuationPlace R).valuation_le_one (K := F) (e w)
  have hquot : v (eF nu / eF omega) ≤ 1 := by
    rw [map_div₀]
    exact (div_le_one₀ (zero_lt_one.trans_le hden)).mpr (hnum.trans hden)
  obtain ⟨r, hr⟩ :=
    (dvr_height_one_valuation_integers (R := R) (K := F)).exists_of_le_one hquot
  refine ⟨r, ?_⟩
  apply eF.injective
  rw [map_smul, smul_eq_mul, hr]
  exact div_mul_cancel₀ (eF nu) hcoef

end Litt3.CartierAndSpin
