import Mathlib.LinearAlgebra.TensorProduct.Associator
import Mathlib.LinearAlgebra.Quotient.Basic
import Mathlib.RingTheory.Kaehler.Basic

open scoped TensorProduct

namespace Litt3.SharedTensors

variable (K : Type*) [CommRing K] (M : Type*) [AddCommGroup M] [Module K M]

/-- The actual exchange relations defining the symmetric square. -/
def symmetricSquareRelations : Submodule K (M ⊗[K] M) :=
  Submodule.span K (Set.range fun z : M ⊗[K] M => TensorProduct.comm K M M z - z)

/-- The symmetric square is the actual tensor quotient by exchange
relations, in every characteristic. -/
def RationalSymmetricSquare := (M ⊗[K] M) ⧸ symmetricSquareRelations K M

noncomputable instance : AddCommGroup (RationalSymmetricSquare K M) :=
  inferInstanceAs (AddCommGroup ((M ⊗[K] M) ⧸ symmetricSquareRelations K M))

noncomputable instance : Module K (RationalSymmetricSquare K M) :=
  inferInstanceAs (Module K ((M ⊗[K] M) ⧸ symmetricSquareRelations K M))

/-- Actual symmetric multiplication of two rational differentials. -/
def rationalSymmetricProduct (a b : M) : RationalSymmetricSquare K M :=
  (symmetricSquareRelations K M).mkQ (a ⊗ₜ[K] b)

/-- A coordinate of a rank-one module induces a coordinate of its actual
tensor square; the equivalence itself is proved by tensor functoriality. -/
noncomputable def rationalTensorSquareCoordinate (e : M ≃ₗ[K] K) :
    (M ⊗[K] M) ≃ₗ[K] K :=
  (TensorProduct.congr e e).trans (TensorProduct.lid K K)

end Litt3.SharedTensors
