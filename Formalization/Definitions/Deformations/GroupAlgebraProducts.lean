import Mathlib.Algebra.MonoidAlgebra.Basic
import Mathlib.RingTheory.TensorProduct.Maps
import Mathlib.LinearAlgebra.TensorProduct.Basis

namespace Litt3.Deformations

open scoped MonoidAlgebra TensorProduct

variable {k G H : Type*} [CommSemiring k] [Monoid G] [Monoid H]

noncomputable def groupAlgebraLeftProductMap : k[G] →ₐ[k] k[G × H] :=
  MonoidAlgebra.mapDomainAlgHom k k (MonoidHom.inl G H)

noncomputable def groupAlgebraRightProductMap : k[H] →ₐ[k] k[G × H] :=
  MonoidAlgebra.mapDomainAlgHom k k (MonoidHom.inr G H)

/-- The actual product monoid acts by pure tensors of its two
genuine group-algebra elements. -/
noncomputable def groupProductTensorMonoidHom : G × H →* (k[G] ⊗[k] k[H]) where
  toFun gh := MonoidAlgebra.of k G gh.1 ⊗ₜ[k] MonoidAlgebra.of k H gh.2
  map_one' := by
    change (1 : k[G]) ⊗ₜ[k] (1 : k[H]) = 1
    rfl
  map_mul' := by
    intro x y
    simp only [Prod.fst_mul, Prod.snd_mul, map_mul, Algebra.TensorProduct.tmul_mul_tmul]

noncomputable def groupAlgebraProductTensorInverse : k[G × H] →ₐ[k] (k[G] ⊗[k] k[H]) :=
  MonoidAlgebra.lift k (G × H) _ groupProductTensorMonoidHom

end Litt3.Deformations
