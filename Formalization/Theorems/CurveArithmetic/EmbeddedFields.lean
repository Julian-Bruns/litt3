import Mathlib.FieldTheory.IntermediateField.Algebraic
import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic

namespace Litt3.CurveArithmetic.Targets

/-- The actual joint subfield inside a fixed ambient field has index
dividing both leg indices. The ambient field need not be finite over its
constant field, so this applies to curve function fields. -/
def JointFieldIndexDivisibility : Prop :=
  ∀ (K L : Type) [Field K] [Field L] [Algebra K L]
    (F E : IntermediateField K L),
    Module.finrank (F ⊔ E : IntermediateField K L) L ∣
      Nat.gcd (Module.finrank F L) (Module.finrank E L)

/-- Coprime map degrees make the two embedded function fields jointly
generate the original ambient field. -/
def CoprimeEmbeddedFieldsGenerate : Prop :=
  ∀ (K L : Type) [Field K] [Field L] [Algebra K L]
    (F E : IntermediateField K L),
    Nat.Coprime (Module.finrank F L) (Module.finrank E L) → F ⊔ E = ⊤

end Litt3.CurveArithmetic.Targets
