import Definitions.CartierAndSpin.PurePowerQuotient
import Mathlib.LinearAlgebra.FiniteDimensional.Basic
import Mathlib.Algebra.MvPolynomial.Eval

namespace Litt3.CartierAndSpin.Specifications

variable {K : Type*} [Field K]

/-- The quotient-algebra assertion in `pure_power_pair_finite_algebra`.
The independent leading forms are encoded by their nonzero determinant;
lower terms have actual multivariate total degree less than `m`. -/
def PurePowerPairFiniteQuotient (m : ℕ) (a b c d : K)
    (R S : MvPolynomial (Fin 2) K) : Prop :=
  R.totalDegree < m → S.totalDegree < m → a * d - b * c ≠ 0 →
    Module.Finite K (MvPolynomial (Fin 2) K ⧸ purePowerPairIdeal m a b c d R S) ∧
    Module.finrank K (MvPolynomial (Fin 2) K ⧸ purePowerPairIdeal m a b c d R S) ≤ m ^ 2

/-- At most `m²` distinct solution pairs over any field extension. A finite
indexed family formulation avoids presupposing finiteness of the zero locus. -/
def PurePowerPairPointBound {Ω ι : Type*} [Field Ω] [Algebra K Ω] [Fintype ι]
    (m : ℕ) (a b c d : K) (R S : MvPolynomial (Fin 2) K)
    (point : ι → Ω × Ω) : Prop :=
  R.totalDegree < m → S.totalDegree < m → a * d - b * c ≠ 0 →
  Function.Injective point →
  (∀ i, MvPolynomial.aeval ![(point i).1, (point i).2] (purePowerPolynomial m a b R) = 0) →
  (∀ i, MvPolynomial.aeval ![(point i).1, (point i).2] (purePowerPolynomial m c d S) = 0) →
    Fintype.card ι ≤ m ^ 2

end Litt3.CartierAndSpin.Specifications
