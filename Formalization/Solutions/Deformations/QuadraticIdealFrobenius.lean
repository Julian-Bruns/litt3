import Solutions.Deformations.QuadraticFrobeniusRedundancy

namespace Litt3.Deformations

variable {A : Type*} [CommRing A] [Invertible (2 : A)]
  (p : ℕ) [Fact p.Prime] [CharP A p]

/-- Completing the square and its entire Frobenius redundancy are
derived from the literal original quadratic coefficients and whole ideal
cutoff. The commutative coefficient ring may have arbitrary zero divisors. -/
theorem monic_quadratic_ideal_frobenius_redundant (J : Ideal A) (n m : ℕ)
    (exponent : p ^ n = 2 * m + 1) (cutoff : J ^ (2 * m) = ⊥)
    (f : Polynomial A) (monic : f.Monic) (degree : f.natDegree = 2)
    (linear : f.coeff 1 ∈ J) (constant : f.coeff 0 ∈ J ^ 2) :
    Ideal.span ({f, Polynomial.X ^ (p ^ n)} : Set (Polynomial A)) =
      Ideal.span ({f} : Set (Polynomial A)) := by
  let a := f.coeff 1
  let b := f.coeff 0
  let t := ⅟(2 : A) * a
  have half : a = 2 * t := by
    dsimp only [t]
    rw [← mul_assoc, mul_invOf_self, one_mul]
  have tMember : t ∈ J := J.mul_mem_left _ linear
  have squareMember : t ^ 2 ∈ J ^ 2 := Ideal.pow_mem_pow tMember 2
  have remainderMember : b - t ^ 2 ∈ J ^ 2 := (J ^ 2).sub_mem constant squareMember
  have remainder : (b - t ^ 2) ^ m = 0 := by
    have member := Ideal.pow_mem_pow remainderMember m
    rw [← pow_mul, cutoff, Ideal.mem_bot] at member
    exact member
  have translation : t ^ (p ^ n) = 0 := by
    have member := Ideal.pow_mem_pow tMember (p ^ n)
    have powers : J ^ (p ^ n) ≤ J ^ (2 * m) := Ideal.pow_le_pow_right (by omega)
    have zero := powers member
    simpa only [cutoff, Ideal.mem_bot] using zero
  rw [monic_degree_two_original_polynomial f monic degree]
  exact quadratic_linear_frobenius_relation_redundant p n m exponent a b t half translation remainder

end Litt3.Deformations
