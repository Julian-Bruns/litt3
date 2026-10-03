import Solutions.Jacobians.ActualSchemeModulePullbacks
import Solutions.Jacobians.RationalFunctionOpenLinearEquivalence
import Solutions.Jacobians.RationalFunctionOpenValues
import Solutions.QuotientGeometry.FunctionFieldChartTowers

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (f : X ⟶ Y) [Surjective f]

/-- ANY actual surjective scheme morphism has a genuine nonempty
inverse image of EVERY nonempty original open. -/
theorem actualSchemeNonemptyPreimageOpen (U : Y.Opens) [Nonempty U] :
    Nonempty (f ⁻¹ᵁ U) := by
  let y : U := Classical.arbitrary U
  obtain ⟨x, hx⟩ := f.surjective y.val
  exact ⟨⟨x, by change f x ∈ U; rw [hx]; exact y.property⟩⟩

/-- Genuine original rational-section pullback through the ACTUAL
generic-stalk field map and the full ORIGINAL rational-sheaf open isos. -/
noncomputable def actualSchemeRationalSectionPullback
    (U : Y.Opens) [Nonempty U] :
    (actualSchemeRationalFunctionRingSheaf Y).val.obj (op U) →+*
      (actualSchemeRationalFunctionRingSheaf X).val.obj (op (f ⁻¹ᵁ U)) := by
  letI := actualSchemeNonemptyPreimageOpen f U
  exact (actualSchemeRationalFunctionOpenIso X (f ⁻¹ᵁ U)).commRingCatIsoToRingEquiv.symm.toRingHom.comp
    ((Litt3.SharedTensors.schemeFunctionFieldPullback f).comp
      (actualSchemeRationalFunctionOpenIso Y U).commRingCatIsoToRingEquiv.toRingHom)

/-- The FULL rational value of every pulled original section is
its actual ORIGINAL generic-stalk pullback. -/
theorem actualSchemeRationalSectionPullback_field_value
    (U : Y.Opens) [Nonempty U]
    (a : (actualSchemeRationalFunctionRingSheaf Y).val.obj (op U)) :
    letI := actualSchemeNonemptyPreimageOpen f U
    actualRationalFunctionOpenLinearEquiv X (f ⁻¹ᵁ U)
        (actualSchemeRationalSectionPullback f U a) =
      Litt3.SharedTensors.schemeFunctionFieldPullback f
        (actualRationalFunctionOpenLinearEquiv Y U a) := by
  letI := actualSchemeNonemptyPreimageOpen f U
  exact (actualSchemeRationalFunctionOpenIso X (f ⁻¹ᵁ U)).commRingCatIsoToRingEquiv.apply_symm_apply _

/-- The literal original rational pullback is semilinear through
the ACTUAL structure-sheaf pullback on the full ORIGINAL open rings. -/
theorem actualSchemeRationalSectionPullback_smul
    (U : Y.Opens) [Nonempty U] (r : Γ(Y, U))
    (a : (actualSchemeRationalFunctionModuleSheaf Y).val.obj (op U)) :
    actualSchemeRationalSectionPullback f U (r • a) =
      (actualSchemeStructureToRationalFunctions X).val.app (op (f ⁻¹ᵁ U))
        (f.app U r) * actualSchemeRationalSectionPullback f U a := by
  letI := actualSchemeNonemptyPreimageOpen f U
  apply (actualSchemeRationalFunctionOpenIso X (f ⁻¹ᵁ U)).commRingCatIsoToRingEquiv.injective
  rw [map_mul]
  have hstructure := CategoryTheory.congr_fun
    (actualSchemeStructureToRationalFunctions_open X (f ⁻¹ᵁ U)) (f.app U r)
  change (actualSchemeRationalFunctionOpenIso X (f ⁻¹ᵁ U)).commRingCatIsoToRingEquiv
      ((actualSchemeStructureToRationalFunctions X).val.app (op (f ⁻¹ᵁ U)) (f.app U r)) =
    algebraMap Γ(X, f ⁻¹ᵁ U) X.functionField (f.app U r) at hstructure
  rw [hstructure]
  change actualRationalFunctionOpenLinearEquiv X (f ⁻¹ᵁ U)
      (actualSchemeRationalSectionPullback f U (r • a)) =
    algebraMap Γ(X, f ⁻¹ᵁ U) X.functionField (f.app U r) *
      actualRationalFunctionOpenLinearEquiv X (f ⁻¹ᵁ U)
        (actualSchemeRationalSectionPullback f U a)
  rw [actualSchemeRationalSectionPullback_field_value,
    (actualRationalFunctionOpenLinearEquiv Y U).map_smul r a]
  change Litt3.SharedTensors.schemeFunctionFieldPullback f
      (algebraMap Γ(Y, U) Y.functionField r * actualRationalFunctionOpenLinearEquiv Y U a) = _
  rw [map_mul, actualSchemeRationalSectionPullback_field_value]
  have h := RingHom.congr_fun
    (Litt3.QuotientGeometry.actual_function_field_pullback_chart f U) r
  change Litt3.SharedTensors.schemeFunctionFieldPullback f
      (algebraMap Γ(Y, U) Y.functionField r) =
    algebraMap Γ(X, f ⁻¹ᵁ U) X.functionField (f.app U r) at h
  rw [h]

/-- Original rational-section pullback commutes with ALL actual
nonempty ORIGINAL open restrictions on BOTH schemes. -/
theorem actualSchemeRationalSectionPullback_restriction
    {U V : Y.Opens} [Nonempty U] [Nonempty V] (i : V ⟶ U)
    (a : (actualSchemeRationalFunctionRingSheaf Y).val.obj (op U)) :
    actualSchemeRationalSectionPullback f V
        ((actualSchemeRationalFunctionRingSheaf Y).val.map i.op a) =
      (actualSchemeRationalFunctionRingSheaf X).val.map
        ((Opens.map f.base).map i).op (actualSchemeRationalSectionPullback f U a) := by
  letI := actualSchemeNonemptyPreimageOpen f U
  letI := actualSchemeNonemptyPreimageOpen f V
  apply (actualRationalFunctionOpenLinearEquiv X (f ⁻¹ᵁ V)).injective
  rw [actualSchemeRationalSectionPullback_field_value]
  have hY := actualRationalFunctionOpenValue_restriction Y i a
  have hX := actualRationalFunctionOpenValue_restriction X
    ((Opens.map f.base).map i) (actualSchemeRationalSectionPullback f U a)
  change actualRationalFunctionOpenLinearEquiv Y V
      ((actualSchemeRationalFunctionRingSheaf Y).val.map i.op a) =
    actualRationalFunctionOpenLinearEquiv Y U a at hY
  change actualRationalFunctionOpenLinearEquiv X (f ⁻¹ᵁ V)
      ((actualSchemeRationalFunctionRingSheaf X).val.map
        ((Opens.map f.base).map i).op (actualSchemeRationalSectionPullback f U a)) =
    actualRationalFunctionOpenLinearEquiv X (f ⁻¹ᵁ U)
      (actualSchemeRationalSectionPullback f U a) at hX
  rw [hY, hX, actualSchemeRationalSectionPullback_field_value]

end Litt3.Jacobians
