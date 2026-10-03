import Solutions.Jacobians.AffineDivisorTensorMultiplicationBijective
import Solutions.Jacobians.SchemeAffineModuleLocalBijectivity
import Solutions.Jacobians.SmoothCurveAffineDivisorTensorSections

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- The LITERAL original divisor-tensor multiplication is genuinely
locally bijective on the ENTIRE original scheme site. The affine basis,
every original affine tensor bijection and all DVR/Dedekind/valuation
inputs are derived from the actual smooth integral curve, in ANY
characteristic, with no quasi-compactness/properness or frame premise. -/
theorem actual_smooth_curve_divisor_tensor_locally_bijective
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    PresheafOfModules.IsLocallyInjective (Opens.grothendieckTopology X)
      (actualDivisorSheafTensorPresheafMultiply X D E) ∧
    PresheafOfModules.IsLocallySurjective (Opens.grothendieckTopology X)
      (actualDivisorSheafTensorPresheafMultiply X D E) := by
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : JacobsonSpace X := LocallyOfFiniteType.jacobsonSpace sX
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  let f := actualDivisorSheafTensorPresheafMultiply X D E
  have h : ∀ U : X.Opens, IsAffineOpen U → Nonempty U →
      Function.Bijective ((f.app (op U)).hom) := by
    intro U hU hnonempty
    letI : Nonempty U := hnonempty
    letI : IsDedekindDomain Γ(X, U) :=
      Litt3.QuotientGeometry.actual_smooth_curve_affine_chart_dedekind sX U hU
    exact actualDivisorTensorOpenMultiply_affine_bijective hU
      (Litt3.SharedTensors.actual_smooth_curve_affine_chart_not_isField sX U hU) D E
  exact ⟨actualSchemeModule_affine_locally_injective X f h,
    actualSchemeModule_affine_locally_surjective X f h⟩

end Litt3.Jacobians
