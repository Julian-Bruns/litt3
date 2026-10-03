import Definitions.CurveArithmetic.FractionalLinearMaps
import Theorems.CurveArithmetic.FractionalLinearMaps
import Solutions.CurveArithmetic.FiniteAffineInvariant
import Mathlib.Algebra.Polynomial.Roots
import Mathlib.Tactic

namespace Litt3.CurveArithmetic

theorem fractional_linear_eval_injective
    {L : Type*} [Field L] (g : FractionalLinearData L) (x y : L)
    (hx : g.denominator x ≠ 0) (hy : g.denominator y ≠ 0)
    (hequal : g.eval x = g.eval y) : x = y := by
  have hcross := (div_eq_div_iff hx hy).mp hequal
  have hproduct :
      (g.numeratorLinear * g.denominatorConstant -
        g.numeratorConstant * g.denominatorLinear) * (x - y) = 0 := by
    unfold FractionalLinearData.denominator at hcross
    linear_combination hcross
  exact sub_eq_zero.mp ((mul_eq_zero.mp hproduct).resolve_left g.determinant_ne_zero)

theorem fractional_linear_frobenius_cross_vanishes
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (g : FractionalLinearData L) (x : K)
    (hx : g.denominator (algebraMap K L x) ≠ 0)
    (himage : g.eval (algebraMap K L x) ∈ Set.range (algebraMap K L)) :
    (g.frobeniusCrossPolynomial (Fintype.card K)).eval (algebraMap K L x) = 0 := by
  have hfixed := (finite_field_power_fixed_iff_in_base _).mpr himage
  let frob := FiniteField.frobeniusAlgHom K L
  have hFrob : frob (g.eval (algebraMap K L x)) = g.eval (algebraMap K L x) := hfixed
  unfold FractionalLinearData.eval FractionalLinearData.denominator at hFrob
  rw [map_div₀, map_add, map_mul, frob.commutes, map_add, map_mul, frob.commutes] at hFrob
  have hdenominator :
      g.denominatorLinear ^ Fintype.card K * algebraMap K L x +
        g.denominatorConstant ^ Fintype.card K ≠ 0 := by
    change frob (g.denominatorLinear) * _ + frob (g.denominatorConstant) ≠ 0
    rw [← frob.commutes x, ← map_mul, ← map_add]
    simpa only [map_zero] using frob.injective.ne hx
  have hcross := (div_eq_div_iff hdenominator hx).mp hFrob
  simp only [FractionalLinearData.frobeniusCrossPolynomial, Polynomial.eval_add,
    Polynomial.eval_mul, Polynomial.eval_pow, Polynomial.eval_C, Polynomial.eval_X]
  change _ = 0
  change (g.numeratorLinear ^ Fintype.card K * algebraMap K L x +
      g.numeratorConstant ^ Fintype.card K) *
      (g.denominatorLinear * algebraMap K L x + g.denominatorConstant) =
    (g.numeratorLinear * algebraMap K L x + g.numeratorConstant) *
      (g.denominatorLinear ^ Fintype.card K * algebraMap K L x +
        g.denominatorConstant ^ Fintype.card K) at hcross
  linear_combination hcross

theorem fractional_linear_frobenius_cross_degree_le
    {L : Type*} [Field L] (g : FractionalLinearData L) (q : ℕ) :
    (g.frobeniusCrossPolynomial q).natDegree ≤ 2 := by
  unfold FractionalLinearData.frobeniusCrossPolynomial
  compute_degree

theorem fractional_linear_frobenius_cross_zero_of_three_rational_images
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (g : FractionalLinearData L) (s : Finset K) (hcard : 3 ≤ s.card)
    (hdenominator : ∀ x ∈ s, g.denominator (algebraMap K L x) ≠ 0)
    (himage : ∀ x ∈ s, g.eval (algebraMap K L x) ∈ Set.range (algebraMap K L)) :
    g.frobeniusCrossPolynomial (Fintype.card K) = 0 := by
  classical
  apply Polynomial.eq_zero_of_natDegree_lt_card_of_eval_eq_zero
    (f := fun x : s => algebraMap K L x.val)
    _ ((algebraMap K L).injective.comp Subtype.val_injective)
  · intro x
    exact fractional_linear_frobenius_cross_vanishes g x.val
      (hdenominator x.val x.property) (himage x.val x.property)
  · have hdegree := fractional_linear_frobenius_cross_degree_le g (Fintype.card K)
    rw [Fintype.card_coe]
    omega

theorem fractional_linear_affine_of_frobenius_cross_zero
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (g : FractionalLinearData L)
    (hcross : g.frobeniusCrossPolynomial (Fintype.card K) = 0)
    (hdenominator : ∀ x : K, g.denominator (algebraMap K L x) ≠ 0) :
    g.denominatorLinear = 0 ∧
      ∃ (u : Kˣ) (v : K), ∀ x : L, g.eval x = finiteAffineTransform u v x := by
  have h2 := congrArg (fun p : Polynomial L => p.coeff 2) hcross
  have h1 := congrArg (fun p : Polynomial L => p.coeff 1) hcross
  have h0 := congrArg (fun p : Polynomial L => p.coeff 0) hcross
  simp only [FractionalLinearData.frobeniusCrossPolynomial, Polynomial.coeff_add,
    Polynomial.coeff_C_mul, Polynomial.coeff_X_pow, Polynomial.coeff_X,
    Polynomial.coeff_C] at h2 h1 h0
  norm_num at h2 h1 h0
  have hgamma : g.denominatorLinear = 0 := by
    by_contra hgamma
    have hproduct :
        (g.numeratorLinear * g.denominatorConstant -
          g.numeratorConstant * g.denominatorLinear) *
        (g.denominatorConstant ^ Fintype.card K * g.denominatorLinear -
          g.denominatorConstant * g.denominatorLinear ^ Fintype.card K) = 0 := by
      linear_combination g.denominatorConstant ^ 2 * h2 -
        g.denominatorConstant * g.denominatorLinear * h1 +
        g.denominatorLinear ^ 2 * h0
    have hdelta := (mul_eq_zero.mp hproduct).resolve_left g.determinant_ne_zero
    have hfixed : (g.denominatorConstant / g.denominatorLinear) ^ Fintype.card K =
        g.denominatorConstant / g.denominatorLinear := by
      rw [div_pow]
      exact (div_eq_div_iff (pow_ne_zero _ hgamma) hgamma).mpr (sub_eq_zero.mp hdelta)
    obtain ⟨c, hc⟩ := (finite_field_power_fixed_iff_in_base _).mp hfixed
    apply hdenominator (-c)
    unfold FractionalLinearData.denominator
    rw [map_neg, hc]
    field_simp
    ring
  have hdelta : g.denominatorConstant ≠ 0 := by
    intro hdelta
    apply g.determinant_ne_zero
    simp [hgamma, hdelta]
  have halpha : g.numeratorLinear ≠ 0 := by
    intro halpha
    apply g.determinant_ne_zero
    simp [hgamma, halpha]
  simp only [hgamma, zero_pow Fintype.card_pos.ne', mul_zero, zero_mul, add_zero, sub_zero] at h1
  have hfixedU : (g.numeratorLinear / g.denominatorConstant) ^ Fintype.card K =
      g.numeratorLinear / g.denominatorConstant := by
    rw [div_pow]
    exact (div_eq_div_iff (pow_ne_zero _ hdelta) hdelta).mpr (sub_eq_zero.mp h1)
  have hfixedV : (g.numeratorConstant / g.denominatorConstant) ^ Fintype.card K =
      g.numeratorConstant / g.denominatorConstant := by
    rw [div_pow]
    exact (div_eq_div_iff (pow_ne_zero _ hdelta) hdelta).mpr (sub_eq_zero.mp h0)
  obtain ⟨u, hu⟩ := (finite_field_power_fixed_iff_in_base _).mp hfixedU
  obtain ⟨v, hv⟩ := (finite_field_power_fixed_iff_in_base _).mp hfixedV
  have huNonzero : u ≠ 0 := by
    intro hzero
    have h := div_ne_zero halpha hdelta
    rw [← hu, hzero, map_zero] at h
    exact h rfl
  refine ⟨hgamma, Units.mk0 u huNonzero, v, ?_⟩
  intro x
  simp only [FractionalLinearData.eval, FractionalLinearData.denominator, hgamma,
    zero_mul, zero_add, finiteAffineTransform, Units.val_mk0]
  rw [hu, hv]
  ring

/-- Four base points suffice: at most one can have the exceptional
non-base image, so three rational images force the Frobenius polynomial
to vanish. The missing rational pole then forces an affine map. -/
theorem fractional_linear_affine_of_finite_branch_images
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (g : FractionalLinearData L) (hcard : 4 ≤ Fintype.card K) (b : L)
    (hdenominator : ∀ x : K, g.denominator (algebraMap K L x) ≠ 0)
    (himages : ∀ x : K, g.eval (algebraMap K L x) ∈ Set.range (algebraMap K L) ∨
      g.eval (algebraMap K L x) = b) :
    g.denominatorLinear = 0 ∧
      ∃ (u : Kˣ) (v : K), ∀ x : L, g.eval x = finiteAffineTransform u v x := by
  classical
  let good := Finset.univ.filter
    (fun x : K => g.eval (algebraMap K L x) ∈ Set.range (algebraMap K L))
  let bad := Finset.univ.filter
    (fun x : K => g.eval (algebraMap K L x) ∉ Set.range (algebraMap K L))
  have hbad : bad.card ≤ 1 := by
    apply Finset.card_le_one.mpr
    intro x hx y hy
    have hxBad := (Finset.mem_filter.mp hx).2
    have hyBad := (Finset.mem_filter.mp hy).2
    have hxequal := (himages x).resolve_left hxBad
    have hyequal := (himages y).resolve_left hyBad
    apply (algebraMap K L).injective
    exact fractional_linear_eval_injective g _ _ (hdenominator x) (hdenominator y)
      (hxequal.trans hyequal.symm)
  have hpartition : good.card + bad.card = Fintype.card K := by
    exact (Finset.card_filter_add_card_filter_not (s := Finset.univ) _).trans Finset.card_univ
  have hgood : 3 ≤ good.card := by omega
  apply fractional_linear_affine_of_frobenius_cross_zero g _ hdenominator
  apply fractional_linear_frobenius_cross_zero_of_three_rational_images g good hgood
  · intro x _
    exact hdenominator x
  · intro x hx
    exact (Finset.mem_filter.mp hx).2

theorem finite_affine_transform_nonbase
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (u : Kˣ) (v : K) (a : L) (ha : a ∉ Set.range (algebraMap K L)) :
    finiteAffineTransform u v a ∉ Set.range (algebraMap K L) := by
  rintro ⟨c, hc⟩
  apply ha
  refine ⟨(c - v) / u.val, ?_⟩
  rw [map_div₀, map_sub]
  have hu : algebraMap K L u.val ≠ 0 := by
    simpa only [map_zero] using (algebraMap K L).injective.ne u.ne_zero
  apply (div_eq_iff hu).mpr
  rw [hc]
  unfold finiteAffineTransform
  ring

/-- The full finite branch-set classification at the level of actual
nonsingular projective coefficient data. No markings of the base points
are fixed: they may be permuted or a priori sent to the moving point. -/
theorem fractional_linear_finite_branch_classification
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (g : FractionalLinearData L) (hcard : 4 ≤ Fintype.card K) (a b : L)
    (ha : a ∉ Set.range (algebraMap K L))
    (hdenominator : ∀ x : K, g.denominator (algebraMap K L x) ≠ 0)
    (himages : ∀ x : K, g.eval (algebraMap K L x) ∈ Set.range (algebraMap K L) ∨
      g.eval (algebraMap K L x) = b)
    (hmoving : g.eval a ∈ Set.range (algebraMap K L) ∨ g.eval a = b) :
    g.denominatorLinear = 0 ∧ ∃ (u : Kˣ) (v : K),
      b = finiteAffineTransform u v a ∧
      ∀ x : L, g.eval x = finiteAffineTransform u v x := by
  obtain ⟨hgamma, u, v, heval⟩ :=
    fractional_linear_affine_of_finite_branch_images g hcard b hdenominator himages
  have hnonbase : g.eval a ∉ Set.range (algebraMap K L) := by
    rw [heval]
    exact finite_affine_transform_nonbase u v a ha
  refine ⟨hgamma, u, v, ?_, heval⟩
  exact ((hmoving.resolve_left hnonbase).symm).trans (heval a)

theorem fractional_linear_finite_branch_classification_target :
    Targets.FiniteBranchFractionalLinearClassification := by
  intro K L _ _ _ _ g hcard a b ha hdenominator himages hmoving
  exact fractional_linear_finite_branch_classification g hcard a b ha hdenominator himages hmoving

theorem fractional_linear_nonbase_branch_stabilizer_trivial
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (g : FractionalLinearData L) (hcard : 4 ≤ Fintype.card K) (a : L)
    (ha : a ∉ Set.range (algebraMap K L))
    (hdenominator : ∀ x : K, g.denominator (algebraMap K L x) ≠ 0)
    (himages : ∀ x : K, g.eval (algebraMap K L x) ∈ Set.range (algebraMap K L) ∨
      g.eval (algebraMap K L x) = a)
    (hmoving : g.eval a ∈ Set.range (algebraMap K L) ∨ g.eval a = a) :
    ∀ x : L, g.eval x = x := by
  obtain ⟨_, u, v, hparameter, heval⟩ :=
    fractional_linear_finite_branch_classification g hcard a a ha hdenominator himages hmoving
  have hcoefficients : (u, v) = ((1 : Kˣ), (0 : K)) :=
    finite_affine_parameter_injective a ha
      (by simpa [finiteAffineTransform] using hparameter.symm)
  have hu : u = 1 := congrArg Prod.fst hcoefficients
  have hv : v = 0 := congrArg Prod.snd hcoefficients
  intro x
  rw [heval, hu, hv]
  simp [finiteAffineTransform]

/-- The rational boundary has all projective-line base points in its
branch set. It cannot map to a finite branch set with one exceptional
point: a finite image of infinity would require a nonzero denominator
linear coefficient, contradicted by the other branch images. -/
theorem fractional_linear_rational_projective_boundary_excluded
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (g : FractionalLinearData L) (hcard : 4 ≤ Fintype.card K) (b : L)
    (hdenominator : ∀ x : K, g.denominator (algebraMap K L x) ≠ 0)
    (himages : ∀ x : K, g.eval (algebraMap K L x) ∈ Set.range (algebraMap K L) ∨
      g.eval (algebraMap K L x) = b)
    (hinfinityFinite : g.denominatorLinear ≠ 0) : False := by
  exact hinfinityFinite
    (fractional_linear_affine_of_finite_branch_images g hcard b hdenominator himages).1

end Litt3.CurveArithmetic
