import Definitions.Deformations.ScalarPowerDiagonalization
import Solutions.Deformations.DiagonalPowerFiltration

namespace Litt3.Deformations

variable {R M V : Type*} [CommRing R] [AddCommGroup M] [Module R M]
    [AddCommGroup V] [Module R V]

/-- An actual two-basis normal form transports the whole original
image through its actual target equivalence. -/
theorem linear_equivs_map_range_normal_form (source target : M ≃ₗ[R] V)
    (A : Module.End R M) (D : Module.End R V)
    (normal : ∀ v, target (A (source.symm v)) = D v) :
    (LinearMap.range A).map target.toLinearMap = LinearMap.range D := by
  ext v
  constructor
  · rintro ⟨w, ⟨x, rfl⟩, rfl⟩
    refine ⟨source x, ?_⟩
    rw [← normal, LinearEquiv.symm_apply_apply]
    rfl
  · rintro ⟨v, rfl⟩
    exact ⟨A (source.symm v), ⟨source.symm v, rfl⟩, normal v⟩

noncomputable def ScalarPowerDiagonalization.cokernelEquiv {r : R} {d N : ℕ}
    {A : Module.End R M} (normal : ScalarPowerDiagonalization r d N A) :
    (M ⧸ LinearMap.range A) ≃ₗ[R]
      ((Fin d → R) ⧸ LinearMap.range (diagonalScalarOperator (M := fun _ : Fin d => R)
        (fun i => r ^ normal.exponent i))) :=
  Submodule.Quotient.equiv _ _ normal.target
    (linear_equivs_map_range_normal_form normal.source normal.target A _ normal.equation)

/-- An actual scalar-power diagonalization determines all actual
original cokernel filtration cardinalities, at every precision. -/
theorem ScalarPowerDiagonalization.filtration_card (p N d j : ℕ) (positive : 0 < p)
    {M : Type*} [AddCommGroup M] [Module (ZMod (p ^ N)) M]
    {A : Module.End (ZMod (p ^ N)) M}
    (normal : ScalarPowerDiagonalization (p : ZMod (p ^ N)) d N A) :
    Nat.card ((M ⧸ LinearMap.range A) ⧸
      coefficientScalarRange (K := M ⧸ LinearMap.range A) ((p : ZMod (p ^ N)) ^ j)) =
      p ^ (∑ i : Fin d, min (normal.exponent i) j) := by
  rw [linear_equiv_scalar_quotient_card normal.cokernelEquiv]
  exact zmod_diagonal_power_filtration_card p N d j positive normal.exponent normal.exponent_bound

end Litt3.Deformations
