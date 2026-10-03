import Theorems.CurveArithmetic.AffineLineGroup
import Solutions.CurveArithmetic.FiniteAffineInvariant
import Mathlib.Tactic

namespace Litt3.CurveArithmetic

theorem affine_line_stabilizer_nonbase_trivial
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (a : L) (ha : a ∉ Set.range (algebraMap K L))
    (g : AffineLineGroup K) (hfixed : g • a = a) : g = 1 := by
  have hcoefficients : (g.linear, g.translation) = ((1 : Kˣ), (0 : K)) :=
    finite_affine_parameter_injective a ha (by simpa [finiteAffineTransform] using hfixed)
  exact AffineLineGroup.ext (congrArg Prod.fst hcoefficients) (congrArg Prod.snd hcoefficients)

/-- A transformation whose linear coefficient differs from one is
conjugate to its dilation by translation to its unique fixed point. -/
theorem affine_line_dilation_semiconjugate
    {K : Type*} [Field K] (g : AffineLineGroup K) (hlinear : g.linear ≠ 1) :
    SemiconjBy (affineLineTranslation (Multiplicative.ofAdd
      (g.translation / (1 - g.linear.val)))) (affineLineDilation g.linear) g := by
  have hdenominator : 1 - g.linear.val ≠ 0 :=
    sub_ne_zero.mpr (fun h => hlinear (Units.ext h.symm))
  apply AffineLineGroup.ext
  · simp [affineLineTranslation, affineLineDilation]
  · change (1 : K) * 0 + g.translation / (1 - g.linear.val) =
      g.linear.val * (g.translation / (1 - g.linear.val)) + g.translation
    simp only [mul_zero, zero_add]
    field_simp <;> ring

theorem affine_line_nondilation_order_dvd
    {K : Type*} [Field K] [Fintype K] (g : AffineLineGroup K) (hlinear : g.linear ≠ 1) :
    orderOf g ∣ Fintype.card K - 1 := by
  rw [← (affine_line_dilation_semiconjugate g hlinear).orderOf_eq]
  apply (orderOf_map_dvd affineLineDilation g.linear).trans
  apply orderOf_dvd_of_pow_eq_one
  apply Units.ext
  simpa only [Units.val_pow_eq_pow_val] using
    FiniteField.pow_card_sub_one_eq_one g.linear.val g.linear.ne_zero

theorem affine_line_translation_pow_char
    {K : Type*} [Field K] (p : ℕ) [CharP K p] (v : K) :
    affineLineTranslation (Multiplicative.ofAdd v) ^ p = 1 := by
  rw [← map_pow]
  have hpower : Multiplicative.ofAdd v ^ p = (1 : Multiplicative K) := by
    change p • v = 0
    rw [nsmul_eq_mul, CharP.cast_eq_zero, zero_mul]
  rw [hpower, map_one]

theorem affine_line_translation_order_prime
    {K : Type*} [Field K] (p : ℕ) [Fact p.Prime] [CharP K p]
    (g : AffineLineGroup K) (hlinear : g.linear = 1) (hne : g ≠ 1) : orderOf g = p := by
  have htranslation : g = affineLineTranslation (Multiplicative.ofAdd g.translation) := by
    exact AffineLineGroup.ext hlinear rfl
  have hdvd : orderOf g ∣ p := by
    apply orderOf_dvd_of_pow_eq_one
    rw [htranslation]
    exact affine_line_translation_pow_char p _
  rcases (Nat.dvd_prime (Fact.out : p.Prime)).mp hdvd with horder | horder
  · exact False.elim (hne (orderOf_eq_one_iff.mp horder))
  · exact horder

/-- Every element order is either the characteristic or divides q−1.
This is a structural group proof over every finite field. -/
theorem finite_affine_element_order_alternatives
    {K : Type*} [Field K] [Fintype K] (p : ℕ) [Fact p.Prime] [CharP K p]
    (g : AffineLineGroup K) : orderOf g = p ∨ orderOf g ∣ Fintype.card K - 1 := by
  by_cases hlinear : g.linear = 1
  · by_cases hidentity : g = 1
    · right
      simp [hidentity]
    · exact Or.inl (affine_line_translation_order_prime p g hlinear hidentity)
  · exact Or.inr (affine_line_nondilation_order_dvd g hlinear)

theorem finite_affine_element_order_alternatives_target :
    Targets.FiniteAffineElementOrderAlternatives := by
  intro K instK instFintype p instPrime instChar g
  exact finite_affine_element_order_alternatives p g

end Litt3.CurveArithmetic
