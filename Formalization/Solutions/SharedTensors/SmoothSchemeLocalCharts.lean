import Solutions.QuotientGeometry.SchemeBaseFields
import Mathlib.AlgebraicGeometry.Morphisms.Smooth

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} (sX : X ⟶ Spec (.of k))

/-- Every actual point of a smooth scheme over a field has a genuine
standard smooth affine chart of the specified relative dimension. No
integrality or generic-point condition is needed. -/
theorem actual_smooth_point_chart (n : ℕ) [IsSmoothOfRelativeDimension n sX] (x : X) :
    ∃ U : X.Opens, IsAffineOpen U ∧ x ∈ U ∧
      RingHom.IsStandardSmoothOfRelativeDimension n
        (Litt3.QuotientGeometry.chartBaseFieldHom sX U) := by
  obtain ⟨⟨V, hV⟩, ⟨U, hU⟩, hx, e, hs⟩ :=
    IsSmoothOfRelativeDimension.exists_isStandardSmoothOfRelativeDimension
      (n := n) (f := sX) x
  have hVtop : V = ⊤ := by
    ext y
    constructor
    · intro _
      trivial
    · intro _
      have hy : y = sX x := Subsingleton.elim _ _
      simpa only [hy] using e hx
  subst V
  refine ⟨U, hU, hx, ?_⟩
  change RingHom.IsStandardSmoothOfRelativeDimension n
    (((Scheme.ΓSpecIso (.of k)).inv ≫ sX.appLE ⊤ U le_top).hom)
  rw [CommRingCat.hom_comp,
    RingHom.isStandardSmoothOfRelativeDimension_respectsIso.cancel_left_isIso]
  exact hs

end Litt3.SharedTensors
