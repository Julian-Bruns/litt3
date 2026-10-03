import Definitions.QuotientGeometry.QuadraticFunctionFields
import Solutions.QuotientGeometry.DerivationCoordinates
import Mathlib.FieldTheory.KummerPolynomial
import Mathlib.Algebra.Squarefree.Basic
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
import Mathlib.Tactic

namespace Litt3.QuotientGeometry

/-- A nonunit squarefree element remains nonsquare in the actual
fraction field of any integrally closed domain. No valuation choice or
factor enumeration is required. -/
theorem squarefree_nonunit_nonsquare_in_fraction_field
    {R K : Type*} [CommRing R] [IsDomain R] [Field K]
    [Algebra R K] [IsFractionRing R K] [IsIntegrallyClosed R]
    (a : R) (hsquarefree : Squarefree a) (hnonunit : ¬ IsUnit a) :
    ∀ x : K, x ^ 2 ≠ algebraMap R K a := by
  intro x hpower
  obtain ⟨r, hr⟩ := IsIntegrallyClosed.exists_algebraMap_eq_of_isIntegral_pow
    (show 0 < 2 by decide) (by rw [hpower]; exact isIntegral_algebraMap)
  have hrpower : r ^ 2 = a := by
    apply IsFractionRing.injective R K
    rw [map_pow, hr, hpower]
  have hrunit : IsUnit r := hsquarefree r (by rw [← pow_two, hrpower])
  apply hnonunit
  rw [← hrpower]
  exact hrunit.pow 2

theorem quadratic_function_polynomial_irreducible
    {k : Type*} [Field k] (f : Polynomial k)
    (hsquarefree : Squarefree f) (hnonconstant : 0 < f.natDegree) :
    Irreducible (quadraticFunctionPolynomial f) := by
  apply X_pow_sub_C_irreducible_of_prime Nat.prime_two
  apply squarefree_nonunit_nonsquare_in_fraction_field f hsquarefree
  intro hunit
  exact hnonconstant.ne' (Polynomial.natDegree_eq_zero_of_isUnit hunit)

theorem quadratic_function_field_degree
    {k : Type*} [Field k] (f : Polynomial k) :
    Module.finrank (RatFunc k) (QuadraticFunctionField f) = 2 := by
  change Module.finrank (RatFunc k)
    ((Polynomial (RatFunc k)) ⧸ Ideal.span {quadraticFunctionPolynomial f}) = 2
  rw [finrank_quotient_span_eq_natDegree]
  unfold quadraticFunctionPolynomial
  exact Polynomial.natDegree_X_pow_sub_C

/-- The actual quadratic algebra maps to the supplied field whenever
its transcendental x-coordinate and y-coordinate satisfy the equation. -/
noncomputable def quadraticFunctionFieldMap
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (f : Polynomial k) (x : L) (hx : Transcendental k x)
    (y : L) (hy : y ^ 2 = Polynomial.aeval x f) :
    QuadraticFunctionField f →ₐ[k] L :=
  AdjoinRoot.liftAlgHom (quadraticFunctionPolynomial f)
    (transcendentalRationalMap x hx) y (by
      simp only [quadraticFunctionPolynomial, Polynomial.eval₂_sub,
        Polynomial.eval₂_pow, Polynomial.eval₂_X, Polynomial.eval₂_C]
      change y ^ 2 - transcendentalRationalMap x hx
        (algebraMap (Polynomial k) (RatFunc k) f) = 0
      rw [transcendental_rational_map_polynomial]
      exact sub_eq_zero.mpr hy)

theorem quadratic_function_field_map_injective
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (f : Polynomial k) (hsquarefree : Squarefree f) (hnonconstant : 0 < f.natDegree)
    (x : L) (hx : Transcendental k x)
    (y : L) (hy : y ^ 2 = Polynomial.aeval x f) :
    Function.Injective (quadraticFunctionFieldMap f x hx y hy) := by
  letI : Fact (Irreducible (quadraticFunctionPolynomial f)) :=
    ⟨quadratic_function_polynomial_irreducible f hsquarefree hnonconstant⟩
  exact (quadraticFunctionFieldMap f x hx y hy).injective

theorem quadratic_function_field_map_root
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (f : Polynomial k) (x : L) (hx : Transcendental k x)
    (y : L) (hy : y ^ 2 = Polynomial.aeval x f) :
    quadraticFunctionFieldMap f x hx y hy (AdjoinRoot.root (quadraticFunctionPolynomial f)) = y := by
  simp [quadraticFunctionFieldMap]

theorem binary_dehomogenization_evaluation
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (H : MvPolynomial (Fin 2) k) (x : L) :
    Polynomial.aeval x (binaryDehomogenization H) =
      H.eval₂ (algebraMap k L) ![1, x] := by
  have hhom : (Polynomial.aeval x).comp
      (MvPolynomial.aeval (![1, Polynomial.X] : Fin 2 → Polynomial k)) =
      MvPolynomial.aeval (![1, x] : Fin 2 → L) := by
    apply MvPolynomial.algHom_ext
    intro i
    fin_cases i <;> simp [AlgHom.comp_apply]
  have h := DFunLike.congr_fun hhom H
  simpa only [AlgHom.comp_apply, binaryDehomogenization, MvPolynomial.aeval_def] using h

/-- The reconstructed field injection keeps the actual quadratic root
and the actual transcendental x-coordinate. The proper-curve and
étale bridges are separate geometric obligations. -/
theorem canonical_pencil_quadratic_field_embedding
    {k L : Type*} [Field k] [Field L] [IsAlgClosed k] [Algebra k L]
    (D : Derivation k L L) (H : MvPolynomial (Fin 2) k)
    (hH : H.IsHomogeneous 6)
    (hsquarefree : Squarefree (binaryDehomogenization H))
    (hnonconstant : 0 < (binaryDehomogenization H).natDegree)
    (A B : L) (hA : A ≠ 0)
    (hbracket : canonicalPencilBracket D A B ≠ 0)
    (hidentity : (canonicalPencilBracket D A B) ^ 2 =
      H.eval₂ (algebraMap k L) ![A, B]) :
    ∃ φ : QuadraticFunctionField (binaryDehomogenization H) →ₐ[k] L,
      Function.Injective φ ∧
      φ (AdjoinRoot.root (quadraticFunctionPolynomial (binaryDehomogenization H))) =
        canonicalPencilY A (canonicalPencilBracket D A B) ∧
      φ (AdjoinRoot.of (quadraticFunctionPolynomial (binaryDehomogenization H))
        (algebraMap (Polynomial k) (RatFunc k) Polynomial.X)) = canonicalPencilX A B := by
  let x := canonicalPencilX A B
  let y := canonicalPencilY A (canonicalPencilBracket D A B)
  have hx : Transcendental k x := canonical_pencil_coordinate_transcendental D A B hA hbracket
  have hy : y ^ 2 = Polynomial.aeval x (binaryDehomogenization H) := by
    rw [binary_dehomogenization_evaluation]
    exact (canonical_pencil_field_reconstruction D H hH A B hA hbracket hidentity).1
  refine ⟨quadraticFunctionFieldMap (binaryDehomogenization H) x hx y hy,
    quadratic_function_field_map_injective _ hsquarefree hnonconstant x hx y hy,
    quadratic_function_field_map_root _ x hx y hy, ?_⟩
  simp only [quadraticFunctionFieldMap, AdjoinRoot.liftAlgHom_of,
    transcendental_rational_map_polynomial, Polynomial.aeval_X]
  rfl

end Litt3.QuotientGeometry
