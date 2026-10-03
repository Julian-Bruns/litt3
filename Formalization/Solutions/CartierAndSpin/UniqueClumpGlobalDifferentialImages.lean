import Solutions.CartierAndSpin.SharedGlobalDifferentialImages
import Solutions.CartierAndSpin.UniqueClumpSharedDifferentialRegularity

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

/-- The shared rational space is EXACTLY the rational realization of
the literal intersection of BOTH genuine endpoint H0 images in the SAME
source H0, under actual at-most-one-clump and ONE genuine H0 rank≥2.
There is no supplied regularity or H0 identification premise. -/
theorem actual_at_most_one_clump_shared_global_image_eq_rational
    (hunique : ∀ c d : s.fiberClump, c.left = d.left)
    (hdimension : 2 ≤ Module.rank k (schemeDifferentialGlobalSections sX)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
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
  exact actual_shared_global_differential_image_eq_of_regular s sX sY hbase
    (actual_at_most_one_clump_shared_rational_differentials_regular
      s sX sY hbase hunique hdimension)

end Litt3.CartierAndSpin
