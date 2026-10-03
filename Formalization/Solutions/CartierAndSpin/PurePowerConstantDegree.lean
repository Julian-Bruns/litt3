import Solutions.CartierAndSpin.PurePowerPoints
import Solutions.CurveArithmetic.RationalCoefficientConjugates
import Solutions.CurveArithmetic.RationalCoefficientField
import Theorems.CartierAndSpin.PurePowerConstantDegree

/-!
# Constant-field degree of pure-power rational solutions

The actual rational-function pair is conjugated by all automorphisms of its
finite coefficient field. Normalized coefficients detect distinct conjugates;
the original equations over the actual base rational-function field are fixed.
The geometric solution count then bounds the coefficient-field degree by m².
-/

namespace Litt3.CartierAndSpin

open Litt3.CurveArithmetic

variable {K L : Type*} [Field K] [Field L] [Algebra K L] [Finite L]

theorem purePower_rational_coefficient_degree_le_square
    (rational : Fin 2 → RatFunc L)
    (hgenerates : IntermediateField.adjoin K
      (Set.range (rationalFamilyCoefficients rational)) = ⊤)
    (m : ℕ) (a b c d : RatFunc K) (R S : MvPolynomial (Fin 2) (RatFunc K))
    (hR : R.totalDegree < m) (hS : S.totalDegree < m)
    (hdet : a * d - b * c ≠ 0)
    (hF : MvPolynomial.eval₂Hom (rationalCoefficientMap (algebraMap K L))
      rational (purePowerPolynomial m a b R) = 0)
    (hG : MvPolynomial.eval₂Hom (rationalCoefficientMap (algebraMap K L))
      rational (purePowerPolynomial m c d S) = 0) :
    Module.finrank K L ≤ m ^ 2 := by
  classical
  letI : Algebra (RatFunc K) (RatFunc L) :=
    (rationalCoefficientMap (algebraMap K L)).toAlgebra
  letI := Fintype.ofFinite (L ≃ₐ[K] L)
  let point (σ : L ≃ₐ[K] L) : RatFunc L × RatFunc L :=
    (rationalCoefficientConjugate σ (rational 0),
      rationalCoefficientConjugate σ (rational 1))
  have hpoint : Function.Injective point := by
    intro σ τ hequal
    apply rational_coefficient_conjugates_injective rational hgenerates
    funext i
    fin_cases i
    · exact congrArg Prod.fst hequal
    · exact congrArg Prod.snd hequal
  have hvector (σ : L ≃ₐ[K] L) :
      (fun i => rationalCoefficientConjugate σ (rational i)) =
        (![(point σ).1, (point σ).2] : Fin 2 → RatFunc L) := by
    funext i
    fin_cases i <;> rfl
  have hFconjugate (σ : L ≃ₐ[K] L) :
      MvPolynomial.aeval ![(point σ).1, (point σ).2]
        (purePowerPolynomial m a b R) = 0 := by
    have h := rational_polynomial_relation_preserved_by_conjugation σ rational
      (purePowerPolynomial m a b R) hF
    rw [hvector] at h
    exact h
  have hGconjugate (σ : L ≃ₐ[K] L) :
      MvPolynomial.aeval ![(point σ).1, (point σ).2]
        (purePowerPolynomial m c d S) = 0 := by
    have h := rational_polynomial_relation_preserved_by_conjugation σ rational
      (purePowerPolynomial m c d S) hG
    rw [hvector] at h
    exact h
  have hcard := purePowerPairPointBound m a b c d R S point
    hR hS hdet hpoint hFconjugate hGconjugate
  rw [Fintype.card_eq_nat_card, IsGalois.card_aut_eq_finrank] at hcard
  exact hcard

section EmbeddedDescent

variable {Ω : Type*} [Field Ω] [Algebra K Ω] [Finite K]
  [Algebra.IsAlgebraic K Ω]

/-- Complete constant-field descent for actual pure-power solution pairs.
The coefficient field is constructed inside Ω from the canonical numerator
and monic denominator coefficients; no height or computation cutoff is used. -/
theorem purePowerRationalDescent (rational : Fin 2 → RatFunc Ω)
    (m : ℕ) (a b c d : RatFunc K) (R S : MvPolynomial (Fin 2) (RatFunc K)) :
    Specifications.PurePowerRationalDescent rational m a b c d R S := by
  classical
  intro hR hS hdet hF hG
  let E := rationalCoefficientField (K := K) rational
  letI : FiniteDimensional K E := rational_coefficient_field_finite_dimensional rational
  letI : Finite E := rational_coefficient_field_finite rational
  letI := Fintype.ofFinite (E ≃ₐ[K] E)
  obtain ⟨descended, hdescends⟩ := Classical.axiom_of_choice
    (rational_family_member_descends_to_coefficient_field (K := K) rational)
  letI : Algebra (RatFunc K) (RatFunc Ω) :=
    (rationalCoefficientMap (algebraMap K Ω)).toAlgebra
  let conjugated (σ : E ≃ₐ[K] E) (i : Fin 2) : RatFunc Ω :=
    rationalCoefficientMap E.val.toRingHom (rationalCoefficientConjugate σ (descended i))
  let point (σ : E ≃ₐ[K] E) : RatFunc Ω × RatFunc Ω :=
    (conjugated σ 0, conjugated σ 1)
  have hpoint : Function.Injective point := by
    intro σ τ hequal
    apply descended_coefficient_field_conjugates_injective rational descended hdescends
    funext i
    apply (rationalCoefficientMap E.val.toRingHom).injective
    fin_cases i
    · exact congrArg Prod.fst hequal
    · exact congrArg Prod.snd hequal
  have hvector (σ : E ≃ₐ[K] E) : conjugated σ =
      (![(point σ).1, (point σ).2] : Fin 2 → RatFunc Ω) := by
    funext i
    fin_cases i <;> rfl
  have hFconjugate (σ : E ≃ₐ[K] E) :
      MvPolynomial.aeval ![(point σ).1, (point σ).2]
        (purePowerPolynomial m a b R) = 0 := by
    have h := embedded_rational_polynomial_relation_preserved_by_conjugation
      E rational descended hdescends σ (purePowerPolynomial m a b R) hF
    change MvPolynomial.eval₂Hom (rationalCoefficientMap (algebraMap K Ω))
      (conjugated σ) (purePowerPolynomial m a b R) = 0 at h
    rw [hvector] at h
    exact h
  have hGconjugate (σ : E ≃ₐ[K] E) :
      MvPolynomial.aeval ![(point σ).1, (point σ).2]
        (purePowerPolynomial m c d S) = 0 := by
    have h := embedded_rational_polynomial_relation_preserved_by_conjugation
      E rational descended hdescends σ (purePowerPolynomial m c d S) hG
    change MvPolynomial.eval₂Hom (rationalCoefficientMap (algebraMap K Ω))
      (conjugated σ) (purePowerPolynomial m c d S) = 0 at h
    rw [hvector] at h
    exact h
  have hcard := purePowerPairPointBound m a b c d R S point
    hR hS hdet hpoint hFconjugate hGconjugate
  rw [Fintype.card_eq_nat_card, IsGalois.card_aut_eq_finrank] at hcard
  exact ⟨E, inferInstance, hcard, descended, hdescends⟩

end EmbeddedDescent

end Litt3.CartierAndSpin
