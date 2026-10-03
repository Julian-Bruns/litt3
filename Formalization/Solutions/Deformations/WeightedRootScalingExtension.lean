import Solutions.Deformations.WeightedRootIntegralKernel
import Mathlib.FieldTheory.IsAlgClosed.AlgebraicClosure
import Mathlib.RingTheory.Localization.FractionRing

namespace Litt3.Deformations

variable (R : Type*) [CommRing R] [IsDomain R]

/-- An actual field extension in which the graded parameter can be
scaled, constructed from the fraction field and its algebraic closure. -/
abbrev WeightedRootScalingField := AlgebraicClosure (FractionRing R)

noncomputable def weightedRootScalingMap : R →+* WeightedRootScalingField R :=
  (algebraMap (FractionRing R) (WeightedRootScalingField R)).comp
    (algebraMap R (FractionRing R))

theorem weighted_root_scaling_map_injective : Function.Injective (weightedRootScalingMap R) :=
  (algebraMap (FractionRing R) (WeightedRootScalingField R)).injective.comp
    (IsFractionRing.injective R (FractionRing R))

/-- A nonzero scaling root is genuinely available for every nonzero
parameter over an integral domain. No splitting extension is assumed. -/
theorem weighted_root_scaling_extension_exists (q : ℕ) (large : 1 < q)
    (tau : R) (nonzero : tau ≠ 0) :
    ∃ c : WeightedRootScalingField R,
      c ≠ 0 ∧ c ^ (q - 1) = -(weightedRootScalingMap R tau) := by
  obtain ⟨c, root⟩ := IsAlgClosed.exists_pow_nat_eq
    (-(weightedRootScalingMap R tau)) (show 0 < q - 1 by omega)
  refine ⟨c, ?_, root⟩
  intro zero
  have vanished : weightedRootScalingMap R tau = 0 := by
    rw [zero, zero_pow (show q - 1 ≠ 0 by omega)] at root
    exact neg_eq_zero.mp root.symm
  apply nonzero
  apply weighted_root_scaling_map_injective R
  exact vanished.trans (map_zero _).symm

end Litt3.Deformations
