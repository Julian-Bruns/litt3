import Solutions.Deformations.FiniteCyclicCohomology
import Mathlib.Algebra.Ring.GeomSum
import Mathlib.Algebra.Polynomial.Coeff
import Mathlib.Algebra.Polynomial.AlgebraMap
import Mathlib.Algebra.CharP.Lemmas
import Lean.Elab.Tactic.Omega

namespace Litt3.Deformations

open Polynomial

universe u v w

section Polynomial

variable {k : Type u} [CommRing k] (p a : ℕ) [Fact p.Prime] [CharP k p]

/-- The full p-power cyclic norm polynomial is exactly the highest
augmentation power. Cancellation uses the actual regular polynomial X,
so arbitrary coefficient rings and zero divisors are allowed. -/
theorem polynomial_cyclic_norm_power :
    (∑ i ∈ Finset.range (p ^ a), ((X : Polynomial k) + 1) ^ i) = X ^ (p ^ a - 1) := by
  apply (Polynomial.isRegular_X (R := k)).2
  have h := geom_sum_mul_add (X : Polynomial k) (p ^ a)
  rw [add_pow_char_pow, one_pow] at h
  have identity := add_right_cancel h
  calc
    (∑ i ∈ Finset.range (p ^ a), ((X : Polynomial k) + 1) ^ i) * X = X ^ (p ^ a) := identity
    _ = X ^ (p ^ a - 1) * X := by
      rw [← pow_succ]
      congr 1
      have positive := pow_pos (Fact.out : p.Prime).pos a
      omega

/-- Evaluation transports the symbolic norm identity into every
possibly noncommutative algebra over the coefficient ring. -/
theorem algebra_cyclic_norm_power {B : Type v} [Ring B] [Algebra k B] (x : B) :
    (∑ i ∈ Finset.range (p ^ a), (x + 1) ^ i) = x ^ (p ^ a - 1) := by
  have h := congrArg (Polynomial.aeval x) (polynomial_cyclic_norm_power (k := k) p a)
  simpa only [map_sum, map_pow, map_add, map_one, Polynomial.aeval_X] using h

end Polynomial

section Representation

variable {k : Type u} {G : Type v} {V : Type w} [CommRing k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V]

/-- Reindex the complete actual group norm by all powers of its
actual cyclic generator, with no bounded group-element enumeration. -/
theorem cyclic_norm_eq_geometric_sum (ρ : Representation k G V) (g : G)
    (generated : ∀ x : G, x ∈ Subgroup.zpowers g) :
    ρ.norm = ∑ i ∈ Finset.range (orderOf g), (ρ g) ^ i := by
  let e : Fin (orderOf g) ≃ G :=
    (finEquivZPowers (isOfFinOrder_of_finite g)).trans {
      toFun := Subtype.val
      invFun x := ⟨x, generated x⟩
      left_inv _ := rfl
      right_inv _ := rfl }
  have h : (∑ i : Fin (orderOf g), ρ (g ^ i.val)) = ∑ x : G, ρ x :=
    Fintype.sum_equiv e _ _ (fun _ => rfl)
  simpa only [map_pow, Fin.sum_univ_eq_sum_range] using h.symm

/-- For every actual cyclic representation of p-power order, the
actual full norm is the actual generator-difference power. The scalar
ring may have zero divisors and the representation may have any dimension. -/
theorem cyclic_norm_eq_augmentation_power (p a : ℕ) [Fact p.Prime] [CharP k p]
    (ρ : Representation k G V) (g : G)
    (generated : ∀ x : G, x ∈ Subgroup.zpowers g) (order : orderOf g = p ^ a) :
    ρ.norm = (ρ g - 1) ^ (p ^ a - 1) := by
  rw [cyclic_norm_eq_geometric_sum ρ g generated, order]
  simpa only [sub_add_cancel] using algebra_cyclic_norm_power (k := k) p a (ρ g - 1)

end Representation

end Litt3.Deformations
