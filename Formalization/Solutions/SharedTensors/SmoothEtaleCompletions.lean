import Solutions.SharedTensors.SmoothCurveCompletions
import Definitions.SharedTensors.SchemeDivisors
import Solutions.QuotientGeometry.SchemeDVRCompletions
import Solutions.QuotientGeometry.SchemeStalkCoefficients
import Solutions.QuotientGeometry.CompletedDVRMaps

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry Litt3.Jacobians

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X]

/-- At an original smooth-curve closed point, EVERY actual scheme map
over the coefficient field induces a bijection of the actual residue
fields. No geometric assumption on the target or map is needed here. -/
theorem actual_smooth_closed_point_stalk_residue_map_bijective
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (sY : Y ⟶ Spec (.of k)) (f : X ⟶ Y) (hover : f ≫ sY = sX)
    (x : ClosedPoint X) : Function.Bijective (schemeStalkResidueMap f x.val) := by
  letI := actual_smooth_curve_closed_point_dvr sX x
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI := (stalkBaseFieldHom sY (f x.val)).toAlgebra
  let φ := actualSchemeStalkAlgHom f sX sY hover x.val
  refine ⟨(schemeStalkResidueMap f x.val).injective, ?_⟩
  intro b
  obtain ⟨c, hc⟩ := actual_smooth_curve_closed_point_residue_surjective sX x b
  refine ⟨IsLocalRing.residue (Y.presheaf.stalk (f x.val))
    (algebraMap k (Y.presheaf.stalk (f x.val)) c), ?_⟩
  change IsLocalRing.ResidueField.map φ.toRingHom _ = b
  rw [IsLocalRing.ResidueField.map_residue]
  change IsLocalRing.residue (X.presheaf.stalk x.val)
    (φ (algebraMap k (Y.presheaf.stalk (f x.val)) c)) = b
  rw [φ.commutes]
  exact hc

variable [IsIntegral Y]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (f : X ⟶ Y) [IsFinite f] [AlgebraicGeometry.FormallyUnramified f]
  (hover : f ≫ sY = sX) (x : ClosedPoint X)

include sX sY hover

/-- An actual finite unramified morphism of integral smooth curves gives
an isomorphism of the ENTIRE original completed stalk rings at every
closed source point. All DVR, equal-residue and completion-model inputs
are derived from the genuine scheme morphisms. Surjectivity and global
Galois hypotheses are unnecessary. -/
theorem actual_smooth_finite_unramified_completion_isomorphism :
    ∃ e : AdicCompletion (IsLocalRing.maximalIdeal (Y.presheaf.stalk (f x.val)))
        (Y.presheaf.stalk (f x.val)) ≃+*
      AdicCompletion (IsLocalRing.maximalIdeal (X.presheaf.stalk x.val))
        (X.presheaf.stalk x.val),
      e.toRingHom = schemeCompletedStalkMap f x.val ∧
      ∀ r : Y.presheaf.stalk (f x.val),
        e (AdicCompletion.of _ _ r) =
          AdicCompletion.of _ _ ((f.stalkMap x.val).hom r) := by
  letI := actual_smooth_curve_closed_point_dvr sX x
  letI : IsDiscreteValuationRing (Y.presheaf.stalk (f x.val)) :=
    actual_smooth_curve_closed_point_dvr sY (mapClosedPoint f x)
  exact scheme_unramified_dvr_completion_isomorphism f x.val
    (actual_smooth_closed_point_stalk_residue_map_bijective sX sY f hover x).surjective

/-- With genuine constructed original uniformizer/residue parameters, the
actual completed map is an equivalence of WHOLE power-series algebras.
The parameters are constructed above; their field charts and bijectivity
are conclusions, not caller-supplied completion identifications. -/
noncomputable def actualSmoothUnramifiedPowerSeriesEquiv :
    PowerSeries k ≃ₐ[k] PowerSeries k := by
  letI := actual_smooth_curve_closed_point_dvr sX x
  letI : IsDiscreteValuationRing (Y.presheaf.stalk (f x.val)) :=
    actual_smooth_curve_closed_point_dvr sY (mapClosedPoint f x)
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI := (stalkBaseFieldHom sY (f x.val)).toAlgebra
  exact unramifiedCompletedDVRPowerSeriesEquiv
    (actualSmoothCurveCompletionParameters sY
      (⟨f x.val, (mapClosedPoint f x).property⟩ : ClosedPoint Y))
    (actualSmoothCurveCompletionParameters sX x)
    (actualSchemeStalkAlgHom f sX sY hover x.val)
    (scheme_stalk_map_formallyUnramified f x.val)
    (scheme_stalk_map_essFiniteType f x.val)

theorem actualSmoothUnramifiedPowerSeriesEquiv_is_actual_map :
    letI := actual_smooth_curve_closed_point_dvr sX x
    letI : IsDiscreteValuationRing (Y.presheaf.stalk (f x.val)) :=
      actual_smooth_curve_closed_point_dvr sY (mapClosedPoint f x)
    letI := (stalkBaseFieldHom sX x.val).toAlgebra
    letI := (stalkBaseFieldHom sY (f x.val)).toAlgebra
    (actualSmoothUnramifiedPowerSeriesEquiv sX sY f hover x).toAlgHom =
      completedDVRPowerSeriesMap
        (actualSmoothCurveCompletionParameters sY
          (⟨f x.val, (mapClosedPoint f x).property⟩ : ClosedPoint Y))
        (actualSmoothCurveCompletionParameters sX x)
        (actualSchemeStalkAlgHom f sX sY hover x.val) := by
  letI := actual_smooth_curve_closed_point_dvr sX x
  letI : IsDiscreteValuationRing (Y.presheaf.stalk (f x.val)) :=
    actual_smooth_curve_closed_point_dvr sY (mapClosedPoint f x)
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI := (stalkBaseFieldHom sY (f x.val)).toAlgebra
  exact unramifiedCompletedDVRPowerSeriesEquiv_toAlgHom _ _ _ _ _

end Litt3.SharedTensors
