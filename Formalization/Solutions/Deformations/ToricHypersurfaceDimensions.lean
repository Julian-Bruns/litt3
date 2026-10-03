import Solutions.Deformations.ToricHypersurfaceBasis
import Solutions.Deformations.ToricHypersurfaceIndex
import Mathlib.LinearAlgebra.Dimension.Free
import Mathlib.LinearAlgebra.FreeModule.StrongRankCondition
import Mathlib.Data.Fin.Rev

namespace Litt3.Deformations

variable (K : Type*) [CommRing K]

noncomputable def toricHypersurfaceFiniteBasis (Q R s : ℕ)
    (positiveQ : 0<Q) (below : R≤Q) (positiveS : 0<s) :
    Module.Basis (ToricHypersurfaceFiniteIndex Q R s) K (ToricHypersurfaceAlgebra K Q R s) :=
  (toricHypersurfaceBasis K Q R s positiveS).reindex
    (toricHypersurfaceIndexEquiv Q R s positiveQ below positiveS)

variable [Nontrivial K]

/-- Exact actual quotient length from the constructed original basis;
the finite sum has no coefficient enumeration or supplied rank input. -/
theorem toric_hypersurface_polynomial_finrank (Q R s : ℕ)
    (positiveQ : 0<Q) (below : R≤Q) (positiveS : 0<s) :
    Module.finrank K (ToricHypersurfaceAlgebra K Q R s) =
      R+2*∑ i : Fin (Q-1), min R (s*(i.val+1)) := by
  classical
  rw [Module.finrank_eq_card_basis
    (toricHypersurfaceFiniteBasis K Q R s positiveQ below positiveS)]
  simp only [ToricHypersurfaceFiniteIndex,ToricHypersurfaceAxisIndex,Fintype.card_sum,
    Fintype.card_prod,Fintype.card_bool,Fintype.card_sigma,Fintype.card_fin]
  congr 2
  apply Fintype.sum_equiv (Fin.revPerm : Equiv.Perm (Fin (Q-1)))
  intro i
  have degree : Q-(i.val+1)=(Fin.rev i).val+1 := by
    simp only [Fin.val_rev]
    have := i.isLt
    omega
  simp only [Fin.revPerm_apply,degree]

end Litt3.Deformations
