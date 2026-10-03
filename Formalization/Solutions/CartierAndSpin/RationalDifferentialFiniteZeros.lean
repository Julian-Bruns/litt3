import Definitions.CartierAndSpin.SchemeDifferentialZeros
import Solutions.CartierAndSpin.SmoothAffineDifferentialCoordinates
import Solutions.CartierAndSpin.DifferentialCoordinateLocalizations
import Solutions.CartierAndSpin.DVRDifferentialZeroValuation
import Solutions.SharedTensors.SmoothCurveFiniteSupport
import Solutions.SharedTensors.DivisorSectionOrders

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry
open scoped WithZero

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry Litt3.Jacobians

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- On an actual standard smooth affine chart, genuine zeros of a
nonzero rational one-form lie in the actual principal-divisor support
of its constructed chart coordinate. The coefficient is an actual
nonzero element of the ORIGINAL function field. -/
theorem actual_affine_differential_zero_support_subset
    (U : X.Opens) (hU : IsAffineOpen U) [Nonempty U]
    (hs : RingHom.IsStandardSmoothOfRelativeDimension 1 (chartBaseFieldHom sX U)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    ∀ omega : KaehlerDifferential k X.functionField, omega ≠ 0 →
      ∃ (f : X.functionField) (hf : f ≠ 0),
        ∀ x : ClosedPoint X, x.val ∈ U → x ∈ schemeDifferentialZeroSet sX omega →
          valuationOrder (closedPointValuation X x) (Additive.ofMul (Units.mk0 f hf)) ≠ 0 := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := (chartBaseFieldHom sX U).toAlgebra
  letI := functionField_isFractionRing_of_isAffineOpen X U hU
  letI : IsScalarTower k Γ(X, U) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (chart_base_field_hom_generic_compatibility sX U).symm
  letI : Algebra.FormallyEtale Γ(X, U) X.functionField :=
    Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors Γ(X, U))
  let e := actualStandardSmoothAffineDifferentialCoordinate sX U hs
  let eK := formallyEtaleDifferentialCoordinate (S := X.functionField) e
  intro omega homega
  let f := eK omega
  have hf : f ≠ 0 := by
    intro h
    apply homega
    exact eK.injective (h.trans (map_zero eK).symm)
  refine ⟨f, hf, ?_⟩
  intro x hx hzero horder
  let xU : U := ⟨x.val, hx⟩
  let R := X.presheaf.stalk x.val
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI := X.presheaf.algebra_section_stalk xU
  letI : IsScalarTower k Γ(X, U) R :=
    IsScalarTower.of_algebraMap_eq' (actual_chart_stalk_base_field_compatibility sX U xU).symm
  letI : IsScalarTower k R X.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
  letI : IsScalarTower Γ(X, U) R X.functionField :=
    IsScalarTower.of_algebraMap_eq' (by
      symm
      change (X.presheaf.germ U x.val hx ≫
          X.presheaf.stalkSpecializes ((genericPoint_spec X).specializes trivial)).hom =
        (X.presheaf.germ U (genericPoint X) _).hom
      rw [X.presheaf.germ_stalkSpecializes])
  letI := hU.isLocalization_stalk xU
  letI : Algebra.FormallyEtale Γ(X, U) R :=
    Algebra.FormallyEtale.of_isLocalization (hU.primeIdealOf xU).asIdeal.primeCompl
  letI : Algebra.FormallyEtale R X.functionField :=
    Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors R)
  change differentialZeroLattice (R := R) omega at hzero
  have hval := (actual_dvr_differential_zero_iff_valuation_lt_one
    (formallyEtaleDifferentialCoordinate (S := R) e) omega).mp hzero
  rw [formally_etale_differential_coordinate_localization] at hval
  have hone : closedPointValuation X x f = 1 := by
    have h := valuation_value_eq_exp_neg_order (closedPointValuation X x)
      (Additive.ofMul (Units.mk0 f hf))
    simpa only [horder, neg_zero, WithZero.exp_zero] using h
  exact (ne_of_lt hval) hone

/-- EVERY nonzero rational one-form on an actual quasi-compact smooth
integral curve has finitely many genuine original m·Ω zeros, in ANY
characteristic. The finite actual affine cover, local coordinates and
principal support bounds are all constructed. -/
theorem actual_compact_smooth_rational_differential_zeros_finite
    [CompactSpace X] :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField, omega ≠ 0 →
      (schemeDifferentialZeroSet sX omega).Finite := by
  classical
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_compact_smooth_curve_finite_principal_support sX
  intro omega homega
  choose U hU hx hs using fun x : X => actual_smooth_point_chart sX 1 x
  have hcover : (Set.univ : Set X) ⊆ ⋃ x : X, (U x : Set X) := by
    intro x _
    exact Set.mem_iUnion.mpr ⟨x, hx x⟩
  obtain ⟨t, ht⟩ := isCompact_univ.elim_finite_subcover
    (fun x : X => (U x : Set X)) (fun x => (U x).isOpen) hcover
  letI : ∀ i : t, Nonempty (U i.val) := fun i => ⟨⟨i.val, hx i.val⟩⟩
  choose f hf hsupport using fun i : t =>
    actual_affine_differential_zero_support_subset sX (U i.val) (hU i.val)
      (hs i.val) omega homega
  have hfinite : (⋃ i : t, Function.support (fun x : ClosedPoint X =>
      valuationOrder (closedPointValuation X x) (Additive.ofMul (Units.mk0 (f i) (hf i))))).Finite :=
    Set.finite_iUnion fun i => FinitePrincipalSupport.finite_support _
  apply hfinite.subset
  intro x hzero
  obtain ⟨i, hi⟩ := Set.mem_iUnion.mp (ht (Set.mem_univ x.val))
  obtain ⟨hit, hxi⟩ := Set.mem_iUnion.mp hi
  exact Set.mem_iUnion.mpr ⟨⟨i, hit⟩, hsupport ⟨i, hit⟩ x hxi hzero⟩

end Litt3.CartierAndSpin
