import Solutions.SharedTensors.SchemeDifferentialClosedRecovery

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

omit [IsIntegral X] in
/-- The original sheafification unit is linear over the ORIGINAL open
section ring, with the actual sheaf's derived module structure. -/
theorem schemeDifferentialSheafification_unit_smul
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) (r : Γ(X, U))
    (a : (schemeDifferentialPresheaf sX).obj (Opposite.op U)) :
    let b : (schemeDifferentialSheaf sX).val.obj (Opposite.op U) :=
      (CategoryTheory.toSheafify (Opens.grothendieckTopology X)
        (schemeDifferentialPresheaf sX).presheaf).app (Opposite.op U) a
    (CategoryTheory.toSheafify (Opens.grothendieckTopology X)
      (schemeDifferentialPresheaf sX).presheaf).app (Opposite.op U) (r • a) =
    r • b := by
  let f := ((PresheafOfModules.sheafificationAdjunction
    (𝟙 X.ringCatSheaf.val)).unit.app (schemeDifferentialPresheaf sX)).app (Opposite.op U)
  exact f.hom.map_smul r a

/-- Genuine associated-sheaf rational realization is linear over every
ORIGINAL nonempty open's section ring. This follows by a true local
presheaf representative at the generic point and actual restriction/unit
linearity, without a supplied linearity premise or smoothness. -/
theorem schemeDifferentialSheafOpenToFunctionField_smul
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) [Nonempty U] :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (r : Γ(X, U)) (a : (schemeDifferentialSheaf sX).val.obj (Opposite.op U)),
      schemeDifferentialSheafOpenToFunctionField sX U (r • a) =
        algebraMap Γ(X, U) X.functionField r •
          schemeDifferentialSheafOpenToFunctionField sX U a := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro r a
  have hη : genericPoint X ∈ U :=
    ((genericPoint_spec X).mem_open_set_iff U.isOpen).mpr
      (by simpa using (inferInstance : Nonempty U))
  obtain ⟨V, i, hηV, b, hb⟩ :=
    schemeDifferentialSheaf_local_representative sX U a (genericPoint X) hη
  letI : Nonempty V := ⟨⟨genericPoint X, hηV⟩⟩
  let bModule : (schemeDifferentialPresheaf sX).obj (Opposite.op V) := b
  let rV : Γ(X, V) := X.presheaf.map i.op r
  have hbmul :
      (CategoryTheory.toSheafify (Opens.grothendieckTopology X)
        (schemeDifferentialPresheaf sX).presheaf).app (Opposite.op V) (rV • bModule) =
      (schemeDifferentialSheaf sX).val.presheaf.map i.op (r • a) := by
    rw [schemeDifferentialSheafification_unit_smul, hb]
    exact ((schemeDifferentialSheaf sX).val.map_smul i.op r a).symm
  have hrestrict (c : (schemeDifferentialSheaf sX).val.obj (Opposite.op U)) :
      schemeDifferentialSheafOpenToFunctionField sX V
        ((schemeDifferentialSheaf sX).val.presheaf.map i.op c) =
      schemeDifferentialSheafOpenToFunctionField sX U c :=
    congrArg (fun f => f.hom c)
      (schemeDifferentialSheafOpenToFunctionField_restriction sX i)
  have hunit (c : (schemeDifferentialPresheaf sX).obj (Opposite.op V)) :
      schemeDifferentialSheafOpenToFunctionField sX V
        ((CategoryTheory.toSheafify (Opens.grothendieckTopology X)
          (schemeDifferentialPresheaf sX).presheaf).app (Opposite.op V) c) =
      schemeDifferentialOpenToFunctionField sX V c :=
    congrArg (fun f => f.hom c)
      (schemeDifferentialSheafOpenToFunctionField_presheaf sX V)
  have hcoef : algebraMap Γ(X, V) X.functionField rV =
      algebraMap Γ(X, U) X.functionField r := by
    exact RingHom.congr_fun
      (actual_section_restriction_function_field (X := X) (leOfHom i)) r
  have hlinear : schemeDifferentialOpenToFunctionField sX V (rV • bModule) =
      algebraMap Γ(X, V) X.functionField rV •
        schemeDifferentialOpenToFunctionField sX V bModule := by
    letI := (chartBaseFieldHom sX V).toAlgebra
    letI : IsScalarTower k Γ(X, V) X.functionField :=
      IsScalarTower.of_algebraMap_eq'
        (chart_base_field_hom_generic_compatibility sX V).symm
    change KaehlerDifferential.map k k Γ(X, V) X.functionField (rV • bModule) = _
    rw [map_smul, IsScalarTower.algebraMap_smul]
    rfl
  rw [← hrestrict (r • a), ← hbmul, hunit, hlinear, hcoef,
    ← hunit bModule, hb, hrestrict a]

end Litt3.SharedTensors
