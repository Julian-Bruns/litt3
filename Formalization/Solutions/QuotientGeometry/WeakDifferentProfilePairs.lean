import Theorems.QuotientGeometry.WeakCompletedDifferentProfile
import Solutions.QuotientGeometry.WeakDifferentClassification

namespace Litt3.QuotientGeometry

/-- An actual original trace-different profile supplies every root/order
input to classification of the entire fixed-base Laurent extension. -/
theorem weak_different_profile_classification
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [CharP k p] [Fact p.Prime]
    (hp : 1 < p) (hh : 0 < h) (hdiv : h ∣ p - 1) (hchar : (h : k) ≠ 0)
    (b c : PowerSeries k) (hb : b = PowerSeries.X ^ (p * h) * c)
    (hc : PowerSeries.constantCoeff c ≠ 0) (hb0 : PowerSeries.constantCoeff b = 0)
    (hprofile : weakCompletedDifferentProfile p h hp hh b c hb hc hb0) :
    let hi := finite_parameter_substitution_injective (p * h)
      (Nat.mul_pos (by omega) hh) b c hb hc;
    let Ψ := parameterLaurentMap b hb0 hi;
    ∃ ψ : LaurentSeries k,
      ψ ^ h = (b : LaurentSeries k)⁻¹ ∧
      ψ.order = -(p : ℤ) ∧ (LaurentSeries.derivative k ψ).order = -2 ∧
      (∀ (χβ : PowerSeries k →ₐ[k] PowerSeries k)
        (Ωβ : LaurentSeries k →+* LaurentSeries k),
        (∀ f : PowerSeries k, Ωβ (f : LaurentSeries k) = (χβ f : PowerSeries k)) →
        ∀ χ : LaurentSeries k,
          χ ^ h = Ωβ (HahnSeries.single (-1) 1) →
          χ.order = -(p : ℤ) → (LaurentSeries.derivative k χ).order = -2 →
          (ParameterFieldsEquivalent Ψ Ωβ ↔ weakPoleScalar p ψ = weakPoleScalar p χ)) ∧
      (∀ χ : LaurentSeries k, χ ^ h = (b : LaurentSeries k)⁻¹ →
        weakPoleScalar p ψ = weakPoleScalar p χ) := by
  exact weak_different_parameter_classification p h hp hh hdiv hchar b c hb hc hb0
    hprofile.1 hprofile.2

/-- TWO genuine original separating trace-different profiles over the
SAME full base are isomorphic exactly when their actual scalars agree.
The weak roots and both order conditions are DERIVED from the profiles;
the equivalence holds for EVERY choice of either h-th root. -/
theorem weak_two_original_different_profiles_equiv_iff
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [CharP k p] [Fact p.Prime]
    (hp : 1 < p) (hh : 0 < h) (hdiv : h ∣ p - 1) (hchar : (h : k) ≠ 0)
    (b₁ c₁ b₂ c₂ : PowerSeries k)
    (hb₁ : b₁ = PowerSeries.X ^ (p * h) * c₁)
    (hb₂ : b₂ = PowerSeries.X ^ (p * h) * c₂)
    (hc₁ : PowerSeries.constantCoeff c₁ ≠ 0)
    (hc₂ : PowerSeries.constantCoeff c₂ ≠ 0)
    (hb₁0 : PowerSeries.constantCoeff b₁ = 0)
    (hb₂0 : PowerSeries.constantCoeff b₂ = 0)
    (hprofile₁ : weakCompletedDifferentProfile p h hp hh b₁ c₁ hb₁ hc₁ hb₁0)
    (hprofile₂ : weakCompletedDifferentProfile p h hp hh b₂ c₂ hb₂ hc₂ hb₂0) :
    let hi₁ := finite_parameter_substitution_injective (p * h)
      (Nat.mul_pos (by omega) hh) b₁ c₁ hb₁ hc₁;
    let hi₂ := finite_parameter_substitution_injective (p * h)
      (Nat.mul_pos (by omega) hh) b₂ c₂ hb₂ hc₂;
    let Ψ₁ := parameterLaurentMap b₁ hb₁0 hi₁;
    let Ψ₂ := parameterLaurentMap b₂ hb₂0 hi₂;
    ∃ (ψ₁ ψ₂ : LaurentSeries k),
      ψ₁ ^ h = (b₁ : LaurentSeries k)⁻¹ ∧
      ψ₂ ^ h = (b₂ : LaurentSeries k)⁻¹ ∧
      ∀ (χ₁ χ₂ : LaurentSeries k),
        χ₁ ^ h = (b₁ : LaurentSeries k)⁻¹ →
        χ₂ ^ h = (b₂ : LaurentSeries k)⁻¹ →
        (ParameterFieldsEquivalent Ψ₁ Ψ₂ ↔ weakPoleScalar p χ₁ = weakPoleScalar p χ₂) := by
  let hi₁ := finite_parameter_substitution_injective (p * h)
    (Nat.mul_pos (by omega) hh) b₁ c₁ hb₁ hc₁
  let hi₂ := finite_parameter_substitution_injective (p * h)
    (Nat.mul_pos (by omega) hh) b₂ c₂ hb₂ hc₂
  let Ψ₁ := parameterLaurentMap b₁ hb₁0 hi₁
  let Ψ₂ := parameterLaurentMap b₂ hb₂0 hi₂
  obtain ⟨ψ₁, hr₁, ho₁, hd₁, hclass₁, hind₁⟩ :=
    weak_different_profile_classification p h hp hh hdiv hchar b₁ c₁ hb₁ hc₁ hb₁0 hprofile₁
  obtain ⟨ψ₂, hr₂, ho₂, hd₂, _, hind₂⟩ :=
    weak_different_profile_classification p h hp hh hdiv hchar b₂ c₂ hb₂ hc₂ hb₂0 hprofile₂
  let φ₂ : PowerSeries k →ₐ[k] PowerSeries k :=
    PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb₂0)
  have hΨ₂ : ∀ f : PowerSeries k, Ψ₂ (f : LaurentSeries k) = (φ₂ f : PowerSeries k) := by
    intro f
    rw [parameter_laurent_map_power_series]
    exact congrArg (fun g : PowerSeries k => (g : LaurentSeries k))
      (congr_fun (PowerSeries.coe_substAlgHom
        (PowerSeries.HasSubst.of_constantCoeff_zero' hb₂0)) f).symm
  have hβ₂ : ψ₂ ^ h = Ψ₂ (HahnSeries.single (-1) 1) := by
    rw [parameter_laurent_map_pole]
    simpa using hr₂
  have hclass : ParameterFieldsEquivalent Ψ₁ Ψ₂ ↔
      weakPoleScalar p ψ₁ = weakPoleScalar p ψ₂ :=
    hclass₁ φ₂ Ψ₂ hΨ₂ ψ₂ hβ₂ ho₂ hd₂
  refine ⟨ψ₁, ψ₂, hr₁, hr₂, ?_⟩
  intro χ₁ χ₂ hχ₁ hχ₂
  simpa only [hind₁ χ₁ hχ₁, hind₂ χ₂ hχ₂] using hclass

end Litt3.QuotientGeometry
