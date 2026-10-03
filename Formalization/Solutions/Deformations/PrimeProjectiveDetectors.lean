import Solutions.Deformations.ProjectiveFiniteSums
import Solutions.Deformations.PrimeCoefficientExtraction

namespace Litt3.Deformations

open scoped LinearAlgebra.Projectivization BigOperators

variable (p : ℕ) [Fact p.Prime]
variable {I K : Type*} [Fintype I] [DecidableEq I] [Field K] [CharP K p]

theorem prime_projective_ratio_scale_invariant (a : ℕ) (positive : 0 < a)
    (φ : ZMod p →+* K) (i : I) (Z q : (I → ZMod p) → K)
    (targetScale : ∀ (u : (ZMod p)ˣ) v,
      Z ((u : ZMod p) • v) = φ u ^ (a - 1) * Z v)
    (principalScale : ∀ (u : (ZMod p)ˣ) v,
      q ((u : ZMod p) • v) = φ u ^ a * q v)
    (u : (ZMod p)ˣ) (v : I → ZMod p) :
    φ (((u : ZMod p) • v) i) * Z ((u : ZMod p) • v) /
      q ((u : ZMod p) • v) = φ (v i) * Z v / q v := by
  rw [targetScale, principalScale]
  change φ ((u : ZMod p) * v i) * (φ u ^ (a - 1) * Z v) /
    (φ u ^ a * q v) = _
  rw [map_mul]
  have nonzero : φ (u : ZMod p) ≠ 0 := (map_ne_zero φ).mpr u.ne_zero
  have power : φ u * φ u ^ (a - 1) = φ u ^ a := by
    rw [← pow_succ', Nat.sub_add_cancel positive]
  calc
    _ = (φ u ^ a * (φ (v i) * Z v)) / (φ u ^ a * q v) := by
      congr 1
      calc
        _ = (φ u * φ u ^ (a - 1)) * (φ (v i) * Z v) := by ring
        _ = _ := by rw [power]
    _ = _ := mul_div_mul_left _ _ (pow_ne_zero a nonzero)

variable [Fintype (ℙ (ZMod p) (I → ZMod p))]

/-- The exact projective extraction sign, uniformly in the original prime,
using actual projective lines and full finite-field moments. -/
theorem prime_projective_normal_coefficient (large : 2 < p) (φ : ZMod p →+* K) (i : I)
    (c : (I → Fin p) → K)
    (invariant : ∀ (u : (ZMod p)ˣ) (v : I → ZMod p),
      φ (((u : ZMod p) • v) i) *
        (∑ alpha : I → Fin p, c alpha * ∏ j, φ (((u : ZMod p) • v) j) ^ (alpha j).val) =
      φ (v i) * (∑ alpha : I → Fin p, c alpha * ∏ j, φ (v j) ^ (alpha j).val)) :
    (∑ P : ℙ (ZMod p) (I → ZMod p), φ (P.rep i) *
      (∑ alpha : I → Fin p, c alpha * ∏ j, φ (P.rep j) ^ (alpha j).val)) =
      (-1 : K) ^ (Fintype.card I + 1) * c (primeDetectorExponent p large i) := by
  classical
  let f : (I → ZMod p) → K := fun v =>
    φ (v i) * (∑ alpha : I → Fin p, c alpha * ∏ j, φ (v j) ^ (alpha j).val)
  have zero : f 0 = 0 := by simp [f]
  have sumProjective := finite_projective_sum (ZMod p) (I → ZMod p) f zero invariant
  have moment := prime_normal_coefficient_extraction p large φ i c
  have card : Fintype.card (ZMod p)ˣ = p - 1 := ZMod.card_units p
  rw [card, nsmul_eq_mul] at sumProjective
  have scalar : ((p - 1 : ℕ) : K) = -1 := by
    rw [Nat.cast_sub (Fact.out : p.Prime).one_le, CharP.cast_eq_zero K p, Nat.cast_one, zero_sub]
  rw [scalar] at sumProjective
  have conclusion : -(∑ P : ℙ (ZMod p) (I → ZMod p), f P.rep) =
      (-1 : K) ^ Fintype.card I * c (primeDetectorExponent p large i) := by
    simpa only [f, neg_one_mul] using sumProjective.symm.trans moment
  have negated := congrArg Neg.neg conclusion
  simpa only [neg_neg, pow_succ, mul_neg_one, neg_mul] using negated

end Litt3.Deformations
