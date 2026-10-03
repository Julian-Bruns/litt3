import Mathlib.FieldTheory.Minpoly.Field

namespace Litt3.CurveArithmetic.Targets

/-- A nonzero exceptional polynomial of bounded degree cannot vanish at
a parameter of larger algebraic degree. The field need not be finite. -/
def LargeDegreeParameterAvoidsPolynomial : Prop :=
  ∀ (K L : Type) [Field K] [Field L] [Algebra K L]
    (parameter : L) (exceptional : Polynomial K),
    exceptional ≠ 0 → exceptional.natDegree < (minpoly K parameter).natDegree →
    Polynomial.aeval parameter exceptional ≠ 0

end Litt3.CurveArithmetic.Targets
