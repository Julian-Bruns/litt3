import Solutions.CartierAndSpin.NewtonCarries
import Mathlib.RingTheory.LocalRing.ResidueField.Basic

namespace Litt3.CartierAndSpin

open IsLocalRing

variable {R K ι : Type*} [CommRing R] [IsLocalRing R] [Field K] [Fintype ι]

/-- Natural integers prime to the residue characteristic are precisely the
units of the actual local ring, even in mixed characteristic. -/
theorem local_natCast_isUnit_iff_not_dvd (p : ℕ) [CharP (ResidueField R) p] (k : ℕ) :
    IsUnit (k : R) ↔ ¬p ∣ k := by
  rw [← residue_ne_zero_iff_isUnit, map_natCast, Ne, CharP.cast_eq_zero_iff (ResidueField R) p]

omit [IsLocalRing R] in
theorem unit_image_inverse_mem_range (f : R →+* K) (a : R) (ha : IsUnit a) :
    f a ≠ 0 ∧ (f a)⁻¹ ∈ f.range := by
  constructor
  · exact (ha.map f).ne_zero
  · refine ⟨↑(ha.unit⁻¹), ?_⟩
    rw [map_units_inv, ha.unit_spec]

/-- The complete carry induction in an actual local ring, with membership
under an actual ring map. The fraction field can have characteristic zero. -/
theorem local_newton_carry_membership (f : R →+* K) (p N : ℕ)
    [CharP (ResidueField R) p] (u : ι → K)
    (hcarries : ∀ k, 0 < k → k ≤ N → p ∣ k → finiteElementarySymmetric u k ∈ f.range)
    (htraces : ∀ k, 0 < k → k ≤ N → ¬p ∣ k → finitePowerSum u k ∈ f.range) :
    ∀ k, k ≤ N → finiteElementarySymmetric u k ∈ f.range ∧ finitePowerSum u k ∈ f.range := by
  apply newton_carry_membership f.range p N u ?_ hcarries htraces
  intro k _ _ hk
  have hunit : IsUnit (k : R) := (local_natCast_isUnit_iff_not_dvd p k).mpr hk
  simpa only [map_natCast] using unit_image_inverse_mem_range f (k : R) hunit

end Litt3.CartierAndSpin
