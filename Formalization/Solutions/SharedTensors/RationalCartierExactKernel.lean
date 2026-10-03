import Solutions.SharedTensors.RationalCartierConstruction

namespace Litt3.SharedTensors

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]
variable {p : ℕ} [Fact p.Prime] [CharP K p]

/-- A zero Cartier coefficient has an actual primitive in the entire
field, obtained by integrating every surviving p-basis digit. -/
theorem rationalCartierCoefficient_zero_has_primitive
    (b : PowerPBasis K p) (D : Derivation k K K)
    (ht : D b.parameter = 1) (a : K)
    (hC : rationalCartierCoefficient K p b a = 0) :
    ∃ f : K, D f = a := by
  let f : K := ∑ i : Fin p,
    pRootCoefficient K p b a i ^ p * ((i.val + 1 : ℕ) : K)⁻¹ *
      b.parameter ^ (i.val + 1)
  refine ⟨f, ?_⟩
  change D (∑ i : Fin p, _) = a
  rw [map_sum]
  calc
    _ = ∑ i : Fin p, pRootCoefficient K p b a i ^ p * b.parameter ^ i.val := by
      apply Finset.sum_congr rfl
      intro i _
      by_cases hi : i.val = p - 1
      · have hc : pRootCoefficient K p b a i = 0 := by
          have heq : i = ⟨p - 1, Nat.sub_lt (Fact.out : p.Prime).pos (by decide)⟩ :=
            Fin.ext hi
          simpa only [heq, rationalCartierCoefficient] using hC
        simp [hc, (Fact.out : p.Prime).ne_zero]
      · have hlt : i.val + 1 < p := by omega
        have hcast : ((i.val + 1 : ℕ) : K) ≠ 0 :=
          (CharP.cast_eq_zero_iff K p (i.val + 1)).not.mpr
            (Nat.not_dvd_of_pos_of_lt (by omega) hlt)
        simp only [D.leibniz, D.leibniz_pow, D.leibniz_inv,
          D.map_natCast, ht, nsmul_eq_mul, smul_eq_mul,
          CharP.cast_eq_zero K p, zero_mul, mul_zero, add_zero,
          Nat.add_sub_cancel, mul_one]
        field_simp
    _ = a := p_basis_actual_expansion b a

/-- The kernel of the actual constructed differential map is exactly
the actual exact differentials, with no polynomial-degree truncation. -/
theorem constructedRationalCartier_zero_iff_exact
    (b : PowerPBasis K p) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hnormalized : e (KaehlerDifferential.D k K b.parameter) = 1)
    (omega : KaehlerDifferential k K) :
    constructedRationalCartier b e omega = 0 ↔
      ∃ f : K, KaehlerDifferential.D k K f = omega := by
  constructor
  · intro hzero
    have hC : rationalCartierCoefficient K p b (e omega) = 0 := by
      rw [← constructedRationalCartier_coordinate, hzero, map_zero]
    obtain ⟨f, hf⟩ := rationalCartierCoefficient_zero_has_primitive b
      (universalCoordinateDerivation e) hnormalized (e omega) hC
    refine ⟨f, e.injective hf⟩
  · rintro ⟨f, rfl⟩
    exact constructedRationalCartier_kills_exact b e hnormalized f

end Litt3.SharedTensors
