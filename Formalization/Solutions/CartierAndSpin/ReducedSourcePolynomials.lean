import Mathlib.RingTheory.AdjoinRoot
import Mathlib.Algebra.Polynomial.FieldDivision
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- Polynomial division gives the unique reduced polynomial representing
any element of the literal source quotient. No separability, monic
normalization input, or supplied power basis is needed. -/
theorem source_quotient_reduced_polynomial (F : K[X]) (hF : F ≠ 0)
    (value : AdjoinRoot F) :
    ∃! P : K[X], P.degree < F.degree ∧ AdjoinRoot.mk F P = value := by
  obtain ⟨Q, hQ⟩ := AdjoinRoot.mk_surjective value
  have hmk : AdjoinRoot.mk F (Q % F) = AdjoinRoot.mk F Q := by
    rw [EuclideanDomain.mod_eq_sub_mul_div, map_sub, map_mul,
      AdjoinRoot.mk_self, zero_mul, sub_zero]
  refine ⟨Q % F, ⟨degree_mod_lt Q hF, hmk.trans hQ⟩, ?_⟩
  intro P hP
  have hdvd : F ∣ P - Q % F := AdjoinRoot.mk_eq_mk.mp (hP.2.trans (hmk.trans hQ).symm)
  have hsmall : (P - Q % F).degree < F.degree :=
    (degree_sub_le P (Q % F)).trans_lt (max_lt hP.1 (degree_mod_lt Q hF))
  apply sub_eq_zero.mp
  by_contra hnonzero
  exact (not_le_of_gt hsmall) (degree_le_of_dvd hdvd hnonzero)

/-- The actual quotient representative of a remainder is unchanged. -/
theorem source_quotient_mk_remainder (F P : K[X]) :
    AdjoinRoot.mk F (P % F) = AdjoinRoot.mk F P := by
  rw [EuclideanDomain.mod_eq_sub_mul_div, map_sub, map_mul,
    AdjoinRoot.mk_self, zero_mul, sub_zero]

end Litt3.CartierAndSpin
