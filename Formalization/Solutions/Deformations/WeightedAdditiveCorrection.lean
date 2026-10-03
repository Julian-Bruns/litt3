import Solutions.Deformations.WeightedGeneratorFiltration

namespace Litt3.Deformations

variable {R A I : Type*} [CommRing R] [CommRing A] [Algebra R A] [Fintype I]

/-- Integer-prime multiplication commutes with every actual additive
operator, without coefficient-ring linearity. -/
theorem additive_integer_power_mul (L : A →+ A) (p j : ℕ) (x : A) :
    L ((p : A) ^ j * x) = (p : A) ^ j * L x := by
  simpa only [nsmul_eq_mul, Nat.cast_pow] using L.map_nsmul x (p ^ j)

theorem additive_generator_monomial_commute (L : A →+ A) (e : I → A)
    (commute : ∀ i x, L (e i * x) = e i * L x) (alpha : I → ℕ) (x : A) :
    L (generatorMonomial e alpha * x) = generatorMonomial e alpha * L x := by
  classical
  have powers (i : I) (n : ℕ) : ∀ x, L (e i ^ n * x) = e i ^ n * L x := by
    induction n with
    | zero => intro x; simp
    | succ n induction =>
      intro x
      rw [pow_succ, mul_assoc, induction, commute, mul_assoc]
  have finite (s : Finset I) :
      ∀ x, L ((∏ i ∈ s, e i ^ alpha i) * x) = (∏ i ∈ s, e i ^ alpha i) * L x := by
    induction s using Finset.induction_on with
    | empty => intro x; simp
    | @insert i s member induction =>
      intro x
      rw [Finset.prod_insert member, mul_assoc, powers, induction, ← mul_assoc]
  exact finite Finset.univ x

/-- A correction divisible by the scalar prime on all actual
coefficient constants raises the full original generated weight by
the prime's assigned weight. Only additivity and original generator
commutation are needed; coefficient operators need not commute. -/
theorem weighted_additive_correction_raises (L : A →+ A) (p primeWeight : ℕ) (e : I → A)
    (commute : ∀ i x, L (e i * x) = e i * L x)
    (constantDivisible : ∀ c : R, ∃ z : A, L (algebraMap R A c) = (p : A) * z)
    (initial : weightedGeneratorFiltration R (p : A) primeWeight e 0 = ⊤)
    (d : ℕ) (x : A) (member : x ∈ weightedGeneratorFiltration R (p : A) primeWeight e d) :
    L x ∈ weightedGeneratorFiltration R (p : A) primeWeight e (d + primeWeight) := by
  have effect : ∀ y ∈ weightedGeneratorFiltration R (p : A) primeWeight e d,
      ∀ c : R, L (c • y) ∈ weightedGeneratorFiltration R (p : A) primeWeight e (d + primeWeight) := by
    intro y hy
    induction hy using Submodule.span_induction with
    | mem y hy =>
      obtain ⟨j, alpha, weight, rfl⟩ := hy
      intro c
      obtain ⟨z, relation⟩ := constantDivisible c
      have translated : L (c • ((p : A) ^ j * generatorMonomial e alpha)) =
          (p : A) ^ j * generatorMonomial e alpha * L (algebraMap R A c) := by
        have reorder : c • ((p : A) ^ j * generatorMonomial e alpha) =
            (p : A) ^ j * (generatorMonomial e alpha * algebraMap R A c) := by
          rw [Algebra.smul_def]
          ring
        rw [reorder, additive_integer_power_mul,
          additive_generator_monomial_commute L e commute, mul_assoc]
      rw [translated, relation]
      have generator : (p : A) ^ (j + 1) * generatorMonomial e alpha ∈
          weightedGeneratorFiltration R (p : A) primeWeight e (d + primeWeight) := by
        apply weighted_generator_member
        rw [Nat.mul_add, Nat.mul_one]
        omega
      have zeroMember : z ∈ weightedGeneratorFiltration R (p : A) primeWeight e 0 := by
        rw [initial]
        exact Submodule.mem_top
      have product := weighted_generator_filtration_multiplicative
        (p : A) primeWeight e (d + primeWeight) 0
        ((p : A) ^ (j + 1) * generatorMonomial e alpha) z generator zeroMember
      simp only [Nat.add_zero] at product
      convert product using 1 <;> rw [pow_succ] <;> ring
    | zero => intro c; simp
    | add y z _ _ iy iz =>
      intro c
      rw [smul_add, map_add]
      exact Submodule.add_mem _ (iy c) (iz c)
    | smul a y _ induction =>
      intro c
      rw [smul_smul]
      exact induction (c * a)
  simpa only [one_smul] using effect x member (1 : R)

end Litt3.Deformations
