import Theorems.CartierAndSpin.FirstHasseContactType
import Solutions.CartierAndSpin.NonclassicalHasseContact
import Solutions.CartierAndSpin.TruncatedHasseSecondDerivative

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k L : Type*} [Field k] [Field L] [Algebra k L] [IsAlgClosed k]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP L p]

/-- Every literal nonline coordinate pair has actual first tangent
contact either two or a positive characteristic power. All p-basis,
Taylor maps, higher coefficients and Frobenius termination facts are
genuine checked algebraic constructions. -/
theorem first_hasse_contact_type
    (hpodd : Odd p) (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1)
    (b : PowerPBasis L p) (D : Derivation k L L) (ht : D b.parameter = 1)
    (v : L)
    (hnotline : ¬ ∃ m n : k, v = algebraMap k L n + b.parameter * algebraMap k L m) :
    FirstHasseContactType b v := by
  have hpgt : 2 < p := by
    have hpge := (Fact.out : p.Prime).two_le
    have hpne : p ≠ 2 := by
      intro h
      rw [h] at hpodd
      obtain ⟨n, hn⟩ := hpodd
      omega
    omega
  by_cases hsecond : D (D v) = 0
  · obtain ⟨r, hr, hnonzero, hvanish⟩ :=
      nonclassical_hasse_contact_is_characteristic_power hfg htrdeg b D ht v hsecond hnotline
    have hpos := pow_pos (Fact.out : p.Prime).pos r
    have hpower : 1 < p ^ r := (Nat.one_lt_pow_iff hr.ne').mpr (Fact.out : p.Prime).one_lt
    have hlt : p ^ r < p ^ (r + 1) := by rw [pow_succ]; nlinarith
    exact ⟨r + 1, p ^ r, by omega, hlt, Or.inr ⟨r, hr, rfl⟩, hnonzero, hvanish⟩
  · refine ⟨1, 2, le_rfl, by simpa using hpgt, Or.inl rfl, ?_, ?_⟩
    · intro hzero
      apply hsecond
      rw [← truncated_hasse_second_derivative b D ht 1 (by simpa using hpgt) v,
        hzero, mul_zero]
    · intro j hjlower hjupper
      omega

end Litt3.CartierAndSpin
