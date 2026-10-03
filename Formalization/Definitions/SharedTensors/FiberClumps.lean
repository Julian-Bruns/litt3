import Definitions.SharedTensors.DivisorRelations

namespace Litt3.SharedTensors

attribute [local instance] Classical.propDecidable

variable {X Y Z : Type*}

/-- A nonempty finite fiber relation on the two actual endpoint point
sets. Its source set is the same inverse image under both legs. -/
structure FiberClump (f : Z → X) (g : Z → Y) where
  left : Set X
  right : Set Y
  left_finite : left.Finite
  right_finite : right.Finite
  left_nonempty : left.Nonempty
  right_nonempty : right.Nonempty
  same_source : f ⁻¹' left = g ⁻¹' right

noncomputable def reducedSetDivisor (s : Set X) (hs : s.Finite) :
    Litt3.Jacobians.Divisor X :=
  Finsupp.ofSupportFinite (fun x => if x ∈ s then 1 else 0) (by
    classical
    apply hs.subset
    intro x hx
    by_contra h
    exact hx (if_neg h))

end Litt3.SharedTensors
