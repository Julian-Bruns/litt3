import Definitions.CartierAndSpin.WeightedMoments
import Definitions.CartierAndSpin.DifferentialEnergy
import Definitions.CartierAndSpin.ClearedEnergy
import Mathlib.Algebra.Polynomial.Eval.Defs
import Mathlib.Algebra.Ring.Subring.Basic
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K]

theorem polynomial_eval_mem_subring (S : Subring K) (P : K[X]) (x : K)
    (hP : ∀ j, P.coeff j ∈ S) (hx : x ∈ S) : P.eval x ∈ S := by
  rw [Polynomial.eval_eq_sum, Polynomial.sum]
  exact S.sum_mem fun j _ => S.mul_mem (hP j) (S.pow_mem hx j)

/-- The actual source equation supplies the integral denominator inverse
from tau's inverse and the polynomial coefficients, without a discriminant. -/
theorem source_factor_inverse_mem_subring (S : Subring K)
    (F H : K[X]) (p : ℕ) (q tau w : K)
    (hsource : F = (X ^ p + C q) * H + C tau) (hwroot : F.eval w = 0)
    (htau : tau ≠ 0) (htauInv : tau⁻¹ ∈ S)
    (hH : ∀ j, H.coeff j ∈ S) (hw : w ∈ S) :
    (w ^ p + q)⁻¹ ∈ S := by
  have hroot : (w ^ p + q) * H.eval w + tau = 0 := by
    simpa only [hsource, eval_add, eval_mul, eval_pow, eval_X, eval_C] using hwroot
  have hphi : w ^ p + q ≠ 0 := by
    intro hz
    rw [hz, zero_mul, zero_add] at hroot
    exact htau hroot
  have hinv : (w ^ p + q)⁻¹ = -(H.eval w) * tau⁻¹ := by
    field_simp
    linear_combination hroot
  rw [hinv]
  exact S.mul_mem (S.neg_mem (polynomial_eval_mem_subring S H w hH hw)) htauInv

theorem weighted_moment_mem_subring (S : Subring K) (s : Finset ι) (weight value : ι → K)
    (hweight : ∀ i ∈ s, weight i ∈ S) (hvalue : ∀ i ∈ s, value i ∈ S) (n : ℕ) :
    weightedMoment s weight value n ∈ S := by
  exact S.sum_mem fun i hi => S.mul_mem (hweight i hi) (S.pow_mem (hvalue i hi) n)

theorem split_derivative_energy_mem_subring (S : Subring K) (D : Derivation R K K)
    (s : Finset ι) (node phi : ι → K)
    (hD : ∀ x ∈ S, D x ∈ S) (hnode : ∀ i ∈ s, node i ∈ S)
    (hphi : ∀ i ∈ s, (phi i)⁻¹ ∈ S) : splitDifferentialEnergy D s node phi ∈ S := by
  unfold splitDifferentialEnergy
  exact S.sum_mem fun i hi => by
    rw [div_eq_mul_inv]
    exact S.mul_mem (S.pow_mem (hD _ (hnode i hi)) 2) (hphi i hi)

theorem cleared_energy_mem_subring (S : Subring K) (D : Derivation R K K)
    (energy q tau s c : K) (hD : ∀ x ∈ S, D x ∈ S)
    (henergy : energy ∈ S) (hq : q ∈ S) (htauInv : tau⁻¹ ∈ S)
    (hs : s ∈ S) (hc : c ∈ S) : clearedDifferentialExpression D energy q tau s c ∈ S := by
  unfold clearedDifferentialExpression
  rw [div_eq_mul_inv]
  exact S.sub_mem (S.mul_mem hs henergy)
    (S.mul_mem (S.mul_mem (S.mul_mem (by simpa only [one_add_one_eq_two] using S.add_mem S.one_mem S.one_mem) (hD _ hq)) htauInv)
      (S.sub_mem (S.mul_mem hs (hD _ hc)) (S.mul_mem hc (hD _ hs))))

theorem affine_energy_mem_subring (S : Subring K) (D : Derivation R K K)
    (energy q tau c : K) (hD : ∀ x ∈ S, D x ∈ S)
    (henergy : energy ∈ S) (hq : q ∈ S) (htauInv : tau⁻¹ ∈ S) (hc : c ∈ S) :
    energy - D q * D c / tau ∈ S := by
  rw [div_eq_mul_inv]
  exact S.sub_mem henergy (S.mul_mem (S.mul_mem (hD _ hq) (hD _ hc)) htauInv)

end Litt3.CartierAndSpin
