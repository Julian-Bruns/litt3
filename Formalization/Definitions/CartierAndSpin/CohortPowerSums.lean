import Mathlib.RingTheory.MvPolynomial.Symmetric.NewtonIdentities

namespace Litt3.CartierAndSpin

open Finset

variable {K ι : Type*} [CommRing K] [Fintype ι]

/-- The actual power sum of a finite scalar family, with repetitions retained. -/
def finitePowerSum (u : ι → K) (k : ℕ) : K := ∑ i, u i ^ k

/-- The weighted power trace in the actual split algebra K^ι. -/
def finiteWeightedPowerSum (a u : ι → K) (j k : ℕ) : K :=
  ∑ i, a i ^ j * u i ^ k

/-- The actual elementary symmetric function of a finite scalar family. -/
noncomputable def finiteElementarySymmetric (u : ι → K) (k : ℕ) : K :=
  MvPolynomial.eval u (MvPolynomial.esymm ι K k)

/-- Weighted moments of explicitly assigned residue cohorts. No equality
between distinct cohort labels is built into this definition. -/
def cohortWeightedMoment {d : ℕ} (c : Fin d → K) (label : ι → Fin d)
    (u : ι → K) (j k : ℕ) : K :=
  ∑ i, c (label i) ^ j * u i ^ k

end Litt3.CartierAndSpin
