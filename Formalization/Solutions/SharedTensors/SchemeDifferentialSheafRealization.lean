import Solutions.SharedTensors.SchemeDifferentialGenericRealization

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

/-- The actual associated differential SHEAF maps naturally into the
honest rational differential sheaf. This follows from the universal
property of genuine sheafification, not from naming a rational lattice. -/
noncomputable def schemeDifferentialSheafToRational (sX : X ⟶ Spec (.of k)) :
    (schemeDifferentialSheaf sX).val.presheaf ⟶
      (schemeRationalDifferentialSheaf sX).val := by
  change CategoryTheory.sheafify (Opens.grothendieckTopology X)
      (schemeDifferentialPresheaf sX).presheaf ⟶ _
  exact CategoryTheory.sheafifyLift (Opens.grothendieckTopology X)
    (schemeDifferentialPresheafToRational sX) (schemeRationalDifferentialSheaf sX).cond

/-- The associated-sheaf map is exactly the literal original
presheaf map after the actual sheafification unit. -/
theorem schemeDifferentialSheafToRational_presheaf_compatibility
    (sX : X ⟶ Spec (.of k)) :
    CategoryTheory.toSheafify (Opens.grothendieckTopology X)
      (schemeDifferentialPresheaf sX).presheaf ≫
      schemeDifferentialSheafToRational sX =
    schemeDifferentialPresheafToRational sX :=
  CategoryTheory.toSheafify_sheafifyLift (Opens.grothendieckTopology X)
    (schemeDifferentialPresheafToRational sX) (schemeRationalDifferentialSheaf sX).cond

end Litt3.SharedTensors
