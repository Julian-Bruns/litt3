import Solutions.Deformations.BalancedNodeBasis
import Solutions.Deformations.BalancedNodeIndexEquivalence
import Mathlib.LinearAlgebra.FreeModule.StrongRankCondition
import Mathlib.LinearAlgebra.Dimension.Free

namespace Litt3.Deformations

variable (R : Type*) [CommRing R]

/-- The actual node quotient has the constant and its two unchanged
nonzero axis strings as a constructed finite coefficient-ring basis. -/
noncomputable def balancedNodeAxisBasis (Q : ℕ) (positive : 0 < Q) :
    Module.Basis (Option (Fin (Q - 1) ⊕ Fin (Q - 1))) R (BalancedNodeAlgebra R Q) :=
  (balancedNodeBasis R Q).reindex (balancedNodeIndexEquiv Q positive).symm

variable [Nontrivial R]

/-- Exact balanced node length from the genuine original quotient
basis, over every nontrivial commutative coefficient ring. -/
theorem balanced_node_finrank (Q : ℕ) (positive : 0 < Q) :
    Module.finrank R (BalancedNodeAlgebra R Q) = 2 * Q - 1 := by
  classical
  rw [Module.finrank_eq_card_basis (balancedNodeAxisBasis R Q positive)]
  simp only [Fintype.card_option, Fintype.card_sum, Fintype.card_fin]
  omega

/-- The literal three-generator original polynomial quotient retains
the source's balanced length, without assuming any basis or length input. -/
theorem balanced_node_original_quotient_finrank (Q : ℕ) (positive : 0 < Q) :
    Module.finrank R ((MvPolynomial (Fin 2) R) ⧸
      Ideal.span ({(MvPolynomial.X 0 : MvPolynomial (Fin 2) R) ^ Q,
        MvPolynomial.X 1 ^ Q, MvPolynomial.X 0 * MvPolynomial.X 1} :
          Set (MvPolynomial (Fin 2) R))) = 2 * Q - 1 := by
  have equivalence := Ideal.quotientEquivAlgOfEq R (balanced_node_ideal_original_generators R Q)
  rw [← equivalence.toLinearEquiv.finrank_eq]
  exact balanced_node_finrank R Q positive

end Litt3.Deformations
