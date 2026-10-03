import Definitions.CartierAndSpin.SchemeDifferentialZeros
import Definitions.CartierAndSpin.SchemeDifferentialPoles

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

/-- A genuine original residue-fiber zero is in the ORIGINAL regular
differential stalk image. This follows from the actual module witness,
without smoothness, DVR, coordinate or valuation hypotheses. -/
theorem actual_original_differential_zero_regular
    (sX : X ⟶ Spec (.of k)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (x : ClosedPoint X),
      x ∈ schemeDifferentialZeroSet sX omega →
        omega ∈ schemeLocalRegularDifferentials sX x.val := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega x hzero
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI : IsScalarTower k (X.presheaf.stalk x.val) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
  obtain ⟨w, _, hw⟩ := hzero
  exact ⟨w, hw⟩

/-- Genuine original zero and pole supports are disjoint, for EVERY
rational universal differential on EVERY original integral scheme. -/
theorem actual_original_differential_zero_pole_sets_disjoint
    (sX : X ⟶ Spec (.of k)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField,
      Disjoint (schemeDifferentialZeroSet sX omega) (schemeDifferentialPoleSet sX omega) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega
  apply Set.disjoint_left.mpr
  intro x hzero hpole
  exact hpole (actual_original_differential_zero_regular sX omega x hzero)

end Litt3.CartierAndSpin
