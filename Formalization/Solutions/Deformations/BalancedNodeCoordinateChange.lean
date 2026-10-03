import Solutions.Deformations.BalancedSeriesNodeDimensions
import Solutions.Deformations.HypersurfaceNormalFormTransport
import Solutions.Deformations.SeriesUnequalFrobeniusInvariance

namespace Litt3.Deformations

variable (R : Type*) [CommRing R]

theorem balanced_series_node_ideal_eq_sup (Q : ℕ) :
    balancedSeriesNodeIdeal R Q = seriesVariablePowerIdeal R 2 (fun _ => Q) ⊔
      Ideal.span ({MvPowerSeries.X 0 * MvPowerSeries.X 1} : Set (MvPowerSeries (Fin 2) R)) := by
  have generators : Set.range (fun i : Fin 2 => (MvPowerSeries.X i : MvPowerSeries (Fin 2) R) ^ Q) =
      {MvPowerSeries.X 0 ^ Q, MvPowerSeries.X 1 ^ Q} := by
    ext f
    simp [Fin.exists_fin_two, eq_comm]
  rw [seriesVariablePowerIdeal, generators]
  simp only [balancedSeriesNodeIdeal, Ideal.span_insert, sup_assoc]

variable (K : Type*) [Field K] (p : ℕ) [Fact p.Prime] [CharP K p]

/-- An actual formal coefficient coordinate change taking f to a
unit times xy yields the original balanced Frobenius-truncated length.
Preservation of the actual truncation ideal is derived, not assumed.
The construction of such a change from a quadratic-rank hypothesis is
the separate formal Morse obligation. -/
theorem balanced_hypersurface_length_of_node_change (n : ℕ)
    (e : MvPowerSeries (Fin 2) K ≃ₐ[K] MvPowerSeries (Fin 2) K)
    (f : MvPowerSeries (Fin 2) K) (u : (MvPowerSeries (Fin 2) K)ˣ)
    (equation : e f = (u : MvPowerSeries (Fin 2) K) * (MvPowerSeries.X 0 * MvPowerSeries.X 1)) :
    Module.finrank K ((MvPowerSeries (Fin 2) K) ⧸
      (seriesVariablePowerIdeal K 2 (fun _ => p ^ n) ⊔ Ideal.span ({f} : Set (MvPowerSeries (Fin 2) K)))) =
        2 * p ^ n - 1 := by
  have positive : 0 < p ^ n := pow_pos (Fact.out (p := p.Prime)).pos n
  have invariant := series_unequal_frobenius_ideal_invariant K p 2 (fun _ => p ^ n)
    (fun _ => positive) n (fun _ => le_rfl) e.toRingEquiv (fun _ lower => (lower rfl).elim)
  have normal := hypersurfaceNormalFormQuotientEquiv K (MvPowerSeries (Fin 2) K)
    (seriesVariablePowerIdeal K 2 (fun _ => p ^ n)) e f (MvPowerSeries.X 0 * MvPowerSeries.X 1)
      u invariant equation
  have node := Ideal.quotientEquivAlgOfEq K (balanced_series_node_ideal_eq_sup K (p ^ n)).symm
  rw [normal.toLinearEquiv.finrank_eq, node.toLinearEquiv.finrank_eq]
  exact balanced_series_node_finrank K (p ^ n) positive

end Litt3.Deformations
