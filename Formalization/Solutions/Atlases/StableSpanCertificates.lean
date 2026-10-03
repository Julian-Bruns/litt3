import Definitions.Atlases.StableSpanCertificates
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.Atlases

section Semiring

variable {K A : Type*} [CommSemiring K] [Semiring A] [Algebra K A]

/-- A submodule containing one and stable under actual algebra
generators equals the whole algebra. The stability is inside the
original algebra, not merely in an approximate presentation. -/
theorem submodule_eq_top_of_one_and_generator_stability
    (S : Submodule K A) (G : Set A) (hG : Algebra.adjoin K G = ⊤)
    (h1 : (1 : A) ∈ S) (stable : ∀ g ∈ G, ∀ x ∈ S, g * x ∈ S) : S = ⊤ := by
  have hstab : Algebra.adjoin K G ≤ leftMultiplierStabilizer S :=
    Algebra.adjoin_le (fun g hg => stable g hg)
  rw [hG] at hstab
  apply top_unique
  intro x _
  have hx : x ∈ leftMultiplierStabilizer S := hstab trivial
  simpa only [mul_one] using hx 1 h1

end Semiring

section Field

variable {K A ι : Type*} [Field K] [Ring A] [Algebra K A] [Fintype ι]

/-- The border/stability certificate makes a family with cardinality
at most the independently known dimension an actual basis family. -/
theorem stable_generator_span_basis_certificate (b : ι → A) (G : Set A)
    (hG : Algebra.adjoin K G = ⊤) (h1 : (1 : A) ∈ Submodule.span K (Set.range b))
    (stable : ∀ g ∈ G, ∀ x ∈ Submodule.span K (Set.range b),
      g * x ∈ Submodule.span K (Set.range b))
    (hcard : Fintype.card ι ≤ Module.finrank K A) :
    Submodule.span K (Set.range b) = ⊤ ∧
      Fintype.card ι = Module.finrank K A ∧ LinearIndependent K b := by
  have hs := submodule_eq_top_of_one_and_generator_stability
    (Submodule.span K (Set.range b)) G hG h1 stable
  refine ⟨hs, le_antisymm hcard (finrank_le_of_span_eq_top hs), ?_⟩
  exact linearIndependent_of_top_le_span_of_card_le_finrank (le_of_eq hs.symm) hcard

end Field
end Litt3.Atlases
