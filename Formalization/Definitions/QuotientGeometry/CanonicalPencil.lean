import Mathlib.RingTheory.Derivation.Basic

namespace Litt3.QuotientGeometry

/-- The coefficient of the canonical-pencil bracket in an actual local
differential frame. Its sign agrees with B*D(A)-A*D(B). -/
def canonicalPencilBracket {k L : Type*} [Field k] [Field L] [Algebra k L]
    (D : Derivation k L L) (A B : L) : L := B * D A - A * D B

def canonicalPencilX {L : Type*} [Field L] (A B : L) : L := B / A

def canonicalPencilY {L : Type*} [Field L] (A W : L) : L := -W / A ^ 3

end Litt3.QuotientGeometry
