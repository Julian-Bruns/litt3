import Solutions.SharedTensors.SmoothCurveRationalDifferentialOrders
import Solutions.CartierAndSpin.RationalDifferentialFiniteZeros
import Solutions.CartierAndSpin.RationalDifferentialFinitePoles

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.CartierAndSpin Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X] [CompactSpace X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- Both actual finite zero and pole sets control the support of the
ORIGINAL normalized differential order. No canonical degree or support
finiteness is supplied. Properness is unnecessary. -/
theorem actual_smooth_rational_differential_order_support_finite :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0),
      (Function.support (smoothCurveRationalDifferentialOrder sX omega h)).Finite := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h
  apply ((actual_compact_smooth_rational_differential_zeros_finite sX omega h).union
    (actual_compact_smooth_rational_differential_poles_finite sX omega)).subset
  intro x hx
  change smoothCurveRationalDifferentialOrder sX omega h x ≠ 0 at hx
  by_cases hn : smoothCurveRationalDifferentialOrder sX omega h x < 0
  · exact Or.inr ((actual_smooth_negative_differential_order_iff_pole sX omega h x).mp hn)
  · exact Or.inl ((actual_smooth_positive_differential_order_iff_zero sX omega h x).mp
      (by omega))

/-- The genuine finite integral divisor of the original nonzero rational
one-form, constructed from the derived original closed-stalk orders. -/
noncomputable def actualRationalDifferentialDivisor :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField, omega ≠ 0 → Divisor (ClosedPoint X) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h
  exact Finsupp.ofSupportFinite (smoothCurveRationalDifferentialOrder sX omega h)
    (actual_smooth_rational_differential_order_support_finite sX omega h)

theorem actual_rational_differential_divisor_coefficient :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0) (x : ClosedPoint X),
      actualRationalDifferentialDivisor sX omega h x =
        smoothCurveRationalDifferentialOrder sX omega h x := by
  intros
  rfl

/-- Effectiveness means true original regularity at every closed point,
equivalently the literal global regular rational-differential lattice. -/
theorem actual_rational_differential_divisor_effective_iff_regular :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0),
      EffectiveDivisor (actualRationalDifferentialDivisor sX omega h) ↔
        omega ∈ schemeGlobalRegularDifferentials sX := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h
  rw [mem_schemeGlobalRegularDifferentials_iff]
  change (∀ x, 0 ≤ smoothCurveRationalDifferentialOrder sX omega h x) ↔
    ∀ x : ClosedPoint X, omega ∈ schemeLocalRegularDifferentials sX x.val
  exact forall_congr' fun x =>
    actual_smooth_nonnegative_differential_order_iff_regular sX omega h x

end Litt3.SharedTensors
