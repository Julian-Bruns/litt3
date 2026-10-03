import Definitions.Deformations.FiniteShiftCokernel

namespace Litt3.Deformations

variable {R I : Type*} {M : I → Type*} [CommRing R]
    [∀ i, AddCommGroup (M i)] [∀ i, Module R (M i)]

/-- Literal coordinatewise scalar multiplication on the full actual product. -/
def diagonalScalarOperator (r : I → R) : Module.End R (∀ i, M i) where
  toFun v i := r i • v i
  map_add' v w := funext (fun i => smul_add (r i) (v i) (w i))
  map_smul' s v := by
    funext i
    exact smul_comm (r i) s (v i)

/-- The literal product of actual individual scalar quotient maps. -/
def diagonalCoefficientQuotientMap (r : I → R) :
    (∀ i, M i) →ₗ[R] (∀ i, M i ⧸ coefficientScalarRange (K := M i) (r i)) where
  toFun v i := (coefficientScalarRange (K := M i) (r i)).mkQ (v i)
  map_add' v w := funext (fun i => (coefficientScalarRange (K := M i) (r i)).mkQ.map_add (v i) (w i))
  map_smul' s v := funext (fun i => (coefficientScalarRange (K := M i) (r i)).mkQ.map_smul s (v i))

end Litt3.Deformations
