import Solutions.Deformations.OriginalToricFormalType
import Solutions.Deformations.SeriesUnequalFrobeniusUnitInvariance

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (K : Type*) [Field K] (p : ℕ) [Fact p.Prime] [CharP K p]

/-- A genuine relative toric change, including an invertible univariate
change of the lower variable, transports the ORIGINAL unequal-power
hypersurface length. The lower coordinate need only remain a unit times
itself. Whole original ideal invariance is derived in both directions. -/
theorem unequal_toric_hypersurface_length_of_formal_change
    (n T s : ℕ) (positiveT : 0 < T) (below : T ≤ p ^ n) (positiveS : 0 < s)
    (e : MvPowerSeries (Fin 3) K ≃ₐ[K] MvPowerSeries (Fin 3) K)
    (f : MvPowerSeries (Fin 3) K) (u : (MvPowerSeries (Fin 3) K)ˣ)
    (lower : T ≠ p ^ n → ∃ v : (MvPowerSeries (Fin 3) K)ˣ,
      e (MvPowerSeries.X 2) = (v : MvPowerSeries (Fin 3) K) * MvPowerSeries.X 2)
    (equation : e f = (u : MvPowerSeries (Fin 3) K) *
      (MvPowerSeries.X 0 * MvPowerSeries.X 1 - MvPowerSeries.X 2 ^ s)) :
    Module.finrank K (MvPowerSeries (Fin 3) K ⧸
      (seriesVariablePowerIdeal K 3 (toricHypersurfacePowers (p ^ n) T) ⊔
        Ideal.span ({f} : Set _))) =
      T + 2 * ∑ i : Fin (p ^ n - 1), min T (s * (i.val + 1)) := by
  have positiveQ : 0 < p ^ n := pow_pos (Fact.out (p := p.Prime)).pos n
  have positive : ∀ i, 0 < toricHypersurfacePowers (p ^ n) T i := by
    intro i
    unfold toricHypersurfacePowers
    split_ifs <;> assumption
  have bounds : ∀ i, toricHypersurfacePowers (p ^ n) T i ≤ p ^ n := by
    intro i
    unfold toricHypersurfacePowers
    split_ifs
    · exact below
    · exact le_rfl
  have lowerAll : ∀ i, toricHypersurfacePowers (p ^ n) T i ≠ p ^ n →
      ∃ v : (MvPowerSeries (Fin 3) K)ˣ,
        e (MvPowerSeries.X i) = (v : MvPowerSeries (Fin 3) K) * MvPowerSeries.X i := by
    intro i smaller
    have index : i = 2 := by
      by_contra different
      exact smaller (by simp [toricHypersurfacePowers, different])
    subst i
    exact lower (by simpa [toricHypersurfacePowers] using smaller)
  have invariant := series_unequal_frobenius_unit_ideal_invariant K p 3
    (toricHypersurfacePowers (p ^ n) T) positive n bounds e.toRingEquiv lowerAll
  let normal := hypersurfaceNormalFormQuotientEquiv K (MvPowerSeries (Fin 3) K)
    (seriesVariablePowerIdeal K 3 (toricHypersurfacePowers (p ^ n) T)) e f
    (MvPowerSeries.X 0 * MvPowerSeries.X 1 - MvPowerSeries.X 2 ^ s) u invariant equation
  let toric := Ideal.quotientEquivAlgOfEq K
    (toric_hypersurface_series_ideal_eq_sup K (p ^ n) T s).symm
  rw [normal.toLinearEquiv.finrank_eq, toric.toLinearEquiv.finrank_eq]
  exact toric_hypersurface_series_finrank K (p ^ n) T s positiveQ positiveT below positiveS

/-- The positive xy+z^s convention is retained together with the actual
lower-coordinate unit condition. The genuine sign involution fixes z,
so it preserves that condition and the whole original equation. -/
theorem unequal_toric_hypersurface_length_of_positive_formal_change
    (n T s : ℕ) (positiveT : 0 < T) (below : T ≤ p ^ n) (positiveS : 0 < s)
    (e : MvPowerSeries (Fin 3) K ≃ₐ[K] MvPowerSeries (Fin 3) K)
    (f : MvPowerSeries (Fin 3) K) (u : (MvPowerSeries (Fin 3) K)ˣ)
    (lower : T ≠ p ^ n → ∃ v : (MvPowerSeries (Fin 3) K)ˣ,
      e (MvPowerSeries.X 2) = (v : MvPowerSeries (Fin 3) K) * MvPowerSeries.X 2)
    (equation : e f = (u : MvPowerSeries (Fin 3) K) *
      (MvPowerSeries.X 0 * MvPowerSeries.X 1 + MvPowerSeries.X 2 ^ s)) :
    Module.finrank K (MvPowerSeries (Fin 3) K ⧸
      (seriesVariablePowerIdeal K 3 (toricHypersurfacePowers (p ^ n) T) ⊔
        Ideal.span ({f} : Set _))) =
      T + 2 * ∑ i : Fin (p ^ n - 1), min T (s * (i.val + 1)) := by
  let sign := seriesFirstCoordinateNegation K 2
  let v : (MvPowerSeries (Fin 3) K)ˣ := -(Units.map sign.toMonoidHom u)
  have third : sign (MvPowerSeries.X 2) = MvPowerSeries.X 2 :=
    seriesFirstCoordinateNegation_X_succ K 2 1
  apply unequal_toric_hypersurface_length_of_formal_change K p n T s positiveT below
    positiveS (e.trans sign) f v
  · intro smaller
    obtain ⟨w, hw⟩ := lower smaller
    refine ⟨Units.map sign.toMonoidHom w, ?_⟩
    change sign (e (MvPowerSeries.X 2)) = sign (w : MvPowerSeries (Fin 3) K) * MvPowerSeries.X 2
    rw [hw, map_mul, third]
  · change sign (e f) = _
    rw [equation, map_mul, map_add, map_mul, map_pow]
    have first : sign (MvPowerSeries.X 0) = -MvPowerSeries.X 0 :=
      seriesFirstCoordinateNegation_X_zero K 2
    have second : sign (MvPowerSeries.X 1) = MvPowerSeries.X 1 :=
      seriesFirstCoordinateNegation_X_succ K 2 0
    rw [first, second, third]
    change sign (u : MvPowerSeries (Fin 3) K) *
      (-MvPowerSeries.X 0 * MvPowerSeries.X 1 + MvPowerSeries.X 2 ^ s) =
        (-sign (u : MvPowerSeries (Fin 3) K)) *
          (MvPowerSeries.X 0 * MvPowerSeries.X 1 - MvPowerSeries.X 2 ^ s)
    ring

end Litt3.Deformations
