import Mathlib.RingTheory.AdjoinRoot
import Mathlib.Algebra.Algebra.Bilinear
import Mathlib.LinearAlgebra.Dual.Defs

namespace Litt3.CartierAndSpin

open Polynomial

variable {R : Type*} [CommRing R]

/-- The literal top-remainder functional on a monic polynomial quotient.
No separability or reducedness is part of this definition. -/
noncomputable def quotientResidueFunctional {D : R[X]} (hD : D.Monic) :
    Module.Dual R (AdjoinRoot D) :=
  (Polynomial.lcoeff R (D.natDegree - 1)).comp (AdjoinRoot.modByMonicHom hD)

/-- Multiplication followed by the actual quotient residue functional. -/
noncomputable def quotientResiduePairing {D : R[X]} (hD : D.Monic) :
    AdjoinRoot D →ₗ[R] Module.Dual R (AdjoinRoot D) :=
  (LinearMap.mul R (AdjoinRoot D)).compr₂ (quotientResidueFunctional hD)

end Litt3.CartierAndSpin
