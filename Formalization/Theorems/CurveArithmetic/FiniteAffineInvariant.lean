import Definitions.CurveArithmetic.FiniteAffineInvariant

namespace Litt3.CurveArithmetic.Targets

def FiniteAffineInvariantComplete : Prop :=
  ∀ (K L : Type) [Field K] [Fintype K] [Field L] [Algebra K L] (a b : L),
    a ∉ Set.range (algebraMap K L) → b ∉ Set.range (algebraMap K L) →
    (finiteAffineInvariant K a = finiteAffineInvariant K b ↔
      ∃ (u : Kˣ) (v : K), b = finiteAffineTransform u v a)

end Litt3.CurveArithmetic.Targets
