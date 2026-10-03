import Solutions.CartierAndSpin.SharedGlobalDifferentialRealization

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

/-- Once ORIGINAL shared rational regularity has been proved, genuine
shared sheaf H0 is linearly equivalent to BOTH original rational images.
Its scalar action is ORIGINAL, and the map is true generic realization. -/
noncomputable def actualSharedGlobalRationalEquivOfRegular :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    sharedRationalDifferentialSubspace k X.functionField Y.functionField
        s.source.functionField ≤ schemeGlobalRegularDifferentials (s.left ≫ sX) →
      actualSharedGlobalDifferentialSubspace s sX sY hbase ≃ₗ[k]
        sharedRationalDifferentialSubspace k X.functionField Y.functionField
          s.source.functionField := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
  letI := (schemeFunctionFieldPullback s.left).toAlgebra
  letI := (schemeFunctionFieldPullback s.right).toAlgebra
  letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
  letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
  intro hregular
  exact LinearEquiv.ofBijective (sharedGlobalDifferentialRationalRealization s sX sY hbase)
    ⟨sharedGlobalDifferentialRationalRealization_injective s sX sY hbase,
      sharedGlobalDifferentialRationalRealization_surjective_of_regular s sX sY hbase hregular⟩

/-- The equivalence is the literal original generic realization, with
no action transported to the true H0 module. -/
theorem actualSharedGlobalRationalEquivOfRegular_apply :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    ∀ (hregular : sharedRationalDifferentialSubspace k X.functionField Y.functionField
      s.source.functionField ≤ schemeGlobalRegularDifferentials (s.left ≫ sX))
      (a : actualSharedGlobalDifferentialSubspace s sX sY hbase),
      (actualSharedGlobalRationalEquivOfRegular s sX sY hbase hregular a).val =
        schemeDifferentialGlobalSectionsToFunctionField (s.left ≫ sX) a.val := by
  intros
  rfl

end Litt3.CartierAndSpin
