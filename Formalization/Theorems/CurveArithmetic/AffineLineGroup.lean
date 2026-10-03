import Definitions.CurveArithmetic.AffineLineGroup

namespace Litt3.CurveArithmetic.Targets

def FiniteAffineElementOrderAlternatives : Prop :=
  ∀ (K : Type) [Field K] [Fintype K] (p : ℕ) [Fact p.Prime] [CharP K p]
    (g : AffineLineGroup K), orderOf g = p ∨ orderOf g ∣ Fintype.card K - 1

end Litt3.CurveArithmetic.Targets
