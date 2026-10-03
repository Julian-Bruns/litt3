import Mathlib.RingTheory.Kaehler.Basic
import Solutions.QuotientGeometry.SmoothCurveDifferentialFrames
import Solutions.QuotientGeometry.DVRResidueValues

namespace Litt3.QuotientGeometry

/-- Differentiation with respect to an actual étale coordinate is
constructed from the original universal differential frame. The
reciprocal ratio applies to ANY original local function, without a
polynomial-in-the-coordinate restriction. -/
theorem original_uniformizer_coordinate_derivative
    {k R : Type*} [CommRing k] [CommRing R] [Algebra k R]
    (t z : R) (e : R ≃ₗ[R] KaehlerDifferential k R)
    (he : ∀ r : R, e r = r • KaehlerDifferential.D k R t)
    (y S : Rˣ)
    (hcoordinate : (y⁻¹ : Rˣ).val • KaehlerDifferential.D k R z =
      S.val • KaehlerDifferential.D k R t) :
    ∃ D : Derivation k R R, D z = 1 ∧
      ∃ v : Rˣ, D t = v.val ∧ S.val = ((y * v)⁻¹ : Rˣ).val := by
  let q : Rˣ := y * S
  have ht : e.symm (KaehlerDifferential.D k R t) = 1 := by
    have he1 : e 1 = KaehlerDifferential.D k R t := by simpa using he 1
    rw [← he1]
    exact e.symm_apply_apply 1
  have hz : KaehlerDifferential.D k R z = q.val • KaehlerDifferential.D k R t := by
    calc
      KaehlerDifferential.D k R z =
          y.val • ((y⁻¹ : Rˣ).val • KaehlerDifferential.D k R z) := by
        rw [smul_smul, ← Units.val_mul]
        simp
      _ = y.val • (S.val • KaehlerDifferential.D k R t) := by rw [hcoordinate]
      _ = q.val • KaehlerDifferential.D k R t := by rw [smul_smul]; rfl
  let D : Derivation k R R :=
    (((q⁻¹ : Rˣ).val • e.symm.toLinearMap).compDer (KaehlerDifferential.D k R))
  have hD : ∀ a : R, D a = (q⁻¹ : Rˣ).val * e.symm (KaehlerDifferential.D k R a) := by
    intro a
    rfl
  refine ⟨D, ?_, q⁻¹, ?_, ?_⟩
  · rw [hD, hz, map_smul, ht]
    simp [Algebra.smul_def]
  · rw [hD, ht, mul_one]
  · change S.val = ((y * (y * S)⁻¹)⁻¹ : Rˣ).val
    congr 1
    simp [mul_comm, mul_left_comm, mul_assoc]

/-- The actual residue of sigma/dF is the reciprocal of y(R) F_z(R).
Here F_z is the constructed original coordinate derivation value. -/
theorem original_coordinate_differential_residue_ratio
    {k R : Type*} [Field k] [CommRing R] [IsDomain R]
    [Algebra k R] [IsDiscreteValuationRing R]
    (d : DVRCompletionParameters k R) (y v S : Rˣ)
    (hS : S.val = ((y * v)⁻¹ : Rˣ).val) :
    dvrResidueValue d S.val =
      (dvrResidueValue d y.val * dvrResidueValue d v.val)⁻¹ := by
  rw [hS]
  change dvrResidueValue d ((y * v)⁻¹ : Rˣ).val =
    (dvrResidueValue d y.val * dvrResidueValue d v.val)⁻¹
  have hi := congrArg (dvrResidueValue d)
    (Units.inv_mul (y * v))
  simp only [map_mul, map_one, Units.val_mul] at hi
  have hn : dvrResidueValue d y.val * dvrResidueValue d v.val ≠ 0 :=
    mul_ne_zero (dvrResidueValue_unit_nonzero d y.val y.isUnit)
      (dvrResidueValue_unit_nonzero d v.val v.isUnit)
  apply mul_right_cancel₀ hn
  rw [hi, inv_mul_cancel₀ hn]

end Litt3.QuotientGeometry
