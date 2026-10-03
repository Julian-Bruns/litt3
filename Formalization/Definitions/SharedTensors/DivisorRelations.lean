import Definitions.Jacobians.ValuationDivisors
import Mathlib.Data.Finsupp.SMul
import Mathlib.Data.Set.Finite.Lattice
import Mathlib.GroupTheory.QuotientGroup.Basic

/-!
Unramified divisor pullbacks and their actual two-leg relation lattice.
The underlying point sets may be infinite. Finite fibers, not injectivity,
ensure finite support; all integral divisor coefficients are retained.
-/

namespace Litt3.SharedTensors

noncomputable section

def divisorPullback {X Z : Type*} (f : Z → X)
    (hf : ∀ s : Set X, s.Finite → (f ⁻¹' s).Finite) :
    Litt3.Jacobians.Divisor X →+ Litt3.Jacobians.Divisor Z where
  toFun D := Finsupp.ofSupportFinite (fun z => D (f z))
    (hf (Function.support D) D.finite_support)
  map_zero' := by ext z; rfl
  map_add' := by intro D E; ext z; rfl

@[simp] theorem divisorPullback_apply {X Z : Type*} (f : Z → X)
    (hf : ∀ s : Set X, s.Finite → (f ⁻¹' s).Finite)
    (D : Litt3.Jacobians.Divisor X) (z : Z) : divisorPullback f hf D z = D (f z) := rfl

/-- The original endpoint divisor relation map on one common source. -/
def divisorRelationMap {X Y Z : Type*} (f : Z → X) (g : Z → Y)
    (hf : ∀ s : Set X, s.Finite → (f ⁻¹' s).Finite)
    (hg : ∀ s : Set Y, s.Finite → (g ⁻¹' s).Finite) :
    (Litt3.Jacobians.Divisor X × Litt3.Jacobians.Divisor Y) →+
      Litt3.Jacobians.Divisor Z :=
  (divisorPullback f hf).comp (AddMonoidHom.fst _ _) -
    (divisorPullback g hg).comp (AddMonoidHom.snd _ _)

/-- Integral quotient by both actual endpoint pullback images. -/
abbrev DivisorRelationQuotient {X Y Z : Type*} (f : Z → X) (g : Z → Y)
    (hf : ∀ s : Set X, s.Finite → (f ⁻¹' s).Finite)
    (hg : ∀ s : Set Y, s.Finite → (g ⁻¹' s).Finite) :=
  Litt3.Jacobians.Divisor Z ⧸ (divisorRelationMap f g hf hg).range

end
end Litt3.SharedTensors
