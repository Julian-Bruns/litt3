import Solutions.QuotientGeometry.WeakTameGalois

namespace Litt3.QuotientGeometry

theorem weak_tame_polynomial_root_field_galois
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    letI : Fact (Irreducible (constantPolePolynomial (weakTamePolynomial p h α γ))) :=
      ⟨weak_tame_polynomial_pole_irreducible p h (Fact.out : p.Prime).one_lt hh α γ hα⟩
    letI : Field (AdjoinRoot (constantPolePolynomial (weakTamePolynomial p h α γ))) := inferInstance
    IsGalois (LaurentSeries k) (AdjoinRoot (constantPolePolynomial (weakTamePolynomial p h α γ))) := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  let g := weakTamePolynomial p h α γ
  have hg : 0 < g.natDegree := by
    rw [weak_tame_polynomial_degree p h hp α γ hα]
    exact Nat.mul_pos (by omega) hh
  haveI : Fact (Irreducible (constantPolePolynomial g)) :=
    ⟨weak_tame_polynomial_pole_irreducible p h hp hh α γ hα⟩
  let E := AdjoinRoot (constantPolePolynomial g)
  letI : Field E := inferInstance
  let AE : Algebra (LaurentSeries k) E := inferInstance
  letI : Algebra (LaurentSeries k) E := AE
  letI : SMul (LaurentSeries k) E := AE.toSMul
  letI : Module (LaurentSeries k) E := Algebra.toModule
  have hEmap : algebraMap (LaurentSeries k) E = AdjoinRoot.of (constantPolePolynomial g) :=
    AdjoinRoot.algebraMap_eq _
  obtain ⟨e, he⟩ := constant_polynomial_laurent_field_model g hg
    (weak_tame_polynomial_constant_zero p h hp hh α γ)
  let Φ := parameterLaurentMap (constantPolynomialParameter g) (constant_polynomial_parameter_zero g hg)
    (constant_polynomial_parameter_injective g hg)
  letI : Algebra (LaurentSeries k) (LaurentSeries k) := Φ.toAlgebra
  letI : SMul (LaurentSeries k) (LaurentSeries k) := Φ.toAlgebra.toSMul
  letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
  haveI : IsGalois (LaurentSeries k) (LaurentSeries k) :=
    weak_tame_normalized_laurent_galois p h hh hdiv α γ hα hγ
  let ε : E ≃ₐ[LaurentSeries k] LaurentSeries k :=
    { __ := e
      commutes' := fun r => by rw [hEmap]; exact he r }
  exact IsGalois.of_algEquiv ε.symm

end Litt3.QuotientGeometry
