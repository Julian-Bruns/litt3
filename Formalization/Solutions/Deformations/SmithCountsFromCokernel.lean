import Solutions.Deformations.ScalarPowerDiagonalization
import Solutions.Deformations.FreePowerQuotientCounts
import Solutions.Deformations.SmithPowerCountArithmetic

namespace Litt3.Deformations

/-- For any actual scalar-power two-basis diagonalization, the actual
free-plus-torsion cokernel forces every factor and its exact multiplicity.
Only generic diagonalization existence remains outside this theorem. -/
theorem smith_counts_from_cokernel (p a q n f : ℕ) [Fact p.Prime] (aPositive : 0 < a)
    (K M : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [AddCommGroup M] [Module (ZMod (p ^ (a + 1))) M]
    (basis : K ≃ₗ[ZMod (p ^ (a + 1))] (Fin f → ZMod (p ^ (a + 1))))
    (A : Module.End (ZMod (p ^ (a + 1))) M)
    (normal : ScalarPowerDiagonalization (p : ZMod (p ^ (a + 1))) (q * f) (a + 1) A)
    (cokernel : (M ⧸ LinearMap.range A) ≃ₗ[ZMod (p ^ (a + 1))]
      (K × (Fin n → K ⧸ coefficientScalarRange (K := K) ((p : ZMod (p ^ (a + 1))) ^ a)))) :
    (∀ i, normal.exponent i = 0 ∨ normal.exponent i = a ∨ normal.exponent i = a + 1) ∧
      (Finset.univ.filter (fun i : Fin (q * f) => normal.exponent i = 0)).card = f * (q - (n + 1)) ∧
      (Finset.univ.filter (fun i : Fin (q * f) => normal.exponent i = a)).card = f * n ∧
      (Finset.univ.filter (fun i : Fin (q * f) => normal.exponent i = a + 1)).card = f := by
  have prime := (Fact.out : p.Prime)
  have filtration : ∀ j : ℕ, j ≤ a + 1 →
      (∑ i : Fin (q * f), min (normal.exponent i) j) = f * j + n * (f * min a j) := by
    intro j bound
    apply Nat.pow_right_injective prime.one_lt
    dsimp only
    rw [← normal.filtration_card p (a + 1) (q * f) j prime.pos,
      linear_equiv_scalar_quotient_card cokernel]
    exact free_torsion_cokernel_filtration_card p (a + 1) f n a j prime.pos (Nat.le_succ a) bound K basis
  have first : (∑ i : Fin (q * f), min (normal.exponent i) 1) = f * (n + 1) := by
    have identity := filtration 1 (by omega)
    rw [Nat.min_eq_right (by omega : 1 ≤ a)] at identity
    convert identity using 1 <;> ring
  have lower : (∑ i : Fin (q * f), min (normal.exponent i) a) = f * (n + 1) * a := by
    have identity := filtration a (Nat.le_succ a)
    rw [Nat.min_self] at identity
    convert identity using 1 <;> ring
  have full : (∑ i : Fin (q * f), min (normal.exponent i) (a + 1)) = f * (n + 1) * a + f := by
    have identity := filtration (a + 1) le_rfl
    rw [Nat.min_eq_left (Nat.le_succ a)] at identity
    convert identity using 1 <;> ring
  simpa only [Nat.add_sub_cancel] using
    smith_power_count_arithmetic q (n + 1) f a aPositive normal.exponent normal.exponent_bound first lower full

end Litt3.Deformations
