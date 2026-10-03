import Mathlib.RingTheory.MvPolynomial.Ideal
import Mathlib.RingTheory.Ideal.Quotient.Operations
import Mathlib.Data.Finsupp.Basic

namespace Litt3.Deformations

variable (K : Type*) [CommRing K]

/-- The literal toric equation and all three original power relations. -/
noncomputable def toricHypersurfaceIdeal (Q R s : ℕ) : Ideal (MvPolynomial (Fin 3) K) :=
  Ideal.span ({MvPolynomial.X 0 * MvPolynomial.X 1 - MvPolynomial.X 2 ^ s,
    MvPolynomial.X 0 ^ Q, MvPolynomial.X 1 ^ Q, MvPolynomial.X 2 ^ R} : Set _)

abbrev ToricHypersurfaceAlgebra (Q R s : ℕ) :=
  MvPolynomial (Fin 3) K ⧸ toricHypersurfaceIdeal K Q R s

@[ext] structure ToricHypersurfaceData where
  x : ℕ
  y : ℕ
  z : ℕ
  deriving DecidableEq

def toricHypersurfaceNormalize (s : ℕ) (a : Fin 3 →₀ ℕ) : ToricHypersurfaceData :=
  ⟨a 0 - a 1, a 1 - a 0, a 2 + s * min (a 0) (a 1)⟩

/-- Exactly the surviving unchanged axis monomials after the original
toric and power relations; the two last bounds are derived relations. -/
def toricHypersurfaceSurvives (Q R s : ℕ) (a : ToricHypersurfaceData) : Prop :=
  (a.x = 0 ∨ a.y = 0) ∧ a.x < Q ∧ a.y < Q ∧ a.z < R ∧
    a.z < s * (Q - a.x) ∧ a.z < s * (Q - a.y)

abbrev ToricHypersurfaceNormalIndex (Q R s : ℕ) :=
  {a : ToricHypersurfaceData // toricHypersurfaceSurvives Q R s a}

noncomputable def toricHypersurfaceExponent (a : ToricHypersurfaceData) : Fin 3 →₀ ℕ :=
  Finsupp.single 0 a.x + Finsupp.single 1 a.y + Finsupp.single 2 a.z

end Litt3.Deformations
