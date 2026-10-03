import Definitions.Deformations.TruncatedCoefficientRing
import Definitions.Deformations.CyclicCoordinates

namespace Litt3.Deformations

open Polynomial

variable (k : Type*) [CommRing k]

noncomputable instance truncatedInvertibleTwo (N : ℕ) [Invertible (2 : k)] :
    Invertible (2 : TruncatedCoefficientRing k N) where
  invOf := algebraMap k (TruncatedCoefficientRing k N) (⅟ (2 : k))
  invOf_mul_self := by
    have h := congrArg (algebraMap k (TruncatedCoefficientRing k N)) (invOf_mul_self (2 : k))
    simpa only [map_mul, map_ofNat, map_one] using h
  mul_invOf_self := by
    have h := congrArg (algebraMap k (TruncatedCoefficientRing k N)) (mul_invOf_self (2 : k))
    simpa only [map_mul, map_ofNat, map_one] using h

/-- The actual substitution homomorphism into the actual
truncated coefficient algebra, with its defining relation checked. -/
noncomputable def truncatedSubstitution (N : ℕ)
    (x : TruncatedCoefficientRing k N) (relation : x ^ N = 0) :
    TruncatedCoefficientRing k N →ₐ[k] TruncatedCoefficientRing k N :=
  AdjoinRoot.liftAlgHom ((X : Polynomial k) ^ N)
    (Algebra.ofId k (TruncatedCoefficientRing k N)) x
      (by simpa only [Polynomial.eval₂_pow, Polynomial.eval₂_X] using relation)

end Litt3.Deformations
