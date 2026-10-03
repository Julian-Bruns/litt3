import Solutions.Deformations.PolynomialCyclicNorm
import Solutions.Deformations.PolynomialCoefficientAction
import Solutions.Deformations.FormalCyclicPreparation
import Solutions.Deformations.LinearEndomorphismRanges

namespace Litt3.Deformations

open Polynomial

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The actual original polynomial cyclic relation, under the actual
coefficient inclusion, is precisely the distinguished polynomial
relation on polynomial coefficient sequences. -/
theorem polynomial_cyclic_relation_conjugate (p a : ℕ) [Fact p.Prime] :
    (polynomialCoefficientSeriesEquiv (R := R) (K := K)).conj
        (polynomialCyclicOperator (R := R) (K := K) p a) =
      polynomialPreparedSeriesOperator (p ^ a) (p : R)
        (formalCyclicCorrection (R := R) (K := K) p a)
        (formal_cyclic_correction_preserves_polynomial p a) := by
  apply LinearMap.ext
  intro v
  apply Subtype.ext
  rw [LinearEquiv.conj_apply_apply]
  change polynomialCoefficientFullMap (R := R)
      (polynomialCyclicOperator (R := R) (K := K) p a
        ((polynomialCoefficientSeriesEquiv (R := R) (K := K)).symm v)) =
    preparedSeriesOperator (p ^ a) (p : R) (formalCyclicCorrection (R := R) (K := K) p a)
      (v : CoefficientSeries (K := K))
  rw [polynomialCyclicOperator, polynomial_scalar_operator_apply,
    polynomial_coefficient_full_map_smul]
  have value : polynomialCoefficientFullMap (R := R)
      ((polynomialCoefficientSeriesEquiv (R := R) (K := K)).symm v) =
        (v : CoefficientSeries (K := K)) :=
    congrArg (fun w : polynomialCoefficientSeries (R := R) (K := K) => w.val)
      ((polynomialCoefficientSeriesEquiv (R := R) (K := K)).apply_symm_apply v)
  rw [value]
  simp only [cyclicGroupPolynomial, map_sub, map_pow, map_add, map_one,
    Polynomial.aeval_X]
  exact LinearMap.congr_fun (formal_cyclic_relation_prepared (R := R) (K := K) p a Fact.out) v

/-- The literal original polynomial quotient K[e]/F K[e] completes
isomorphically into the literal full-series quotient by F, at arbitrary
coefficient-module rank. The equivalence is constructed and agrees
with the original coefficient inclusion. -/
noncomputable def polynomialCyclicCompletionEquiv (p a : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0) :
    PolynomialCyclicModule (R := R) (K := K) p a ≃ₗ[R]
      (CoefficientSeries (K := K) ⧸ LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)) :=
  (Submodule.Quotient.equiv _ _ (polynomialCoefficientSeriesEquiv (R := R) (K := K))
    ((linear_equiv_map_range_conjugate _ _).trans
      (congrArg LinearMap.range (polynomial_cyclic_relation_conjugate (R := R) (K := K) p a)))).trans
    ((polynomialPreparedCompletionEquiv (p ^ a) (p : R) ⟨a + 1, vanish⟩
      (formalCyclicCorrection (R := R) (K := K) p a)
      (formal_cyclic_correction_preserves_polynomial p a)).trans
        (Submodule.quotEquivOfEq _ _ (congrArg LinearMap.range
          (formal_cyclic_relation_prepared (R := R) (K := K) p a Fact.out).symm)))

theorem polynomial_cyclic_completion_equiv_mk (p a : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0) (u : PolynomialModule R K) :
    polynomialCyclicCompletionEquiv (K := K) p a vanish
      ((LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ u) =
      (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
        (polynomialCoefficientFullMap (R := R) u) := by
  unfold polynomialCyclicCompletionEquiv
  simp only [LinearEquiv.trans_apply, Submodule.Quotient.equiv_apply,
    Submodule.mapQ_apply, Submodule.mkQ_apply]
  change (Submodule.quotEquivOfEq _ _ _)
    (polynomialPreparedCompletionEquiv (p ^ a) (p : R) ⟨a + 1, vanish⟩
      (formalCyclicCorrection (R := R) (K := K) p a)
      (formal_cyclic_correction_preserves_polynomial p a)
      ((LinearMap.range (polynomialPreparedSeriesOperator (p ^ a) (p : R)
        (formalCyclicCorrection (R := R) (K := K) p a)
        (formal_cyclic_correction_preserves_polynomial p a))).mkQ
          (polynomialCoefficientSeriesEquiv (R := R) (K := K) u))) = _
  rw [polynomial_prepared_completion_equiv_mk]
  rfl

end Litt3.Deformations
