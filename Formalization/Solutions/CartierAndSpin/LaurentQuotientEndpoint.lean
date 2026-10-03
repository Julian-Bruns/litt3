import Solutions.CartierAndSpin.SplitSourceDifferentialTrace
import Solutions.CartierAndSpin.LaurentCoefficientChangeEndpoint

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {k ι : Type*} [Field k] [Fintype ι]

/-- The endpoint estimate is a theorem about the literal trace in
the actual separable source algebra, with its actual extended derivation. -/
theorem actual_source_laurent_twisted_endpoint_bound
    (F H : (LaurentSeries k)[X]) (hsep : F.Separable)
    (node : ι → LaurentSeries k) (hinj : Function.Injective node)
    (p r : ℕ) [CharP k p] (q tau leading : LaurentSeries k)
    (hp : p = 2 * r + 1) (hr : 1 ≤ r) (hdegree : p ≤ F.natDegree)
    (htau : tau ≠ 0) (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal univ node)
    (hsource : F = (X ^ p + C q) * H + C tau)
    (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ c : LaurentSeries k,
      E (algebraMap (LaurentSeries k) (AdjoinRoot F) c) =
        algebraMap (LaurentSeries k) (AdjoinRoot F) (laurentDerivation k c))
    (unit : (AdjoinRoot F)ˣ)
    (hunit : (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q))
    (hnodes : ∀ i, (0 : WithTop ℤ) ≤ (node i).orderTop)
    (hq : q.orderTop = (((r : ℤ) + 1 : ℤ) : WithTop ℤ)) :
    ((1 - (r : ℤ) : ℤ) : WithTop ℤ) ≤
      (Algebra.trace (LaurentSeries k) (AdjoinRoot F)
        ((E (AdjoinRoot.root F)) ^ 2 * (↑unit⁻¹ : AdjoinRoot F)) -
        4 * laurentDerivation k q *
          laurentDerivation k ((H %ₘ (X ^ p + C q)).coeff (p - 2) / tau)).orderTop := by
  rw [split_actual_source_differential_trace (laurentDerivation k) F hsep node hinj
    leading hleading hFsplit E compatible (X ^ p + C q) unit hunit]
  simp only [Polynomial.eval_add, Polynomial.eval_pow, Polynomial.eval_X, Polynomial.eval_C]
  exact split_source_laurent_twisted_endpoint_bound univ node hinj.injOn F H p r
    q tau leading hp hr hdegree htau hleading hFsplit hsource (fun i _ => hnodes i) hq

/-- Both the denominator unit and the extended derivation are
constructed from the actual separable source equation. -/
theorem actual_source_laurent_endpoint_objects_exist
    (F H : (LaurentSeries k)[X]) (hsep : F.Separable)
    (node : ι → LaurentSeries k) (hinj : Function.Injective node)
    (p r : ℕ) [CharP k p] (q tau leading : LaurentSeries k)
    (hp : p = 2 * r + 1) (hr : 1 ≤ r) (hdegree : p ≤ F.natDegree)
    (htau : tau ≠ 0) (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal univ node)
    (hsource : F = (X ^ p + C q) * H + C tau)
    (hnodes : ∀ i, (0 : WithTop ℤ) ≤ (node i).orderTop)
    (hq : q.orderTop = (((r : ℤ) + 1 : ℤ) : WithTop ℤ)) :
    ∃ (E : Derivation k (AdjoinRoot F) (AdjoinRoot F)) (unit : (AdjoinRoot F)ˣ),
      (∀ c : LaurentSeries k,
        E (algebraMap (LaurentSeries k) (AdjoinRoot F) c) =
          algebraMap (LaurentSeries k) (AdjoinRoot F) (laurentDerivation k c)) ∧
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      ((1 - (r : ℤ) : ℤ) : WithTop ℤ) ≤
        (Algebra.trace (LaurentSeries k) (AdjoinRoot F)
          ((E (AdjoinRoot.root F)) ^ 2 * (↑unit⁻¹ : AdjoinRoot F)) -
          4 * laurentDerivation k q *
            laurentDerivation k ((H %ₘ (X ^ p + C q)).coeff (p - 2) / tau)).orderTop := by
  obtain ⟨E, compatible⟩ := separable_polynomial_quotient_derivation_exists
    (laurentDerivation k) F hsep
  obtain ⟨unit, hunit⟩ := source_phi_isUnit (AdjoinRoot.mkₐ F) F
    (X ^ p + C q) H tau htau hsource (AdjoinRoot.mk_self (f := F))
  exact ⟨E, unit, compatible, hunit, actual_source_laurent_twisted_endpoint_bound
    F H hsep node hinj p r q tau leading hp hr hdegree htau hleading hFsplit hsource
    E compatible unit hunit hnodes hq⟩

theorem actual_source_laurent_corrected_endpoint_bound [CharP k 5]
    (F H : (LaurentSeries k)[X]) (hsep : F.Separable)
    (node : ι → LaurentSeries k) (hinj : Function.Injective node)
    (q tau leading : LaurentSeries k) (hdegree : 5 ≤ F.natDegree)
    (htauzero : tau ≠ 0) (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal univ node)
    (hsource : F = (X ^ 5 + C q) * H + C tau)
    (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ c : LaurentSeries k,
      E (algebraMap (LaurentSeries k) (AdjoinRoot F) c) =
        algebraMap (LaurentSeries k) (AdjoinRoot F) (laurentDerivation k c))
    (unit : (AdjoinRoot F)ˣ)
    (hunit : (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ 5 + C q))
    (hnodes : ∀ i, (0 : WithTop ℤ) ≤ (node i).orderTop)
    (hq : q.orderTop = (3 : WithTop ℤ)) (htau : tau.orderTop = (3 : WithTop ℤ))
    (hH : ∀ n, (0 : WithTop ℤ) ≤ (H.coeff n).orderTop) :
    let c := (H %ₘ (X ^ 5 + C q)).coeff 3
    (-1 : WithTop ℤ) ≤
      (Algebra.trace (LaurentSeries k) (AdjoinRoot F)
        ((E (AdjoinRoot.root F)) ^ 2 * (↑unit⁻¹ : AdjoinRoot F)) -
        laurentDerivation k q * laurentDerivation k c / tau -
        c * laurentDerivation k q * laurentDerivation k tau / tau ^ 2).orderTop := by
  dsimp only
  rw [split_actual_source_differential_trace (laurentDerivation k) F hsep node hinj
    leading hleading hFsplit E compatible (X ^ 5 + C q) unit hunit]
  simp only [Polynomial.eval_add, Polynomial.eval_pow, Polynomial.eval_X, Polynomial.eval_C]
  exact split_source_laurent_corrected_endpoint_bound univ node hinj.injOn F H
    q tau leading hdegree htauzero hleading hFsplit hsource (fun i _ => hnodes i)
    hq htau hH

theorem actual_source_laurent_coefficient_corrected_endpoint_bound [CharP k 5]
    (F H : (LaurentSeries k)[X]) (hsep : F.Separable)
    (node : ι → LaurentSeries k) (hinj : Function.Injective node)
    (q tau leading : LaurentSeries k) (hdegree : 5 ≤ F.natDegree)
    (htauzero : tau ≠ 0) (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal univ node)
    (hsource : F = (X ^ 5 + C q) * H + C tau)
    (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ c : LaurentSeries k,
      E (algebraMap (LaurentSeries k) (AdjoinRoot F) c) =
        algebraMap (LaurentSeries k) (AdjoinRoot F) (laurentDerivation k c))
    (unit : (AdjoinRoot F)ˣ)
    (hunit : (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ 5 + C q))
    (hnodes : ∀ i, (0 : WithTop ℤ) ≤ (node i).orderTop)
    (hq : q.orderTop = (3 : WithTop ℤ)) (htau : tau.orderTop = (3 : WithTop ℤ))
    (hH : ∀ n, (0 : WithTop ℤ) ≤ (H.coeff n).orderTop) :
    (-1 : WithTop ℤ) ≤
      (Algebra.trace (LaurentSeries k) (AdjoinRoot F)
        ((E (AdjoinRoot.root F)) ^ 2 * (↑unit⁻¹ : AdjoinRoot F)) -
        laurentDerivation k q * laurentDerivation k (H.coeff 3) / tau -
        H.coeff 3 * laurentDerivation k q * laurentDerivation k tau / tau ^ 2).orderTop := by
  rw [split_actual_source_differential_trace (laurentDerivation k) F hsep node hinj
    leading hleading hFsplit E compatible (X ^ 5 + C q) unit hunit]
  simp only [Polynomial.eval_add, Polynomial.eval_pow, Polynomial.eval_X, Polynomial.eval_C]
  exact split_source_laurent_coefficient_corrected_endpoint_bound univ node hinj.injOn F H
    q tau leading hdegree htauzero hleading hFsplit hsource (fun i _ => hnodes i)
    hq htau hH

end Litt3.CartierAndSpin
