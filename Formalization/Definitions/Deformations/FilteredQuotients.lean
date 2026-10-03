import Definitions.Deformations.FiltrationWidth
import Mathlib.LinearAlgebra.Quotient.Basic

namespace Litt3.Deformations

variable {k V W : Type*} [DivisionRing k]
variable [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

/-- A genuine linear map preserving every specified filtration
subspace, with no associated-graded rank information assumed. -/
structure FilteredLinearMap (F : ℕ → Submodule k V) (E : ℕ → Submodule k W) where
  toLinearMap : V →ₗ[k] W
  respects : ∀ i x, x ∈ F i → toLinearMap x ∈ E i

namespace FilteredLinearMap

variable {F : ℕ → Submodule k V} {E : ℕ → Submodule k W}

def restriction (f : FilteredLinearMap F E) (i : ℕ) : F i →ₗ[k] E i :=
  f.toLinearMap.restrict (f.respects i)

def layerMap (f : FilteredLinearMap F E) (i : ℕ) :
    FiltrationLayer F i →ₗ[k] FiltrationLayer E i :=
  Submodule.mapQ _ _ (f.restriction i) (fun x hx => f.respects (i + 1) x.val hx)

end FilteredLinearMap

end Litt3.Deformations
