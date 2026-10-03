import Solutions.SharedTensors.SmoothSchemeLocalCharts
import Solutions.SharedTensors.ConstantPrincipalDivisors
import Solutions.QuotientGeometry.AffineChartStalkCoefficients
import Mathlib.RingTheory.Smooth.StandardSmoothCotangent
import Mathlib.RingTheory.Etale.Kaehler
import Mathlib.LinearAlgebra.FreeModule.Basic
import Mathlib.Algebra.Module.Torsion.Free

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- Localization in the fraction field is injective on actual differentials
whenever the original differential module is free. No differential
injectivity hypothesis is supplied. -/
theorem fraction_field_differential_map_injective
    {k R K : Type*} [CommRing k] [CommRing R] [IsDomain R]
    [Field K] [Algebra k R] [Algebra R K] [Algebra k K]
    [IsScalarTower k R K] [IsFractionRing R K]
    [Module.Free R (KaehlerDifferential k R)] :
    Function.Injective (KaehlerDifferential.map k k R K) := by
  apply (IsLocalizedModule.injective_iff_isRegular (nonZeroDivisors R)
    (KaehlerDifferential.map k k R K)).mpr
  intro c
  exact smul_right_injective (KaehlerDifferential k R)
    (nonZeroDivisors.ne_zero c.property)

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k))

omit [IsIntegral X] in
/-- Every original stalk of an actual smooth scheme has a free
module of relative differentials. The standard smooth chart and the full
localization equivalence are constructed from the structure morphism.
No closed-point, rational-residue, or dimension-one assumption is needed. -/
theorem actual_smooth_stalk_differentials_free (n : ℕ)
    [IsSmoothOfRelativeDimension n sX] (x : X) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
    Module.Free (X.presheaf.stalk x) (KaehlerDifferential k (X.presheaf.stalk x)) := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
  obtain ⟨U, hU, hx, hs⟩ := Litt3.SharedTensors.actual_smooth_point_chart sX n x
  let xU : U := ⟨x, hx⟩
  letI : Nonempty U := ⟨xU⟩
  letI : Algebra k Γ(X, U) := (chartBaseFieldHom sX U).toAlgebra
  letI := X.presheaf.algebra_section_stalk xU
  letI : IsScalarTower k Γ(X, U) (X.presheaf.stalk x) :=
    IsScalarTower.of_algebraMap_eq'
      (actual_chart_stalk_base_field_compatibility sX U xU).symm
  letI : Algebra.IsStandardSmoothOfRelativeDimension n k Γ(X, U) := hs
  letI : Algebra.IsStandardSmooth k Γ(X, U) :=
    Algebra.IsStandardSmoothOfRelativeDimension.isStandardSmooth n
  letI := hU.isLocalization_stalk xU
  letI : Algebra.FormallyEtale Γ(X, U) (X.presheaf.stalk x) :=
    Algebra.FormallyEtale.of_isLocalization (hU.primeIdealOf xU).asIdeal.primeCompl
  exact Module.Free.of_equiv
    (KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale k Γ(X, U)
      (X.presheaf.stalk x))

/-- Actual smooth-stalk differentials inject into the actual function
field. Both coefficient maps and their tower are the original scheme
maps, and the fraction-field localization is genuine. -/
theorem actual_smooth_stalk_differential_map_injective (n : ℕ)
    [IsSmoothOfRelativeDimension n sX] (x : X) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
    letI := (genericBaseFieldHom sX).toAlgebra
    letI : IsScalarTower k (X.presheaf.stalk x) X.functionField :=
      IsScalarTower.of_algebraMap_eq'
        (Litt3.SharedTensors.stalk_base_field_generic_compatibility sX x).symm
    Function.Injective
      (KaehlerDifferential.map k k (X.presheaf.stalk x) X.functionField) := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : IsScalarTower k (X.presheaf.stalk x) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (Litt3.SharedTensors.stalk_base_field_generic_compatibility sX x).symm
  letI : Module.Free (X.presheaf.stalk x)
      (KaehlerDifferential k (X.presheaf.stalk x)) :=
    actual_smooth_stalk_differentials_free sX n x
  exact fraction_field_differential_map_injective

end Litt3.QuotientGeometry
