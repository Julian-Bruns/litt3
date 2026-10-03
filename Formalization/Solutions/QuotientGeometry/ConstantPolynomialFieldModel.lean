import Solutions.QuotientGeometry.ConstantPoleIrreducibility
import Solutions.QuotientGeometry.ConstantPolynomialParameter
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.QuotientGeometry

/-- The entire original Laurent field over the actual constant
polynomial of its pole-one coordinate is the genuine universal root
field. Reciprocal Eisenstein and the actual parameter span prove the
identification, without a generation or degree assumption. -/
theorem constant_polynomial_laurent_field_model
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) (hzero : g.coeff 0 = 0) :
    ∃ e : AdjoinRoot (constantPolePolynomial g) ≃+* LaurentSeries k,
      ∀ r : LaurentSeries k,
        e (AdjoinRoot.of (constantPolePolynomial g) r) =
          parameterLaurentMap (constantPolynomialParameter g) (constant_polynomial_parameter_zero g hg)
            (constant_polynomial_parameter_injective g hg) r := by
  have hirred := constant_pole_polynomial_irreducible g hg hzero
  haveI : Fact (Irreducible (constantPolePolynomial g)) := ⟨hirred⟩
  let E := AdjoinRoot (constantPolePolynomial g)
  letI : Field E := inferInstance
  let AE : Algebra (LaurentSeries k) E := inferInstance
  letI : Algebra (LaurentSeries k) E := AE
  letI : SMul (LaurentSeries k) E := AE.toSMul
  letI : Module (LaurentSeries k) E := Algebra.toModule
  have hEmap : algebraMap (LaurentSeries k) E = AdjoinRoot.of (constantPolePolynomial g) :=
    AdjoinRoot.algebraMap_eq _
  let pb := AdjoinRoot.powerBasis hirred.ne_zero
  haveI : FiniteDimensional (LaurentSeries k) E := Module.Finite.of_basis pb.basis
  have hsource : Module.finrank (LaurentSeries k) E = g.natDegree := by
    exact pb.finrank.trans (constant_pole_polynomial_degree g hg)
  let b := constantPolynomialParameter g
  let Φ := parameterLaurentMap b (constant_polynomial_parameter_zero g hg)
    (constant_polynomial_parameter_injective g hg)
  letI : Algebra (LaurentSeries k) (LaurentSeries k) := Φ.toAlgebra
  letI : SMul (LaurentSeries k) (LaurentSeries k) := Φ.toAlgebra.toSMul
  letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
  have hc : PowerSeries.constantCoeff (constantPolynomialUnit g)⁻¹ ≠ 0 := by
    rw [PowerSeries.constantCoeff_inv, constant_polynomial_unit_constant]
    exact inv_ne_zero (Polynomial.leadingCoeff_ne_zero.mpr (by intro hz; simp [hz] at hg))
  have hdim : FiniteDimensional (LaurentSeries k) (LaurentSeries k) ∧
      Module.finrank (LaurentSeries k) (LaurentSeries k) ≤ g.natDegree :=
    finite_parameter_laurent_dimension g.natDegree hg b (constantPolynomialUnit g)⁻¹ rfl hc
      (constant_polynomial_parameter_zero g hg) (constant_polynomial_parameter_injective g hg)
  haveI : FiniteDimensional (LaurentSeries k) (LaurentSeries k) := hdim.1
  have hcomp : Φ.comp HahnSeries.C = (HahnSeries.C : k →+* LaurentSeries k) := by
    apply RingHom.ext
    intro a
    exact parameter_laurent_map_constant b (constant_polynomial_parameter_zero g hg)
      (constant_polynomial_parameter_injective g hg) a
  let v : LaurentSeries k := HahnSeries.single (-1) 1
  have hroot : (constantPolePolynomial g).eval₂ Φ v = 0 := by
    rw [constantPolePolynomial, Polynomial.eval₂_sub, Polynomial.eval₂_map,
      Polynomial.eval₂_C, hcomp, constant_polynomial_parameter_pole_image g hg]
    exact sub_self _
  let f : E →ₐ[LaurentSeries k] LaurentSeries k :=
    { __ := AdjoinRoot.lift Φ v hroot
      commutes' := fun r => by
        change AdjoinRoot.lift Φ v hroot (algebraMap (LaurentSeries k) E r) = Φ r
        rw [hEmap]
        exact AdjoinRoot.lift_of hroot }
  have hlower : Module.finrank (LaurentSeries k) E ≤
      Module.finrank (LaurentSeries k) (LaurentSeries k) :=
    LinearMap.finrank_le_finrank_of_injective (f := f.toLinearMap) f.injective
  have heq : Module.finrank (LaurentSeries k) E =
      Module.finrank (LaurentSeries k) (LaurentSeries k) := by
    apply Nat.le_antisymm hlower
    rw [hsource]
    exact hdim.2
  have hsurj : Function.Surjective f :=
    (LinearMap.injective_iff_surjective_of_finrank_eq_finrank heq (f := f.toLinearMap)).mp f.injective
  let e := AlgEquiv.ofBijective f ⟨f.injective, hsurj⟩
  refine ⟨e.toRingEquiv, ?_⟩
  intro r
  have h := e.commutes r
  rw [hEmap] at h
  exact h

end Litt3.QuotientGeometry
