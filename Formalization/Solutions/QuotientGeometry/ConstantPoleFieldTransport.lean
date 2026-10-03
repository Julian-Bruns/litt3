import Solutions.QuotientGeometry.ConstantPoleIrreducibility
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.QuotientGeometry

theorem constant_pole_field_model_degree
    {k L : Type*} [Field k] [Field L] (g : Polynomial k)
    (hg : 0 < g.natDegree) (hzero : g.coeff 0 = 0) (Ψ : LaurentSeries k →+* L)
    (e : AdjoinRoot (constantPolePolynomial g) ≃+* L)
    (he : ∀ r : LaurentSeries k, e (AdjoinRoot.of (constantPolePolynomial g) r) = Ψ r) :
    letI : Algebra (LaurentSeries k) L := Ψ.toAlgebra
    letI : SMul (LaurentSeries k) L := Ψ.toAlgebra.toSMul
    letI : Module (LaurentSeries k) L := Algebra.toModule
    FiniteDimensional (LaurentSeries k) L ∧ Module.finrank (LaurentSeries k) L = g.natDegree := by
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
  letI : Algebra (LaurentSeries k) L := Ψ.toAlgebra
  letI : SMul (LaurentSeries k) L := Ψ.toAlgebra.toSMul
  letI : Module (LaurentSeries k) L := Algebra.toModule
  let ε : E ≃ₐ[LaurentSeries k] L :=
    { __ := e
      commutes' := fun r => by rw [hEmap]; exact he r }
  haveI : FiniteDimensional (LaurentSeries k) L :=
    FiniteDimensional.of_surjective ε.toLinearMap ε.surjective
  exact ⟨inferInstance, ε.toLinearEquiv.finrank_eq.symm.trans hsource⟩

end Litt3.QuotientGeometry
