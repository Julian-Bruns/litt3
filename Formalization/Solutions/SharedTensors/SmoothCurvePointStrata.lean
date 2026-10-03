import Solutions.QuotientGeometry.SmoothCurveAffineDedekind

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

include sX

/-- Every original point of an actual integral smooth curve is either
closed or the original generic point. This is derived from the genuine
Dedekind affine charts and Jacobson closed-point transfer. -/
theorem actual_smooth_curve_point_closed_or_generic (x : X) :
    IsClosed ({x} : Set X) ∨ x = genericPoint X := by
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : JacobsonSpace X := LocallyOfFiniteType.jacobsonSpace sX
  obtain ⟨U, hU, hx, _⟩ := actual_smooth_point_chart sX 1 x
  let xU : U := ⟨x, hx⟩
  letI : Nonempty U := ⟨xU⟩
  letI : IsDedekindDomain Γ(X, U) := actual_smooth_curve_affine_chart_dedekind sX U hU
  let y := hU.primeIdealOf xU
  by_cases hP : y.asIdeal = ⊥
  · right
    have hy : y = genericPoint (Spec Γ(X, U)) := by
      rw [genericPoint_eq_bot_of_affine]
      exact PrimeSpectrum.ext hP
    have hgeneric := genericPoint_eq_of_isOpenImmersion hU.fromSpec
    rw [← hy, hU.fromSpec_primeIdealOf] at hgeneric
    exact hgeneric
  · left
    have hmax : y.asIdeal.IsMaximal := y.isPrime.isMaximal hP
    have hy : y ∈ closedPoints (Spec Γ(X, U)) :=
      y.isClosed_singleton_iff_isMaximal.mpr hmax
    have hclosed : IsClosed ({hU.fromSpec y} : Set X) :=
      (Set.ext_iff.mp hU.fromSpec.isOpenEmbedding.preimage_closedPoints y).mpr hy
    simpa only [y, hU.fromSpec_primeIdealOf] using hclosed

/-- Original closed-stalk regularity is actual everywhere regularity
on the same smooth integral curve; the generic stalk adds no condition. -/
theorem actual_smooth_curve_closed_regular_iff_everywhere (f : X.functionField) :
    (∀ x : ClosedPoint X, ∃ r : X.presheaf.stalk x.val,
      algebraMap (X.presheaf.stalk x.val) X.functionField r = f) ↔
    ∀ x : X, ∃ r : X.presheaf.stalk x,
      algebraMap (X.presheaf.stalk x) X.functionField r = f := by
  constructor
  · intro hregular x
    rcases actual_smooth_curve_point_closed_or_generic sX x with hclosed | hgeneric
    · exact hregular ⟨x, hclosed⟩
    · subst x
      refine ⟨f, ?_⟩
      change (X.presheaf.stalkSpecializes
        ((genericPoint_spec X).specializes trivial)).hom f = f
      rw [X.presheaf.stalkSpecializes_refl]
      rfl
  · intro hregular x
    exact hregular x.val

end Litt3.SharedTensors
