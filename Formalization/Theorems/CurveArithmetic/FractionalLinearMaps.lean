import Definitions.CurveArithmetic.FractionalLinearMaps
import Definitions.CurveArithmetic.FiniteAffineInvariant

namespace Litt3.CurveArithmetic.Targets

def FiniteBranchFractionalLinearClassification : Prop :=
  ∀ (K L : Type) [Field K] [Fintype K] [Field L] [Algebra K L]
    (g : FractionalLinearData L), 4 ≤ Fintype.card K → ∀ a b : L,
    a ∉ Set.range (algebraMap K L) →
    (∀ x : K, g.denominator (algebraMap K L x) ≠ 0) →
    (∀ x : K, g.eval (algebraMap K L x) ∈ Set.range (algebraMap K L) ∨
      g.eval (algebraMap K L x) = b) →
    (g.eval a ∈ Set.range (algebraMap K L) ∨ g.eval a = b) →
    g.denominatorLinear = 0 ∧ ∃ (u : Kˣ) (v : K),
      b = finiteAffineTransform u v a ∧
      ∀ x : L, g.eval x = finiteAffineTransform u v x

end Litt3.CurveArithmetic.Targets
