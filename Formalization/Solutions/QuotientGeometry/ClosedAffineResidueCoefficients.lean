import Definitions.QuotientGeometry.DVRCompletionParameters
import Mathlib.RingTheory.LocalRing.ResidueField.Ideal
import Mathlib.RingTheory.Jacobson.Ring
import Mathlib.FieldTheory.IsAlgClosed.Basic

namespace Litt3.QuotientGeometry

variable {k R : Type*} [Field k] [IsAlgClosed k] [CommRing R]
  [Algebra k R] [Algebra.FiniteType k R]

/-- The actual residue field at a closed affine point of a finite-type
algebra over an algebraically closed field has every coefficient in
the original base field. This follows from the actual quotient and
Zariski's lemma, rather than a supplied residue-field equivalence. -/
theorem closed_affine_residue_coefficients_surjective
    (P : Ideal R) [P.IsMaximal] :
    Function.Surjective (algebraMap k P.ResidueField) := by
  letI := Ideal.Quotient.field P
  letI : Module.Finite k (R ⧸ P) := finite_of_finite_type_of_isJacobsonRing k (R ⧸ P)
  haveI : IsScalarTower k (R ⧸ P) P.ResidueField :=
    IsScalarTower.of_algebraMap_eq fun a => by
      change algebraMap k P.ResidueField a =
        algebraMap (R ⧸ P) P.ResidueField (Ideal.Quotient.mk P (algebraMap k R a))
      rw [Ideal.algebraMap_quotient_residueField_mk]
      exact IsScalarTower.algebraMap_apply k R P.ResidueField a
  haveI : Module.Finite k P.ResidueField := Module.Finite.of_surjective
    (IsScalarTower.toAlgHom k (R ⧸ P) P.ResidueField).toLinearMap
    (Ideal.bijective_algebraMap_quotient_residueField P).2
  exact (IsAlgClosed.algebraMap_bijective_of_isIntegral (k := k)).2

/-- Any actual local parameter at the closed affine DVR point gives
the complete coefficient/parameter data; residue surjectivity is
derived from the original finite-type coordinate algebra. -/
noncomputable def closedAffineDVRParameters
    (P : Ideal R) [P.IsMaximal] [IsDomain (Localization.AtPrime P)]
    [IsDiscreteValuationRing (Localization.AtPrime P)]
    (t : Localization.AtPrime P) (ht : Irreducible t) :
    DVRCompletionParameters k (Localization.AtPrime P) :=
  ⟨t, ht, closed_affine_residue_coefficients_surjective P⟩

end Litt3.QuotientGeometry
