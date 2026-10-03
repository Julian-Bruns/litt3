import Definitions.QuotientGeometry.ConstantPolynomialParameter
import Solutions.QuotientGeometry.ParameterLaurentImages
import Solutions.QuotientGeometry.LaurentPoleCoordinates
import Solutions.QuotientGeometry.FiniteParameterDimension

namespace Litt3.QuotientGeometry

theorem constant_polynomial_unit_constant
    {k : Type*} [Field k] (g : Polynomial k) :
    PowerSeries.constantCoeff (constantPolynomialUnit g) = g.leadingCoeff := by
  rw [constantPolynomialUnit, Polynomial.hom_eval₂]
  simp

theorem constant_polynomial_parameter_zero
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) :
    PowerSeries.constantCoeff (constantPolynomialParameter g) = 0 := by
  simp [constantPolynomialParameter, hg.ne']

theorem constant_polynomial_parameter_injective
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) :
    Function.Injective (PowerSeries.subst (constantPolynomialParameter g) :
      PowerSeries k → PowerSeries k) := by
  apply finite_parameter_substitution_injective g.natDegree hg (constantPolynomialParameter g)
    (constantPolynomialUnit g)⁻¹ rfl
  rw [PowerSeries.constantCoeff_inv, constant_polynomial_unit_constant]
  apply inv_ne_zero
  exact Polynomial.leadingCoeff_ne_zero.mpr (by intro hz; simp [hz] at hg)

theorem constant_polynomial_parameter_inverse
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) :
    (constantPolynomialParameter g : LaurentSeries k)⁻¹ =
      g.eval₂ HahnSeries.C (HahnSeries.single (-1) 1) := by
  have hleading : g.leadingCoeff ≠ 0 :=
    Polynomial.leadingCoeff_ne_zero.mpr (by intro hz; simp [hz] at hg)
  let v : LaurentSeries k := HahnSeries.single (-1) 1
  let x : LaurentSeries k := HahnSeries.single 1 1
  have hv : v ≠ 0 := HahnSeries.single_ne_zero one_ne_zero
  letI : Invertible v := invertibleOfNonzero hv
  have hvinv : ⅟v = x := by simp [v, x, invOf_eq_inv, HahnSeries.inv_single]
  have hc : (constantPolynomialUnit g : LaurentSeries k) = g.reverse.eval₂ HahnSeries.C x := by
    rw [constantPolynomialUnit, Polynomial.hom_eval₂]
    have hcomp : (HahnSeries.ofPowerSeries ℤ k).comp PowerSeries.C = HahnSeries.C := by
      apply RingHom.ext
      intro a
      exact PowerSeries.coe_C a
    rw [hcomp]
    rw [show (HahnSeries.ofPowerSeries ℤ k) PowerSeries.X = x from PowerSeries.coe_X]
  rw [constantPolynomialParameter, PowerSeries.coe_mul, PowerSeries.coe_pow,
    PowerSeries.coe_X, power_series_coe_inverse _ (by rw [constant_polynomial_unit_constant]; exact hleading),
    mul_inv_rev, inv_inv]
  change (constantPolynomialUnit g : LaurentSeries k) * (x ^ g.natDegree)⁻¹ = _
  have hxinv : x⁻¹ = v := by simp [v, x, HahnSeries.inv_single]
  rw [← inv_pow, hxinv, hc]
  have h := Polynomial.eval₂_reverse_mul_pow (HahnSeries.C : k →+* LaurentSeries k) v g
  rwa [hvinv] at h

theorem constant_polynomial_parameter_pole_image
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) :
    parameterLaurentMap (constantPolynomialParameter g) (constant_polynomial_parameter_zero g hg)
      (constant_polynomial_parameter_injective g hg) (HahnSeries.single (-1) 1) =
      g.eval₂ HahnSeries.C (HahnSeries.single (-1) 1) := by
  rw [parameter_laurent_map_pole, HahnSeries.C_one, one_mul,
    constant_polynomial_parameter_inverse g hg]

end Litt3.QuotientGeometry
