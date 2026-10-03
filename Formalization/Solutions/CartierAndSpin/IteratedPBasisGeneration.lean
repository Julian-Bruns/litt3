import Definitions.CartierAndSpin.IteratedFrobeniusFields
import Solutions.SharedTensors.FrobeniusCoordinates
import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors IntermediateField

variable {L : Type*} [Field L] {p : ℕ} [Fact p.Prime] [CharP L p]

/-- A full literal p-basis parameter generates the entire original field
over every actual iterated Frobenius-image subfield. -/
theorem p_basis_generates_over_iterated_frobenius (b : PowerPBasis L p) (e : ℕ) :
    IntermediateField.adjoin (iteratedFrobeniusSubfield L p e) {b.parameter} = ⊤ := by
  have hmem : ∀ e : ℕ, ∀ a : L,
      a ∈ IntermediateField.adjoin (iteratedFrobeniusSubfield L p e) {b.parameter} := by
    intro e
    induction e with
    | zero =>
        intro a
        let c : iteratedFrobeniusSubfield L p 0 := ⟨a, ⟨a, by simp⟩⟩
        exact (IntermediateField.adjoin (iteratedFrobeniusSubfield L p 0)
          {b.parameter}).algebraMap_mem c
    | succ e ih =>
        let F := IntermediateField.adjoin (iteratedFrobeniusSubfield L p e) {b.parameter}
        let G := IntermediateField.adjoin (iteratedFrobeniusSubfield L p (e + 1)) {b.parameter}
        have ht : b.parameter ∈ G := subset_adjoin _ _ (Set.mem_singleton _)
        have hpow : ∀ a ∈ F, a ^ p ∈ G := by
          intro a ha
          induction ha using IntermediateField.adjoin_induction with
          | mem a ha =>
              rw [Set.mem_singleton_iff.mp ha]
              exact G.toSubalgebra.pow_mem ht p
          | algebraMap c =>
              obtain ⟨r, hr⟩ := c.property
              change r ^ (p ^ e) = c.val at hr
              have hcp : c.val ^ p ∈ iteratedFrobeniusSubfield L p (e + 1) := by
                refine ⟨r, ?_⟩
                change r ^ (p ^ (e + 1)) = c.val ^ p
                rw [pow_succ, pow_mul, hr]
              exact G.algebraMap_mem ⟨c.val ^ p, hcp⟩
          | add a c ha hc hpa hpc =>
              rw [add_pow_char]
              exact G.add_mem hpa hpc
          | inv a ha hpa =>
              rw [inv_pow]
              exact G.inv_mem hpa
          | mul a c ha hc hpa hpc =>
              rw [mul_pow]
              exact G.mul_mem hpa hpc
        intro a
        rw [← p_basis_actual_expansion b a]
        apply G.sum_mem
        intro i _
        exact G.mul_mem (hpow _ (ih _)) (G.toSubalgebra.pow_mem ht i.val)
  apply top_unique
  intro a _
  exact hmem e a

end Litt3.CartierAndSpin
