import Definitions.Deformations.CyclicInversion
import Definitions.Deformations.TruncatedSubstitution
import Definitions.Deformations.TruncatedReflection

namespace Litt3.Deformations

variable (k : Type*) [CommRing k]

noncomputable instance cyclicGroupInvertibleTwo (N : ℕ) [Invertible (2 : k)] :
    Invertible (2 : CyclicGroupAlgebra k N) where
  invOf := algebraMap k (CyclicGroupAlgebra k N) (⅟ (2 : k))
  invOf_mul_self := by
    have h := congrArg (algebraMap k (CyclicGroupAlgebra k N)) (invOf_mul_self (2 : k))
    simpa only [map_mul, map_ofNat, map_one] using h
  mul_invOf_self := by
    have h := congrArg (algebraMap k (CyclicGroupAlgebra k N)) (mul_invOf_self (2 : k))
    simpa only [map_mul, map_ofNat, map_one] using h

end Litt3.Deformations
