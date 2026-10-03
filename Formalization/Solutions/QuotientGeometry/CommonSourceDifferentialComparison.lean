import Solutions.QuotientGeometry.CommonSourceCompletedComparison
import Solutions.QuotientGeometry.WeakDifferentialOrders
import Solutions.QuotientGeometry.WeakLaurentDifferentialScalar
import Solutions.Jacobians.PowerSeriesRoots
import Definitions.QuotientGeometry.LocalDifferentialScalar

namespace Litt3.QuotientGeometry

/-- With the literal original beta=G^m/t^(ph) and dG=c*t^(p-2)*sigma
on both endpoints, BOTH actual unramified maps into the SAME completed
source force the stated differential scalars equal. Actual roots and
their weak orders are constructed, not supplied. -/
theorem same_source_unramified_differential_scalars_equal
    {k : Type*} [Field k] [IsAlgClosed k] (p h m : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hm : 0 < m) (hdiv : h ∣ p - 1)
    (hchar : (h : k) ≠ 0) (hmchar : (m : k) ≠ 0)
    (φ₁ φ₂ χ₁ χ₂ : PowerSeries k →ₐ[k] PowerSeries k)
    (Φ₁ Φ₂ Ψ₁ Ψ₂ : LaurentSeries k →+* LaurentSeries k)
    (hΦ₁ : ∀ f : PowerSeries k, Φ₁ (f : LaurentSeries k) = (φ₁ f : PowerSeries k))
    (hΦ₂ : ∀ f : PowerSeries k, Φ₂ (f : LaurentSeries k) = (φ₂ f : PowerSeries k))
    (hΨ₁ : ∀ f : PowerSeries k, Ψ₁ (f : LaurentSeries k) = (χ₁ f : PowerSeries k))
    (hΨ₂ : ∀ f : PowerSeries k, Ψ₂ (f : LaurentSeries k) = (χ₂ f : PowerSeries k))
    (hmax₁ : (IsLocalRing.maximalIdeal (PowerSeries k)).map φ₁.toRingHom =
      IsLocalRing.maximalIdeal (PowerSeries k))
    (hmax₂ : (IsLocalRing.maximalIdeal (PowerSeries k)).map φ₂.toRingHom =
      IsLocalRing.maximalIdeal (PowerSeries k))
    (hbase : Φ₁.comp Ψ₁ = Φ₂.comp Ψ₂)
    (g₁ g₂ σ₁ σ₂ : PowerSeries k) (c : k) (hc : c ≠ 0)
    (hg₁ : PowerSeries.constantCoeff g₁ ≠ 0) (hg₂ : PowerSeries.constantCoeff g₂ ≠ 0)
    (hσ₁ : PowerSeries.constantCoeff σ₁ ≠ 0) (hσ₂ : PowerSeries.constantCoeff σ₂ ≠ 0)
    (hβ₁ : Ψ₁ (HahnSeries.single (-1) 1) =
      HahnSeries.single (-((p * h : ℕ) : ℤ)) 1 * (g₁ : LaurentSeries k) ^ m)
    (hβ₂ : Ψ₂ (HahnSeries.single (-1) 1) =
      HahnSeries.single (-((p * h : ℕ) : ℤ)) 1 * (g₂ : LaurentSeries k) ^ m)
    (hdg₁ : PowerSeries.derivative k g₁ = PowerSeries.C c * PowerSeries.X ^ (p - 2) * σ₁)
    (hdg₂ : PowerSeries.derivative k g₂ = PowerSeries.C c * PowerSeries.X ^ (p - 2) * σ₂) :
    localDifferentialScalar p h m c (PowerSeries.constantCoeff g₁) (PowerSeries.constantCoeff σ₁) =
      localDifferentialScalar p h m c (PowerSeries.constantCoeff g₂) (PowerSeries.constantCoeff σ₂) := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  obtain ⟨u₁, hu₁, _⟩ := Litt3.Jacobians.power_series_unit_nth_root h hh hchar (g₁ ^ m)
    (by simpa using pow_ne_zero m hg₁)
  obtain ⟨u₂, hu₂, _⟩ := Litt3.Jacobians.power_series_unit_nth_root h hh hchar (g₂ ^ m)
    (by simpa using pow_ne_zero m hg₂)
  let ψ₁ : LaurentSeries k := HahnSeries.single (-(p : ℤ)) 1 * (u₁ : LaurentSeries k)
  let ψ₂ : LaurentSeries k := HahnSeries.single (-(p : ℤ)) 1 * (u₂ : LaurentSeries k)
  have horders₁ := weak_differential_root_laurent_orders p h m hp hh hm hchar hmchar
    u₁ g₁ σ₁ c hc hg₁ hσ₁ hu₁ hdg₁
  have horders₂ := weak_differential_root_laurent_orders p h m hp hh hm hchar hmchar
    u₂ g₂ σ₂ c hc hg₂ hσ₂ hu₂ hdg₂
  have hscalar := same_source_unramified_weak_scalars_equal p h hh hdiv
    φ₁ φ₂ χ₁ χ₂ Φ₁ Φ₂ Ψ₁ Ψ₂ hΦ₁ hΦ₂ hΨ₁ hΨ₂ hmax₁ hmax₂ hbase
    ψ₁ ψ₂ (horders₁.2.2.trans hβ₁.symm) (horders₂.2.2.trans hβ₂.symm)
    horders₁.1 horders₂.1 horders₁.2.1 horders₂.2.1
  have hf₁ := weak_laurent_power_root_differential_scalar p h m hp hh hm hdiv hchar hmchar
    u₁ g₁ σ₁ c hc hg₁ hσ₁ hu₁ hdg₁
  have hf₂ := weak_laurent_power_root_differential_scalar p h m hp hh hm hdiv hchar hmchar
    u₂ g₂ σ₂ c hc hg₂ hσ₂ hu₂ hdg₂
  exact hf₁.symm.trans (hscalar.trans hf₂)

theorem characteristic_five_local_differential_scalar
    {k : Type*} [Field k] [CharP k 5] (c g σ : k)
    (hc : c ≠ 0) (hg : g ≠ 0) (hσ : σ ≠ 0) :
    localDifferentialScalar 5 4 7 c g σ = -1 / ((2 * c) ^ 5 * g ^ 2 * σ ^ 5) := by
  have hfive : (5 : k) = 0 := by exact CharP.cast_eq_zero k 5
  have hfour : (4 : k) ≠ 0 := by
    change ((4 : ℕ) : k) ≠ 0
    rw [ne_eq, CharP.cast_eq_zero_iff k 5]
    norm_num
  have htwo : (2 : k) ≠ 0 := by
    change ((2 : ℕ) : k) ≠ 0
    rw [ne_eq, CharP.cast_eq_zero_iff k 5]
    norm_num
  have hfrac : -((7 : k) / (4 : k)) = 2 := by
    rw [← neg_div]
    apply (div_eq_iff hfour).mpr
    have h7 : (7 : k) = 2 := by linear_combination hfive
    rw [h7]
    linear_combination -2 * hfive
  norm_num only [localDifferentialScalar, Nat.reduceSub, Nat.reduceDiv, Nat.reduceMul,
    Int.reduceSub, Int.reduceNeg, zpow_neg, zpow_ofNat]
  have hdenom : -((7 : k) / (4 : k) * c * σ) = 2 * c * σ := by rw [← neg_mul, ← neg_mul, hfrac]
  rw [hdenom]
  field_simp [hc, hg, hσ, htwo]

theorem characteristic_five_local_scalars_equal_iff
    {k : Type*} [Field k] [CharP k 5] (c g₁ g₂ σ₁ σ₂ : k)
    (hc : c ≠ 0) (hg₁ : g₁ ≠ 0) (hg₂ : g₂ ≠ 0) (hσ₁ : σ₁ ≠ 0) (hσ₂ : σ₂ ≠ 0) :
    localDifferentialScalar 5 4 7 c g₁ σ₁ = localDifferentialScalar 5 4 7 c g₂ σ₂ ↔
      g₁ ^ 2 * σ₁ ^ 5 = g₂ ^ 2 * σ₂ ^ 5 := by
  rw [characteristic_five_local_differential_scalar c g₁ σ₁ hc hg₁ hσ₁,
    characteristic_five_local_differential_scalar c g₂ σ₂ hc hg₂ hσ₂]
  rw [mul_assoc, mul_assoc]
  apply negative_reciprocal_scaled_eq_iff
  have htwo : (2 : k) ≠ 0 := by
    change ((2 : ℕ) : k) ≠ 0
    rw [ne_eq, CharP.cast_eq_zero_iff k 5]
    norm_num
  exact pow_ne_zero 5 (mul_ne_zero htwo hc)

end Litt3.QuotientGeometry
