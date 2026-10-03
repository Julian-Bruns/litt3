import Solutions.Deformations.DiagonalPowerFiltration
import Solutions.Deformations.ScalarPairQuotient

namespace Litt3.Deformations

theorem free_power_quotient_card (p N f j : ℕ) (positive : 0 < p) (bound : j ≤ N)
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ N)) K]
    (basis : K ≃ₗ[ZMod (p ^ N)] (Fin f → ZMod (p ^ N))) :
    Nat.card (K ⧸ coefficientScalarRange (K := K) ((p : ZMod (p ^ N)) ^ j)) = p ^ (f * j) := by
  rw [linear_equiv_scalar_quotient_card basis,
    Nat.card_congr (coefficientScalarProductQuotientEquiv
      (M := fun _ : Fin f => ZMod (p ^ N)) ((p : ZMod (p ^ N)) ^ j)).toEquiv,
    Nat.card_pi]
  simp_rw [zmod_power_quotient_card p N j positive bound]
  simp only [Finset.prod_const, Finset.card_univ, Fintype.card_fin]
  rw [← pow_mul, mul_comm]

theorem free_double_power_quotient_card (p N f e j : ℕ) (positive : 0 < p) (bound : e ≤ N)
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ N)) K]
    (basis : K ≃ₗ[ZMod (p ^ N)] (Fin f → ZMod (p ^ N))) :
    Nat.card ((K ⧸ coefficientScalarRange (K := K) ((p : ZMod (p ^ N)) ^ e)) ⧸
      coefficientScalarRange (K := K ⧸ coefficientScalarRange (K := K) ((p : ZMod (p ^ N)) ^ e))
        ((p : ZMod (p ^ N)) ^ j)) = p ^ (f * min e j) := by
  rw [Nat.card_congr (scalarPowerDoubleQuotientEquiv (K := K) (p : ZMod (p ^ N)) e j).toEquiv]
  exact free_power_quotient_card p N f (min e j) positive (le_trans (Nat.min_le_left _ _) bound) K basis

/-- The complete actual free-plus-torsion cokernel has the exact
full scalar quotient filtration at every surviving precision. -/
theorem free_torsion_cokernel_filtration_card (p N f n e j : ℕ) (positive : 0 < p)
    (eBound : e ≤ N) (jBound : j ≤ N)
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ N)) K]
    (basis : K ≃ₗ[ZMod (p ^ N)] (Fin f → ZMod (p ^ N))) :
    Nat.card ((K × (Fin n → K ⧸ coefficientScalarRange (K := K) ((p : ZMod (p ^ N)) ^ e))) ⧸
      coefficientScalarRange (K := K × (Fin n → K ⧸ coefficientScalarRange (K := K)
        ((p : ZMod (p ^ N)) ^ e))) ((p : ZMod (p ^ N)) ^ j)) =
      p ^ (f * j + n * (f * min e j)) := by
  rw [Nat.card_congr (scalarPairQuotientEquiv
    (M := K) (N := Fin n → K ⧸ coefficientScalarRange (K := K) ((p : ZMod (p ^ N)) ^ e))
      ((p : ZMod (p ^ N)) ^ j)).toEquiv, Nat.card_prod,
    free_power_quotient_card p N f j positive jBound K basis]
  rw [Nat.card_congr (coefficientScalarProductQuotientEquiv
    (M := fun _ : Fin n => K ⧸ coefficientScalarRange (K := K) ((p : ZMod (p ^ N)) ^ e))
      ((p : ZMod (p ^ N)) ^ j)).toEquiv, Nat.card_pi]
  simp_rw [free_double_power_quotient_card p N f e j positive eBound K basis]
  simp only [Finset.prod_const, Finset.card_univ, Fintype.card_fin]
  rw [← pow_mul, ← pow_add]
  congr 1
  rw [mul_comm (f * min e j) n]

end Litt3.Deformations
