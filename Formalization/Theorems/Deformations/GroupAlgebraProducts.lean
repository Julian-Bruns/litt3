import Definitions.Deformations.GroupAlgebraProducts

namespace Litt3.Deformations.Specifications

open scoped MonoidAlgebra TensorProduct

variable {k G H : Type*} [CommSemiring k] [Monoid G] [Monoid H]

def GenuineGroupAlgebraProductPresentation : Prop :=
  ∃ e : (k[G] ⊗[k] k[H]) ≃ₐ[k] k[G × H],
    ∀ g h, e (MonoidAlgebra.of k G g ⊗ₜ[k] MonoidAlgebra.of k H h) =
      MonoidAlgebra.of k (G × H) (g, h)

end Litt3.Deformations.Specifications
