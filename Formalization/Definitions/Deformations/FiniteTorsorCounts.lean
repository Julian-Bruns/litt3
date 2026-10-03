import Definitions.Deformations.ObstructionTorsors
import Mathlib.FieldTheory.Finiteness
import Mathlib.SetTheory.Cardinal.Finite

namespace Litt3.Deformations

variable {k V A : Type*} [DivisionRing k] [AddCommGroup V]
variable [Module k V] [Module.Finite k V] [AddTorsor V A]

/-- The count concerns the actual point torsor. Identification with
marked geometric isomorphism classes is a separate input. -/
def VectorTorsorCount : Prop :=
  Nat.card A = Nat.card k ^ Module.finrank k V

end Litt3.Deformations
