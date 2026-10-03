import Solutions.CartierAndSpin.PowerKernelFiniteness

namespace Litt3.CartierAndSpin

variable {A : Type*} [AddCommGroup A]

/-- A bound on the literal p-kernel bounds every actual p^n-kernel
by p^n. The proof counts the kernel and image of the genuine successive
p-multiplication homomorphism, without an abelian classification input
or finite ambient group premise. Primality is unnecessary. -/
theorem actual_power_kernel_cardinality_bound (p : ℕ)
    [Finite (powerTorsionSubgroup A p)]
    (hp : Nat.card (powerTorsionSubgroup A p) ≤ p) (n : ℕ) :
    Nat.card (powerTorsionSubgroup A (p ^ n)) ≤ p ^ n := by
  induction n with
  | zero =>
    have hsub : Subsingleton (powerTorsionSubgroup A 1) := by
      constructor
      intro x y
      apply Subtype.ext
      have hx : x.val = 0 := by
        have hx : 1 • x.val = 0 := x.property
        simpa only [one_nsmul] using hx
      have hy : y.val = 0 := by
        have hy : 1 • y.val = 0 := y.property
        simpa only [one_nsmul] using hy
      exact hx.trans hy.symm
    letI := hsub
    have hc : Nat.card (powerTorsionSubgroup A 1) = 1 :=
      Nat.card_eq_one_iff_unique.mpr ⟨hsub, inferInstance⟩
    rw [pow_zero, hc]
  | succ n hn =>
    letI : Finite (powerTorsionSubgroup A (p ^ n)) := actual_power_kernel_finite p n
    let f := powerKernelStep A p n
    let j := powerKernelStepKernelInclusion A p n
    have hj : Function.Injective j := actual_power_kernel_step_inclusion_injective p n
    have hk : Nat.card f.ker ≤ p :=
      (Nat.card_le_card_of_injective j hj).trans hp
    have hr : Nat.card f.range ≤ p ^ n :=
      (Nat.card_le_card_of_injective (fun x : f.range => x.val) Subtype.val_injective).trans hn
    have hc := f.ker.card_mul_index
    rw [AddSubgroup.index_ker] at hc
    calc
      Nat.card (powerTorsionSubgroup A (p ^ (n + 1))) = Nat.card f.ker * Nat.card f.range := hc.symm
      _ ≤ p * p ^ n := Nat.mul_le_mul hk hr
      _ = p ^ (n + 1) := by rw [pow_succ, mul_comm]

end Litt3.CartierAndSpin
