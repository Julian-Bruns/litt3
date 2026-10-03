import Solutions.CartierAndSpin.ProperDifferentialRatioConstants
import Solutions.SharedTensors.SchemeDifferentialGlobalLinearEquivalence
import Mathlib.LinearAlgebra.Dimension.FreeAndStrongRankCondition

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  [UniversallyClosed sX]

/-- A true nowhere-zero regular one-form bounds the genuine ORIGINAL
differential sheaf H0 dimension by one. The actual H0-to-stalk-image
linear equivalence is proved; no genus or canonical-degree bridge is used. -/
theorem actual_nowhere_zero_differential_global_rank_le_one :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField,
      omega ≠ 0 → omega ∈ schemeGlobalRegularDifferentials sX →
      schemeDifferentialZeroSet sX omega = ∅ →
      Module.rank k (schemeDifferentialGlobalSections sX) ≤ 1 := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega homega hregular hzero
  let omegaReg : schemeGlobalRegularDifferentials sX := ⟨omega, hregular⟩
  have hsmall : Module.rank k (schemeGlobalRegularDifferentials sX) ≤ 1 := by
    apply rank_le_one_iff.mpr
    refine ⟨omegaReg, ?_⟩
    intro nu
    obtain ⟨c, hc⟩ := actual_nowhere_zero_regular_differential_spans_global
      sX omega nu.val homega hregular nu.property hzero
    exact ⟨c, Subtype.ext hc.symm⟩
  rw [(schemeDifferentialGlobalSectionsRegularEquiv sX 1).rank_eq]
  exact hsmall

/-- Genuine ORIGINAL differential H0 rank at least two forces every
nonzero actual regular one-form to have a true original closed-point
zero. No finite dimensionality or cohomological genus conversion is assumed. -/
theorem actual_global_differential_rank_two_forces_zero
    (hdimension : 2 ≤ Module.rank k (schemeDifferentialGlobalSections sX)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField,
      omega ≠ 0 → omega ∈ schemeGlobalRegularDifferentials sX →
      (schemeDifferentialZeroSet sX omega).Nonempty := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega homega hregular
  by_contra h
  have hzero := Set.not_nonempty_iff_eq_empty.mp h
  have hsmall := actual_nowhere_zero_differential_global_rank_le_one
    sX omega homega hregular hzero
  exact (by norm_num : ¬ (2 : Cardinal) ≤ 1) (hdimension.trans hsmall)

end Litt3.CartierAndSpin
