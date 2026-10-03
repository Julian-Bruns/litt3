import Definitions.CartierAndSpin.SourceDerivation
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K : Type*} [CommRing R] [CommRing K] [Algebra R K]

theorem sourceCoefficientDerivation_C (D : Derivation R K K) (c : K) :
    sourceCoefficientDerivation D (C c) = C (D c) := by
  simp [sourceCoefficientDerivation]

theorem sourceCoefficientDerivation_X (D : Derivation R K K) :
    sourceCoefficientDerivation D X = 0 := by
  simp [sourceCoefficientDerivation]

theorem sourcePolynomialDerivation_apply (D : Derivation R K K) (v P : K[X]) :
    sourcePolynomialDerivation D v P = sourceCoefficientDerivation D P + v * P.derivative := by
  rfl

theorem sourcePolynomialDerivation_C (D : Derivation R K K) (v : K[X]) (c : K) :
    sourcePolynomialDerivation D v (C c) = C (D c) := by
  rw [sourcePolynomialDerivation_apply, sourceCoefficientDerivation_C, derivative_C]
  simp

theorem sourcePolynomialDerivation_X (D : Derivation R K K) (v : K[X]) :
    sourcePolynomialDerivation D v X = v := by
  rw [sourcePolynomialDerivation_apply, sourceCoefficientDerivation_X, derivative_X]
  simp

variable {A : Type*} [CommRing A] [Algebra K A] [Algebra R A]

/-- The coefficient/ordinary derivative chain rule over arbitrary
commutative algebras, including disconnected polynomial quotients. -/
theorem source_derivation_polynomial_aeval (D : Derivation R K K)
    (E : Derivation R A A)
    (compatible : ∀ c : K, E (algebraMap K A c) = algebraMap K A (D c))
    (x : A) (P : K[X]) :
    E (aeval x P) = aeval x (sourceCoefficientDerivation D P) +
      aeval x P.derivative * E x := by
  have h := D.apply_aeval_eq' E (Algebra.linearMap K A)
    (fun c => (compatible c).symm) x P
  have hpoly : sourceCoefficientDerivation D P =
      PolynomialModule.equivPolynomial (D.mapCoeffs P) := rfl
  rw [hpoly, PolynomialModule.aeval_equivPolynomial]
  simpa only [smul_eq_mul] using h

/-- Every derivation extends to the actual quotient by a separable
polynomial over any commutative coefficient ring. The proof constructs a
Bezout inverse of F' and lifts a derivation through the actual ideal. -/
theorem separable_polynomial_quotient_derivation_exists (D : Derivation R K K)
    (F : K[X]) (hseparable : F.Separable) :
    ∃ extension : Derivation R (AdjoinRoot F) (AdjoinRoot F),
      ∀ c : K, extension (algebraMap K (AdjoinRoot F) c) =
        algebraMap K (AdjoinRoot F) (D c) := by
  obtain ⟨a, b, hbezout⟩ := hseparable
  let q := (AdjoinRoot.mkₐ F).restrictScalars R
  let v := -b * sourceCoefficientDerivation D F
  let d := sourcePolynomialDerivation D v
  have hqF : q F = 0 := AdjoinRoot.mk_self
  have hbezoutQ : q b * q F.derivative = 1 := by
    have h := congrArg q hbezout
    simp only [map_add, map_mul, map_one, hqF, mul_zero, zero_add] at h
    exact h
  have hdF : q (d F) = 0 := by
    change q (sourceCoefficientDerivation D F +
      (-b * sourceCoefficientDerivation D F) * F.derivative) = 0
    rw [map_add, map_mul, map_mul, map_neg]
    calc
      _ = q (sourceCoefficientDerivation D F) * (1 - q b * q F.derivative) := by ring
      _ = 0 := by rw [hbezoutQ]; ring
  have hstable : ∀ P, q P = 0 → q (d P) = 0 := by
    intro P hzero
    have hdivides : F ∣ P := AdjoinRoot.mk_eq_zero.mp hzero
    obtain ⟨Q, rfl⟩ := hdivides
    rw [d.leibniz]
    simp only [smul_eq_mul, map_add, map_mul, hdF,
      show q F = 0 from AdjoinRoot.mk_self, mul_zero, zero_mul, zero_add]
  let extension := Derivation.liftOfSurjective (f := q) AdjoinRoot.mk_surjective hstable
  refine ⟨extension, ?_⟩
  intro c
  change extension (q (C c)) = q (C (D c))
  rw [Derivation.liftOfSurjective_apply]
  change q (sourcePolynomialDerivation D v (C c)) = q (C (D c))
  rw [sourcePolynomialDerivation_C]

/-- The extension to a separable polynomial quotient is unique. The
ordinary derivative is canceled by the actual polynomial Bezout inverse,
so neither quotient field structure nor an irreducibility assumption enters. -/
theorem separable_polynomial_quotient_derivation_unique (D : Derivation R K K)
    (F : K[X]) (hseparable : F.Separable)
    (E₁ E₂ : Derivation R (AdjoinRoot F) (AdjoinRoot F))
    (h₁ : ∀ c : K, E₁ (algebraMap K (AdjoinRoot F) c) = algebraMap K (AdjoinRoot F) (D c))
    (h₂ : ∀ c : K, E₂ (algebraMap K (AdjoinRoot F) c) = algebraMap K (AdjoinRoot F) (D c)) :
    E₁ = E₂ := by
  obtain ⟨a, b, hbezout⟩ := hseparable
  have hbezoutQ : AdjoinRoot.mk F b * AdjoinRoot.mk F F.derivative = 1 := by
    have h := congrArg (AdjoinRoot.mk F) hbezout
    simpa only [map_add, map_mul, map_one, AdjoinRoot.mk_self, mul_zero, zero_add] using h
  have hroot₁ := source_derivation_polynomial_aeval D E₁ h₁ (AdjoinRoot.root F) F
  have hroot₂ := source_derivation_polynomial_aeval D E₂ h₂ (AdjoinRoot.root F) F
  simp only [AdjoinRoot.aeval_eq, AdjoinRoot.mk_self, map_zero] at hroot₁ hroot₂
  have hmul : AdjoinRoot.mk F F.derivative * E₁ (AdjoinRoot.root F) =
      AdjoinRoot.mk F F.derivative * E₂ (AdjoinRoot.root F) := by
    linear_combination hroot₂ - hroot₁
  have hroot : E₁ (AdjoinRoot.root F) = E₂ (AdjoinRoot.root F) := by
    have h := congrArg (fun x => AdjoinRoot.mk F b * x) hmul
    simpa only [← mul_assoc, hbezoutQ, one_mul] using h
  ext x
  refine AdjoinRoot.induction_on F x (fun P => ?_)
  rw [← AdjoinRoot.aeval_eq,
    source_derivation_polynomial_aeval D E₁ h₁,
    source_derivation_polynomial_aeval D E₂ h₂, hroot]

end Litt3.CartierAndSpin
