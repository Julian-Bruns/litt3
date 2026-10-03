import Solutions.CartierAndSpin.FrobeniusConstantIntersection
import Mathlib.RingTheory.Derivation.Basic

namespace Litt3.CartierAndSpin

variable {k L : Type*} [Field k] [Field L] [Algebra k L] [IsAlgClosed k]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP L p]

/-- An affine p-power normal form cannot persist at every depth unless
the actual function is an affine constant-field function of the parameter.
This proves the termination step without assuming an intersection theorem
for Frobenius subfields. -/
theorem unbounded_affine_frobenius_forms_force_line
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1) (D : Derivation k L L)
    (t v : L) (ht : D t = 1)
    (hforms : ∀ e : ℕ, ∃ a b : L,
      v = a ^ (p ^ (e + 1)) + t * b ^ (p ^ (e + 1))) :
    ∃ m n : k, v = algebraMap k L n + t * algebraMap k L m := by
  have hkill (e : ℕ) (z : L) : D (z ^ (p ^ (e + 1))) = 0 := by
    rw [pow_succ, pow_mul, D.leibniz_pow, nsmul_eq_mul,
      CharP.cast_eq_zero, zero_mul]
  have hslope : ∀ e : ℕ, ∃ r : L, r ^ (p ^ e) = D v := by
    intro e
    obtain ⟨a, b, hv⟩ := hforms e
    have hdv : D v = b ^ (p ^ (e + 1)) := by
      rw [hv, map_add, D.leibniz, ht, hkill, hkill]
      simp only [smul_eq_mul, mul_one, mul_zero, zero_add]
    refine ⟨b ^ p, ?_⟩
    rw [← pow_mul, ← pow_succ', hdv]
  have hintercept : ∀ e : ℕ, ∃ r : L, r ^ (p ^ e) = v - t * D v := by
    intro e
    obtain ⟨a, b, hv⟩ := hforms e
    have hdv : D v = b ^ (p ^ (e + 1)) := by
      rw [hv, map_add, D.leibniz, ht, hkill, hkill]
      simp only [smul_eq_mul, mul_one, mul_zero, zero_add]
    refine ⟨a ^ p, ?_⟩
    rw [← pow_mul, ← pow_succ', hdv, hv]
    ring
  obtain ⟨m, hm⟩ := (all_frobenius_roots_iff_constant hfg htrdeg (D v)).mp hslope
  obtain ⟨n, hn⟩ := (all_frobenius_roots_iff_constant hfg htrdeg (v - t * D v)).mp hintercept
  refine ⟨m, n, ?_⟩
  rw [hm, hn]
  ring

/-- The generic-contact raising process has a finite stopping depth
whenever the literal coordinate pair is not an affine line. -/
theorem affine_frobenius_normal_form_finite_depth
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1) (D : Derivation k L L)
    (t v : L) (ht : D t = 1)
    (hnotline : ¬ ∃ m n : k, v = algebraMap k L n + t * algebraMap k L m) :
    ∃ e : ℕ, ¬ ∃ a b : L,
      v = a ^ (p ^ (e + 1)) + t * b ^ (p ^ (e + 1)) := by
  by_contra h
  push_neg at h
  exact hnotline (unbounded_affine_frobenius_forms_force_line hfg htrdeg D t v ht h)

end Litt3.CartierAndSpin
