import Solutions.Atlases.FiniteAlgebraDecomposition
import Solutions.Atlases.WeightedCompleteness

namespace Litt3.Atlases

variable {k A : Type*} [Field k] [CommRing A] [Algebra k A]
  [FiniteDimensional k A] [Fintype (MaximalSpectrum A)]

theorem finite_algebra_closed_points_complete_of_lower_lengths
    (s : Finset (MaximalSpectrum A)) (ell : MaximalSpectrum A → ℕ)
    (lower : ∀ P ∈ s, ell P ≤
      (Module.length (A ⧸ P.asIdeal ^ Module.finrank k A)
        (A ⧸ P.asIdeal ^ Module.finrank k A)).toNat)
    (total : ∑ P ∈ s, Module.finrank k (A ⧸ P.asIdeal) * ell P =
      Module.finrank k A) :
    s = Finset.univ ∧ ∀ P, ell P =
      (Module.length (A ⧸ P.asIdeal ^ Module.finrank k A)
        (A ⧸ P.asIdeal ^ Module.finrank k A)).toNat := by
  classical
  let w (P : MaximalSpectrum A) :=
    Module.finrank k (A ⧸ P.asIdeal ^ Module.finrank k A)
  let b (P : MaximalSpectrum A) := Module.finrank k (A ⧸ P.asIdeal) * ell P
  have positive : ∀ P, 0 < w P := fun P => Module.finrank_pos
  have hle : ∀ P ∈ s, b P ≤ w P := by
    intro P hP
    dsimp only [b, w]
    rw [finite_algebra_local_factor_dimension_residue P]
    exact Nat.mul_le_mul_left _ (lower P hP)
  have htotal : ∑ P ∈ s, b P = ∑ P, w P := by
    change (∑ P ∈ s, Module.finrank k (A ⧸ P.asIdeal) * ell P) = _
    rw [total]
    exact finite_algebra_dimension_sum_local_factors
  obtain ⟨hs, hb⟩ := weighted_lower_bounds_complete s w b positive hle htotal
  refine ⟨hs, ?_⟩
  intro P
  letI := Ideal.Quotient.field P.asIdeal
  have hd : 0 < Module.finrank k (A ⧸ P.asIdeal) := Module.finrank_pos
  have h := hb P
  dsimp only [b, w] at h
  rw [finite_algebra_local_factor_dimension_residue P] at h
  exact Nat.eq_of_mul_eq_mul_left hd h

end Litt3.Atlases
