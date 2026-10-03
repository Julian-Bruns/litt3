import Mathlib.RingTheory.MvPowerSeries.Substitution
import Mathlib.Algebra.Algebra.Equiv

namespace Litt3.Deformations

variable (R : Type*) [CommRing R] (d : ℕ)

/-- An actual coefficient-preserving formal-series involution changing
the sign of the first original variable and fixing every other one. -/
noncomputable def seriesFirstCoordinateNegation :
    MvPowerSeries (Fin (d + 1)) R ≃ₐ[R] MvPowerSeries (Fin (d + 1)) R := by
  let a : Fin (d + 1) → R := Fin.cons (-1) (fun _ => 1)
  have square : a * a = 1 := by
    funext i
    induction i using Fin.cases with
    | zero => simp [a]
    | succ j => simp [a]
  apply AlgEquiv.ofAlgHom (MvPowerSeries.rescaleAlgHom a) (MvPowerSeries.rescaleAlgHom a)
  · rw [← MvPowerSeries.rescaleAlgHom_mul, square, MvPowerSeries.rescaleAlgHom_one]
  · rw [← MvPowerSeries.rescaleAlgHom_mul, square, MvPowerSeries.rescaleAlgHom_one]

@[simp] theorem seriesFirstCoordinateNegation_X_zero :
    seriesFirstCoordinateNegation R d (MvPowerSeries.X 0) = -MvPowerSeries.X 0 := by
  change MvPowerSeries.rescaleAlgHom (Fin.cons (-1) (fun _ => 1)) (MvPowerSeries.X 0) = _
  rw [MvPowerSeries.rescaleAlgHom_apply, MvPowerSeries.rescale_eq_subst,
    MvPowerSeries.subst_X (MvPowerSeries.HasSubst.smul_X _)]
  simp

@[simp] theorem seriesFirstCoordinateNegation_X_succ (i : Fin d) :
    seriesFirstCoordinateNegation R d (MvPowerSeries.X i.succ) = MvPowerSeries.X i.succ := by
  change MvPowerSeries.rescaleAlgHom (Fin.cons (-1) (fun _ => 1)) (MvPowerSeries.X i.succ) = _
  rw [MvPowerSeries.rescaleAlgHom_apply, MvPowerSeries.rescale_eq_subst,
    MvPowerSeries.subst_X (MvPowerSeries.HasSubst.smul_X _)]
  simp

end Litt3.Deformations
