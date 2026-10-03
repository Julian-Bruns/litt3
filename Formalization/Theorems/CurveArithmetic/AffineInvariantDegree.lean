import Theorems.CurveArithmetic.AffineLineGroup
import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic

namespace Litt3.CurveArithmetic.Targets

def FiniteAffineInvariantDegreeQuotient : Prop :=
  ∀ (F K L : Type) [Field F] [Fintype F] [Field K] [Fintype K] [Field L]
    [Algebra F K] [Algebra K L] [Algebra F L] [IsScalarTower F K L]
    [Algebra.IsAlgebraic K L] (p : ℕ) [Fact p.Prime] [CharP F p] (a : L),
    a ∉ Set.range (algebraMap F L) →
    let d := Module.finrank K (IntermediateField.adjoin K {a})
    let m := Module.finrank K (IntermediateField.adjoin K {finiteAffineInvariant F a})
    m ∣ d ∧ (d / m = p ∨ d / m ∣ Fintype.card F - 1)

end Litt3.CurveArithmetic.Targets
