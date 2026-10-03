import Definitions.CartierAndSpin.SharedGlobalDifferentialSubspaces

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

noncomputable local instance sourceTopNonempty : Nonempty (⊤ : s.source.Opens) :=
  ⟨⟨genericPoint s.source, trivial⟩⟩

noncomputable local instance leftTopNonempty : Nonempty (⊤ : X.Opens) :=
  ⟨⟨genericPoint X, trivial⟩⟩

noncomputable local instance rightTopNonempty : Nonempty (⊤ : Y.Opens) :=
  ⟨⟨genericPoint Y, trivial⟩⟩

/-- A genuine shared source H0 section realizes a shared ORIGINAL
rational form through BOTH original endpoint maps. No clump or
regularity hypothesis is required for this direction. -/
theorem actual_shared_global_differential_rational_image_mem :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    ∀ c : schemeDifferentialGlobalSections (s.left ≫ sX),
      c ∈ actualSharedGlobalDifferentialSubspace s sX sY hbase →
        schemeDifferentialGlobalSectionsToFunctionField (s.left ≫ sX) c ∈
          sharedRationalDifferentialSubspace k X.functionField Y.functionField
            s.source.functionField := by
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
  intro c hc
  obtain ⟨a, ha⟩ := hc.1
  obtain ⟨b, hb⟩ := hc.2
  constructor
  · refine ⟨schemeDifferentialGlobalSectionsToFunctionField sX a, ?_⟩
    change KaehlerDifferential.map k k X.functionField s.source.functionField _ = _
    rw [← actualSmoothEtaleGlobalDifferentialPullback_rational
      (s.left ≫ sX) sX s.left rfl, ha]
  · refine ⟨schemeDifferentialGlobalSectionsToFunctionField sY b, ?_⟩
    change KaehlerDifferential.map k k Y.functionField s.source.functionField _ = _
    rw [← actualSmoothEtaleGlobalDifferentialPullback_rational
      (s.left ≫ sX) sY s.right hbase, hb]

/-- When actual shared rational regularity has been established,
the genuine shared H0 image is EXACTLY the original shared rational
subspace. The reverse inclusion constructs source and endpoint sheaf
sections through actual gluing and original étale reflection. -/
theorem actual_shared_global_differential_image_eq_of_regular :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    sharedRationalDifferentialSubspace k X.functionField Y.functionField
        s.source.functionField ≤ schemeGlobalRegularDifferentials (s.left ≫ sX) →
      (actualSharedGlobalDifferentialSubspace s sX sY hbase).map
          (schemeDifferentialGlobalSectionsToFunctionField (s.left ≫ sX)) =
        sharedRationalDifferentialSubspace k X.functionField Y.functionField
          s.source.functionField := by
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
  intro hregular
  apply le_antisymm
  · rintro omega ⟨c, hc, rfl⟩
    exact actual_shared_global_differential_rational_image_mem s sX sY hbase c hc
  · intro omega hshared
    have hsource := hregular hshared
    obtain ⟨a, ha⟩ := hshared.1
    obtain ⟨b, hb⟩ := hshared.2
    change KaehlerDifferential.map k k X.functionField s.source.functionField a = omega at ha
    change KaehlerDifferential.map k k Y.functionField s.source.functionField b = omega at hb
    have hleft := (actual_smooth_etale_global_rational_differential_regular_iff
      (s.left ≫ sX) sX s.left rfl a).mp (ha ▸ hsource)
    have hright := (actual_smooth_etale_global_rational_differential_regular_iff
      (s.left ≫ sX) sY s.right hbase b).mp (hb ▸ hsource)
    obtain ⟨ca, hca⟩ := (schemeDifferential_closed_regular_iff_global_section sX 1 a).mp hleft
    obtain ⟨cb, hcb⟩ := (schemeDifferential_closed_regular_iff_global_section sY 1 b).mp hright
    obtain ⟨c, hc⟩ := (schemeDifferential_closed_regular_iff_global_section
      (s.left ≫ sX) 1 omega).mp hsource
    refine ⟨c, ?_, hc⟩
    constructor
    · refine ⟨ca, ?_⟩
      apply schemeDifferentialSheafOpenToFunctionField_injective (s.left ≫ sX) 1 ⊤
      change schemeDifferentialGlobalSectionsToFunctionField (s.left ≫ sX)
        (actualSmoothEtaleGlobalDifferentialPullback (s.left ≫ sX) sX s.left rfl ca) = _
      rw [actualSmoothEtaleGlobalDifferentialPullback_rational]
      change KaehlerDifferential.map k k X.functionField s.source.functionField
        (schemeDifferentialSheafOpenToFunctionField sX ⊤ ca) = _
      rw [hca, ha]
      exact hc.symm
    · refine ⟨cb, ?_⟩
      apply schemeDifferentialSheafOpenToFunctionField_injective (s.left ≫ sX) 1 ⊤
      change schemeDifferentialGlobalSectionsToFunctionField (s.left ≫ sX)
        (actualSmoothEtaleGlobalDifferentialPullback (s.left ≫ sX) sY s.right hbase cb) = _
      rw [actualSmoothEtaleGlobalDifferentialPullback_rational]
      change KaehlerDifferential.map k k Y.functionField s.source.functionField
        (schemeDifferentialSheafOpenToFunctionField sY ⊤ cb) = _
      rw [hcb, hb]
      exact hc.symm

end Litt3.CartierAndSpin
