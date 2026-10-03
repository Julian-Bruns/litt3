import Solutions.Deformations.ElementaryCriticalQuotientCharacter
import Mathlib.LinearAlgebra.Projectivization.Basic

namespace Litt3.Deformations

open scoped LinearAlgebra.Projectivization WeightedRootPolynomialScalars

variable (k : Type*) [Field k] [Fact (Nat.Prime 5)]

/-- Every actual homogeneous critical target gives exactly the same
original projective summand for any two representatives of its line. -/
theorem elementary_actual_critical_representative (r : ℕ)
    (ψ : ZMod 5 →+* k) (q : MvPolynomial (Fin r) k) (quadratic : q.IsHomogeneous 2)
    (Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k 5 (by omega) r (4 * r + 1))
    (i : Fin r) (a b : Fin r → ZMod 5) (ha : a ≠ 0) (hb : b ≠ 0)
    (same : Projectivization.mk (ZMod 5) a ha = Projectivization.mk (ZMod 5) b hb) :
    ψ (a i) * weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r Z a /
        q.eval (fun j => ψ (a j)) =
      ψ (b i) * weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r Z b /
        q.eval (fun j => ψ (b j)) := by
  obtain ⟨u, relation⟩ := (Projectivization.mk_eq_mk_iff (ZMod 5) a b ha hb).mp same
  change (u : ZMod 5) • b = a at relation
  rw [← relation]
  have coordinate : ψ (((u : ZMod 5) • b) i) = ψ u * ψ (b i) := by
    simp only [Pi.smul_apply, smul_eq_mul, map_mul]
  have ratio := elementary_actual_critical_ratio_character k ψ r q quadratic Z homogeneous u b
  have fourth : ψ (u : ZMod 5) ^ 4 = 1 := by
    simpa only [map_pow, map_one] using congrArg ψ (ZMod.pow_card_sub_one_eq_one u.ne_zero)
  rw [mul_div_assoc, mul_div_assoc, coordinate, ratio]
  calc
    _ = ψ (u : ZMod 5) ^ 4 *
        (ψ (b i) * (weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r Z b /
          q.eval (fun j => ψ (b j)))) := by ring
    _ = _ := by rw [fourth, one_mul]

end Litt3.Deformations
