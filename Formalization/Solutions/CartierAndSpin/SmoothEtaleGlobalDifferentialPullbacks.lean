import Solutions.CartierAndSpin.SmoothEtaleGlobalDifferentialRegularity
import Solutions.SharedTensors.SchemeDifferentialGlobalLinearEquivalence

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (f : X ⟶ Y) [IsFinite f] [IsEtale f] [Surjective f]
  (hover : f ≫ sY = sX)

/-- A genuine linear map between the ORIGINAL global differential
sheaf modules. Its value is constructed by proved regularity and
actual sheaf gluing; the coefficient-field actions are original. -/
noncomputable def actualSmoothEtaleGlobalDifferentialPullback :
    schemeDifferentialGlobalSections sY →ₗ[k]
      schemeDifferentialGlobalSections sX := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  let g := (KaehlerDifferential.map k k Y.functionField X.functionField).restrictScalars k
  let r := (g.comp (schemeDifferentialGlobalSectionsToFunctionField sY)).codRestrict
    (schemeGlobalRegularDifferentials sX) (by
      intro a
      exact (actual_smooth_etale_global_rational_differential_regular_iff
        sX sY f hover _).mpr (schemeDifferentialGlobalSections_mem_regular sY a))
  exact (schemeDifferentialGlobalSectionsRegularEquiv sX 1).symm.toLinearMap.comp r

/-- The genuine H0 pullback realizes exactly the ORIGINAL universal
differential map on original rational images. No H0 image is supplied. -/
theorem actualSmoothEtaleGlobalDifferentialPullback_rational
    : letI := (genericBaseFieldHom sX).toAlgebra
      letI := (genericBaseFieldHom sY).toAlgebra
      letI := (schemeFunctionFieldPullback f).toAlgebra
      letI := actualFunctionFieldBaseTower f sY sX hover
      ∀ a : schemeDifferentialGlobalSections sY,
        schemeDifferentialGlobalSectionsToFunctionField sX
            (actualSmoothEtaleGlobalDifferentialPullback sX sY f hover a) =
          KaehlerDifferential.map k k Y.functionField X.functionField
            (schemeDifferentialGlobalSectionsToFunctionField sY a) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  intro a
  change (schemeDifferentialGlobalSectionsRegularEquiv sX 1
      ((schemeDifferentialGlobalSectionsRegularEquiv sX 1).symm _)).val = _
  rw [LinearEquiv.apply_symm_apply]
  rfl

end Litt3.CartierAndSpin
