import Solutions.Deformations.ProjectiveFiniteSums
import Solutions.Deformations.ElementaryCoefficientExtraction

namespace Litt3.Deformations

open scoped LinearAlgebra.Projectivization BigOperators

variable {I K : Type*} [Fintype I] [DecidableEq I] [Field K]
variable [Fact (Nat.Prime 5)]

/-- The literal source summand a_i Z(a)/q(a) is independent of its
projective representative when the target has scalar weight one and
the denominator has scalar weight two. -/
theorem projective_ratio_scale_invariant (φ : ZMod 5 →+* K) (i : I)
    (Z q : (I → ZMod 5) → K)
    (targetScale : ∀ (u : (ZMod 5)ˣ) a, Z ((u : ZMod 5) • a) = φ u * Z a)
    (quadScale : ∀ (u : (ZMod 5)ˣ) a, q ((u : ZMod 5) • a) = φ u ^ 2 * q a)
    (u : (ZMod 5)ˣ) (a : I → ZMod 5) :
    φ (((u : ZMod 5) • a) i) * Z ((u : ZMod 5) • a) /
      q ((u : ZMod 5) • a) = φ (a i) * Z a / q a := by
  rw [targetScale, quadScale]
  change φ ((u : ZMod 5) * a i) * (φ u * Z a) / (φ u ^ 2 * q a) = _
  rw [map_mul]
  have nonzero : φ (u : ZMod 5) ≠ 0 := by
    exact (map_ne_zero φ).mpr u.ne_zero
  calc
    _ = (φ u ^ 2 * (φ (a i) * Z a)) / (φ u ^ 2 * q a) := by ring
    _ = _ := mul_div_mul_left _ _ (pow_ne_zero 2 nonzero)

variable [Fintype (ℙ (ZMod 5) (I → ZMod 5))]

/-- The exact projective coefficient-extraction sign for original
elementary-five coordinates. No projective point enumeration is used. -/
theorem elementary_projective_normal_coefficient (φ : ZMod 5 →+* K) (i : I)
    (c : (I → Fin 5) → K)
    (invariant : ∀ (u : (ZMod 5)ˣ) (a : I → ZMod 5),
      φ (((u : ZMod 5) • a) i) *
        (∑ alpha : I → Fin 5, c alpha * (∏ j, φ (((u : ZMod 5) • a) j) ^ (alpha j).val)) =
      φ (a i) * (∑ alpha : I → Fin 5, c alpha * (∏ j, φ (a j) ^ (alpha j).val))) :
    (∑ P : ℙ (ZMod 5) (I → ZMod 5), φ (P.rep i) *
      (∑ alpha : I → Fin 5, c alpha * (∏ j, φ (P.rep j) ^ (alpha j).val))) =
      (-1 : K) ^ (Fintype.card I + 1) *
        c (finiteFieldDetectorExponent (ZMod 5) (by norm_num) i) := by
  classical
  let f : (I → ZMod 5) → K := fun a =>
    φ (a i) * (∑ alpha : I → Fin 5, c alpha * (∏ j, φ (a j) ^ (alpha j).val))
  have zero : f 0 = 0 := by simp [f]
  have sumProjective := finite_projective_sum (ZMod 5) (I → ZMod 5) f zero invariant
  have moment := finite_field_normal_coefficient_extraction (ZMod 5) φ (by norm_num) i c
  have card : Fintype.card (ZMod 5)ˣ = 4 := by
    rw [Fintype.card_units]
    norm_num
  rw [card, nsmul_eq_mul] at sumProjective
  have scalar : (4 : K) = -1 := by
    have image := congrArg φ (show (4 : ZMod 5) = -1 by rfl)
    simpa only [map_ofNat, map_neg, map_one] using image
  have castScalar : ((4 : ℕ) : K) = -1 := by exact_mod_cast scalar
  rw [castScalar] at sumProjective
  have conclusion : -(∑ P : ℙ (ZMod 5) (I → ZMod 5), f P.rep) =
      (-1 : K) ^ Fintype.card I * c (finiteFieldDetectorExponent (ZMod 5) (by norm_num) i) := by
    simpa only [f, neg_one_mul] using sumProjective.symm.trans moment
  have negated := congrArg Neg.neg conclusion
  simpa only [neg_neg, pow_succ, mul_neg_one, neg_mul] using negated

end Litt3.Deformations
