import Solutions.SharedTensors.SchemeDifferentialSheafRealization
import Solutions.QuotientGeometry.AffineChartStalkCoefficients
import Definitions.SharedTensors.SchemeRegularDifferentials
import Mathlib.Topology.Sheaves.LocallySurjective

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

omit [IsIntegral X] in
/-- Every section of the genuine associated differential SHEAF locally
comes from an ORIGINAL universal differential of actual open sections. -/
theorem schemeDifferentialSheaf_local_representative
    (sX : X ⟶ Spec (.of k)) (U : X.Opens)
    (omega : (schemeDifferentialSheaf sX).val.presheaf.obj (Opposite.op U))
    (x : X) (hx : x ∈ U) :
    ∃ (V : X.Opens) (i : V ⟶ U), x ∈ V ∧
      ∃ a : (schemeDifferentialPresheaf sX).presheaf.obj (Opposite.op V),
        (CategoryTheory.toSheafify (Opens.grothendieckTopology X)
          (schemeDifferentialPresheaf sX).presheaf).app (Opposite.op V) a =
            (schemeDifferentialSheaf sX).val.presheaf.map i.op omega := by
  let M := (schemeDifferentialPresheaf sX).presheaf
  have h : CategoryTheory.Presheaf.IsLocallySurjective (Opens.grothendieckTopology X)
      (CategoryTheory.toSheafify (Opens.grothendieckTopology X) M) := inferInstance
  obtain ⟨V, i, ⟨a, equality⟩, hxV⟩ := h.imageSieve_mem omega x hx
  exact ⟨V, i, hxV, a, equality⟩

/-- Literal universal differentials on an original open map into the
universal module of its original point stalk through the actual germ. -/
noncomputable def schemeDifferentialOpenToStalk
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) (x : U) :
    letI := (stalkBaseFieldHom sX x).toAlgebra
    (schemeDifferentialPresheaf sX).presheaf.obj (Opposite.op U) ⟶
      AddCommGrpCat.of (KaehlerDifferential k (X.presheaf.stalk x)) := by
  letI := (stalkBaseFieldHom sX x).toAlgebra
  letI := (chartBaseFieldHom sX U).toAlgebra
  letI := X.presheaf.algebra_section_stalk x
  letI : IsScalarTower k Γ(X, U) (X.presheaf.stalk x) :=
    IsScalarTower.of_algebraMap_eq'
      (actual_chart_stalk_base_field_compatibility sX U x).symm
  exact AddCommGrpCat.ofHom
    (KaehlerDifferential.map k k Γ(X, U) (X.presheaf.stalk x)).toAddMonoidHom

/-- Every original open differential generic image lies in the actual
original stalk differential image at every point of that open. -/
theorem schemeDifferentialOpenToFunctionField_mem_local
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) [Nonempty U] (x : U) :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ a : (schemeDifferentialPresheaf sX).presheaf.obj (Opposite.op U),
      schemeDifferentialOpenToFunctionField sX U a ∈
        schemeLocalRegularDifferentials sX x := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (stalkBaseFieldHom sX x).toAlgebra
  letI := (chartBaseFieldHom sX U).toAlgebra
  letI := X.presheaf.algebra_section_stalk x
  letI : IsScalarTower k Γ(X, U) (X.presheaf.stalk x) :=
    IsScalarTower.of_algebraMap_eq'
      (actual_chart_stalk_base_field_compatibility sX U x).symm
  letI : IsScalarTower k Γ(X, U) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (chart_base_field_hom_generic_compatibility sX U).symm
  letI : IsScalarTower k (X.presheaf.stalk x) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (stalk_base_field_generic_compatibility sX x).symm
  letI : IsScalarTower Γ(X, U) (X.presheaf.stalk x) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (by
      symm
      change (X.presheaf.germ U x x.property ≫
          X.presheaf.stalkSpecializes ((genericPoint_spec X).specializes trivial)).hom =
        (X.presheaf.germ U (genericPoint X) _).hom
      rw [X.presheaf.germ_stalkSpecializes])
  intro a
  exact ⟨schemeDifferentialOpenToStalk sX U x a,
    kaehler_map_composition (k := k) (R := Γ(X, U))
      (S := X.presheaf.stalk x) (T := X.functionField) a⟩

/-- Rational restriction on any two genuine nonempty opens preserves
the identical original function-field differential. -/
theorem schemeRationalDifferentialOpenIso_restriction
    (sX : X ⟶ Spec (.of k)) {U V : X.Opens} [Nonempty U] [Nonempty V]
    (i : V ⟶ U) :
    (schemeRationalDifferentialSheaf sX).val.map i.op ≫
        (schemeRationalDifferentialOpenIso sX V).hom =
      (schemeRationalDifferentialOpenIso sX U).hom := by
  classical
  have hV : genericPoint X ∈ V :=
    ((genericPoint_spec X).mem_open_set_iff V.isOpen).mpr
      (by simpa using (inferInstance : Nonempty V))
  simp only [schemeRationalDifferentialSheaf, skyscraperSheaf,
    skyscraperPresheaf_map, dif_pos hV, schemeRationalDifferentialOpenIso,
    eqToIso.hom, eqToHom_trans]

/-- The actual SHEAF section map to original rational differentials
on every nonempty open. -/
noncomputable def schemeDifferentialSheafOpenToFunctionField
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) [Nonempty U] :
    letI := (genericBaseFieldHom sX).toAlgebra
    (schemeDifferentialSheaf sX).val.presheaf.obj (Opposite.op U) ⟶
      AddCommGrpCat.of (KaehlerDifferential k X.functionField) :=
  (schemeDifferentialSheafToRational sX).app (Opposite.op U) ≫
    (schemeRationalDifferentialOpenIso sX U).hom

/-- The honest associated-sheaf generic map extends the literal
original universal differential map. -/
theorem schemeDifferentialSheafOpenToFunctionField_presheaf
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) [Nonempty U] :
    (CategoryTheory.toSheafify (Opens.grothendieckTopology X)
      (schemeDifferentialPresheaf sX).presheaf).app (Opposite.op U) ≫
        schemeDifferentialSheafOpenToFunctionField sX U =
      schemeDifferentialOpenToFunctionField sX U := by
  unfold schemeDifferentialSheafOpenToFunctionField
  rw [← Category.assoc]
  have h := NatTrans.congr_app
    (schemeDifferentialSheafToRational_presheaf_compatibility sX) (Opposite.op U)
  dsimp only [NatTrans.comp_app] at h
  rw [h]
  exact schemeDifferentialPresheafToRational_open sX U

/-- Genuine differential SHEAF restrictions preserve the original
rational image on every nonempty open. -/
theorem schemeDifferentialSheafOpenToFunctionField_restriction
    (sX : X ⟶ Spec (.of k)) {U V : X.Opens} [Nonempty U] [Nonempty V]
    (i : V ⟶ U) :
    (schemeDifferentialSheaf sX).val.presheaf.map i.op ≫
        schemeDifferentialSheafOpenToFunctionField sX V =
      schemeDifferentialSheafOpenToFunctionField sX U := by
  unfold schemeDifferentialSheafOpenToFunctionField
  rw [← Category.assoc, (schemeDifferentialSheafToRational sX).naturality]
  rw [Category.assoc, schemeRationalDifferentialOpenIso_restriction]

/-- Every actual differential SHEAF section maps into the original
stalk differential image at EVERY point of its original open. No
smoothness, properness or rational-lattice H0 identification is assumed. -/
theorem schemeDifferentialSheafOpenToFunctionField_mem_local
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) [Nonempty U] (x : U) :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : (schemeDifferentialSheaf sX).val.presheaf.obj (Opposite.op U),
      schemeDifferentialSheafOpenToFunctionField sX U omega ∈
        schemeLocalRegularDifferentials sX x := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega
  obtain ⟨V, i, hxV, a, equality⟩ :=
    schemeDifferentialSheaf_local_representative sX U omega x x.property
  letI : Nonempty V := ⟨⟨x, hxV⟩⟩
  have restriction :
      schemeDifferentialSheafOpenToFunctionField sX V
        ((schemeDifferentialSheaf sX).val.presheaf.map i.op omega) =
      schemeDifferentialSheafOpenToFunctionField sX U omega :=
    congrArg (fun f => f.hom omega)
      (schemeDifferentialSheafOpenToFunctionField_restriction sX i)
  have original :
      schemeDifferentialSheafOpenToFunctionField sX V
        ((CategoryTheory.toSheafify (Opens.grothendieckTopology X)
          (schemeDifferentialPresheaf sX).presheaf).app (Opposite.op V) a) =
      schemeDifferentialOpenToFunctionField sX V a :=
    congrArg (fun f => f.hom a)
      (schemeDifferentialSheafOpenToFunctionField_presheaf sX V)
  rw [← restriction, ← equality, original]
  exact schemeDifferentialOpenToFunctionField_mem_local sX V ⟨x, hxV⟩ a

/-- Genuine H0 of the actual differential sheaf maps into the full
intersection of ORIGINAL closed-stalk differential lattices. -/
theorem schemeDifferentialGlobalSections_mem_regular
    (sX : X ⟶ Spec (.of k)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI : Nonempty (⊤ : X.Opens) := ⟨⟨genericPoint X, trivial⟩⟩
    ∀ omega : schemeDifferentialGlobalSections sX,
      schemeDifferentialSheafOpenToFunctionField sX ⊤ omega ∈
        schemeGlobalRegularDifferentials sX := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : Nonempty (⊤ : X.Opens) := ⟨⟨genericPoint X, trivial⟩⟩
  intro omega
  change schemeDifferentialSheafOpenToFunctionField sX ⊤ omega ∈
    ⨅ x : ClosedPoint X, schemeLocalRegularDifferentials sX x.val
  rw [Submodule.mem_iInf]
  intro x
  exact schemeDifferentialSheafOpenToFunctionField_mem_local sX ⊤
    ⟨x.val, trivial⟩ omega

end Litt3.SharedTensors
