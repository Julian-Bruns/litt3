import Solutions.Jacobians.ActualFractionalIdealTensorSheaves
import Solutions.Jacobians.DedekindAffineSectionSheaves

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry TensorProduct
open scoped nonZeroDivisors TensorProduct
open IsDedekindDomain

namespace Litt3.Jacobians

universe u
variable (R : Type u) [CommRing R] [IsDedekindDomain R]

/-- Adding actual normalized affine divisors gives the genuine tensor
SHEAF of their actual ideal sheaves, with the literal O(-D) convention. -/
noncomputable def actualDedekindAffineDivisorTensorSheafIso
    (D E : Divisor (HeightOneSpectrum R)) :
    actualTildeTensorSheaf (dedekindAffineDivisorModule R D)
      (dedekindAffineDivisorModule R E) ≅ dedekindAffineDivisorSheaf R (D + E) := by
  change actualTildeTensorSheaf
    (actualFractionalIdealModule (dedekindDivisorIdealMap R (FractionRing R) D).toMul)
    (actualFractionalIdealModule (dedekindDivisorIdealMap R (FractionRing R) E).toMul) ≅
    (actualFractionalIdealModule (dedekindDivisorIdealMap R (FractionRing R) (D + E)).toMul).tilde
  have h := congrArg Additive.toMul (map_add (dedekindDivisorIdealMap R (FractionRing R)) D E)
  change (dedekindDivisorIdealMap R (FractionRing R) (D + E)).toMul =
    (dedekindDivisorIdealMap R (FractionRing R) D).toMul *
      (dedekindDivisorIdealMap R (FractionRing R) E).toMul at h
  rw [h]
  exact actualFractionalIdealTensorSheafProductIso _ _

/-- The usual O(D) sign convention respects genuine tensor products
as an isomorphism of original module SHEAVES, on the full open site. -/
noncomputable def actualDedekindAffineSectionTensorSheafIso
    (D E : Divisor (HeightOneSpectrum R)) :
    actualTildeTensorSheaf (dedekindAffineSectionModule R D)
      (dedekindAffineSectionModule R E) ≅ dedekindAffineSectionSheaf R (D + E) := by
  simpa only [dedekindAffineSectionModule, dedekindAffineSectionSheaf,
    dedekindAffineDivisorSheaf, neg_add] using
      actualDedekindAffineDivisorTensorSheafIso R (-D) (-E)

/-- The actual zero divisor gives the actual structure-sheaf unit. -/
noncomputable def actualDedekindAffineZeroDivisorUnitIso :
    dedekindAffineDivisorSheaf R 0 ≅
      SheafOfModules.unit (Spec (.of R)).ringCatSheaf := by
  change (actualFractionalIdealModule
    (dedekindDivisorIdealMap R (FractionRing R) 0).toMul).tilde ≅ _
  rw [map_zero]
  exact actualFractionalIdealUnitSheafIso

/-- The actual sheaves O(D) and O(-D) are inverse under their actual
tensor SHEAF product. No abstract Picard-class equality is substituted. -/
noncomputable def actualDedekindAffineSectionInverseTensorUnitIso
    (D : Divisor (HeightOneSpectrum R)) :
    actualTildeTensorSheaf (dedekindAffineSectionModule R D)
      (dedekindAffineSectionModule R (-D)) ≅
        SheafOfModules.unit (Spec (.of R)).ringCatSheaf :=
  actualDedekindAffineSectionTensorSheafIso R D (-D) ≪≫
    (by simpa [dedekindAffineSectionSheaf, dedekindAffineSectionModule,
      dedekindAffineDivisorSheaf] using actualDedekindAffineZeroDivisorUnitIso R)

end Litt3.Jacobians
