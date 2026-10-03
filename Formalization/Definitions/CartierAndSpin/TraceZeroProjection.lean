import Mathlib.RingTheory.Trace.Basic
import Mathlib.LinearAlgebra.BilinearForm.Properties

namespace Litt3.CartierAndSpin

open Module LinearMap
open LinearMap (BilinForm)

variable {K L : Type*} [Field K] [Field L] [Algebra K L]

noncomputable def normalizedTrace (n : ℕ) : L →ₗ[K] K :=
  (n : K)⁻¹ • Algebra.trace K L

noncomputable def traceZeroSpace (n : ℕ) : Submodule K L := LinearMap.ker (normalizedTrace (K := K) (L := L) n)

noncomputable def traceZeroProjection (n : ℕ) : L →ₗ[K] L :=
  LinearMap.id - (Algebra.linearMap K L).comp (normalizedTrace n)

noncomputable def normalizedTraceZeroPairing (n : ℕ) : BilinForm K (traceZeroSpace (K := K) (L := L) n) :=
  ((n : K)⁻¹ • Algebra.traceForm K L).restrict (traceZeroSpace n)

noncomputable def traceZeroCompressedMultiplication (n : ℕ) (epsilon : L) : L →ₗ[K] L :=
  (traceZeroProjection n).comp (LinearMap.mulLeft K epsilon)

end Litt3.CartierAndSpin
