import Solutions.SharedTensors.SchemeDifferentialGlobalLinearEquivalence
import Solutions.SharedTensors.SmoothCurveCartier

open CategoryTheory AlgebraicGeometry

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 200000

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [PerfectField k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X] {p : ℕ} [Fact p.Prime] [CharP k p]

/-- Actual intrinsic Cartier on genuine global sections of the ORIGINAL
associated differential sheaf. Original local regularity and actual H0
recovery construct this restriction. No Cartier preservation or H0 model
identification is an input. -/
noncomputable def actualSmoothCurveSheafGlobalCartier
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    schemeDifferentialGlobalSections sX →+ schemeDifferentialGlobalSections sX := by
  letI := (genericBaseFieldHom sX).toAlgebra
  let e := schemeDifferentialGlobalSectionsRegularEquiv sX 1
  exact e.symm.toLinearMap.toAddMonoidHom.comp
    ((actualSmoothCurveGlobalCartier (p := p) sX).comp e.toLinearMap.toAddMonoidHom)

theorem actualSmoothCurveSheafGlobalCartier_intertwines
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ a : schemeDifferentialGlobalSections sX,
      schemeDifferentialGlobalSectionsRegularEquiv sX 1
          (actualSmoothCurveSheafGlobalCartier (p := p) sX a) =
        actualSmoothCurveGlobalCartier (p := p) sX
          (schemeDifferentialGlobalSectionsRegularEquiv sX 1 a) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro a
  exact (schemeDifferentialGlobalSectionsRegularEquiv sX 1).apply_symm_apply _

/-- Cartier on true H0 is inverse p-semilinear for the ORIGINAL
coefficient action, not an action transported from rational forms. -/
theorem actualSmoothCurveSheafGlobalCartier_pth_semilinear
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (c : k) (a : schemeDifferentialGlobalSections sX) :
    actualSmoothCurveSheafGlobalCartier (p := p) sX (c ^ p • a) =
      c • actualSmoothCurveSheafGlobalCartier (p := p) sX a := by
  letI := (genericBaseFieldHom sX).toAlgebra
  apply (schemeDifferentialGlobalSectionsRegularEquiv sX 1).injective
  rw [actualSmoothCurveSheafGlobalCartier_intertwines, map_smul,
    actualSmoothCurveGlobalCartier_pth_semilinear, map_smul,
    actualSmoothCurveSheafGlobalCartier_intertwines]

/-- A true global differential SHEAF section is killed by Cartier
exactly when its original rational realization is the differential of
an actual rational function. That primitive need not be globally regular. -/
theorem actualSmoothCurveSheafGlobalCartier_zero_iff_rational_exact
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI : Nonempty (⊤ : X.Opens) := ⟨⟨genericPoint X, trivial⟩⟩
    ∀ a : schemeDifferentialGlobalSections sX,
      actualSmoothCurveSheafGlobalCartier (p := p) sX a = 0 ↔
      ∃ f : X.functionField, KaehlerDifferential.D k X.functionField f =
        schemeDifferentialSheafOpenToFunctionField sX ⊤ a := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : Nonempty (⊤ : X.Opens) := ⟨⟨genericPoint X, trivial⟩⟩
  intro a
  rw [← (schemeDifferentialGlobalSectionsRegularEquiv sX 1).map_eq_zero_iff,
    actualSmoothCurveSheafGlobalCartier_intertwines,
    actualSmoothCurveGlobalCartier_zero_iff_rational_exact,
    schemeDifferentialGlobalSectionsRegularEquiv_apply]

end Litt3.SharedTensors
