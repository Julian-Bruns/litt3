import Definitions.CartierAndSpin.LogarithmicDifferentials

namespace Litt3.CartierAndSpin

/-- The genuine k-linear universal differential map induced by an
ACTUAL k-algebra homomorphism, with its scalar tower constructed from
the homomorphism's literal coefficient compatibility. -/
noncomputable def actualAlgebraDifferentialMap
    {k R S : Type*} [CommRing k] [CommRing R] [CommRing S]
    [Algebra k R] [Algebra k S] (f : R →ₐ[k] S) :
    KaehlerDifferential k R →ₗ[k] KaehlerDifferential k S := by
  letI := f.toRingHom.toAlgebra
  letI : IsScalarTower k R S := IsScalarTower.of_algebraMap_eq' (by
    ext a
    exact (f.commutes a).symm)
  exact (KaehlerDifferential.map k k R S).restrictScalars k

end Litt3.CartierAndSpin
