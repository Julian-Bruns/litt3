import Solutions.Deformations.TruncatedMonomialBasis
import Mathlib.LinearAlgebra.Dimension.Free
import Mathlib.LinearAlgebra.FreeModule.StrongRankCondition

namespace Litt3.Deformations

variable (R I : Type*) [CommRing R] [Fintype I]

/-- Surviving original exponents are exactly the finite tuple of
unchanged coordinate bounds, including zero bounds without exceptions. -/
noncomputable def truncatedExponentTupleEquiv (q : I → ℕ) :
    {a : I →₀ ℕ // a ∉ oversizedMonomialExponents I q} ≃ (∀ i, Fin (q i)) where
  toFun a i := ⟨a.val i, Nat.lt_of_not_ge (fun h => a.property ⟨i, h⟩)⟩
  invFun v := ⟨Finsupp.equivFunOnFinite.symm (fun i => (v i).val), by
    rintro ⟨i, h⟩
    exact (Nat.not_le_of_lt (v i).isLt) h⟩
  left_inv a := by
    apply Subtype.ext
    exact Finsupp.equivFunOnFinite.symm_apply_apply a.val
  right_inv v := by
    funext i
    apply Fin.ext
    rfl

/-- A finite original tuple basis of the actual unequal-power quotient,
constructed by reindexing the actual monomial quotient basis. -/
noncomputable def truncatedMonomialTupleBasis (q : I → ℕ) :
    Module.Basis (∀ i, Fin (q i)) R (TruncatedMonomialAlgebra R I q) :=
  (truncatedMonomialBasis R I q).reindex (truncatedExponentTupleEquiv I q)

variable [Nontrivial R]

/-- The actual unequal-power quotient has exact dimension the product
of its original truncation exponents, over any commutative coefficient
ring, without a supplied monomial count or quotient presentation. -/
theorem truncated_monomial_finrank (q : I → ℕ) :
    Module.finrank R (TruncatedMonomialAlgebra R I q) = ∏ i, q i := by
  classical
  rw [Module.finrank_eq_card_basis (truncatedMonomialTupleBasis R I q)]
  simp

end Litt3.Deformations
