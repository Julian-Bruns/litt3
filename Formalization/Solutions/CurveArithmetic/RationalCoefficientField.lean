import Solutions.CurveArithmetic.RationalCoefficientConjugates
import Theorems.CurveArithmetic.RationalCoefficientField
import Mathlib.Algebra.Polynomial.Lifts
import Mathlib.RingTheory.Finiteness.Cardinality
import Mathlib.Tactic

namespace Litt3.CurveArithmetic

theorem polynomial_coefficient_range_finite
    {L : Type*} [Semiring L] (p : Polynomial L) : (Set.range p.coeff).Finite := by
  classical
  apply ((p.support.finite_toSet.image p.coeff).union (Set.finite_singleton 0)).subset
  rintro value ⟨n, rfl⟩
  by_cases hn : n ∈ p.support
  · exact Or.inl ⟨n, hn, rfl⟩
  · exact Or.inr (Polynomial.notMem_support_iff.mp hn)

theorem rational_family_coefficient_range_finite
    {L ι : Type*} [Field L] [Finite ι] (rational : ι → RatFunc L) :
    (Set.range (rationalFamilyCoefficients rational)).Finite := by
  apply (Set.finite_iUnion fun i : ι =>
    (polynomial_coefficient_range_finite (rational i).num).union
      (polynomial_coefficient_range_finite (rational i).denom)).subset
  rintro value ⟨⟨i, which, n⟩, rfl⟩
  apply Set.mem_iUnion.mpr
  refine ⟨i, ?_⟩
  cases which
  · exact Or.inr ⟨n, rfl⟩
  · exact Or.inl ⟨n, rfl⟩

/-- Algebraic coefficients of any finite rational-function family generate
a finite constant-field extension, with no height or degree cutoff. -/
theorem rational_coefficient_field_finite_dimensional
    {K L ι : Type*} [Field K] [Field L] [Algebra K L]
    [Algebra.IsAlgebraic K L] [Finite ι] (rational : ι → RatFunc L) :
    FiniteDimensional K (rationalCoefficientField (K := K) rational) := by
  letI := (rational_family_coefficient_range_finite rational).fintype
  apply IntermediateField.finiteDimensional_adjoin
  intro x _hx
  exact Algebra.IsIntegral.isIntegral x

theorem rational_coefficient_field_finite
    {K L ι : Type*} [Field K] [Finite K] [Field L] [Algebra K L]
    [Algebra.IsAlgebraic K L] [Finite ι] (rational : ι → RatFunc L) :
    Finite (rationalCoefficientField (K := K) rational) := by
  letI := rational_coefficient_field_finite_dimensional (K := K) rational
  exact Module.finite_of_finite (R := K)

/-- The coefficient field is defined as an embedded adjoin, so its
automorphisms are detected by the lifted coefficients without an extra
generation hypothesis. -/
theorem coefficient_field_automorphisms_injective
    {K L ι : Type*} [Field K] [Field L] [Algebra K L]
    (rational : ι → RatFunc L) :
    Function.Injective (fun σ : rationalCoefficientField (K := K) rational ≃ₐ[K]
      rationalCoefficientField (K := K) rational => fun index =>
        σ (rationalFamilyCoefficientLift (K := K) rational index)) := by
  intro σ τ hequal
  have heq : σ.toAlgHom = τ.toAlgHom := by
    apply IntermediateField.adjoin_algHom_ext K
    rintro x ⟨index, rfl⟩
    exact congrFun hequal index
  apply AlgEquiv.ext
  intro x
  exact DFunLike.congr_fun heq x

theorem polynomial_lifts_to_embedded_field
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (E : IntermediateField K L) (p : Polynomial L)
    (hcoefficients : ∀ n, p.coeff n ∈ E) :
    ∃ q : Polynomial E, q.map E.val.toRingHom = p := by
  apply (Polynomial.mem_lifts (f := E.val.toRingHom) p).mp
  apply (Polynomial.lifts_iff_coeff_lifts (f := E.val.toRingHom) p).mpr
  intro n
  exact ⟨⟨p.coeff n, hcoefficients n⟩, rfl⟩

/-- Every member descends as an actual rational function over the embedded
coefficient field. The map fixes the indeterminate and the conclusion
uses an explicit fraction-field homomorphism. -/
theorem rational_family_member_descends_to_coefficient_field
    {K L ι : Type*} [Field K] [Field L] [Algebra K L]
    (rational : ι → RatFunc L) (i : ι) :
    ∃ descended : RatFunc (rationalCoefficientField (K := K) rational),
      rationalCoefficientMap (rationalCoefficientField (K := K) rational).val.toRingHom descended =
        rational i := by
  let E := rationalCoefficientField (K := K) rational
  have hn : ∀ n, (rational i).num.coeff n ∈ E := by
    intro n
    exact IntermediateField.subset_adjoin K _
      ⟨(i, true, n), rfl⟩
  have hd : ∀ n, (rational i).denom.coeff n ∈ E := by
    intro n
    exact IntermediateField.subset_adjoin K _
      ⟨(i, false, n), rfl⟩
  obtain ⟨numerator, hnum⟩ := polynomial_lifts_to_embedded_field E (rational i).num hn
  obtain ⟨denominator, hdenom⟩ := polynomial_lifts_to_embedded_field E (rational i).denom hd
  refine ⟨algebraMap (Polynomial E) (RatFunc E) numerator /
      algebraMap (Polynomial E) (RatFunc E) denominator, ?_⟩
  rw [map_div₀, rational_coefficient_map_polynomial, rational_coefficient_map_polynomial,
    hnum, hdenom]
  exact RatFunc.num_div_denom (rational i)

theorem rational_coefficient_field_finite_descent_target :
    Targets.RationalCoefficientFieldFiniteDescent := by
  intro K L ι instK instL instAlgebra instAlgebraic instFinite rational
  refine ⟨rational_coefficient_field_finite_dimensional rational, ?_⟩
  exact Classical.axiom_of_choice
    (rational_family_member_descends_to_coefficient_field (K := K) rational)

/-- The smallest coefficient field is characterized by actual rational
descent. There are no restrictions on the family size or ambient extension. -/
theorem rational_family_descends_iff_coefficient_field_le
    {K L ι : Type*} [Field K] [Field L] [Algebra K L]
    (rational : ι → RatFunc L) (E : IntermediateField K L) :
    (∃ descended : ι → RatFunc E, ∀ i,
      rationalCoefficientMap E.val.toRingHom (descended i) = rational i) ↔
      rationalCoefficientField (K := K) rational ≤ E := by
  constructor
  · rintro ⟨descended, hdescends⟩
    apply IntermediateField.adjoin_le_iff.mpr
    rintro value ⟨⟨i, which, n⟩, rfl⟩
    have hpair := rational_coefficient_map_normalized_pair E.val.toRingHom (descended i)
    rw [hdescends i] at hpair
    cases which
    · change (rational i).denom.coeff n ∈ E
      rw [hpair.2, Polynomial.coeff_map]
      exact ((descended i).denom.coeff n).property
    · change (rational i).num.coeff n ∈ E
      rw [hpair.1, Polynomial.coeff_map]
      exact ((descended i).num.coeff n).property
  · intro hfield
    refine Classical.axiom_of_choice (r := fun i (r : RatFunc E) =>
      rationalCoefficientMap E.val.toRingHom r = rational i) ?_
    intro i
    have hn : ∀ n, (rational i).num.coeff n ∈ E := fun n => hfield
      (IntermediateField.subset_adjoin K _ ⟨(i, true, n), rfl⟩)
    have hd : ∀ n, (rational i).denom.coeff n ∈ E := fun n => hfield
      (IntermediateField.subset_adjoin K _ ⟨(i, false, n), rfl⟩)
    obtain ⟨numerator, hnum⟩ := polynomial_lifts_to_embedded_field E (rational i).num hn
    obtain ⟨denominator, hdenom⟩ := polynomial_lifts_to_embedded_field E (rational i).denom hd
    refine ⟨algebraMap (Polynomial E) (RatFunc E) numerator /
      algebraMap (Polynomial E) (RatFunc E) denominator, ?_⟩
    dsimp only
    rw [map_div₀, rational_coefficient_map_polynomial, rational_coefficient_map_polynomial,
      hnum, hdenom]
    exact RatFunc.num_div_denom (rational i)

/-- Relations defined over K(t) descend through an actual embedded
coefficient field, because the coefficient-extension map is injective. -/
theorem rational_polynomial_relation_descends
    {K L ι : Type*} [Field K] [Field L] [Algebra K L]
    (E : IntermediateField K L) (rational : ι → RatFunc L)
    (descended : ι → RatFunc E)
    (hdescends : ∀ i, rationalCoefficientMap E.val.toRingHom (descended i) = rational i)
    (relation : MvPolynomial ι (RatFunc K))
    (hrelation : MvPolynomial.eval₂Hom (rationalCoefficientMap (algebraMap K L))
      rational relation = 0) :
    MvPolynomial.eval₂Hom (rationalCoefficientMap (algebraMap K E))
      descended relation = 0 := by
  apply (rationalCoefficientMap E.val.toRingHom).injective
  rw [map_zero, MvPolynomial.map_eval₂Hom, rational_coefficient_map_comp]
  have hbase : E.val.toRingHom.comp (algebraMap K E) = algebraMap K L := by
    ext x
    exact E.val.commutes x
  rw [hbase]
  have htuple : (fun i => rationalCoefficientMap E.val.toRingHom (descended i)) =
      rational := funext hdescends
  rw [htuple]
  exact hrelation

/-- All coefficient-field conjugates of a descended family retain the
original K(t)-relations after embedding back into the ambient field. -/
theorem embedded_rational_polynomial_relation_preserved_by_conjugation
    {K L ι : Type*} [Field K] [Field L] [Algebra K L]
    (E : IntermediateField K L) (rational : ι → RatFunc L)
    (descended : ι → RatFunc E)
    (hdescends : ∀ i, rationalCoefficientMap E.val.toRingHom (descended i) = rational i)
    (σ : E ≃ₐ[K] E) (relation : MvPolynomial ι (RatFunc K))
    (hrelation : MvPolynomial.eval₂Hom (rationalCoefficientMap (algebraMap K L))
      rational relation = 0) :
    MvPolynomial.eval₂Hom (rationalCoefficientMap (algebraMap K L))
      (fun i => rationalCoefficientMap E.val.toRingHom
        (rationalCoefficientConjugate σ (descended i))) relation = 0 := by
  have hdescended := rational_polynomial_relation_descends E rational descended hdescends
    relation hrelation
  have hconjugated := rational_polynomial_relation_preserved_by_conjugation σ descended
    relation hdescended
  have h := congrArg (rationalCoefficientMap E.val.toRingHom) hconjugated
  rw [MvPolynomial.map_eval₂Hom, rational_coefficient_map_comp, map_zero] at h
  have hbase : E.val.toRingHom.comp (algebraMap K E) = algebraMap K L := by
    ext x
    exact E.val.commutes x
  simpa only [hbase] using h

/-- A family descending to its smallest coefficient field distinguishes
all its automorphisms. No further generation assumption is required. -/
theorem descended_coefficient_field_conjugates_injective
    {K L ι : Type*} [Field K] [Field L] [Algebra K L]
    (rational : ι → RatFunc L)
    (descended : ι → RatFunc (rationalCoefficientField (K := K) rational))
    (hdescends : ∀ i,
      rationalCoefficientMap (rationalCoefficientField (K := K) rational).val.toRingHom
        (descended i) = rational i) :
    Function.Injective (fun σ : rationalCoefficientField (K := K) rational ≃ₐ[K]
      rationalCoefficientField (K := K) rational => fun i =>
        rationalCoefficientConjugate σ (descended i)) := by
  intro σ τ hequal
  apply coefficient_field_automorphisms_injective rational
  funext index
  obtain ⟨i, which, n⟩ := index
  have hnormalized := rational_coefficient_map_normalized_pair
    (rationalCoefficientField (K := K) rational).val.toRingHom (descended i)
  rw [hdescends i] at hnormalized
  have hpair := rational_coefficient_conjugate_equality_detects_normalized_pair σ τ
    (descended i) (congrFun hequal i)
  have hcoefficient : rationalFamilyCoefficientLift (K := K) rational (i, which, n) =
      if which then (descended i).num.coeff n else (descended i).denom.coeff n := by
    apply Subtype.ext
    cases which
    · simpa [rationalFamilyCoefficientLift, rationalFamilyCoefficients, Polynomial.coeff_map]
        using congrArg (fun p : Polynomial L => p.coeff n) hnormalized.2
    · simpa [rationalFamilyCoefficientLift, rationalFamilyCoefficients, Polynomial.coeff_map]
        using congrArg (fun p : Polynomial L => p.coeff n) hnormalized.1
  change σ (rationalFamilyCoefficientLift (K := K) rational (i, which, n)) =
    τ (rationalFamilyCoefficientLift (K := K) rational (i, which, n))
  rw [hcoefficient]
  cases which
  · simpa using congrArg (fun p : Polynomial (rationalCoefficientField (K := K) rational) =>
      p.coeff n) hpair.2
  · simpa using congrArg (fun p : Polynomial (rationalCoefficientField (K := K) rational) =>
      p.coeff n) hpair.1

/-- A finite solution set bounds the actual smallest embedded constant
field of a rational family over an algebraic extension of a finite field.
The family is retained through its explicit coefficient-extension map. -/
theorem rational_coefficient_field_degree_le_constraint_count
    {K L ι : Type*} [Field K] [Finite K] [Field L] [Algebra K L]
    [Algebra.IsAlgebraic K L] [Finite ι] (rational : ι → RatFunc L)
    (descended : ι → RatFunc (rationalCoefficientField (K := K) rational))
    (hdescends : ∀ i,
      rationalCoefficientMap (rationalCoefficientField (K := K) rational).val.toRingHom
        (descended i) = rational i)
    (solutions : Finset (ι → RatFunc L))
    (hsolutions : ∀ σ : rationalCoefficientField (K := K) rational ≃ₐ[K]
      rationalCoefficientField (K := K) rational,
      (fun i => rationalCoefficientMap (rationalCoefficientField (K := K) rational).val.toRingHom
        (rationalCoefficientConjugate σ (descended i))) ∈ solutions) :
    Module.finrank K (rationalCoefficientField (K := K) rational) ≤ solutions.card := by
  classical
  let E := rationalCoefficientField (K := K) rational
  letI : FiniteDimensional K E := rational_coefficient_field_finite_dimensional rational
  letI : Finite E := rational_coefficient_field_finite rational
  letI := Fintype.ofFinite (E ≃ₐ[K] E)
  let observable : (E ≃ₐ[K] E) → {tuple // tuple ∈ solutions} := fun σ =>
    ⟨fun i => rationalCoefficientMap E.val.toRingHom
      (rationalCoefficientConjugate σ (descended i)), hsolutions σ⟩
  have hinjective : Function.Injective observable := by
    intro σ τ h
    apply descended_coefficient_field_conjugates_injective rational descended hdescends
    funext i
    apply (rationalCoefficientMap E.val.toRingHom).injective
    exact congrFun (congrArg Subtype.val h) i
  have hcard := Fintype.card_le_of_injective observable hinjective
  rw [Fintype.card_eq_nat_card, IsGalois.card_aut_eq_finrank] at hcard
  simpa using hcard

end Litt3.CurveArithmetic
