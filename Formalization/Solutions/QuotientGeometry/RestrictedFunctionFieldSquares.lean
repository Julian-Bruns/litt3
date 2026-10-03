import Solutions.QuotientGeometry.GenericFieldPullbacks
import Solutions.QuotientGeometry.OpenFunctionFields

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

universe u

instance actual_restricted_scheme_surjective
    {X Y : Scheme.{u}} (f : X ⟶ Y) [Surjective f] (U : Y.Opens) :
    Surjective (f ∣_ U) := IsZariskiLocalAtTarget.restrict ‹Surjective f› U

/-- Restricting an original surjective Scheme morphism to a genuine
open chart preserves the ENTIRE original generic-field inclusion through
the actual open generic-stalk equivalences on BOTH source and target. -/
theorem actual_restricted_function_field_square
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [Surjective f]
    (U : Y.Opens) [Nonempty U] [Nonempty (f ⁻¹ᵁ U)] :
    (actualOpenFunctionFieldEquiv (f ⁻¹ᵁ U).ι).toRingHom.comp
        (schemeFunctionFieldPullback f) =
      (schemeFunctionFieldPullback (f ∣_ U)).comp
        (actualOpenFunctionFieldEquiv U.ι).toRingHom := by
  let fU := f ∣_ U
  have hfU := scheme_genericPoint_eq_of_surjective fU
  have hf := scheme_genericPoint_eq_of_surjective f
  have hU := genericPoint_eq_of_isOpenImmersion U.ι
  have hV := genericPoint_eq_of_isOpenImmersion (f ⁻¹ᵁ U).ι
  have hl : (fU ≫ U.ι) (genericPoint (f ⁻¹ᵁ U).toScheme) = genericPoint Y := by
    rw [Scheme.Hom.comp_apply, hfU, hU]
  have hr : ((f ⁻¹ᵁ U).ι ≫ f) (genericPoint (f ⁻¹ᵁ U).toScheme) = genericPoint Y := by
    rw [Scheme.Hom.comp_apply, hV, hf]
  have hc := actual_generic_field_pullback_congr
    (fU ≫ U.ι) ((f ⁻¹ᵁ U).ι ≫ f) hl hr (morphismRestrict_ι f U)
  rw [actual_generic_field_pullback_comp fU U.ι hfU hU hl,
    actual_generic_field_pullback_comp (f ⁻¹ᵁ U).ι f hV hf hr,
    actual_generic_field_pullback_surjective fU hfU,
    actual_generic_field_pullback_open U.ι hU,
    actual_generic_field_pullback_open (f ⁻¹ᵁ U).ι hV,
    actual_generic_field_pullback_surjective f hf] at hc
  exact hc.symm

end Litt3.QuotientGeometry
