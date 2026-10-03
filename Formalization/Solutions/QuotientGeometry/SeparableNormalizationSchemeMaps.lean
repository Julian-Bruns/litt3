import Mathlib.RingTheory.DedekindDomain.IntegralClosure
import Mathlib.AlgebraicGeometry.Morphisms.Finite
import Mathlib.AlgebraicGeometry.Morphisms.UnderlyingMap

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

variable {A K L : Type u} [CommRing A] [IsDomain A] [Field K] [Field L]
  [Algebra A K] [Algebra K L] [Algebra A L] [IsScalarTower A K L]
  [IsFractionRing A K]

include K in
/-- The original inclusion into the integral closure is injective
for any genuine extension of the fraction field. -/
theorem actual_fraction_field_integral_closure_injective :
    Function.Injective (algebraMap A (integralClosure A L)) := by
  intro a b hab
  have h := congrArg (fun x : integralClosure A L => (x : L)) hab
  change algebraMap A L a = algebraMap A L b at h
  rw [IsScalarTower.algebraMap_apply A K L, IsScalarTower.algebraMap_apply A K L] at h
  exact IsFractionRing.injective A K ((algebraMap K L).injective h)

include K in
/-- The actual affine normalization morphism for a finite separable
extension of a Dedekind fraction field is finite. No Galois hypothesis
or independent finite-normalization assumption is required. -/
theorem actual_separable_normalization_spec_finite
    [IsDedekindDomain A] [FiniteDimensional K L] [Algebra.IsSeparable K L] :
    IsFinite (Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L)))) := by
  letI : Module.Finite A (integralClosure A L) :=
    IsIntegralClosure.finite A K L (integralClosure A L)
  apply (IsFinite.SpecMap_iff _).mpr
  exact RingHom.finite_algebraMap.mpr inferInstance

include K in
/-- Every original base prime has an actual point of the finite
separable normalization above it. -/
theorem actual_separable_normalization_spec_surjective
    [IsDedekindDomain A] [FiniteDimensional K L] [Algebra.IsSeparable K L] :
    Surjective (Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L)))) := by
  letI : Module.Finite A (integralClosure A L) :=
    IsIntegralClosure.finite A K L (integralClosure A L)
  have hf : (algebraMap A (integralClosure A L)).Finite :=
    RingHom.finite_algebraMap.mpr inferInstance
  constructor
  exact hf.to_isIntegral.specComap_surjective
    (actual_fraction_field_integral_closure_injective (K := K))

end Litt3.QuotientGeometry
