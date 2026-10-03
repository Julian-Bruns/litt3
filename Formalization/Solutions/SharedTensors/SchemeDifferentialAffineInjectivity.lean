import Solutions.SharedTensors.SchemeDifferentialLocalRealization
import Solutions.QuotientGeometry.SmoothStalkDifferentialInjectivity
import Mathlib.RingTheory.LocalProperties.Submodule

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

/-- The ORIGINAL universal module on every nonempty affine open of an
actual smooth scheme injects into its original rational module. No
standard-smooth global chart or differential injectivity premise is
needed: the genuine localizations and free ORIGINAL stalk modules
detect every original element. -/
theorem schemeDifferentialOpenToFunctionField_affine_injective
    (sX : X ⟶ Spec (.of k)) (n : ℕ) [IsSmoothOfRelativeDimension n sX]
    (U : X.Opens) [Nonempty U] (hU : IsAffineOpen U) :
    Function.Injective (schemeDifferentialOpenToFunctionField sX U) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (chartBaseFieldHom sX U).toAlgebra
  intro a b h
  apply Module.eq_of_localization_maximal (R := Γ(X, U))
    (fun (P : Ideal Γ(X, U)) (_ : P.IsMaximal) =>
      LocalizedModule P.primeCompl (KaehlerDifferential k Γ(X, U)))
    (fun (P : Ideal Γ(X, U)) (_ : P.IsMaximal) =>
      LocalizedModule.mkLinearMap P.primeCompl (KaehlerDifferential k Γ(X, U))) a b
  intro P hP
  let y : PrimeSpectrum Γ(X, U) := ⟨P, hP.isPrime⟩
  let x : U := hU.isoSpec.inv y
  have hprime : hU.primeIdealOf x = y := by
    change hU.isoSpec.hom (hU.isoSpec.inv y) = y
    simpa using
      congrArg (fun f : Spec Γ(X, U) ⟶ Spec Γ(X, U) => f y) hU.isoSpec.inv_hom_id
  letI := (stalkBaseFieldHom sX x).toAlgebra
  letI := X.presheaf.algebra_section_stalk x
  letI : IsScalarTower k Γ(X, U) (X.presheaf.stalk x) :=
    IsScalarTower.of_algebraMap_eq'
      (actual_chart_stalk_base_field_compatibility sX U x).symm
  letI : IsScalarTower k Γ(X, U) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (chart_base_field_hom_generic_compatibility sX U).symm
  letI : IsScalarTower k (X.presheaf.stalk x) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (stalk_base_field_generic_compatibility sX x).symm
  letI : IsScalarTower Γ(X, U) (X.presheaf.stalk x) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (by
      symm
      change (X.presheaf.germ U x x.property ≫
          X.presheaf.stalkSpecializes ((genericPoint_spec X).specializes trivial)).hom =
        (X.presheaf.germ U (genericPoint X) _).hom
      rw [X.presheaf.germ_stalkSpecializes])
  letI : IsLocalization.AtPrime (X.presheaf.stalk x) P := by
    have hloc := hU.isLocalization_stalk x
    rw [hprime] at hloc
    exact hloc
  let f := KaehlerDifferential.map k k Γ(X, U) (X.presheaf.stalk x)
  have hf : f a = f b := by
    apply actual_smooth_stalk_differential_map_injective sX n x
    exact (kaehler_map_composition (k := k) (R := Γ(X, U))
      (S := X.presheaf.stalk x) (T := X.functionField) a).trans
        (h.trans (kaehler_map_composition (k := k) (R := Γ(X, U))
          (S := X.presheaf.stalk x) (T := X.functionField) b).symm)
  apply (IsLocalizedModule.iso P.primeCompl f).injective
  simpa only [LocalizedModule.mkLinearMap_apply, IsLocalizedModule.iso_mk_one] using hf

end Litt3.SharedTensors
