import Solutions.Jacobians.SchemeDivisorSheaves
import Solutions.Jacobians.RationalFunctionOpenLinearEquivalence

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]
  (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
  (e : actualSchemeDivisorSheaf X D ≅ SheafOfModules.unit X.ringCatSheaf)

/-- A true global divisor-sheaf trivialization gives actual ORIGINAL
section-module equivalences on EVERY original open. -/
noncomputable def actualDivisorSheafTrivialSectionEquiv (U : X.Opensᵒᵖ) :
    (actualSchemeDivisorSheaf X D).val.obj U ≃ₗ[Γ(X, U.unop)] Γ(X, U.unop) :=
  ((SheafOfModules.evaluation X.ringCatSheaf U).mapIso e).toLinearEquiv

/-- The true inverse image of the ORIGINAL unit section under an
ACTUAL SHEAF isomorphism, not a supplied meromorphic generator. -/
noncomputable def actualDivisorSheafUnitGenerator (U : X.Opensᵒᵖ) :
    (actualSchemeDivisorSheaf X D).val.obj U :=
  (actualDivisorSheafTrivialSectionEquiv X D e U).symm 1

/-- Every genuine original section on U is its actual scalar multiple
of the derived original unit generator. -/
theorem actualDivisorSheafUnitGenerator_generates (U : X.Opensᵒᵖ)
    (a : (actualSchemeDivisorSheaf X D).val.obj U) :
    a = (actualDivisorSheafTrivialSectionEquiv X D e U a) •
      actualDivisorSheafUnitGenerator X D e U := by
  apply (actualDivisorSheafTrivialSectionEquiv X D e U).injective
  simp [actualDivisorSheafUnitGenerator]

/-- The derived unit generators commute with ALL ORIGINAL restrictions,
since they come from one genuine original SHEAF isomorphism. -/
theorem actualDivisorSheafUnitGenerator_restriction
    {U V : X.Opensᵒᵖ} (i : U ⟶ V) :
    (actualSchemeDivisorSheaf X D).val.map i (actualDivisorSheafUnitGenerator X D e U) =
      actualDivisorSheafUnitGenerator X D e V := by
  change (actualSchemeDivisorSheaf X D).val.map i (e.inv.val.app U (1 : Γ(X, U.unop))) =
    e.inv.val.app V (1 : Γ(X, V.unop))
  have hunit : (SheafOfModules.unit X.ringCatSheaf).val.map i (1 : Γ(X, U.unop)) =
      (1 : Γ(X, V.unop)) :=
    (X.ringCatSheaf.val.map i).hom.map_one
  have h := CategoryTheory.congr_fun (e.inv.val.naturality i)
    (1 : Γ(X, U.unop))
  simpa only [PresheafOfModules.comp_app, ModuleCat.comp_apply, hunit] using h.symm

end Litt3.Jacobians
