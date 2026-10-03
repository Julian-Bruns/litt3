import Solutions.Jacobians.ActualSchemeRationalFunctionSheaf

open CategoryTheory AlgebraicGeometry TopologicalSpace TopCat

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X]

/-- Evaluation at any original point uses the true rational SHEAF germ
and its actual generic-specialization stalk isomorphism. -/
noncomputable def actualRationalFunctionEvaluation
    (U : X.Opens) (x : X) (hx : x ∈ U) :
    ((actualSchemeRationalFunctionRingSheaf X).val.obj (Opposite.op U)) →+*
      X.functionField := by
  classical
  exact (TopCat.Presheaf.germ (actualSchemeRationalFunctionRingSheaf X).val U x hx ≫
    (skyscraperPresheafStalkOfSpecializes (genericPoint X)
      (CommRingCat.of X.functionField) ((genericPoint_spec X).specializes trivial)).hom).hom

/-- This value is literally the original open's rational function;
the choice of original point does not change its value. -/
theorem actualRationalFunctionEvaluation_eq_open
    (U : X.Opens) [Nonempty U] (x : X) (hx : x ∈ U) :
    actualRationalFunctionEvaluation X U x hx =
      (actualSchemeRationalFunctionOpenIso X U).hom.hom := by
  classical
  unfold actualRationalFunctionEvaluation
  unfold actualSchemeRationalFunctionRingSheaf
  dsimp only [skyscraperSheaf]
  rw [germ_skyscraperPresheafStalkOfSpecializes_hom]
  rfl

/-- Every actual restriction preserves the entire rational function,
expressed through true original-point germ evaluation. -/
theorem actualRationalFunctionEvaluation_restriction
    {U V : X.Opens} (i : V ⟶ U) (x : X) (hx : x ∈ V) :
    (actualRationalFunctionEvaluation X V x hx).comp
      ((actualSchemeRationalFunctionRingSheaf X).val.map i.op).hom =
        actualRationalFunctionEvaluation X U x (i.le hx) := by
  classical
  let e : TopCat.Presheaf.stalk (actualSchemeRationalFunctionRingSheaf X).val x ≅
      CommRingCat.of X.functionField :=
    skyscraperPresheafStalkOfSpecializes (genericPoint X)
      (CommRingCat.of X.functionField) ((genericPoint_spec X).specializes trivial)
  change CommRingCat.Hom.hom
    ((((actualSchemeRationalFunctionRingSheaf X).val.map i.op) ≫
      TopCat.Presheaf.germ (actualSchemeRationalFunctionRingSheaf X).val V x hx) ≫ e.hom) = _
  rw [TopCat.Presheaf.germ_res]
  rfl

/-- The derived O_X action evaluates to genuine multiplication by the
original section's actual function-field germ. -/
theorem actualRationalFunctionEvaluation_smul
    (U : X.Opens) [Nonempty U] (x : X) (hx : x ∈ U)
    (r : Γ(X, U)) (a : (actualSchemeRationalFunctionModuleSheaf X).val.obj (Opposite.op U)) :
    actualRationalFunctionEvaluation X U x hx (r • a) =
      algebraMap Γ(X, U) X.functionField r * actualRationalFunctionEvaluation X U x hx a := by
  classical
  change actualRationalFunctionEvaluation X U x hx
    ((show (actualSchemeRationalFunctionRingSheaf X).val.obj (Opposite.op U) from
      (actualSchemeStructureToRationalFunctions X).val.app (Opposite.op U) r) *
        (show (actualSchemeRationalFunctionRingSheaf X).val.obj (Opposite.op U) from a)) = _
  rw [map_mul, actualRationalFunctionEvaluation_eq_open]
  exact congrArg (fun z => z * (actualSchemeRationalFunctionOpenIso X U).hom a)
    (CategoryTheory.congr_fun (actualSchemeStructureToRationalFunctions_open X U) r)

end Litt3.Jacobians
