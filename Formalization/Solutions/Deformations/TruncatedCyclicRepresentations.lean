import Definitions.Deformations.TruncatedCyclicRepresentations
import Solutions.Deformations.TruncatedRestriction
import Solutions.Deformations.CyclicNormPower

namespace Litt3.Deformations

universe u

theorem p_power_cyclic_generator_generates (p a : ℕ) [Fact p.Prime]
    (x : Multiplicative (ZMod (p ^ a))) : x ∈ Subgroup.zpowers (pPowerCyclicGenerator p a) := by
  refine ⟨(Multiplicative.toAdd x).val, ?_⟩
  change Multiplicative.ofAdd (1 : ZMod (p ^ a)) ^
    ((Multiplicative.toAdd x).val : ℤ) = x
  rw [zpow_natCast]
  change Multiplicative.ofAdd ((Multiplicative.toAdd x).val • (1 : ZMod (p ^ a))) = x
  simp only [Nat.smul_one_eq_cast, ZMod.natCast_zmod_val]
  rfl

theorem p_power_cyclic_generator_order (p a : ℕ) :
    orderOf (pPowerCyclicGenerator p a) = p ^ a :=
  ZMod.addOrderOf_one (p ^ a)

variable {k : Type u} [CommRing k]

@[simp] theorem truncated_cyclic_generator_action (p a j : ℕ)
    [Fact p.Prime] [CharP k p] (bound : j ≤ p ^ a)
    (v : TruncatedCoefficientRing k j) :
    truncatedCyclicBlockRepresentation p a j bound (pPowerCyclicGenerator p a) v =
      (1 + truncatedParameter k j) * v := by
  change truncatedRestriction k (p ^ a) j bound
    (truncatedCyclicGroupHom p a (Multiplicative.ofAdd 1)) * v = _
  rw [truncated_cyclic_group_hom_one, map_add, map_one, truncated_restriction_parameter]

theorem truncated_cyclic_generator_difference (p a j : ℕ)
    [Fact p.Prime] [CharP k p] (bound : j ≤ p ^ a) :
    truncatedCyclicBlockRepresentation (k := k) p a j bound (pPowerCyclicGenerator p a) - 1 =
      truncatedPowerCoefficientMap k j 1 := by
  apply LinearMap.ext
  intro v
  change truncatedCyclicBlockRepresentation p a j bound (pPowerCyclicGenerator p a) v - v =
    truncatedParameter k j ^ 1 * v
  rw [truncated_cyclic_generator_action, add_mul, one_mul, add_sub_cancel_left, pow_one]

/-- The actual full group norm on the actual quotient block is
literal multiplication by its highest cyclic augmentation power. -/
theorem truncated_cyclic_norm_action (p a j : ℕ)
    [Fact p.Prime] [CharP k p] (bound : j ≤ p ^ a) :
    (truncatedCyclicBlockRepresentation (k := k) p a j bound).norm =
      truncatedPowerCoefficientMap k j (p ^ a - 1) := by
  have norm : (truncatedCyclicBlockRepresentation (k := k) p a j bound).norm =
      (truncatedCyclicBlockRepresentation (k := k) p a j bound (pPowerCyclicGenerator p a) - 1) ^
        (p ^ a - 1) := cyclic_norm_eq_augmentation_power p a
    (truncatedCyclicBlockRepresentation (k := k) p a j bound) (pPowerCyclicGenerator p a)
    (p_power_cyclic_generator_generates p a) (p_power_cyclic_generator_order p a)
  rw [norm, truncated_cyclic_generator_difference]
  have model : ∀ n, truncatedPowerCoefficientMap k j n =
      Algebra.lmul k (TruncatedCoefficientRing k j) (truncatedParameter k j ^ n) := by
    intro n
    apply LinearMap.ext
    intro v
    rfl
  rw [model, pow_one, model]
  exact (map_pow _ _ _).symm

end Litt3.Deformations
