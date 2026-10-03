import Solutions.Deformations.DiagonalScalarQuotient
import Solutions.Deformations.ScalarQuotientTransport

namespace Litt3.Deformations

/-- Every actual scalar-power diagonal presentation has the full
literal quotient filtration counts, uniformly at every precision. -/
theorem zmod_diagonal_power_filtration_card (p N n j : ℕ) (positive : 0 < p)
    (e : Fin n → ℕ) (bound : ∀ i, e i ≤ N) :
    Nat.card (((Fin n → ZMod (p ^ N)) ⧸ LinearMap.range
      (diagonalScalarOperator (M := fun _ : Fin n => ZMod (p ^ N))
        (fun i => (p : ZMod (p ^ N)) ^ e i))) ⧸
      coefficientScalarRange (K := (Fin n → ZMod (p ^ N)) ⧸ LinearMap.range
        (diagonalScalarOperator (M := fun _ : Fin n => ZMod (p ^ N))
          (fun i => (p : ZMod (p ^ N)) ^ e i))) ((p : ZMod (p ^ N)) ^ j)) =
      p ^ (∑ i : Fin n, min (e i) j) := by
  rw [linear_equiv_scalar_quotient_card (diagonalScalarCokernelEquiv
    (M := fun _ : Fin n => ZMod (p ^ N)) (fun i => (p : ZMod (p ^ N)) ^ e i))]
  rw [Nat.card_congr (coefficientScalarProductQuotientEquiv
    (M := fun i : Fin n => ZMod (p ^ N) ⧸ coefficientScalarRange (K := ZMod (p ^ N))
      ((p : ZMod (p ^ N)) ^ e i)) ((p : ZMod (p ^ N)) ^ j)).toEquiv,
    Nat.card_pi]
  simp_rw [zmod_double_power_quotient_card p N _ j positive (bound _)]
  exact Finset.prod_pow_eq_pow_sum _ _ _

end Litt3.Deformations
