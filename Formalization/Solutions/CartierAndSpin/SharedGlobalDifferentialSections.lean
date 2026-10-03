import Solutions.CartierAndSpin.SharedEndpointDifferentialRegularity
import Solutions.SharedTensors.SchemeDifferentialClosedRecovery

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [IsProper sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY] [IsProper sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)

noncomputable local instance endpointLeftTopNonempty : Nonempty (⊤ : X.Opens) :=
  ⟨⟨genericPoint X, trivial⟩⟩
noncomputable local instance endpointRightTopNonempty : Nonempty (⊤ : Y.Opens) :=
  ⟨⟨genericPoint Y, trivial⟩⟩
noncomputable local instance commonSourceTopNonempty : Nonempty (⊤ : s.source.Opens) :=
  ⟨⟨genericPoint s.source, trivial⟩⟩

/-- Under literal absence of a finite clump, the ACTUAL shared rational
one-forms are exactly the shared rational images of ACTUAL endpoint
global sections of their ORIGINAL associated differential sheaves.
The global sections are constructed from the true stalk images. -/
theorem actual_no_clump_shared_rational_iff_global_endpoint_sections
    (hno : IsEmpty s.fiberClump) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    ∀ omega : KaehlerDifferential k s.source.functionField,
      omega ∈ sharedRationalDifferentialSubspace k X.functionField Y.functionField
          s.source.functionField ↔
        ∃ (a : schemeDifferentialGlobalSections sX)
          (b : schemeDifferentialGlobalSections sY),
          KaehlerDifferential.map k k X.functionField s.source.functionField
              (schemeDifferentialSheafOpenToFunctionField sX ⊤ a) = omega ∧
            KaehlerDifferential.map k k Y.functionField s.source.functionField
              (schemeDifferentialSheafOpenToFunctionField sY ⊤ b) = omega := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
  letI := (schemeFunctionFieldPullback s.left).toAlgebra
  letI := (schemeFunctionFieldPullback s.right).toAlgebra
  letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
  letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
  intro omega
  constructor
  · intro hshared
    obtain ⟨alpha, halpha⟩ := hshared.1
    obtain ⟨beta, hbeta⟩ := hshared.2
    change KaehlerDifferential.map k k X.functionField s.source.functionField alpha = omega at halpha
    change KaehlerDifferential.map k k Y.functionField s.source.functionField beta = omega at hbeta
    obtain ⟨hleft, hright⟩ := actual_no_clump_shared_endpoint_differentials_regular
      s sX sY hbase hno alpha beta (halpha.trans hbeta.symm)
    obtain ⟨a, ha⟩ := (schemeDifferential_closed_regular_iff_global_section sX 1 alpha).mp hleft
    obtain ⟨b, hb⟩ := (schemeDifferential_closed_regular_iff_global_section sY 1 beta).mp hright
    exact ⟨a, b, ha ▸ halpha, hb ▸ hbeta⟩
  · rintro ⟨a, b, ha, hb⟩
    exact ⟨⟨schemeDifferentialSheafOpenToFunctionField sX ⊤ a, ha⟩,
      ⟨schemeDifferentialSheafOpenToFunctionField sY ⊤ b, hb⟩⟩

/-- The same shared rational form is also the rational image of an
ACTUAL global differential sheaf section on the SAME original source.
This is a genuine H0 realization, not a definition by stalk intersection. -/
theorem actual_no_clump_shared_rational_has_source_global_section
    (hno : IsEmpty s.fiberClump) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    ∀ omega : KaehlerDifferential k s.source.functionField,
      omega ∈ sharedRationalDifferentialSubspace k X.functionField Y.functionField
          s.source.functionField →
        ∃ c : schemeDifferentialGlobalSections (s.left ≫ sX),
          schemeDifferentialSheafOpenToFunctionField (s.left ≫ sX) ⊤ c = omega := by
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
  intro omega hshared
  apply (schemeDifferential_closed_regular_iff_global_section (s.left ≫ sX) 1 omega).mp
  exact actual_no_clump_shared_rational_differentials_regular s sX sY hbase hno hshared

end Litt3.CartierAndSpin
