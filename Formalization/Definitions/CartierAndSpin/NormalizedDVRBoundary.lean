import Definitions.Jacobians.DVRDivisors
import Theorems.CartierAndSpin.ReciprocalTraceBoundary

namespace Litt3.CartierAndSpin

open scoped WithZero

/-- Integer order of a nonzero field element. The value at zero is irrelevant:
every conclusion below explicitly asserts nonvanishing. On actual field units
this agrees with the additive homomorphism `Jacobians.valuationOrder`.
The discrete valuation used in the specialization is normalized by its actual
height-one prime ideal, not by an assumed order function. -/
def integerFieldOrder {K : Type*} [Field K] (v : Valuation K ℤᵐ⁰) (x : K) : ℤ :=
  -WithZero.log (v x)

namespace Specifications

open Finset IsLocalRing Classical

def NormalizedDVRBoundaryOutcome {R K ι : Type*}
    [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
    [Field K] [Algebra R K] [IsFractionRing R K] [Fintype ι]
    (u : ι → K) (p : ℕ) : Prop :=
  TupleDescendsAsUnits (R := R) u ∨
    (Fintype.card ι = 2 * p ∧ ∀ i, u i ≠ 0) ∧
      ∃ M : ℤ, 0 < M ∧ ∃ i₀ j₀,
        integerFieldOrder ((Litt3.Jacobians.discreteValuationPlace R).valuation K) (u i₀) = -M ∧
        integerFieldOrder ((Litt3.Jacobians.discreteValuationPlace R).valuation K) (u j₀) = M ∧
        (univ.filter fun i => integerFieldOrder
          ((Litt3.Jacobians.discreteValuationPlace R).valuation K) (u i) = -M).card = p ∧
        (univ.filter fun i => integerFieldOrder
          ((Litt3.Jacobians.discreteValuationPlace R).valuation K) (u i) = M).card = p ∧
        (∀ i, integerFieldOrder
          ((Litt3.Jacobians.discreteValuationPlace R).valuation K) (u i) = -M ∨
          integerFieldOrder
          ((Litt3.Jacobians.discreteValuationPlace R).valuation K) (u i) = M) ∧
        (∃ b : ι → R, (∀ i, algebraMap R K (b i) = u i / u i₀) ∧
          ∀ i, residue R (b i) = if integerFieldOrder
            ((Litt3.Jacobians.discreteValuationPlace R).valuation K) (u i) = -M then 1 else 0) ∧
        (∃ b : ι → R, (∀ i, algebraMap R K (b i) = (u i)⁻¹ / (u j₀)⁻¹) ∧
          ∀ i, residue R (b i) = if integerFieldOrder
            ((Litt3.Jacobians.discreteValuationPlace R).valuation K) (u i) = M then 1 else 0) ∧
        finiteElementarySymmetric u p ≠ 0 ∧
        integerFieldOrder ((Litt3.Jacobians.discreteValuationPlace R).valuation K)
          (finiteElementarySymmetric u p) = -(p : ℤ) * M

end Specifications
end Litt3.CartierAndSpin
