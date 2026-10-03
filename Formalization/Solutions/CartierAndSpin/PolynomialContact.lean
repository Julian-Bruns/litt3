import Theorems.CartierAndSpin.PolynomialContact
import Mathlib.Tactic.Ring
import Mathlib.RingTheory.Localization.FractionRing

/-!
# Polynomial endpoint rigidity

This formalizes the exact algebraic cross-difference argument in
`hermite_endpoint_interpolation`. Polynomial zeros and both endpoint section
frames are explicit; node equations never divide by a denominator.
-/

namespace Litt3.CartierAndSpin

open Polynomial

variable {R : Type*} [CommRing R] [IsDomain R]

omit [IsDomain R] in
theorem natDegree_add_order_le_of_infinity_vanishing (H : R[X]) (N e : ℕ)
    (hH : H ≠ 0) (hvan : polynomialSectionVanishesAtInfinity H N e) :
    H.natDegree + e ≤ N := by
  by_contra h
  have hcoeff := hvan H.natDegree (by omega)
  exact (Polynomial.leadingCoeff_ne_zero.mpr hH) (by
    simpa only [Polynomial.coeff_natDegree] using hcoeff)

theorem polynomialEndpointRigidity (H : R[X]) (s : Finset R)
    (N ezero einfinity : ℕ) :
    Specifications.PolynomialEndpointRigidity H s N ezero einfinity := by
  classical
  intro hnonzero hroots hzero hinfinity hcount
  by_contra hH
  obtain ⟨G, hfactor⟩ := hzero
  have hG : G ≠ 0 := by
    intro hz
    apply hH
    rw [hfactor, hz, mul_zero]
  have hdegree := natDegree_add_order_le_of_infinity_vanishing H N einfinity hH hinfinity
  have hdegree_product : H.natDegree = ezero + G.natDegree := by
    rw [hfactor, Polynomial.natDegree_mul (pow_ne_zero ezero Polynomial.X_ne_zero) hG,
      Polynomial.natDegree_X_pow]
  have hGdegree : G.natDegree < s.card := by omega
  apply hG
  apply Polynomial.eq_zero_of_natDegree_lt_card_of_eval_eq_zero' G s
  · intro z hz
    have h := hroots z hz
    rw [hfactor, Polynomial.eval_mul, Polynomial.eval_pow, Polynomial.eval_X] at h
    exact (mul_eq_zero.mp h).resolve_left (pow_ne_zero ezero (hnonzero z hz))
  · exact hGdegree

omit [IsDomain R] in
theorem polynomialCrossDifference_common_part_cancels (P f T g U : R[X]) :
    polynomialCrossDifference (P * T + f) T (P * U + g) U =
      polynomialCrossDifference f T g U := by
  unfold polynomialCrossDifference
  ring

omit [IsDomain R] in
/-- The nodal equation is valid even when either or both denominators vanish. -/
theorem polynomialCrossDifference_eval_zero (F T G U : R[X]) (z b : R)
    (hF : F.eval z = b * T.eval z) (hG : G.eval z = b * U.eval z) :
    (polynomialCrossDifference F T G U).eval z = 0 := by
  simp only [polynomialCrossDifference, Polynomial.eval_sub, Polynomial.eval_mul, hF, hG]
  ring

omit [IsDomain R] in
theorem polynomialCrossDifference_degree_bound (f T g U : R[X]) (a d : ℕ)
    (hf : f.natDegree ≤ a + d) (hg : g.natDegree ≤ a + d)
    (hT : T.natDegree ≤ d) (hU : U.natDegree ≤ d) :
    (polynomialCrossDifference f T g U).natDegree ≤ a + 2 * d := by
  apply le_trans (Polynomial.natDegree_sub_le (f * U) (g * T))
  apply max_le
  · have h : (f * U).natDegree ≤ f.natDegree + U.natDegree := Polynomial.natDegree_mul_le
    omega
  · have h : (g * T).natDegree ≤ g.natDegree + T.natDegree := Polynomial.natDegree_mul_le
    omega

/-- The complete polynomial cross-difference rigidity argument with finite
conditions and both endpoint orders. A unit denominator is not needed at a
node; endpoint contact is supplied in the actual polynomial section frame. -/
theorem polynomialCrossDifference_zero_of_endpoint_conditions
    (P f T g U : R[X]) (C V : Finset R) (b : R → R) (N ezero einfinity : ℕ)
    (hdisjoint : Disjoint C V)
    (hnonzero : ∀ z, z ∈ C ∨ z ∈ V → z ≠ 0)
    (hFC : ∀ z ∈ C, (P * T + f).eval z = 0)
    (hGC : ∀ z ∈ C, (P * U + g).eval z = 0)
    (hFV : ∀ z ∈ V, (P * T + f).eval z = b z * T.eval z)
    (hGV : ∀ z ∈ V, (P * U + g).eval z = b z * U.eval z)
    (hzero : X ^ ezero ∣ polynomialCrossDifference f T g U)
    (hinfinity : polynomialSectionVanishesAtInfinity
      (polynomialCrossDifference f T g U) N einfinity)
    (hcount : N < C.card + V.card + ezero + einfinity) :
    polynomialCrossDifference f T g U = 0 := by
  classical
  apply polynomialEndpointRigidity (polynomialCrossDifference f T g U)
    (C ∪ V) N ezero einfinity (fun z hz => hnonzero z (Finset.mem_union.mp hz))
  · intro z hz
    rw [← polynomialCrossDifference_common_part_cancels P f T g U]
    rcases Finset.mem_union.mp hz with hz | hz
    · apply polynomialCrossDifference_eval_zero _ _ _ _ z 0
      · simpa only [zero_mul] using hFC z hz
      · simpa only [zero_mul] using hGC z hz
    · exact polynomialCrossDifference_eval_zero _ _ _ _ z (b z) (hFV z hz) (hGV z hz)
  · exact hzero
  · exact hinfinity
  · simpa only [Finset.card_union_of_disjoint hdisjoint] using hcount

omit [IsDomain R] in
/-- The zero cross product gives equality of actual rational quotients. -/
theorem polynomial_ratio_eq_of_crossDifference_zero {L : Type*} [Field L]
    [Algebra R[X] L] [IsFractionRing R[X] L]
    (f T g U : R[X]) (hT : T ≠ 0) (hU : U ≠ 0)
    (hcross : polynomialCrossDifference f T g U = 0) :
    algebraMap R[X] L f / algebraMap R[X] L T =
      algebraMap R[X] L g / algebraMap R[X] L U := by
  have hmap := IsFractionRing.injective R[X] L
  have hTmap : algebraMap R[X] L T ≠ 0 := by
    intro hz
    apply hT
    apply hmap
    simpa using hz
  have hUmap : algebraMap R[X] L U ≠ 0 := by
    intro hz
    apply hU
    apply hmap
    simpa using hz
  apply (div_eq_div_iff hTmap hUmap).mpr
  unfold polynomialCrossDifference at hcross
  rw [← map_mul, ← map_mul]
  exact congrArg (algebraMap R[X] L) (sub_eq_zero.mp hcross)

end Litt3.CartierAndSpin
