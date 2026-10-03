import Solutions.CartierAndSpin.SmoothEtaleDifferentialOpenPullbacks

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry Litt3.Jacobians

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (f : X ⟶ Y) [IsFinite f] [IsEtale f] [Surjective f]
  (hover : f ≫ sY = sX)

/-- The recovered ORIGINAL differential section pullback is semilinear
through the ACTUAL structure-sheaf section-ring map, on every open. -/
theorem actualSmoothEtaleDifferentialOpenPullback_smul
    (U : Y.Opens) (r : Γ(Y, U))
    (a : (schemeDifferentialSheaf sY).val.obj (op U)) :
    actualSmoothEtaleDifferentialOpenPullback sX sY f hover U (r • a) =
      (f.app U r) • actualSmoothEtaleDifferentialOpenPullback sX sY f hover U a := by
  classical
  by_cases hU : Nonempty U
  · letI := hU
    letI := actualSchemeNonemptyPreimageOpen f U
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    apply schemeDifferentialSheafOpenToFunctionField_injective sX 1 (f ⁻¹ᵁ U)
    rw [actualSmoothEtaleDifferentialOpenPullback_rational,
      schemeDifferentialSheafOpenToFunctionField_smul,
      schemeDifferentialSheafOpenToFunctionField_smul,
      actualSmoothEtaleDifferentialOpenPullback_rational,
      map_smul, ← IsScalarTower.algebraMap_smul (R := Y.functionField) X.functionField]
    have hcoef := RingHom.congr_fun (actual_function_field_pullback_chart f U) r
    change algebraMap Y.functionField X.functionField
        (algebraMap Γ(Y, U) Y.functionField r) =
      algebraMap Γ(X, f ⁻¹ᵁ U) X.functionField (f.app U r) at hcoef
    rw [hcoef]
  · have hpre : ¬Nonempty (f ⁻¹ᵁ U) := by
      rintro ⟨x⟩
      exact hU ⟨⟨f x.val, x.property⟩⟩
    letI := actualOriginalModuleSheaf_empty_sections_subsingleton X
      (schemeDifferentialSheaf sX) (f ⁻¹ᵁ U) hpre
    exact Subsingleton.elim _ _

/-- A genuine ORIGINAL module-SHEAF morphism to the actual pushforward
of the source differential sheaf. Every section map is the recovered
literal universal pullback; scalar and restriction squares are proved,
and agreement with the entire original presheaf is proved separately. -/
noncomputable def actualSmoothEtaleDifferentialSheafPullbackMap :
    schemeDifferentialSheaf sY ⟶
      (SheafOfModules.pushforward (actualSchemeRingSheafMap f)).obj
        (schemeDifferentialSheaf sX) where
  val :=
    { app := fun U => ModuleCat.ofHom
        (X := (schemeDifferentialSheaf sY).val.obj U)
        (Y := ((SheafOfModules.pushforward (actualSchemeRingSheafMap f)).obj
          (schemeDifferentialSheaf sX)).val.obj U)
        { toFun := actualSmoothEtaleDifferentialOpenPullback sX sY f hover U.unop
          map_add' := fun a b => map_add _ a b
          map_smul' := fun r a =>
            actualSmoothEtaleDifferentialOpenPullback_smul sX sY f hover U.unop r a }
      naturality := fun {U V} i => by
        apply ModuleCat.hom_ext
        apply LinearMap.ext
        intro a
        exact actualSmoothEtaleDifferentialOpenPullback_restriction sX sY f hover i.unop a }

/-- The genuine module-SHEAF morphism extends the ENTIRE original
universal differential-presheaf map through both sheafification units. -/
theorem actualSmoothEtaleDifferentialSheafPullbackMap_presheaf
    (U : Y.Opens) (a : (schemeDifferentialPresheaf sY).obj (op U)) :
    (actualSmoothEtaleDifferentialSheafPullbackMap sX sY f hover).val.app (op U)
        ((CategoryTheory.toSheafify (Opens.grothendieckTopology Y)
          (schemeDifferentialPresheaf sY).presheaf).app (op U) a) =
      (CategoryTheory.toSheafify (Opens.grothendieckTopology X)
        (schemeDifferentialPresheaf sX).presheaf).app (op (f ⁻¹ᵁ U))
        (actualSchemeDifferentialPresheafOpenPullback sX sY f hover U a) :=
  actualSmoothEtaleDifferentialOpenPullback_presheaf sX sY f hover U a

/-- On EVERY original open the true sheaf map carries the sheafified
original derivative d(r) to the original derivative of f.app(r). -/
theorem actualSmoothEtaleDifferentialSheafPullbackMap_derivative
    (U : Y.Opens) (r : Γ(Y, U)) :
    (actualSmoothEtaleDifferentialSheafPullbackMap sX sY f hover).val.app (op U)
        ((CategoryTheory.toSheafify (Opens.grothendieckTopology Y)
          (schemeDifferentialPresheaf sY).presheaf).app (op U)
          (CommRingCat.KaehlerDifferential.d
            (f := (schemeConstantFieldPresheafMap sY).app (op U)) r)) =
      (CategoryTheory.toSheafify (Opens.grothendieckTopology X)
        (schemeDifferentialPresheaf sX).presheaf).app (op (f ⁻¹ᵁ U))
        (CommRingCat.KaehlerDifferential.d
          (f := (schemeConstantFieldPresheafMap sX).app (op (f ⁻¹ᵁ U))) (f.app U r)) := by
  rw [actualSmoothEtaleDifferentialSheafPullbackMap_presheaf,
    actualSchemeDifferentialPresheafOpenPullback_derivative]

end Litt3.CartierAndSpin
