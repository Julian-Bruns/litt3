import Definitions.SharedTensors.CharacterBlocks
import Mathlib.RingTheory.Kaehler.Basic

namespace Litt3.SharedTensors

open Polynomial

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- The literal coefficient equations for dF+(eta+beta Z)F_Z-N beta F
in the actual module of rational Kahler differentials. -/
def KaehlerAffinePolynomialEquation
    (eta beta : KaehlerDifferential k K) (F : K[X]) : Prop :=
  ∀ i : ℕ, KaehlerDifferential.D k K (F.coeff i) =
    (-((i + 1 : ℕ) : K) * F.coeff (i + 1)) • eta +
      (((F.natDegree : K) - (i : K)) * F.coeff i) • beta

def NoKaehlerHomogeneousCharacters (beta : KaehlerDifferential k K)
    (V : Submodule k K) (p : ℕ) : Prop :=
  ∀ j : ℕ, 0 < j → j < p → ∀ a : K, a ∈ V →
    KaehlerDifferential.D k K a = ((j : K) * a) • beta → a = 0

def NoNonconstantKaehlerConstants (V : Submodule k K) : Prop :=
  ∀ a : K, a ∈ V → KaehlerDifferential.D k K a = 0 →
    ∃ c : k, algebraMap k K c = a

end Litt3.SharedTensors
