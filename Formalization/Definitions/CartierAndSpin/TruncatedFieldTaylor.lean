import Definitions.CartierAndSpin.IteratedFrobeniusFields
import Mathlib.RingTheory.AdjoinRoot

namespace Litt3.CartierAndSpin

open Polynomial

variable (L : Type*) [Field L] (p e : ℕ)

/-- The genuine truncated Taylor algebra L[z]/(z^(p^e)). It retains
nilpotents and is not incorrectly declared a field. -/
abbrev TruncatedFieldTaylor := AdjoinRoot (X ^ (p ^ e) : L[X])

/-- The actual nilpotent Taylor parameter. -/
noncomputable def truncatedTaylorParameter : TruncatedFieldTaylor L p e :=
  AdjoinRoot.root (X ^ (p ^ e) : L[X])

end Litt3.CartierAndSpin
