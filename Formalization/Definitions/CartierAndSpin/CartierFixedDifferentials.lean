import Definitions.SharedTensors.RationalCartier

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K] {p : ℕ}

/-- The literal fixed subgroup of an actual intrinsic rational Cartier
operator on the ORIGINAL universal differential module. -/
noncomputable def intrinsicCartierFixedSubgroup (C : RationalCartierOperator k K p) :
    AddSubgroup (KaehlerDifferential k K) :=
  (C.toAddHom - AddMonoidHom.id (KaehlerDifferential k K)).ker

@[simp] theorem mem_intrinsicCartierFixedSubgroup
    (C : RationalCartierOperator k K p) (omega : KaehlerDifferential k K) :
    omega ∈ intrinsicCartierFixedSubgroup C ↔ C.toAddHom omega = omega := by
  change C.toAddHom omega - omega = 0 ↔ _
  exact sub_eq_zero

end Litt3.CartierAndSpin
