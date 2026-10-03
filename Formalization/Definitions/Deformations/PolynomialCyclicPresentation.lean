import Mathlib.Algebra.Polynomial.Module.Basic
import Mathlib.Algebra.Polynomial.Inductions

namespace Litt3.Deformations

open Polynomial

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The source's literal cyclic group-relation polynomial. -/
noncomputable def cyclicGroupPolynomial (p a : ℕ) : R[X] := (1 + X) ^ (p ^ a) - 1

/-- The source's literal quotient F/e, using actual polynomial division by X. -/
noncomputable def cyclicGroupNormPolynomial (p a : ℕ) : R[X] := (cyclicGroupPolynomial (R := R) p a).divX

/-- The actual original polynomial scalar action on K[e], as an
endomorphism over the original coefficient ring. -/
noncomputable def polynomialScalarOperator (P : R[X]) : Module.End R (PolynomialModule R K) :=
  Polynomial.aeval (Finsupp.lmapDomain K R Nat.succ) P

noncomputable def polynomialCyclicOperator (p a : ℕ) : Module.End R (PolynomialModule R K) :=
  polynomialScalarOperator (cyclicGroupPolynomial (R := R) p a)

noncomputable def polynomialCyclicNormOperator (p a : ℕ) : Module.End R (PolynomialModule R K) :=
  polynomialScalarOperator (cyclicGroupNormPolynomial (R := R) p a)

/-- The actual original polynomial coefficient quotient K[e]/F K[e]. -/
abbrev PolynomialCyclicModule (p a : ℕ) :=
  PolynomialModule R K ⧸ LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)

end Litt3.Deformations
