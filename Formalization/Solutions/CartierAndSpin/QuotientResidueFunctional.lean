import Definitions.CartierAndSpin.QuotientResidueFunctional
import Solutions.CartierAndSpin.PolynomialResiduePairing

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The intrinsic functional agrees with the literal reduced coefficient. -/
theorem quotient_residue_functional_mk {D : K[X]} (hD : D.Monic) (P : K[X]) :
    quotientResidueFunctional hD (AdjoinRoot.mk D P) =
      (P % D).coeff (D.natDegree - 1) := by
  simp only [quotientResidueFunctional, LinearMap.comp_apply,
    Polynomial.lcoeff_apply, AdjoinRoot.modByMonicHom_mk,
    Polynomial.modByMonic_eq_mod P hD]

theorem quotient_residue_pairing_apply {D : K[X]} (hD : D.Monic)
    (x y : AdjoinRoot D) :
    quotientResiduePairing hD x y = quotientResidueFunctional hD (x * y) := rfl

/-- Every nonzero actual quotient value pairs nontrivially with some
power of the quotient generator below the full quotient dimension. -/
theorem quotient_residue_pairing_nonzero {D : K[X]} (hD : D.Monic)
    (x : AdjoinRoot D) (hx : x ≠ 0) :
    ∃ j : ℕ, j < D.natDegree ∧
      quotientResiduePairing hD x (AdjoinRoot.root D ^ j) ≠ 0 := by
  obtain ⟨P, ⟨hsmall, hPx⟩, _⟩ := source_quotient_reduced_polynomial D hD.ne_zero x
  have hP : P ≠ 0 := by intro hz; simp [hz] at hPx; exact hx hPx.symm
  obtain ⟨j, hj, hmoment⟩ :=
    nonzero_reduced_polynomial_residue_moment D P hD.ne_zero hP hsmall
  refine ⟨j, hj, ?_⟩
  rw [quotient_residue_pairing_apply, ← hPx, mul_comm,
    ← AdjoinRoot.mk_X, ← map_pow, ← map_mul,
    quotient_residue_functional_mk]
  exact hmoment

/-- The actual residue pairing has zero left kernel, including every
inseparable or nonreduced monic quotient and the zero quotient. -/
theorem quotient_residue_pairing_injective {D : K[X]} (hD : D.Monic) :
    Function.Injective (quotientResiduePairing hD) := by
  apply LinearMap.ker_eq_bot.mp
  apply LinearMap.ker_eq_bot'.mpr
  intro x hx
  by_contra hnonzero
  obtain ⟨j, _, hpair⟩ := quotient_residue_pairing_nonzero hD x hnonzero
  apply hpair
  exact congrArg (fun f : Module.Dual K (AdjoinRoot D) => f (AdjoinRoot.root D ^ j)) hx

end Litt3.CartierAndSpin
