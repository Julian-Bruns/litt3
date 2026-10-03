import Definitions.CurveArithmetic.RationalCoefficientAction
import Mathlib.LinearAlgebra.FiniteDimensional.Defs

namespace Litt3.CurveArithmetic.Targets

/-- An algebraic finite family descends to its actual smallest embedded
coefficient field, and that field is finite-dimensional over the base. -/
def RationalCoefficientFieldFiniteDescent : Prop :=
  ∀ (K L ι : Type) [Field K] [Field L] [Algebra K L]
    [Algebra.IsAlgebraic K L] [Finite ι] (rational : ι → RatFunc L),
    FiniteDimensional K (rationalCoefficientField (K := K) rational) ∧
      ∃ descended : ι → RatFunc (rationalCoefficientField (K := K) rational),
        ∀ i, rationalCoefficientMap
          (rationalCoefficientField (K := K) rational).val.toRingHom (descended i) = rational i

end Litt3.CurveArithmetic.Targets
