import Solutions.QuotientGeometry.SpecStalkBaseMaps
import Solutions.QuotientGeometry.SchemeFixedBaseStalkMap

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

variable {k A R : Type u} [Field k] [CommRing A] [CommRing R]
  [Algebra k A] [Algebra A R] [Algebra k R] [IsScalarTower k A R]

/-- The true affine stalk map at any point over a fixed actual base
point agrees, on the whole stalk, with the genuine coordinate-ring
localization map over that same fixed prime. -/
theorem actual_spec_fixed_base_stalk_map_localization
    (J : PrimeSpectrum A) (P : PrimeSpectrum R)
    (hJP : J = Spec.map (CommRingCat.ofHom (algebraMap A R)) P) :
    let f := Spec.map (CommRingCat.ofHom (algebraMap A R))
    let sA := actualAffineStructureMap (k := k) (A := A)
    let sR := actualAffineStructureMap (k := k) (A := R)
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sA J).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sR P).toAlgebra
    (actualSpecStalkCoefficientAlgEquiv (k := k) P).toAlgHom.comp
        (actualSchemeFixedBaseStalkMap f sR sA actual_affine_structure_map_square J P hJP) =
      (localizedCoefficientBaseMap (k := k) J.asIdeal P.asIdeal
        (congrArg PrimeSpectrum.asIdeal hJP)).comp
        (actualSpecStalkCoefficientAlgEquiv (k := k) J).toAlgHom := by
  subst J
  simpa [actualSchemeFixedBaseStalkMap, actualSchemeStalkPointAlgEquiv] using
    actual_spec_stalk_base_map_localization (k := k) (A := A) P

/-- Injectivity of the original coordinate-ring inclusion implies
injectivity of the genuine original affine Scheme stalk map. -/
theorem actual_spec_fixed_base_stalk_map_injective [IsDomain R]
    (J : PrimeSpectrum A) (P : PrimeSpectrum R)
    (hJP : J = Spec.map (CommRingCat.ofHom (algebraMap A R)) P)
    (hi : Function.Injective (algebraMap A R)) :
    let f := Spec.map (CommRingCat.ofHom (algebraMap A R))
    let sA := actualAffineStructureMap (k := k) (A := A)
    let sR := actualAffineStructureMap (k := k) (A := R)
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sA J).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sR P).toAlgebra
    Function.Injective
      (actualSchemeFixedBaseStalkMap f sR sA actual_affine_structure_map_square J P hJP) := by
  let f := Spec.map (CommRingCat.ofHom (algebraMap A R))
  let sA := actualAffineStructureMap (k := k) (A := A)
  let sR := actualAffineStructureMap (k := k) (A := R)
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sA J).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sR P).toAlgebra
  let χ := actualSchemeFixedBaseStalkMap f sR sA actual_affine_structure_map_square J P hJP
  let θ := localizedCoefficientBaseMap (k := k) J.asIdeal P.asIdeal
    (congrArg PrimeSpectrum.asIdeal hJP)
  let eJ := actualSpecStalkCoefficientAlgEquiv (k := k) J
  let eP := actualSpecStalkCoefficientAlgEquiv (k := k) P
  have hc := actual_spec_fixed_base_stalk_map_localization (k := k) J P hJP
  have hiθ : Function.Injective θ := localizedCoefficientBaseMap_injective
    hi J.asIdeal P.asIdeal (congrArg PrimeSpectrum.asIdeal hJP)
  change Function.Injective χ
  intro a b hab
  apply eJ.injective
  apply hiθ
  have ha : eP (χ a) = θ (eJ a) := AlgHom.congr_fun hc a
  have hb : eP (χ b) = θ (eJ b) := AlgHom.congr_fun hc b
  exact ha.symm.trans ((congrArg eP hab).trans hb)

end Litt3.QuotientGeometry
