import Mathlib.Algebra.Polynomial.Eval.Degree
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

namespace Litt3.Deformations

variable {k ι : Type*} [CommRing k]

/-- Literal coefficient matrix of polynomial representatives. -/
noncomputable def polynomialCoefficientMatrix
    (A : Matrix ι ι (Polynomial k)) (e : ℕ) : Matrix ι ι k :=
  fun i j => (A i j).coeff e

/-- The actual involution z maps to -z, combined with transpose. -/
noncomputable def polynomialHermitianTranspose
    (A : Matrix ι ι (Polynomial k)) : Matrix ι ι (Polynomial k) :=
  fun i j => (A j i).comp (-Polynomial.X)

/-- Hermitian symmetry in the actual truncated polynomial ring.
Divisibility of each entry difference is the concrete congruence
modulo z^N; it is stronger data than a guessed leading symmetry. -/
def IsTruncatedHermitian (N : ℕ) (A : Matrix ι ι (Polynomial k)) : Prop :=
  ∀ i j, Polynomial.X ^ N ∣ A i j - polynomialHermitianTranspose A i j

end Litt3.Deformations
