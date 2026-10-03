import Definitions.Deformations.TruncatedCoefficientRing
import Mathlib.Algebra.Star.Basic

namespace Litt3.Deformations

open Polynomial

variable (k : Type*) [CommRing k]

/-- The actual reflection homomorphism of k[z]/z^N, fixing all
coefficients and mapping the actual nilpotent parameter to -z. -/
noncomputable def truncatedReflection (N : ℕ) :
    TruncatedCoefficientRing k N →+* TruncatedCoefficientRing k N :=
  AdjoinRoot.lift (f := (X : Polynomial k) ^ N)
    (AdjoinRoot.of ((X : Polynomial k) ^ N)) (-truncatedParameter k N) (by
      rw [Polynomial.eval₂_pow, Polynomial.eval₂_X, neg_pow]
      have h := AdjoinRoot.eval₂_root ((X : Polynomial k) ^ N)
      have hn : truncatedParameter k N ^ N = 0 := by
        simpa only [Polynomial.eval₂_pow, Polynomial.eval₂_X] using h
      rw [hn, mul_zero])

end Litt3.Deformations
