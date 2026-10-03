import Definitions.CartierAndSpin.SchemeDifferentialPoles
import Solutions.CartierAndSpin.SmoothEtaleDifferentialRegularity

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

/-- The TRUE original pole set pulls back through the original finite
etale map. Polar-support equality is proved from actual universal-module
regularity reflection, with no characteristic or frame premise. -/
theorem actual_smooth_etale_differential_pole_set_pullback
    {k : Type u} [Field k] [IsAlgClosed k]
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
    (f : X ⟶ Y) [IsFinite f] [IsEtale f] [Surjective f]
    (hover : f ≫ sY = sX) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    ∀ omega : KaehlerDifferential k Y.functionField,
      schemeDifferentialPoleSet sX
          (KaehlerDifferential.map k k Y.functionField X.functionField omega) =
        (mapClosedPoint f) ⁻¹' schemeDifferentialPoleSet sY omega := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  intro omega
  ext x
  change (KaehlerDifferential.map k k Y.functionField X.functionField omega ∉
    schemeLocalRegularDifferentials sX x.val) ↔
      (omega ∉ schemeLocalRegularDifferentials sY (f x.val))
  exact not_congr (actual_smooth_etale_rational_differential_regular_iff
    sX sY f hover x omega)

end Litt3.CartierAndSpin
