import Solutions.QuotientGeometry.QuadraticIntegralOrder
import Mathlib.RingTheory.DedekindDomain.IntegralClosure
import Mathlib.FieldTheory.SeparableClosure

namespace Litt3.QuotientGeometry

open scoped QuadraticAlgebra

theorem quadratic_field_separable
    {K : Type*} [Field K] (a : K) (ha : a ≠ 0) (htwo : (2 : K) ≠ 0)
    [Fact (∀ r : K, r ^ 2 ≠ a + 0 * r)] :
    Algebra.IsSeparable K (QuadraticAlgebra K a 0) := by
  let θ : QuadraticAlgebra K a 0 := QuadraticAlgebra.omega
  have hpoly : (Polynomial.X ^ 2 - Polynomial.C a : Polynomial K).Separable :=
    Polynomial.separable_X_pow_sub_C a htwo ha
  have hroot : Polynomial.aeval θ
      (Polynomial.X ^ 2 - Polynomial.C a : Polynomial K) = (0 : QuadraticAlgebra K a 0) := by
    ext <;> simp [θ, QuadraticAlgebra.omega, pow_two]
  have hθ : IsSeparable K θ := hpoly.of_dvd (minpoly.dvd K θ hroot)
  constructor
  intro z
  have hz : z = algebraMap K (QuadraticAlgebra K a 0) z.re +
      algebraMap K (QuadraticAlgebra K a 0) z.im * θ := by
    ext <;> simp [θ, QuadraticAlgebra.omega, QuadraticAlgebra.algebraMap_eq]
  rw [hz]
  exact Field.isSeparable_add (isSeparable_algebraMap _)
    (Field.isSeparable_mul (isSeparable_algebraMap _) hθ)

/-- Every squarefree nonunit quadratic order with two invertible over a
Dedekind unique factorization domain is a genuine Dedekind domain. Its
actual quadratic fraction field and integral-closure identification are
constructed in the proof. -/
theorem quadratic_order_isDedekindDomain
    {R K : Type*} [CommRing R] [IsDedekindDomain R] [UniqueFactorizationMonoid R]
    [Field K] [Algebra R K] [IsFractionRing R K]
    (a : R) (ha : Squarefree a) (hnonunit : ¬ IsUnit a) (htwo : IsUnit (2 : R)) :
    IsDedekindDomain (QuadraticAlgebra R a 0) := by
  haveI : Fact (∀ r : K, r ^ 2 ≠ algebraMap R K a + 0 * r) := ⟨by
    intro r
    simpa only [zero_mul, add_zero] using
      squarefree_nonunit_nonsquare_in_fraction_field a ha hnonunit r⟩
  let L := QuadraticAlgebra K (algebraMap R K a) 0
  letI : Field L := inferInstance
  letI : Algebra (QuadraticAlgebra R a 0) L := quadraticOrderFractionAlgebra R K a
  haveI : IsScalarTower R (QuadraticAlgebra R a 0) L := quadraticOrderFractionTower R K a
  haveI : IsIntegralClosure (QuadraticAlgebra R a 0) R L :=
    quadratic_order_isIntegralClosure a ha htwo
  haveI : IsDomain (QuadraticAlgebra R a 0) :=
    Function.Injective.isDomain (algebraMap (QuadraticAlgebra R a 0) L)
      (IsIntegralClosure.algebraMap_injective (QuadraticAlgebra R a 0) R L)
  have haK : algebraMap R K a ≠ 0 := by
    simpa only [map_zero] using (IsFractionRing.injective R K).ne ha.ne_zero
  have htwoK : (2 : K) ≠ 0 := by
    have hu := htwo.map (algebraMap R K)
    simpa only [map_ofNat] using hu.ne_zero
  haveI : Algebra.IsSeparable K L := quadratic_field_separable _ haK htwoK
  exact IsIntegralClosure.isDedekindDomain R K L (QuadraticAlgebra R a 0)

end Litt3.QuotientGeometry
