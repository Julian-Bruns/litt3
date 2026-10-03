import Solutions.CartierAndSpin.SharedGlobalDifferentialImages

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)

noncomputable local instance sharedRealizationTopNonempty : Nonempty (⊤ : s.source.Opens) :=
  ⟨⟨genericPoint s.source, trivial⟩⟩

/-- The ORIGINAL rational realization restricted to the literal
intersection of the two true H0 images. It is linear for the actual
coefficient action, and its values lie in BOTH true rational images. -/
noncomputable def sharedGlobalDifferentialRationalRealization :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    actualSharedGlobalDifferentialSubspace s sX sY hbase →ₗ[k]
      sharedRationalDifferentialSubspace k X.functionField Y.functionField
        s.source.functionField := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
  letI := (schemeFunctionFieldPullback s.left).toAlgebra
  letI := (schemeFunctionFieldPullback s.right).toAlgebra
  letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
  letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
  exact ((schemeDifferentialGlobalSectionsToFunctionField (s.left ≫ sX)).comp
    (actualSharedGlobalDifferentialSubspace s sX sY hbase).subtype).codRestrict
    (sharedRationalDifferentialSubspace k X.functionField Y.functionField
      s.source.functionField)
    (fun a => actual_shared_global_differential_rational_image_mem
      s sX sY hbase a.val a.property)

/-- Genuine shared H0 realization is injective without any clump,
properness, dimension or regularity hypothesis. -/
theorem sharedGlobalDifferentialRationalRealization_injective :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    Function.Injective (sharedGlobalDifferentialRationalRealization s sX sY hbase) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
  letI := (schemeFunctionFieldPullback s.left).toAlgebra
  letI := (schemeFunctionFieldPullback s.right).toAlgebra
  letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
  letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
  letI : IsSmoothOfRelativeDimension 1 (s.left ≫ sX) := by
    have h : IsSmoothOfRelativeDimension (0 + 1) (s.left ≫ sX) := inferInstance
    exact h
  intro a b h
  apply Subtype.ext
  apply schemeDifferentialSheafOpenToFunctionField_injective (s.left ≫ sX) 1 ⊤
  exact congrArg Subtype.val h

/-- A proved regularity theorem supplies surjectivity of the genuine
shared H0 realization. Its witnesses are true sheaf global sections. -/
theorem sharedGlobalDifferentialRationalRealization_surjective_of_regular :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    sharedRationalDifferentialSubspace k X.functionField Y.functionField
        s.source.functionField ≤ schemeGlobalRegularDifferentials (s.left ≫ sX) →
      Function.Surjective (sharedGlobalDifferentialRationalRealization s sX sY hbase) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
  letI := (schemeFunctionFieldPullback s.left).toAlgebra
  letI := (schemeFunctionFieldPullback s.right).toAlgebra
  letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
  letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
  intro hregular omega
  have hmem : omega.val ∈ (actualSharedGlobalDifferentialSubspace s sX sY hbase).map
      (schemeDifferentialGlobalSectionsToFunctionField (s.left ≫ sX)) := by
    rw [actual_shared_global_differential_image_eq_of_regular s sX sY hbase hregular]
    exact omega.property
  obtain ⟨c, hc, heq⟩ := hmem
  exact ⟨⟨c, hc⟩, Subtype.ext heq⟩

end Litt3.CartierAndSpin
