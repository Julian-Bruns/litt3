import Solutions.CartierAndSpin.RationalMonomialDegree
import Solutions.CartierAndSpin.FiniteFunctionDegree
import Mathlib.Data.Nat.Find
import Mathlib.Data.Nat.Log

namespace Litt3.CartierAndSpin

variable {k L : Type*} [Field k] [Field L] [Algebra k L]

/-- Root depth is bounded by actual function degree for every exponent
base p>1. This needs neither prime characteristic nor a differential
criterion: the literal monomial minimal polynomial forces p^e to divide
the original function degree. -/
theorem function_root_exponent_bound
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1) (q : L) (hq : Transcendental k q)
    (p : ℕ) (hp : 1 < p) (e : ℕ) (r : L) (hroot : r ^ (p ^ e) = q) :
    e ≤ Nat.log p (Module.finrank (IntermediateField.adjoin k {q}) L) := by
  have hr : Transcendental k r := by
    intro halg
    apply hq
    rw [← hroot]
    exact halg.pow _
  letI : FiniteDimensional (IntermediateField.adjoin k {q}) L :=
    one_variable_finite_function_degree hfg htrdeg q hq
  letI : FiniteDimensional (IntermediateField.adjoin k {r ^ (p ^ e)}) L := by
    rw [hroot]
    infer_instance
  have hdvd := function_power_degree_divisibility r hr (p ^ e)
    (pow_pos (by omega) e)
  rw [hroot] at hdvd
  exact Nat.le_log_of_pow_le hp (Nat.le_of_dvd Module.finrank_pos hdvd)

/-- Every nonconstant one-variable function has a maximal actual
p-power root in the same field. The terminal root is genuinely not a
p-th power; the entire tower depth is bounded by the actual original
function degree. No chosen function degree or terminal-root existence
is input. -/
theorem maximal_function_power_root_exists
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1) (q : L) (hq : Transcendental k q)
    (p : ℕ) (hp : 1 < p) :
    ∃ e : ℕ, ∃ r : L, r ^ (p ^ e) = q ∧
      (¬ ∃ s : L, s ^ p = r) ∧
      e ≤ Nat.log p (Module.finrank (IntermediateField.adjoin k {q}) L) := by
  classical
  let N := Module.finrank (IntermediateField.adjoin k {q}) L
  let P : ℕ → Prop := fun e => ∃ r : L, r ^ (p ^ e) = q
  let e := Nat.findGreatest P (Nat.log p N)
  have hzero : P 0 := ⟨q, by simp⟩
  have he : P e := Nat.findGreatest_spec (Nat.zero_le _) hzero
  obtain ⟨r, hr⟩ := he
  refine ⟨e, r, hr, ?_, Nat.findGreatest_le _⟩
  rintro ⟨s, hs⟩
  have hnext : s ^ (p ^ (e + 1)) = q := by
    rw [pow_succ', pow_mul, hs]
    exact hr
  have hbound : e + 1 ≤ Nat.log p N :=
    function_root_exponent_bound hfg htrdeg q hq p hp (e + 1) s hnext
  have hmax : e + 1 ≤ e := Nat.le_findGreatest hbound ⟨s, hnext⟩
  omega

end Litt3.CartierAndSpin
