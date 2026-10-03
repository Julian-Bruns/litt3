import Solutions.QuotientGeometry.ConstantPolynomialFieldModel
import Solutions.QuotientGeometry.ConstantPoleFieldTransport

namespace Litt3.QuotientGeometry

theorem constant_polynomial_laurent_field_model_with_generator
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) (hzero : g.coeff 0 = 0) :
    ∃ e : AdjoinRoot (constantPolePolynomial g) ≃+* LaurentSeries k,
      (∀ r : LaurentSeries k, e (AdjoinRoot.of (constantPolePolynomial g) r) =
        parameterLaurentMap (constantPolynomialParameter g) (constant_polynomial_parameter_zero g hg)
          (constant_polynomial_parameter_injective g hg) r) ∧
      e (AdjoinRoot.root (constantPolePolynomial g)) = HahnSeries.single (-1) 1 := by
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
  have hsource : Module.finrank (LaurentSeries k) E = g.natDegree :=
    pb.finrank.trans (constant_pole_polynomial_degree g hg)
  obtain ⟨e₀, he₀⟩ := constant_polynomial_laurent_field_model g hg hzero
  let Φ := parameterLaurentMap (constantPolynomialParameter g) (constant_polynomial_parameter_zero g hg)
    (constant_polynomial_parameter_injective g hg)
  have htarget := constant_pole_field_model_degree g hg hzero Φ e₀ he₀
  letI : Algebra (LaurentSeries k) (LaurentSeries k) := Φ.toAlgebra
  letI : SMul (LaurentSeries k) (LaurentSeries k) := Φ.toAlgebra.toSMul
  letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
  haveI : FiniteDimensional (LaurentSeries k) (LaurentSeries k) := htarget.1
  have hcomp : Φ.comp HahnSeries.C = (HahnSeries.C : k →+* LaurentSeries k) := by
    apply RingHom.ext
    intro a
    exact parameter_laurent_map_constant _ (constant_polynomial_parameter_zero g hg)
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
  have heq : Module.finrank (LaurentSeries k) E =
      Module.finrank (LaurentSeries k) (LaurentSeries k) := hsource.trans htarget.2.symm
  have hsurj : Function.Surjective f :=
    (LinearMap.injective_iff_surjective_of_finrank_eq_finrank heq (f := f.toLinearMap)).mp f.injective
  let e := AlgEquiv.ofBijective f ⟨f.injective, hsurj⟩
  refine ⟨e.toRingEquiv, ?_, ?_⟩
  · intro r
    have h := e.commutes r
    rw [hEmap] at h
    exact h
  · change AdjoinRoot.lift Φ v hroot (AdjoinRoot.root (constantPolePolynomial g)) = v
    exact AdjoinRoot.lift_root hroot

/-- The downstairs image and the actual pole generator determine
ring maps on the whole parameter field, without continuity inputs. -/
theorem constant_polynomial_parameter_maps_ext
    {k A : Type*} [Field k] [Semiring A]
    (g : Polynomial k) (hg : 0 < g.natDegree) (hzero : g.coeff 0 = 0)
    (φ χ : LaurentSeries k →+* A)
    (hbase : φ.comp (parameterLaurentMap (constantPolynomialParameter g)
      (constant_polynomial_parameter_zero g hg) (constant_polynomial_parameter_injective g hg)) =
        χ.comp (parameterLaurentMap (constantPolynomialParameter g)
          (constant_polynomial_parameter_zero g hg) (constant_polynomial_parameter_injective g hg)))
    (hpole : φ (HahnSeries.single (-1) 1) = χ (HahnSeries.single (-1) 1)) : φ = χ := by
  obtain ⟨e, he, hgen⟩ := constant_polynomial_laurent_field_model_with_generator g hg hzero
  have hcompose : φ.comp e.toRingHom = χ.comp e.toRingHom := by
    apply AdjoinRoot.ringHom_ext
    · apply RingHom.ext
      intro r
      change φ (e (AdjoinRoot.of _ r)) = χ (e (AdjoinRoot.of _ r))
      rw [he]
      exact congr_fun (congrArg DFunLike.coe hbase) r
    · change φ (e (AdjoinRoot.root _)) = χ (e (AdjoinRoot.root _))
      rw [hgen]
      exact hpole
  apply RingHom.ext
  intro a
  obtain ⟨x, rfl⟩ := e.surjective a
  exact congr_fun (congrArg DFunLike.coe hcompose) x

end Litt3.QuotientGeometry
