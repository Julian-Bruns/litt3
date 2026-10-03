import Definitions.Deformations.HermitianSchur

namespace Litt3.Deformations.Specifications

open Matrix

variable {R m n : Type*} [Ring R] [StarRing R]
variable [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n]

def HermitianSchurCongruence (C : Matrix m m R) (D : Matrix m n R)
    (F : Matrix n n R) [Invertible C] : Prop :=
  (hermitianSchurEliminator C D)ᴴ * fromBlocks C D Dᴴ F *
      hermitianSchurEliminator C D =
    fromBlocks C 0 0 (F - Dᴴ * ⅟C * D)

def SkewHermitianSchurCongruence (C : Matrix m m R) (D : Matrix m n R)
    (F : Matrix n n R) [Invertible C] : Prop :=
  (hermitianSchurEliminator C D)ᴴ * fromBlocks C D (-Dᴴ) F *
      hermitianSchurEliminator C D =
    fromBlocks C 0 0 (F + Dᴴ * ⅟C * D)

end Litt3.Deformations.Specifications
