import Definitions.CartierAndSpin.SmoothSelectedTranslation
import Solutions.CartierAndSpin.SchemeSelectedTranslation
import Solutions.SharedTensors.ConstantPrincipalDivisors

namespace Litt3.CartierAndSpin

open CategoryTheory AlgebraicGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]

/-- On the same actual smooth source curve, every nonzero constant
translation destroys a prescribed double zero. The stalk DVR and both
constant-field maps come from the actual structure morphism. -/
theorem smooth_curve_selected_double_zero_translation
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (P : Litt3.SharedTensors.ClosedPoint X) (f : X.functionField) (hf : f ≠ 0)
    (horder : integerFieldOrder (smoothCurveClosedPointValuation sX P) f = 2)
    (z : k) (hz : z ≠ 0) :
    ∃ germ : X.presheaf.stalk P.val, IsUnit germ ∧
      algebraMap (X.presheaf.stalk P.val) X.functionField germ =
        f - Litt3.QuotientGeometry.genericBaseFieldHom sX z ∧
      f - Litt3.QuotientGeometry.genericBaseFieldHom sX z ≠ 0 ∧
      integerFieldOrder (smoothCurveClosedPointValuation sX P)
        (f - Litt3.QuotientGeometry.genericBaseFieldHom sX z) = 0 := by
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : Algebra k (X.presheaf.stalk P.val) :=
    (Litt3.SharedTensors.stalkBaseFieldHom sX P.val).toAlgebra
  letI : Algebra k X.functionField :=
    (Litt3.QuotientGeometry.genericBaseFieldHom sX).toAlgebra
  letI : IsScalarTower k (X.presheaf.stalk P.val) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (Litt3.SharedTensors.stalk_base_field_generic_compatibility sX P.val).symm
  exact scheme_selected_double_zero_translation X P f hf horder z hz

/-- No nonzero scalar translation preserves even one prescribed
selected double zero of the actual smooth source. -/
theorem smooth_curve_translation_does_not_preserve_double_zero
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (P : Litt3.SharedTensors.ClosedPoint X) (f : X.functionField) (hf : f ≠ 0)
    (horder : integerFieldOrder (smoothCurveClosedPointValuation sX P) f = 2)
    (z : k) (hz : z ≠ 0) :
    integerFieldOrder (smoothCurveClosedPointValuation sX P)
      (f - Litt3.QuotientGeometry.genericBaseFieldHom sX z) ≠ 2 := by
  obtain ⟨germ, hgerm, hmap, hnonzero, hzero⟩ :=
    smooth_curve_selected_double_zero_translation sX P f hf horder z hz
  rw [hzero]
  norm_num

end Litt3.CartierAndSpin
