import Solutions.Jacobians.SchemeValuationPullbacks

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- Actual surjective maps of integral schemes have injective maps on
every original local ring. The proof uses the genuine generic-stalk
field inclusion and its actual local compatibility. -/
theorem actual_integral_surjective_scheme_stalk_injective
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [Surjective f] (x : X) :
    Function.Injective (f.stalkMap x).hom := by
  intro a b hab
  apply IsFractionRing.injective (Y.presheaf.stalk (f x)) Y.functionField
  apply (Litt3.SharedTensors.schemeFunctionFieldPullback f).injective
  rw [Litt3.Jacobians.scheme_function_field_pullback_stalk,
    Litt3.Jacobians.scheme_function_field_pullback_stalk, hab]

end Litt3.QuotientGeometry
