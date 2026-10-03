import Mathlib.Algebra.Order.Field.Basic

/-!
Numerical data appearing in the adjunction proof and in Raynaud dimension
bounds. These predicates record explicit inequalities; they do not stand in
for curves, Jacobians, or any of the canonical geometric theorem targets.
-/

namespace Litt3.Jacobians

/-- The trace inequality obtained after normalizing an actual joint image.
The geometry proving this inequality is not encoded in this predicate. -/
def JointImageTraceBound {K : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K]
    (a b c genus trace : K) : Prop :=
  trace ≤ 2 * a * b + 2 * a * c * (genus - 1)

/-- The published rank-one Raynaud dimension inequality, in scaled form.
Connecting the data to a translated abelian family is a separate task. -/
def RankOneDimensionBound {K : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K]
    (characteristic genus dimension : K) : Prop :=
  characteristic * dimension ≤ (characteristic - 1) * (genus - 1)

end Litt3.Jacobians
