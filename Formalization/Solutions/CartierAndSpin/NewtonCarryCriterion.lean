import Theorems.CartierAndSpin.NewtonCarryCriterion
import Solutions.CartierAndSpin.AllNewtonCarryUnits
import Solutions.CartierAndSpin.NewtonCarryNecessity

namespace Litt3.CartierAndSpin

open IsLocalRing

variable {R K Γ ι : Type*} [CommRing R] [IsLocalRing R] [Field K]
  [Algebra R K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

/-- Exact necessary and sufficient arbitrary-degree carry criterion. All
data use the actual local ring, and residue characteristic alone is used. -/
theorem newtonCarry_unit_iff_conditions (v : Valuation K Γ) (hv : v.Integers R)
    (p : ℕ) [CharP (ResidueField R) p] (hp : 0 < p) (u : ι → K)
    (hdegree : p ≤ Fintype.card ι) (hnorm : v (∏ i, u i) = 1)
    (hforward : ∀ k, 0 < k → k < p → finitePowerSum u k ∈ (algebraMap R K).range)
    (hreciprocal : ∀ k, 0 < k → k < p →
      finitePowerSum (fun i => (u i)⁻¹) k ∈ (algebraMap R K).range) :
    Specifications.TupleDescendsAsUnits (R := R) u ↔
      Specifications.NewtonCarryConditions (R := R) u p := by
  constructor
  · intro hunits
    obtain ⟨htraces, _, helementary, _⟩ := descended_unit_tuple_all_newton_data_regular u hunits
    exact ⟨fun k _ _ _ => helementary k, fun k _ _ _ => htraces k⟩
  · rintro ⟨hcarries, hextra⟩
    exact all_newton_carries_force_units v hv p hp u hdegree hnorm
      hforward hreciprocal hcarries hextra

omit [IsLocalRing R] in
/-- In degrees 2p+r with r<p, the exact carry list reduces to e_p and
precisely the traces P_(p+1),...,P_(p+r). -/
theorem newtonCarry_conditions_twice_characteristic {p r : ℕ}
    (hp : 0 < p) (hrp : r < p) (u : ι → K) (hdegree : Fintype.card ι = 2 * p + r) :
    Specifications.NewtonCarryConditions (R := R) u p ↔
      (finiteElementarySymmetric u p ∈ (algebraMap R K).range ∧
        ∀ i, 0 < i → i ≤ r → finitePowerSum u (p + i) ∈ (algebraMap R K).range) := by
  have hbound : Fintype.card ι - p = p + r := by omega
  constructor
  · rintro ⟨hcarries, hextra⟩
    refine ⟨hcarries p hp (by omega) (dvd_refl p), ?_⟩
    intro i hi hir
    have hnotdiv : ¬p ∣ p + i := by
      intro hdiv
      have hidiv : p ∣ i := (Nat.dvd_add_iff_right (dvd_refl p)).mpr hdiv
      exact Nat.not_dvd_of_pos_of_lt hi (lt_of_le_of_lt hir hrp) hidiv
    exact hextra (p + i) (by omega) (by omega) hnotdiv
  · rintro ⟨hcarry, htraces⟩
    constructor
    · intro k hk hkle hdiv
      obtain ⟨j, hj⟩ := hdiv
      have hjpos : 0 < j := by
        by_contra hj0
        have hz : j = 0 := by omega
        simp [hz] at hj
        omega
      have hjone : j = 1 := by
        by_contra hjne
        have hjtwo : 2 ≤ j := by omega
        have htwop := Nat.mul_le_mul_left p hjtwo
        omega
      have hkp : k = p := by simpa [hjone] using hj
      simpa only [hkp] using hcarry
    · intro k hpk hkle hnotdiv
      have hkp : p < k := by
        by_contra hnotlt
        have heq : k = p := by omega
        exact hnotdiv (heq ▸ dvd_refl p)
      have hi : 0 < k - p := by omega
      have hir : k - p ≤ r := by omega
      simpa only [Nat.add_sub_of_le hpk] using htraces (k - p) hi hir

theorem newtonCarry_unit_iff_short_conditions (v : Valuation K Γ) (hv : v.Integers R)
    (p r : ℕ) [CharP (ResidueField R) p] (hp : 0 < p) (hrp : r < p)
    (u : ι → K) (hdegree : Fintype.card ι = 2 * p + r) (hnorm : v (∏ i, u i) = 1)
    (hforward : ∀ k, 0 < k → k < p → finitePowerSum u k ∈ (algebraMap R K).range)
    (hreciprocal : ∀ k, 0 < k → k < p →
      finitePowerSum (fun i => (u i)⁻¹) k ∈ (algebraMap R K).range) :
    Specifications.TupleDescendsAsUnits (R := R) u ↔
      (finiteElementarySymmetric u p ∈ (algebraMap R K).range ∧
        ∀ i, 0 < i → i ≤ r → finitePowerSum u (p + i) ∈ (algebraMap R K).range) :=
  (newtonCarry_unit_iff_conditions v hv p hp u (by omega) hnorm hforward hreciprocal).trans
    (newtonCarry_conditions_twice_characteristic hp hrp u hdegree)

end Litt3.CartierAndSpin
