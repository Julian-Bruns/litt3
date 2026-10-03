import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
import Mathlib.AlgebraicGeometry.AffineScheme

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

variable {A R L : Type u} [CommRing A] [CommRing R] [IsDomain R]
  [Field L] [Algebra A R] [Algebra R L] [Algebra A L]
  [IsScalarTower A R L] [IsFractionRing R L]
  [IsIntegrallyClosed R] [Algebra.IsIntegral A R]

/-- A genuine normal integral coordinate algebra in its actual
fraction field IS the integral closure, via a constructed original
base-algebra equivalence. No normalization model is assumed. -/
noncomputable def actualNormalIntegralAffineNormalizationEquiv :
    R ≃ₐ[A] integralClosure A L :=
  IsIntegralClosure.equiv A R L (integralClosure A L)

/-- The constructed normalization identification preserves the
actual inclusion of every original coordinate into the original
function field. -/
theorem actualNormalIntegralAffineNormalizationEquiv_function_field (r : R) :
    algebraMap (integralClosure A L) L (actualNormalIntegralAffineNormalizationEquiv r) =
      algebraMap R L r :=
  IsIntegralClosure.algebraMap_equiv A R L (integralClosure A L) r

/-- The true affine Scheme isomorphism identifying the original
normal integral affine curve chart with its actual normalization. -/
noncomputable def actualNormalIntegralAffineNormalizationIso :
    Spec (.of R) ≅ Spec (.of (integralClosure A L)) :=
  Scheme.Spec.mapIso (actualNormalIntegralAffineNormalizationEquiv
    (A := A) (R := R) (L := L)).symm.toRingEquiv.toCommRingCatIso.op

/-- The entire original Scheme structure morphism to the original
base is respected by the actual normalization isomorphism. -/
theorem actualNormalIntegralAffineNormalizationIso_over_base :
    actualNormalIntegralAffineNormalizationIso.hom ≫
        Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L))) =
      Spec.map (CommRingCat.ofHom (algebraMap A R)) := by
  change Spec.map (CommRingCat.ofHom actualNormalIntegralAffineNormalizationEquiv.symm.toRingHom) ≫
    Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L))) = _
  rw [← Spec.map_comp]
  congr 1
  apply CommRingCat.hom_ext
  apply RingHom.ext
  intro a
  exact (actualNormalIntegralAffineNormalizationEquiv (A := A) (R := R) (L := L)).symm.commutes a

/-- The inverse genuine Scheme identification fixes the same
entire original base morphism. -/
theorem actualNormalIntegralAffineNormalizationIso_inv_over_base :
    actualNormalIntegralAffineNormalizationIso.inv ≫
        Spec.map (CommRingCat.ofHom (algebraMap A R)) =
      Spec.map (CommRingCat.ofHom (algebraMap A (integralClosure A L))) := by
  change Spec.map (CommRingCat.ofHom actualNormalIntegralAffineNormalizationEquiv.toRingHom) ≫
    Spec.map (CommRingCat.ofHom (algebraMap A R)) = _
  rw [← Spec.map_comp]
  congr 1
  apply CommRingCat.hom_ext
  apply RingHom.ext
  intro a
  exact (actualNormalIntegralAffineNormalizationEquiv (A := A) (R := R) (L := L)).commutes a

end Litt3.QuotientGeometry
