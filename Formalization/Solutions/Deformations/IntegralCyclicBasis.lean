import Solutions.Deformations.IntegralCyclicGroupAlgebra
import Mathlib.LinearAlgebra.Basis.Basic
import Mathlib.Tactic

namespace Litt3.Deformations

open Polynomial

variable {R : Type*} [CommRing R] [Nontrivial R]

theorem integral_cyclic_relation_degree (q : ℕ) (positive : 0 < q) :
    (integralCyclicRelation (R := R) q).natDegree = q := by
  have degree : ((1 + X : R[X]) ^ q).natDegree = q := by
    rw [add_comm (1 : R[X]) X, ← Polynomial.C_1]
    simpa only [natDegree_X_add_C, Nat.mul_one] using (monic_X_add_C (1 : R)).natDegree_pow q
  rw [integralCyclicRelation, natDegree_sub_eq_left_of_natDegree_lt, degree]
  rw [natDegree_one, degree]
  exact positive

theorem integral_cyclic_relation_monic (q : ℕ) (positive : 0 < q) :
    (integralCyclicRelation (R := R) q).Monic := by
  have monic : ((1 + X : R[X]) ^ q).Monic := by
    rw [add_comm (1 : R[X]) X, ← Polynomial.C_1]
    exact (monic_X_add_C (1 : R)).pow q
  apply monic.sub_of_left
  apply degree_lt_degree
  have degree : ((1 + X : R[X]) ^ q).natDegree = q := by
    rw [add_comm (1 : R[X]) X, ← Polynomial.C_1]
    simpa only [natDegree_X_add_C, Nat.mul_one] using (monic_X_add_C (1 : R)).natDegree_pow q
  rw [natDegree_one, degree]
  exact positive

/-- The actual original augmentation powers are a basis of the actual
cyclic group algebra over every nontrivial commutative coefficient ring. -/
noncomputable def integralCyclicAugmentationBasis (q : ℕ) (positive : 0 < q) :
    Module.Basis (Fin q) R (CyclicGroupAlgebra R q) :=
  ((AdjoinRoot.powerBasis' (integral_cyclic_relation_monic (R := R) q positive)).basis.reindex
    (finCongr (integral_cyclic_relation_degree (R := R) q positive))).map
      (integralCyclicAlgebraEquiv (R := R) q positive).toLinearEquiv

@[simp] theorem integral_cyclic_augmentation_basis_apply (q : ℕ) (positive : 0 < q)
    (i : Fin q) :
    integralCyclicAugmentationBasis (R := R) q positive i =
      ((cyclicGroupGenerator R q : CyclicGroupAlgebra R q) - 1) ^ i.val := by
  simp only [integralCyclicAugmentationBasis, Module.Basis.map_apply, Module.Basis.reindex_apply]
  change integralCyclicPresentation (R := R) q
    ((AdjoinRoot.powerBasis' (integral_cyclic_relation_monic (R := R) q positive)).basis
      ((finCongr (integral_cyclic_relation_degree (R := R) q positive)).symm i)) = _
  rw [(AdjoinRoot.powerBasis' (integral_cyclic_relation_monic (R := R) q positive)).basis_eq_pow,
    map_pow]
  change integralCyclicPresentation (R := R) q (integralCyclicParameter (R := R) q) ^ i.val = _
  rw [integral_cyclic_presentation_parameter]

/-- The genuine mixed-characteristic five-cycle augmentation relation.
Its two least-weight terms are e^5 and 5e when wt(5)=4. -/
theorem original_five_cycle_relation :
    let e : CyclicGroupAlgebra R 5 := (cyclicGroupGenerator R 5 : CyclicGroupAlgebra R 5) - 1
    e ^ 5 = -(5 : CyclicGroupAlgebra R 5) * (e + 2 * e ^ 2 + 2 * e ^ 3 + e ^ 4) := by
  dsimp only
  have order := cyclic_group_generator_power (R := R) 5
  linear_combination order

end Litt3.Deformations
