import Mathlib.FieldTheory.Finite.Basic

namespace Litt3.CurveArithmetic

/-- The affine parameter invariant for every finite base field, not only
a prime field. The extension is an actual field containing the base. -/
def finiteAffineInvariant (K : Type*) [Field K] [Fintype K]
    {L : Type*} [Field L] (a : L) : L :=
  (a ^ Fintype.card K - a) ^ (Fintype.card K - 1)

def finiteAffineTransform {K L : Type*} [Field K] [Field L] [Algebra K L]
    (u : Kˣ) (v : K) (a : L) : L := algebraMap K L u.val * a + algebraMap K L v

end Litt3.CurveArithmetic
