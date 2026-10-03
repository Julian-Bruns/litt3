import Mathlib.FieldTheory.IsAlgClosed.Basic
import Mathlib.Algebra.Ring.Action.Basic
import Mathlib.GroupTheory.Abelianization.Defs

namespace Litt3.QuotientGeometry.Targets

/-- Finite actual field actions with no invariant functions beyond the
algebraically closed constant field have no nonconstant functions at all. -/
def FiniteInvariantFieldTriviality : Prop :=
  ∀ (K L G : Type) [Field K] [Field L] [Algebra K L] [IsAlgClosed K]
    [Group G] [Finite G] [MulSemiringAction G L],
    (∀ (g : G) (k : K), g • algebraMap K L k = algebraMap K L k) →
    (∀ x : L, (∀ g : G, g • x = x) → ∃ k, algebraMap K L k = x) →
    Function.Surjective (algebraMap K L)

/-- The obstruction applies to every abelian quotient, in any group size. -/
def PerfectGroupAbelianHomTriviality : Prop :=
  ∀ (G A : Type) [Group G] [CommGroup A], commutator G = ⊤ →
    ∀ (f : G →* A) (g : G), f g = 1

end Litt3.QuotientGeometry.Targets
