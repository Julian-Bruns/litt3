import Theorems.Deformations.ObstructionTorsors

/-!
The additive and set-theoretic mechanisms in `marked_obstruction_torsors`.
These lemmas use actual torsor points and arbitrary additive groups. They
make no linearity or perfect-field assumption. The identification of a
geometric lifting problem with this torsor is a separate bridge.
-/

namespace Litt3.Deformations

section AffineObstruction

variable {K O A : Type*} [AddCommGroup K] [AddCommGroup O] [AddTorsor K A]
variable (R : K →+ O) (c : A → O)
variable (h : ∀ (x : K) (a : A), c (x +ᵥ a) = R x + c a)

include h

/-- The full point obstruction has a zero exactly when its negative
value at any origin belongs to the actual additive response image. -/
theorem obstruction_zero_iff (a₀ : A) :
    (∃ a, c a = 0) ↔ ∃ x, R x = -c a₀ := by
  constructor
  · rintro ⟨a, ha⟩
    refine ⟨a -ᵥ a₀, ?_⟩
    have H := h (a -ᵥ a₀) a₀
    rw [vsub_vadd, ha] at H
    exact eq_neg_of_add_eq_zero_left H.symm
  · rintro ⟨x, hx⟩
    refine ⟨x +ᵥ a₀, ?_⟩
    rw [h, hx, neg_add_cancel]

/-- Surjectivity of the complete additive response solves every target
on the point torsor; this includes existence of a zero. -/
theorem obstruction_surjective (hR : Function.Surjective R) :
    Function.Surjective c := by
  intro y
  let a₀ : A := Classical.choice (inferInstance : Nonempty A)
  obtain ⟨x, hx⟩ := hR (y - c a₀)
  refine ⟨x +ᵥ a₀, ?_⟩
  rw [h, hx, sub_add_cancel]

/-- An injective complete response makes the actual marked zero unique. -/
theorem obstruction_injective (hR : Function.Injective R) :
    Function.Injective c := by
  intro a b hab
  have H := h (a -ᵥ b) b
  rw [vsub_vadd, hab] at H
  have hz : R (a -ᵥ b) = 0 :=
    add_right_cancel (H.symm.trans (zero_add (c b)).symm)
  have hv : a -ᵥ b = 0 := hR (hz.trans R.map_zero.symm)
  exact (vsub_eq_zero_iff_eq).mp hv

theorem obstruction_unique_zero (hR : Function.Bijective R) :
    ∃! a, c a = 0 := by
  obtain ⟨a, ha⟩ := obstruction_surjective R c h hR.2 0
  refine ⟨a, ha, ?_⟩
  intro b hb
  exact obstruction_injective R c h hR.1 (hb.trans ha.symm)

end AffineObstruction

section Triangular

variable {P P' K O : Type*} [AddCommGroup O]

/-- Every finite triangular system is a bijection by recursively
appending this step. This theorem is the step and is independent of
the size or presentation of the earlier point space. -/
theorem triangular_step_bijective (earlierEquiv : P ≃ P') (diagonal : K ≃ O)
    (tail : P → O) :
    Function.Bijective (fun x : P × K =>
      (earlierEquiv x.1, diagonal x.2 + tail x.1)) :=
  (triangularStep earlierEquiv diagonal tail).bijective

end Triangular

section DelayedStabilization

variable {L : ℕ → Type*} (truncate : ∀ n, L (n + 1) → L n)

/-- Preserving the three-digits-earlier prefix is enough to produce a
compatible infinite tower. No uniform response group is required. -/
theorem stabilized_levels_compatible
    (provisional : ∀ n, L (n + 2))
    (preserves : ∀ n,
      truncate n (truncate (n + 1) (truncate (n + 2) (provisional (n + 1)))) =
      truncate n (truncate (n + 1) (provisional n))) :
    ∀ n, truncate n (stabilizedLevel truncate provisional (n + 1)) =
      stabilizedLevel truncate provisional n := by
  intro n
  exact preserves n

end DelayedStabilization

end Litt3.Deformations
