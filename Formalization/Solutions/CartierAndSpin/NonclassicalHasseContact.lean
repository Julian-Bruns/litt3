import Solutions.CartierAndSpin.AffineHasseContactRaising
import Solutions.CartierAndSpin.PBasisAffineNormalForm
import Solutions.CartierAndSpin.AffineFrobeniusTermination

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k L : Type*} [Field k] [Field L] [Algebra k L] [IsAlgClosed k]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP L p]

/-- A nonline affine coordinate with vanishing second derivative has
an actual finite first higher tangent coefficient, whose order is a
positive power of the characteristic. Every coefficient in this claim
comes from the literal truncated Taylor algebra. -/
theorem nonclassical_hasse_contact_is_characteristic_power
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1)
    (b : PowerPBasis L p) (D : Derivation k L L) (ht : D b.parameter = 1)
    (v : L) (hsecond : D (D v) = 0)
    (hnotline : ¬ ∃ m n : k, v = algebraMap k L n + b.parameter * algebraMap k L m) :
    ∃ r : ℕ, 0 < r ∧
      truncatedHasseDerivative b (r + 1) (p ^ r) v ≠ 0 ∧
      ∀ j : ℕ, 2 ≤ j → j < p ^ r → truncatedHasseDerivative b (r + 1) j v = 0 := by
  classical
  let A (r : ℕ) : Prop := ∃ a c : L, v = a ^ (p ^ r) + b.parameter * c ^ (p ^ r)
  have hAone : A 1 := by
    simpa only [A, pow_one] using (normalized_second_derivation_zero_iff b D ht v).mp hsecond
  have hfail : ∃ r : ℕ, ¬ A (r + 1) :=
    affine_frobenius_normal_form_finite_depth hfg htrdeg D b.parameter v ht hnotline
  let r := Nat.find hfail
  have hr : 0 < r := by
    by_contra hn
    have hr0 : r = 0 := by omega
    have hspec : ¬ A (r + 1) := Nat.find_spec hfail
    exact hspec (by simpa only [hr0, zero_add] using hAone)
  have hAr : A r := by
    have hlt : r - 1 < Nat.find hfail := by change r - 1 < r; omega
    have hmin := Nat.find_min hfail hlt
    have heq : r - 1 + 1 = r := by omega
    exact not_not.mp (by simpa only [heq] using hmin)
  have hpowers : p ^ r < p ^ (r + 1) := by
    rw [pow_succ]
    have hpos := pow_pos (Fact.out : p.Prime).pos r
    have hprime := (Fact.out : p.Prime).one_lt
    nlinarith
  obtain ⟨a, c, hv⟩ := hAr
  refine ⟨r, hr, ?_, ?_⟩
  · intro hzero
    obtain ⟨a', c', hraised⟩ := affine_frobenius_form_raises_of_hasse_zero b D ht
      (r + 1) r hr hpowers a c (by simpa only [hv] using hzero)
    exact (Nat.find_spec hfail) ⟨a', c', hv.trans hraised⟩
  · intro j hjlower hjupper
    rw [hv]
    exact affine_frobenius_hasse_lower_vanish b (r + 1) r j
      (hjupper.trans hpowers) hjlower hjupper a c

end Litt3.CartierAndSpin
