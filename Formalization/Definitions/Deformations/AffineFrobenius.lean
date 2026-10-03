import Mathlib.FieldTheory.IsAlgClosed.Basic
import Mathlib.FieldTheory.Separable
import Mathlib.Algebra.Polynomial.Derivative
import Mathlib.Algebra.Polynomial.Degree.Operations
import Mathlib.SetTheory.Cardinal.Finite

namespace Litt3.Deformations

variable {k : Type*} [Field k]

/-- The scalar Frobenius-shaped equation at an arbitrary translation.
For actual Frobenius q is a characteristic-power; the more general
condition `(q : k)=0` already suffices for the exact root count. -/
noncomputable def affineFrobeniusPolynomial (q : ℕ) (translation : k) : Polynomial k :=
  Polynomial.X ^ q - Polynomial.X - Polynomial.C translation

/-- Actual solutions, not just a nonempty polynomial relaxation. -/
def ScalarFrobeniusSolutions (q : ℕ) (translation : k) :=
  {x : k // x ^ q - x = translation}

/-- Independent-coordinate affine Frobenius fixed points after an
actual rational basis has been chosen. -/
def CoordinateFrobeniusSolutions (q d : ℕ) (translation : Fin d → k) :=
  {x : Fin d → k // ∀ i, x i ^ q - x i = translation i}

/-- Literal affine Frobenius fixed points in the source convention
x maps to tau plus Frobenius(x). -/
def AffineFrobeniusFixedPoints (q d : ℕ) (translation : Fin d → k) :=
  {x : Fin d → k // ∀ i, translation i + x i ^ q = x i}

end Litt3.Deformations
