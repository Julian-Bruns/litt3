import Mathlib.RepresentationTheory.Basic
import Mathlib.RepresentationTheory.Invariants
import Mathlib.GroupTheory.PGroup
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.Field.ZMod
import Mathlib.LinearAlgebra.FiniteDimensional.Defs
import Mathlib.LinearAlgebra.Basis.VectorSpace
import Mathlib.Data.Fintype.Card

namespace Litt3.Deformations

variable {p : ℕ} [Fact p.Prime] {G V : Type*} [Group G]
    [AddCommGroup V] [Module (ZMod p) V]

/-- The genuine finite prime-field orbit span of one specified vector. -/
def primeFieldOrbitSpan (ρ : Representation (ZMod p) G V) (v : V) : Submodule (ZMod p) V :=
  Submodule.span (ZMod p) (Set.range (fun g => ρ g v))

end Litt3.Deformations
