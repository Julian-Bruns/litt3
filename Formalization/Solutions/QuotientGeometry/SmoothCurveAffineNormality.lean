import Solutions.SharedTensors.SmoothCurveDVRStalks
import Mathlib.RingTheory.LocalProperties.IntegrallyClosed
import Mathlib.Topology.JacobsonSpace

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- EVERY genuine nonempty affine-open coordinate ring on an
original integral smooth curve is integrally closed. The original
closed-point DVR property and localization identifications are
derived; no normal affine chart or normalization model is supplied. -/
theorem actual_smooth_curve_affine_chart_isIntegrallyClosed
    {k : Type u} [Field k] [IsAlgClosed k]
    {X : Scheme.{u}} [IsIntegral X]
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (U : X.Opens) (hU : IsAffineOpen U) [Nonempty U] :
    IsIntegrallyClosed Γ(X, U) := by
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : JacobsonSpace X := LocallyOfFiniteType.jacobsonSpace sX
  apply IsIntegrallyClosed.of_localization_maximal
  intro P _hP hPmax
  letI : P.IsMaximal := hPmax
  let y : PrimeSpectrum Γ(X, U) := ⟨P, inferInstance⟩
  have hy : y ∈ closedPoints (Spec Γ(X, U)) :=
    y.isClosed_singleton_iff_isMaximal.mpr hPmax
  have hx : IsClosed ({hU.fromSpec y} : Set X) := by
    exact (Set.ext_iff.mp hU.fromSpec.isOpenEmbedding.preimage_closedPoints y).mpr hy
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
  exact IsIntegrallyClosed.of_equiv
    (IsLocalization.algEquiv P.primeCompl (X.presheaf.stalk (hU.fromSpec y))
      (Localization.AtPrime P)).toRingEquiv

end Litt3.QuotientGeometry
