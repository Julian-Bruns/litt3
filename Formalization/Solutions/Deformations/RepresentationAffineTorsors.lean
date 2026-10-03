import Definitions.Deformations.RepresentationAffineTorsors

namespace Litt3.Deformations

universe u

variable {k G V A : Type u} [CommRing k] [Group G]
    [AddCommGroup V] [Module k V] [AddTorsor V A] [MulAction G A]
    (ρ : Representation k G V) (compatible : IsRepresentationAffineAction (A := A) ρ)

include compatible in
/-- Compatibility on the actual affine torsor determines the full
actual representation action on every torsor difference. -/
theorem representation_affine_action_vsub (g : G) (a b : A) :
    ρ g (a -ᵥ b) = g • a -ᵥ g • b := by
  have h := compatible g (a -ᵥ b) b
  rw [vsub_vadd] at h
  calc
    ρ g (a -ᵥ b) = (ρ g (a -ᵥ b) +ᵥ g • b) -ᵥ g • b := (vadd_vsub _ _).symm
    _ = g • a -ᵥ g • b := congrArg (fun x : A => x -ᵥ g • b) h.symm

/-- The complete cohomology class is independent of every origin
in the actual point torsor. -/
theorem affine_torsor_class_independent (a b : A) :
    affineTorsorClass ρ compatible a = affineTorsorClass ρ compatible b := by
  apply sub_eq_zero.mp
  change groupCohomology.H1π _ (affineTorsorCocycle ρ compatible a) -
    groupCohomology.H1π _ (affineTorsorCocycle ρ compatible b) = 0
  rw [← map_sub]
  apply (groupCohomology.H1π_eq_zero_iff _).mpr
  refine ⟨a -ᵥ b, ?_⟩
  apply funext
  intro g
  change ρ g (a -ᵥ b) - (a -ᵥ b) = (g • a -ᵥ a) - (g • b -ᵥ b)
  rw [representation_affine_action_vsub ρ compatible]
  exact (vsub_sub_vsub_comm (g • a) a (g • b) b).symm

/-- Vanishing of the genuine class is precisely existence of an
actual fixed torsor point; no prescribed point is assumed to descend. -/
theorem affine_torsor_class_zero_iff_fixed (a : A) :
    affineTorsorClass ρ compatible a = 0 ↔ ∃ b : A, ∀ g : G, g • b = b := by
  change groupCohomology.H1π _ (affineTorsorCocycle ρ compatible a) = 0 ↔ _
  rw [groupCohomology.H1π_eq_zero_iff]
  constructor
  · rintro ⟨v, hv⟩
    refine ⟨(-v) +ᵥ a, ?_⟩
    intro g
    apply (vsub_eq_zero_iff_eq).mp
    rw [compatible, map_neg, vadd_vsub_vadd_comm]
    have h := congrFun hv g
    change ρ g v - v = g • a -ᵥ a at h
    rw [← h]
    abel
  · rintro ⟨b, fixed⟩
    refine ⟨a -ᵥ b, ?_⟩
    apply funext
    intro g
    change ρ g (a -ᵥ b) - (a -ᵥ b) = g • a -ᵥ a
    rw [representation_affine_action_vsub ρ compatible, fixed g]
    exact vsub_sub_vsub_cancel_right _ _ _

end Litt3.Deformations
