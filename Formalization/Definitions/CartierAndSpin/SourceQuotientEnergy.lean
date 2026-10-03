import Mathlib.RingTheory.AdjoinRoot
import Mathlib.RingTheory.Trace.Defs
import Mathlib.RingTheory.Derivation.Basic

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]

/-- Energy computed by the actual quotient algebra trace, including
disconnected or unsplit source algebras. -/
noncomputable def sourceQuotientDifferentialEnergy (F : K[X])
    (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)) (unit : (AdjoinRoot F)ˣ) : K :=
  Algebra.trace K (AdjoinRoot F) (E (AdjoinRoot.root F) ^ 2 * (↑unit⁻¹ : AdjoinRoot F))

noncomputable def sourceQuotientTwistedDifferentialEnergy (D : Derivation R K K)
    (F : K[X]) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F))
    (unit : (AdjoinRoot F)ˣ) (q : K) : K :=
  Algebra.trace K (AdjoinRoot F)
    ((E (AdjoinRoot.root F) - 2 * AdjoinRoot.root F *
      algebraMap K (AdjoinRoot F) (D q) * (↑unit⁻¹ : AdjoinRoot F)) ^ 2 *
        (↑unit⁻¹ : AdjoinRoot F))

end Litt3.CartierAndSpin
