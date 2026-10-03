import Theorems.Deformations.ReciprocalCharacterSections

namespace Litt3.Deformations

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V]

/-- Two actual nonzero eigenvectors in a one-dimensional
space have the same eigenvalue. -/
theorem one_dimensional_eigenvalue_unique (one_dimensional : Module.finrank k V = 1)
    (f : V →ₗ[k] V) (a b : k) (v w : V) (hv : v ≠ 0) (hw : w ≠ 0)
    (hv_action : f v = a • v) (hw_action : f w = b • w) : a = b := by
  obtain ⟨c, hc⟩ := exists_smul_eq_of_finrank_eq_one one_dimensional hv w
  have hc_nonzero : c ≠ 0 := by
    intro hz
    rw [hz, zero_smul] at hc
    exact hw hc.symm
  have heigen : f (c • v) = b • (c • v) := by rw [hc, hw_action]
  rw [map_smul, hv_action, smul_smul, smul_smul] at heigen
  have hcoeff : c * a = b * c := smul_left_injective k hv heigen
  apply mul_left_cancel₀ hc_nonzero
  simpa only [mul_comm b c] using hcoeff

variable {G : Type*} [Group G]

/-- Reciprocal nonzero sections in an actual one-dimensional
representation force the whole character to have square one.
No quadratic-character conclusion is present in the input. -/
theorem reciprocal_character_sections_quadratic (ρ : Representation k G V)
    (χ : G →* kˣ) (one_dimensional : Module.finrank k V = 1)
    (sections : ReciprocalCharacterSections ρ χ) : Specifications.QuadraticCharacter χ := by
  intro g
  have hscalar := one_dimensional_eigenvalue_unique one_dimensional (ρ g)
    (χ g : k) (((χ g)⁻¹ : kˣ) : k) sections.vector sections.reciprocal
    sections.vector_nonzero sections.reciprocal_nonzero
    (sections.vector_action g) (sections.reciprocal_action g)
  have hunit : χ g = (χ g)⁻¹ := Units.ext hscalar
  rw [pow_two]
  calc
    χ g * χ g = (χ g)⁻¹ * χ g := congrArg (fun u : kˣ => u * χ g) hunit
    _ = 1 := inv_mul_cancel (χ g)

end Litt3.Deformations
