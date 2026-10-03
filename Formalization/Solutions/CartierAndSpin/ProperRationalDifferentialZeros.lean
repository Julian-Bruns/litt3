import Solutions.CartierAndSpin.RationalDifferentialZeroRatios
import Solutions.CartierAndSpin.GlobalDifferentialDimensionZeros

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

/-- Every regular form divided by ANY nonzero rational form with no
genuine original zeros is an actual proper constant. The rational
denominator may have poles. This derives the positive-zero phenomenon
without a canonical divisor degree or genus theorem. -/
theorem actual_rational_differential_without_zeros_regular_forms_scalar :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega nu : KaehlerDifferential k X.functionField,
      omega ≠ 0 → nu ∈ schemeGlobalRegularDifferentials sX →
      schemeDifferentialZeroSet sX omega = ∅ →
      ∃ c : k, nu = c • omega := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  intro omega nu homega hregnu hzero
  obtain ⟨e⟩ := one_variable_kaehler_coordinate_exists
    (actual_locally_finite_type_function_field_finitely_generated sX)
    (actual_smooth_function_field_transcendence_degree sX 1)
  have heomega : e omega ≠ 0 := by
    intro h
    exact homega (e.injective (h.trans (map_zero e).symm))
  let f := e nu / e omega
  have hform : nu = f • omega := by
    apply e.injective
    rw [map_smul, smul_eq_mul]
    exact (div_mul_cancel₀ (e nu) heomega).symm
  have hclosed : ∀ x : ClosedPoint X, ∃ r : X.presheaf.stalk x.val,
      algebraMap (X.presheaf.stalk x.val) X.functionField r = f := by
    intro x
    letI := (stalkBaseFieldHom sX x.val).toAlgebra
    letI : IsScalarTower k (X.presheaf.stalk x.val) X.functionField :=
      IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
    have hnozero : ¬ differentialZeroLattice (R := X.presheaf.stalk x.val) omega := by
      have hnot : x ∉ schemeDifferentialZeroSet sX omega := by
        simp only [hzero, Set.mem_empty_iff_false, not_false_eq_true]
      exact hnot
    have hv := (mem_schemeGlobalRegularDifferentials_iff sX nu).mp hregnu x
    obtain ⟨r, hr⟩ := actual_regular_differential_ratio_of_rational_no_zero
      (actualSmoothCurveStalkDifferentialCoordinate sX x.val) omega nu homega hv hnozero
    refine ⟨r, ?_⟩
    have he := congrArg e hr
    rw [map_smul, smul_eq_mul] at he
    exact (eq_div_iff heomega).mpr he
  obtain ⟨c, hc⟩ := actual_universally_closed_regular_rational_function_constant sX f
    ((actual_smooth_curve_closed_regular_iff_everywhere sX f).mp hclosed)
  refine ⟨c, ?_⟩
  rw [hform]
  change f • omega = algebraMap k X.functionField c • omega
  change algebraMap k X.functionField c = f at hc
  rw [hc]

/-- Even a nonregular rational form without genuine zeros bounds the
GENUINE original global differential SHEAF dimension by one. -/
theorem actual_rational_differential_without_zeros_global_rank_le_one :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField,
      omega ≠ 0 → schemeDifferentialZeroSet sX omega = ∅ →
      Module.rank k (schemeDifferentialGlobalSections sX) ≤ 1 := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega homega hzero
  rw [(schemeDifferentialGlobalSectionsRegularEquiv sX 1).rank_eq]
  by_cases hregular : omega ∈ schemeGlobalRegularDifferentials sX
  · apply rank_le_one_iff.mpr
    refine ⟨⟨omega, hregular⟩, ?_⟩
    intro nu
    obtain ⟨c, hc⟩ := actual_rational_differential_without_zeros_regular_forms_scalar
      sX omega nu.val homega nu.property hzero
    exact ⟨c, Subtype.ext hc.symm⟩
  · apply rank_le_one_iff.mpr
    refine ⟨0, ?_⟩
    intro nu
    obtain ⟨c, hc⟩ := actual_rational_differential_without_zeros_regular_forms_scalar
      sX omega nu.val homega nu.property hzero
    have hnuzero : nu.val = 0 := by
      by_cases hczero : c = 0
      · simpa only [hczero, zero_smul] using hc
      · have hm := (schemeGlobalRegularDifferentials sX).smul_mem c⁻¹ nu.property
        rw [hc, inv_smul_smul₀ hczero] at hm
        exact False.elim (hregular hm)
    exact ⟨0, Subtype.ext (by simpa only [zero_smul] using hnuzero.symm)⟩

/-- Actual original differential H0 rank at least two forces a true
closed-point zero of EVERY nonzero rational one-form, including forms
with poles. No genus or canonical-degree theorem is an input. -/
theorem actual_global_rank_two_every_rational_differential_has_zero
    (hdimension : 2 ≤ Module.rank k (schemeDifferentialGlobalSections sX)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField,
      omega ≠ 0 → (schemeDifferentialZeroSet sX omega).Nonempty := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega homega
  by_contra h
  have hsmall := actual_rational_differential_without_zeros_global_rank_le_one
    sX omega homega (Set.not_nonempty_iff_eq_empty.mp h)
  exact (by norm_num : ¬ (2 : Cardinal) ≤ 1) (hdimension.trans hsmall)

end Litt3.CartierAndSpin
