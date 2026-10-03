import Solutions.CartierAndSpin.FormallyEtaleDifferentialCoordinates
import Solutions.QuotientGeometry.SmoothStalkDifferentialInjectivity
import Mathlib.LinearAlgebra.Pi
import Mathlib.LinearAlgebra.Dimension.Constructions

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

/-- The ENTIRE original universal differential module on a true
standard smooth dimension-one affine chart has a constructed coordinate.
No local frame, characteristic, or differential injection is assumed. -/
noncomputable def actualStandardSmoothAffineDifferentialCoordinate
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) [Nonempty U]
    (hs : RingHom.IsStandardSmoothOfRelativeDimension 1 (chartBaseFieldHom sX U)) :
    letI := (chartBaseFieldHom sX U).toAlgebra
    KaehlerDifferential k Γ(X, U) ≃ₗ[Γ(X, U)] Γ(X, U) := by
  letI := (chartBaseFieldHom sX U).toAlgebra
  letI : Algebra.IsStandardSmoothOfRelativeDimension 1 k Γ(X, U) := hs
  letI : Algebra.IsStandardSmooth k Γ(X, U) :=
    Algebra.IsStandardSmoothOfRelativeDimension.isStandardSmooth 1
  exact (finDimVectorspaceEquiv 1
    (Algebra.IsStandardSmoothOfRelativeDimension.rank_kaehlerDifferential 1)).trans
      (LinearEquiv.funUnique (Fin 1) Γ(X, U) Γ(X, U))

end Litt3.CartierAndSpin
