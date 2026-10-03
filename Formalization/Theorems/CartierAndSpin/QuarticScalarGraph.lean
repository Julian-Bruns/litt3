import Solutions.CartierAndSpin.TraceCompression
import Definitions.CartierAndSpin.KummerMatrices
import Definitions.CartierAndSpin.KummerElements
import Mathlib.FieldTheory.IntermediateField.Adjoin.Algebra

namespace Litt3.CartierAndSpin.Specifications

open Module LinearMap

variable {K L : Type*} [Field K] [Field L] [Algebra K L]
    [FiniteDimensional K L] [Algebra.IsSeparable K L]

def ActualQuarticScalarGraph (hdim : finrank K L = 4) (hfour : (4 : K) ≠ 0)
    (M : traceZeroSpace (K := K) (L := L) 4 →ₗ[K] traceZeroSpace (K := K) (L := L) 4)
    (epsilon : L) : Prop :=
  epsilon ∉ Set.range (algebraMap K L) ∧
    ∃ a : traceZeroSpace (K := K) (L := L) 4 →ₗ[K] K,
      M = traceZeroCompression 4 hdim hfour epsilon +
        a.smulRight (traceZeroProjectionToSpace 4 hdim hfour epsilon)

def QuarticScalarGraphRecovery (hdim : finrank K L = 4) (hfour : (4 : K) ≠ 0) : Prop :=
  let V := traceZeroSpace (K := K) (L := L) 4
  let B := normalizedTraceZeroPairing (K := K) (L := L) 4
  let adj := B.leftAdjointOfNondegenerate (normalizedTraceZeroPairing_nondegenerate 4 hdim hfour)
  (∀ M : V →ₗ[K] V, M - adj M ≠ 0 → finrank K (LinearMap.ker (M - adj M)) = 1) ∧
  (∀ M : V →ₗ[K] V, ∀ epsilon : L, ∀ a : V →ₗ[K] K,
    M = traceZeroCompression 4 hdim hfour epsilon +
      a.smulRight (traceZeroProjectionToSpace 4 hdim hfour epsilon) →
    M - adj M ≠ 0 → ∀ k : V, (k : L) ≠ 0 → (M - adj M) k = 0 →
      epsilon = (M k : L) / (k : L)) ∧
  (∀ k z : L, ∀ r : K, r ≠ 0 → (r • z) / (r • k) = z / k) ∧
  (∀ M : V →ₗ[K] V, ∀ epsilon : L, ∀ basis : Basis (Fin 3) K V,
    ActualQuarticScalarGraph hdim hfour M epsilon ↔
    epsilon ∉ Set.range (algebraMap K L) ∧
      ∀ i, M (basis i) - traceZeroCompression 4 hdim hfour epsilon (basis i) ∈
        Submodule.span K ({traceZeroProjectionToSpace 4 hdim hfour epsilon} : Set V)) ∧
  (∀ M : V →ₗ[K] V, ∀ k z : L, LinearIndependent K ![k, z] →
    ∀ basis : Basis (Fin 3) K V,
    ActualQuarticScalarGraph hdim hfour M (z/k) ↔
    ∀ i, k * (M (basis i) : L) - z * (basis i : L) ∈
      Submodule.span K ({k, z} : Set L)) ∧
  (∀ t : L, ∀ m : K, m ≠ 0 → t ^ 4 = algebraMap K L m →
    IntermediateField.adjoin K ({t} : Set L) = ⊤ →
    ∃ basis : Basis (Fin 4) K L, ∃ bV : Basis (Fin 3) K V,
      (∀ i : Fin 4, basis i = t ^ (i : ℕ)) ∧
      (∀ i : Fin 3, (bV i : L) = t ^ ((i : ℕ) + 1)) ∧
      (∀ M : V →ₗ[K] V,
        let A := LinearMap.toMatrix bV bV M
        let k := bV.equivFun.symm (kummerSkewKernelCoordinates A)
        (M - adj M) k = 0 ∧ (k = 0 ↔ M = adj M) ∧
        ((k : L) = (A 1 2 - A 0 1) • t + (A 0 0 - A 2 2) • t ^ 2 +
          (A 2 1 - A 1 0) • t ^ 3)) ∧
      (∀ a b c d : K, kummerElement t a b c d ∉ Set.range (algebraMap K L) →
        ∀ f : V →ₗ[K] K, ∀ M : V →ₗ[K] V,
        M = traceZeroCompression 4 hdim hfour (kummerElement t a b c d) +
          f.smulRight (traceZeroProjectionToSpace 4 hdim hfour (kummerElement t a b c d)) →
        M = adj M → ![b, c, d] ≠ 0 ∧ ∃ kappa : K, LinearMap.toMatrix bV bV M =
          kummerCompressionMatrix m a b c d + kappa • kummerBoundaryMatrix m b c d))

end Litt3.CartierAndSpin.Specifications
