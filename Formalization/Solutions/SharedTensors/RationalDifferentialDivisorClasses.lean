import Solutions.SharedTensors.RationalDifferentialDivisors
import Solutions.SharedTensors.SmoothCurveDifferentialOrderCalculus
import Solutions.SharedTensors.SmoothCurveFiniteSupport
import Solutions.SharedTensors.SmoothSchemeDifferentials

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.CartierAndSpin Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X] [CompactSpace X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- The divisor of an ORIGINAL rational scalar multiple differs by the
genuine original principal divisor. All finite supports are derived. -/
theorem actual_rational_differential_divisor_smul :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_compact_smooth_curve_finite_principal_support sX
    ∀ (a : X.functionFieldˣ) (omega : KaehlerDifferential k X.functionField)
      (h : omega ≠ 0),
      actualRationalDifferentialDivisor sX ((a : X.functionField) • omega)
          (rational_line_smul_ne_zero a omega h) =
        principalDivisorMap (schemeDivisorSystem X) (Additive.ofMul a) +
          actualRationalDifferentialDivisor sX omega h := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_compact_smooth_curve_finite_principal_support sX
  intro a omega h
  ext x
  exact actual_smooth_differential_order_smul sX a omega h x

/-- The actual original divisor class is invariant under every original
nonzero rational scalar; no degree or genus is assumed. -/
theorem actual_rational_differential_divisor_class_smul :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_compact_smooth_curve_finite_principal_support sX
    ∀ (a : X.functionFieldˣ) (omega : KaehlerDifferential k X.functionField)
      (h : omega ≠ 0),
      divisorClassMap (schemeDivisorSystem X)
          (actualRationalDifferentialDivisor sX ((a : X.functionField) • omega)
            (rational_line_smul_ne_zero a omega h)) =
        divisorClassMap (schemeDivisorSystem X)
          (actualRationalDifferentialDivisor sX omega h) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_compact_smooth_curve_finite_principal_support sX
  intro a omega h
  rw [actual_rational_differential_divisor_smul sX a omega h, map_add]
  have hp : divisorClassMap (schemeDivisorSystem X)
      (principalDivisorMap (schemeDivisorSystem X) (Additive.ofMul a)) = 0 := by
    change ((principalDivisorMap (schemeDivisorSystem X) (Additive.ofMul a)) :
      DivisorClassGroup (schemeDivisorSystem X)) = 0
    rw [QuotientAddGroup.eq_zero_iff]
    exact ⟨Additive.ofMul a, rfl⟩
  rw [hp, zero_add]

/-- ALL nonzero original rational differentials have the SAME genuine
divisor class. The original rank-one field module is derived from actual
smoothness, and the proportionality scalar is constructed in that field. -/
theorem actual_rational_differential_divisor_class_independent :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_compact_smooth_curve_finite_principal_support sX
    ∀ (omega eta : KaehlerDifferential k X.functionField)
      (h : omega ≠ 0) (hEta : eta ≠ 0),
      divisorClassMap (schemeDivisorSystem X)
          (actualRationalDifferentialDivisor sX omega h) =
        divisorClassMap (schemeDivisorSystem X)
          (actualRationalDifferentialDivisor sX eta hEta) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_compact_smooth_curve_finite_principal_support sX
  intro omega eta h hEta
  obtain ⟨a, ha⟩ := rational_line_exists_unit_smul_eq
    (actualSmoothCurveKaehlerCoordinate sX) omega eta h hEta
  subst eta
  exact (actual_rational_differential_divisor_class_smul sX a omega h).symm

end Litt3.SharedTensors
