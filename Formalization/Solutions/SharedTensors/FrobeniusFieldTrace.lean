import Solutions.SharedTensors.FrobeniusCoordinates
import Mathlib.RingTheory.Trace.Basic
import Mathlib.Algebra.CharP.Frobenius

namespace Litt3.SharedTensors

variable {K L : Type*} [Field K] [Field L] [Algebra K L]
  [FiniteDimensional K L] [Algebra.IsSeparable K L]
variable {p : ℕ} [Fact p.Prime] [CharP L p]

/-- Frobenius commutes with the actual finite separable field trace.
The proof uses the full genuine embeddings, without a simultaneous
Galois closure or a bounded characteristic computation. -/
theorem finite_separable_trace_pth_power (a : L) :
    Algebra.trace K L (a ^ p) = (Algebra.trace K L a) ^ p := by
  let E := AlgebraicClosure L
  apply (algebraMap K E).injective
  rw [map_pow (algebraMap K E), trace_eq_sum_embeddings (E := E),
    trace_eq_sum_embeddings (E := E)]
  have hsum : (∑ sigma : L →ₐ[K] E, sigma a) ^ p =
      ∑ sigma : L →ₐ[K] E, (sigma a) ^ p := by
    exact map_sum (frobenius E p) _ _
  rw [hsum]
  apply Finset.sum_congr rfl
  intro sigma _
  exact map_pow sigma a p

end Litt3.SharedTensors
