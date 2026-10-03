import Definitions.QuotientGeometry.FreeFiniteActions

namespace Litt3.QuotientGeometry.Targets

/-- A free group preserving a nonempty fiber of cardinality at most two
has at most two elements. This is the local group-action component, not
the classification of hyperelliptic étale quotient groups. -/
def SmallFiberFreeActionBound : Prop :=
  ∀ (G A : Type) [Group G] [Fintype G] [Fintype A] [MulAction G A],
    FixedPointFreeAction G A → Nonempty A → Fintype.card A ≤ 2 →
    Fintype.card G ≤ 2

end Litt3.QuotientGeometry.Targets
