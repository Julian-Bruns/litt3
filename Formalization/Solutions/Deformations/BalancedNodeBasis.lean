import Definitions.Deformations.BalancedNodeAlgebra
import Solutions.Deformations.BasisQuotientComplement
import Mathlib.Data.Finsupp.Order
import Mathlib.Tactic

namespace Litt3.Deformations

variable (R : Type*) [CommRing R]

theorem balanced_node_ideal_original_generators (Q : ℕ) :
    balancedNodeIdeal R Q = Ideal.span ({(MvPolynomial.X 0 : MvPolynomial (Fin 2) R) ^ Q,
      MvPolynomial.X 1 ^ Q, MvPolynomial.X 0 * MvPolynomial.X 1} :
        Set (MvPolynomial (Fin 2) R)) := by
  classical
  simp only [MvPolynomial.X_pow_eq_monomial]
  simp only [balancedNodeIdeal, Set.image_insert_eq, Set.image_singleton,
    MvPolynomial.X, MvPolynomial.monomial_mul, one_mul]

/-- Exact membership in the original balanced node relation ideal. -/
theorem balanced_node_ideal_membership (Q : ℕ) (f : MvPolynomial (Fin 2) R) :
    f ∈ balancedNodeIdeal R Q ↔ ∀ a ∈ f.support, a ∈ balancedNodeRemovedExponents Q := by
  classical
  rw [balancedNodeIdeal, MvPolynomial.mem_ideal_span_monomial_image]
  apply forall₂_congr
  intro a member
  simp only [Set.mem_insert_iff, Set.mem_singleton_iff, exists_eq_or_imp,
    exists_eq_left, Finsupp.single_le_iff, balancedNodeRemovedExponents, Set.mem_setOf_eq]
  have both : Finsupp.single (0 : Fin 2) 1 + Finsupp.single 1 1 ≤ a ↔
      1 ≤ a 0 ∧ 1 ≤ a 1 := by
    change (∀ i : Fin 2, ((Finsupp.single 0 1 + Finsupp.single 1 1) : Fin 2 →₀ ℕ) i ≤ a i) ↔ _
    simp [Fin.forall_fin_two]
  rw [both]

theorem balanced_node_ideal_span (Q : ℕ) :
    (balancedNodeIdeal R Q).restrictScalars R =
      Submodule.span R ((MvPolynomial.basisMonomials (Fin 2) R) '' balancedNodeRemovedExponents Q) := by
  ext f
  rw [Module.Basis.mem_span_image]
  exact balanced_node_ideal_membership R Q f

/-- The genuine balanced node basis is built from the actual original
monomial basis and the complete literal relation ideal. -/
noncomputable def balancedNodeBasis (Q : ℕ) :
    Module.Basis {a : Fin 2 →₀ ℕ // a ∉ balancedNodeRemovedExponents Q} R (BalancedNodeAlgebra R Q) :=
  (basisQuotientComplement (MvPolynomial.basisMonomials (Fin 2) R) (balancedNodeRemovedExponents Q)).map
    ((Submodule.quotEquivOfEq _ _ (balanced_node_ideal_span R Q).symm).trans
      (Submodule.Quotient.restrictScalarsEquiv R (balancedNodeIdeal R Q)))

end Litt3.Deformations
