import Solutions.SharedTensors.SmoothLocalizationDVR
import Solutions.SharedTensors.SmoothSchemeLocalCharts
import Solutions.QuotientGeometry.AffineChartStalkCoefficients
import Solutions.QuotientGeometry.LocalCoefficientResidueTransport
import Solutions.QuotientGeometry.ClosedAffineResidueCoefficients
import Definitions.Jacobians.SchemeDivisors

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

include sX

/-- The actual coefficient field surjects onto the actual residue field
of every closed stalk, through the original structure morphism. -/
theorem actual_smooth_curve_closed_point_residue_surjective (x : ClosedPoint X) :
    letI := (stalkBaseFieldHom sX x.val).toAlgebra
    Function.Surjective
      (algebraMap k (IsLocalRing.ResidueField (X.presheaf.stalk x.val))) := by
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  obtain ⟨U, hU, hx, hs⟩ := actual_smooth_point_chart sX 1 x.val
  let xU : U := ⟨x.val, hx⟩
  letI : Nonempty U := ⟨xU⟩
  letI : Algebra k Γ(X, U) := (chartBaseFieldHom sX U).toAlgebra
  letI : Algebra.IsStandardSmoothOfRelativeDimension 1 k Γ(X, U) := hs
  letI : Algebra.IsStandardSmooth k Γ(X, U) :=
    Algebra.IsStandardSmoothOfRelativeDimension.isStandardSmooth 1
  letI : (hU.primeIdealOf xU).asIdeal.IsMaximal :=
    hU.primeIdealOf_isMaximal_of_isClosed xU x.property
  exact actual_local_algEquiv_residue_coefficients_surjective
    (actualAffineChartStalkCoefficientAlgEquiv sX U hU xU)
    (closed_affine_residue_coefficients_surjective (hU.primeIdealOf xU).asIdeal)

/-- The actual closed-point stalk of an integral smooth curve is a genuine
DVR. This is derived from its actual standard smooth chart, conormal
sequence and rational residue field, in arbitrary characteristic. -/
theorem actual_smooth_curve_closed_point_dvr (x : ClosedPoint X) :
    IsDiscreteValuationRing (X.presheaf.stalk x.val) := by
  obtain ⟨U, hU, hx, hs⟩ := actual_smooth_point_chart sX 1 x.val
  let xU : U := ⟨x.val, hx⟩
  letI : Nonempty U := ⟨xU⟩
  letI : Algebra k Γ(X, U) := (chartBaseFieldHom sX U).toAlgebra
  letI : Algebra k (X.presheaf.stalk x.val) := (stalkBaseFieldHom sX x.val).toAlgebra
  letI := X.presheaf.algebra_section_stalk xU
  letI : IsScalarTower k Γ(X, U) (X.presheaf.stalk x.val) :=
    IsScalarTower.of_algebraMap_eq' (actual_chart_stalk_base_field_compatibility sX U xU).symm
  letI : Algebra.IsStandardSmoothOfRelativeDimension 1 k Γ(X, U) := hs
  letI : Algebra.IsStandardSmooth k Γ(X, U) :=
    Algebra.IsStandardSmoothOfRelativeDimension.isStandardSmooth 1
  letI := hU.isLocalization_stalk xU
  letI : (hU.primeIdealOf xU).asIdeal.IsMaximal :=
    hU.primeIdealOf_isMaximal_of_isClosed xU x.property
  have hres : Function.Surjective
      (algebraMap k (IsLocalRing.ResidueField (X.presheaf.stalk x.val))) :=
    actual_smooth_curve_closed_point_residue_surjective sX x
  exact standard_smooth_localization_rational_dvr
    (hU.primeIdealOf xU).asIdeal.primeCompl hres

/-- The closed-point DVR family on an actual smooth curve is constructed,
rather than supplied as a replacement for the curve hypothesis. -/
theorem actual_smooth_curve_closed_point_dvr_stalks : Litt3.Jacobians.ClosedPointDVRStalks X :=
  ⟨actual_smooth_curve_closed_point_dvr sX⟩

end Litt3.SharedTensors
