import Solutions.QuotientGeometry.SmoothCurveAffineDedekind
import Solutions.Jacobians.SchemeFiniteSupport
import Mathlib.AlgebraicGeometry.Morphisms.Proper
import Mathlib.Algebra.Field.Equiv

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry Litt3.Jacobians

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

include sX

/-- Every genuine nonempty affine chart of an actual smooth integral
curve is not a field. Its actual maximal localization is a DVR, whereas
localization of a field would be that field. -/
theorem actual_smooth_curve_affine_chart_not_isField
    (U : X.Opens) (hU : IsAffineOpen U) [Nonempty U] :
    ¬ IsField Γ(X, U) := by
  intro hfield
  obtain ⟨P, hP⟩ := Ideal.exists_maximal Γ(X, U)
  letI := hP
  letI : IsDiscreteValuationRing (Localization.AtPrime P) :=
    actual_smooth_curve_affine_chart_maximal_dvr sX U hU P
  have hzero : (0 : Γ(X, U)) ∉ P.primeCompl := by
    change ¬ (0 : Γ(X, U)) ∉ P
    exact not_not.mpr P.zero_mem
  let e : Γ(X, U) ≃+* Localization.AtPrime P :=
    RingEquiv.ofBijective (algebraMap Γ(X, U) (Localization.AtPrime P))
      (hfield.localization_map_bijective hzero)
  exact IsDiscreteValuationRing.not_isField (Localization.AtPrime P)
    (MulEquiv.isField hfield e.symm.toMulEquiv)

/-- Actual quasi-compactness plus actual smooth one-dimensional geometry
prove finite support of every ORIGINAL rational principal divisor.
The finite affine cover, Dedekind charts and non-field condition are
constructed rather than supplied. Properness is unnecessary. -/
theorem actual_compact_smooth_curve_finite_principal_support [CompactSpace X] :
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    FinitePrincipalSupport X := by
  classical
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  choose U hU hx hs using fun x : X => actual_smooth_point_chart sX 1 x
  have hcover : (Set.univ : Set X) ⊆ ⋃ x : X, (U x : Set X) := by
    intro x _
    exact Set.mem_iUnion.mpr ⟨x, hx x⟩
  obtain ⟨t, ht⟩ := isCompact_univ.elim_finite_subcover
    (fun x : X => (U x : Set X)) (fun x => (U x).isOpen) hcover
  let V : t → X.Opens := fun i => U i.val
  letI : ∀ i : t, Nonempty (V i) := fun i => ⟨⟨i.val, hx i.val⟩⟩
  letI : ∀ i : t, IsDedekindDomain Γ(X, V i) := fun i =>
    actual_smooth_curve_affine_chart_dedekind sX (V i) (hU i.val)
  apply finite_principal_support_of_dedekind_cover V (fun i => hU i.val)
    (fun i => actual_smooth_curve_affine_chart_not_isField sX (V i) (hU i.val))
  intro x
  obtain ⟨i, hi⟩ := Set.mem_iUnion.mp (ht (Set.mem_univ x))
  obtain ⟨hit, hxi⟩ := Set.mem_iUnion.mp hi
  exact ⟨⟨i, hit⟩, hxi⟩

/-- A genuine quasi-compact structure morphism supplies the compact
source condition above. Finite principal support follows on the actual
smooth curve, with no auxiliary covering hypotheses. -/
theorem actual_quasiCompact_smooth_curve_finite_principal_support
    [QuasiCompact sX] :
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    FinitePrincipalSupport X := by
  letI : CompactSpace X := QuasiCompact.compactSpace_of_compactSpace sX
  exact actual_compact_smooth_curve_finite_principal_support sX

/-- In particular the original proper smooth integral curve has its
genuine finite-support valuation divisor system. -/
theorem actual_proper_smooth_curve_finite_principal_support [IsProper sX] :
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    FinitePrincipalSupport X :=
  actual_quasiCompact_smooth_curve_finite_principal_support sX

end Litt3.SharedTensors
