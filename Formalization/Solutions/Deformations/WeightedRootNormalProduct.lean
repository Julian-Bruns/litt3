import Solutions.Deformations.WeightedRootProductRelations

namespace Litt3.Deformations

open scoped BigOperators

def rootNormalCarry (q : ℕ) (a b : Fin q) : ℕ :=
  if a.val + b.val < q then 0 else 1

def rootNormalProductExponent (q : ℕ) (large : 1 < q) (a b : Fin q) : Fin q :=
  if small : a.val + b.val < q then ⟨a.val + b.val, small⟩
  else ⟨a.val + b.val - (q - 1), by omega⟩

theorem root_normal_weight_addition (q : ℕ) (large : 1 < q) (a b : Fin q) :
    (q - 1) * rootNormalCarry q a b + (rootNormalProductExponent q large a b).val =
      a.val + b.val := by
  unfold rootNormalCarry rootNormalProductExponent
  split_ifs <;> simp only [Fin.val_mk] <;> omega

/-- The single original-coordinate reduction, with its exact scalar
carry, over any commutative ring. -/
theorem root_normal_power_product {A : Type*} [CommRing A] (q : ℕ) (large : 1 < q)
    (tau e : A) (relation : e ^ q = -tau * e) (a b : Fin q) :
    e ^ a.val * e ^ b.val =
      (-tau) ^ rootNormalCarry q a b * e ^ (rootNormalProductExponent q large a b).val := by
  rw [← pow_add]
  unfold rootNormalCarry rootNormalProductExponent
  split_ifs with small
  · simp
  · have split : a.val + b.val = q + (a.val + b.val - q) := by omega
    have rest : a.val + b.val - (q - 1) = 1 + (a.val + b.val - q) := by omega
    change e ^ (a.val + b.val) = (-tau) ^ 1 * e ^ (a.val + b.val - (q - 1))
    conv_lhs => rw [split, pow_add, relation]
    rw [pow_one, rest, pow_add, pow_one]
    ring

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Multiplication of two actual original normal basis vectors has a
single actual normal term and its explicitly proved parameter carry. -/
theorem weighted_root_normal_basis_product (q : ℕ) (large : 1 < q) (tau : R) (r : ℕ)
    (alpha beta : Fin r → Fin q) :
    weightedRootProductBasis q large tau r alpha * weightedRootProductBasis q large tau r beta =
      (-tau) ^ (∑ i, rootNormalCarry q (alpha i) (beta i)) •
        weightedRootProductBasis q large tau r
          (fun i => rootNormalProductExponent q large (alpha i) (beta i)) := by
  rw [weighted_root_product_basis_apply, weighted_root_product_basis_apply,
    weighted_root_product_basis_apply, ← Finset.prod_mul_distrib]
  simp_rw [root_normal_power_product q large _ _
    (weighted_root_product_coordinate_relation q tau r _)]
  rw [Finset.prod_mul_distrib, Finset.prod_pow_eq_pow_sum, Algebra.smul_def]
  rw [map_pow, map_neg]

theorem weighted_root_normal_product_weight (q : ℕ) (large : 1 < q) (r : ℕ)
    (alpha beta : Fin r → Fin q) :
    (q - 1) * (∑ i, rootNormalCarry q (alpha i) (beta i)) +
        (∑ i, (rootNormalProductExponent q large (alpha i) (beta i)).val) =
      (∑ i, (alpha i).val) + ∑ i, (beta i).val := by
  rw [Finset.mul_sum, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i _
  exact root_normal_weight_addition q large (alpha i) (beta i)

end Litt3.Deformations
