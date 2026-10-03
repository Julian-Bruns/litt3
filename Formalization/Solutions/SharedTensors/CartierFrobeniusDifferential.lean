import Solutions.SharedTensors.CartierBinomialPrimitive

namespace Litt3.SharedTensors

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]
variable {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The composite of inverse Cartier's universal formula with actual
p-basis extraction; additivity follows from an explicit exact primitive. -/
noncomputable def cartierFrobeniusDifferential
    (b : PowerPBasis K p) (D : Derivation k K K) (a : K) : K :=
  rationalCartierCoefficient K p b (a ^ (p - 1) * D a)

theorem cartierFrobeniusDifferential_add
    (b : PowerPBasis K p) (D : Derivation k K K) (ht : D b.parameter = 1)
    (a c : K) :
    cartierFrobeniusDifferential b D (a + c) =
      cartierFrobeniusDifferential b D a + cartierFrobeniusDifferential b D c := by
  let C := rationalCartierCoefficientAddHom b
  have h := rationalCartierCoefficient_exact b D ht
    (cartierBinomialPrimitive (p := p) a c)
  rw [cartier_binomial_primitive_derivative] at h
  change C (_ - _ - _) = 0 at h
  rw [map_sub, map_sub] at h
  change C ((a + c) ^ (p - 1) * D (a + c)) =
    C (a ^ (p - 1) * D a) + C (c ^ (p - 1) * D c)
  linear_combination h

theorem cartierFrobeniusDifferential_mul
    (b : PowerPBasis K p) (D : Derivation k K K) (a c : K) :
    cartierFrobeniusDifferential b D (a * c) =
      a * cartierFrobeniusDifferential b D c + c * cartierFrobeniusDifferential b D a := by
  have hp : 1 ≤ p := (Fact.out : p.Prime).pos
  have hpow (x : K) : x ^ p = x ^ (p - 1) * x := by
    conv_lhs => rw [← Nat.sub_add_cancel hp]
    rw [pow_succ]
  have hidentity : (a * c) ^ (p - 1) * D (a * c) =
      a ^ p * (c ^ (p - 1) * D c) + c ^ p * (a ^ (p - 1) * D a) := by
    rw [mul_pow, D.leibniz, hpow a, hpow c]
    simp only [smul_eq_mul]
    ring
  rw [cartierFrobeniusDifferential, hidentity, rationalCartierCoefficient_add,
    rationalCartierCoefficient_pth_mul, rationalCartierCoefficient_pth_mul]
  rfl

theorem cartierFrobeniusDifferential_algebraMap
    (b : PowerPBasis K p) (D : Derivation k K K) (c : k) :
    cartierFrobeniusDifferential b D (algebraMap k K c) = 0 := by
  simp [cartierFrobeniusDifferential, D.map_algebraMap,
    rationalCartierCoefficient]

/-- The entire composite is an actual derivation. Its additive law is
proved through the all-characteristic binomial primitive. -/
noncomputable def cartierFrobeniusDerivation
    (b : PowerPBasis K p) (D : Derivation k K K) (ht : D b.parameter = 1) :
    Derivation k K K where
  toLinearMap := {
    toFun := cartierFrobeniusDifferential b D
    map_add' := cartierFrobeniusDifferential_add b D ht
    map_smul' := fun c a => by
      simp only [Algebra.smul_def]
      rw [cartierFrobeniusDifferential_mul,
        cartierFrobeniusDifferential_algebraMap, mul_zero, add_zero]
      rfl }
  map_one_eq_zero' := by simp [cartierFrobeniusDifferential, rationalCartierCoefficient]
  leibniz' := fun a c => by
    exact cartierFrobeniusDifferential_mul b D a c

theorem cartierFrobeniusDerivation_parameter
    (b : PowerPBasis K p) (D : Derivation k K K) (ht : D b.parameter = 1) :
    cartierFrobeniusDerivation b D ht b.parameter = 1 := by
  change rationalCartierCoefficient K p b (b.parameter ^ (p - 1) * D b.parameter) = 1
  rw [ht, mul_one,
    rationalCartierCoefficient_parameter_power b _
      (Nat.sub_lt (Fact.out : p.Prime).pos (by decide)), if_pos rfl]

/-- Normalization and the full actual p-basis force equality with the
original derivation, without a separability or perfectness assumption. -/
theorem cartierFrobeniusDerivation_eq
    (b : PowerPBasis K p) (D : Derivation k K K) (ht : D b.parameter = 1) :
    cartierFrobeniusDerivation b D ht = D := by
  ext a
  rw [derivation_p_basis_expansion b (cartierFrobeniusDerivation b D ht)
    (cartierFrobeniusDerivation_parameter b D ht) a,
    derivation_p_basis_expansion b D ht a]

theorem rationalCartierCoefficient_frobenius_differential
    (b : PowerPBasis K p) (D : Derivation k K K) (ht : D b.parameter = 1) (a : K) :
    rationalCartierCoefficient K p b (a ^ (p - 1) * D a) = D a :=
  DFunLike.congr_fun (cartierFrobeniusDerivation_eq b D ht) a

end Litt3.SharedTensors
