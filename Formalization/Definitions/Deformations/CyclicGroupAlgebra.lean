import Definitions.Deformations.TruncatedCoefficientRing
import Mathlib.Algebra.MonoidAlgebra.Basic
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.CharP.Lemmas
import Mathlib.Algebra.CharP.Algebra
import Mathlib.LinearAlgebra.Dimension.Constructions

namespace Litt3.Deformations

open Polynomial

variable (k : Type*) [CommRing k]

/-- The actual group algebra of the constant cyclic group of order N. -/
abbrev CyclicGroupAlgebra (N : ℕ) := AddMonoidAlgebra k (ZMod N)

instance (N p : ℕ) [CharP k p] : CharP (CyclicGroupAlgebra k N) p :=
  charP_of_injective_algebraMap' k p

/-- The actual group-algebra unit associated to the cyclic generator. -/
noncomputable def cyclicGroupGenerator (N : ℕ) : (CyclicGroupAlgebra k N)ˣ where
  val := AddMonoidAlgebra.single (1 : ZMod N) 1
  inv := AddMonoidAlgebra.single (-1 : ZMod N) 1
  val_inv := by
    rw [AddMonoidAlgebra.single_mul_single]
    simp only [add_neg_cancel, one_mul]
    rfl
  inv_val := by
    rw [AddMonoidAlgebra.single_mul_single]
    simp only [neg_add_cancel, one_mul]
    rfl

/-- The actual presentation homomorphism, mapping the polynomial
parameter to the augmentation coordinate of the cyclic generator. -/
noncomputable def cyclicAugmentationPresentation (p a : ℕ) [Fact p.Prime] [CharP k p] :
    TruncatedCoefficientRing k (p ^ a) →ₐ[k] CyclicGroupAlgebra k (p ^ a) :=
  AdjoinRoot.liftAlgHom ((X : Polynomial k) ^ (p ^ a))
    (Algebra.ofId k (CyclicGroupAlgebra k (p ^ a)))
    ((cyclicGroupGenerator k (p ^ a) : CyclicGroupAlgebra k (p ^ a)) - 1) (by
      rw [Polynomial.eval₂_pow, Polynomial.eval₂_X, sub_pow_char_pow]
      change AddMonoidAlgebra.single (1 : ZMod (p ^ a)) 1 ^ (p ^ a) - 1 ^ (p ^ a) = 0
      rw [AddMonoidAlgebra.single_pow]
      simp only [one_pow, Nat.smul_one_eq_cast, ZMod.natCast_self]
      change (1 : CyclicGroupAlgebra k (p ^ a)) - 1 = 0
      exact sub_self _)

end Litt3.Deformations
