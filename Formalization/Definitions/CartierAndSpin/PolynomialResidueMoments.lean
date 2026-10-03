import Mathlib.Algebra.Polynomial.FieldDivision

namespace Litt3.CartierAndSpin

open Polynomial

/-- The actual polynomial-quotient residue moment. Theorems give its
scope for nonzero source polynomials; no simple-root interpretation is
part of the definition. -/
noncomputable def polynomialResidueMoment {K : Type*} [Field K]
    (D P : K[X]) (j : ℕ) : K :=
  ((X ^ j * P) % D).coeff (D.natDegree - 1) / D.leadingCoeff

/-- Literal cubic inverse residue formula, retaining all critical
coefficient degree drops. -/
noncomputable def cubicResidueReconstruction {K : Type*} [CommRing K]
    (D : K[X]) (z : ℕ → K) : K[X] :=
  C (D.coeff 3 * z 2 + D.coeff 2 * z 1 + D.coeff 1 * z 0) +
    C (D.coeff 3 * z 1 + D.coeff 2 * z 0) * X + C (D.coeff 3 * z 0) * X ^ 2

end Litt3.CartierAndSpin
