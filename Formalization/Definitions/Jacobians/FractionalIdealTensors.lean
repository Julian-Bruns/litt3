import Mathlib.RingTheory.FractionalIdeal.Operations
import Mathlib.Algebra.Algebra.Bilinear
import Mathlib.RingTheory.PicardGroup

open scoped nonZeroDivisors TensorProduct

namespace Litt3.Jacobians

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]

/-- Multiplication on the actual tensor product of the actual fractional
ideal modules, into their original ambient field. -/
noncomputable def fractionalIdealTensorProductMap
    (I J : FractionalIdeal R⁰ K) :
    (I : Submodule R K) ⊗[R] (J : Submodule R K) →ₗ[R] K :=
  (LinearMap.mul' R K).comp
    (TensorProduct.map (I : Submodule R K).subtype (J : Submodule R K).subtype)

end Litt3.Jacobians
