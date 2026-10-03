import Definitions.QuotientGeometry.AffineChartFields

open AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

theorem affine_chart_function_field_equiv_section
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    {U : X.Opens} {V : Y.Opens} (hU : IsAffineOpen U) (hV : IsAffineOpen V)
    [Nonempty U] [Nonempty V] (e : Γ(Y, V) ≃+* Γ(X, U)) (a : Γ(Y, V)) :
    affineChartFunctionFieldEquiv hU hV e (algebraMap Γ(Y, V) Y.functionField a) =
      algebraMap Γ(X, U) X.functionField (e a) := by
  haveI := functionField_isFractionRing_of_isAffineOpen X U hU
  haveI := functionField_isFractionRing_of_isAffineOpen Y V hV
  exact IsFractionRing.ringEquivOfRingEquiv_algebraMap e a

theorem affine_chart_function_field_equiv_symm
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    {U : X.Opens} {V : Y.Opens} (hU : IsAffineOpen U) (hV : IsAffineOpen V)
    [Nonempty U] [Nonempty V] (e : Γ(Y, V) ≃+* Γ(X, U)) :
    (affineChartFunctionFieldEquiv hU hV e).symm =
      affineChartFunctionFieldEquiv hV hU e.symm := rfl

end Litt3.QuotientGeometry
