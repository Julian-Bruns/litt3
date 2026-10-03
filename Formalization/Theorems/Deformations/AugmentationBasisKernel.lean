import Mathlib.LinearAlgebra.Basis.Basic
import Mathlib.Algebra.Module.Submodule.Ker

namespace Litt3.Deformations.Specifications

variable {k V ι : Type*} [CommRing k] [AddCommGroup V] [Module k V]

def AugmentationBasisKernel (b : Module.Basis ι k V) (z : ι) (ε : V →ₗ[k] k) : Prop :=
  LinearMap.ker ε = Submodule.span k (b '' {i : ι | i ≠ z})

end Litt3.Deformations.Specifications
