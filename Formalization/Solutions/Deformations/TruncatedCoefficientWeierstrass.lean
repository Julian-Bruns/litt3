import Solutions.Deformations.TruncatedMonomialCompleteLocalRing
import Solutions.Deformations.TruncatedMonomialDimensions
import Mathlib.RingTheory.PowerSeries.WeierstrassPreparation
import Mathlib.RingTheory.IsAdjoinRoot

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (K I : Type*) [Field K] [Fintype I]

/-- On the actual original truncated coefficient ring, Weierstrass
preparation constructs a literal distinguished polynomial and a genuine
unit factor. Completeness is derived from the original generator powers. -/
theorem truncated_coefficient_weierstrass_preparation (q : I → ℕ) (positive : ∀ i, 0 < q i)
    [IsLocalRing (TruncatedMonomialAlgebra K I q)]
    (g : PowerSeries (TruncatedMonomialAlgebra K I q))
    (nonzero : g.map (IsLocalRing.residue (TruncatedMonomialAlgebra K I q)) ≠ 0) :
    ∃ f : Polynomial (TruncatedMonomialAlgebra K I q),
      f.Monic ∧ f.natDegree = (g.map (IsLocalRing.residue (TruncatedMonomialAlgebra K I q))).order.toNat ∧
        (∀ i < f.natDegree, f.coeff i ∈ truncatedMonomialAugmentationIdeal K I q) ∧
          ∃ u : (PowerSeries (TruncatedMonomialAlgebra K I q))ˣ,
            g = (f : PowerSeries (TruncatedMonomialAlgebra K I q)) *
              (u : PowerSeries (TruncatedMonomialAlgebra K I q)) := by
  letI := truncated_monomial_maximal_is_adic_complete K I q positive
  obtain ⟨f, h, factorization⟩ := g.exists_isWeierstrassFactorization nonzero
  refine ⟨f, factorization.isDistinguishedAt.monic, factorization.natDegree_eq_toNat_order_map,
    ?_, factorization.isUnit.unit, ?_⟩
  · intro i lower
    rw [truncated_monomial_augmentation_eq_maximal K I q positive]
    exact factorization.isDistinguishedAt.mem lower
  · simpa only [IsUnit.unit_spec] using factorization.eq_mul

/-- The full genuine one-variable formal-series hypersurface over
the actual truncated coefficient algebra has exact dimension given by
its ORIGINAL residue order. No preparation, rank or length conclusion
is supplied as an input. -/
theorem truncated_coefficient_series_hypersurface_finrank (q : I → ℕ) (positive : ∀ i, 0 < q i)
    [IsLocalRing (TruncatedMonomialAlgebra K I q)]
    (g : PowerSeries (TruncatedMonomialAlgebra K I q))
    (nonzero : g.map (IsLocalRing.residue (TruncatedMonomialAlgebra K I q)) ≠ 0) :
    Module.finrank K ((PowerSeries (TruncatedMonomialAlgebra K I q)) ⧸
      Ideal.span ({g} : Set (PowerSeries (TruncatedMonomialAlgebra K I q)))) =
        (g.map (IsLocalRing.residue (TruncatedMonomialAlgebra K I q))).order.toNat * ∏ i, q i := by
  let A := TruncatedMonomialAlgebra K I q
  letI : Nontrivial A := truncated_monomial_nontrivial K I q positive
  letI := truncated_monomial_maximal_is_adic_complete K I q positive
  let f := g.weierstrassDistinguished nonzero
  have factorization := g.isWeierstrassFactorization_weierstrassDistinguished_weierstrassUnit nonzero
  let equivalence := (g.algEquivQuotientWeierstrassDistinguished nonzero).restrictScalars K
  rw [← equivalence.toLinearEquiv.finrank_eq]
  change Module.finrank K (AdjoinRoot f) = _
  letI : Module.Free A (AdjoinRoot f) := factorization.isDistinguishedAt.monic.free_adjoinRoot
  have relative := finrank_quotient_span_eq_natDegree' factorization.isDistinguishedAt.monic
  change Module.finrank A (AdjoinRoot f) = f.natDegree at relative
  rw [← Module.finrank_mul_finrank K A (AdjoinRoot f), relative]
  change Module.finrank K (TruncatedMonomialAlgebra K I q) *
    (g.weierstrassDistinguished nonzero).natDegree = _
  rw [
    factorization.natDegree_eq_toNat_order_map, truncated_monomial_finrank K I q, mul_comm]

end Litt3.Deformations
