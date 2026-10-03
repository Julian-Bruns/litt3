import Theorems.CurveArithmetic.CoefficientConjugates
import Mathlib.FieldTheory.Galois.Basic
import Mathlib.Tactic

namespace Litt3.CurveArithmetic

/-- All coefficients may be indexed by an infinite type; in particular
polynomial coefficient sequences need no arbitrary degree cutoff. -/
theorem coefficient_conjugates_injective
    {K L ι : Type*} [Field K] [Field L] [Algebra K L]
    (coefficient : ι → L)
    (hgenerates : IntermediateField.adjoin K (Set.range coefficient) = ⊤) :
    Function.Injective (fun σ : L ≃ₐ[K] L => fun i => σ (coefficient i)) := by
  intro σ τ hequal
  let E := IntermediateField.adjoin K (Set.range coefficient)
  have hrestriction : σ.toAlgHom.comp E.val = τ.toAlgHom.comp E.val := by
    apply IntermediateField.adjoin_algHom_ext K
    rintro x ⟨i, rfl⟩
    exact congrFun hequal i
  apply AlgEquiv.ext
  intro x
  have hx : x ∈ E := by change x ∈ IntermediateField.adjoin K (Set.range coefficient); rw [hgenerates]; trivial
  exact DFunLike.congr_fun hrestriction ⟨x, hx⟩

theorem coefficient_conjugates_target : Targets.CoefficientConjugatesInjective := by
  intro K L ι instK instL instAlgebra coefficient hgenerates
  exact coefficient_conjugates_injective coefficient hgenerates

/-- A finite Galois coefficient field cannot have degree larger than a
finite solution set containing all conjugate coefficient tuples. -/
theorem galois_coefficient_degree_le_constraint_count
    {K L ι : Type*} [Field K] [Field L] [Algebra K L]
    [FiniteDimensional K L] [IsGalois K L]
    (coefficient : ι → L)
    (hgenerates : IntermediateField.adjoin K (Set.range coefficient) = ⊤)
    (solutions : Finset (ι → L))
    (hsolutions : ∀ σ : L ≃ₐ[K] L, (fun i => σ (coefficient i)) ∈ solutions) :
    Module.finrank K L ≤ solutions.card := by
  classical
  letI := Fintype.ofFinite (L ≃ₐ[K] L)
  let observable : (L ≃ₐ[K] L) → {tuple // tuple ∈ solutions} :=
    fun σ => ⟨fun i => σ (coefficient i), hsolutions σ⟩
  have hinjective : Function.Injective observable := by
    intro σ τ h
    exact coefficient_conjugates_injective coefficient hgenerates (congrArg Subtype.val h)
  have hcard := Fintype.card_le_of_injective observable hinjective
  rw [Fintype.card_eq_nat_card, IsGalois.card_aut_eq_finrank] at hcard
  simpa using hcard

/-- In a finite field every extension is Galois, so the same count directly
bounds the constant-field degree. No Frobenius sampling is used. -/
theorem finite_field_coefficient_degree_le_constraint_count
    {K L ι : Type*} [Field K] [Field L] [Algebra K L] [Finite L]
    (coefficient : ι → L)
    (hgenerates : IntermediateField.adjoin K (Set.range coefficient) = ⊤)
    (solutions : Finset (ι → L))
    (hsolutions : ∀ σ : L ≃ₐ[K] L, (fun i => σ (coefficient i)) ∈ solutions) :
    Module.finrank K L ≤ solutions.card :=
  galois_coefficient_degree_le_constraint_count coefficient hgenerates solutions hsolutions

/-- The simultaneous Frobenius period of generating coefficients is
exactly their finite constant-field degree. This is valid for any index
set and for n=0 as well as every positive period. -/
theorem generating_coefficients_frobenius_period_iff
    {K L ι : Type*} [Field K] [Fintype K] [Field L] [Finite L] [Algebra K L]
    (coefficient : ι → L)
    (hgenerates : IntermediateField.adjoin K (Set.range coefficient) = ⊤) (n : ℕ) :
    (∀ i, coefficient i ^ (Fintype.card K ^ n) = coefficient i) ↔
      Module.finrank K L ∣ n := by
  let frob := FiniteField.frobeniusAlgEquivOfAlgebraic K L
  have hformula : ∀ x : L, (frob ^ n) x = x ^ (Fintype.card K ^ n) := by
    intro x
    change (FiniteField.frobeniusAlgEquivOfAlgebraic K L ^ n) x = _
    rw [AlgEquiv.coe_pow, FiniteField.coe_frobeniusAlgEquivOfAlgebraic_iterate]
  rw [← FiniteField.orderOf_frobeniusAlgEquivOfAlgebraic K L]
  change _ ↔ orderOf frob ∣ n
  rw [orderOf_dvd_iff_pow_eq_one]
  constructor
  · intro hfixed
    apply coefficient_conjugates_injective coefficient hgenerates
    funext i
    change (frob ^ n) (coefficient i) = coefficient i
    rw [hformula]
    exact hfixed i
  · intro hpower i
    rw [← hformula, hpower]
    rfl

end Litt3.CurveArithmetic
