import Definitions.Deformations.RepresentationCocycles
import Mathlib.Algebra.AddTorsor.Basic

namespace Litt3.Deformations

universe u

variable {k G V A : Type u} [CommRing k] [Group G]
    [AddCommGroup V] [Module k V] [AddTorsor V A] [MulAction G A]

/-- The actual group action on the full point torsor has linear
part equal to the specified actual representation. -/
def IsRepresentationAffineAction (ρ : Representation k G V) : Prop :=
  ∀ (g : G) (v : V) (a : A), g • (v +ᵥ a) = ρ g v +ᵥ (g • a)

/-- Actual deck differences of an arbitrary torsor point form a
genuine degree-one cocycle, retaining every group element. -/
def affineTorsorCocycle (ρ : Representation k G V)
    (compatible : IsRepresentationAffineAction (A := A) ρ) (a : A) :
    groupCohomology.cocycles₁ (Rep.of ρ) :=
  ⟨fun g => g • a -ᵥ a,
    (groupCohomology.mem_cocycles₁_iff (A := Rep.of ρ) _).mpr (by
      intro g h
      have action : (g * h) • a = ρ g (h • a -ᵥ a) +ᵥ (g • a) := by
        rw [mul_smul]
        calc
          g • (h • a) = g • ((h • a -ᵥ a : V) +ᵥ a) := by rw [vsub_vadd]
          _ = ρ g (h • a -ᵥ a) +ᵥ (g • a) := compatible g _ a
      rw [action, vadd_vsub_assoc]
      rfl)⟩

noncomputable def affineTorsorClass (ρ : Representation k G V)
    (compatible : IsRepresentationAffineAction (A := A) ρ) (a : A) :
    groupCohomology (Rep.of ρ) 1 :=
  groupCohomology.H1π _ (affineTorsorCocycle ρ compatible a)

end Litt3.Deformations
