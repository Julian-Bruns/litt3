import Solutions.SharedTensors.PBasisDerivation
import Mathlib.Algebra.Polynomial.Coeff

namespace Litt3.SharedTensors

open Polynomial Module

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The literal Taylor polynomial of the actual p-basis representation
of f, obtained by replacing its parameter t by t+epsilon. Coefficients
remain in the ORIGINAL field; no perfectness assumption is made. -/
noncomputable def pBasisTaylorPolynomial (b : PowerPBasis K p) (f : K) : K[X] :=
  ∑ i : Fin p, C (b.basis.repr f i : K) * (X + C b.parameter) ^ i.val

/-- The Taylor polynomial's constant coefficient is the actual original
field element, by its full literal p-basis expansion. -/
theorem pBasisTaylorPolynomial_constant (b : PowerPBasis K p) (f : K) :
    (pBasisTaylorPolynomial b f).coeff 0 = f := by
  classical
  rw [pBasisTaylorPolynomial, finset_sum_coeff]
  simp only [coeff_C_mul, coeff_X_add_C_pow, Nat.sub_zero,
    Nat.choose_zero_right, Nat.cast_one, mul_one]
  simpa only [← pRootCoefficient_pow] using p_basis_actual_expansion b f

/-- Only the final actual p-basis digit contributes to the top Taylor
coefficient. No finite matrix calculation is involved. -/
theorem pBasisTaylorPolynomial_top (b : PowerPBasis K p) (f : K) :
    (pBasisTaylorPolynomial b f).coeff (p - 1) =
      (b.basis.repr f ⟨p - 1, Nat.sub_lt (Fact.out : p.Prime).pos (by decide)⟩ : K) := by
  classical
  let j : Fin p := ⟨p - 1, Nat.sub_lt (Fact.out : p.Prime).pos (by decide)⟩
  rw [pBasisTaylorPolynomial, finset_sum_coeff]
  have hterm : ∀ i : Fin p,
      (C (b.basis.repr f i : K) * (X + C b.parameter) ^ i.val).coeff (p - 1) =
        if i = j then (b.basis.repr f j : K) else 0 := by
    intro i
    rw [coeff_C_mul, coeff_X_add_C_pow]
    by_cases hi : i = j
    · subst i
      simp [j]
    · have hij : i.val < p - 1 := by
        have hne : i.val ≠ p - 1 := fun h => hi (Fin.ext h)
        omega
      rw [Nat.choose_eq_zero_of_lt hij]
      simp [hi]
  simp only [hterm]
  simp [j]

/-- Cartier-fixedness of the actual rational coefficient is exactly the
single literal top-coefficient obstruction in its true Taylor polynomial. -/
theorem pBasisTaylorPolynomial_logarithmic_obstruction_iff
    (b : PowerPBasis K p) (f : K) :
    (pBasisTaylorPolynomial b f).coeff (p - 1) =
        ((pBasisTaylorPolynomial b f).coeff 0) ^ p ↔
      rationalCartierCoefficient K p b f = f := by
  rw [pBasisTaylorPolynomial_constant, pBasisTaylorPolynomial_top]
  constructor
  · intro h
    apply (frobenius K p).injective
    change rationalCartierCoefficient K p b f ^ p = f ^ p
    change pRootCoefficient K p b f _ ^ p = f ^ p
    rw [pRootCoefficient_pow]
    exact h
  · intro h
    have hp := pRootCoefficient_pow b f
      ⟨p - 1, Nat.sub_lt (Fact.out : p.Prime).pos (by decide)⟩
    change rationalCartierCoefficient K p b f ^ p = _ at hp
    rw [h] at hp
    exact hp.symm

end Litt3.SharedTensors
