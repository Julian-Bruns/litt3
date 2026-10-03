import Theorems.CartierAndSpin.SourceCoefficientMoments
import Solutions.CartierAndSpin.SplitSourceAlgebra
import Solutions.CartierAndSpin.InverseSquareMoments

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {K ι : Type*} [Field K] [Fintype ι]

theorem splitSourceCoefficientMoments (node : ι → K) (F H : K[X])
    (p : ℕ) [CharP K p] (q tau c : K) :
    Specifications.SplitSourceCoefficientMoments node F H p q tau c := by
  intro hp hdegree hinj htau hc hFsplit hsource
  have hH : H ≠ 0 := by
    intro hzero
    have hnat : F.natDegree = 0 := by
      rw [hsource, hzero, mul_zero, zero_add, Polynomial.natDegree_C]
    omega
  obtain ⟨unit, hunit, hfirst⟩ := split_source_quotient_first_moments node hinj
    F H p q tau c (by omega) hH htau hc hFsplit hsource
  refine ⟨unit, hunit, ?_⟩
  intro j hj
  refine ⟨hfirst j hj, ?_⟩
  rw [split_algebra_trace_unit_inverse_power (splitPolynomialQuotientEquiv node hinj), hunit]
  simp_rw [splitPolynomialQuotientEquiv_mk, Polynomial.eval_add,
    Polynomial.eval_pow, Polynomial.eval_X, Polynomial.eval_C]
  exact split_inseparable_source_inverseSquare_moment univ node hinj.injOn
    F H p q tau c hp hH htau hc hFsplit hsource j hj

end Litt3.CartierAndSpin
