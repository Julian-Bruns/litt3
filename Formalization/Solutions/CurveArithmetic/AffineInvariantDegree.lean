import Theorems.CurveArithmetic.AffineInvariantDegree
import Solutions.CurveArithmetic.AffineLineGroup
import Solutions.CurveArithmetic.FreeActionReturns
import Solutions.CurveArithmetic.ElementFrobeniusPeriod
import Mathlib.Tactic

namespace Litt3.CurveArithmetic

open Function

/-- The field degree of an actual parameter over the invariant field
has the sharp affine element-order alternative. The parameter may lie in
an infinite algebraic extension, and Frobenius may be over any larger
finite base field containing the invariant's coefficient field. -/
theorem finite_affine_invariant_field_degree_quotient
    {F K L : Type*} [Field F] [Fintype F] [Field K] [Fintype K] [Field L]
    [Algebra F K] [Algebra K L] [Algebra F L] [IsScalarTower F K L]
    [Algebra.IsAlgebraic K L] (p : ℕ) [Fact p.Prime] [CharP F p]
    (a : L) (ha : a ∉ Set.range (algebraMap F L)) :
    let d := Module.finrank K (IntermediateField.adjoin K {a})
    let m := Module.finrank K (IntermediateField.adjoin K {finiteAffineInvariant F a})
    m ∣ d ∧ (d / m = p ∨ d / m ∣ Fintype.card F - 1) := by
  let frob := FiniteField.frobeniusAlgEquivOfAlgebraic K L
  let invariant := finiteAffineInvariant F a
  let m := minimalPeriod frob invariant
  have hperiodInvariant : ∀ n, finiteAffineInvariant F ((frob ^ n) a) =
      (frob ^ n) invariant := by
    intro n
    simp only [invariant, finiteAffineInvariant, map_pow, map_sub]
  have hdivides : m ∣ minimalPeriod frob a := by
    apply (isPeriodicPt_iff_minimalPeriod_dvd).mp
    change frob^[minimalPeriod frob a] invariant = invariant
    rw [← AlgEquiv.coe_pow, ← hperiodInvariant]
    rw [AlgEquiv.coe_pow, iterate_minimalPeriod]
  have hm : m ≠ 0 := by
    have hpositive : 0 < m := by
      change 0 < minimalPeriod (FiniteField.frobeniusAlgEquivOfAlgebraic K L) invariant
      rw [single_element_frobenius_minimal_period]
      letI := IntermediateField.adjoin.finiteDimensional
        (Algebra.IsIntegral.isIntegral (R := K) invariant)
      exact Module.finrank_pos
    exact hpositive.ne'
  have hreturnInvariant : finiteAffineInvariant F (frob^[m] a) = invariant := by
    rw [← AlgEquiv.coe_pow, hperiodInvariant, AlgEquiv.coe_pow]
    exact iterate_minimalPeriod
  obtain ⟨coefficients, hcoefficients⟩ := (finiteAffineInvariantFiberEquiv a ha).surjective
    ⟨frob^[m] a, hreturnInvariant⟩
  let g : AffineLineGroup F := ⟨coefficients.1, coefficients.2⟩
  have hreturn : frob^[m] a = g • a := (congrArg Subtype.val hcoefficients).symm
  have hconstants : ∀ c : F, frob (algebraMap F L c) = algebraMap F L c := by
    intro c
    rw [IsScalarTower.algebraMap_apply F K L c, frob.commutes]
  have hcommute : ∀ (h : AffineLineGroup F) (x : L), frob (h • x) = h • frob x := by
    intro h x
    change frob (algebraMap F L h.linear.val * x + algebraMap F L h.translation) =
      algebraMap F L h.linear.val * frob x + algebraMap F L h.translation
    rw [map_add, map_mul, hconstants, hconstants]
  have hratio := free_action_return_period_quotient frob a m hm g
    (fun h hh => affine_line_stabilizer_nonbase_trivial a ha h hh) hcommute hreturn hdivides
  have halternative := finite_affine_element_order_alternatives p g
  rw [← hratio] at halternative
  change _ ∧ _
  constructor
  · simpa only [m, invariant, frob, single_element_frobenius_minimal_period] using hdivides
  · simpa only [m, invariant, frob, single_element_frobenius_minimal_period] using halternative

theorem finite_affine_invariant_degree_quotient_target :
    Targets.FiniteAffineInvariantDegreeQuotient := by
  intro F K L instF instFintypeF instK instFintypeK instL instFK instKL instFL
    instTower instAlgebraic p instPrime instChar a ha
  exact finite_affine_invariant_field_degree_quotient p a ha

theorem finite_affine_invariant_degree_bound
    {F K L : Type*} [Field F] [Fintype F] [Field K] [Fintype K] [Field L]
    [Algebra F K] [Algebra K L] [Algebra F L] [IsScalarTower F K L]
    [Algebra.IsAlgebraic K L] (p : ℕ) [Fact p.Prime] [CharP F p]
    (a : L) (ha : a ∉ Set.range (algebraMap F L)) :
    Module.finrank K (IntermediateField.adjoin K {a}) ≤
      Module.finrank K (IntermediateField.adjoin K {finiteAffineInvariant F a}) *
        max p (Fintype.card F - 1) := by
  obtain ⟨hdivides, halternative⟩ :=
    finite_affine_invariant_field_degree_quotient (F := F) (K := K) p a ha
  let d := Module.finrank K (IntermediateField.adjoin K {a})
  let m := Module.finrank K (IntermediateField.adjoin K {finiteAffineInvariant F a})
  have hbound : d / m ≤ max p (Fintype.card F - 1) := by
    rcases halternative with h | h
    · rw [h]
      exact le_max_left _ _
    · exact (Nat.le_of_dvd (Nat.sub_pos_of_lt Fintype.one_lt_card) h).trans (le_max_right _ _)
  change d ≤ m * max p (Fintype.card F - 1)
  calc
    d = (d / m) * m := (Nat.div_mul_cancel hdivides).symm
    _ ≤ m * max p (Fintype.card F - 1) := by
      simpa [Nat.mul_comm] using Nat.mul_le_mul_right m hbound

theorem prime_field_affine_invariant_degree_bound
    {F K L : Type*} [Field F] [Fintype F] [Field K] [Fintype K] [Field L]
    [Algebra F K] [Algebra K L] [Algebra F L] [IsScalarTower F K L]
    [Algebra.IsAlgebraic K L] (p : ℕ) [Fact p.Prime] [CharP F p]
    (hcard : Fintype.card F = p) (a : L) (ha : a ∉ Set.range (algebraMap F L)) :
    Module.finrank K (IntermediateField.adjoin K {a}) ≤
      Module.finrank K (IntermediateField.adjoin K {finiteAffineInvariant F a}) * p := by
  simpa only [hcard, max_eq_left (Nat.sub_le p 1)] using
    finite_affine_invariant_degree_bound (F := F) (K := K) p a ha

/-- Coprimality forces the invariant to retain the full parameter field
degree. It holds for arbitrary finite invariant coefficient fields. -/
theorem coprime_affine_invariant_degree_eq
    {F K L : Type*} [Field F] [Fintype F] [Field K] [Fintype K] [Field L]
    [Algebra F K] [Algebra K L] [Algebra F L] [IsScalarTower F K L]
    [Algebra.IsAlgebraic K L] (p : ℕ) [Fact p.Prime] [CharP F p]
    (a : L) (ha : a ∉ Set.range (algebraMap F L))
    (hcoprime : Nat.Coprime (Module.finrank K (IntermediateField.adjoin K {a}))
      (p * (Fintype.card F - 1))) :
    Module.finrank K (IntermediateField.adjoin K {finiteAffineInvariant F a}) =
      Module.finrank K (IntermediateField.adjoin K {a}) := by
  obtain ⟨hdivides, halternative⟩ :=
    finite_affine_invariant_field_degree_quotient (F := F) (K := K) p a ha
  let d := Module.finrank K (IntermediateField.adjoin K {a})
  let m := Module.finrank K (IntermediateField.adjoin K {finiteAffineInvariant F a})
  have hindexProduct : d / m ∣ p * (Fintype.card F - 1) := by
    rcases halternative with h | h
    · rw [h]
      exact dvd_mul_right _ _
    · exact h.trans (dvd_mul_left _ _)
  have hindexOne : d / m = 1 := by
    apply Nat.dvd_one.mp
    rw [← hcoprime.gcd_eq_one]
    exact Nat.dvd_gcd (Nat.div_dvd_of_dvd hdivides) hindexProduct
  have hproduct : (d / m) * m = d := Nat.div_mul_cancel hdivides
  rw [hindexOne, one_mul] at hproduct
  exact hproduct

end Litt3.CurveArithmetic
