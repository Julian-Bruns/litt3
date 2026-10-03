import Solutions.Deformations.SignedGeneratorFiltration
import Mathlib.Algebra.CharP.Lemmas

set_option maxHeartbeats 800000

namespace Litt3.Deformations

open scoped BigOperators

variable {R A I : Type*} [CommRing R] [CommRing A] [Algebra R A] [Fintype I]

theorem signed_generator_coordinate (p : A) (w : ℕ) (e : I → A) (i : I) :
    e i ∈ signedGeneratorFiltration R p w e 1 := by
  classical
  simpa [generatorMonomial, generatorMonomialWeight] using
    signed_generator_member (R := R) p w e 1 0 (fun j => if j = i then 1 else 0) (by
      simp [generatorMonomialWeight])

/-- The displayed Artin--Schreier relation supplies the needed degree
one pth-power bound for every literal original chart coordinate,
without any unit, torsion-free, or etaleness assumption. -/
theorem artin_schreier_coordinate_power (p : ℕ) (e : I → A) (a b : I → R)
    (relations : ∀ i, e i ^ p = a i • e i + b i • (1 : A)) (i : I) :
    e i ^ p ∈ signedGeneratorFiltration R (p : A) (p - 1) e 1 := by
  rw [relations i]
  apply Submodule.add_mem
  · exact Submodule.smul_mem _ (a i) (signed_generator_coordinate (p : A) (p - 1) e i)
  · apply Submodule.smul_mem
    exact signed_generator_filtration_monotone (p : A) (p - 1) e (by omega)
      (signed_generator_initial_one (R := R) (p : A) (p - 1) e)

theorem artin_schreier_monomial_power (p : ℕ) (e : I → A)
    (coordinatePower : ∀ i, e i ^ p ∈ signedGeneratorFiltration R (p : A) (p - 1) e 1)
    (alpha : I → ℕ) :
    generatorMonomial e alpha ^ p ∈ signedGeneratorFiltration R (p : A) (p - 1) e
      (generatorMonomialWeight alpha : ℤ) := by
  have product := signed_generator_finite_product (R := R) (p : A) (p - 1) e Finset.univ
    (fun i => (e i ^ p) ^ alpha i) (fun i => (alpha i : ℤ))
    (fun i _ => by
      simpa using (signed_generator_power (R := R) (p : A) (p - 1) e 1
        (e i ^ p) (coordinatePower i) (alpha i)))
  simpa [generatorMonomial, generatorMonomialWeight, ← Finset.prod_pow,
    ← pow_mul, Nat.mul_comm] using product

theorem artin_schreier_weighted_atom_power (p : ℕ) (prime : p.Prime) (e : I → A)
    (coordinatePower : ∀ i, e i ^ p ∈ signedGeneratorFiltration R (p : A) (p - 1) e 1)
    (j : ℕ) (alpha : I → ℕ)
    (bound : (generatorMonomialWeight alpha : ℤ) ≤ 1 + ((p - 1 : ℕ) : ℤ) * j) :
    ((p : A) ^ j * generatorMonomial e alpha) ^ p ∈
      signedGeneratorFiltration R (p : A) (p - 1) e 1 := by
  have term := signed_generator_prime_power_mul (p : A) (p - 1) e
    (generatorMonomialWeight alpha : ℤ) (j * p) (generatorMonomial e alpha ^ p)
    (artin_schreier_monomial_power p e coordinatePower alpha)
  have multiplied : (j : ℤ) ≤ ((j * p : ℕ) : ℤ) := by
    exact_mod_cast Nat.le_mul_of_pos_right j prime.pos
  have scale := mul_le_mul_of_nonneg_left multiplied (Nat.cast_nonneg (p - 1) : (0 : ℤ) ≤ _)
  have weight : (generatorMonomialWeight alpha : ℤ) - ((p - 1 : ℕ) : ℤ) * (j * p : ℕ) ≤ 1 := by
    omega
  apply signed_generator_filtration_monotone (p : A) (p - 1) e weight
  simpa only [mul_pow, ← pow_mul] using term

/-- Prime binomial divisibility bounds every cross term, with the
actual p factor lowering its integral degree by p-1. -/
theorem artin_schreier_power_add (p : ℕ) (prime : p.Prime) (e : I → A)
    (x y : A)
    (hx : x ∈ signedGeneratorFiltration R (p : A) (p - 1) e 1)
    (hy : y ∈ signedGeneratorFiltration R (p : A) (p - 1) e 1)
    (hxp : x ^ p ∈ signedGeneratorFiltration R (p : A) (p - 1) e 1)
    (hyp : y ^ p ∈ signedGeneratorFiltration R (p : A) (p - 1) e 1) :
    (x + y) ^ p ∈ signedGeneratorFiltration R (p : A) (p - 1) e 1 := by
  rw [(Commute.all x y).add_pow_prime_eq' prime, Finset.mul_sum]
  apply Submodule.add_mem _ (Submodule.add_mem _ hxp hyp)
  apply Submodule.sum_mem
  intro j member
  have indices := Finset.mem_Ioo.mp member
  have left := signed_generator_power (p : A) (p - 1) e 1 x hx j
  have right := signed_generator_power (p : A) (p - 1) e 1 y hy (p - j)
  have product := signed_generator_filtration_multiplicative (p : A) (p - 1) e
    (j : ℤ) ((p - j : ℕ) : ℤ) (x ^ j) (y ^ (p - j)) (by simpa using left) (by simpa using right)
  have sumIndex : (j : ℤ) + ((p - j : ℕ) : ℤ) = (p : ℤ) := by
    rw [Nat.cast_sub (Nat.le_of_lt indices.2)]
    ring
  have productAtP : x ^ j * y ^ (p - j) ∈
      signedGeneratorFiltration R (p : A) (p - 1) e (p : ℤ) := by
    simpa only [sumIndex] using product
  have lowered := signed_generator_prime_power_mul (p : A) (p - 1) e (p : ℤ) 1
    (x ^ j * y ^ (p - j)) productAtP
  have index : (p : ℤ) - ((p - 1 : ℕ) : ℤ) * (1 : ℕ) = 1 := by
    have := prime.pos
    omega
  rw [index, pow_one] at lowered
  have scaled := (signedGeneratorFiltration R (p : A) (p - 1) e 1).smul_mem
    (p.choose j / p : R) lowered
  simpa [Algebra.smul_def, mul_assoc, mul_comm, mul_left_comm] using scaled

/-- The entire generated degree-one integral carry module is closed
under pth powers. The proof is symbolic and works with arbitrary
coefficient torsion. -/
theorem artin_schreier_degree_one_power (p : ℕ) (prime : p.Prime) (e : I → A)
    (coordinatePower : ∀ i, e i ^ p ∈ signedGeneratorFiltration R (p : A) (p - 1) e 1)
    (x : A) (member : x ∈ signedGeneratorFiltration R (p : A) (p - 1) e 1) :
    x ^ p ∈ signedGeneratorFiltration R (p : A) (p - 1) e 1 := by
  induction member using Submodule.span_induction with
  | mem x hx =>
    obtain ⟨j, alpha, bound, rfl⟩ := hx
    exact artin_schreier_weighted_atom_power p prime e coordinatePower j alpha bound
  | zero => simpa [zero_pow prime.ne_zero] using
      (signedGeneratorFiltration R (p : A) (p - 1) e 1).zero_mem
  | add x y hx hy ix iy => exact artin_schreier_power_add p prime e x y hx hy ix iy
  | smul c x hx induction =>
    simpa [Algebra.smul_def, mul_pow] using
      (signedGeneratorFiltration R (p : A) (p - 1) e 1).smul_mem (c ^ p) induction

end Litt3.Deformations
