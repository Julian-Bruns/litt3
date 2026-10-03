import Definitions.CartierAndSpin.ActualFieldDifferentialMaps
import Solutions.CartierAndSpin.LogarithmicDifferentialPullbacks

namespace Litt3.CartierAndSpin

open Litt3.Jacobians

/-- The actual universal map carries the ORIGINAL universal derivative
to the derivative of the literal algebra-homomorphic image. -/
theorem actual_algebra_differential_map_derivative
    {k R S : Type*} [CommRing k] [CommRing R] [CommRing S]
    [Algebra k R] [Algebra k S] (f : R →ₐ[k] S) (r : R) :
    actualAlgebraDifferentialMap f (KaehlerDifferential.D k R r) =
      KaehlerDifferential.D k S (f r) := by
  letI := f.toRingHom.toAlgebra
  letI : IsScalarTower k R S := IsScalarTower.of_algebraMap_eq' (by
    ext a
    exact (f.commutes a).symm)
  exact KaehlerDifferential.map_D k k R S r

/-- The real logarithmic map commutes with an arbitrary actual field
algebra homomorphism. No separability or characteristic hypothesis is
required. -/
theorem actual_algebra_differential_map_logarithm
    {k R S : Type*} [Field k] [Field R] [Field S]
    [Algebra k R] [Algebra k S] (f : R →ₐ[k] S) (u : Additive Rˣ) :
    actualAlgebraDifferentialMap f (rationalLogarithmicDifferential k R u) =
      rationalLogarithmicDifferential k S (rationalUnitPullback f.toRingHom u) := by
  letI := f.toRingHom.toAlgebra
  letI : IsScalarTower k R S := IsScalarTower.of_algebraMap_eq' (by
    ext a
    exact (f.commutes a).symm)
  exact (rational_logarithmic_differential_pullback (k := k) (F := R) (E := S) u).symm

/-- Commutation of ACTUAL field homomorphisms induces commutation of
the literal unit maps. No unit-map compatibility is supplied. -/
theorem actual_unit_pullback_diagram
    {F E F' E' : Type*} [Field F] [Field E] [Field F'] [Field E']
    (phi : F →+* E) (phi' : F' →+* E')
    (a : E →+* E') (b : F →+* F')
    (hphi : ∀ x, a (phi x) = phi' (b x)) (u : Additive Fˣ) :
    rationalUnitPullback a (rationalUnitPullback phi u) =
      rationalUnitPullback phi' (rationalUnitPullback b u) := by
  apply Additive.toMul.injective
  apply Units.ext
  exact hphi ((u.toMul : Fˣ) : F)

end Litt3.CartierAndSpin
