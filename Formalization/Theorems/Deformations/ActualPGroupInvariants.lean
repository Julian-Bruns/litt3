import Definitions.Deformations.PGroupInvariants
import Mathlib.Algebra.Module.ZMod
import Mathlib.Algebra.CharP.Defs

namespace Litt3.Deformations.Specifications

variable {k G V : Type*} [CommRing k] [Group G] [AddCommGroup V] [Module k V]

def NonzeroCharacteristicPGroupInvariants (ρ : Representation k G V) : Prop :=
  (∃ v : V, v ≠ 0) → ∃ w : V, w ≠ 0 ∧ ∀ g, ρ g w = w

end Litt3.Deformations.Specifications
