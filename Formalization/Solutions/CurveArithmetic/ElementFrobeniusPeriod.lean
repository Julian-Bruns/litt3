import Solutions.CurveArithmetic.CoefficientConjugates
import Mathlib.Dynamics.PeriodicPts.Defs
import Mathlib.RingTheory.Finiteness.Cardinality
import Mathlib.Tactic

namespace Litt3.CurveArithmetic

open Function

/-- The exact Frobenius period of one actual element is the degree of
its smallest embedded field, even when it does not generate the ambient
finite extension. -/
theorem single_element_frobenius_period_iff
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    [Algebra.IsAlgebraic K L]
    (x : L) (n : ℕ) :
    x ^ (Fintype.card K ^ n) = x ↔
      Module.finrank K (IntermediateField.adjoin K {x}) ∣ n := by
  let E := IntermediateField.adjoin K {x}
  letI : FiniteDimensional K E := IntermediateField.adjoin.finiteDimensional
    (Algebra.IsIntegral.isIntegral x)
  letI : Finite E := Module.finite_of_finite (R := K)
  let generator : E := ⟨x, IntermediateField.subset_adjoin K {x} (Set.mem_singleton x)⟩
  let frob := FiniteField.frobeniusAlgEquivOfAlgebraic K E
  have hformula : ∀ y : E, (frob ^ n) y = y ^ (Fintype.card K ^ n) := by
    intro y
    change (FiniteField.frobeniusAlgEquivOfAlgebraic K E ^ n) y = _
    rw [AlgEquiv.coe_pow, FiniteField.coe_frobeniusAlgEquivOfAlgebraic_iterate]
  rw [← FiniteField.orderOf_frobeniusAlgEquivOfAlgebraic K E]
  change _ ↔ orderOf frob ∣ n
  rw [orderOf_dvd_iff_pow_eq_one]
  constructor
  · intro hpower
    have hgenerator : (frob ^ n) generator = generator := by
      rw [hformula]
      apply Subtype.ext
      exact hpower
    have hhom : (frob ^ n).toAlgHom = (1 : E ≃ₐ[K] E).toAlgHom := by
      apply IntermediateField.adjoin_algHom_ext K
      intro y hy
      have hyx : y = x := Set.mem_singleton_iff.mp hy
      subst y
      exact hgenerator
    apply AlgEquiv.ext
    intro y
    exact DFunLike.congr_fun hhom y
  · intro hpower
    have hgenerator : generator ^ (Fintype.card K ^ n) = generator := by
      rw [← hformula, hpower]
      rfl
    exact congrArg Subtype.val hgenerator

theorem single_element_frobenius_minimal_period
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    [Algebra.IsAlgebraic K L]
    (x : L) :
    minimalPeriod (FiniteField.frobeniusAlgEquivOfAlgebraic K L) x =
      Module.finrank K (IntermediateField.adjoin K {x}) := by
  let frob := FiniteField.frobeniusAlgEquivOfAlgebraic K L
  have hperiod : ∀ n, minimalPeriod frob x ∣ n ↔
      Module.finrank K (IntermediateField.adjoin K {x}) ∣ n := by
    intro n
    rw [← isPeriodicPt_iff_minimalPeriod_dvd]
    change frob^[n] x = x ↔ _
    change (FiniteField.frobeniusAlgEquivOfAlgebraic K L)^[n] x = x ↔ _
    rw [FiniteField.coe_frobeniusAlgEquivOfAlgebraic_iterate]
    exact single_element_frobenius_period_iff x n
  apply Nat.dvd_antisymm
  · exact (hperiod _).mpr (dvd_refl _)
  · exact (hperiod _).mp (dvd_refl _)

end Litt3.CurveArithmetic
