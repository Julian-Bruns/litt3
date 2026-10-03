import Definitions.CartierAndSpin.ValuationIntegrality

namespace Litt3.CartierAndSpin.Specifications

open Finset IsLocalRing Classical

variable {R K Γ ι : Type*} [CommRing R] [IsLocalRing R] [Field K]
  [Algebra R K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

def TupleDescendsAsUnits (u : ι → K) : Prop :=
  ∀ i, ∃ b : R, IsUnit b ∧ algebraMap R K b = u i

/-- Complete reciprocal-trace boundary conclusion, stated through actual
valuations, actual normalized leading residues, and the actual elementary
symmetric coefficient. It includes the precise pole valuation of e_p. -/
def ReciprocalTraceBoundaryOutcome (v : Valuation K Γ) (u : ι → K) (p : ℕ) : Prop :=
  TupleDescendsAsUnits (R := R) u ∨
    (Fintype.card ι = 2 * p ∧ ∃ i₀ j₀,
      1 < v (u i₀) ∧ 1 < v ((u j₀)⁻¹) ∧
      (univ.filter fun i => v (u i) = v (u i₀)).card = p ∧
      (univ.filter fun i => v ((u i)⁻¹) = v ((u j₀)⁻¹)).card = p ∧
      (∀ i, v (u i) = v (u i₀) ∨ v (u i) = v (u j₀)) ∧
      v (u i₀) * v (u j₀) = 1 ∧
      (∃ b : ι → R, (∀ i, algebraMap R K (b i) = u i / u i₀) ∧
        ∀ i, residue R (b i) = if v (u i) = v (u i₀) then 1 else 0) ∧
      (∃ b : ι → R, (∀ i, algebraMap R K (b i) = (u i)⁻¹ / (u j₀)⁻¹) ∧
        ∀ i, residue R (b i) = if v ((u i)⁻¹) = v ((u j₀)⁻¹) then 1 else 0) ∧
      v (finiteElementarySymmetric u p) = v (u i₀) ^ p ∧
      1 < v (finiteElementarySymmetric u p))

end Litt3.CartierAndSpin.Specifications
