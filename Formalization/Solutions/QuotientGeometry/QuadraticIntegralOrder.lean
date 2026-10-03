import Definitions.QuotientGeometry.QuadraticIntegralOrder
import Solutions.QuotientGeometry.QuadraticIntegralCoefficients
import Solutions.QuotientGeometry.QuadraticFunctionFields
import Mathlib.RingTheory.IntegralClosure.IsIntegralClosure.Basic

namespace Litt3.QuotientGeometry

open scoped QuadraticAlgebra

theorem quadratic_order_integral_coefficients
    {R K : Type*} [CommRing R] [IsDomain R] [UniqueFactorizationMonoid R]
    [Field K] [Algebra R K] [IsFractionRing R K] [IsIntegrallyClosed R]
    (a : R) (ha : Squarefree a) (htwo : IsUnit (2 : R))
    (z : QuadraticAlgebra K (algebraMap R K a) 0) (hz : IsIntegral R z) :
    ∃ n d : R, algebraMap R K n = z.re ∧ algebraMap R K d = z.im := by
  have hstar : IsIntegral R (star z) := by
    simpa [quadraticOrderConjugation, starRingEnd_apply] using
      hz.map (quadraticOrderConjugation R K a)
  have htrace : IsIntegral R (algebraMap K
      (QuadraticAlgebra K (algebraMap R K a) 0) ((2 : K) * z.re)) := by
    convert hz.add hstar using 1
    ext <;> simp [QuadraticAlgebra.algebraMap_eq] <;> ring
  have hnorm : IsIntegral R (algebraMap K
      (QuadraticAlgebra K (algebraMap R K a) 0)
      (z.re ^ 2 - algebraMap R K a * z.im ^ 2)) := by
    convert hz.mul hstar using 1
    ext <;> simp [QuadraticAlgebra.algebraMap_eq] <;> ring
  have htr : IsIntegral R ((2 : K) * z.re) :=
    (isIntegral_algebraMap_iff QuadraticAlgebra.algebraMap_injective).mp htrace
  obtain ⟨e, he⟩ := htwo.exists_left_inv
  have heK : algebraMap R K e * (2 : K) = 1 := by
    simpa only [map_mul, map_ofNat, map_one] using congrArg (algebraMap R K) he
  have hre : IsIntegral R z.re := by
    have hei : IsIntegral R (algebraMap R K e) := isIntegral_algebraMap
    simpa only [← mul_assoc, heK, one_mul] using hei.mul htr
  have hnormK : IsIntegral R (z.re ^ 2 - algebraMap R K a * z.im ^ 2) :=
    (isIntegral_algebraMap_iff QuadraticAlgebra.algebraMap_injective).mp hnorm
  have himsq : IsIntegral R (z.im ^ 2 * algebraMap R K a) := by
    convert (hre.pow 2).sub hnormK using 1
    ring
  obtain ⟨n, hn⟩ := (isIntegrallyClosed_iff K).mp (inferInstance : IsIntegrallyClosed R) hre
  obtain ⟨d, hd⟩ := squarefree_fraction_product_integral a ha z.im himsq
  exact ⟨n, d, hn, hd⟩

/-- The genuine squarefree quadratic coordinate order is exactly the
integral closure of its base in the actual quadratic fraction algebra,
provided two is invertible. -/
theorem quadratic_order_isIntegralClosure
    {R K : Type*} [CommRing R] [IsDomain R] [UniqueFactorizationMonoid R]
    [Field K] [Algebra R K] [IsFractionRing R K] [IsIntegrallyClosed R]
    (a : R) (ha : Squarefree a) (htwo : IsUnit (2 : R)) :
    IsIntegralClosure (QuadraticAlgebra R a 0) R
      (QuadraticAlgebra K (algebraMap R K a) 0) where
  algebraMap_injective := by
    intro z w h
    have hre := congrArg QuadraticAlgebra.re h
    have him := congrArg QuadraticAlgebra.im h
    change algebraMap R K z.re = algebraMap R K w.re at hre
    change algebraMap R K z.im = algebraMap R K w.im at him
    exact QuadraticAlgebra.ext (IsFractionRing.injective R K hre)
      (IsFractionRing.injective R K him)
  isIntegral_iff := by
    intro z
    constructor
    · intro hz
      obtain ⟨n, d, hn, hd⟩ := quadratic_order_integral_coefficients a ha htwo z hz
      refine ⟨⟨n, d⟩, ?_⟩
      exact QuadraticAlgebra.ext hn hd
    · rintro ⟨y, rfl⟩
      exact (IsIntegral.of_finite R y).algebraMap

end Litt3.QuotientGeometry
