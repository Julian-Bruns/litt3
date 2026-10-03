import Solutions.QuotientGeometry.LinearizedParameter
import Solutions.QuotientGeometry.LinearizedArtinSchreierScaling
import Solutions.QuotientGeometry.PoleOneArtinSchreierFields
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.QuotientGeometry

/-- The original whole Laurent field, over the actual parameter
`(αt⁻ᵖ+γt⁻¹)⁻¹`, is a genuine pole-one Artin–Schreier quotient field.
No degree or algebraic-generation conclusion is supplied as an input. -/
theorem linearized_laurent_artin_schreier_model
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [Fact p.Prime] [CharP k p]
    (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    ∃ a : k, a ≠ 0 ∧ a ^ (p - 1) = -α / γ ^ p ∧
      ∃ e : ArtinSchreierAlgebra (LaurentSeries k) p (HahnSeries.single (-1) a) ≃+* LaurentSeries k,
        ∀ r : LaurentSeries k,
          e (AdjoinRoot.of (artinSchreierPolynomial p (HahnSeries.single (-1) a)) r) =
            parameterLaurentMap (linearizedParameter p α γ)
              (linearized_parameter_zero p (Fact.out : p.Prime).one_lt α γ)
              (linearized_parameter_injective p (Fact.out : p.Prime).one_lt α γ hα) r := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  obtain ⟨ℓ, a, hℓ, ha, _, hlinear, hinv, hscalar⟩ :=
    linearized_artin_schreier_scaling p α γ hα hγ
  refine ⟨a, ha, hscalar, ?_⟩
  haveI := laurent_series_charP (k := k) p
  let E := ArtinSchreierAlgebra (LaurentSeries k) p (HahnSeries.single (-1) a)
  haveI : Fact (Irreducible (artinSchreierPolynomial p (HahnSeries.single (-1) a : LaurentSeries k))) :=
    ⟨pole_one_artin_schreier_irreducible p hp a ha⟩
  letI : Field E := inferInstance
  let AE : Algebra (LaurentSeries k) E := inferInstance
  letI : Algebra (LaurentSeries k) E := AE
  letI : SMul (LaurentSeries k) E := AE.toSMul
  letI : Module (LaurentSeries k) E := Algebra.toModule
  have hEmap : algebraMap (LaurentSeries k) E =
      AdjoinRoot.of (artinSchreierPolynomial p (HahnSeries.single (-1) a : LaurentSeries k)) :=
    AdjoinRoot.algebraMap_eq _
  haveI : FiniteDimensional (LaurentSeries k) E :=
    (artin_schreier_monic_degree p hp (HahnSeries.single (-1) a : LaurentSeries k)).1.finite_adjoinRoot
  have hsource : Module.finrank (LaurentSeries k) E = p :=
    artin_schreier_field_degree p hp (HahnSeries.single (-1) a : LaurentSeries k)
  let b := linearizedParameter p α γ
  let φ := parameterLaurentMap b (linearized_parameter_zero p hp α γ)
    (linearized_parameter_injective p hp α γ hα)
  letI : Algebra (LaurentSeries k) (LaurentSeries k) := φ.toAlgebra
  letI : SMul (LaurentSeries k) (LaurentSeries k) := φ.toAlgebra.toSMul
  letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
  have hc : PowerSeries.constantCoeff
      (PowerSeries.C α + PowerSeries.C γ * PowerSeries.X ^ (p - 1) : PowerSeries k)⁻¹ ≠ 0 := by
    rw [PowerSeries.constantCoeff_inv, linearized_parameter_factor_constant p hp α γ]
    exact inv_ne_zero hα
  have hdim : FiniteDimensional (LaurentSeries k) (LaurentSeries k) ∧
      Module.finrank (LaurentSeries k) (LaurentSeries k) ≤ p :=
    finite_parameter_laurent_dimension p (by omega) b
      (PowerSeries.C α + PowerSeries.C γ * PowerSeries.X ^ (p - 1))⁻¹ rfl hc
      (linearized_parameter_zero p hp α γ) (linearized_parameter_injective p hp α γ hα)
  haveI : FiniteDimensional (LaurentSeries k) (LaurentSeries k) := hdim.1
  have hcoeff₁ : a * α = (ℓ⁻¹) ^ p := by
    apply mul_right_cancel₀ (pow_ne_zero p hℓ)
    calc
      (a * α) * ℓ ^ p = 1 := by simpa only [mul_assoc] using hinv
      _ = (ℓ⁻¹) ^ p * ℓ ^ p := by rw [← mul_pow, inv_mul_cancel₀ hℓ, one_pow]
  have hcoeff₂ : a * γ = -ℓ⁻¹ := by
    apply mul_right_cancel₀ hℓ
    calc
      (a * γ) * ℓ = -(a * (α * ℓ ^ p)) := by rw [hlinear]; ring
      _ = -1 := by rw [hinv]
      _ = -ℓ⁻¹ * ℓ := by rw [neg_mul, inv_mul_cancel₀ hℓ]
  let C : k →+* LaurentSeries k := HahnSeries.C
  let u : LaurentSeries k := HahnSeries.single (-1) 1
  let θ : LaurentSeries k := C ℓ⁻¹ * u
  have ht₁ : (C ℓ⁻¹) ^ p = C a * C α := by rw [← map_pow, ← hcoeff₁, map_mul]
  have ht₂ : C a * C γ = -(C ℓ⁻¹) := by rw [← map_mul, hcoeff₂, map_neg]
  have hy : θ ^ p - θ = φ (HahnSeries.single (-1) a) := by
    rw [parameter_laurent_map_pole, linearized_parameter_inverse p hp α γ hα]
    change θ ^ p - θ = C a * (C α * u ^ p + C γ * u)
    dsimp only [θ]
    rw [mul_pow, ht₁, mul_add, ← mul_assoc, ← mul_assoc, ht₂]
    ring
  have hroot : (artinSchreierPolynomial p (HahnSeries.single (-1) a : LaurentSeries k)).eval₂
      (algebraMap (LaurentSeries k) (LaurentSeries k)) θ = 0 := by
    change θ ^ p - θ = algebraMap (LaurentSeries k) (LaurentSeries k)
      (HahnSeries.single (-1) a) at hy
    simpa [artinSchreierPolynomial, sub_eq_zero] using hy
  let f : E →ₐ[LaurentSeries k] LaurentSeries k :=
    { __ := AdjoinRoot.lift φ θ hroot
      commutes' := fun r => by
        change AdjoinRoot.lift φ θ hroot (algebraMap (LaurentSeries k) E r) = φ r
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
