import Definitions.Deformations.RadicalPowerFiltration
import Mathlib.LinearAlgebra.Quotient.Basic

namespace Litt3.Deformations

variable {k A : Type*} [Field k] [Ring A] [Algebra k A]

/-- The genuine quotient of the left regular module by Rf.
The relation need not be central or define a two-sided ideal. -/
abbrev LeftPrincipalQuotient (f : A) := A ⧸ Submodule.span A {f}

end Litt3.Deformations
