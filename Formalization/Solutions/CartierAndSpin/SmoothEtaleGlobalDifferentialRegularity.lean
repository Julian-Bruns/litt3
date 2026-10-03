import Solutions.CartierAndSpin.SmoothEtaleDifferentialRegularity
import Solutions.SharedTensors.ClosedPointSurjectivity

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]

/-- An actual finite etale surjective map of smooth integral curves
reflects and preserves regularity at ALL original closed points.
Surjectivity on closed points is derived from the genuine source being
Jacobson. No properness, characteristic, or H0 identification is used. -/
theorem actual_smooth_etale_global_rational_differential_regular_iff
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
    (f : X ⟶ Y) [IsFinite f] [IsEtale f] [Surjective f]
    (hover : f ≫ sY = sX) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    ∀ omega : KaehlerDifferential k Y.functionField,
      KaehlerDifferential.map k k Y.functionField X.functionField omega ∈
          schemeGlobalRegularDifferentials sX ↔
        omega ∈ schemeGlobalRegularDifferentials sY := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : JacobsonSpace X := LocallyOfFiniteType.jacobsonSpace sX
  intro omega
  rw [mem_schemeGlobalRegularDifferentials_iff, mem_schemeGlobalRegularDifferentials_iff]
  constructor
  · intro h y
    obtain ⟨x, hx⟩ := mapClosedPoint_surjective f y
    have hlocal := (actual_smooth_etale_rational_differential_regular_iff
      sX sY f hover x omega).mp (h x)
    have hpoint : f x.val = y.val := congrArg Subtype.val hx
    rwa [hpoint] at hlocal
  · intro h x
    apply (actual_smooth_etale_rational_differential_regular_iff
      sX sY f hover x omega).mpr
    exact h (mapClosedPoint f x)

end Litt3.CartierAndSpin
