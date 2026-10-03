import Definitions.Deformations.ArtinSchreierDigits
import Solutions.Deformations.ArtinSchreierCarryCoefficients
import Solutions.Deformations.SignedBasisDigits
import Mathlib.RingTheory.Ideal.Quotient.Operations

namespace Litt3.Deformations

open scoped BigOperators ArtinSchreierAdic

variable {R k : Type*} [CommRing R] [Nontrivial R] [CommRing k]

/-- Every actual integral carry has a finite fixed-section normal
digit expansion with the exact original degree bounds. -/
theorem artin_schreier_carry_fixed_digits (p : ℕ) (prime : p.Prime) (r : ℕ)
    (a b : Fin r → R) (d : ℤ) (phi : R →+* k)
    (kernel : RingHom.ker phi = Ideal.span {(p : R)})
    (lift : k → R) (residue : ∀ c, phi (lift c) = c) (zero : lift 0 = 0)
    (m : ℕ) (x : artinSchreierChart R p r a b)
    (member : x ∈ artinSchreierCarry R p r a b d) :
    ∃ digits : Fin m → (Fin r → Fin p) → k,
      x ≡ (∑ j : Fin m, (p : artinSchreierChart R p r a b) ^ j.val *
        artinSchreierNormalDigit p prime.one_lt r a b lift (digits j))
        [SMOD ((Ideal.span {(p : artinSchreierChart R p r a b)}) ^ m)] ∧
      ∀ (j : Fin m) (alpha : Fin r → Fin p),
        d + ((p - 1 : ℕ) : ℤ) * j.val < (∑ i, (alpha i).val : ℕ) → digits j alpha = 0 := by
  rw [artin_schreier_carry_eq_normal p prime r a b d,
    artin_schreier_normal_eq_basis p prime.one_lt r a b d] at member
  obtain ⟨digits, remainder, expansion, degrees⟩ := signed_basis_fixed_digits
    (artinSchreierChartBasis p prime.one_lt r a b) (p : R) (p - 1)
      (by have := prime.one_lt; omega) (fun alpha => ∑ i, (alpha i).val) d
      phi kernel lift residue zero m x member
  refine ⟨digits, ?_, degrees⟩
  apply (prime_power_smodEq_iff p m _ _).mpr
  refine ⟨remainder, ?_⟩
  simp only [artinSchreierNormalDigit, artin_schreier_chart_basis_apply,
    Algebra.smul_def, map_pow, map_natCast] at expansion ⊢
  linear_combination expansion

/-- Literal bounded original normal digits give actual carry classes.
This is the converse needed for the full finite quotient description. -/
theorem artin_schreier_fixed_digit_mem (p : ℕ) (prime : p.Prime) (r : ℕ)
    (a b : Fin r → R) (d : ℤ) (j : ℕ) (lift : k → R) (zero : lift 0 = 0)
    (digits : (Fin r → Fin p) → k)
    (degrees : ∀ alpha, d + ((p - 1 : ℕ) : ℤ) * j <
      (∑ i, (alpha i).val : ℕ) → digits alpha = 0) :
    (p : artinSchreierChart R p r a b) ^ j *
      artinSchreierNormalDigit p prime.one_lt r a b lift digits ∈
        artinSchreierCarry R p r a b d := by
  classical
  rw [artin_schreier_carry_eq_normal p prime r a b d]
  unfold artinSchreierNormalDigit
  rw [Finset.mul_sum]
  apply Submodule.sum_mem
  intro alpha _
  by_cases high : d + ((p - 1 : ℕ) : ℤ) * j < (∑ i, (alpha i).val : ℕ)
  · simp [degrees alpha high, zero]
  · rw [Algebra.mul_smul_comm]
    apply Submodule.smul_mem
    simpa only [artin_schreier_chart_basis_apply, generatorMonomial] using
      normal_signed_generator_member (R := R) p
        (p : artinSchreierChart R p r a b) (p - 1)
        (artinSchreierChartCoordinate R p r a b) d j
        (fun i => (alpha i).val) (fun i => (alpha i).isLt) (le_of_not_gt high)

/-- Exact finite-precision description of the image of the actual
carry module in the original p^m quotient, using fixed-section digits. -/
theorem artin_schreier_quotient_digits_iff (p : ℕ) (prime : p.Prime) (r : ℕ)
    (a b : Fin r → R) (d : ℤ) (phi : R →+* k)
    (kernel : RingHom.ker phi = Ideal.span {(p : R)})
    (lift : k → R) (residue : ∀ c, phi (lift c) = c) (zero : lift 0 = 0)
    (m : ℕ) (x : artinSchreierChart R p r a b) :
    (∃ y : artinSchreierChart R p r a b, y ∈ artinSchreierCarry R p r a b d ∧
      x ≡ y [SMOD ((Ideal.span {(p : artinSchreierChart R p r a b)}) ^ m)]) ↔
    ∃ digits : Fin m → (Fin r → Fin p) → k,
      x ≡ (∑ j : Fin m, (p : artinSchreierChart R p r a b) ^ j.val *
        artinSchreierNormalDigit p prime.one_lt r a b lift (digits j))
        [SMOD ((Ideal.span {(p : artinSchreierChart R p r a b)}) ^ m)] ∧
      ∀ (j : Fin m) (alpha : Fin r → Fin p),
        d + ((p - 1 : ℕ) : ℤ) * j.val < (∑ i, (alpha i).val : ℕ) → digits j alpha = 0 := by
  constructor
  · rintro ⟨y, member, congruence⟩
    obtain ⟨digits, expansion, degrees⟩ := artin_schreier_carry_fixed_digits p prime r a b d
      phi kernel lift residue zero m y member
    exact ⟨digits, congruence.trans expansion, degrees⟩
  · rintro ⟨digits, expansion, degrees⟩
    refine ⟨_, ?_, expansion⟩
    apply Submodule.sum_mem
    intro j _
    exact artin_schreier_fixed_digit_mem p prime r a b d j.val lift zero (digits j) (degrees j)

/-- The residue ring and kernel here are the actual original quotient
R/(p), rather than an assumed abstract residue model. -/
theorem artin_schreier_original_residue_digits (p : ℕ) (prime : p.Prime) (r : ℕ)
    (a b : Fin r → R) (d : ℤ)
    (lift : R ⧸ Ideal.span {(p : R)} → R)
    (residue : ∀ c, Ideal.Quotient.mk (Ideal.span {(p : R)}) (lift c) = c)
    (zero : lift 0 = 0) (m : ℕ) (x : artinSchreierChart R p r a b)
    (member : x ∈ artinSchreierCarry R p r a b d) :
    ∃ digits : Fin m → (Fin r → Fin p) → R ⧸ Ideal.span {(p : R)},
      x ≡ (∑ j : Fin m, (p : artinSchreierChart R p r a b) ^ j.val *
        artinSchreierNormalDigit p prime.one_lt r a b lift (digits j))
        [SMOD ((Ideal.span {(p : artinSchreierChart R p r a b)}) ^ m)] ∧
      ∀ (j : Fin m) (alpha : Fin r → Fin p),
        d + ((p - 1 : ℕ) : ℤ) * j.val < (∑ i, (alpha i).val : ℕ) → digits j alpha = 0 :=
  artin_schreier_carry_fixed_digits p prime r a b d (Ideal.Quotient.mk _)
    Ideal.mk_ker lift residue zero m x member

end Litt3.Deformations
