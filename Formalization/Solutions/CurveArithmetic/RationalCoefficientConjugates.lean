import Theorems.CurveArithmetic.RationalCoefficientConjugates
import Solutions.CurveArithmetic.CoefficientConjugates
import Mathlib.Algebra.MvPolynomial.Eval
import Mathlib.Tactic

namespace Litt3.CurveArithmetic

theorem rational_coefficient_map_polynomial
    {L M : Type*} [Field L] [Field M] (φ : L →+* M) (p : Polynomial L) :
    rationalCoefficientMap φ (algebraMap (Polynomial L) (RatFunc L) p) =
      algebraMap (Polynomial M) (RatFunc M) (p.map φ) := by
  simpa only [Polynomial.coe_mapRingHom, map_one, div_one] using
    (RatFunc.map_apply_div (Polynomial.mapRingHom φ)
      (nonZeroDivisors_le_comap_nonZeroDivisors_of_injective
        (Polynomial.mapRingHom φ) (Polynomial.map_injective φ φ.injective)) p 1)

theorem rational_coefficient_conjugate_eq_map
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (σ : L ≃ₐ[K] L) (r : RatFunc L) :
    rationalCoefficientConjugate σ r = rationalCoefficientMap σ.toRingHom r := by
  exact (RatFunc.map_apply (Polynomial.mapRingHom σ.toRingHom)
    (nonZeroDivisors_le_comap_nonZeroDivisors_of_injective
      (Polynomial.mapRingHom σ.toRingHom)
      (Polynomial.map_injective σ.toRingHom σ.injective)) r).symm

/-- Coefficient extension respects actual composition of field maps. -/
theorem rational_coefficient_map_comp
    {L M N : Type*} [Field L] [Field M] [Field N]
    (φ : L →+* M) (ψ : M →+* N) :
    (rationalCoefficientMap ψ).comp (rationalCoefficientMap φ) =
      rationalCoefficientMap (ψ.comp φ) := by
  ext r
  rw [← RatFunc.num_div_denom r]
  simp only [RingHom.comp_apply, map_div₀, rational_coefficient_map_polynomial,
    Polynomial.map_map]

/-- Every rational function over the original constant field is fixed by
coefficient conjugation. This keeps the target field K(t) fixed. -/
theorem rational_coefficient_map_fixes_base
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (σ : L ≃ₐ[K] L) (r : RatFunc K) :
    rationalCoefficientMap σ.toRingHom (rationalCoefficientMap (algebraMap K L) r) =
      rationalCoefficientMap (algebraMap K L) r := by
  rw [← RatFunc.num_div_denom r]
  simp only [map_div₀, rational_coefficient_map_polynomial, Polynomial.map_map]
  have hcommutes : σ.toRingHom.comp (algebraMap K L) = algebraMap K L := by
    ext x
    exact σ.commutes x
  rw [hcommutes]

theorem rational_coefficient_map_comp_base
    {K L : Type*} [Field K] [Field L] [Algebra K L] (σ : L ≃ₐ[K] L) :
    (rationalCoefficientMap σ.toRingHom).comp (rationalCoefficientMap (algebraMap K L)) =
      rationalCoefficientMap (algebraMap K L) := by
  ext r
  exact rational_coefficient_map_fixes_base σ r

/-- Every polynomial relation with coefficients in K(t) survives actual
constant-field conjugation. This supplies the solution-set stability input
for the degree-count theorem below. -/
theorem rational_polynomial_relation_preserved_by_conjugation
    {K L ι : Type*} [Field K] [Field L] [Algebra K L]
    (σ : L ≃ₐ[K] L) (rational : ι → RatFunc L)
    (relation : MvPolynomial ι (RatFunc K))
    (hrelation : MvPolynomial.eval₂Hom (rationalCoefficientMap (algebraMap K L))
      rational relation = 0) :
    MvPolynomial.eval₂Hom (rationalCoefficientMap (algebraMap K L))
      (fun i => rationalCoefficientConjugate σ (rational i)) relation = 0 := by
  have h := congrArg (rationalCoefficientMap σ.toRingHom) hrelation
  rw [MvPolynomial.map_eval₂Hom, rational_coefficient_map_comp_base, map_zero] at h
  simpa only [← rational_coefficient_conjugate_eq_map] using h

/-- Uniqueness of a reduced rational representation with monic denominator.
Zero numerators are allowed. -/
theorem normalized_polynomial_fraction_unique
    {L : Type*} [Field L] (p q r s : Polynomial L)
    (hpq : IsCoprime p q) (hrs : IsCoprime r s)
    (hq : q.Monic) (hs : s.Monic)
    (hequal : algebraMap (Polynomial L) (RatFunc L) p /
        algebraMap (Polynomial L) (RatFunc L) q =
      algebraMap (Polynomial L) (RatFunc L) r /
        algebraMap (Polynomial L) (RatFunc L) s) : p = r ∧ q = s := by
  have hcross : p * s = r * q := by
    apply RatFunc.algebraMap_injective L
    simp only [map_mul]
    exact (div_eq_div_iff (RatFunc.algebraMap_ne_zero hq.ne_zero)
      (RatFunc.algebraMap_ne_zero hs.ne_zero)).mp hequal
  have hqdvd : q ∣ s := hpq.symm.dvd_of_dvd_mul_left (by rw [hcross]; exact dvd_mul_left q r)
  have hsdvd : s ∣ q := hrs.symm.dvd_of_dvd_mul_left (by rw [← hcross]; exact dvd_mul_left s p)
  have hdenominator : q = s := Polynomial.eq_of_monic_of_associated hq hs
    (associated_of_dvd_dvd hqdvd hsdvd)
  have hnumerator : p = r := by
    rw [← hdenominator] at hcross
    exact mul_right_cancel₀ hq.ne_zero hcross
  exact ⟨hnumerator, hdenominator⟩

/-- Injective field coefficient extension preserves the canonical
numerator and monic denominator, so it neither creates nor conceals
cancellation. -/
theorem rational_coefficient_map_normalized_pair
    {L M : Type*} [Field L] [Field M] (φ : L →+* M) (r : RatFunc L) :
    (rationalCoefficientMap φ r).num = r.num.map φ ∧
      (rationalCoefficientMap φ r).denom = r.denom.map φ := by
  apply normalized_polynomial_fraction_unique
  · exact RatFunc.isCoprime_num_denom _
  · exact (RatFunc.isCoprime_num_denom r).map (Polynomial.mapRingHom φ)
  · exact RatFunc.monic_denom _
  · exact (RatFunc.monic_denom r).map φ
  · rw [RatFunc.num_div_denom]
    exact RatFunc.map_apply (Polynomial.mapRingHom φ)
      (nonZeroDivisors_le_comap_nonZeroDivisors_of_injective
        (Polynomial.mapRingHom φ) (Polynomial.map_injective φ φ.injective)) r

theorem rational_coefficient_conjugate_equality_detects_normalized_pair
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (σ τ : L ≃ₐ[K] L) (r : RatFunc L)
    (hequal : rationalCoefficientConjugate σ r = rationalCoefficientConjugate τ r) :
    r.num.map σ.toRingHom = r.num.map τ.toRingHom ∧
      r.denom.map σ.toRingHom = r.denom.map τ.toRingHom := by
  apply normalized_polynomial_fraction_unique
  · exact (RatFunc.isCoprime_num_denom r).map (Polynomial.mapRingHom σ.toRingHom)
  · exact (RatFunc.isCoprime_num_denom r).map (Polynomial.mapRingHom τ.toRingHom)
  · exact (RatFunc.monic_denom r).map σ.toRingHom
  · exact (RatFunc.monic_denom r).map τ.toRingHom
  · exact hequal

theorem rational_coefficient_conjugates_injective
    {K L ι : Type*} [Field K] [Field L] [Algebra K L]
    (rational : ι → RatFunc L)
    (hgenerates : IntermediateField.adjoin K
      (Set.range (rationalFamilyCoefficients rational)) = ⊤) :
    Function.Injective (fun σ : L ≃ₐ[K] L => fun i =>
      rationalCoefficientConjugate σ (rational i)) := by
  intro σ τ hequal
  apply coefficient_conjugates_injective (rationalFamilyCoefficients rational) hgenerates
  funext index
  obtain ⟨i, which, n⟩ := index
  have hpair := rational_coefficient_conjugate_equality_detects_normalized_pair σ τ
    (rational i) (congrFun hequal i)
  cases which
  · have hcoefficient := congrArg (fun p : Polynomial L => p.coeff n) hpair.2
    simpa [rationalFamilyCoefficients] using hcoefficient
  · have hcoefficient := congrArg (fun p : Polynomial L => p.coeff n) hpair.1
    simpa [rationalFamilyCoefficients] using hcoefficient

theorem rational_coefficient_conjugates_target :
    Targets.RationalCoefficientConjugatesInjective := by
  intro K L ι instK instL instAlgebra rational hgenerates
  exact rational_coefficient_conjugates_injective rational hgenerates

/-- This is the coefficient-field degree bound for actual rational-function
families. For a pair use `ι=Fin 2`. The finite solution count can arise from
any system defined over the constant base field. -/
theorem finite_field_rational_family_degree_le_constraint_count
    {K L ι : Type*} [Field K] [Field L] [Algebra K L] [Finite L]
    (rational : ι → RatFunc L)
    (hgenerates : IntermediateField.adjoin K
      (Set.range (rationalFamilyCoefficients rational)) = ⊤)
    (solutions : Finset (ι → RatFunc L))
    (hsolutions : ∀ σ : L ≃ₐ[K] L,
      (fun i => rationalCoefficientConjugate σ (rational i)) ∈ solutions) :
    Module.finrank K L ≤ solutions.card := by
  classical
  letI := Fintype.ofFinite (L ≃ₐ[K] L)
  let observable : (L ≃ₐ[K] L) → {tuple // tuple ∈ solutions} :=
    fun σ => ⟨fun i => rationalCoefficientConjugate σ (rational i), hsolutions σ⟩
  have hinjective : Function.Injective observable := by
    intro σ τ h
    exact rational_coefficient_conjugates_injective rational hgenerates (congrArg Subtype.val h)
  have hcard := Fintype.card_le_of_injective observable hinjective
  rw [Fintype.card_eq_nat_card, IsGalois.card_aut_eq_finrank] at hcard
  simpa using hcard

end Litt3.CurveArithmetic
