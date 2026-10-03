import Theorems.CartierAndSpin.AnnihilatorCriticalTranslation
import Solutions.CartierAndSpin.IndependentRationalCriticalTranslation
import Solutions.CartierAndSpin.SmoothSelectedTranslation

namespace Litt3.CartierAndSpin

open CategoryTheory AlgebraicGeometry Polynomial

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {Z : Scheme.{u}} [IsIntegral Z]
  {K : Type*} [Field K] [Algebra K Z.functionField] [CharP K 5]

/-- Every literal algebraic and actual selected-point clause of the
translation theorem on the same smooth source, with no DVR, power basis,
trace invariant or admissibility conclusion supplied as a premise. -/
theorem annihilator_critical_translation_source
    (sZ : Z ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sZ]
    (w u : Z.functionField) (hu : u ≠ 0) (F phi D U : K[X])
    (hgen : IntermediateField.adjoin K ({w} : Set Z.functionField) = ⊤)
    (hroot : aeval w F = 0) (hactualdegree : Module.finrank K Z.functionField = 10)
    (hdegree : F.natDegree = 10) (hsep : F.Separable)
    (hderivative : F.derivative = phi * D) (hDdegree : D.natDegree ≤ 3)
    (hUdegree : U.natDegree ≤ 5) (hequation : aeval w U = u * aeval w D) :
    Specifications.AnnihilatorCriticalTranslation sZ w u F phi D U := by
  refine ⟨actual_critical_translation_package w u F phi D U hgen hroot
      hactualdegree hdegree hsep hderivative hDdegree hUdegree hequation,
    independent_rational_critical_translation_package w u F phi D U hgen hroot
      hactualdegree hdegree hsep hderivative hDdegree hUdegree hequation, ?_, ?_⟩
  · intro P horder z hz
    exact smooth_curve_selected_double_zero_translation sZ P u hu horder z hz
  · intro selected hnonempty horders z hz hpreserves
    obtain ⟨P, hP⟩ := hnonempty
    exact smooth_curve_translation_does_not_preserve_double_zero
      sZ P u hu (horders P hP) z hz (hpreserves P hP)

end Litt3.CartierAndSpin
