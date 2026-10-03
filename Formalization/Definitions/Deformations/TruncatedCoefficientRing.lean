import Mathlib.RingTheory.AdjoinRoot
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse

namespace Litt3.Deformations

open Polynomial

variable (k : Type*) [CommRing k]

/-- The actual quotient k[z]/(z^N), with its algebra structure. -/
abbrev TruncatedCoefficientRing (N : ℕ) := AdjoinRoot ((X : Polynomial k) ^ N)

instance (N : ℕ) : Module.Free k (TruncatedCoefficientRing k N) :=
  (Polynomial.monic_X_pow N).free_adjoinRoot

instance (N : ℕ) : Module.Finite k (TruncatedCoefficientRing k N) :=
  (Polynomial.monic_X_pow N).finite_adjoinRoot

noncomputable def truncatedParameter (N : ℕ) : TruncatedCoefficientRing k N :=
  AdjoinRoot.root ((X : Polynomial k) ^ N)

/-- The actual residue homomorphism at z=0. A positive truncation
length is necessary for this residue map. -/
noncomputable def truncatedResidue (N : ℕ) (positive : 0 < N) :
    TruncatedCoefficientRing k N →+* k :=
  AdjoinRoot.lift (f := (X : Polynomial k) ^ N) (RingHom.id k) 0
    (by simp [positive.ne'])

end Litt3.Deformations
