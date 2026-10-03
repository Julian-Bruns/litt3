import Solutions.Jacobians.SchemeValuationPullbacks
import Mathlib.RingTheory.Unramified.Field

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians
universe u

variable {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (f : X ⟶ Y) [Surjective f]

theorem actual_function_field_map_essFiniteType [LocallyOfFiniteType f] :
    (schemeFunctionFieldPullback f).EssFiniteType := by
  change (((Y.presheaf.stalkCongr (.of_eq
    (scheme_genericPoint_eq_of_surjective f))).inv ≫ f.stalkMap (genericPoint X)).hom).EssFiniteType
  rw [CommRingCat.hom_comp, essFiniteType_respectsIso.cancel_left_isIso]
  exact scheme_stalk_map_essFiniteType f (genericPoint X)

theorem actual_function_field_map_formallyUnramified
    [AlgebraicGeometry.FormallyUnramified f] :
    (schemeFunctionFieldPullback f).FormallyUnramified := by
  change (((Y.presheaf.stalkCongr (.of_eq
    (scheme_genericPoint_eq_of_surjective f))).inv ≫ f.stalkMap (genericPoint X)).hom).FormallyUnramified
  rw [CommRingCat.hom_comp, RingHom.FormallyUnramified.respectsIso.cancel_left_isIso]
  exact scheme_stalk_map_formallyUnramified f (genericPoint X)

/-- The actual generic-stalk map of a locally finite-type unramified
surjection is a finite separable field extension. No abstract extension
or one-leg substitute for the original span is used. -/
theorem actual_unramified_function_field_finite_separable
    [LocallyOfFiniteType f] [AlgebraicGeometry.FormallyUnramified f] :
    letI := (schemeFunctionFieldPullback f).toAlgebra
    Module.Finite Y.functionField X.functionField ∧
      Algebra.IsSeparable Y.functionField X.functionField := by
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI : Algebra.EssFiniteType Y.functionField X.functionField :=
    actual_function_field_map_essFiniteType f
  letI : Algebra.FormallyUnramified Y.functionField X.functionField :=
    actual_function_field_map_formallyUnramified f
  exact ⟨Algebra.FormallyUnramified.finite_of_free _ _,
    Algebra.FormallyUnramified.isSeparable _ _⟩

theorem actual_unramified_function_field_elements_integral
    [LocallyOfFiniteType f] [AlgebraicGeometry.FormallyUnramified f]
    (a : X.functionField) :
    letI := (schemeFunctionFieldPullback f).toAlgebra
    IsIntegral Y.functionField a := by
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI : Module.Finite Y.functionField X.functionField :=
    (actual_unramified_function_field_finite_separable f).1
  exact Algebra.IsIntegral.isIntegral a

/-- Both actual endpoint extensions are proved finite and separable
inside the SAME actual source function field. -/
theorem actual_span_both_generic_extensions_finite_separable
    (s : FiniteEtaleSpan X Y) [IsIntegral s.source] :
    (letI := (schemeFunctionFieldPullback s.left).toAlgebra
     Module.Finite X.functionField s.source.functionField ∧
       Algebra.IsSeparable X.functionField s.source.functionField) ∧
    (letI := (schemeFunctionFieldPullback s.right).toAlgebra
     Module.Finite Y.functionField s.source.functionField ∧
       Algebra.IsSeparable Y.functionField s.source.functionField) := by
  exact ⟨actual_unramified_function_field_finite_separable s.left,
    actual_unramified_function_field_finite_separable s.right⟩

end Litt3.SharedTensors
