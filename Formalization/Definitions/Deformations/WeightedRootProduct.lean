import Solutions.Deformations.WeightedRootFactor
import Mathlib.Algebra.Category.CommAlgCat.Basic
import Mathlib.RingTheory.TensorProduct.Basic

namespace Litt3.Deformations

open scoped TensorProduct

/-- The actual tensor product of the literal monic one-coordinate
quotients E_i^q+tau E_i, over the original coefficient ring. -/
noncomputable def weightedRootProduct (R : Type*) [CommRing R] (q : ℕ) (tau : R) :
    ℕ → CommAlgCat R
  | 0 => CommAlgCat.of R R
  | r + 1 => CommAlgCat.of R
      (WeightedRootFactor R q tau ⊗[R] weightedRootProduct R q tau r)

/-- The original ordered quotient coordinates, inserted by the actual
left/right tensor algebra homomorphisms. -/
noncomputable def weightedRootProductParameter (R : Type*) [CommRing R] (q : ℕ) (tau : R) :
    (r : ℕ) → Fin r → weightedRootProduct R q tau r
  | 0 => Fin.elim0
  | r + 1 => Fin.cases
      ((Algebra.TensorProduct.includeLeft : WeightedRootFactor R q tau →ₐ[R]
        WeightedRootFactor R q tau ⊗[R] weightedRootProduct R q tau r)
          (AdjoinRoot.root (weightedRootRelation q tau)))
      (fun i => (Algebra.TensorProduct.includeRight : weightedRootProduct R q tau r →ₐ[R]
        WeightedRootFactor R q tau ⊗[R] weightedRootProduct R q tau r)
          (weightedRootProductParameter R q tau r i))

end Litt3.Deformations
