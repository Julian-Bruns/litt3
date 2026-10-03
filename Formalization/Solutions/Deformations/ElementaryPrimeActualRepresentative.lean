import Solutions.Deformations.ElementaryPrimeHomogeneousRatio
import Mathlib.LinearAlgebra.Projectivization.Basic

namespace Litt3.Deformations

open scoped LinearAlgebra.Projectivization WeightedRootPolynomialScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k]

/-- The literal critical summand is independent of the representative
of every original prime-field projective line, for every principal degree. -/
theorem elementary_prime_actual_critical_representative (r a : ℕ) (positive : 0 < r)
    (psi : ZMod p →+* k) (q : MvPolynomial (Fin r) k) (principal : q.IsHomogeneous a)
    (Z : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k p
      (Fact.out : p.Prime).one_lt r ((p - 1) * r + a - 1))
    (i : Fin r) (v w : Fin r → ZMod p) (hv : v ≠ 0) (hw : w ≠ 0)
    (same : Projectivization.mk (ZMod p) v hv = Projectivization.mk (ZMod p) w hw) :
    psi (v i) * primeWeightedPolynomialFunction p k psi r Z v /
        q.eval (fun j => psi (v j)) =
      psi (w i) * primeWeightedPolynomialFunction p k psi r Z w /
        q.eval (fun j => psi (w j)) := by
  obtain ⟨u, relation⟩ := (Projectivization.mk_eq_mk_iff (ZMod p) v w hv hw).mp same
  change (u : ZMod p) • w = v at relation
  rw [← relation]
  have coordinate : psi (((u : ZMod p) • w) i) = psi u * psi (w i) := by
    simp only [Pi.smul_apply, smul_eq_mul, map_mul]
  have first : 1 ≤ (p - 1) * r := Nat.mul_pos (by have := (Fact.out : p.Prime).two_le; omega) positive
  have ratio := elementary_prime_homogeneous_ratio_character p k psi r
    ((p - 1) * r + a - 1) a (by omega) q principal Z homogeneous u w
  have order : psi (u : ZMod p) ^ (p - 1) = 1 := by
    simpa only [map_pow, map_one] using congrArg psi (ZMod.pow_card_sub_one_eq_one u.ne_zero)
  have exponent : ((p - 1) * r + a - 1 - a) + 1 = (p - 1) * r := by omega
  rw [mul_div_assoc, mul_div_assoc, coordinate, ratio]
  calc
    _ = psi (u : ZMod p) ^ (((p - 1) * r + a - 1 - a) + 1) *
        (psi (w i) * (primeWeightedPolynomialFunction p k psi r Z w /
          q.eval (fun j => psi (w j)))) := by rw [pow_succ]; ring
    _ = _ := by rw [exponent, pow_mul, order, one_pow, one_mul]

end Litt3.Deformations
