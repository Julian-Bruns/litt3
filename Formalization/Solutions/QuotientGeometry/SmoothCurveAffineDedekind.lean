import Solutions.QuotientGeometry.SmoothCurveAffineNormality
import Solutions.QuotientGeometry.AffineChartFiniteType
import Solutions.Jacobians.MaximalLocalDVRDimension

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- The actual maximal localization of EVERY original affine chart of
an integral smooth curve is a DVR, through the original chart stalk. -/
theorem actual_smooth_curve_affine_chart_maximal_dvr
    {k : Type u} [Field k] [IsAlgClosed k]
    {X : Scheme.{u}} [IsIntegral X]
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (U : X.Opens) (hU : IsAffineOpen U) [Nonempty U]
    (P : Ideal Γ(X, U)) [P.IsMaximal] :
    IsDiscreteValuationRing (Localization.AtPrime P) := by
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : JacobsonSpace X := LocallyOfFiniteType.jacobsonSpace sX
  let y : PrimeSpectrum Γ(X, U) := ⟨P, inferInstance⟩
  have hy : y ∈ closedPoints (Spec Γ(X, U)) :=
    y.isClosed_singleton_iff_isMaximal.mpr inferInstance
  have hx : IsClosed ({hU.fromSpec y} : Set X) :=
    (Set.ext_iff.mp hU.fromSpec.isOpenEmbedding.preimage_closedPoints y).mpr hy
  have hxU : hU.fromSpec y ∈ U := by
    change hU.fromSpec y ∈ (U : Set X)
    rw [← hU.range_fromSpec]
    exact ⟨y, rfl⟩
  let x : Litt3.SharedTensors.ClosedPoint X := ⟨hU.fromSpec y, hx⟩
  letI : IsDiscreteValuationRing (X.presheaf.stalk (hU.fromSpec y)) :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sX x
  letI := X.presheaf.algebra_section_stalk ⟨hU.fromSpec y, hxU⟩
  letI : IsLocalization.AtPrime (X.presheaf.stalk (hU.fromSpec y)) P :=
    hU.isLocalization_stalk' y hxU
  exact IsDiscreteValuationRing.RingEquivClass.isDiscreteValuationRing
    (IsLocalization.algEquiv P.primeCompl (X.presheaf.stalk (hU.fromSpec y))
      (Localization.AtPrime P)).toRingEquiv

/-- The coordinate ring of EVERY genuine nonempty affine chart on an
actual integral smooth curve is Dedekind. Normality, dimension and
Noetherianity are all derived from the original smooth structure. -/
theorem actual_smooth_curve_affine_chart_dedekind
    {k : Type u} [Field k] [IsAlgClosed k]
    {X : Scheme.{u}} [IsIntegral X]
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (U : X.Opens) (hU : IsAffineOpen U) [Nonempty U] :
    IsDedekindDomain Γ(X, U) := by
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : Algebra k Γ(X, U) := (chartBaseFieldHom sX U).toAlgebra
  letI : Algebra.FiniteType k Γ(X, U) := actual_affine_chart_finiteType sX U hU
  letI : IsNoetherianRing Γ(X, U) := Algebra.FiniteType.isNoetherianRing k Γ(X, U)
  letI : IsIntegrallyClosed Γ(X, U) :=
    actual_smooth_curve_affine_chart_isIntegrallyClosed sX U hU
  letI : Ring.DimensionLEOne Γ(X, U) :=
    Litt3.Jacobians.dimensionLEOne_of_maximal_localization_dvr Γ(X, U)
      (fun P hP _ => by
        letI := hP
        exact actual_smooth_curve_affine_chart_maximal_dvr sX U hU P)
  letI : IsDedekindRing Γ(X, U) :=
    { toIsNoetherian := inferInstance
      toDimensionLEOne := inferInstance
      toIsIntegralClosure := inferInstance }
  infer_instance

end Litt3.QuotientGeometry
