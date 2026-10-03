import Mathlib.RepresentationTheory.Basic
import Mathlib.LinearAlgebra.FiniteDimensional.Basic

namespace Litt3.Deformations

variable {k G V : Type*} [Field k] [Group G] [AddCommGroup V] [Module k V]

/-- Actual nonzero reciprocal character sections. The
existence of the inverse-character section is a separate
duality and Riemann--Roch obligation in a curve application. -/
structure ReciprocalCharacterSections (ρ : Representation k G V) (χ : G →* kˣ) where
  vector : V
  vector_nonzero : vector ≠ 0
  vector_action : ∀ g, ρ g vector = (χ g : k) • vector
  reciprocal : V
  reciprocal_nonzero : reciprocal ≠ 0
  reciprocal_action : ∀ g, ρ g reciprocal = ((χ g)⁻¹ : kˣ) • reciprocal

end Litt3.Deformations
