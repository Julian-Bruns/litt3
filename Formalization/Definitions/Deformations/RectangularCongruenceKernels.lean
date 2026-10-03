import Definitions.Deformations.CongruenceKernels

namespace Litt3.Deformations

variable {R m n : Type*} [CommRing R]
variable [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n]

structure MatrixInversePair (P : Matrix m n R) (Q : Matrix n m R) : Prop where
  left_inverse : Q * P = 1
  right_inverse : P * Q = 1

end Litt3.Deformations
