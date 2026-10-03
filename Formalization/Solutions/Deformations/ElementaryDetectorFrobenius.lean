import Solutions.Deformations.ElementaryProjectiveDetectors
import Mathlib.FieldTheory.Perfect

namespace Litt3.Deformations

open scoped LinearAlgebra.Projectivization BigOperators

variable {I K : Type*} [Fintype I] [DecidableEq I] [Field K] [Fact (Nat.Prime 5)]

/-- Literal projective-line equality gives equality of the original
summands, retaining the original coordinates. -/
theorem original_projective_ratio_representative_independent (φ : ZMod 5 →+* K) (i : I)
    (Z q : (I → ZMod 5) → K)
    (targetScale : ∀ (u : (ZMod 5)ˣ) a, Z ((u : ZMod 5) • a) = φ u * Z a)
    (quadScale : ∀ (u : (ZMod 5)ˣ) a, q ((u : ZMod 5) • a) = φ u ^ 2 * q a)
    (a b : I → ZMod 5) (ha : a ≠ 0) (hb : b ≠ 0)
    (same : Projectivization.mk (ZMod 5) a ha = Projectivization.mk (ZMod 5) b hb) :
    φ (a i) * Z a / q a = φ (b i) * Z b / q b := by
  obtain ⟨u, relation⟩ := (Projectivization.mk_eq_mk_iff (ZMod 5) a b ha hb).mp same
  change (u : ZMod 5) • b = a at relation
  rw [← relation]
  exact projective_ratio_scale_invariant φ i Z q targetScale quadScale u b

variable [Fintype (ℙ (ZMod 5) (I → ZMod 5))] [CharP K 5] [PerfectRing K 5]

/-- Inverse actual coefficient Frobenius is applied after the full
projective sum, and the exact source sign recovers the distinguished
original normal coefficient. -/
theorem elementary_projective_detector_frobenius (φ : ZMod 5 →+* K) (i : I)
    (c : (I → Fin 5) → K)
    (invariant : ∀ (u : (ZMod 5)ˣ) (a : I → ZMod 5),
      φ (((u : ZMod 5) • a) i) *
        (∑ alpha : I → Fin 5, c alpha * (∏ j, φ (((u : ZMod 5) • a) j) ^ (alpha j).val)) =
      φ (a i) * (∑ alpha : I → Fin 5, c alpha * (∏ j, φ (a j) ^ (alpha j).val))) :
    (_root_.frobeniusEquiv K 5).symm
      ((-1 : K) ^ (Fintype.card I + 1) *
        ∑ P : ℙ (ZMod 5) (I → ZMod 5), φ (P.rep i) *
          (∑ alpha : I → Fin 5, c alpha * (∏ j, φ (P.rep j) ^ (alpha j).val))) =
      (_root_.frobeniusEquiv K 5).symm
        (c (finiteFieldDetectorExponent (ZMod 5) (by norm_num) i)) := by
  rw [elementary_projective_normal_coefficient φ i c invariant]
  have sign : (-1 : K) ^ (Fintype.card I + 1) *
      (-1 : K) ^ (Fintype.card I + 1) = 1 := by
    rw [← pow_add]
    have exponent : Fintype.card I + 1 + (Fintype.card I + 1) = 2 * (Fintype.card I + 1) := by omega
    rw [exponent, pow_mul]
    norm_num
  rw [← mul_assoc, sign, one_mul]

end Litt3.Deformations
