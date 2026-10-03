import Definitions.Deformations.RegularFunctionRepresentation
import Mathlib.LinearAlgebra.Basis.VectorSpace

namespace Litt3.Deformations

variable {k G V : Type*} [Field k] [Group G] [AddCommGroup V] [Module k V]

/-- An ordinary linear retraction onto the actual invariant subspace.
Its choice uses vector-space complements, with no averaging or division
by the group order. -/
noncomputable def invariantRetraction (ρ : Representation k G V) : V →ₗ[k] ρ.invariants :=
  ρ.invariants.linearProjOfIsCompl
    (Classical.choose ρ.invariants.exists_isCompl)
    (Classical.choose_spec ρ.invariants.exists_isCompl)

/-- The actual orbit-function map into the full function module on the
actual invariant coefficient space. Injectivity is a theorem. -/
noncomputable def invariantOrbitMap (ρ : Representation k G V) : V →ₗ[k] (G → ρ.invariants) :=
  projectedOrbitMap ρ (invariantRetraction ρ)

end Litt3.Deformations
