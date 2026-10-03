import Solutions.QuotientGeometry.RestrictedFunctionFieldSquares
import Solutions.QuotientGeometry.FieldExtensionEquivalenceTransport

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

universe u

/-- Finite separability of the TRUE original generic-stalk inclusion
passes to each actual nonempty open restriction, through both actual
open generic-field RingEquivs and the proved original inclusion square. -/
theorem actual_restricted_function_field_finite_separable
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [Surjective f] :
    letI := (schemeFunctionFieldPullback f).toAlgebra
    FiniteDimensional Y.functionField X.functionField →
    Algebra.IsSeparable Y.functionField X.functionField →
    ∀ (U : Y.Opens) [Nonempty U] [Nonempty (f ⁻¹ᵁ U)],
      letI := (schemeFunctionFieldPullback (f ∣_ U)).toAlgebra
      FiniteDimensional U.toScheme.functionField (f ⁻¹ᵁ U).toScheme.functionField ∧
        Algebra.IsSeparable U.toScheme.functionField (f ⁻¹ᵁ U).toScheme.functionField := by
  letI := (schemeFunctionFieldPullback f).toAlgebra
  intro hfinite hseparable U hU hV
  letI := hfinite
  letI := hseparable
  letI := hU
  letI := hV
  letI := (schemeFunctionFieldPullback (f ∣_ U)).toAlgebra
  apply finite_separable_extension_of_field_equivalences
    (actualOpenFunctionFieldEquiv U.ι) (actualOpenFunctionFieldEquiv (f ⁻¹ᵁ U).ι)
  intro a
  exact congrArg (fun h : Y.functionField →+* (f ⁻¹ᵁ U).toScheme.functionField => h a)
    (actual_restricted_function_field_square f U)

end Litt3.QuotientGeometry
