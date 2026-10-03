import Mathlib.FieldTheory.SeparablyGenerated

namespace Litt3.SharedTensors

open IntermediateField

variable {k K : Type*} [Field k] [Field K] [Algebra k K] [PerfectField k]

/-- Every actual finitely generated one-variable extension of a perfect
field has an actual separating function. This is proved from Mathlib's
general separating-transcendence-basis theorem, with no selected endpoint
or existence-of-coordinate premise. -/
theorem one_variable_separating_element_exists
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) :
    ∃ x : K, Transcendental k x ∧
      Algebra.IsSeparable (IntermediateField.adjoin k {x}) K := by
  classical
  obtain ⟨s, hs, hsep⟩ :=
    exists_isTranscendenceBasis_and_isSeparable_of_perfectField hfg
  have hcard : s.card = 1 := by
    have h := hs.cardinalMk_eq_trdeg
    rw [htrdeg, Cardinal.mk_fintype, Fintype.card_coe] at h
    exact_mod_cast h
  obtain ⟨x, hx⟩ := Finset.card_eq_one.mp hcard
  subst s
  refine ⟨x, hs.1.transcendental ⟨x, by simp⟩, ?_⟩
  have hset : (({x} : Finset K) : Set K) = {x} := by ext a; simp
  rw [← hset]
  exact hsep

end Litt3.SharedTensors
