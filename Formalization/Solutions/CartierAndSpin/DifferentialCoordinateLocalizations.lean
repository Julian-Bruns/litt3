import Solutions.CartierAndSpin.FormallyEtaleDifferentialCoordinates

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k R S F : Type*} [CommRing k] [CommRing R] [CommRing S] [Field F]
  [Algebra k R] [Algebra k S] [Algebra k F] [Algebra R S] [Algebra R F] [Algebra S F]
  [IsScalarTower k R S] [IsScalarTower k R F] [IsScalarTower k S F]
  [IsScalarTower R S F]
  [Algebra.FormallyEtale R S] [Algebra.FormallyEtale R F] [Algebra.FormallyEtale S F]

/-- Direct and stalk-localized actual rank-one coordinates agree on
the entire rational universal module. No compatible-frame equation is
an input; the universal-module map composition proves it. -/
theorem formally_etale_differential_coordinate_localization
    (e : KaehlerDifferential k R ≃ₗ[R] R) (omega : KaehlerDifferential k F) :
    formallyEtaleDifferentialCoordinate (S := F)
        (formallyEtaleDifferentialCoordinate (S := S) e) omega =
      formallyEtaleDifferentialCoordinate (S := F) e omega := by
  let nu := e.symm 1
  let c := formallyEtaleDifferentialCoordinate (S := F) e omega
  have hnuF : formallyEtaleDifferentialCoordinate (S := F) e
      (KaehlerDifferential.map k k R F nu) = 1 := by
    rw [formally_etale_differential_coordinate_map]
    simp only [nu, e.apply_symm_apply, map_one]
  have hform : omega = c • KaehlerDifferential.map k k R F nu := by
    apply (formallyEtaleDifferentialCoordinate (S := F) e).injective
    rw [map_smul, hnuF, smul_eq_mul, mul_one]
  have hnuSF : formallyEtaleDifferentialCoordinate (S := F)
        (formallyEtaleDifferentialCoordinate (S := S) e)
        (KaehlerDifferential.map k k R F nu) = 1 := by
    rw [← kaehler_map_composition (k := k) (R := R) (S := S) (T := F),
      formally_etale_differential_coordinate_map, formally_etale_differential_coordinate_map]
    simp only [nu, e.apply_symm_apply, map_one]
  rw [hform, map_smul, hnuSF, smul_eq_mul, mul_one,
    map_smul, hnuF, smul_eq_mul, mul_one]

end Litt3.CartierAndSpin
