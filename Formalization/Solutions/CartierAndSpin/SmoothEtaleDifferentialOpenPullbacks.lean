import Solutions.CartierAndSpin.SmoothEtaleDifferentialDivisors
import Solutions.CartierAndSpin.SchemeDifferentialPresheafPullbacks
import Solutions.SharedTensors.SchemeDifferentialOpenRecovery
import Solutions.SharedTensors.SchemeDifferentialSheafLinearity
import Solutions.SharedTensors.ClosedPointSurjectivity
import Solutions.Jacobians.OriginalModuleSheafEmptySections

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

/-- Original closed-stalk regularity on EVERY actual preimage open
is reflected and preserved by the literal universal rational pullback. -/
theorem actual_smooth_etale_differential_regular_on_preimage_iff (U : Y.Opens) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    ∀ omega : KaehlerDifferential k Y.functionField,
      (∀ x : ClosedPoint X, x.val ∈ f ⁻¹ᵁ U →
        KaehlerDifferential.map k k Y.functionField X.functionField omega ∈
          schemeLocalRegularDifferentials sX x.val) ↔
      ∀ y : ClosedPoint Y, y.val ∈ U → omega ∈ schemeLocalRegularDifferentials sY y.val := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : JacobsonSpace X := LocallyOfFiniteType.jacobsonSpace sX
  intro omega
  constructor
  · intro h y hy
    obtain ⟨x, hx⟩ := mapClosedPoint_surjective f y
    have hpoint : f x.val = y.val := congrArg Subtype.val hx
    have hpre : x.val ∈ f ⁻¹ᵁ U := by change f x.val ∈ U; rw [hpoint]; exact hy
    have hr := (actual_smooth_etale_rational_differential_regular_iff
      sX sY f hover x omega).mp (h x hpre)
    rwa [hpoint] at hr
  · intro h x hx
    exact (actual_smooth_etale_rational_differential_regular_iff sX sY f hover x omega).mpr
      (h (mapClosedPoint f x) hx)

/-- Existence of an ORIGINAL differential SHEAF section on the whole
preimage open is exactly existence on the target open for an ORIGINAL
rational form. Both implications follow from original stalk recovery. -/
theorem actual_smooth_etale_differential_sections_on_preimage_iff
    (U : Y.Opens) [Nonempty U] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    letI := actualSchemeNonemptyPreimageOpen f U
    ∀ omega : KaehlerDifferential k Y.functionField,
      (∃ b : (schemeDifferentialSheaf sX).val.obj (op (f ⁻¹ᵁ U)),
        schemeDifferentialSheafOpenToFunctionField sX (f ⁻¹ᵁ U) b =
          KaehlerDifferential.map k k Y.functionField X.functionField omega) ↔
      ∃ a : (schemeDifferentialSheaf sY).val.obj (op U),
        schemeDifferentialSheafOpenToFunctionField sY U a = omega := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  letI := actualSchemeNonemptyPreimageOpen f U
  intro omega
  rw [← schemeDifferential_closed_regular_on_open_iff_section sX 1 (f ⁻¹ᵁ U),
    ← schemeDifferential_closed_regular_on_open_iff_section sY 1 U]
  exact actual_smooth_etale_differential_regular_on_preimage_iff sX sY f hover U omega

theorem actual_smooth_etale_differential_section_pullback_exists
    (U : Y.Opens) [Nonempty U] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    letI := actualSchemeNonemptyPreimageOpen f U
    ∀ a : (schemeDifferentialSheaf sY).val.obj (op U),
      ∃ b : (schemeDifferentialSheaf sX).val.obj (op (f ⁻¹ᵁ U)),
        schemeDifferentialSheafOpenToFunctionField sX (f ⁻¹ᵁ U) b =
          KaehlerDifferential.map k k Y.functionField X.functionField
            (schemeDifferentialSheafOpenToFunctionField sY U a) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  letI := actualSchemeNonemptyPreimageOpen f U
  intro a
  exact (actual_smooth_etale_differential_sections_on_preimage_iff sX sY f hover U _).mpr
    ⟨a, rfl⟩

/-- On a nonempty open, the unique ORIGINAL recovered section of the
literal rational pullback. Its uniqueness proves additivity. -/
noncomputable def actualSmoothEtaleDifferentialNonemptyOpenPullback
    (U : Y.Opens) [Nonempty U] :
    (schemeDifferentialSheaf sY).val.obj (op U) →+
      (schemeDifferentialSheaf sX).val.obj (op (f ⁻¹ᵁ U)) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  letI := actualSchemeNonemptyPreimageOpen f U
  let g (a : (schemeDifferentialSheaf sY).val.obj (op U)) :=
    Classical.choose (actual_smooth_etale_differential_section_pullback_exists sX sY f hover U a)
  have hg (a : (schemeDifferentialSheaf sY).val.obj (op U)) :
      schemeDifferentialSheafOpenToFunctionField sX (f ⁻¹ᵁ U) (g a) =
        KaehlerDifferential.map k k Y.functionField X.functionField
          (schemeDifferentialSheafOpenToFunctionField sY U a) :=
    Classical.choose_spec (actual_smooth_etale_differential_section_pullback_exists
      sX sY f hover U a)
  exact
    { toFun := g
      map_zero' := by
        apply schemeDifferentialSheafOpenToFunctionField_injective sX 1 (f ⁻¹ᵁ U)
        rw [hg, map_zero, map_zero, map_zero]
      map_add' := by
        intro a b
        apply schemeDifferentialSheafOpenToFunctionField_injective sX 1 (f ⁻¹ᵁ U)
        rw [hg, map_add, map_add, map_add, hg, hg] }

/-- The ORIGINAL section pullback on EVERY open. On an empty open it
is the true zero section; on a nonempty open original gluing and the
literal actual rational pullback construct its unique value. -/
noncomputable def actualSmoothEtaleDifferentialOpenPullback (U : Y.Opens) :
    (schemeDifferentialSheaf sY).val.obj (op U) →+
      (schemeDifferentialSheaf sX).val.obj (op (f ⁻¹ᵁ U)) := by
  classical
  exact if hU : Nonempty U then
    letI := hU
    actualSmoothEtaleDifferentialNonemptyOpenPullback sX sY f hover U
    else 0

theorem actualSmoothEtaleDifferentialOpenPullback_rational
    (U : Y.Opens) [Nonempty U] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    letI := actualSchemeNonemptyPreimageOpen f U
    ∀ a : (schemeDifferentialSheaf sY).val.obj (op U),
      schemeDifferentialSheafOpenToFunctionField sX (f ⁻¹ᵁ U)
          (actualSmoothEtaleDifferentialOpenPullback sX sY f hover U a) =
        KaehlerDifferential.map k k Y.functionField X.functionField
          (schemeDifferentialSheafOpenToFunctionField sY U a) := by
  classical
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  letI := actualSchemeNonemptyPreimageOpen f U
  intro a
  simp only [actualSmoothEtaleDifferentialOpenPullback,
    dif_pos (inferInstance : Nonempty U)]
  exact Classical.choose_spec (actual_smooth_etale_differential_section_pullback_exists
    sX sY f hover U a)

/-- EVERY original restriction square commutes, including restriction
to the empty open. Both maps are the actual original sheaf restrictions. -/
theorem actualSmoothEtaleDifferentialOpenPullback_restriction
    {U V : Y.Opens} (i : V ⟶ U)
    (a : (schemeDifferentialSheaf sY).val.obj (op U)) :
    actualSmoothEtaleDifferentialOpenPullback sX sY f hover V
        ((schemeDifferentialSheaf sY).val.map i.op a) =
      (schemeDifferentialSheaf sX).val.map ((Opens.map f.base).map i).op
        (actualSmoothEtaleDifferentialOpenPullback sX sY f hover U a) := by
  classical
  by_cases hV : Nonempty V
  · letI := hV
    let y : V := Classical.arbitrary V
    letI : Nonempty U := ⟨⟨y.val, i.le y.property⟩⟩
    letI := actualSchemeNonemptyPreimageOpen f U
    letI := actualSchemeNonemptyPreimageOpen f V
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    apply schemeDifferentialSheafOpenToFunctionField_injective sX 1 (f ⁻¹ᵁ V)
    have hY := congrArg (fun g => g.hom a)
      (schemeDifferentialSheafOpenToFunctionField_restriction sY i)
    have hX := congrArg (fun g => g.hom
        (actualSmoothEtaleDifferentialOpenPullback sX sY f hover U a))
      (schemeDifferentialSheafOpenToFunctionField_restriction sX ((Opens.map f.base).map i))
    change schemeDifferentialSheafOpenToFunctionField sY V
      ((schemeDifferentialSheaf sY).val.map i.op a) =
        schemeDifferentialSheafOpenToFunctionField sY U a at hY
    change schemeDifferentialSheafOpenToFunctionField sX (f ⁻¹ᵁ V)
      ((schemeDifferentialSheaf sX).val.map ((Opens.map f.base).map i).op
        (actualSmoothEtaleDifferentialOpenPullback sX sY f hover U a)) =
      schemeDifferentialSheafOpenToFunctionField sX (f ⁻¹ᵁ U)
        (actualSmoothEtaleDifferentialOpenPullback sX sY f hover U a) at hX
    rw [actualSmoothEtaleDifferentialOpenPullback_rational, hY, hX,
      actualSmoothEtaleDifferentialOpenPullback_rational]
  · have hpre : ¬Nonempty (f ⁻¹ᵁ V) := by
      rintro ⟨x⟩
      exact hV ⟨⟨f x.val, x.property⟩⟩
    letI := actualOriginalModuleSheaf_empty_sections_subsingleton X
      (schemeDifferentialSheaf sX) (f ⁻¹ᵁ V) hpre
    exact Subsingleton.elim _ _

/-- The true original sheaf pullback agrees with the ENTIRE actual
universal differential PRESHEAF pullback after both original
sheafification units, on EVERY open including the empty one. -/
theorem actualSmoothEtaleDifferentialOpenPullback_presheaf
    (U : Y.Opens) (a : (schemeDifferentialPresheaf sY).obj (op U)) :
    actualSmoothEtaleDifferentialOpenPullback sX sY f hover U
        ((CategoryTheory.toSheafify (Opens.grothendieckTopology Y)
          (schemeDifferentialPresheaf sY).presheaf).app (op U) a) =
      (CategoryTheory.toSheafify (Opens.grothendieckTopology X)
        (schemeDifferentialPresheaf sX).presheaf).app (op (f ⁻¹ᵁ U))
        (actualSchemeDifferentialPresheafOpenPullback sX sY f hover U a) := by
  classical
  by_cases hU : Nonempty U
  · letI := hU
    letI := actualSchemeNonemptyPreimageOpen f U
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    apply schemeDifferentialSheafOpenToFunctionField_injective sX 1 (f ⁻¹ᵁ U)
    have hY := congrArg (fun g => g.hom a)
      (schemeDifferentialSheafOpenToFunctionField_presheaf sY U)
    have hX := congrArg (fun g => g.hom
        (actualSchemeDifferentialPresheafOpenPullback sX sY f hover U a))
      (schemeDifferentialSheafOpenToFunctionField_presheaf sX (f ⁻¹ᵁ U))
    change schemeDifferentialSheafOpenToFunctionField sY U
        ((CategoryTheory.toSheafify (Opens.grothendieckTopology Y)
          (schemeDifferentialPresheaf sY).presheaf).app (op U) a) =
      schemeDifferentialOpenToFunctionField sY U a at hY
    change schemeDifferentialSheafOpenToFunctionField sX (f ⁻¹ᵁ U)
        ((CategoryTheory.toSheafify (Opens.grothendieckTopology X)
          (schemeDifferentialPresheaf sX).presheaf).app (op (f ⁻¹ᵁ U))
          (actualSchemeDifferentialPresheafOpenPullback sX sY f hover U a)) =
      schemeDifferentialOpenToFunctionField sX (f ⁻¹ᵁ U)
        (actualSchemeDifferentialPresheafOpenPullback sX sY f hover U a) at hX
    rw [actualSmoothEtaleDifferentialOpenPullback_rational, hY, hX,
      actualSchemeDifferentialPresheafOpenPullback_rational]
  · have hpre : ¬Nonempty (f ⁻¹ᵁ U) := by
      rintro ⟨x⟩
      exact hU ⟨⟨f x.val, x.property⟩⟩
    letI := actualOriginalModuleSheaf_empty_sections_subsingleton X
      (schemeDifferentialSheaf sX) (f ⁻¹ᵁ U) hpre
    exact Subsingleton.elim _ _

end Litt3.CartierAndSpin
