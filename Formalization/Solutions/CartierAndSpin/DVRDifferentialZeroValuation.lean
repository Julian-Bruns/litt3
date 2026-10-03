import Solutions.CartierAndSpin.DifferentialZeroCoordinates
import Solutions.CartierAndSpin.UnramifiedDifferentialLattices

namespace Litt3.CartierAndSpin

open Litt3.Jacobians

variable {k R F : Type*} [CommRing k] [CommRing R] [IsDomain R]
  [IsDiscreteValuationRing R] [Field F] [Algebra k R] [Algebra k F]
  [Algebra R F] [IsFractionRing R F] [IsScalarTower k R F]

local instance dvrFractionFormallyEtale : Algebra.FormallyEtale R F :=
  Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors R)

/-- The zero lattice of the ORIGINAL differential module is exactly
strict positive normalized order, expressed by the actual DVR valuation.
No coordinate-dependent zero predicate is substituted for m·Ω. -/
theorem actual_dvr_differential_zero_iff_valuation_lt_one
    (e : KaehlerDifferential k R ≃ₗ[R] R) (omega : KaehlerDifferential k F) :
    differentialZeroLattice (R := R) omega ↔
      (discreteValuationPlace R).valuation F
        (formallyEtaleDifferentialCoordinate (S := F) e omega) < 1 := by
  letI : Algebra.FormallyEtale R F :=
    Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors R)
  rw [differential_zero_lattice_iff_coordinate e]
  constructor
  · rintro ⟨r, hr, hcoord⟩
    rw [← hcoord]
    exact ((discreteValuationPlace R).valuation_lt_one_iff_mem (K := F) r).mpr hr
  · intro h
    obtain ⟨r, hr⟩ :=
      (dvr_height_one_valuation_integers (R := R) (K := F)).exists_of_le_one h.le
    refine ⟨r, ?_, hr⟩
    apply ((discreteValuationPlace R).valuation_lt_one_iff_mem (K := F) r).mp
    change (discreteValuationPlace R).valuation F (algebraMap R F r) < 1
    rwa [hr]

end Litt3.CartierAndSpin
