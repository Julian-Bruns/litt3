import Solutions.Deformations.SignedBasisPowers
import Solutions.Deformations.FiniteResidueDigits

namespace Litt3.Deformations

open scoped BigOperators

variable {R k M I : Type*} [CommRing R] [CommRing k] [AddCommGroup M]
  [Module R M] [Fintype I]

/-- Exact fixed-section digits for every original free-basis signed
carry. The original degree restriction is imposed on each literal
digit coefficient. It remains valid for coefficient p-torsion. -/
theorem signed_basis_fixed_digits (B : Module.Basis I R M) (p : R) (w : ℕ)
    (positive : 0 < w) (degree : I → ℕ) (d : ℤ)
    (phi : R →+* k) (kernel : RingHom.ker phi = Ideal.span {p})
    (lift : k → R) (residue : ∀ c, phi (lift c) = c) (zero : lift 0 = 0)
    (m : ℕ) (x : M) (member : x ∈ signedBasisPowerFiltration B p w degree d) :
    ∃ digits : Fin m → I → k, ∃ remainder : M,
      x = (∑ j : Fin m, p ^ j.val • ∑ i, lift (digits j i) • B i) +
        p ^ m • remainder ∧
      ∀ (j : Fin m) (i : I), d + (w : ℤ) * j.val < degree i → digits j i = 0 := by
  classical
  have coefficients := (signed_basis_power_mem_iff B p w positive degree d x).mp member
  choose digits remainder expansion vanishing using fun i =>
    finite_residue_section_digits p phi kernel lift residue zero m
      (signedBasisWeightExponent w d (degree i)) (B.repr x i) (coefficients i)
  refine ⟨fun j i => digits i j, ∑ i, remainder i • B i, ?_, ?_⟩
  · calc
      x = ∑ i, ((∑ j : Fin m, p ^ j.val * lift (digits i j)) +
          p ^ m * remainder i) • B i := by
        rw [← B.sum_repr x]
        apply Finset.sum_congr rfl
        intro i _
        rw [expansion i]
      _ = (∑ i, ∑ j : Fin m, p ^ j.val • (lift (digits i j) • B i)) +
          ∑ i, p ^ m • (remainder i • B i) := by
        simp only [add_smul, Finset.sum_smul, mul_smul, Finset.sum_add_distrib]
      _ = (∑ j : Fin m, p ^ j.val • ∑ i, lift (digits i j) • B i) +
          p ^ m • ∑ i, remainder i • B i := by
        rw [Finset.sum_comm]
        simp only [Finset.smul_sum]
  · intro j i high
    apply vanishing i j
    have notReached : ¬signedBasisWeightExponent w d (degree i) ≤ j.val := by
      intro reached
      exact (not_le_of_gt high)
        ((signed_basis_weight_exponent_le w positive d (degree i) j.val).mp reached)
    omega

end Litt3.Deformations
