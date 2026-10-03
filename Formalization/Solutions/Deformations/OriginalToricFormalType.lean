import Solutions.Deformations.ToricHypersurfaceSeriesDimensions
import Solutions.Deformations.SeriesUnequalFrobeniusInvariance
import Solutions.Deformations.HypersurfaceNormalFormTransport
import Solutions.Deformations.SeriesFirstCoordinateNegation

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (R : Type*) [CommRing R]

theorem toric_hypersurface_series_ideal_eq_sup (Q T s : ℕ) :
    toricHypersurfaceSeriesIdeal R Q T s =
      seriesVariablePowerIdeal R 3 (toricHypersurfacePowers Q T) ⊔
        Ideal.span ({MvPowerSeries.X 0 * MvPowerSeries.X 1 - MvPowerSeries.X 2 ^ s} : Set _) := by
  have generators : Set.range (fun i : Fin 3 =>
      (MvPowerSeries.X i : MvPowerSeries (Fin 3) R) ^ toricHypersurfacePowers Q T i) =
      {MvPowerSeries.X 0 ^ Q, MvPowerSeries.X 1 ^ Q, MvPowerSeries.X 2 ^ T} := by
    ext f
    constructor
    · rintro ⟨i, rfl⟩
      fin_cases i <;> simp [toricHypersurfacePowers]
    · intro member
      simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at member
      rcases member with rfl | rfl | rfl
      · exact ⟨0, by simp [toricHypersurfacePowers]⟩
      · exact ⟨1, by simp [toricHypersurfacePowers]⟩
      · exact ⟨2, by simp [toricHypersurfacePowers]⟩
  rw [seriesVariablePowerIdeal, generators, toricHypersurfaceSeriesIdeal]
  simp only [Ideal.span_insert]
  ac_rfl

variable (K : Type*) [Field K] (p : ℕ) [Fact p.Prime] [CharP K p]

/-- The source's balanced toric formal-type clause. The supplied
hypothesis is precisely its actual formal coordinate change and unit;
preservation of the full original Frobenius ideal and the quotient length
are derived. Neither a rank nor a quotient dimension is an input. -/
theorem balanced_toric_hypersurface_length_of_formal_change (n s : ℕ) (positiveS : 0 < s)
    (e : MvPowerSeries (Fin 3) K ≃ₐ[K] MvPowerSeries (Fin 3) K)
    (f : MvPowerSeries (Fin 3) K) (u : (MvPowerSeries (Fin 3) K)ˣ)
    (equation : e f = (u : MvPowerSeries (Fin 3) K) *
      (MvPowerSeries.X 0 * MvPowerSeries.X 1 - MvPowerSeries.X 2 ^ s)) :
    Module.finrank K (MvPowerSeries (Fin 3) K ⧸
      (seriesVariablePowerIdeal K 3 (fun _ => p ^ n) ⊔ Ideal.span ({f} : Set _))) =
        p ^ n + 2 * ∑ i : Fin (p ^ n - 1), min (p ^ n) (s * (i.val + 1)) := by
  have positive : 0 < p ^ n := pow_pos (Fact.out (p := p.Prime)).pos n
  have invariant := series_unequal_frobenius_ideal_invariant K p 3 (fun _ => p ^ n)
    (fun _ => positive) n (fun _ => le_rfl) e.toRingEquiv (fun _ lower => (lower rfl).elim)
  let normal := hypersurfaceNormalFormQuotientEquiv K (MvPowerSeries (Fin 3) K)
    (seriesVariablePowerIdeal K 3 (fun _ => p ^ n)) e f
    (MvPowerSeries.X 0 * MvPowerSeries.X 1 - MvPowerSeries.X 2 ^ s) u invariant equation
  have powers : toricHypersurfacePowers (p ^ n) (p ^ n) = (fun _ => p ^ n) := by
    funext i
    simp [toricHypersurfacePowers]
  have ideals := toric_hypersurface_series_ideal_eq_sup K (p ^ n) (p ^ n) s
  rw [powers] at ideals
  let toric := Ideal.quotientEquivAlgOfEq K ideals.symm
  rw [normal.toLinearEquiv.finrank_eq, toric.toLinearEquiv.finrank_eq]
  exact toric_hypersurface_series_finrank K (p ^ n) (p ^ n) s positive positive le_rfl positiveS

/-- The literal xy+z^s convention in the original statement is carried
to xy-z^s by a constructed formal involution. The entire original f and
its actual formal-type coordinate change remain in the theorem. -/
theorem balanced_toric_hypersurface_length_of_positive_formal_change
    (n s : ℕ) (positiveS : 0 < s)
    (e : MvPowerSeries (Fin 3) K ≃ₐ[K] MvPowerSeries (Fin 3) K)
    (f : MvPowerSeries (Fin 3) K) (u : (MvPowerSeries (Fin 3) K)ˣ)
    (equation : e f = (u : MvPowerSeries (Fin 3) K) *
      (MvPowerSeries.X 0 * MvPowerSeries.X 1 + MvPowerSeries.X 2 ^ s)) :
    Module.finrank K (MvPowerSeries (Fin 3) K ⧸
      (seriesVariablePowerIdeal K 3 (fun _ => p ^ n) ⊔ Ideal.span ({f} : Set _))) =
        p ^ n + 2 * ∑ i : Fin (p ^ n - 1), min (p ^ n) (s * (i.val + 1)) := by
  let sign := seriesFirstCoordinateNegation K 2
  let v : (MvPowerSeries (Fin 3) K)ˣ := -(Units.map sign.toMonoidHom u)
  apply balanced_toric_hypersurface_length_of_formal_change K p n s positiveS (e.trans sign) f v
  change sign (e f) = _
  rw [equation, map_mul, map_add, map_mul, map_pow]
  have first : sign (MvPowerSeries.X 0) = -MvPowerSeries.X 0 :=
    seriesFirstCoordinateNegation_X_zero K 2
  have second : sign (MvPowerSeries.X 1) = MvPowerSeries.X 1 :=
    seriesFirstCoordinateNegation_X_succ K 2 0
  have third : sign (MvPowerSeries.X 2) = MvPowerSeries.X 2 :=
    seriesFirstCoordinateNegation_X_succ K 2 1
  rw [first, second, third]
  change sign (u : MvPowerSeries (Fin 3) K) *
    (-MvPowerSeries.X 0 * MvPowerSeries.X 1 + MvPowerSeries.X 2 ^ s) =
      (-sign (u : MvPowerSeries (Fin 3) K)) *
        (MvPowerSeries.X 0 * MvPowerSeries.X 1 - MvPowerSeries.X 2 ^ s)
  ring

end Litt3.Deformations
