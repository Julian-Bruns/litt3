import Definitions.Deformations.FiniteShiftCokernel
import Solutions.Deformations.CommutingCokernels
import Solutions.Deformations.ZModPowerQuotient

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

theorem scalar_power_range_antitone (r : R) (e j : ℕ) (bound : e ≤ j) :
    coefficientScalarRange (K := K) (r ^ j) ≤ coefficientScalarRange (r ^ e) := by
  rintro v ⟨w, rfl⟩
  refine ⟨r ^ (j - e) • w, ?_⟩
  change r ^ e • (r ^ (j - e) • w) = r ^ j • w
  rw [smul_smul, ← pow_add, Nat.add_sub_of_le bound]

theorem scalar_power_range_sup (r : R) (e j : ℕ) :
    coefficientScalarRange (K := K) (r ^ e) ⊔ coefficientScalarRange (r ^ j) =
      coefficientScalarRange (r ^ min e j) := by
  by_cases bound : e ≤ j
  · rw [Nat.min_eq_left bound, sup_eq_left.mpr (scalar_power_range_antitone r e j bound)]
  · have reverse : j ≤ e := by omega
    rw [Nat.min_eq_right reverse, sup_eq_right.mpr (scalar_power_range_antitone r j e reverse)]

theorem scalar_endomorphisms_commute (r s : R) :
    Commute (r • (LinearMap.id : Module.End R K)) (s • (LinearMap.id : Module.End R K)) := by
  apply LinearMap.ext
  intro v
  change r • (s • v) = s • (r • v)
  rw [smul_smul, smul_smul, mul_comm]

theorem scalar_quotient_endomorphism (r s : R) :
    commutingRangeQuotientEnd (r • (LinearMap.id : Module.End R K))
      (s • (LinearMap.id : Module.End R K)) (scalar_endomorphisms_commute r s) =
      s • (LinearMap.id : Module.End R (K ⧸ coefficientScalarRange (K := K) r)) := by
  apply LinearMap.ext
  intro v
  obtain ⟨w, rfl⟩ := (coefficientScalarRange (K := K) r).mkQ_surjective v
  change (coefficientScalarRange (K := K) r).mkQ (s • w) =
    s • (coefficientScalarRange (K := K) r).mkQ w
  exact map_smul _ _ _

/-- Two actual scalar-power quotients combine by the exact minimum
exponent, on every original coefficient module. -/
noncomputable def scalarPowerDoubleQuotientEquiv (r : R) (e j : ℕ) :
    ((K ⧸ coefficientScalarRange (K := K) (r ^ e)) ⧸
      coefficientScalarRange (K := K ⧸ coefficientScalarRange (K := K) (r ^ e)) (r ^ j)) ≃ₗ[R]
      (K ⧸ coefficientScalarRange (K := K) (r ^ min e j)) :=
  (Submodule.quotEquivOfEq _ _
    ((congrArg LinearMap.range (scalar_quotient_endomorphism (K := K) (r ^ e) (r ^ j))).symm.trans
      (commuting_range_quotient_range _ _ (scalar_endomorphisms_commute (r ^ e) (r ^ j))))).trans
    ((Submodule.quotientQuotientEquivQuotientSup (coefficientScalarRange (K := K) (r ^ e))
      (coefficientScalarRange (K := K) (r ^ j))).trans
        (Submodule.quotEquivOfEq _ _ (scalar_power_range_sup r e j)))

theorem zmod_double_power_quotient_card (p N e j : ℕ) (positive : 0 < p) (bound : e ≤ N) :
    Nat.card ((ZMod (p ^ N) ⧸ coefficientScalarRange (K := ZMod (p ^ N)) ((p : ZMod (p ^ N)) ^ e)) ⧸
      coefficientScalarRange (K := ZMod (p ^ N) ⧸ coefficientScalarRange (K := ZMod (p ^ N))
        ((p : ZMod (p ^ N)) ^ e)) ((p : ZMod (p ^ N)) ^ j)) = p ^ min e j := by
  rw [Nat.card_congr (scalarPowerDoubleQuotientEquiv (K := ZMod (p ^ N)) (p : ZMod (p ^ N)) e j).toEquiv]
  exact zmod_power_quotient_card p N (min e j) positive (le_trans (Nat.min_le_left _ _) bound)

end Litt3.Deformations
