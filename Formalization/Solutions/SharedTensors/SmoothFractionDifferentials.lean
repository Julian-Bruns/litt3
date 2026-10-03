import Solutions.SharedTensors.KaehlerCharacters
import Mathlib.RingTheory.Etale.Kaehler
import Mathlib.RingTheory.Smooth.StandardSmoothCotangent
import Mathlib.LinearAlgebra.Dimension.Constructions
import Mathlib.RingTheory.Localization.FractionRing

namespace Litt3.SharedTensors

open scoped TensorProduct

variable {k R K : Type*} [Field k] [CommRing R] [IsDomain R] [Field K]
  [Algebra k R] [Algebra k K] [Algebra R K] [IsScalarTower k R K]
  [IsFractionRing R K]

/-- The actual universal differential module of the fraction field of a
standard smooth affine domain has its actual relative dimension. Arbitrary
localization is used; the fraction field is not falsely declared a finitely
presented smooth algebra. -/
theorem smooth_fraction_field_kaehler_rank (n : ℕ)
    [Algebra.IsStandardSmoothOfRelativeDimension n k R] :
    Module.rank K (KaehlerDifferential k K) = n := by
  letI : Algebra.IsStandardSmooth k R :=
    Algebra.IsStandardSmoothOfRelativeDimension.isStandardSmooth n
  letI : Algebra.FormallyEtale R K :=
    Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors R)
  let e := KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale k R K
  have hr := e.lift_rank_eq
  rw [Module.rank_baseChange,
    Algebra.IsStandardSmoothOfRelativeDimension.rank_kaehlerDifferential n] at hr
  simpa only [Cardinal.lift_natCast, Cardinal.lift_eq_nat_iff] using hr.symm

theorem smooth_fraction_field_kaehler_finrank (n : ℕ)
    [Algebra.IsStandardSmoothOfRelativeDimension n k R] :
    Module.finrank K (KaehlerDifferential k K) = n :=
  Module.finrank_eq_of_rank_eq (smooth_fraction_field_kaehler_rank (k := k) (R := R) n)

/-- A genuine standard smooth curve chart supplies the coordinate of the
actual rational Kähler module. No differential coordinate is an assumption. -/
noncomputable def smoothFractionKaehlerCoordinate
    [Algebra.IsStandardSmoothOfRelativeDimension 1 k R] :
    KaehlerDifferential k K ≃ₗ[K] K := by
  letI : Module.Finite K (KaehlerDifferential k K) :=
    Module.finite_of_rank_eq_nat (smooth_fraction_field_kaehler_rank (k := k) (R := R) 1)
  exact LinearEquiv.ofFinrankEq (KaehlerDifferential k K) K
    (by rw [smooth_fraction_field_kaehler_finrank (R := R) 1, Module.finrank_self])

end Litt3.SharedTensors
