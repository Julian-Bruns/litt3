import Mathlib.FieldTheory.Finite.Basic
import Mathlib.FieldTheory.Perfect
import Mathlib.LinearAlgebra.LinearIndependent.Lemmas
import Mathlib.LinearAlgebra.Finsupp.LinearCombination

namespace Litt3.CartierAndSpin

variable {k V : Type*} [Field k] [PerfectField k]
    [AddCommGroup V] [Module k V] {p : ℕ} [Fact p.Prime] [CharP k p]

/-- Fixed vectors which are independent over the actual prime subfield
are independent over the entire perfect field. Neither invertibility of
the operator nor finite dimension of the ambient space is required. -/
theorem inverse_frobenius_fixed_fin_independent
    (C : V →+ V) (hC : ∀ (a : k) (v : V), C (a ^ p • v) = a • C v)
    (n : ℕ) (v : Fin n → V) (hfixed : ∀ i, C (v i) = v i)
    (hind : LinearIndependent (⊥ : Subfield k) v) : LinearIndependent k v := by
  classical
  induction n with
  | zero => exact linearIndependent_empty_type
  | succ n ih =>
    have htail := ih (Fin.tail v) (fun i => hfixed i.succ)
      (linearIndependent_fin_succ.mp hind).1
    apply linearIndependent_fin_succ.mpr
    refine ⟨htail, ?_⟩
    intro hmem
    obtain ⟨c, hc⟩ := (Submodule.mem_span_range_iff_exists_fun k).mp hmem
    let r : Fin n → k := fun i => (frobeniusEquiv k p).symm (c i)
    have hroot (i : Fin n) : (r i) ^ p = c i :=
      frobeniusEquiv_symm_pow_p k p (c i)
    have hr : ∑ i, r i • Fin.tail v i = v 0 := by
      calc
        ∑ i, r i • Fin.tail v i = ∑ i, C (c i • Fin.tail v i) := by
          apply Finset.sum_congr rfl
          intro i _
          rw [← hroot i, hC]
          change r i • v i.succ = r i • C (v i.succ)
          rw [hfixed i.succ]
        _ = C (∑ i, c i • Fin.tail v i) := (map_sum C _ _).symm
        _ = v 0 := by rw [hc, hfixed 0]
    have hcr (i : Fin n) : c i = r i := htail.eq_coords_of_eq (hc.trans hr.symm) i
    have hpow (i : Fin n) : (c i) ^ p = c i :=
      (congrArg (fun x : k => x ^ p) (hcr i)).trans (hroot i)
    let cp : Fin n → (⊥ : Subfield k) := fun i =>
      ⟨c i, (Subfield.mem_bot_iff_pow_eq_self k p).mpr (hpow i)⟩
    apply (linearIndependent_fin_succ.mp hind).2
    apply (Submodule.mem_span_range_iff_exists_fun (⊥ : Subfield k)).mpr
    refine ⟨cp, ?_⟩
    change ∑ i, c i • Fin.tail v i = v 0
    exact hc

/-- The same descent statement for an arbitrary, possibly infinite,
indexed family of fixed vectors. -/
theorem inverse_frobenius_fixed_independent
    (C : V →+ V) (hC : ∀ (a : k) (v : V), C (a ^ p • v) = a • C v)
    {ι : Type*} (v : ι → V) (hfixed : ∀ i, C (v i) = v i)
    (hind : LinearIndependent (⊥ : Subfield k) v) : LinearIndependent k v := by
  classical
  apply linearIndependent_iff_finset_linearIndependent.mpr
  intro s
  let e := (Fintype.equivFin s).symm
  apply (linearIndependent_equiv e).mp
  apply inverse_frobenius_fixed_fin_independent C hC
  · intro i
    exact hfixed (e i).val
  · exact ((linearIndependent_iff_finset_linearIndependent.mp hind) s).comp e e.injective

end Litt3.CartierAndSpin
