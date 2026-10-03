import Definitions.Deformations.RegularFunctionRepresentation
import Mathlib.LinearAlgebra.TensorProduct.Basis
import Mathlib.LinearAlgebra.Finsupp.Pi

namespace Litt3.Deformations

open scoped MonoidAlgebra TensorProduct

variable {k G V : Type*} [CommRing k] [Group G] [Finite G]
    [AddCommGroup V] [Module k V]

/-- The complete actual coefficient tensor is the full function module
on a finite group; inversion changes left multiplication to right translation. -/
noncomputable def regularFunctionTensorEquiv : k[G] ⊗[k] V ≃ₗ[k] (G → V) :=
  by
  classical
  exact (TensorProduct.equivFinsuppOfBasisLeft
    (Finsupp.basisSingleOne : Module.Basis G k k[G])).trans
    ((Finsupp.linearEquivFunOnFinite k V G).trans
      (LinearEquiv.funCongrLeft k V (Equiv.inv G)))

end Litt3.Deformations
