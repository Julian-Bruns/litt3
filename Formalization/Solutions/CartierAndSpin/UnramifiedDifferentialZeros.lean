import Solutions.CartierAndSpin.DVRDifferentialZeroValuation

namespace Litt3.CartierAndSpin

open Litt3.Jacobians

variable {k R S F E : Type*} [CommRing k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S]
  [Field F] [Field E]
  [Algebra k R] [Algebra k S] [Algebra k F] [Algebra k E]
  [Algebra R S] [Algebra R F] [Algebra R E] [Algebra S E] [Algebra F E]
  [IsFractionRing R F] [IsFractionRing S E]
  [IsScalarTower k R S] [IsScalarTower k R F] [IsScalarTower k R E]
  [IsScalarTower k S E] [IsScalarTower k F E]
  [IsScalarTower R S E] [IsScalarTower R F E]
  [IsLocalHom (algebraMap R S)] [Algebra.EssFiniteType R S]
  [Algebra.FormallyEtale R S]

/-- An actual original unramified local DVR square reflects and
preserves the true m·Ω zero lattice. True coordinate compatibility and
valuation preservation are proved from the original ring maps. -/
theorem actual_unramified_differential_zero_iff
    (e : KaehlerDifferential k R ≃ₗ[R] R) (omega : KaehlerDifferential k F) :
    differentialZeroLattice (R := S) (KaehlerDifferential.map k k F E omega) ↔
      differentialZeroLattice (R := R) omega := by
  letI : Algebra.FormallyEtale R F :=
    Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors R)
  letI : Algebra.FormallyEtale S E :=
    Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors S)
  rw [actual_dvr_differential_zero_iff_valuation_lt_one
      (formallyEtaleDifferentialCoordinate (S := S) e),
    actual_dvr_differential_zero_iff_valuation_lt_one e,
    formally_etale_differential_coordinate_square]
  rw [unramified_dvr_fraction_field_valuation_preserved
    (algebraMap F E) (fun r => (IsScalarTower.algebraMap_apply R F E r).symm)]

end Litt3.CartierAndSpin
