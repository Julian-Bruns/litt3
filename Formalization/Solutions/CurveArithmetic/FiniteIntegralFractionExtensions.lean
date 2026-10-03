import Mathlib.RingTheory.FiniteType
import Mathlib.RingTheory.Localization.Integral
import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic

namespace Litt3.CurveArithmetic

variable {A R K L : Type*} [CommRing A] [CommRing R] [IsDomain R]
  [Field K] [Field L] [Algebra A R] [Algebra A K] [Algebra A L]
  [Algebra R L] [Algebra K L] [IsScalarTower A R L] [IsScalarTower A K L]
  [IsFractionRing R L] [Algebra.FiniteType A R] [Algebra.IsIntegral A R]

include A R

/-- The genuine fraction field of an integral finite-type algebra
is finite over ANY actual intermediate coefficient field containing
the base-ring image. Neither a chosen basis nor computation is used. -/
theorem actual_integral_finite_type_fraction_extension_finite :
    FiniteDimensional K L := by
  letI : Algebra.IsAlgebraic K L := isAlgebraic_of_isFractionRing (R := A) (S := R) K L
  obtain ⟨s, hs⟩ := Algebra.FiniteType.out (R := A) (A := R)
  let t : Set L := (algebraMap R L) '' (↑s : Set R)
  let E : IntermediateField K L := IntermediateField.adjoin K t
  have hR : ∀ r : R, algebraMap R L r ∈ E := by
    have hle : Algebra.adjoin A (↑s : Set R) ≤
        (E.toSubalgebra.restrictScalars A).comap (IsScalarTower.toAlgHom A R L) := by
      apply Algebra.adjoin_le
      intro r hr
      exact IntermediateField.subset_adjoin K t ⟨r, hr, rfl⟩
    rw [hs] at hle
    intro r
    exact hle (by trivial)
  have htop : E = ⊤ := by
    apply top_unique
    intro x _
    obtain ⟨n, d, _, hnd⟩ := IsFractionRing.div_surjective (A := R) x
    rw [← hnd]
    exact E.div_mem (hR n) (hR d)
  letI : Finite t := (s.finite_toSet.image (algebraMap R L)).to_subtype
  letI : FiniteDimensional K E := IntermediateField.finiteDimensional_adjoin
    (fun x _ => Algebra.IsIntegral.isIntegral x)
  rw [htop] at this
  exact IntermediateField.topEquiv.toLinearEquiv.finiteDimensional

end Litt3.CurveArithmetic
