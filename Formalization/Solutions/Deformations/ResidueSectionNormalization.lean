import Mathlib.RingTheory.Ideal.Quotient.Operations

namespace Litt3.Deformations

variable {R k : Type*} [CommRing R] [CommRing k]

/-- Every prescribed residue section can be normalized at zero while
retaining its right-inverse property and every nonzero coefficient. -/
theorem residue_section_normalization (phi : R →+* k) (lift : k → R)
    (residue : ∀ c, phi (lift c) = c) :
    ∃ normalized : k → R, (∀ c, phi (normalized c) = c) ∧ normalized 0 = 0 ∧
      ∀ c, c ≠ 0 → normalized c = lift c := by
  classical
  refine ⟨fun c => if c = 0 then 0 else lift c, ?_, by simp, ?_⟩
  · intro c
    by_cases zero : c = 0
    · simp [zero]
    · simp [zero, residue]
  · intro c nonzero
    simp [nonzero]

/-- Actual original residue quotients always admit a zero-preserving
coefficient section, with no field or torsion-free assumption. -/
theorem original_residue_section_exists (p : R) :
    ∃ lift : R ⧸ Ideal.span {p} → R,
      (∀ c, Ideal.Quotient.mk (Ideal.span {p}) (lift c) = c) ∧ lift 0 = 0 := by
  classical
  choose lift residue using (Ideal.Quotient.mk_surjective :
    Function.Surjective (Ideal.Quotient.mk (Ideal.span {p})))
  obtain ⟨normalized, rightInverse, zero, _⟩ :=
    residue_section_normalization (Ideal.Quotient.mk _) lift residue
  exact ⟨normalized, rightInverse, zero⟩

end Litt3.Deformations
