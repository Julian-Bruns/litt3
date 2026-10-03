import Solutions.SharedTensors.SmoothCurveDVRStalks

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- Completion parameters of every original smooth-curve closed stalk
are constructed from its true structure morphism. The DVR, residue
coefficient surjectivity and uniformizer are all conclusions. -/
noncomputable def actualSmoothCurveCompletionParameters (x : ClosedPoint X) :
    letI := actual_smooth_curve_closed_point_dvr sX x
    letI := (stalkBaseFieldHom sX x.val).toAlgebra
    DVRCompletionParameters k (X.presheaf.stalk x.val) := by
  letI := actual_smooth_curve_closed_point_dvr sX x
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  let t := Classical.choose (IsDiscreteValuationRing.exists_irreducible (X.presheaf.stalk x.val))
  exact ⟨t, Classical.choose_spec (IsDiscreteValuationRing.exists_irreducible
    (X.presheaf.stalk x.val)), actual_smooth_curve_closed_point_residue_surjective sX x⟩

end Litt3.SharedTensors
