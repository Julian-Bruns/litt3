import Theorems.Deformations.AbelianPairRadicalHilbert
import Solutions.Deformations.TruncatedTensorRadical
import Solutions.Deformations.CyclicRadicalWidth
import Solutions.Deformations.GroupAlgebraProducts

namespace Litt3.Deformations

open scoped MonoidAlgebra TensorProduct

variable {k : Type*} [Field k]

/-- Genuine two-variable augmentation presentation, including
unequal cyclic p-power factors and every exponent. -/
noncomputable def abelianPairAugmentationAlgebraEquiv (p a b : ℕ)
    [Fact p.Prime] [CharP k p] :
    TruncatedTensorAlgebra k (p ^ a) (p ^ b) ≃ₐ[k]
      k[Multiplicative (ZMod (p ^ a)) × Multiplicative (ZMod (p ^ b))] :=
  (Algebra.TensorProduct.congr (cyclicMonoidAugmentationAlgebraEquiv (k := k) p a)
    (cyclicMonoidAugmentationAlgebraEquiv (k := k) p b)).trans groupAlgebraProductTensorEquiv

/-- Complete actual radical Hilbert formula for the actual
product group algebra, without any Jennings hypothesis. -/
theorem actual_abelian_pair_radical_hilbert_polynomial (p a b : ℕ)
    [Fact p.Prime] [CharP k p] :
    Specifications.ActualAbelianPairRadicalHilbertPolynomial (k := k) p a b := by
  intro i
  rw [← algebra_equiv_radical_layer_finrank (abelianPairAugmentationAlgebraEquiv (k := k) p a b) i]
  exact truncated_tensor_radical_hilbert_polynomial (p ^ a) (p ^ b)
    (pow_pos (Fact.out : p.Prime).pos a) (pow_pos (Fact.out : p.Prime).pos b) i

end Litt3.Deformations
