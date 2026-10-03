import Theorems.QuotientGeometry.WeakValuativeDifferentProfile
import Solutions.QuotientGeometry.WeakAllRootNormalForms

namespace Litt3.QuotientGeometry

/-- Every chosen root has the full weak normal form directly from the
ORIGINAL valuation and genuine separating trace-different hypothesis.
No coefficient unit, root order or nonzero characteristic cast is
supplied. -/
theorem weak_valuative_different_all_roots_normal_form
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [CharP k p] [Fact p.Prime]
    (hp : 1 < p) (hh : 0 < h) (hdiv : h ∣ p - 1)
    (b : PowerSeries k) (hb : b.order = p * h)
    (hprofile : weakValuativeDifferentProfile p h hp hh b hb)
    (χ : LaurentSeries k) (hχ : χ ^ h = (b : LaurentSeries k)⁻¹) :
    χ.order = -(p : ℤ) ∧ (LaurentSeries.derivative k χ).order = -2 ∧
      weakPoleScalar p χ ≠ 0 ∧
      ∃ (α γ : k) (r : PowerSeries k), α ≠ 0 ∧ γ ≠ 0 ∧
        χ = HahnSeries.single (-(p : ℤ)) α + HahnSeries.single (-1) γ +
          (r : LaurentSeries k) := by
  have hcanonical := positive_parameter_canonical_factor (p * h) b hb
  exact weak_original_different_all_roots_normal_form p h hp hh hdiv
    (tame_degree_cast_ne_zero p h hh hdiv) b (PowerSeries.divXPowOrder b)
    hcanonical.1 hcanonical.2
    (positive_parameter_constant_zero (p * h) (Nat.mul_pos (by omega) hh) b hb)
    hprofile χ hχ

/-- The exact same-base scalar classification of TWO original
valuative different profiles. Both weak roots are constructed;
isomorphism of ENTIRE fixed-base fields is equivalent to scalar equality
for EVERY root choice. -/
theorem weak_two_valuative_different_profiles_equiv_iff
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [CharP k p] [Fact p.Prime]
    (hp : 1 < p) (hh : 0 < h) (hdiv : h ∣ p - 1)
    (b₁ b₂ : PowerSeries k) (hb₁ : b₁.order = p * h) (hb₂ : b₂.order = p * h)
    (hprofile₁ : weakValuativeDifferentProfile p h hp hh b₁ hb₁)
    (hprofile₂ : weakValuativeDifferentProfile p h hp hh b₂ hb₂) :
    let hc₁ := positive_parameter_canonical_factor (p * h) b₁ hb₁;
    let hc₂ := positive_parameter_canonical_factor (p * h) b₂ hb₂;
    let hb₁0 := positive_parameter_constant_zero (p * h) (Nat.mul_pos (by omega) hh) b₁ hb₁;
    let hb₂0 := positive_parameter_constant_zero (p * h) (Nat.mul_pos (by omega) hh) b₂ hb₂;
    let hi₁ := finite_parameter_substitution_injective (p * h)
      (Nat.mul_pos (by omega) hh) b₁ (PowerSeries.divXPowOrder b₁) hc₁.1 hc₁.2;
    let hi₂ := finite_parameter_substitution_injective (p * h)
      (Nat.mul_pos (by omega) hh) b₂ (PowerSeries.divXPowOrder b₂) hc₂.1 hc₂.2;
    let Ψ₁ := parameterLaurentMap b₁ hb₁0 hi₁;
    let Ψ₂ := parameterLaurentMap b₂ hb₂0 hi₂;
    ∃ (ψ₁ ψ₂ : LaurentSeries k),
      ψ₁ ^ h = (b₁ : LaurentSeries k)⁻¹ ∧
      ψ₂ ^ h = (b₂ : LaurentSeries k)⁻¹ ∧
      ∀ (χ₁ χ₂ : LaurentSeries k),
        χ₁ ^ h = (b₁ : LaurentSeries k)⁻¹ →
        χ₂ ^ h = (b₂ : LaurentSeries k)⁻¹ →
        (ParameterFieldsEquivalent Ψ₁ Ψ₂ ↔ weakPoleScalar p χ₁ = weakPoleScalar p χ₂) := by
  have hc₁ := positive_parameter_canonical_factor (p * h) b₁ hb₁
  have hc₂ := positive_parameter_canonical_factor (p * h) b₂ hb₂
  exact weak_two_original_different_profiles_equiv_iff p h hp hh hdiv
    (tame_degree_cast_ne_zero p h hh hdiv)
    b₁ (PowerSeries.divXPowOrder b₁) b₂ (PowerSeries.divXPowOrder b₂)
    hc₁.1 hc₂.1 hc₁.2 hc₂.2
    (positive_parameter_constant_zero (p * h) (Nat.mul_pos (by omega) hh) b₁ hb₁)
    (positive_parameter_constant_zero (p * h) (Nat.mul_pos (by omega) hh) b₂ hb₂)
    hprofile₁ hprofile₂

end Litt3.QuotientGeometry
