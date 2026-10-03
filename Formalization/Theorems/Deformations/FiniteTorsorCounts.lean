import Definitions.Deformations.FiniteTorsorCounts

namespace Litt3.Deformations.Specifications

variable {k V A : Type*} [DivisionRing k] [AddCommGroup V]
variable [Module k V] [Module.Finite k V] [AddTorsor V A]

/-- Exact point-class count, once an actual vector-group torsor
description has been supplied. -/
def ExactVectorTorsorCount : Prop := VectorTorsorCount (k := k) (V := V) (A := A)

end Litt3.Deformations.Specifications
