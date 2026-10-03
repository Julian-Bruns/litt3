import Definitions.Deformations.RepresentationCocycles

namespace Litt3.Deformations

universe u v w t

variable {k : Type u} {G : Type v} {H : Type w} {V : Type t}
    [CommRing k] [Group G] [Group H] [AddCommGroup V] [Module k V]

/-- Reindexing through an actual full group isomorphism preserves
the entire actual invariant subspace. -/
theorem representation_group_equiv_invariants (ρ : Representation k H V) (e : G ≃* H) :
    Representation.invariants (ρ.comp e.toMonoidHom) = ρ.invariants := by
  ext v
  rw [Representation.mem_invariants, Representation.mem_invariants]
  constructor
  · intro fixed h
    obtain ⟨g, rfl⟩ := e.surjective h
    exact fixed g
  · intro fixed g
    exact fixed (e g)

/-- An actual group isomorphism reindexes the full group norm,
without changing its actual action on the coefficient module. -/
theorem representation_group_equiv_norm [Fintype G] [Fintype H]
    (ρ : Representation k H V) (e : G ≃* H) :
    Representation.norm (ρ.comp e.toMonoidHom) = ρ.norm :=
  e.toEquiv.sum_comp ρ

end Litt3.Deformations
