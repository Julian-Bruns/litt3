import Solutions.CartierAndSpin.FinitePrimaryCyclicity

namespace Litt3.CartierAndSpin

/-- The gcd of two powers of the SAME natural base is the smaller
power, including base zero and exponent zero. -/
theorem actual_same_base_power_gcd (p m n : ℕ) :
    Nat.gcd (p ^ m) (p ^ n) = p ^ min m n := by
  by_cases h : m ≤ n
  · rw [min_eq_left h]
    exact Nat.gcd_eq_left_iff_dvd.mpr (pow_dvd_pow p h)
  · have h' : n ≤ m := (Nat.le_of_not_ge h)
    rw [min_eq_right h']
    exact Nat.gcd_eq_right_iff_dvd.mpr (pow_dvd_pow p h')

/-- A finite actual primary abelian group with small p-kernel has
one literal height, and its true multiplication kernels have the exact
cardinalities p^min(height,n). No decomposition is supplied. -/
theorem actual_finite_primary_kernel_profile
    {A : Type*} [AddCommGroup A] [Finite A]
    (p : ℕ) (hprimary : ∀ a : A, ∃ n : ℕ, addOrderOf a = p ^ n)
    (hp : Nat.card (powerTorsionSubgroup A p) ≤ p) :
    ∃ height : ℕ, Nat.card A = p ^ height ∧
      ∀ n : ℕ, Nat.card (powerTorsionSubgroup A (p ^ n)) =
        p ^ min height n := by
  letI := actual_finite_primary_group_is_cyclic p hprimary hp
  obtain ⟨a, ha⟩ := isAddCyclic_iff_exists_zmultiples_eq_top.mp
    (inferInstance : IsAddCyclic A)
  obtain ⟨height, hheight⟩ := hprimary a
  have hcard : Nat.card A = p ^ height :=
    (addOrderOf_eq_card_of_zmultiples_eq_top ha).symm.trans hheight
  refine ⟨height, hcard, fun n => ?_⟩
  have hkernel : powerTorsionSubgroup A (p ^ n) =
      (nsmulAddMonoidHom (p ^ n) : A →+ A).ker := rfl
  rw [hkernel, IsAddCyclic.card_nsmulAddMonoidHom_ker, hcard]
  exact actual_same_base_power_gcd p height n

end Litt3.CartierAndSpin
