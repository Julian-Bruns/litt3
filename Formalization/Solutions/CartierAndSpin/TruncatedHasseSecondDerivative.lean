import Solutions.CartierAndSpin.TruncatedTaylorPolynomials
import Solutions.CartierAndSpin.TruncatedHasseFirstDerivation

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Polynomial

theorem normalized_derivation_aeval
    {S L : Type*} [CommRing S] [Field L] [Algebra S L]
    (D : Derivation S L L) (t : L) (ht : D t = 1) (P : S[X]) :
    D (aeval t P) = aeval t P.derivative := by
  induction P using Polynomial.induction_on' with
  | add P Q hP hQ => simp only [map_add, hP, hQ]
  | monomial n c =>
      simp [aeval_monomial, D.leibniz, D.leibniz_pow, D.map_algebraMap,
        ht, smul_eq_mul, nsmul_eq_mul, derivative_monomial, mul_assoc]

variable {L : Type*} [Field L] {p : ℕ} [Fact p.Prime] [CharP L p]

/-- The literal second field Taylor coefficient equals half of the
second derivation wherever two is invertible. The cleared identity
holds in every prime characteristic without that restriction. -/
theorem truncated_hasse_second_derivative
    {k : Type*} [CommRing k] [Algebra k L]
    (b : PowerPBasis L p) (D : Derivation k L L) (ht : D b.parameter = 1)
    (e : ℕ) (hdegree : 2 < p ^ e) (a : L) :
    (2 : L) * truncatedHasseDerivative b e 2 a = D (D a) := by
  have he : 0 < e := by
    by_contra h
    have he0 : e = 0 := by omega
    simp [he0] at hdegree
  let S := iteratedFrobeniusSubfield L p e
  let E := truncatedHasseFirstDerivation b e he
  have hEt : E b.parameter = 1 := truncated_hasse_first_parameter b e he
  have hED : ∀ z : L, E z = D z :=
    truncated_hasse_first_eq_normalized_derivation b e he D ht
  obtain ⟨P, hP⟩ := (iteratedPBasisPowerBasis b e).exists_eq_aeval' a
  rw [iteratedPBasisPowerBasis_gen] at hP
  have hsecond : E (E a) = aeval b.parameter P.derivative.derivative := by
    rw [hP, normalized_derivation_aeval E b.parameter hEt P,
      normalized_derivation_aeval E b.parameter hEt P.derivative]
  rw [← hED a, ← hED (E a), hsecond, hP,
    truncated_hasse_polynomial_evaluation b e 2 hdegree]
  let Q := P.map (algebraMap S L)
  have hpoly : (2 : ℕ) • hasseDeriv 2 Q = Q.derivative.derivative := by
    simpa using congrFun (factorial_smul_hasseDeriv (R := L) 2) Q
  have hev := congrArg (fun F : L[X] => F.eval b.parameter) hpoly
  simpa [Q, eval_smul, nsmul_eq_mul, derivative_map, eval_map, aeval_def] using hev

end Litt3.CartierAndSpin
