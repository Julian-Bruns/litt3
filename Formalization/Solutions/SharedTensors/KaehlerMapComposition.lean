import Mathlib.RingTheory.Kaehler.Basic

namespace Litt3.SharedTensors

/-- Universal differential maps compose through the actual ring tower,
on the ENTIRE original universal module. -/
theorem kaehler_map_composition
    {k R S T : Type*} [CommRing k] [CommRing R] [CommRing S] [CommRing T]
    [Algebra k R] [Algebra k S] [Algebra k T]
    [Algebra R S] [Algebra R T] [Algebra S T]
    [IsScalarTower k R S] [IsScalarTower k R T]
    [IsScalarTower k S T] [IsScalarTower R S T]
    (omega : KaehlerDifferential k R) :
    KaehlerDifferential.map k k S T (KaehlerDifferential.map k k R S omega) =
      KaehlerDifferential.map k k R T omega := by
  let left : KaehlerDifferential k R →ₗ[R] KaehlerDifferential k T :=
    ((KaehlerDifferential.map k k S T).restrictScalars R).comp
      (KaehlerDifferential.map k k R S)
  have h : left = KaehlerDifferential.map k k R T := by
    apply Derivation.liftKaehlerDifferential_unique
    ext a
    change KaehlerDifferential.map k k S T
        (KaehlerDifferential.map k k R S (KaehlerDifferential.D k R a)) =
      KaehlerDifferential.map k k R T (KaehlerDifferential.D k R a)
    rw [KaehlerDifferential.map_D, KaehlerDifferential.map_D,
      KaehlerDifferential.map_D, ← IsScalarTower.algebraMap_apply R S T]
  exact LinearMap.congr_fun h omega

end Litt3.SharedTensors
