import Solutions.CartierAndSpin.SelectedTranslationBoundary
import Definitions.Jacobians.SchemeDivisors

namespace Litt3.CartierAndSpin

open AlgebraicGeometry

universe u

variable {k : Type*} [Field k]

/-- Literal selected-point translation on an actual integral scheme.
The function field and fraction embedding of the actual closed-point
stalk are genuine Mathlib objects; an abstract valuation is not supplied.
The explicit DVR-stalk hypothesis isolates the standard smooth-curve
local-regularity bridge, without imposing DVR structure at the generic point. -/
theorem scheme_selected_double_zero_translation
    (X : Scheme.{u}) [IsIntegral X] [Litt3.Jacobians.ClosedPointDVRStalks X]
    (P : Litt3.SharedTensors.ClosedPoint X)
    [Algebra k (X.presheaf.stalk P.val)] [Algebra k X.functionField]
    [IsScalarTower k (X.presheaf.stalk P.val) X.functionField]
    (f : X.functionField) (hf : f ≠ 0)
    (horder : integerFieldOrder (Litt3.Jacobians.closedPointValuation X P) f = 2)
    (z : k) (hz : z ≠ 0) :
    ∃ germ : X.presheaf.stalk P.val, IsUnit germ ∧
      algebraMap (X.presheaf.stalk P.val) X.functionField germ =
        f - algebraMap k X.functionField z ∧
      f - algebraMap k X.functionField z ≠ 0 ∧
      integerFieldOrder (Litt3.Jacobians.closedPointValuation X P)
        (f - algebraMap k X.functionField z) = 0 := by
  exact dvr_nonzero_scalar_translation_zero_order
    (R := X.presheaf.stalk P.val) f hf horder z hz

/-- A nonzero scalar translation cannot preserve even one actual
prescribed selected double zero. This is an obstruction on the same
source's function field, rather than a claimed admissible deformation. -/
theorem scheme_selected_translation_does_not_preserve_double_zero
    (X : Scheme.{u}) [IsIntegral X] [Litt3.Jacobians.ClosedPointDVRStalks X]
    (P : Litt3.SharedTensors.ClosedPoint X)
    [Algebra k (X.presheaf.stalk P.val)] [Algebra k X.functionField]
    [IsScalarTower k (X.presheaf.stalk P.val) X.functionField]
    (f : X.functionField) (hf : f ≠ 0)
    (horder : integerFieldOrder (Litt3.Jacobians.closedPointValuation X P) f = 2)
    (z : k) (hz : z ≠ 0) :
    integerFieldOrder (Litt3.Jacobians.closedPointValuation X P)
      (f - algebraMap k X.functionField z) ≠ 2 := by
  obtain ⟨germ, hgerm, hmap, hnonzero, hzero⟩ :=
    scheme_selected_double_zero_translation X P f hf horder z hz
  rw [hzero]
  norm_num

end Litt3.CartierAndSpin
