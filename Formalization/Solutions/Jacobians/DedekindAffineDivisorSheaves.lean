import Solutions.Jacobians.DedekindAffineDivisorPicard
import Solutions.Jacobians.ActualTildeIsomorphismRecovery

open CategoryTheory Opposite AlgebraicGeometry
open scoped nonZeroDivisors
open IsDedekindDomain

namespace Litt3.Jacobians

universe u
variable (R : Type u) [CommRing R] [IsDedekindDomain R]

/-- The literal invertible fractional-ideal module of an actual normalized
adic affine divisor. Positive primes have the O(-D) convention. -/
noncomputable def dedekindAffineDivisorModule (D : Divisor (HeightOneSpectrum R)) :
    ModuleCat.{u} R :=
  ModuleCat.of R (((dedekindDivisorIdealMap R (FractionRing R) D).toMul.val :
    FractionalIdeal R⁰ (FractionRing R)) : Submodule R (FractionRing R))

noncomputable instance dedekindAffineDivisorModule_invertible
    (D : Divisor (HeightOneSpectrum R)) :
    Module.Invertible R (dedekindAffineDivisorModule R D) :=
  actual_invertible_fractional_ideal_module
    (dedekindDivisorIdealMap R (FractionRing R) D).toMul

/-- This is an ACTUAL O_Spec-module SHEAF of the actual fractional-ideal module,
not a class-group name or abstract line-bundle placeholder. -/
noncomputable def dedekindAffineDivisorSheaf (D : Divisor (HeightOneSpectrum R)) :
    (Spec (.of R)).Modules :=
  (dedekindAffineDivisorModule R D).tilde

/-- An actual divisor ideal sheaf is trivial precisely when its normalized
adic affine divisor is the divisor of an original fraction-field unit. -/
theorem dedekind_affine_divisor_sheaf_trivial_iff_principal
    (D : Divisor (HeightOneSpectrum R)) :
    Nonempty (dedekindAffineDivisorSheaf R D ≅
      SheafOfModules.unit (Spec (.of R)).ringCatSheaf) ↔
      ∃ f : Additive (FractionRing R)ˣ,
        principalDivisorMap (dedekindValuationDivisorSystem R (FractionRing R)) f = D := by
  unfold dedekindAffineDivisorSheaf
  rw [← actual_invertible_module_picard_zero_iff_sheaf_trivial
    (M := dedekindAffineDivisorModule R D)]
  exact dedekindDivisorPicardMap_zero_iff R (FractionRing R) D

end Litt3.Jacobians
