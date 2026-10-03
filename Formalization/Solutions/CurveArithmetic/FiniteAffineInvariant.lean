import Theorems.CurveArithmetic.FiniteAffineInvariant
import Mathlib.Algebra.Polynomial.Splits
import Mathlib.Tactic

namespace Litt3.CurveArithmetic

theorem finite_field_power_fixed_iff_in_base
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L] (x : L) :
    x ^ Fintype.card K = x ↔ x ∈ Set.range (algebraMap K L) := by
  constructor
  · intro hpower
    have hsplits : (Polynomial.X ^ Fintype.card K - Polynomial.X : Polynomial K).Splits := by
      rw [Polynomial.splits_iff_card_roots, FiniteField.roots_X_pow_card_sub_X,
        ← Finset.card_def, Finset.card_univ,
        FiniteField.X_pow_card_sub_X_natDegree_eq K Fintype.one_lt_card]
    apply hsplits.mem_range_of_isRoot
      (FiniteField.X_pow_card_sub_X_ne_zero K Fintype.one_lt_card)
    simpa [Polynomial.IsRoot, Polynomial.eval_map, hpower] using sub_self x
  · rintro ⟨c, rfl⟩
    rw [← map_pow, FiniteField.pow_card]

theorem finite_field_root_unity_in_base
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (x : L) (hpower : x ^ (Fintype.card K - 1) = 1) :
    x ∈ Set.range (algebraMap K L) := by
  apply (finite_field_power_fixed_iff_in_base x).mp
  rw [← Nat.sub_add_cancel Fintype.one_lt_card.le, pow_add, hpower, pow_one, one_mul]

theorem finite_affine_invariant_transform
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (u : Kˣ) (v : K) (a : L) :
    finiteAffineInvariant K (finiteAffineTransform u v a) = finiteAffineInvariant K a := by
  let frob := FiniteField.frobeniusAlgHom K L
  have hdelta : (finiteAffineTransform u v a) ^ Fintype.card K - finiteAffineTransform u v a =
      algebraMap K L u.val * (a ^ Fintype.card K - a) := by
    change frob (algebraMap K L u.val * a + algebraMap K L v) -
      (algebraMap K L u.val * a + algebraMap K L v) = _
    rw [map_add, map_mul, frob.commutes, frob.commutes]
    change _ * a ^ Fintype.card K + _ - (_ * a + _) = _
    ring
  unfold finiteAffineInvariant
  rw [hdelta, mul_pow, ← map_pow,
    FiniteField.pow_card_sub_one_eq_one u.val u.ne_zero, map_one, one_mul]

theorem finite_affine_invariant_complete
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (a b : L) (ha : a ∉ Set.range (algebraMap K L))
    (hb : b ∉ Set.range (algebraMap K L)) :
    finiteAffineInvariant K a = finiteAffineInvariant K b ↔
      ∃ (u : Kˣ) (v : K), b = finiteAffineTransform u v a := by
  constructor
  · intro hequal
    have haDelta : a ^ Fintype.card K - a ≠ 0 := by
      intro h
      exact ha ((finite_field_power_fixed_iff_in_base a).mp (sub_eq_zero.mp h))
    have hbDelta : b ^ Fintype.card K - b ≠ 0 := by
      intro h
      exact hb ((finite_field_power_fixed_iff_in_base b).mp (sub_eq_zero.mp h))
    let ratio := (b ^ Fintype.card K - b) / (a ^ Fintype.card K - a)
    have hratioNonzero : ratio ≠ 0 := div_ne_zero hbDelta haDelta
    have hratioPower : ratio ^ (Fintype.card K - 1) = 1 := by
      change ((b ^ Fintype.card K - b) / (a ^ Fintype.card K - a)) ^
        (Fintype.card K - 1) = 1
      rw [div_pow]
      change (a ^ Fintype.card K - a) ^ (Fintype.card K - 1) =
        (b ^ Fintype.card K - b) ^ (Fintype.card K - 1) at hequal
      rw [← hequal]
      exact div_self (pow_ne_zero _ haDelta)
    obtain ⟨u, hu⟩ := finite_field_root_unity_in_base ratio hratioPower
    have huNonzero : u ≠ 0 := by
      intro hzero
      apply hratioNonzero
      rw [← hu, hzero, map_zero]
    have hdelta : b ^ Fintype.card K - b = ratio * (a ^ Fintype.card K - a) := by
      exact (div_eq_iff haDelta).mp rfl
    have hshift : (b - ratio * a) ^ Fintype.card K = b - ratio * a := by
      let frob := FiniteField.frobeniusAlgHom K L
      change frob (b - ratio * a) = b - ratio * a
      rw [map_sub, map_mul, ← hu, frob.commutes]
      change b ^ Fintype.card K - algebraMap K L u * a ^ Fintype.card K = _
      rw [hu]
      linear_combination hdelta
    obtain ⟨v, hv⟩ := (finite_field_power_fixed_iff_in_base (b - ratio * a)).mp hshift
    refine ⟨Units.mk0 u huNonzero, v, ?_⟩
    change b = algebraMap K L u * a + algebraMap K L v
    rw [hu, hv]
    ring
  · rintro ⟨u, v, rfl⟩
    exact (finite_affine_invariant_transform u v a).symm

theorem finite_affine_invariant_complete_target : Targets.FiniteAffineInvariantComplete := by
  intro K L instK instFintype instL instAlgebra a b ha hb
  exact finite_affine_invariant_complete a b ha hb

/-- Every non-base parameter has a free affine orbit; two pairs of
coefficients giving its image must be identical. -/
theorem finite_affine_parameter_injective
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (a : L) (ha : a ∉ Set.range (algebraMap K L)) :
    Function.Injective (fun coefficients : Kˣ × K =>
      finiteAffineTransform coefficients.1 coefficients.2 a) := by
  rintro ⟨u, v⟩ ⟨s, w⟩ hequal
  change algebraMap K L u.val * a + algebraMap K L v =
    algebraMap K L s.val * a + algebraMap K L w at hequal
  have hlinear : algebraMap K L (u.val - s.val) * a = algebraMap K L (w - v) := by
    simp only [map_sub]
    linear_combination hequal
  have hus : u = s := by
    by_contra hne
    have hdenominator : algebraMap K L (u.val - s.val) ≠ 0 := by
      apply (map_ne_zero (algebraMap K L)).mpr
      exact sub_ne_zero.mpr (fun h => hne (Units.ext h))
    have hparameter : a = algebraMap K L ((w - v) / (u.val - s.val)) := by
      rw [map_div₀]
      apply (eq_div_iff hdenominator).mpr
      exact mul_comm _ _ |>.trans hlinear
    exact ha ⟨_, hparameter.symm⟩
  have hvw : v = w := by
    apply (algebraMap K L).injective
    rw [hus] at hequal
    exact add_left_cancel hequal
  exact Prod.ext hus hvw

/-- Equality of invariants identifies the full fiber with the affine
coefficient pairs. Finite-field cardinalities follow from this actual
equivalence, with no enumeration of the ambient extension. -/
noncomputable def finiteAffineInvariantFiberEquiv
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (a : L) (ha : a ∉ Set.range (algebraMap K L)) :
    (Kˣ × K) ≃ {b : L // finiteAffineInvariant K b = finiteAffineInvariant K a} := by
  let affine : (Kˣ × K) → {b : L // finiteAffineInvariant K b = finiteAffineInvariant K a} :=
    fun coefficients => ⟨finiteAffineTransform coefficients.1 coefficients.2 a,
      finite_affine_invariant_transform _ _ _⟩
  apply Equiv.ofBijective affine
  constructor
  · intro coefficients coefficients' h
    exact finite_affine_parameter_injective a ha (congrArg Subtype.val h)
  · intro b
    have haDelta : a ^ Fintype.card K - a ≠ 0 := by
      intro h
      exact ha ((finite_field_power_fixed_iff_in_base a).mp (sub_eq_zero.mp h))
    have haInvariant : finiteAffineInvariant K a ≠ 0 := pow_ne_zero _ haDelta
    have hb : b.val ∉ Set.range (algebraMap K L) := by
      rintro ⟨c, hc⟩
      have hbInvariant : finiteAffineInvariant K b.val = 0 := by
        rw [← hc]
        simp only [finiteAffineInvariant, ← map_pow, FiniteField.pow_card, sub_self]
        exact zero_pow (Nat.sub_ne_zero_of_lt Fintype.one_lt_card)
      exact haInvariant (b.property.symm.trans hbInvariant)
    obtain ⟨u, v, huv⟩ := (finite_affine_invariant_complete a b.val ha hb).mp b.property.symm
    exact ⟨(u, v), Subtype.ext huv.symm⟩

theorem finite_affine_invariant_fiber_card
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (a : L) (ha : a ∉ Set.range (algebraMap K L)) :
    Nat.card {b : L // finiteAffineInvariant K b = finiteAffineInvariant K a} =
      Fintype.card K * (Fintype.card K - 1) := by
  classical
  rw [← Nat.card_congr (finiteAffineInvariantFiberEquiv a ha), Nat.card_prod,
    Nat.card_eq_fintype_card, Nat.card_eq_fintype_card, Fintype.card_units, Nat.mul_comm]

end Litt3.CurveArithmetic
