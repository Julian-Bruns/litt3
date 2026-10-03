import Mathlib.RingTheory.Localization.NumDen
import Mathlib.Algebra.Squarefree.Basic
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
import Mathlib.Tactic

namespace Litt3.QuotientGeometry

/-- Squarefreeness removes every denominator from a rational coefficient
whose square times the branch element is integral. This works over every
integrally closed unique factorization domain, with no factor enumeration. -/
theorem squarefree_fraction_product_integral
    {R K : Type*} [CommRing R] [IsDomain R] [UniqueFactorizationMonoid R]
    [Field K] [Algebra R K] [IsFractionRing R K] [IsIntegrallyClosed R]
    (a : R) (ha : Squarefree a) (x : K)
    (hx : IsIntegral R (x ^ 2 * algebraMap R K a)) :
    ∃ y : R, algebraMap R K y = x := by
  obtain ⟨y, hy⟩ := (isIntegrallyClosed_iff K).mp (inferInstance : IsIntegrallyClosed R) hx
  obtain ⟨n, d, hcoprime, hfrac⟩ := IsFractionRing.exists_reduced_fraction R x
  have hn : algebraMap R K n = algebraMap R K d * x := by
    rw [← hfrac]
    exact (IsLocalization.mk'_spec' K n d).symm
  have hpoly : a * n ^ 2 = y * (d : R) ^ 2 := by
    apply IsFractionRing.injective R K
    simp only [map_mul, map_pow]
    rw [hn, hy]
    ring
  have hdiv : (d : R) * d ∣ a * n ^ 2 := by
    refine ⟨y, ?_⟩
    simpa [pow_two, mul_comm, mul_left_comm, mul_assoc] using hpoly
  have hdennum : (d : R) ∣ n ^ 2 := ha.dvd_of_squarefree_of_mul_dvd_mul_right hdiv
  have hunit : IsUnit (d : R) :=
    (hcoprime.mul_left hcoprime).symm.isUnit_of_dvd (by simpa [pow_two] using hdennum)
  obtain ⟨e, he⟩ := hunit.exists_right_inv
  refine ⟨n * e, ?_⟩
  rw [map_mul, hn]
  calc
    algebraMap R K d * x * algebraMap R K e =
        x * algebraMap R K (d * e) := by rw [map_mul]; ring
    _ = x := by rw [he, map_one, mul_one]

end Litt3.QuotientGeometry
