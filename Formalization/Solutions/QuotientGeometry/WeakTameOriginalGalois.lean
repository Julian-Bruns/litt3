import Solutions.QuotientGeometry.WeakTameOriginalField
import Solutions.QuotientGeometry.WeakTameRootFieldGalois

namespace Litt3.QuotientGeometry

theorem weak_tame_original_completed_extension_galois
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1)
    (φ : PowerSeries k →ₐ[k] PowerSeries k) (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (ψ : LaurentSeries k) (hroot : ψ ^ h = Ψ (HahnSeries.single (-1) 1))
    (hψorder : ψ.order = -(p : ℤ)) (hψderiv : (LaurentSeries.derivative k ψ).order = -2) :
    letI : Algebra (LaurentSeries k) (LaurentSeries k) := Ψ.toAlgebra
    letI : SMul (LaurentSeries k) (LaurentSeries k) := Ψ.toAlgebra.toSMul
    letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
    IsGalois (LaurentSeries k) (LaurentSeries k) := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  obtain ⟨α, γ, hα, hγ, _, _, e, he⟩ :=
    weak_tame_original_completed_field_model p h hp hh φ Ψ hΨ ψ hroot hψorder hψderiv
  let g := weakTamePolynomial p h α γ
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
  haveI : IsGalois (LaurentSeries k) E := weak_tame_polynomial_root_field_galois p h hh hdiv α γ hα hγ
  letI : Algebra (LaurentSeries k) (LaurentSeries k) := Ψ.toAlgebra
  letI : SMul (LaurentSeries k) (LaurentSeries k) := Ψ.toAlgebra.toSMul
  letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
  let ε : E ≃ₐ[LaurentSeries k] LaurentSeries k :=
    { __ := e
      commutes' := fun r => by rw [hEmap]; exact he r }
  exact IsGalois.of_algEquiv ε

end Litt3.QuotientGeometry
