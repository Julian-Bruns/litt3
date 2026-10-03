import Mathlib.RingTheory.Derivation.MapCoeffs
import Mathlib.RingTheory.AdjoinRoot

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K : Type*} [CommRing R] [CommRing K] [Algebra R K]

/-- The actual coefficientwise derivation from Mathlib's polynomial
module constructor. No new coefficient-function abstraction is used. -/
noncomputable def sourceCoefficientDerivation (D : Derivation R K K) :
    Derivation R K[X] K[X] :=
  PolynomialModule.equivPolynomialSelf.compDer D.mapCoeffs

/-- A polynomial derivation extending D and prescribing D(X)=v. -/
noncomputable def sourcePolynomialDerivation (D : Derivation R K K) (v : K[X]) :
    Derivation R K[X] K[X] :=
  sourceCoefficientDerivation D + v • Polynomial.derivative'.restrictScalars R

end Litt3.CartierAndSpin
