import Definitions.CurveArithmetic.FiniteAffineInvariant
import Mathlib.Algebra.MvPolynomial.Eval
import Mathlib.RingTheory.Ideal.Quotient.Operations

namespace Litt3.CurveArithmetic

noncomputable def finiteBranchPolynomial
    (K : Type*) [Field K] [Fintype K] {L : Type*} [CommRing L] (a : L) : Polynomial L :=
  (Polynomial.X ^ Fintype.card K - Polynomial.X) * (Polynomial.X - Polynomial.C a)

/-- The actual affine plane equation for the finite-field branch family.
The parameter lies in L while the finite branch set comes from K. -/
noncomputable def finiteBranchEquation
    (K : Type*) [Field K] [Fintype K] {L : Type*} [CommRing L] (a : L) :
    MvPolynomial (Fin 2) L :=
  MvPolynomial.X 1 ^ 2 -
    (MvPolynomial.X 0 ^ Fintype.card K - MvPolynomial.X 0) *
      (MvPolynomial.X 0 - MvPolynomial.C a)

noncomputable def finiteBranchIdeal
    (K : Type*) [Field K] [Fintype K] {L : Type*} [CommRing L] (a : L) :
    Ideal (MvPolynomial (Fin 2) L) := Ideal.span {finiteBranchEquation K a}

abbrev FiniteBranchCoordinateRing
    (K : Type*) [Field K] [Fintype K] {L : Type*} [CommRing L] (a : L) :=
  MvPolynomial (Fin 2) L ⧸ finiteBranchIdeal K a

/-- Simultaneous affine x-change and linear y-change on the actual
polynomial coordinate ring, over any commutative coefficient ring. -/
noncomputable def affinePlaneHom
    {L : Type*} [CommRing L] (u : Lˣ) (v : L) :
    MvPolynomial (Fin 2) L →ₐ[L] MvPolynomial (Fin 2) L :=
  MvPolynomial.aeval ![MvPolynomial.C u.val * MvPolynomial.X 0 + MvPolynomial.C v,
    MvPolynomial.C u.val * MvPolynomial.X 1]

end Litt3.CurveArithmetic
