import Solutions.QuotientGeometry.AffineChartMapSquares
import Solutions.QuotientGeometry.LocalizedCoefficientBaseMaps

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X Y : Scheme.{u}}
  (f : X ⟶ Y) (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
  (hover : f ≫ sY = sX) (U : Y.Opens)
  (hU : IsAffineOpen U) (hV : IsAffineOpen (f ⁻¹ᵁ U)) (x : f ⁻¹ᵁ U)

/-- The actual original chart map induces its genuine coefficient
localization map at the two actual chart primes. -/
noncomputable def actualAffineChartLocalizedBaseMap :
    letI := (chartBaseFieldHom sY U).toAlgebra
    letI := (chartBaseFieldHom sX (f ⁻¹ᵁ U)).toAlgebra
    Localization.AtPrime (hU.primeIdealOf ⟨f x, x.property⟩).asIdeal →ₐ[k]
      Localization.AtPrime (hV.primeIdealOf x).asIdeal := by
  letI := (chartBaseFieldHom sY U).toAlgebra
  letI := (chartBaseFieldHom sX (f ⁻¹ᵁ U)).toAlgebra
  letI := (f.app U).hom.toAlgebra
  letI : IsScalarTower k Γ(Y, U) Γ(X, f ⁻¹ᵁ U) :=
    IsScalarTower.of_algebraMap_eq'
      (actual_affine_chart_pullback_coefficient_square f sX sY hover U).symm
  exact localizedCoefficientBaseMap (k := k)
    (hU.primeIdealOf ⟨f x, x.property⟩).asIdeal (hV.primeIdealOf x).asIdeal
    (congrArg PrimeSpectrum.asIdeal
      (actual_affine_chart_prime_comap f U hU hV x).symm)

theorem actualAffineChartLocalizedBaseMap_ring (a : Γ(Y, U)) :
    letI := (chartBaseFieldHom sY U).toAlgebra
    letI := (chartBaseFieldHom sX (f ⁻¹ᵁ U)).toAlgebra
    actualAffineChartLocalizedBaseMap f sX sY hover U hU hV x
      (algebraMap Γ(Y, U)
        (Localization.AtPrime (hU.primeIdealOf ⟨f x, x.property⟩).asIdeal) a) =
      algebraMap Γ(X, f ⁻¹ᵁ U) (Localization.AtPrime (hV.primeIdealOf x).asIdeal)
        (f.app U a) := by
  letI := (chartBaseFieldHom sY U).toAlgebra
  letI := (chartBaseFieldHom sX (f ⁻¹ᵁ U)).toAlgebra
  letI := (f.app U).hom.toAlgebra
  letI : IsScalarTower k Γ(Y, U) Γ(X, f ⁻¹ᵁ U) :=
    IsScalarTower.of_algebraMap_eq'
      (actual_affine_chart_pullback_coefficient_square f sX sY hover U).symm
  exact localizedCoefficientBaseMap_ring
    (hU.primeIdealOf ⟨f x, x.property⟩).asIdeal (hV.primeIdealOf x).asIdeal _ a

instance actualAffineChartLocalizedBaseMap_isLocal :
    letI := (chartBaseFieldHom sY U).toAlgebra
    letI := (chartBaseFieldHom sX (f ⁻¹ᵁ U)).toAlgebra
    IsLocalHom
      (actualAffineChartLocalizedBaseMap f sX sY hover U hU hV x).toRingHom := by
  letI := (chartBaseFieldHom sY U).toAlgebra
  letI := (chartBaseFieldHom sX (f ⁻¹ᵁ U)).toAlgebra
  letI := (f.app U).hom.toAlgebra
  letI : IsScalarTower k Γ(Y, U) Γ(X, f ⁻¹ᵁ U) :=
    IsScalarTower.of_algebraMap_eq'
      (actual_affine_chart_pullback_coefficient_square f sX sY hover U).symm
  exact localizedCoefficientBaseMap_isLocal _ _ _

end Litt3.QuotientGeometry
