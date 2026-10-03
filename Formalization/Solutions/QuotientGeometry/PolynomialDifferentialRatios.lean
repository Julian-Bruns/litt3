import Mathlib.RingTheory.Kaehler.Basic

namespace Litt3.QuotientGeometry

variable {k R : Type*} [CommRing k] [CommRing R] [Algebra k R]

/-- At a point where both the denominator and the polynomial coordinate
derivative are units, the literal differential ratio is the reciprocal
of their actual product. This uses actual universal differentials over
any coefficient ring and imposes no genus or characteristic restriction. -/
theorem polynomial_coordinate_differential_ratio
    (z : R) (P : Polynomial k) (y v : Rˣ)
    (hv : Polynomial.aeval z P.derivative = v.val) :
    (y⁻¹ : Rˣ).val • KaehlerDifferential.D k R z =
      ((y * v)⁻¹ : Rˣ).val • KaehlerDifferential.D k R (Polynomial.aeval z P) := by
  rw [(KaehlerDifferential.D k R).map_aeval, hv, smul_smul]
  have hc : ((y * v)⁻¹ : Rˣ).val * v.val = (y⁻¹ : Rˣ).val := by
    change (((y * v)⁻¹ * v : Rˣ).val) = (y⁻¹ : Rˣ).val
    congr 1
    simp [mul_inv_rev, mul_assoc, mul_comm, mul_left_comm]
  rw [hc]

/-- A curve differential identity written as dG=c F^n dz/y is converted
inside the actual local ring to dG=c F^n (y F_z)^(-1) dF. The reciprocal
is an actual unit, rather than an unspecified coefficient ratio. -/
theorem polynomial_coordinate_source_differential_identity
    (z g : R) (P : Polynomial k) (y v : Rˣ) (c : k) (n : ℕ)
    (hv : Polynomial.aeval z P.derivative = v.val)
    (hdg : KaehlerDifferential.D k R g =
      (algebraMap k R c * (Polynomial.aeval z P) ^ n) •
        ((y⁻¹ : Rˣ).val • KaehlerDifferential.D k R z)) :
    KaehlerDifferential.D k R g =
      (algebraMap k R c * (Polynomial.aeval z P) ^ n * ((y * v)⁻¹ : Rˣ).val) •
        KaehlerDifferential.D k R (Polynomial.aeval z P) := by
  rw [hdg, polynomial_coordinate_differential_ratio z P y v hv, smul_smul]

end Litt3.QuotientGeometry
