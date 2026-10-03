import Definitions.CartierAndSpin.CriticalContraction
import Mathlib.RingTheory.Valuation.Integers

namespace Litt3.CartierAndSpin.Specifications

open Polynomial

/-- The exact local clause of critical-pencil integrality: the actual
constant-minus-contraction value lies in the actual integer ring at
every critical root, including zero and repeated roots. -/
def CriticalContractionRootIntegral {R K : Type*} [CommRing R] [Field K]
    [Algebra R K] (D : R[X]) (n : ℕ → R) (d : ℕ) (constant : R) : Prop :=
  ∀ c : K, D.eval₂ (algebraMap R K) c = 0 →
    ∃ b : R, algebraMap R K b =
      (C constant - criticalTraceContraction D n d).eval₂ (algebraMap R K) c

end Litt3.CartierAndSpin.Specifications
